Return-Path: <SRS0=dFfS=3B=sntech.de=heiko@kernel.org>
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: =?utf-8?B?6ZmI5Lqu?= <cl@rock-chips.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, zhengxing@rock-chips.com, andy.yan@rock-chips.com, jay.xu@rock-chips.com, matthias.bgg@gmail.com, paweljarosz3691@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wxt@rock-chips.com, david.wu@rock-chips.com, linux-iio@vger.kernel.org, shawn.lin@rock-chips.com, akpm@linux-foundation.org, dianders@chromium.org, yamada.masahiro@socionext.com, catalin.marinas@arm.com, will.deacon@arm.com, afaerber@suse.de, shawnguo@kernel.org, khilman@baylibre.com, arnd@arndb.de, fabio.estevam@nxp.com, zhangqing@rock-chips.com, kever.yang@rock-chips.com, tony.xie@rock-chips.com, huangtao@rock-chips.com, yhx@rock-chips.com, rocky.hao@rock-chips.com
Subject: Re: [PATCH v2 4/6] arm64: dts: rockchip: add core dtsi file for RK3328 SoCs
Date: Fri, 24 Mar 2017 08:12:07 +0100
Message-ID: <3271639.DkaRJdVeCG@diego>
In-Reply-To: <58D4BD40.5090900@rock-chips.com>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com> <58D34208.6090509@rock-chips.com> <58D4BD40.5090900@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Am Freitag, 24. M=C3=A4rz 2017, 14:31:28 CET schrieb =E9=99=88=E4=BA=AE:
> Hi, Heiko:
>=20
> =E5=9C=A8 2017=E5=B9=B403=E6=9C=8823=E6=97=A5 11:33, =E9=99=88=E4=BA=AE =
=E5=86=99=E9=81=93:
> > Hi, Heiko
> >=20
> > =E5=9C=A8 2017=E5=B9=B403=E6=9C=8821=E6=97=A5 16:55, Heiko St=C3=BCbner=
 =E5=86=99=E9=81=93:
> >> Hi,
> >>=20
> >> Am Donnerstag, 16. M=C3=A4rz 2017, 21:17:22 CET schrieb cl@rock-chips.=
com:
> >>> +        assigned-clock-parents =3D
> >>> +            <&cru HDMIPHY>, <&cru PLL_APLL>,
> >>> +            <&cru PLL_GPLL>, <&xin24m>,
> >>> +            <&xin24m>, <&xin24m>;
> >>> +        assigned-clock-rates =3D
> >>> +            <0>, <61440000>,
> >>> +            <0>, <24000000>,
> >>> +            <24000000>, <24000000>,
> >>> +            <15000000>, <15000000>,
> >>> +            <100000000>, <100000000>,
> >>> +            <100000000>, <100000000>,
> >>> +            <50000000>, <100000000>,
> >>> +            <100000000>, <100000000>,
> >>> +            <50000000>, <50000000>,
> >>> +            <50000000>, <50000000>,
> >>> +            <24000000>, <600000000>,
> >>> +            <491520000>, <1200000000>,
> >>> +            <150000000>, <75000000>,
> >>> +            <75000000>, <150000000>,
> >>> +            <75000000>, <75000000>,
> >>> +            <300000000>, <100000000>,
> >>> +            <300000000>, <200000000>,
> >>> +            <400000000>, <500000000>,
> >>> +            <200000000>, <300000000>,
> >>> +            <300000000>, <250000000>,
> >>> +            <200000000>, <100000000>,
> >>> +            <24000000>, <100000000>,
> >>> +            <150000000>, <50000000>,
> >>> +            <32768>, <32768>;
> >>> +    };
> >>> +
> >>> +    gmac2io: eth@ff540000 {
> >>=20
> >> phandle should be gmac instead?
> >> Node name, ethernet@ff540000
> >=20
> > RK3328 have another gmac channel with PHY in the soc, so gmac2io mean
> > the channel with the PHY outside, and it is also called gmac2io in the
> > TRM.
>=20
> So we remain gmac2io, or you have other idea?

No, that is ok in that case.

Heiko
