Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35450 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbbCHMgZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 08:36:25 -0400
Message-ID: <54FC4248.3080100@kernel.org>
Date: Sun, 08 Mar 2015 12:36:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	devicetree@vger.kernel.org
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ti-adc128s052: Add DT binding documentation
References: <1424085712-22275-1-git-send-email-angelo.compagnucci@gmail.com>
In-Reply-To: <1424085712-22275-1-git-send-email-angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/02/15 11:21, Angelo Compagnucci wrote:
> Adding binding documentation for Texas Instruments' ADC128S052 ADC chip.
Patch is fine, but missing a signed-off-by line.
> ---
>  .../devicetree/bindings/iio/adc/ti-adc128s052.txt      | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> new file mode 100644
> index 0000000..c8d682b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> @@ -0,0 +1,18 @@
> +* Texas Instruments' ADC128S052 ADC chip
> +
> +Required properties:
> + - compatible: Should be "ti,adc128s052"
> + - reg: spi chip select number for the device
> + - vref-supply: The regulator supply for ADC reference voltage
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +adc@0 {
> +	compatible = "ti,adc128s052";
> +	reg = <0>;
> +	vref-supply = <&vdd_supply>;
> +	spi-max-frequency = <1000000>;
> +};
> 

