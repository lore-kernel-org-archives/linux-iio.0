Return-Path: <SRS0=len+=A2=free-electrons.com=quentin.schulz@kernel.org>
Subject: Re: [RFC PATCH 1/7] dt-bindings: add compatibles for AXP803
 Battery/USB power supplies
To: Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20170920151814.22461-1-icenowy@aosc.io>
 <20170920151814.22461-2-icenowy@aosc.io>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <8cf69d3d-0004-b5dc-16e0-ce1a4f8c313b@free-electrons.com>
Date: Mon, 25 Sep 2017 11:14:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170920151814.22461-2-icenowy@aosc.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Hi Icenowy,

On 20/09/2017 17:18, Icenowy Zheng wrote:
> The AXP803 PMIC has different Battery and USB power supplies than the
> AXP series PMICs already supported by the kernel, but the AC power
> supply is the same as AXP22x (as it can only detect the present/online
> state of the AC power supply on both AXP22x and AXP803).
> 
> Add compatible strings for the AXP803 Battery/USB power supplies. For AC
> power supply the one on AXP803 is compatible with the one on AXP22x.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/power/supply/axp20x_battery.txt   | 1 +
>  Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> index c24886676a60..091e5471a8c6 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> @@ -4,6 +4,7 @@ Required Properties:
>   - compatible, one of:
>  			"x-powers,axp209-battery-power-supply"
>  			"x-powers,axp221-battery-power-supply"
> +			"x-powers,axp803-battery-power-supply"
>  
>  This node is a subnode of the axp20x/axp22x PMIC.
>  
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
> index ba8d35f66cbe..f30e3bf8d23f 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
> @@ -4,6 +4,7 @@ Required Properties:
>  -compatible: One of: "x-powers,axp202-usb-power-supply"
>                       "x-powers,axp221-usb-power-supply"
>                       "x-powers,axp223-usb-power-supply"
> +                     "x-powers,axp803-usb-power-supply"

No. You are adding support for AC and battery power supply in this
patchset, not for USB.

Quentin
-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
