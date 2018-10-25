Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39477 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeJZDRY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Oct 2018 23:17:24 -0400
Date: Thu, 25 Oct 2018 13:43:26 -0500
From: Rob Herring <robh@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: jic23@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: Add docs for AD7606 ADC
Message-ID: <20181025184326.GA9995@bogus>
References: <1539853956-26644-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1539853956-26644-1-git-send-email-stefan.popa@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Oct 18, 2018 at 12:12:36PM +0300, Stefan Popa wrote:
> Document support for AD7606 Analog to Digital Converter.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.txt     | 51 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> new file mode 100644
> index 0000000..dede581
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> @@ -0,0 +1,51 @@
> +Analog Devices AD7606 Simultaneous Sampling ADC
> +
> +Required properties for the AD7606:
> +
> + - compatible: Must be one of "adi,ad7605-4", "adi,ad7606-8", "adi,ad7606-6" or
> + 	       "adi,ad7606-4".

Format as one per line please.

> + - reg: SPI chip select number for the device
> + - spi-max-frequency: Max SPI frequency to use
> + 	see: Documentation/devicetree/bindings/spi/spi-bus.txt
> + - spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
> + - avcc-supply: phandle to the Avcc power supply
> + - interrupts: IRQ line for the ADC
> + 	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> + - conversion-start-gpio: must be the device tree identifier of the CONVST pin.
> +			  This logic input is used to initiate conversions on
> +			  the analog input channels.

Doesn't IIO have trigger GPIOs?

> +
> +Optional properties:
> +
> + - reset-gpio: must be the device tree identifier of the RESET pin. If specified,
> + 	       it will be asserted during driver probe.

-gpios is the preferred form: reset-gpios

And state the active state

> + - first-data-gpio: must be the device tree identifier of the FRSTDATA pin.
> + 		    The FRSTDATA output indicates when the first channel, V1, is
> +		    being read back on either the parallel, byte or serial interface.
> +- standby-gpio: must be the device tree identifier of the STBY pin. This pin is used
> +		to place the AD7606 into one of two power-down modes, Standby mode or
> +		Shutdown mode.
> +- range-gpio: must be the device tree identifier of the RANGE pin. The polarity on
> +	      this pin determines the input range of the analog input channels. If
> +	      this pin is tied to a logic high, the analog input range is ±10V for
> +	      allchannels. If this pin is tied to a logic low, the analog input range

s/allchannels/all channels/

> +	      is ±5V for all channels.

conversion-start-gpio, first-data-gpio, and range-gpio should all have 
vendor prefix (in addition to -gpios).

> +
> +Example:
> +
> +	adc@0 {
> +		compatible = "adi,ad7606-8";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +		spi-cpol;
> +
> +		avcc-supply = <&adc_vref>;
> +
> +		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-parent = <&gpio>;
> +
> +		conversion-start-gpio = <&gpio 17 0>;
> +		reset-gpio = <&gpio 27 0>;
> +		first-data-gpio = <&gpio 22 0>;
> +		standby-gpio = <&gpio 24 0>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 843545d..6d63db4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/adc/ad7606.c
> +F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
>  
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
> -- 
> 2.7.4
> 
