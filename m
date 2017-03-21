Return-Path: <SRS0=yRjI=26=sntech.de=heiko@kernel.org>
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: =?utf-8?B?6ZmI5Lqu?= <cl@rock-chips.com>
Cc: Andre Przywara <andre.przywara@arm.com>, mark.rutland@arm.com, wsa@the-dreams.de, linux-iio@vger.kernel.org, catalin.marinas@arm.com, shawn.lin@rock-chips.com, will.deacon@arm.com, kever.yang@rock-chips.com, dianders@chromium.org, yamada.masahiro@socionext.com, tony.xie@rock-chips.com, linux-i2c@vger.kernel.org, pmeerw@pmeerw.net, lars@metafoo.de, zhengxing@rock-chips.com, khilman@baylibre.com, linux-rockchip@lists.infradead.org, jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com, devicetree@vger.kernel.org, zhangqing@rock-chips.com, paweljarosz3691@gmail.com, arnd@arndb.de, yhx@rock-chips.com, knaack.h@gmx.de, robh+dt@kernel.org, matthias.bgg@gmail.com, rocky.hao@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, david.wu@rock-chips.com, fabio.estevam@nxp.com, andy.yan@rock-chips.com, akpm@linux-foundation.org, shawnguo@kernel.org, afaerber@suse.de, jic23@kernel.org
Subject: Re: [PATCH v1 6/7] arm64: dts: rockchip: add dts file for RK3328 evaluation board
Date: Tue, 21 Mar 2017 09:57:44 +0100
Message-ID: <4463099.tv8gYSJGZa@diego>
In-Reply-To: <58D0DD76.8090909@rock-chips.com>
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com> <4559383.EsY2O1vJ7P@phil> <58D0DD76.8090909@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi,

Am Dienstag, 21. M=C3=A4rz 2017, 15:59:50 CET schrieb =E9=99=88=E4=BA=AE:
> Hi Heiko=EF=BC=9A
>=20
>          Is there any advice about the big dtsi?
>          I would like to send next version , thanks.

I did comment on your v2 dtsi though :-) .

Heiko

> =E5=9C=A8 2017=E5=B9=B403=E6=9C=8817=E6=97=A5 16:45, Heiko Stuebner =E5=
=86=99=E9=81=93:
> > Am Freitag, 17. M=C3=A4rz 2017, 10:26:13 CET schrieb =E9=99=88=E4=BA=AE:
> >> =E5=9C=A8 2017=E5=B9=B403=E6=9C=8817=E6=97=A5 00:18, Andre Przywara =
=E5=86=99=E9=81=93:
> >>> Hi Chen,
> >>>=20
> >>> On 16/03/17 01:45, cl@rock-chips.com wrote:
> >>>> From: Chen Liang <cl@rock-chips.com>
> >>>>=20
> >>>> This patch add rk3328-evb.dts for RK3328 evaluation board.
> >>>> Tested on RK3328 evb.
> >>>>=20
> >>>> Signed-off-by: Chen Liang <cl@rock-chips.com>
> >>>> ---
> >>>>=20
> >>>>    arch/arm64/boot/dts/rockchip/Makefile       |  1 +
> >>>>    arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 57
> >>>>    +++++++++++++++++++++++++++++ 2 files changed, 58 insertions(+)
> >>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-evb.dts
> >>>>=20
> >>>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile
> >>>> b/arch/arm64/boot/dts/rockchip/Makefile index 3a86289..853fc7d 100644
> >>>> --- a/arch/arm64/boot/dts/rockchip/Makefile
> >>>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> >>>> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D
> >>>> rk3368-orion-r68-meta.dtb
> >>>>=20
> >>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3368-px5-evb.dtb
> >>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3368-r88.dtb
> >>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-evb.dtb
> >>>>=20
> >>>> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3328-evb.dtb
> >>>>=20
> >>>>    always		:=3D $(dtb-y)
> >>>>    subdir-y	:=3D $(dts-dirs)
> >>>>=20
> >>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
> >>>> b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts new file mode 100644
> >>>> index 0000000..cf27239
> >>>> --- /dev/null
> >>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
> >>>> @@ -0,0 +1,57 @@
> >>>> +/*
> >>>> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
> >>>> + *
> >>>> + * This file is dual-licensed: you can use it either under the terms
> >>>> + * of the GPL or the X11 license, at your option. Note that this du=
al
> >>>> + * licensing only applies to this file, and not this project as a
> >>>> + * whole.
> >>>> + *
> >>>> + *  a) This library is free software; you can redistribute it and/or
> >>>> + *     modify it under the terms of the GNU General Public License =
as
> >>>> + *     published by the Free Software Foundation; either version 2 =
of
> >>>> the
> >>>> + *     License, or (at your option) any later version.
> >>>> + *
> >>>> + *     This library is distributed in the hope that it will be usef=
ul,
> >>>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty =
of
> >>>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>>> + *     GNU General Public License for more details.
> >>>> + *
> >>>> + * Or, alternatively,
> >>>> + *
> >>>> + *  b) Permission is hereby granted, free of charge, to any person
> >>>> + *     obtaining a copy of this software and associated documentati=
on
> >>>> + *     files (the "Software"), to deal in the Software without
> >>>> + *     restriction, including without limitation the rights to use,
> >>>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> >>>> + *     sell copies of the Software, and to permit persons to whom t=
he
> >>>> + *     Software is furnished to do so, subject to the following
> >>>> + *     conditions:
> >>>> + *
> >>>> + *     The above copyright notice and this permission notice shall =
be
> >>>> + *     included in all copies or substantial portions of the Softwa=
re.
> >>>> + *
> >>>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KI=
ND,
> >>>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANT=
IES
> >>>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> >>>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> >>>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> >>>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> >>>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >>>> + *     OTHER DEALINGS IN THE SOFTWARE.
> >>>> + */
> >>>> +
> >>>> +/dts-v1/;
> >>>> +#include "rk3328.dtsi"
> >>>> +
> >>>> +/ {
> >>>> +	model =3D "Rockchip RK3328 EVB";
> >>>> +	compatible =3D "rockchip,rk3328-evb", "rockchip,rk3328";
> >>>> +
> >>>> +	chosen {
> >>>> +		stdout-path =3D "serial2:1500000n8";
> >>>=20
> >>> Is that really 1.5MBit/s?
> >>=20
> >> Yes, the RK3328 EVB board use 1.5MBit/s baud rate.
> >>=20
> >>>> +	};
> >>>> +};
> >>>> +
> >>>> +&uart2 {
> >>>> +	status =3D "okay";
> >>>> +};
> >>>=20
> >>> I don't have the board, but would expect to see more peripherals
> >>> mentioned in the .dtsi enabled here.
> >>> For sure the board has an (micro)SD card slot, possibly even Ethernet?
> >>=20
> >> The codes for other peripherals are not ready now for new kernel, so i
> >> push a base dtsi, and other configration will be pushed later if it is
> >> ok.
> >=20
> > for me that approach is fine in general, but here, you could enable at
> > least the watchdog as well?
> >=20
> > But no need to resend just now, I still need to look at the big dtsi.
> >=20
> >=20
> > Heiko
