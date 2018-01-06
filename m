Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44862 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbeAFM4Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Jan 2018 07:56:16 -0500
Date: Sat, 6 Jan 2018 12:56:13 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <michael.hennerich@analog.com>
Subject: Re: [PATCH 2/2][V2] staging:iio:docs: add ad7192 doc to detail dt
 usage
Message-ID: <20180106125613.71a04a63@archlinux>
In-Reply-To: <20180105152826.12076-1-alexandru.ardelean@analog.com>
References: <20180105152826.12076-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 5 Jan 2018 17:28:26 +0200
<alexandru.ardelean@analog.com> wrote:

> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Always resend the whole series rather than just one patch.
The chances of me getting confused and merging the wrong
combination is way too high if you do it like this.


This needs a proper device tree binding doc.  Which will contain
descriptions of all those parameters and be ready to put under
Documentation/devicetree/bindings/iio

A random documentation file like this is not going to be found
by anyone so provides little value.

Also dt bindings docs are used in some formal checkers to
verify that everything is described as it should be.

Resulting document needs to be cc'd to the devicetree maintainers
as well.  This is particularly true when you are introducing
a whole load of new devicetree bindings as you are here.

Jonathan
> ---
>  drivers/staging/iio/Documentation/adc/ad7192.txt | 60 ++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 drivers/staging/iio/Documentation/adc/ad7192.txt
> 
> diff --git a/drivers/staging/iio/Documentation/adc/ad7192.txt b/drivers/staging/iio/Documentation/adc/ad7192.txt
> new file mode 100644
> index 000000000000..19efc0a9411c
> --- /dev/null
> +++ b/drivers/staging/iio/Documentation/adc/ad7192.txt
> @@ -0,0 +1,60 @@
> +Analog Devices AD719x ADC Driver
> +
> +1. Overview
> +
> +The driver is intended to work with all AD719x ADC chips
> +from Analog Devices (AD7190, AD7192, AD7193, AD7195).
> +
> +It's based on top of the AD Sigma Delta driver
> +
> +2. Device Tree Configuration
> +
> +Example for use on a Raspberry Pi with interrupt line
> +connected to PIN 25 on the GPIO:
> +
> +	adc_vref: fixedregulator@0 {
> +		reg = <0>;
> +
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +	};
> +
> +	ad7190@0 {
> +		compatible = "ad7190";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +		spi-cpol;
> +		spi-cpha;
> +
> +		#interrupt-cells = <2>;
> +		interrupts = <25 0x2>;
> +		interrupt-parent = <&gpio>;
> +		avdd-supply = <&adc_vref>;
> +
> +		adi,clock-source-select = /bits/ 8 <0>;
> +		adi,reference-voltage-mv = /bits/ 16 <3300>;
> +
> +		adi,refin2-pins-enable;
> +		adi,rejection-60-Hz-enable;
> +		adi,chop-enable;
> +		adi,buffer-enable;
> +		adi,burnout-currents-enable;
> +		adi,sinc3-filter-enable;
> +		adi,unipolar-enable;
> +	};
> +
> +Notes (about this example):
> +* be sure to replace `compatible = "ad7190";` with
> +  your actual chip model (ad7190, ad7192, ad7193, ad7195)
> +  in order to make sure it works correctly
> +* PIN 25 must also be connected also to the DOUT pin
> +  of the ADC (or MISO on the host)
> +* be sure to add the "/bits/" specifiers ; newer dtc versions
> +  specify the property type/size using this field,
> +  and the driver may not be able to find the property
> +* not all "adi,xxx" parameters are required ;
> +  see the datasheet to get an idea of what you need
> +

