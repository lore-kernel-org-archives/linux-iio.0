Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55814 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932879AbcCQO6m (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 17 Mar 2016 10:58:42 -0400
Date: Thu, 17 Mar 2016 09:58:37 -0500
From: Rob Herring <robh@kernel.org>
To: michael.hennerich@analog.com
Cc: jic23@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com,
	lars@metafoo.de, knaack.h@gmx.de, paul.cercueil@analog.com,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4] iio: dac: Add support for the AD5592R/AD5593R
 ADCs/DACs
Message-ID: <20160317145837.GA24226@rob-hp-laptop>
References: <1457354915-30831-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457354915-30831-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 07, 2016 at 01:48:35PM +0100, michael.hennerich@analog.com wrote:
> From: Paul Cercueil <paul.cercueil@analog.com>
> 
> This patch adds support for the AD5592R (spi) and AD5593R (i2c)
> ADC/DAC devices.
> 
> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
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
> ---
>  .../devicetree/bindings/iio/dac/ad5592r.txt        | 143 +++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/dac/Kconfig                            |  27 +
>  drivers/iio/dac/Makefile                           |   3 +
>  drivers/iio/dac/ad5592r-base.c                     | 702 +++++++++++++++++++++
>  drivers/iio/dac/ad5592r-base.h                     |  78 +++
>  drivers/iio/dac/ad5592r.c                          | 164 +++++
>  drivers/iio/dac/ad5593r.c                          | 131 ++++
>  include/dt-bindings/iio/adi,ad5592r.h              |  16 +
>  8 files changed, 1264 insertions(+)

