Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43471 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbcCLKb2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Mar 2016 05:31:28 -0500
Subject: Re: [PATCH v2 2/4] dt: document NXP LPC1850 ADC driver bindings
To: Joachim Eastwood <manabian@gmail.com>
References: <1457262795-20282-1-git-send-email-manabian@gmail.com>
 <1457262795-20282-3-git-send-email-manabian@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, robh+dt@kernel.org,
	devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E3EFFE.5000100@kernel.org>
Date: Sat, 12 Mar 2016 10:31:26 +0000
MIME-Version: 1.0
In-Reply-To: <1457262795-20282-3-git-send-email-manabian@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/03/16 11:13, Joachim Eastwood wrote:
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
As this is very standard, I'm happy to take it without a device
tree ack.  I can added an ack though if anyone wants to give one!

Jonathan
> ---
>  .../devicetree/bindings/iio/adc/lpc1850-adc.txt     | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/lpc1850-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/lpc1850-adc.txt b/Documentation/devicetree/bindings/iio/adc/lpc1850-adc.txt
> new file mode 100644
> index 000000000000..0bcae5140bc5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/lpc1850-adc.txt
> @@ -0,0 +1,21 @@
> +NXP LPC1850 ADC bindings
> +
> +Required properties:
> +- compatible: Should be "nxp,lpc1850-adc"
> +- reg: Offset and length of the register set for the ADC device
> +- interrupts: The interrupt number for the ADC device
> +- clocks: The root clock of the ADC controller
> +- vref-supply: The regulator supply ADC reference voltage
> +- resets: phandle to reset controller and line specifier
> +
> +Example:
> +
> +adc0: adc@400e3000 {
> +	compatible = "nxp,lpc1850-adc";
> +	reg = <0x400e3000 0x1000>;
> +	interrupts = <17>;
> +	clocks = <&ccu1 CLK_APB3_ADC0>;
> +	vref-supply = <&reg_vdda>;
> +	resets = <&rgu 40>;
> +	status = "disabled";
> +};
> 

