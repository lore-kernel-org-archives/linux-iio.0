Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:53812 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617AbaLSVxQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 19 Dec 2014 16:53:16 -0500
Message-ID: <54949E48.6010909@gmx.de>
Date: Fri, 19 Dec 2014 22:53:12 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ti-adc128s052: Add DT binding documentation
References: <1418839183-27819-1-git-send-email-angelo.compagnucci@gmail.com>
In-Reply-To: <1418839183-27819-1-git-send-email-angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Angelo Compagnucci schrieb am 17.12.2014 um 18:59:
> Adding binding documentation for Texas Instruments' ADC128S052 ADC chip.
Hi,
some thoughts inline.
> 
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/ti-adc128s052.txt      | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> new file mode 100644
> index 0000000..12132ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> @@ -0,0 +1,18 @@
> +* Texas Instruments' ADC128S052 ADC chip
> +
> +Required properties:
> +  - compatible: Should be "ti,adc128s052" 
> +  - reg: spi chip select number for the device
Use upper case for SPI?
> +  - vref-supply: The regulator supply ADC reference voltage.
Maybe: The regulator supplying ADC reference voltage.
> +
> +Recommended properties:
> +- spi-max-frequency: Definition as per
> +                     Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +adc@0 {
> +	compatible = "ti,adc128s052";
> +	reg = <0>;
> +        vref-supply = <&vdd_supply>;
> +	spi-max-frequency = <1000000>;
> +};
> 

