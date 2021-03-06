/*
 * ==========================(LICENSE BEGIN)============================
 *
 * GroestlCoin kernel implementation: Copyright (c) 2014 pallas
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * ===========================(LICENSE END)=============================*/

#ifndef PALLAS_GROESTL_CL
#define PALLAS_GROESTL_CL

#define DC64(x)     ((ulong)(x ## UL))
#define H15         (((ulong)(512 & 0xFF) << 56) | ((ulong)(512 & 0xFF00) << 40))
#define M15         0x100000000000000
#define ROTL64(x, n) (((x) << (n)) | ((x) >> (64 - (n))))		// rotate

#define C64e(x)     ((DC64(x) >> 56) \
                    | ((DC64(x) >> 40) & DC64(0x000000000000FF00)) \
                    | ((DC64(x) >> 24) & DC64(0x0000000000FF0000)) \
                    | ((DC64(x) >>  8) & DC64(0x00000000FF000000)) \
                    | ((DC64(x) <<  8) & DC64(0x000000FF00000000)) \
                    | ((DC64(x) << 24) & DC64(0x0000FF0000000000)) \
                    | ((DC64(x) << 40) & DC64(0x00FF000000000000)) \
                    | ((DC64(x) << 56)))

#ifdef NO_AMD_OPS
	#define B64_0(x)    ((x) & 0xFF)
	#define B64_1(x)    (((x) >> 8) & 0xFF)
	#define B64_2(x)    (((x) >> 16) & 0xFF)
	#define B64_3(x)    (((x) >> 24) & 0xFF)
	#define B64_4(x)    (((x) >> 32) & 0xFF)
	#define B64_5(x)    (((x) >> 40) & 0xFF)
	#define B64_6(x)    (((x) >> 48) & 0xFF)
	#define B64_7(x)    ((x) >> 56)
#else
	#pragma OPENCL EXTENSION cl_amd_media_ops2 : enable
	#define B64_0(x)    ((uchar)(x))
	#define B64_1(x)    (amd_bfe((uint)(x), 8U, 8U))
	#define B64_2(x)    (amd_bfe((uint)(x), 16U, 8U))
	#define B64_3(x)    (amd_bfe((uint)(x), 24U, 8U))
	#define B64_4(x)    ((uchar)((x) >> 32U))
	#define B64_5(x)    (amd_bfe((uint)((x) >> 32U),  8U, 8U))
	#define B64_6(x)    (amd_bfe((uint)((x) >> 32U), 16U, 8U))
	#define B64_7(x)    (amd_bfe((uint)((x) >> 32U), 24U, 8U))
#endif
#define PC64(j, r)  ((ulong)((j) + (r)))
#define QC64(j, r)  (((ulong)(r) << 56) ^ ~((ulong)(j) << 56))

