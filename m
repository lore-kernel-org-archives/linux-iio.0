Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34068 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755519AbcKJSzz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Nov 2016 13:55:55 -0500
Date: Thu, 10 Nov 2016 12:55:52 -0600
From: Rob Herring <robh@kernel.org>
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: DT: Add bmi160 imu binding
Message-ID: <20161110185552.ny5fdfmy24l2li2f@rob-hp-laptop>
References: <20161103112527.29623-1-m.niestroj@grinn-global.com>
 <20161103112527.29623-2-m.niestroj@grinn-global.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161103112527.29623-2-m.niestroj@grinn-global.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Nov 03, 2016 at 12:25:27PM +0100, Marcin Niestroj wrote:
> This adds documentation for Bosch BMI160 Inertial Measurement Unit
> device-tree bindings.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---
>  .../devicetree/bindings/iio/imu/bmi160.txt         | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> new file mode 100644
> index 0000000..b02ef3e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> @@ -0,0 +1,34 @@
> +Bosch BMI160 - Inertial Measurement Unit with Accelerometer, Gyroscope
> +and externally connectable Magnetometer
> +
> +https://www.bosch-sensortec.com/bst/products/all_products/bmi160
> +
> +Required properties:
> + - compatible : should be "bosch,bmi160"
> + - reg : the I2C address or SPI chip select number of the sensor
> + - spi-max-frequency : set maximum clock frequency (only for SPI)
> +
> +Optional properties:
> + - interrupt-parent : should be the phandle of the interrupt controller
> + - interrupts : interrupt mapping for GPIO IRQ, must be IRQ_TYPE_LEVEL_LOW

The fact that a GPIO is typically used is outside the scope of this doc.

> + - interrupt-names : set to "INT2" if using INT2 pin

Normally there's no point to have names property when there is a single 
interrupt. However, it seems this could be either INT1 or INT2 or both 
connected. You need to specify all the options.

Rob
