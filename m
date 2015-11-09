Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42279 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbbKIP6F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 9 Nov 2015 10:58:05 -0500
Date: Mon, 9 Nov 2015 09:57:59 -0600
From: Rob Herring <robh@kernel.org>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: ti-ads8688: Add DT binding documentation
Message-ID: <20151109155759.GA23092@rob-hp-laptop>
References: <1447073580-17889-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1447073580-17889-2-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1447073580-17889-2-git-send-email-sean.nyekjaer@prevas.dk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Nov 09, 2015 at 01:53:00PM +0100, Sean Nyekjaer wrote:
> Adding binding documentation for Texas Instruments ADS8688 ADC.
> 
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> Reviewed-by: Martin Hundebøll <martin.hundeboll@prevas.dk>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> Changes since v2:
> - Moved vref-supply to Optional properties
> 
>  .../devicetree/bindings/iio/adc/ti-ads8688.txt       | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
> new file mode 100644
> index 0000000..a02337d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
> @@ -0,0 +1,20 @@
> +* Texas Instruments' ADS8684 and ADS8688 ADC chip
> +
> +Required properties:
> + - compatible: Should be "ti,ads8684" or "ti,ads8688"
> + - reg: spi chip select number for the device
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Optional properties:
> + - vref-supply: The regulator supply for ADC reference voltage
> +
> +Example:
> +adc@0 {
> +	compatible = "ti,ads8688";
> +	reg = <0>;
> +	vref-supply = <&vdd_supply>;
> +	spi-max-frequency = <1000000>;
> +};
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
