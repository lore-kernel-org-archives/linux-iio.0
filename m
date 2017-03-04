Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55710 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbdCDQu5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2017 11:50:57 -0500
Subject: Re: [PATCH v6 1/4] dt-bindings: iio: accel: Document ADXL345
 accelerometer binding
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org
References: <cover.1488615230.git.eraretuya@gmail.com>
 <8bdf46e166cc98c75f9ef73b5c6911ae97165da3.1488615230.git.eraretuya@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5b10adf0-647f-da2d-86b5-adcbaca218db@kernel.org>
Date: Sat, 4 Mar 2017 16:39:33 +0000
MIME-Version: 1.0
In-Reply-To: <8bdf46e166cc98c75f9ef73b5c6911ae97165da3.1488615230.git.eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/03/17 08:31, Eva Rachel Retuya wrote:
> Add the device tree binding documentation for the ADXL345 3-axis digital
> accelerometer.
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with.

Thanks,

Jonathan
> ---
> Change from v5:
> * Add Rob's Acked-by tag
> 
>  .../devicetree/bindings/iio/accel/adxl345.txt      | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl345.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adxl345.txt b/Documentation/devicetree/bindings/iio/accel/adxl345.txt
> new file mode 100644
> index 0000000..e7111b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adxl345.txt
> @@ -0,0 +1,38 @@
> +Analog Devices ADXL345 3-Axis, +/-(2g/4g/8g/16g) Digital Accelerometer
> +
> +http://www.analog.com/en/products/mems/accelerometers/adxl345.html
> +
> +Required properties:
> + - compatible : should be "adi,adxl345"
> + - reg : the I2C address or SPI chip select number of the sensor
> +
> +Required properties for SPI bus usage:
> + - spi-max-frequency : set maximum clock frequency, must be 5000000
> + - spi-cpol and spi-cpha : must be defined for adxl345 to enable SPI mode 3
> +
> +Optional properties:
> + - interrupt-parent : phandle to the parent interrupt controller as documented
> +   in Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> + - interrupts: interrupt mapping for IRQ as documented in
> +   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +
> +Example for a I2C device node:
> +
> +	accelerometer@2a {
> +		compatible = "adi,adxl345";
> +		reg = <0x53>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +Example for a SPI device node:
> +
> +	accelerometer@0 {
> +		compatible = "adi,adxl345";
> +		reg = <0>;
> +		spi-max-frequency = <5000000>;
> +		spi-cpol;
> +		spi-cpha;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> 

