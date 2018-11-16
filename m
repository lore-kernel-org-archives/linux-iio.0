Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389436AbeKQE5z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Nov 2018 23:57:55 -0500
Date: Fri, 16 Nov 2018 18:44:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] dt-bindings: iio: adc: Add docs for ad7124
Message-ID: <20181116184417.1259889b@archlinux>
In-Reply-To: <1542108138-3711-1-git-send-email-stefan.popa@analog.com>
References: <1542108138-3711-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 13 Nov 2018 13:22:18 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> Add support for Analog Devices AD7124 4-channels and 8-channels ADC.
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Looks good to me.  Will wait on that DT review of patch 2 (and perhaps
this one as well)

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- Nothing changed.
> Changes in v3:
> 	- Removed the "adi,channels" property.
> 	- Used the "reg" property to get the channel number and "adi,diff-channe=
ls"
> 	  for the differential pins. The "adi,channel-number" property was remov=
ed.
> 	- adi,bipolar is of boolean type.
> Changes in v4:
> 	- Used the bipolar and diff-channels properties defined in the new adc.t=
xt doc.
> Changes in v5:
> 	- Removed the gain and odr properties from the example.
>=20
>  .../devicetree/bindings/iio/adc/adi,ad7124.txt     | 75 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.=
txt
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt b/D=
ocumentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> new file mode 100644
> index 0000000..416273d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> @@ -0,0 +1,75 @@
> +Analog Devices AD7124 ADC device driver
> +
> +Required properties for the AD7124:
> +	- compatible: Must be one of "adi,ad7124-4" or "adi,ad7124-8"
> +	- reg: SPI chip select number for the device
> +	- spi-max-frequency: Max SPI frequency to use
> +		see: Documentation/devicetree/bindings/spi/spi-bus.txt
> +	- clocks: phandle to the master clock (mclk)
> +		see: Documentation/devicetree/bindings/clock/clock-bindings.txt
> +	- clock-names: Must be "mclk".
> +	- interrupts: IRQ line for the ADC
> +		see: Documentation/devicetree/bindings/interrupt-controller/interrupts=
.txt
> +
> +	  Required properties:
> +		* #address-cells: Must be 1.
> +		* #size-cells: Must be 0.
> +
> +	  Subnode(s) represent the external channels which are connected to the=
 ADC.
> +	  Each subnode represents one channel and has the following properties:
> +		Required properties:
> +			* reg: The channel number. It can have up to 4 channels on ad7124-4
> +			  and 8 channels on ad7124-8, numbered from 0 to 15.
> +			* diff-channels: see: Documentation/devicetree/bindings/iio/adc/adc.t=
xt
> +
> +		Optional properties:
> +			* bipolar: see: Documentation/devicetree/bindings/iio/adc/adc.txt
> +			* adi,reference-select: Select the reference source to use when
> +			  converting on the the specific channel. Valid values are:
> +			  0: REFIN1(+)/REFIN1(=E2=88=92).
> +			  1: REFIN2(+)/REFIN2(=E2=88=92).
> +			  3: AVDD
> +			  If this field is left empty, internal reference is selected.
> +
> +Optional properties:
> +	- refin1-supply: refin1 supply can be used as reference for conversion.
> +	- refin2-supply: refin2 supply can be used as reference for conversion.
> +	- avdd-supply: avdd supply can be used as reference for conversion.
> +
> +Example:
> +	adc@0 {
> +		compatible =3D "adi,ad7124-4";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <5000000>;
> +		interrupts =3D <25 2>;
> +		interrupt-parent =3D <&gpio>;
> +		refin1-supply =3D <&adc_vref>;
> +		clocks =3D <&ad7124_mclk>;
> +		clock-names =3D "mclk";
> +
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		channel@0 {
> +			reg =3D <0>;
> +			diff-channels =3D <0 1>;
> +			adi,reference-select =3D <0>;
> +		};
> +
> +		channel@1 {
> +			reg =3D <1>;
> +			bipolar;
> +			diff-channels =3D <2 3>;
> +			adi,reference-select =3D <0>;
> +		};
> +
> +		channel@2 {
> +			reg =3D <2>;
> +			diff-channels =3D <4 5>;
> +		};
> +
> +		channel@3 {
> +			reg =3D <3>;
> +			diff-channels =3D <6 7>;
> +		};
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a1bfcb..f2fa508 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/adc/ad7124.c
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> =20
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
