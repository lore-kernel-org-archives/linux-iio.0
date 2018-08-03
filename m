Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729828AbeHCXVS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 3 Aug 2018 19:21:18 -0400
Date: Fri, 3 Aug 2018 22:23:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <broonie@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] dt-bindings: iio: accel: Add docs for ADXL372
Message-ID: <20180803222313.09f458a4@archlinux>
In-Reply-To: <1533301341-26560-3-git-send-email-stefan.popa@analog.com>
References: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
        <1533301341-26560-3-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 3 Aug 2018 16:02:17 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> Add the device tree binding documentation for the ADXL372 3-axis digital
> accelerometer.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../devicetree/bindings/iio/accel/adxl372.txt      | 24 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> new file mode 100644
> index 0000000..41493d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> @@ -0,0 +1,24 @@
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
> + - interrupt-parent : phandle to the parent interrupt controller as documented
> +   in Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

General convention, IIRC, is to not bother adding interrupt-parent as it is clear
from the reference you give for interrupts.

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

