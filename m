Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f175.google.com ([209.85.210.175]:34207 "EHLO
        mail-wj0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbdADLwA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jan 2017 06:52:00 -0500
Received: by mail-wj0-f175.google.com with SMTP id tn15so8563069wjb.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Jan 2017 03:51:02 -0800 (PST)
Date: Wed, 4 Jan 2017 11:54:44 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Pavel Machek <pavel@ucw.cz>, Jingoo Han <jingoohan1@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v4 1/5] devicetree: mfd: Add binding for the TI LM3533
Message-ID: <20170104115444.GI27589@dell>
References: <20161226181153.11271-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161226181153.11271-1-bjorn.andersson@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 26 Dec 2016, Bjorn Andersson wrote:

> From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> 
> Add the binding for the Texas Instruments LM3533 lighting power
> solution.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

> ---
> 
> I had Acks from Jonathan and Rob on v3, but dropped these due to the added
> compatible properties.
> 
> Changes since v3:
> - Added compatible to sub-nodes, per Lee's requested to treat them as separate
>   pieces.
> 
>  Documentation/devicetree/bindings/mfd/lm3533.txt | 205 +++++++++++++++++++++++
>  1 file changed, 205 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/lm3533.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/lm3533.txt b/Documentation/devicetree/bindings/mfd/lm3533.txt
> new file mode 100644
> index 000000000000..909281096ba2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/lm3533.txt
> @@ -0,0 +1,205 @@
> +Texas Instruments LM3533 binding
> +
> +This binding describes the Texas Instruments LM3533, a lighting power solution
> +for smartphone handsets. The common properties are described directly in the
> +node, while each individual component are described in an optional subnode.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be:
> +		    "ti,lm3533"
> +
> +- reg:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: i2c address of the LM3533 chip
> +
> +- als-supply:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: reference to regulator powering the V_als input; as
> +		    specified in "../regulator/regulator.txt"
> +
> +- hwen-gpios:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: reference to gpio pin connected to the HWEN input; as
> +		    specified in "../gpio/gpio.txt"
> +
> +- ti,boost-freq-hz:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: switch-frequency of the boost converter, must be either:
> +		    500000 or 1000000
> +
> +- ti,boost-ovp-mv:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: over-voltage protection limit, in mV. Must be one of:
> +		    16000, 24000, 32000 or 40000
> +
> +- #address-cells:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: must be 1
> +
> +- #size-cells:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: must be 0
> +
> += ALS SUBNODE
> +The ambient light sensor subnode carrying the light sensor related properties.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be:
> +		    "ti,lm3533-als"
> +
> +- ti,als-resistance-ohm:
> +	Usage: required (unless ti,pwm-mode is specified)
> +	Value type: <u32>
> +	Definition: specifies the resistor value (R_als), in Ohm. Valid values
> +		    ranges from 200000 to 1574 Ohm.
> +
> +- ti,pwm-mode:
> +	Usage: optional
> +	Value type: <empty>
> +	Definition: specifies, if present, that the als should operate in PWM
> +		    mode - rather than analog mode
> +
> += BACKLIGHT NODES
> +Backlight subnodes carrying the backlight related properties.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be:
> +		    "ti,lm3533-backlight"
> +
> +- reg:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: specifies which of the two backlights this node corresponds
> +		    to
> +
> +- default-brightness:
> +	Usage: optional
> +	Value type: <32>
> +	Definition: specifies the default brightness for the backlight, in
> +		    units of brightness [0-255]
> +
> +- label:
> +	Usage: required
> +	Value type: <string>
> +	Definition: specifies a name of this backlight
> +
> +- led-max-microamp:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: specifies the max current for this backlight, in uA, as
> +		    described in "../leds/common.txt"
> +
> +- ti,pwm-zones:
> +	Usage: optional
> +	Value type: <u32 list>
> +	Definition: lists the ALS zones to be PWM controlled for this backlight,
> +		    the values in the list are in the range [0 - 4]
> +
> += LED NODES
> +LED subnodes carrying the LED related properties.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be:
> +		    "ti,lm3533-led"
> +
> +- reg:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: specifies which of the four LEDs this node corresponds to
> +
> +- linux,default-trigger:
> +	Usage: optional
> +	Value type: <string>
> +	Definition: specifies the default trigger for the LED, as described in
> +		    "../leds/common.txt"
> +
> +- label:
> +	Usage: required
> +	Value type: <string>
> +	Definition: specifies a name of this LED, as described in
> +		    "../leds/common.txt"
> +
> +- led-max-microamp:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: specifies the max current for this LED, in uA, as described
> +		    in "../leds/common.txt"
> +
> +- ti,pwm-zones:
> +	Usage: optional
> +	Value type: <u32 list>
> +	Definition: lists the ALS zones to be PWM controlled for this LED, the
> +		    values in the list are in the range [0 - 4]
> +
> += EXAMPLE
> +
> +i2c@12460000 {
> +	compatible = "qcom,i2c-qup-v1.1.1";
> +	...
> +
> +	lm3533@36 {
> +		compatible = "ti,lm3533";
> +		reg = <0x36>;
> +
> +		als-supply = <&pm8921_l11>;
> +		hwen-gpios = <&pm8921_gpio 26 GPIO_ACTIVE_HIGH>;
> +
> +		ti,boost-freq-hz = <500000>;
> +		ti,boost-ovp-mv = <24000>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		als {
> +			compatible = "ti,lm3533-als";
> +			ti,als-resistance-ohm = <200000>;
> +		};
> +
> +		backlight@0 {
> +			compatible = "ti,lm3533-backlight";
> +			reg = <0>;
> +			label = "backlight";
> +
> +			led-max-microamp = <20200>;
> +		};
> +
> +		led@0 {
> +			compatible = "ti,lm3533-led";
> +			reg = <0>;
> +			label = "red";
> +
> +			led-max-microamp = <5000>;
> +		};
> +
> +		led@1 {
> +			compatible = "ti,lm3533-led";
> +			reg = <1>;
> +			label = "green";
> +
> +			led-max-microamp = <5000>;
> +		};
> +
> +		led@2 {
> +			compatible = "ti,lm3533-led";
> +			reg = <2>;
> +			label = "blue";
> +
> +			led-max-microamp = <5000>;
> +		};
> +	};
> +

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
