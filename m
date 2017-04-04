Return-Path: <SRS0=U6b7=3M=sntech.de=heiko@kernel.org>
From: Heiko Stuebner <heiko@sntech.de>
To: cl@rock-chips.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, zhengxing@rock-chips.com, andy.yan@rock-chips.com, jay.xu@rock-chips.com, matthias.bgg@gmail.com, paweljarosz3691@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wxt@rock-chips.com, david.wu@rock-chips.com, linux-iio@vger.kernel.org, shawn.lin@rock-chips.com, akpm@linux-foundation.org, dianders@chromium.org, yamada.masahiro@socionext.com, catalin.marinas@arm.com, will.deacon@arm.com, afaerber@suse.de, shawnguo@kernel.org, khilman@baylibre.com, arnd@arndb.de, fabio.estevam@nxp.com, zhangqing@rock-chips.com, kever.yang@rock-chips.com, tony.xie@rock-chips.com, huangtao@rock-chips.com, yhx@rock-chips.com, rocky.hao@rock-chips.com
Subject: Re: [PATCH v4 4/6] arm64: dts: rockchip: add core dtsi file for RK3328 SoCs
Date: Tue, 04 Apr 2017 18:04:03 +0200
Message-ID: <6636047.jL6XHNkknt@phil>
In-Reply-To: <1490607650-18650-4-git-send-email-cl@rock-chips.com>
References: <1490607650-18650-1-git-send-email-cl@rock-chips.com> <1490607650-18650-4-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <linux-iio@vger.kernel.org>

Am Montag, 27. M=E4rz 2017, 17:40:48 CEST schrieb cl@rock-chips.com:
> From: Liang Chen <cl@rock-chips.com>
>=20
> This patch adds core dtsi file for Rockchip RK3328 SoCs.
>=20
> Signed-off-by: Liang Chen <cl@rock-chips.com>

applied for 4.12, with the following list of changes:

=2D reorder some properties to bring them in alphabetical order
=2D dropped the status-disabled from the power-controller
  power-domain control is a quite essential part of the system, so if
  boards really want to disable them, they should do it in their board file
  Having power-domains on all the time, is also our default in all other
  devicetrees.
=2D removed #dma-cells from spi0 -> this is not a dma controller
=2D reword the cru assigned-clocks comment a bit
=2D fixed sdmmc1_bus4 pins, as indicated by Shawn and after looking up the
  correct pins in the manual


And a final question, are you sure about SCLK_PDM becoming a child of the
APLL in your cru assigned-clocks, as the APLL will vary later on with cpufr=
eq
active?


Heiko
