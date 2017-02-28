Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34199 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdB1BUS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 20:20:18 -0500
Date: Mon, 27 Feb 2017 19:19:29 -0600
From: Rob Herring <robh@kernel.org>
To: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, dmitry.torokhov@gmail.com,
        michael.hennerich@analog.com, daniel.baluta@gmail.com,
        amsfield22@gmail.com, florian.vaussard@heig-vd.ch,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/4] Documentation: dt-bindings: Document ADXL345
 accelerometer binding
Message-ID: <20170228011929.toyt5k7ef55gwxln@rob-hp-laptop>
References: <cover.1488115521.git.eraretuya@gmail.com>
 <08bd2344767d06cb6e7ad7f419f50777e238e5d4.1488115521.git.eraretuya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <08bd2344767d06cb6e7ad7f419f50777e238e5d4.1488115521.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Feb 26, 2017 at 09:45:04PM +0800, Eva Rachel Retuya wrote:
> Add the device tree binding documentation for the ADXL345 3-axis digital
> accelerometer.

Use "dt-bindings: iio: accel: ..." for the subject prefix.

> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> ---
>  .../devicetree/bindings/iio/accel/adxl345.txt      | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl345.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adxl345.txt b/Documentation/devicetree/bindings/iio/accel/adxl345.txt
> new file mode 100644
> index 0000000..e623f4a
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
> +	adxl345@2a {

accelerometer@2a

> +		compatible = "adi,adxl345";
> +		reg = <0x53>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +Example for a SPI device node:
> +
> +	adxl345@0 {

Same here.

> +		compatible = "adi,adxl345";
> +		reg = <0>;
> +		spi-max-frequency = <5000000>;
> +		spi-cpol;
> +		spi-cpha;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> -- 
> 2.7.4
> 