__constant static const ulong T0[] = {
	C64e(0xc632f4a5f497a5c6), C64e(0xf86f978497eb84f8),
	C64e(0xee5eb099b0c799ee), C64e(0xf67a8c8d8cf78df6),
	C64e(0xffe8170d17e50dff), C64e(0xd60adcbddcb7bdd6),
	C64e(0xde16c8b1c8a7b1de), C64e(0x916dfc54fc395491),
	C64e(0x6090f050f0c05060), C64e(0x0207050305040302),
	C64e(0xce2ee0a9e087a9ce), C64e(0x56d1877d87ac7d56),
	C64e(0xe7cc2b192bd519e7), C64e(0xb513a662a67162b5),
	C64e(0x4d7c31e6319ae64d), C64e(0xec59b59ab5c39aec),
	C64e(0x8f40cf45cf05458f), C64e(0x1fa3bc9dbc3e9d1f),
	C64e(0x8949c040c0094089), C64e(0xfa68928792ef87fa),
	C64e(0xefd03f153fc515ef), C64e(0xb29426eb267febb2),
	C64e(0x8ece40c94007c98e), C64e(0xfbe61d0b1ded0bfb),
	C64e(0x416e2fec2f82ec41), C64e(0xb31aa967a97d67b3),
	C64e(0x5f431cfd1cbefd5f), C64e(0x456025ea258aea45),
	C64e(0x23f9dabfda46bf23), C64e(0x535102f702a6f753),
	C64e(0xe445a196a1d396e4), C64e(0x9b76ed5bed2d5b9b),
	C64e(0x75285dc25deac275), C64e(0xe1c5241c24d91ce1),
	C64e(0x3dd4e9aee97aae3d), C64e(0x4cf2be6abe986a4c),
	C64e(0x6c82ee5aeed85a6c), C64e(0x7ebdc341c3fc417e),
	C64e(0xf5f3060206f102f5), C64e(0x8352d14fd11d4f83),
	C64e(0x688ce45ce4d05c68), C64e(0x515607f407a2f451),
	C64e(0xd18d5c345cb934d1), C64e(0xf9e1180818e908f9),
	C64e(0xe24cae93aedf93e2), C64e(0xab3e9573954d73ab),
	C64e(0x6297f553f5c45362), C64e(0x2a6b413f41543f2a),
	C64e(0x081c140c14100c08), C64e(0x9563f652f6315295),
	C64e(0x46e9af65af8c6546), C64e(0x9d7fe25ee2215e9d),
	C64e(0x3048782878602830), C64e(0x37cff8a1f86ea137),
	C64e(0x0a1b110f11140f0a), C64e(0x2febc4b5c45eb52f),
	C64e(0x0e151b091b1c090e), C64e(0x247e5a365a483624),
	C64e(0x1badb69bb6369b1b), C64e(0xdf98473d47a53ddf),
	C64e(0xcda76a266a8126cd), C64e(0x4ef5bb69bb9c694e),
	C64e(0x7f334ccd4cfecd7f), C64e(0xea50ba9fbacf9fea),
	C64e(0x123f2d1b2d241b12), C64e(0x1da4b99eb93a9e1d),
	C64e(0x58c49c749cb07458), C64e(0x3446722e72682e34),
	C64e(0x3641772d776c2d36), C64e(0xdc11cdb2cda3b2dc),
	C64e(0xb49d29ee2973eeb4), C64e(0x5b4d16fb16b6fb5b),
	C64e(0xa4a501f60153f6a4), C64e(0x76a1d74dd7ec4d76),
	C64e(0xb714a361a37561b7), C64e(0x7d3449ce49face7d),
	C64e(0x52df8d7b8da47b52), C64e(0xdd9f423e42a13edd),
	C64e(0x5ecd937193bc715e), C64e(0x13b1a297a2269713),
	C64e(0xa6a204f50457f5a6), C64e(0xb901b868b86968b9),
	C64e(0x0000000000000000), C64e(0xc1b5742c74992cc1),
	C64e(0x40e0a060a0806040), C64e(0xe3c2211f21dd1fe3),
	C64e(0x793a43c843f2c879), C64e(0xb69a2ced2c77edb6),
	C64e(0xd40dd9bed9b3bed4), C64e(0x8d47ca46ca01468d),
	C64e(0x671770d970ced967), C64e(0x72afdd4bdde44b72),
	C64e(0x94ed79de7933de94), C64e(0x98ff67d4672bd498),
	C64e(0xb09323e8237be8b0), C64e(0x855bde4ade114a85),
	C64e(0xbb06bd6bbd6d6bbb), C64e(0xc5bb7e2a7e912ac5),
	C64e(0x4f7b34e5349ee54f), C64e(0xedd73a163ac116ed),
	C64e(0x86d254c55417c586), C64e(0x9af862d7622fd79a),
	C64e(0x6699ff55ffcc5566), C64e(0x11b6a794a7229411),
	C64e(0x8ac04acf4a0fcf8a), C64e(0xe9d9301030c910e9),
	C64e(0x040e0a060a080604), C64e(0xfe66988198e781fe),
	C64e(0xa0ab0bf00b5bf0a0), C64e(0x78b4cc44ccf04478),
	C64e(0x25f0d5bad54aba25), C64e(0x4b753ee33e96e34b),
	C64e(0xa2ac0ef30e5ff3a2), C64e(0x5d4419fe19bafe5d),
	C64e(0x80db5bc05b1bc080), C64e(0x0580858a850a8a05),
	C64e(0x3fd3ecadec7ead3f), C64e(0x21fedfbcdf42bc21),
	C64e(0x70a8d848d8e04870), C64e(0xf1fd0c040cf904f1),
	C64e(0x63197adf7ac6df63), C64e(0x772f58c158eec177),
	C64e(0xaf309f759f4575af), C64e(0x42e7a563a5846342),
	C64e(0x2070503050403020), C64e(0xe5cb2e1a2ed11ae5),
	C64e(0xfdef120e12e10efd), C64e(0xbf08b76db7656dbf),
	C64e(0x8155d44cd4194c81), C64e(0x18243c143c301418),
	C64e(0x26795f355f4c3526), C64e(0xc3b2712f719d2fc3),
	C64e(0xbe8638e13867e1be), C64e(0x35c8fda2fd6aa235),
	C64e(0x88c74fcc4f0bcc88), C64e(0x2e654b394b5c392e),
	C64e(0x936af957f93d5793), C64e(0x55580df20daaf255),
	C64e(0xfc619d829de382fc), C64e(0x7ab3c947c9f4477a),
	C64e(0xc827efacef8bacc8), C64e(0xba8832e7326fe7ba),
	C64e(0x324f7d2b7d642b32), C64e(0xe642a495a4d795e6),
	C64e(0xc03bfba0fb9ba0c0), C64e(0x19aab398b3329819),
	C64e(0x9ef668d16827d19e), C64e(0xa322817f815d7fa3),
	C64e(0x44eeaa66aa886644), C64e(0x54d6827e82a87e54),
	C64e(0x3bdde6abe676ab3b), C64e(0x0b959e839e16830b),
	C64e(0x8cc945ca4503ca8c), C64e(0xc7bc7b297b9529c7),
	C64e(0x6b056ed36ed6d36b), C64e(0x286c443c44503c28),
	C64e(0xa72c8b798b5579a7), C64e(0xbc813de23d63e2bc),
	C64e(0x1631271d272c1d16), C64e(0xad379a769a4176ad),
	C64e(0xdb964d3b4dad3bdb), C64e(0x649efa56fac85664),
	C64e(0x74a6d24ed2e84e74), C64e(0x1436221e22281e14),
	C64e(0x92e476db763fdb92), C64e(0x0c121e0a1e180a0c),
	C64e(0x48fcb46cb4906c48), C64e(0xb88f37e4376be4b8),
	C64e(0x9f78e75de7255d9f), C64e(0xbd0fb26eb2616ebd),
	C64e(0x43692aef2a86ef43), C64e(0xc435f1a6f193a6c4),
	C64e(0x39dae3a8e372a839), C64e(0x31c6f7a4f762a431),
	C64e(0xd38a593759bd37d3), C64e(0xf274868b86ff8bf2),
	C64e(0xd583563256b132d5), C64e(0x8b4ec543c50d438b),
	C64e(0x6e85eb59ebdc596e), C64e(0xda18c2b7c2afb7da),
	C64e(0x018e8f8c8f028c01), C64e(0xb11dac64ac7964b1),
	C64e(0x9cf16dd26d23d29c), C64e(0x49723be03b92e049),
	C64e(0xd81fc7b4c7abb4d8), C64e(0xacb915fa1543faac),
	C64e(0xf3fa090709fd07f3), C64e(0xcfa06f256f8525cf),
	C64e(0xca20eaafea8fafca), C64e(0xf47d898e89f38ef4),
	C64e(0x476720e9208ee947), C64e(0x1038281828201810),
	C64e(0x6f0b64d564ded56f), C64e(0xf073838883fb88f0),
	C64e(0x4afbb16fb1946f4a), C64e(0x5cca967296b8725c),
	C64e(0x38546c246c702438), C64e(0x575f08f108aef157),
	C64e(0x732152c752e6c773), C64e(0x9764f351f3355197),
	C64e(0xcbae6523658d23cb), C64e(0xa125847c84597ca1),
	C64e(0xe857bf9cbfcb9ce8), C64e(0x3e5d6321637c213e),
	C64e(0x96ea7cdd7c37dd96), C64e(0x611e7fdc7fc2dc61),
	C64e(0x0d9c9186911a860d), C64e(0x0f9b9485941e850f),
	C64e(0xe04bab90abdb90e0), C64e(0x7cbac642c6f8427c),
	C64e(0x712657c457e2c471), C64e(0xcc29e5aae583aacc),
	C64e(0x90e373d8733bd890), C64e(0x06090f050f0c0506),
	C64e(0xf7f4030103f501f7), C64e(0x1c2a36123638121c),
	C64e(0xc23cfea3fe9fa3c2), C64e(0x6a8be15fe1d45f6a),
	C64e(0xaebe10f91047f9ae), C64e(0x69026bd06bd2d069),
	C64e(0x17bfa891a82e9117), C64e(0x9971e858e8295899),
	C64e(0x3a5369276974273a), C64e(0x27f7d0b9d04eb927),
	C64e(0xd991483848a938d9), C64e(0xebde351335cd13eb),
	C64e(0x2be5ceb3ce56b32b), C64e(0x2277553355443322),
	C64e(0xd204d6bbd6bfbbd2), C64e(0xa9399070904970a9),
	C64e(0x07878089800e8907), C64e(0x33c1f2a7f266a733),
	C64e(0x2decc1b6c15ab62d), C64e(0x3c5a66226678223c),
	C64e(0x15b8ad92ad2a9215), C64e(0xc9a96020608920c9),
	C64e(0x875cdb49db154987), C64e(0xaab01aff1a4fffaa),
	C64e(0x50d8887888a07850), C64e(0xa52b8e7a8e517aa5),
	C64e(0x03898a8f8a068f03), C64e(0x594a13f813b2f859),
	C64e(0x09929b809b128009), C64e(0x1a2339173934171a),
	C64e(0x651075da75cada65), C64e(0xd784533153b531d7),
	C64e(0x84d551c65113c684), C64e(0xd003d3b8d3bbb8d0),
	C64e(0x82dc5ec35e1fc382), C64e(0x29e2cbb0cb52b029),
	C64e(0x5ac3997799b4775a), C64e(0x1e2d3311333c111e),
	C64e(0x7b3d46cb46f6cb7b), C64e(0xa8b71ffc1f4bfca8),
	C64e(0x6d0c61d661dad66d), C64e(0x2c624e3a4e583a2c)
};

