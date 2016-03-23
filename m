Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54388 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030AbcCWPP0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 23 Mar 2016 11:15:26 -0400
Date: Wed, 23 Mar 2016 10:15:20 -0500
From: Rob Herring <robh@kernel.org>
To: michael.hennerich@analog.com
Cc: jic23@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com,
	lars@metafoo.de, knaack.h@gmx.de, paul.cercueil@analog.com,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5] iio: dac: Add support for the AD5592R/AD5593R
 ADCs/DACs
Message-ID: <20160323151520.GA19229@rob-hp-laptop>
References: <1458721195-28915-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458721195-28915-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 23, 2016 at 09:19:55AM +0100, michael.hennerich@analog.com wrote:
> From: Paul Cercueil <paul.cercueil@analog.com>
> 
> This patch adds support for the AD5592R (spi) and AD5593R (i2c)
> ADC/DAC/GPIO devices.
> 
> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> 
> ---
> 
> Changes since v1:
> 	* Fix mutex usage
> 	* Remove unnecessary NULL pointer guards
> 	* Add comment explaining the invalid data read
> 	* AD5593R Remove surplus adc readback
> 
> Changes since v2:
> 	* Use child nodes to describe channels
> 	* Fix probe return and driver remove path
> 	* Move locking closer to where its used
> 	* Remove WARN_ON but return error
> 	* Remove OPEN DRAIN configuration option
> 
> Changes since v3:
> 	* Documentation: Add missing vendor prefixes in the examples
> 	* Minor function reordering in remove() to match the reverse of probe()
> 
> Changes since v4:
> 	* Documentation: Add missing gpio bindings
> 	* Kconfig: Select GPIOLIB and remove ifdefs in code
> 	* Remove surplus error check in ad5592r_gpio_request()
> 	* Add comment about reset magic
> ---
>  .../devicetree/bindings/iio/dac/ad5592r.txt        | 152 +++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/dac/Kconfig                            |  27 +
>  drivers/iio/dac/Makefile                           |   3 +
>  drivers/iio/dac/ad5592r-base.c                     | 694 +++++++++++++++++++++
>  drivers/iio/dac/ad5592r-base.h                     |  78 +++
>  drivers/iio/dac/ad5592r.c                          | 164 +++++
>  drivers/iio/dac/ad5593r.c                          | 131 ++++
>  include/dt-bindings/iio/adi,ad5592r.h              |  16 +
>  8 files changed, 1265 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5592r.txt
>  create mode 100644 drivers/iio/dac/ad5592r-base.c
>  create mode 100644 drivers/iio/dac/ad5592r-base.h
>  create mode 100644 drivers/iio/dac/ad5592r.c
>  create mode 100644 drivers/iio/dac/ad5593r.c
>  create mode 100644 include/dt-bindings/iio/adi,ad5592r.h
