Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbeKYWdR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Nov 2018 17:33:17 -0500
Date: Sun, 25 Nov 2018 11:42:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: Add docs for AD7606 ADC
Message-ID: <20181125114217.2bf39cd1@archlinux>
In-Reply-To: <1542728677-25899-1-git-send-email-stefan.popa@analog.com>
References: <1542728677-25899-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 20 Nov 2018 17:44:37 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> Document support for AD7606 Analog to Digital Converter.
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
This looks good to me, but given my recent inability to pick up on the
subtle (and not so subtle) issues in DT patches, I'd like a review
from the DT side if possible. The first patch needs some additional
changes, but they probably don't effect the bindings.

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- fixed indentation issues.
> 	- used gpios instead of gpio.
> 	- added vendor prefix for conversion-start-gpios, first-data-gpios,
> 	and range-gpios.
>=20
>  .../devicetree/bindings/iio/adc/adi,ad7606.txt     | 54 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.=
txt
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b/D=
ocumentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> new file mode 100644
> index 0000000..02fae23
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> @@ -0,0 +1,54 @@
> +Analog Devices AD7606 Simultaneous Sampling ADC
> +
> +Required properties for the AD7606:
> +
> +- compatible: Must be one of
> +	* "adi,ad7605-4"
> +	* "adi,ad7606-8"
> +	* "adi,ad7606-6"
> +	* "adi,ad7606-4"
> +- reg: SPI chip select number for the device
> +- spi-max-frequency: Max SPI frequency to use
> +	see: Documentation/devicetree/bindings/spi/spi-bus.txt
> +- spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
> +- avcc-supply: phandle to the Avcc power supply
> +- interrupts: IRQ line for the ADC
> +	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.=
txt
> +- adi,conversion-start-gpios: must be the device tree identifier of the =
CONVST pin.
> +		  This logic input is used to initiate conversions on the analog
> +		  input channels.
> +
> +Optional properties:
> +
> +- reset-gpios: must be the device tree identifier of the RESET pin. If s=
pecified,
> +	       it will be asserted during driver probe.
> +- standby-gpios: must be the device tree identifier of the STBY pin. Thi=
s pin is used
> +		to place the AD7606 into one of two power-down modes, Standby mode or
> +		Shutdown mode.
> +- adi,first-data-gpios: must be the device tree identifier of the FRSTDA=
TA pin.
> +		    The FRSTDATA output indicates when the first channel, V1, is
> +		    being read back on either the parallel, byte or serial interface.
> +- adi,range-gpios: must be the device tree identifier of the RANGE pin. =
The polarity on
> +	      this pin determines the input range of the analog input channels.=
 If
> +	      this pin is tied to a logic high, the analog input range is =C2=
=B110V for
> +	      all channels. If this pin is tied to a logic low, the analog inpu=
t range
> +	      is =C2=B15V for all channels.
> +
> +Example:
> +
> +	adc@0 {
> +		compatible =3D "adi,ad7606-8";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <1000000>;
> +		spi-cpol;
> +
> +		avcc-supply =3D <&adc_vref>;
> +
> +		interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-parent =3D <&gpio>;
> +
> +		adi,conversion-start-gpios =3D <&gpio 17 0>;
> +		reset-gpios =3D <&gpio 27 0>;
> +		adi,first-data-gpios =3D <&gpio 22 0>;
> +		standby-gpios =3D <&gpio 24 0>;
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
> =20
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
