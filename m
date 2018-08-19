Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeHSUPf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 16:15:35 -0400
Date: Sun, 19 Aug 2018 18:03:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <broonie@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/6] dt-bindings: iio: accel: Add docs for ADXL372
Message-ID: <20180819180322.2bbd3f0c@archlinux>
In-Reply-To: <1533890783-13456-3-git-send-email-stefan.popa@analog.com>
References: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
        <1533890783-13456-3-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 10 Aug 2018 11:46:19 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> Add the device tree binding documentation for the ADXL372 3-axis digital
> accelerometer.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/accel/adxl372.txt      | 22 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> new file mode 100644
> index 0000000..9409984
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> @@ -0,0 +1,22 @@
> +Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
> +
> +http://www.analog.com/media/en/technical-documentation/data-sheets/adxl372.pdf
> +
> +Required properties:
> + - compatible : should be "adi,adxl372"
> + - reg: SPI chip select number for the device
> + - spi-max-frequency: Max SPI frequency to use
> +
> +Optional properties:
> + - interrupts: interrupt mapping for IRQ as documented in
> +   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +
> +Example:
> +
> +	accelerometer@0 {
> +		compatible = "adi,adxl372";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +		interrupt-parent = <&gpio>;
> +		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ba47bb..c8dd09c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -548,6 +548,7 @@ M:	Stefan Popa <stefan.popa@analog.com>
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/accel/adxl372.c
> +F:	Documentation/devicetree/bindings/iio/accel/adxl372.txt
>  
>  AF9013 MEDIA DRIVER
>  M:	Antti Palosaari <crope@iki.fi>
