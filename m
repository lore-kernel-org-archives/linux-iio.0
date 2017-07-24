Return-Path: <SRS0=cgOO=63=aosc.io=icenowy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 24 Jul 2017 14:06:20 +0800
From: icenowy@aosc.io
To: Chen-Yu Tsai <wens@csie.org>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>, Jonathan Cameron
 <jic23@kernel.org>, Quentin Schulz <quentin.schulz@free-electrons.com>,
 devicetree <devicetree@vger.kernel.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org, linux-sunxi
 <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH v3 2/5] iio: adc: sun4i-gpadc-iio: rename
 A23/A33-specified registers to contain A23
In-Reply-To: <CAGb2v65a3tyr5EJLgB9mhz2aYsU9NkMSg+wF_aJuhmT3tNpL2w@mail.gmail.com>
References: <20170723141354.42646-1-icenowy@aosc.io>
 <20170723141354.42646-3-icenowy@aosc.io>
 <CAGb2v65a3tyr5EJLgB9mhz2aYsU9NkMSg+wF_aJuhmT3tNpL2w@mail.gmail.com>
Message-ID: <56900ea0ab9a28aea673d68097049354@aosc.io>
List-ID: <linux-iio@vger.kernel.org>

=E5=9C=A8 2017-07-24 14:02=EF=BC=8CChen-Yu Tsai =E5=86=99=E9=81=93=EF=BC=9A
> On Sun, Jul 23, 2017 at 10:13 PM, Icenowy Zheng <icenowy@aosc.io>=20
> wrote:
>> As the H3 SoC, which is also in sun8i line, has totally different
>> register map for the thermal sensor (a cut down version of GPADC), we
>> should rename A23/A33-specified registers to contain A23, in order to
>> prevent obfuscation with H3 registers. Currently these registers are
>> only prefixed "SUN8I", not "SUN8I_A23".
>>=20
>> Add "_A23" after "SUN8I" on the register names.
>=20
> Nit: the compatible string as well as the initial driver targets the=20
> A33.
> Naming the registers as such would be more consistent.

But the registers are the same between A23 and A33.

In fact the only difference between A23 and A33 is the formula's=20
factors.

>=20
> Otherwise,
>=20
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
