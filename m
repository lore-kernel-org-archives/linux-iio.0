Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42372 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbbCILD3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 07:03:29 -0400
Message-ID: <54FD7DFF.4020003@kernel.org>
Date: Mon, 09 Mar 2015 11:03:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	linux-iio@vger.kernel.org
CC: devicetree@vger.kernel.org
Subject: Re: [PATCH] iio: ti-adc128s052: Add DT binding documentation
References: <1425821818-28862-1-git-send-email-angelo.compagnucci@gmail.com>
In-Reply-To: <1425821818-28862-1-git-send-email-angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/03/15 13:36, Angelo Compagnucci wrote:
> Adding binding documentation for Texas Instruments' ADC128S052 ADC chip.
> 
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Applied to the togreg branch of iio.git.

Thanks

Jonathan
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

