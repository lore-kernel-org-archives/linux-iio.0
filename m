Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36912 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbbI0Ohz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 10:37:55 -0400
Subject: Re: [PATCHv2 2/2] iio: ti-ads868x: Add DT binding documentation
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>, linux-iio@vger.kernel.org
References: <1443162580-28293-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1443162580-28293-2-git-send-email-sean.nyekjaer@prevas.dk>
Cc: devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5607FF41.9030101@kernel.org>
Date: Sun, 27 Sep 2015 15:37:53 +0100
MIME-Version: 1.0
In-Reply-To: <1443162580-28293-2-git-send-email-sean.nyekjaer@prevas.dk>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/09/15 07:29, Sean Nyekjaer wrote:
> Adding binding documentation for Texas Instruments ADS868X ADC.
> 
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> Reviewed-by: Martin Hundebøll <martin.hundeboll@prevas.dk>
> ---
>  .../devicetree/bindings/iio/adc/ti-ads868x.txt         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads868x.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads868x.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads868x.txt
> new file mode 100644
> index 0000000..bc3c305
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-ads868x.txt
> @@ -0,0 +1,18 @@
> +* Texas Instruments' ADS8684 and ADS8688 ADC chip
> +
> +Required properties:
> + - compatible: Should be "ti,ads8684" or "ti,ads8688"
> + - reg: spi chip select number for the device
> + - vref-supply: The regulator supply for ADC reference voltage
In the driver it appears that this is optional rather than required.
Whether it is provided or not controls whether the external or internal
reference is used.
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +adc@0 {
> +	compatible = "ti,ads8688";
> +	reg = <0>;
> +	vref-supply = <&vdd_supply>;
> +	spi-max-frequency = <1000000>;
> +};
> 