__constant static const ulong T1[] = {
	C64e(0xc6c632f4a5f497a5), C64e(0xf8f86f978497eb84),
	C64e(0xeeee5eb099b0c799), C64e(0xf6f67a8c8d8cf78d),
	C64e(0xffffe8170d17e50d), C64e(0xd6d60adcbddcb7bd),
	C64e(0xdede16c8b1c8a7b1), C64e(0x91916dfc54fc3954),
	C64e(0x606090f050f0c050), C64e(0x0202070503050403),
	C64e(0xcece2ee0a9e087a9), C64e(0x5656d1877d87ac7d),
	C64e(0xe7e7cc2b192bd519), C64e(0xb5b513a662a67162),
	C64e(0x4d4d7c31e6319ae6), C64e(0xecec59b59ab5c39a),
	C64e(0x8f8f40cf45cf0545), C64e(0x1f1fa3bc9dbc3e9d),
	C64e(0x898949c040c00940), C64e(0xfafa68928792ef87),
	C64e(0xefefd03f153fc515), C64e(0xb2b29426eb267feb),
	C64e(0x8e8ece40c94007c9), C64e(0xfbfbe61d0b1ded0b),
	C64e(0x41416e2fec2f82ec), C64e(0xb3b31aa967a97d67),
	C64e(0x5f5f431cfd1cbefd), C64e(0x45456025ea258aea),
	C64e(0x2323f9dabfda46bf), C64e(0x53535102f702a6f7),
	C64e(0xe4e445a196a1d396), C64e(0x9b9b76ed5bed2d5b),
	C64e(0x7575285dc25deac2), C64e(0xe1e1c5241c24d91c),
	C64e(0x3d3dd4e9aee97aae), C64e(0x4c4cf2be6abe986a),
	C64e(0x6c6c82ee5aeed85a), C64e(0x7e7ebdc341c3fc41),
	C64e(0xf5f5f3060206f102), C64e(0x838352d14fd11d4f),
	C64e(0x68688ce45ce4d05c), C64e(0x51515607f407a2f4),
	C64e(0xd1d18d5c345cb934), C64e(0xf9f9e1180818e908),
	C64e(0xe2e24cae93aedf93), C64e(0xabab3e9573954d73),
	C64e(0x626297f553f5c453), C64e(0x2a2a6b413f41543f),
	C64e(0x08081c140c14100c), C64e(0x959563f652f63152),
	C64e(0x4646e9af65af8c65), C64e(0x9d9d7fe25ee2215e),
	C64e(0x3030487828786028), C64e(0x3737cff8a1f86ea1),
	C64e(0x0a0a1b110f11140f), C64e(0x2f2febc4b5c45eb5),
	C64e(0x0e0e151b091b1c09), C64e(0x24247e5a365a4836),
	C64e(0x1b1badb69bb6369b), C64e(0xdfdf98473d47a53d),
	C64e(0xcdcda76a266a8126), C64e(0x4e4ef5bb69bb9c69),
	C64e(0x7f7f334ccd4cfecd), C64e(0xeaea50ba9fbacf9f),
	C64e(0x12123f2d1b2d241b), C64e(0x1d1da4b99eb93a9e),
	C64e(0x5858c49c749cb074), C64e(0x343446722e72682e),
	C64e(0x363641772d776c2d), C64e(0xdcdc11cdb2cda3b2),
	C64e(0xb4b49d29ee2973ee), C64e(0x5b5b4d16fb16b6fb),
	C64e(0xa4a4a501f60153f6), C64e(0x7676a1d74dd7ec4d),
	C64e(0xb7b714a361a37561), C64e(0x7d7d3449ce49face),
	C64e(0x5252df8d7b8da47b), C64e(0xdddd9f423e42a13e),
	C64e(0x5e5ecd937193bc71), C64e(0x1313b1a297a22697),
	C64e(0xa6a6a204f50457f5), C64e(0xb9b901b868b86968),
	C64e(0x0000000000000000), C64e(0xc1c1b5742c74992c),
	C64e(0x4040e0a060a08060), C64e(0xe3e3c2211f21dd1f),
	C64e(0x79793a43c843f2c8), C64e(0xb6b69a2ced2c77ed),
	C64e(0xd4d40dd9bed9b3be), C64e(0x8d8d47ca46ca0146),
	C64e(0x67671770d970ced9), C64e(0x7272afdd4bdde44b),
	C64e(0x9494ed79de7933de), C64e(0x9898ff67d4672bd4),
	C64e(0xb0b09323e8237be8), C64e(0x85855bde4ade114a),
	C64e(0xbbbb06bd6bbd6d6b), C64e(0xc5c5bb7e2a7e912a),
	C64e(0x4f4f7b34e5349ee5), C64e(0xededd73a163ac116),
	C64e(0x8686d254c55417c5), C64e(0x9a9af862d7622fd7),
	C64e(0x666699ff55ffcc55), C64e(0x1111b6a794a72294),
	C64e(0x8a8ac04acf4a0fcf), C64e(0xe9e9d9301030c910),
	C64e(0x04040e0a060a0806), C64e(0xfefe66988198e781),
	C64e(0xa0a0ab0bf00b5bf0), C64e(0x7878b4cc44ccf044),
	C64e(0x2525f0d5bad54aba), C64e(0x4b4b753ee33e96e3),
	C64e(0xa2a2ac0ef30e5ff3), C64e(0x5d5d4419fe19bafe),
	C64e(0x8080db5bc05b1bc0), C64e(0x050580858a850a8a),
	C64e(0x3f3fd3ecadec7ead), C64e(0x2121fedfbcdf42bc),
	C64e(0x7070a8d848d8e048), C64e(0xf1f1fd0c040cf904),
	C64e(0x6363197adf7ac6df), C64e(0x77772f58c158eec1),
	C64e(0xafaf309f759f4575), C64e(0x4242e7a563a58463),
	C64e(0x2020705030504030), C64e(0xe5e5cb2e1a2ed11a),
	C64e(0xfdfdef120e12e10e), C64e(0xbfbf08b76db7656d),
	C64e(0x818155d44cd4194c), C64e(0x1818243c143c3014),
	C64e(0x2626795f355f4c35), C64e(0xc3c3b2712f719d2f),
	C64e(0xbebe8638e13867e1), C64e(0x3535c8fda2fd6aa2),
	C64e(0x8888c74fcc4f0bcc), C64e(0x2e2e654b394b5c39),
	C64e(0x93936af957f93d57), C64e(0x5555580df20daaf2),
	C64e(0xfcfc619d829de382), C64e(0x7a7ab3c947c9f447),
	C64e(0xc8c827efacef8bac), C64e(0xbaba8832e7326fe7),
	C64e(0x32324f7d2b7d642b), C64e(0xe6e642a495a4d795),
	C64e(0xc0c03bfba0fb9ba0), C64e(0x1919aab398b33298),
	C64e(0x9e9ef668d16827d1), C64e(0xa3a322817f815d7f),
	C64e(0x4444eeaa66aa8866), C64e(0x5454d6827e82a87e),
	C64e(0x3b3bdde6abe676ab), C64e(0x0b0b959e839e1683),
	C64e(0x8c8cc945ca4503ca), C64e(0xc7c7bc7b297b9529),
	C64e(0x6b6b056ed36ed6d3), C64e(0x28286c443c44503c),
	C64e(0xa7a72c8b798b5579), C64e(0xbcbc813de23d63e2),
	C64e(0x161631271d272c1d), C64e(0xadad379a769a4176),
	C64e(0xdbdb964d3b4dad3b), C64e(0x64649efa56fac856),
	C64e(0x7474a6d24ed2e84e), C64e(0x141436221e22281e),
	C64e(0x9292e476db763fdb), C64e(0x0c0c121e0a1e180a),
	C64e(0x4848fcb46cb4906c), C64e(0xb8b88f37e4376be4),
	C64e(0x9f9f78e75de7255d), C64e(0xbdbd0fb26eb2616e),
	C64e(0x4343692aef2a86ef), C64e(0xc4c435f1a6f193a6),
	C64e(0x3939dae3a8e372a8), C64e(0x3131c6f7a4f762a4),
	C64e(0xd3d38a593759bd37), C64e(0xf2f274868b86ff8b),
	C64e(0xd5d583563256b132), C64e(0x8b8b4ec543c50d43),
	C64e(0x6e6e85eb59ebdc59), C64e(0xdada18c2b7c2afb7),
	C64e(0x01018e8f8c8f028c), C64e(0xb1b11dac64ac7964),
	C64e(0x9c9cf16dd26d23d2), C64e(0x4949723be03b92e0),
	C64e(0xd8d81fc7b4c7abb4), C64e(0xacacb915fa1543fa),
	C64e(0xf3f3fa090709fd07), C64e(0xcfcfa06f256f8525),
	C64e(0xcaca20eaafea8faf), C64e(0xf4f47d898e89f38e),
	C64e(0x47476720e9208ee9), C64e(0x1010382818282018),
	C64e(0x6f6f0b64d564ded5), C64e(0xf0f073838883fb88),
	C64e(0x4a4afbb16fb1946f), C64e(0x5c5cca967296b872),
	C64e(0x3838546c246c7024), C64e(0x57575f08f108aef1),
	C64e(0x73732152c752e6c7), C64e(0x979764f351f33551),
	C64e(0xcbcbae6523658d23), C64e(0xa1a125847c84597c),
	C64e(0xe8e857bf9cbfcb9c), C64e(0x3e3e5d6321637c21),
	C64e(0x9696ea7cdd7c37dd), C64e(0x61611e7fdc7fc2dc),
	C64e(0x0d0d9c9186911a86), C64e(0x0f0f9b9485941e85),
	C64e(0xe0e04bab90abdb90), C64e(0x7c7cbac642c6f842),
	C64e(0x71712657c457e2c4), C64e(0xcccc29e5aae583aa),
	C64e(0x9090e373d8733bd8), C64e(0x0606090f050f0c05),
	C64e(0xf7f7f4030103f501), C64e(0x1c1c2a3612363812),
	C64e(0xc2c23cfea3fe9fa3), C64e(0x6a6a8be15fe1d45f),
	C64e(0xaeaebe10f91047f9), C64e(0x6969026bd06bd2d0),
	C64e(0x1717bfa891a82e91), C64e(0x999971e858e82958),
	C64e(0x3a3a536927697427), C64e(0x2727f7d0b9d04eb9),
	C64e(0xd9d991483848a938), C64e(0xebebde351335cd13),
	C64e(0x2b2be5ceb3ce56b3), C64e(0x2222775533554433),
	C64e(0xd2d204d6bbd6bfbb), C64e(0xa9a9399070904970),
	C64e(0x0707878089800e89), C64e(0x3333c1f2a7f266a7),
	C64e(0x2d2decc1b6c15ab6), C64e(0x3c3c5a6622667822),
	C64e(0x1515b8ad92ad2a92), C64e(0xc9c9a96020608920),
	C64e(0x87875cdb49db1549), C64e(0xaaaab01aff1a4fff),
	C64e(0x5050d8887888a078), C64e(0xa5a52b8e7a8e517a),
	C64e(0x0303898a8f8a068f), C64e(0x59594a13f813b2f8),
	C64e(0x0909929b809b1280), C64e(0x1a1a233917393417),
	C64e(0x65651075da75cada), C64e(0xd7d784533153b531),
	C64e(0x8484d551c65113c6), C64e(0xd0d003d3b8d3bbb8),
	C64e(0x8282dc5ec35e1fc3), C64e(0x2929e2cbb0cb52b0),
	C64e(0x5a5ac3997799b477), C64e(0x1e1e2d3311333c11),
	C64e(0x7b7b3d46cb46f6cb), C64e(0xa8a8b71ffc1f4bfc),
	C64e(0x6d6d0c61d661dad6), C64e(0x2c2c624e3a4e583a)
};

