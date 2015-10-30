Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38702 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758631AbbJ3SsN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Oct 2015 14:48:13 -0400
Received: by wmeg8 with SMTP id g8so18670905wme.1
        for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2015 11:48:12 -0700 (PDT)
Date: Fri, 30 Oct 2015 18:42:20 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Johan Hovold <jhovold@gmail.com>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] devicetree: mfd: Add binding for the TI LM3533
Message-ID: <20151030184220.GJ4058@x1>
References: <1445796586-28683-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1445963373-27790-1-git-send-email-bjorn.andersson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1445963373-27790-1-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 27 Oct 2015, Bjorn Andersson wrote:

> Add the binding for the Texas Instruments LM3533 lighting power
> solution.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
> 
> Changes since v1:
> - Added unit to boost-freq and als-resistance (as the frequency now comes with
>   a unit specifier I changed it to be expressed in kHz)
> 
>  Documentation/devicetree/bindings/mfd/lm3533.txt | 183 +++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/lm3533.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/lm3533.txt b/Documentation/devicetree/bindings/mfd/lm3533.txt
> new file mode 100644
> index 000000000000..399df39ec7e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/lm3533.txt
> @@ -0,0 +1,183 @@
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
> +- ti,hwen-gpios:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: reference to gpio pin connected to the HWEN input; as
> +		    specified in "gpio/gpio.txt"

Why have you made this a vendor binding?

*-gpios is a generic property.

> +- ti,als-supply:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: reference to regulator powering the V_als input; as
> +		    specified in "regulator/regulator.txt"

Same goes for *-supply.

> +- ti,boost-freq-khz:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: switch-frequency of the boost converter, must be either:
> +		    500 or 1000

Quite a few vendors are using 'boost' now.

Perhaps we need to create a set of generic bindings.

Also, we usually measure DT bindings in HZ, not kHz.

> +- ti,boost-ovp:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: over voltage protection limit, must be one of: 16, 24, 32
> +		    or 40

Is this in volts?  If so, it should be microvolts.

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
> +The als subnode must be named "als", it carries the als related properties.

Perfect time to tell us what ALS is/means.

> +- ti,als-resistance-ohm:
> +	Usage: required (unless ti,pwm-mode is specified)
> +	Value type: <u32>
> +	Definition: specifies the resistor value (R_als), in Ohm. Valid values
> +		    ranges from 200kOhm to 1574Ohm.

Might be worth specifying the values which you are actually going to
use here i.e. "200kOhm" is not a valid u32.

> +- ti,pwm-mode:
> +	Usage: optional
> +	Value type: <empty>
> +	Definition: specifies, if present, that the als should operate in pwm

Suggest s/pwm/PWM/

> +		    mode - rather than analog mode
> +
> += BACKLIGHT NODES
> +Backlight subnodes must be named "backlight", they carry the backlight related
> +properties.
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
> +		    described in "leds/common.txt"
> +
> +- ti,pwm-zones:
> +	Usage: optional
> +	Value type: <u32 list>
> +	Definition: lists the ALS zones to be PWM controlled for this backlight,
> +		    the values in the list are in the range [0 - 4]
> +

It's usually a good idea to point to where all of the aforementioned
generic properties are documented.  I personally like the format
(See: ../<subsystem>/<binding>.txt)

> += LED NODES
> +LED subnodes must be named "led", they carry the LED related properties.
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
> +		    "leds/common.txt"

No such file.  I think you mean "../leds/common/txt".

> +- label:
> +	Usage: required
> +	Value type: <string>
> +	Definition: specifies a name of this LED, as described in
> +		    "leds/common.txt"
> +
> +- led-max-microamp:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: specifies the max current for this LED, in uA, as described
> +		    in "leds/common.txt"
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
> +		ti,hwen-gpios = <&pm8921_gpio 26 GPIO_ACTIVE_HIGH>;
> +		ti,als-supply = <&pm8921_l11>;
> +
> +		ti,boost-freq = <500000>;
> +		ti,boost-ovp = <24>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		als {
> +			ti,als-resistance = <200000>;
> +		};
> +
> +		backlight@0 {
> +			reg = <0>;
> +			label = "backlight";
> +
> +			led-max-microamp = <20200>;
> +		};
> +
> +		led@0 {
> +			reg = <0>;
> +			label = "red";
> +
> +			led-max-microamp = <5000>;
> +		};
> +
> +		led@1 {
> +			reg = <1>;
> +			label = "green";
> +
> +			led-max-microamp = <5000>;
> +		};
> +
> +		led@2 {
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
