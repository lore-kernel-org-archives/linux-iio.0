Return-Path: <SRS0=P5YL=MR=gmail.com=wens213@kernel.org>
MIME-Version: 1.0
References: <20181004193410.7265-1-oskari@lemmela.net>
In-Reply-To: <20181004193410.7265-1-oskari@lemmela.net>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 5 Oct 2018 11:37:09 +0800
Message-ID: <CAGb2v666d=aMi8u51t-=1mskCdLhifEw0iN7BWNxmQGod=F77A@mail.gmail.com>
Subject: Re: [PATCH 0/4] AXP8x3 AC and battery power supply support
To: oskari@lemmela.net
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>,
	Quentin Schulz <quentin.schulz@free-electrons.com>, linux-gpio@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org, "open list:THERMAL" <linux-pm@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Fri, Oct 5, 2018 at 3:34 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP803 AC and battery power supply support.
> AXP803/AXP813 AC power supply support with input current and
> voltage limiting support.
>
> Oskari Lemmela (4):
>   dt-bindings: add compatibles for AXP803 AC and battery power supplies
>   ARM: dtsi: axp81x: add AC power supply subnode

The prefix should be "ARM: dts: axp81x: "

>   arm64: allwinner: a64: add battery and AC power supply support

This should be "arm64: dts: allwinner: a64: <board>: add ..."

>   power: supply: add AXP803/AXP813 AC and battery power supply support
>
>  .../devicetree/bindings/gpio/gpio-axp209.txt  |   3 +-
>  .../bindings/iio/adc/axp20x_adc.txt           |   3 +-
>  .../bindings/power/supply/axp20x_ac_power.txt |   4 +
>  .../bindings/power/supply/axp20x_battery.txt  |   1 +
>  arch/arm/boot/dts/axp81x.dtsi                 |   5 +
>  arch/arm64/boot/dts/allwinner/axp803.dtsi     |  31 +++
>  .../allwinner/sun50i-a64-sopine-baseboard.dts |   8 +
>  drivers/iio/adc/axp20x_adc.c                  |   1 +
>  drivers/mfd/axp20x.c                          |  22 +-
>  drivers/pinctrl/pinctrl-axp209.c              |   1 +
>  drivers/power/supply/axp20x_ac_power.c        | 194 ++++++++++++++++++
>  drivers/power/supply/axp20x_battery.c         |   3 +
>  include/linux/mfd/axp20x.h                    |   1 +
>  13 files changed, 274 insertions(+), 3 deletions(-)
>
> --
> 2.17.1
>
