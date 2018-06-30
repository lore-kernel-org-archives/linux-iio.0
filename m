Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751114AbeF3PyO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Jun 2018 11:54:14 -0400
Date: Sat, 30 Jun 2018 16:54:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mchehab@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
        <rdunlap@infradead.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Message-ID: <20180630165407.2a878dbd@archlinux>
In-Reply-To: <1530261550-21224-1-git-send-email-stefan.popa@analog.com>
References: <1530261550-21224-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 29 Jun 2018 11:39:10 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
One minor inline. =20

We could look at making some of these properties generic
(slew-time for example) but I'm not sure we fully understand
the 'space' yet to know exactly how this could be described
for all devices.  Hence perhaps best to leave it as it is for now.

Jonathan

> ---
> Changes in v4:
> 	- Nothing changed, just to follow the patch set version.
> Changes in v3:
> 	- AD5758 can be both a current and voltage output DAC. The
> 	  decision is made based on the DT and the channel type is set
> 	  during probe.
> 	- range was replaced by range-microvolt and range-microamp
> 	- dc-dc-mode, range-microvolt and range-microamp are required
> 	  properties.
> 	- Introduced a slew-time-us property from which slew rate clock
> 	  and slew rate step are calculated using a best match algorithm.
> 	- Added units in the name of the properties.
> 	- Offered more explanation for the various modes of operation.
>=20
> Changes in v2:
> 	- Nothing changed, just to follow the patch set version.
>=20
>  .../devicetree/bindings/iio/dac/ad5758.txt         | 73 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/ad5758.txt b/Docum=
entation/devicetree/bindings/iio/dac/ad5758.txt
> new file mode 100644
> index 0000000..797df9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
> @@ -0,0 +1,73 @@
> +Analog Devices AD5758 DAC device driver
> +
> +Required properties for the AD5758:
> +	- compatible: Must be "adi,ad5758"
> +	- reg: SPI chip select number for the device
> +	- spi-max-frequency: Max SPI frequency to use (< 50000000)
> +	- spi-cpha: is the only mode that is supported
> +
> +Required properties:
> +
> + - adi,dc-dc-mode: Mode of operation of the dc-to-dc converter
> + 		   Dynamic Power Control (DPC)
> +		   In this mode, the AD5758 circuitry senses the output voltage and
> +		   dynamically regulates the supply voltage, VDPC+, to meet compliance
> +		   requirements plus an optimized headroom voltage for the output buff=
er.
> +
> +		   Programmable Power Control (PPC)
> +		   In this mode, the VDPC+ voltage is user-programmable to a fixed lev=
el
> +		   that needs to accommodate the maximum output load required.
> +
> +		   The output of the DAC core is either converted to a current or volt=
age
> +		   output at the VIOUT pin. Only one mode can be enabled at any one ti=
me.
> +
> +		   The following values are currently supported:
> +			* 1: DPC current mode
> +			* 2: DPC voltage mode
> +			* 3: PPC current mode
> +
> + Depending on the selected output mode (voltage or current) one of the t=
wo properties must
> + be present:
> +
> + - adi,range-microvolt: Voltage output range
> + 		The array of voltage output ranges must contain two fields:
> +	      	* <0 5000000>: 0 V to 5 V voltage range
> +		* <0 10000000>: 0 V to 10 V voltage range
> +		* <(-5000000) 5000000>: =C2=B15 V voltage range
> +		* <(-10000000) 10000000>: =C2=B110 V voltage range
> + - adi,range-microamp: Current output range
> + 		The array of current output ranges must contain two fields:
> +		* <0 20000>: 0 mA to 20 mA current range
> +		* <0 24000>: 0 mA to 24 mA current range
> +		* <4 24000>: 4 mA to 20 mA current range
> +		* <(-20000) 20000>: =C2=B120 mA current range
> +		* <(-24000) 24000>: =C2=B124 mA current range
> +		* <(-1000) 22000>: =E2=88=921 mA to +22 mA current range
> +
> +Optional properties:
> +
> + - adi,dc-dc-ilim-microamp: The dc-to-dc converter current limit
> +		   The following values are currently supported [uA]:
> +		   	* 150000
> +			* 200000
> +			* 250000
> +			* 300000
> +			* 350000
> +			* 400000
> +
> + - adi,slew-time-us: The time it takes for the output to reach the full =
scale [uS]
> + 		     The supported range is between 133us up to 1023984375us
> +
> +AD5758 Example:
> +
> +	ad5758@0 {

Node names should be generic - now we don't have dac in the device tree
spec but it feels like the right choice rather than the part number.
https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.2

> +		compatible =3D "adi,ad5758";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <1000000>;
> +		spi-cpha;
> +
> +		adi,dc-dc-mode =3D <2>;
> +		adi,range-microvolt =3D <0 10000000>;
> +		adi,dc-dc-ilim-microamp =3D <200000>;
> +		adi,slew-time-us =3D <125000>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12d102d..60b1028 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -802,6 +802,7 @@ L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/dac/ad5758.c
> +F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
> =20
>  ANALOG DEVICES INC AD5686 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>

