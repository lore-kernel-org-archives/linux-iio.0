Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38223 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbdDHQkg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2017 12:40:36 -0400
Subject: Re: [PATCH 1/3 v5] iio: xoadc: augment DT bindings a bit
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <20170404120819.6921-1-linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <32991d83-3622-1923-3fc2-d0292d4d40b5@kernel.org>
Date: Sat, 8 Apr 2017 17:40:34 +0100
MIME-Version: 1.0
In-Reply-To: <20170404120819.6921-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/04/17 13:08, Linus Walleij wrote:
> In order to accommodate in a logical manner for the premuxed channels
> in PM8921 and the similarly addressed channels in later PMICs, we
> need a twocell arrangement with premux and analog mux setting as
> a tuple to uniquely identify a hardware channel.
> 
> These bindings are not yet in use, so it should be fine to augment
> them before we actually start using it in drivers and device trees.
> 
> This scheme came out of lengthy discussions and reverse-engineering
> and reading of the few information sources we have.
> 
> Cc: devicetree@vger.kernel.org
> Acked-by: Rob Herring <robh+dt@kernel.org>
> Suggested-by: Björn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> ChangeLog v3->v5:
> - Some nitpicky spelling fixes. Added Rob's ACK.
> ChangeLog v2->v3:
> - Drop leading zeroes on unit addresses.
> ChangeLog v1->v2:
> - Name nodes with <01 02> in a foo@0102 pattern.
> - Minor spelling nits.
> - Delete flimsy leftover docs from an interrim development path.
> ---
>  .../bindings/iio/adc/qcom,pm8xxx-xoadc.txt         | 76 ++++++++++++----------
>  1 file changed, 42 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
> index 53cd146d8096..3ae06127789e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
> @@ -19,32 +19,42 @@ Required properties:
>    with PMIC variant but is typically something like 2.2 or 1.8V.
>  
>  The following required properties are standard for IO channels, see
> -iio-bindings.txt for more details:
> +iio-bindings.txt for more details, but notice that this particular
> +ADC has a special addressing scheme that require two cells for
> +identifying each ADC channel:
>  
> -- #address-cells: should be set to <1>
> +- #address-cells: should be set to <2>, the first cell is the
> +  prescaler (on PM8058) or premux (on PM8921) with two valid bits
> +  so legal values are 0x00, 0x01 or 0x02. The second cell
> +  is the main analog mux setting (0x00..0x0f). The combination
> +  of prescaler/premux and analog mux uniquely addresses a hardware
> +  channel on all systems.
>  
>  - #size-cells: should be set to <0>
>  
> -- #io-channel-cells: should be set to <1>
> +- #io-channel-cells: should be set to <2>, again the cells are
> +  precaler or premux followed by the analog muxing line.
>  
>  - interrupts: should refer to the parent PMIC interrupt controller
>    and reference the proper ADC interrupt.
>  
>  Required subnodes:
>  
> -The ADC channels are configured as subnodes of the ADC. Since some of
> -them are used for calibrating the ADC, these nodes are compulsory:
> +The ADC channels are configured as subnodes of the ADC.
> +
> +Since some of them are used for calibrating the ADC, these nodes are
> +compulsory:
>  
>  adc-channel@c {
> -	reg = <0x0c>;
> +	reg = <0x00 0x0c>;
>  };
>  
>  adc-channel@d {
> -	reg = <0x0d>;
> +	reg = <0x00 0x0d>;
>  };
>  
>  adc-channel@f {
> -	reg = <0x0f>;
> +	reg = <0x00 0x0f>;
>  };
>  
>  These three nodes are used for absolute and ratiometric calibration
> @@ -52,13 +62,13 @@ and only need to have these reg values: they are by hardware definition
>  1:1 ratio converters that sample 625, 1250 and 0 milliV and create
>  an interpolation calibration for all other ADCs.
>  
> -Optional subnodes: any channels other than channel 0x0c, 0x0d and
> -0x0f are optional.
> +Optional subnodes: any channels other than channels [0x00 0x0c],
> +[0x00 0x0d] and [0x00 0x0f] are optional.
>  
>  Required channel node properties:
>  
>  - reg: should contain the hardware channel number in the range
> -  0 .. 0x0f (4 bits). The hardware only supports 16 channels.
> +  0 .. 0xff (8 bits).
>  
>  Optional channel node properties:
>  
> @@ -94,56 +104,54 @@ Example:
>  xoadc: xoadc@197 {
>  	compatible = "qcom,pm8058-adc";
>  	reg = <0x197>;
> -	interrupt-parent = <&pm8058>;
> -	interrupts = <76 1>;
> -	#address-cells = <1>;
> +	interrupts-extended = <&pm8058 76 IRQ_TYPE_EDGE_RISING>;
> +	#address-cells = <2>;
>  	#size-cells = <0>;
> -	#io-channel-cells = <1>;
> +	#io-channel-cells = <2>;
>  
>  	vcoin: adc-channel@0 {
> -		reg = <0x00>;
> +		reg = <0x00 0x00>;
>  	};
>  	vbat: adc-channel@1 {
> -		reg = <0x01>;
> +		reg = <0x00 0x01>;
>  	};
>  	dcin: adc-channel@2 {
> -		reg = <0x02>;
> +		reg = <0x00 0x02>;
>  	};
>  	ichg: adc-channel@3 {
> -		reg = <0x03>;
> +		reg = <0x00 0x03>;
>  	};
>  	vph_pwr: adc-channel@4 {
> -		reg = <0x04>;
> +		reg = <0x00 0x04>;
>  	};
>  	usb_vbus: adc-channel@a {
> -		reg = <0x0a>;
> +		reg = <0x00 0x0a>;
>  	};
>  	die_temp: adc-channel@b {
> -		reg = <0x0b>;
> +		reg = <0x00 0x0b>;
>  	};
>  	ref_625mv: adc-channel@c {
> -		reg = <0x0c>;
> +		reg = <0x00 0x0c>;
>  	};
>  	ref_1250mv: adc-channel@d {
> -		reg = <0x0d>;
> +		reg = <0x00 0x0d>;
>  	};
>  	ref_325mv: adc-channel@e {
> -		reg = <0x0e>;
> +		reg = <0x00 0x0e>;
>  	};
>  	ref_muxoff: adc-channel@f {
> -		reg = <0x0f>;
> +		reg = <0x00 0x0f>;
>  	};
>  };
>  
> -
>  /* IIO client node */
>  iio-hwmon {
>  	compatible = "iio-hwmon";
> -	io-channels = <&xoadc 0x01>, /* Battery */
> -		    <&xoadc 0x02>, /* DC in (charger) */
> -		    <&xoadc 0x04>, /* VPH the main system voltage */
> -		    <&xoadc 0x0b>, /* Die temperature */
> -		    <&xoadc 0x0c>, /* Reference voltage 1.25V */
> -		    <&xoadc 0x0d>, /* Reference voltage 0.625V */
> -		    <&xoadc 0x0e>; /* Reference voltage 0.325V */
> +	io-channels = <&xoadc 0x00 0x01>, /* Battery */
> +		    <&xoadc 0x00 0x02>, /* DC in (charger) */
> +		    <&xoadc 0x00 0x04>, /* VPH the main system voltage */
> +		    <&xoadc 0x00 0x0b>, /* Die temperature */
> +		    <&xoadc 0x00 0x0c>, /* Reference voltage 1.25V */
> +		    <&xoadc 0x00 0x0d>, /* Reference voltage 0.625V */
> +		    <&xoadc 0x00 0x0e>; /* Reference voltage 0.325V */
>  };
> 