#define RBTT(d, b0, b1, b2, b3, b4, b5, b6, b7)   do { \
		d = T0[t0[b0]] \
			^ T1[t1[b1]] \
			^ T2[t2[b2]] \
			^ T3[t3[b3]] \
			^ T4[t4[b4]] \
			^ T5[t5[b5]] \
			^ T6[t6[b6]] \
			^ T7[t7[b7]]; \
	} while (0)

#define ROUND_BIG_P(a, r)   do { \
		t0[0x0] = B64_0(a[0x0]) ^ PC64(0x00, r); \
		t1[0x0] = B64_1(a[0x0]); \
		t2[0x0] = B64_2(a[0x0]); \
		t3[0x0] = B64_3(a[0x0]); \
		t4[0x0] = B64_4(a[0x0]); \
		t5[0x0] = B64_5(a[0x0]); \
		t6[0x0] = B64_6(a[0x0]); \
		t7[0x0] = B64_7(a[0x0]); \
		t0[0x1] = B64_0(a[0x1]) ^ PC64(0x10, r); \
		t1[0x1] = B64_1(a[0x1]); \
		t2[0x1] = B64_2(a[0x1]); \
		t3[0x1] = B64_3(a[0x1]); \
		t4[0x1] = B64_4(a[0x1]); \
		t5[0x1] = B64_5(a[0x1]); \
		t6[0x1] = B64_6(a[0x1]); \
		t7[0x1] = B64_7(a[0x1]); \
		t0[0x2] = B64_0(a[0x2]) ^ PC64(0x20, r); \
		t1[0x2] = B64_1(a[0x2]); \
		t2[0x2] = B64_2(a[0x2]); \
		t3[0x2] = B64_3(a[0x2]); \
		t4[0x2] = B64_4(a[0x2]); \
		t5[0x2] = B64_5(a[0x2]); \
		t6[0x2] = B64_6(a[0x2]); \
		t7[0x2] = B64_7(a[0x2]); \
		t0[0x3] = B64_0(a[0x3]) ^ PC64(0x30, r); \
		t1[0x3] = B64_1(a[0x3]); \
		t2[0x3] = B64_2(a[0x3]); \
		t3[0x3] = B64_3(a[0x3]); \
		t4[0x3] = B64_4(a[0x3]); \
		t5[0x3] = B64_5(a[0x3]); \
		t6[0x3] = B64_6(a[0x3]); \
		t7[0x3] = B64_7(a[0x3]); \
		t0[0x4] = B64_0(a[0x4]) ^ PC64(0x40, r); \
		t1[0x4] = B64_1(a[0x4]); \
		t2[0x4] = B64_2(a[0x4]); \
		t3[0x4] = B64_3(a[0x4]); \
		t4[0x4] = B64_4(a[0x4]); \
		t5[0x4] = B64_5(a[0x4]); \
		t6[0x4] = B64_6(a[0x4]); \
		t7[0x4] = B64_7(a[0x4]); \
		t0[0x5] = B64_0(a[0x5]) ^ PC64(0x50, r); \
		t1[0x5] = B64_1(a[0x5]); \
		t2[0x5] = B64_2(a[0x5]); \
		t3[0x5] = B64_3(a[0x5]); \
		t4[0x5] = B64_4(a[0x5]); \
		t5[0x5] = B64_5(a[0x5]); \
		t6[0x5] = B64_6(a[0x5]); \
		t7[0x5] = B64_7(a[0x5]); \
		t0[0x6] = B64_0(a[0x6]) ^ PC64(0x60, r); \
		t1[0x6] = B64_1(a[0x6]); \
		t2[0x6] = B64_2(a[0x6]); \
		t3[0x6] = B64_3(a[0x6]); \
		t4[0x6] = B64_4(a[0x6]); \
		t5[0x6] = B64_5(a[0x6]); \
		t6[0x6] = B64_6(a[0x6]); \
		t7[0x6] = B64_7(a[0x6]); \
		t0[0x7] = B64_0(a[0x7]) ^ PC64(0x70, r); \
		t1[0x7] = B64_1(a[0x7]); \
		t2[0x7] = B64_2(a[0x7]); \
		t3[0x7] = B64_3(a[0x7]); \
		t4[0x7] = B64_4(a[0x7]); \
		t5[0x7] = B64_5(a[0x7]); \
		t6[0x7] = B64_6(a[0x7]); \
		t7[0x7] = B64_7(a[0x7]); \
		t0[0x8] = B64_0(a[0x8]) ^ PC64(0x80, r); \
		t1[0x8] = B64_1(a[0x8]); \
		t2[0x8] = B64_2(a[0x8]); \
		t3[0x8] = B64_3(a[0x8]); \
		t4[0x8] = B64_4(a[0x8]); \
		t5[0x8] = B64_5(a[0x8]); \
		t6[0x8] = B64_6(a[0x8]); \
		t7[0x8] = B64_7(a[0x8]); \
		t0[0x9] = B64_0(a[0x9]) ^ PC64(0x90, r); \
		t1[0x9] = B64_1(a[0x9]); \
		t2[0x9] = B64_2(a[0x9]); \
		t3[0x9] = B64_3(a[0x9]); \
		t4[0x9] = B64_4(a[0x9]); \
		t5[0x9] = B64_5(a[0x9]); \
		t6[0x9] = B64_6(a[0x9]); \
		t7[0x9] = B64_7(a[0x9]); \
		t0[0xA] = B64_0(a[0xA]) ^ PC64(0xA0, r); \
		t1[0xA] = B64_1(a[0xA]); \
		t2[0xA] = B64_2(a[0xA]); \
		t3[0xA] = B64_3(a[0xA]); \
		t4[0xA] = B64_4(a[0xA]); \
		t5[0xA] = B64_5(a[0xA]); \
		t6[0xA] = B64_6(a[0xA]); \
		t7[0xA] = B64_7(a[0xA]); \
		t0[0xB] = B64_0(a[0xB]) ^ PC64(0xB0, r); \
		t1[0xB] = B64_1(a[0xB]); \
		t2[0xB] = B64_2(a[0xB]); \
		t3[0xB] = B64_3(a[0xB]); \
		t4[0xB] = B64_4(a[0xB]); \
		t5[0xB] = B64_5(a[0xB]); \
		t6[0xB] = B64_6(a[0xB]); \
		t7[0xB] = B64_7(a[0xB]); \
		t0[0xC] = B64_0(a[0xC]) ^ PC64(0xC0, r); \
		t1[0xC] = B64_1(a[0xC]); \
		t2[0xC] = B64_2(a[0xC]); \
		t3[0xC] = B64_3(a[0xC]); \
		t4[0xC] = B64_4(a[0xC]); \
		t5[0xC] = B64_5(a[0xC]); \
		t6[0xC] = B64_6(a[0xC]); \
		t7[0xC] = B64_7(a[0xC]); \
		t0[0xD] = B64_0(a[0xD]) ^ PC64(0xD0, r); \
		t1[0xD] = B64_1(a[0xD]); \
		t2[0xD] = B64_2(a[0xD]); \
		t3[0xD] = B64_3(a[0xD]); \
		t4[0xD] = B64_4(a[0xD]); \
		t5[0xD] = B64_5(a[0xD]); \
		t6[0xD] = B64_6(a[0xD]); \
		t7[0xD] = B64_7(a[0xD]); \
		t0[0xE] = B64_0(a[0xE]) ^ PC64(0xE0, r); \
		t1[0xE] = B64_1(a[0xE]); \
		t2[0xE] = B64_2(a[0xE]); \
		t3[0xE] = B64_3(a[0xE]); \
		t4[0xE] = B64_4(a[0xE]); \
		t5[0xE] = B64_5(a[0xE]); \
		t6[0xE] = B64_6(a[0xE]); \
		t7[0xE] = B64_7(a[0xE]); \
		t0[0xF] = B64_0(a[0xF]) ^ PC64(0xF0, r); \
		t1[0xF] = B64_1(a[0xF]); \
		t2[0xF] = B64_2(a[0xF]); \
		t3[0xF] = B64_3(a[0xF]); \
		t4[0xF] = B64_4(a[0xF]); \
		t5[0xF] = B64_5(a[0xF]); \
		t6[0xF] = B64_6(a[0xF]); \
		t7[0xF] = B64_7(a[0xF]); \
		RBTT(a[0x0], 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0xB); \
		RBTT(a[0x1], 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0xC); \
		RBTT(a[0x2], 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0xD); \
		RBTT(a[0x3], 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xE); \
		RBTT(a[0x4], 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xF); \
		RBTT(a[0x5], 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0x0); \
		RBTT(a[0x6], 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0x1); \
		RBTT(a[0x7], 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0x2); \
		RBTT(a[0x8], 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0x3); \
		RBTT(a[0x9], 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, 0x4); \
		RBTT(a[0xA], 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, 0x0, 0x5); \
		RBTT(a[0xB], 0xB, 0xC, 0xD, 0xE, 0xF, 0x0, 0x1, 0x6); \
		RBTT(a[0xC], 0xC, 0xD, 0xE, 0xF, 0x0, 0x1, 0x2, 0x7); \
		RBTT(a[0xD], 0xD, 0xE, 0xF, 0x0, 0x1, 0x2, 0x3, 0x8); \
		RBTT(a[0xE], 0xE, 0xF, 0x0, 0x1, 0x2, 0x3, 0x4, 0x9); \
		RBTT(a[0xF], 0xF, 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0xA); \
	} while (0)

