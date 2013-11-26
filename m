Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:17336
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750786Ab3KZFFk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Nov 2013 00:05:40 -0500
Date: Tue, 26 Nov 2013 13:08:07 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Fugang Duan <B38611@freescale.com>
CC: <jic23@kernel.org>, <sachin.kamat@linaro.org>,
	<b20596@freescale.com>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] Documentation: add the binding file for Freescale
 vf610 ADC driver
Message-ID: <20131126050805.GL30476@S2101-09.ap.freescale.net>
References: <1385430172-16642-1-git-send-email-B38611@freescale.com>
 <1385430172-16642-4-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1385430172-16642-4-git-send-email-B38611@freescale.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 26, 2013 at 09:42:52AM +0800, Fugang Duan wrote:
> The patch adds the binding file for Freescale vf610 ADC driver.
> 
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> ---
>  .../devicetree/bindings/iio/adc/vf610-adc.txt      |   57 ++++++++++++++++++++
>  1 files changed, 57 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
> new file mode 100644
> index 0000000..df370c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
> @@ -0,0 +1,57 @@
> +Freescale vf610 Analog to Digital Converter bindings
> +
> +The devicetree bindings are for the new ADC driver written for
> +vf610/i.MX6slx and upward SoCs from Freescale.
> +
> +Required properties:
> +- compatible: Should be "fsl,vf610-adc"
> +  (* the future compatible expander for i.MX6slx, i.MX7 will be "fsl,imx-adc")

Drop this line.  You can extend the bindings when new compatible is
needed.

> +- reg: Offset and length of the register set for the device
> +- interrupts: Should contain the interrupt for the device
> +- clocks: The clocks needed by the ADC controller
> +- clock-names: the name of the clocks
> +
> +Optional properties:
> +- vf610,adc-io-pinctl: Enable field for the I/O port control of MCU pins used as analog inputs.

Use prefix "fsl," instead of "vf610,".

Shawn

> +- vf610,adc-vref: ADC refrence voltage value, unit is uV.
> +- vf610,adc-clk-div: Current clock divider value, such as 1,2,4,8,16 and so on.
> +- vf610,adc-res: ADC conversion mode selection, such as 8 for 8-bit, 10 for 10-bit, 12 for 12-bit mode.
> +- vf610,adc-sam-time: ADC sample time duration, number of ADC clocks, such as 2, 4, 6, 8, 12, 16, 20, 24
> +- vf610,adc-aver-sam-sel: Determines how many ADC conversions will be averaged to create the ADC average result.
> +			The Optional value is 4, 8, 16, 32.
> +- vf610,adc-hw-aver-en: Bool type to decide enable hardware average function.
> +- vf610,adc-low-power-mode: Bool type to decide enable ADC low power mode.
> +- vf610,adc-high-speed-conv: Bool type to decide enable ADC high speed mode.
> +
> +Example:
> +adc0: adc@4003b000 {
> +	compatible = "fsl,vf610-adc";
> +	reg = <0x4003b000 0x1000>;
> +	interrupts = <0 53 0x04>;
> +	clocks = <&clks VF610_CLK_ADC0>;
> +	clock-names = "adc";
> +	status = "disabled";
> +};
> +
> +adc1: adc@400bb000 {
> +	compatible = "fsl,vf610-adc";
> +	reg = <0x400bb000 0x1000>;
> +	interrupts = <0 54 0x04>;
> +	clocks = <&clks VF610_CLK_ADC1>;
> +	clock-names = "adc";
> +	status = "disabled";
> +};
> +
> +&adc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc0_ad5>;
> +	vf610,adc-io-pinctl = <0x20>;
> +	vf610,adc-vref = <3300000>;
> +	vf610,adc-clk-div = <2>;
> +	vf610,adc-res = <12>;
> +	vf610,adc-sam-time = <4>;
> +	vf610,adc-aver-sam-sel = <4>;
> +	vf610,adc-hw-aver-en;
> +	vf610,adc-low-power-mode;
> +	status = "okay";
> +};
> -- 
> 1.7.2.rc3
> 
> 