#define ROUND_BIG_Q(a, r)   do { \
		a[0x0] ^= QC64(0x00, r); \
		a[0x1] ^= QC64(0x10, r); \
		a[0x2] ^= QC64(0x20, r); \
		a[0x3] ^= QC64(0x30, r); \
		a[0x4] ^= QC64(0x40, r); \
		a[0x5] ^= QC64(0x50, r); \
		a[0x6] ^= QC64(0x60, r); \
		a[0x7] ^= QC64(0x70, r); \
		a[0x8] ^= QC64(0x80, r); \
		a[0x9] ^= QC64(0x90, r); \
		a[0xA] ^= QC64(0xA0, r); \
		a[0xB] ^= QC64(0xB0, r); \
		a[0xC] ^= QC64(0xC0, r); \
		a[0xD] ^= QC64(0xD0, r); \
		a[0xE] ^= QC64(0xE0, r); \
		a[0xF] ^= QC64(0xF0, r); \
		t0[0x0] = B64_0(a[0x0]); \
		t1[0x0] = B64_1(a[0x0]); \
		t2[0x0] = B64_2(a[0x0]); \
		t3[0x0] = B64_3(a[0x0]); \
		t4[0x0] = B64_4(a[0x0]); \
		t5[0x0] = B64_5(a[0x0]); \
		t6[0x0] = B64_6(a[0x0]); \
		t7[0x0] = B64_7(a[0x0]); \
		t0[0x1] = B64_0(a[0x1]); \
		t1[0x1] = B64_1(a[0x1]); \
		t2[0x1] = B64_2(a[0x1]); \
		t3[0x1] = B64_3(a[0x1]); \
		t4[0x1] = B64_4(a[0x1]); \
		t5[0x1] = B64_5(a[0x1]); \
		t6[0x1] = B64_6(a[0x1]); \
		t7[0x1] = B64_7(a[0x1]); \
		t0[0x2] = B64_0(a[0x2]); \
		t1[0x2] = B64_1(a[0x2]); \
		t2[0x2] = B64_2(a[0x2]); \
		t3[0x2] = B64_3(a[0x2]); \
		t4[0x2] = B64_4(a[0x2]); \
		t5[0x2] = B64_5(a[0x2]); \
		t6[0x2] = B64_6(a[0x2]); \
		t7[0x2] = B64_7(a[0x2]); \
		t0[0x3] = B64_0(a[0x3]); \
		t1[0x3] = B64_1(a[0x3]); \
		t2[0x3] = B64_2(a[0x3]); \
		t3[0x3] = B64_3(a[0x3]); \
		t4[0x3] = B64_4(a[0x3]); \
		t5[0x3] = B64_5(a[0x3]); \
		t6[0x3] = B64_6(a[0x3]); \
		t7[0x3] = B64_7(a[0x3]); \
		t0[0x4] = B64_0(a[0x4]); \
		t1[0x4] = B64_1(a[0x4]); \
		t2[0x4] = B64_2(a[0x4]); \
		t3[0x4] = B64_3(a[0x4]); \
		t4[0x4] = B64_4(a[0x4]); \
		t5[0x4] = B64_5(a[0x4]); \
		t6[0x4] = B64_6(a[0x4]); \
		t7[0x4] = B64_7(a[0x4]); \
		t0[0x5] = B64_0(a[0x5]); \
		t1[0x5] = B64_1(a[0x5]); \
		t2[0x5] = B64_2(a[0x5]); \
		t3[0x5] = B64_3(a[0x5]); \
		t4[0x5] = B64_4(a[0x5]); \
		t5[0x5] = B64_5(a[0x5]); \
		t6[0x5] = B64_6(a[0x5]); \
		t7[0x5] = B64_7(a[0x5]); \
		t0[0x6] = B64_0(a[0x6]); \
		t1[0x6] = B64_1(a[0x6]); \
		t2[0x6] = B64_2(a[0x6]); \
		t3[0x6] = B64_3(a[0x6]); \
		t4[0x6] = B64_4(a[0x6]); \
		t5[0x6] = B64_5(a[0x6]); \
		t6[0x6] = B64_6(a[0x6]); \
		t7[0x6] = B64_7(a[0x6]); \
		t0[0x7] = B64_0(a[0x7]); \
		t1[0x7] = B64_1(a[0x7]); \
		t2[0x7] = B64_2(a[0x7]); \
		t3[0x7] = B64_3(a[0x7]); \
		t4[0x7] = B64_4(a[0x7]); \
		t5[0x7] = B64_5(a[0x7]); \
		t6[0x7] = B64_6(a[0x7]); \
		t7[0x7] = B64_7(a[0x7]); \
		t0[0x8] = B64_0(a[0x8]); \
		t1[0x8] = B64_1(a[0x8]); \
		t2[0x8] = B64_2(a[0x8]); \
		t3[0x8] = B64_3(a[0x8]); \
		t4[0x8] = B64_4(a[0x8]); \
		t5[0x8] = B64_5(a[0x8]); \
		t6[0x8] = B64_6(a[0x8]); \
		t7[0x8] = B64_7(a[0x8]); \
		t0[0x9] = B64_0(a[0x9]); \
		t1[0x9] = B64_1(a[0x9]); \
		t2[0x9] = B64_2(a[0x9]); \
		t3[0x9] = B64_3(a[0x9]); \
		t4[0x9] = B64_4(a[0x9]); \
		t5[0x9] = B64_5(a[0x9]); \
		t6[0x9] = B64_6(a[0x9]); \
		t7[0x9] = B64_7(a[0x9]); \
		t0[0xA] = B64_0(a[0xA]); \
		t1[0xA] = B64_1(a[0xA]); \
		t2[0xA] = B64_2(a[0xA]); \
		t3[0xA] = B64_3(a[0xA]); \
		t4[0xA] = B64_4(a[0xA]); \
		t5[0xA] = B64_5(a[0xA]); \
		t6[0xA] = B64_6(a[0xA]); \
		t7[0xA] = B64_7(a[0xA]); \
		t0[0xB] = B64_0(a[0xB]); \
		t1[0xB] = B64_1(a[0xB]); \
		t2[0xB] = B64_2(a[0xB]); \
		t3[0xB] = B64_3(a[0xB]); \
		t4[0xB] = B64_4(a[0xB]); \
		t5[0xB] = B64_5(a[0xB]); \
		t6[0xB] = B64_6(a[0xB]); \
		t7[0xB] = B64_7(a[0xB]); \
		t0[0xC] = B64_0(a[0xC]); \
		t1[0xC] = B64_1(a[0xC]); \
		t2[0xC] = B64_2(a[0xC]); \
		t3[0xC] = B64_3(a[0xC]); \
		t4[0xC] = B64_4(a[0xC]); \
		t5[0xC] = B64_5(a[0xC]); \
		t6[0xC] = B64_6(a[0xC]); \
		t7[0xC] = B64_7(a[0xC]); \
		t0[0xD] = B64_0(a[0xD]); \
		t1[0xD] = B64_1(a[0xD]); \
		t2[0xD] = B64_2(a[0xD]); \
		t3[0xD] = B64_3(a[0xD]); \
		t4[0xD] = B64_4(a[0xD]); \
		t5[0xD] = B64_5(a[0xD]); \
		t6[0xD] = B64_6(a[0xD]); \
		t7[0xD] = B64_7(a[0xD]); \
		t0[0xE] = B64_0(a[0xE]); \
		t1[0xE] = B64_1(a[0xE]); \
		t2[0xE] = B64_2(a[0xE]); \
		t3[0xE] = B64_3(a[0xE]); \
		t4[0xE] = B64_4(a[0xE]); \
		t5[0xE] = B64_5(a[0xE]); \
		t6[0xE] = B64_6(a[0xE]); \
		t7[0xE] = B64_7(a[0xE]); \
		t0[0xF] = B64_0(a[0xF]); \
		t1[0xF] = B64_1(a[0xF]); \
		t2[0xF] = B64_2(a[0xF]); \
		t3[0xF] = B64_3(a[0xF]); \
		t4[0xF] = B64_4(a[0xF]); \
		t5[0xF] = B64_5(a[0xF]); \
		t6[0xF] = B64_6(a[0xF]); \
		t7[0xF] = B64_7(a[0xF]); \
		RBTT(a[0x0], 0x1, 0x3, 0x5, 0xB, 0x0, 0x2, 0x4, 0x6); \
		RBTT(a[0x1], 0x2, 0x4, 0x6, 0xC, 0x1, 0x3, 0x5, 0x7); \
		RBTT(a[0x2], 0x3, 0x5, 0x7, 0xD, 0x2, 0x4, 0x6, 0x8); \
		RBTT(a[0x3], 0x4, 0x6, 0x8, 0xE, 0x3, 0x5, 0x7, 0x9); \
		RBTT(a[0x4], 0x5, 0x7, 0x9, 0xF, 0x4, 0x6, 0x8, 0xA); \
		RBTT(a[0x5], 0x6, 0x8, 0xA, 0x0, 0x5, 0x7, 0x9, 0xB); \
		RBTT(a[0x6], 0x7, 0x9, 0xB, 0x1, 0x6, 0x8, 0xA, 0xC); \
		RBTT(a[0x7], 0x8, 0xA, 0xC, 0x2, 0x7, 0x9, 0xB, 0xD); \
		RBTT(a[0x8], 0x9, 0xB, 0xD, 0x3, 0x8, 0xA, 0xC, 0xE); \
		RBTT(a[0x9], 0xA, 0xC, 0xE, 0x4, 0x9, 0xB, 0xD, 0xF); \
		RBTT(a[0xA], 0xB, 0xD, 0xF, 0x5, 0xA, 0xC, 0xE, 0x0); \
		RBTT(a[0xB], 0xC, 0xE, 0x0, 0x6, 0xB, 0xD, 0xF, 0x1); \
		RBTT(a[0xC], 0xD, 0xF, 0x1, 0x7, 0xC, 0xE, 0x0, 0x2); \
		RBTT(a[0xD], 0xE, 0x0, 0x2, 0x8, 0xD, 0xF, 0x1, 0x3); \
		RBTT(a[0xE], 0xF, 0x1, 0x3, 0x9, 0xE, 0x0, 0x2, 0x4); \
		RBTT(a[0xF], 0x0, 0x2, 0x4, 0xA, 0xF, 0x1, 0x3, 0x5); \
	} while (0)

#define PERM_BIG_P(a, start, end)   do { \
		for (u = start; u < end; u++) { \
			ROUND_BIG_P(a, u); \
		} \
	} while (0)

#define PERM_BIG_Q(a)   do { \
		for (u = 0; u < 14; u++) { \
			ROUND_BIG_Q(a, u); \
		} \
	} while (0)

#endif
