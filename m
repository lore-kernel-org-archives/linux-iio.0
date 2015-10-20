Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-200.synserver.de ([212.40.185.200]:1054 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752897AbbJTIF3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Oct 2015 04:05:29 -0400
Message-ID: <5625F5C4.7020200@metafoo.de>
Date: Tue, 20 Oct 2015 10:05:24 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Joachim Eastwood <manabian@gmail.com>, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net
CC: martink@posteo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: add Freescale MMA7455L/MMA7456L 3-axis
 accelerometer driver
References: <1445120719-29685-1-git-send-email-manabian@gmail.com> <1445281210-3936-1-git-send-email-manabian@gmail.com>
In-Reply-To: <1445281210-3936-1-git-send-email-manabian@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/19/2015 09:00 PM, Joachim Eastwood wrote:
[...]
> +config MMA7455
> +	tristate "Freescale MMA7455L/MMA7456L Accelerometer Driver"
> +	depends on I2C || SPI_MASTER
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select MMA7455_I2C if I2C
> +	select MMA7455_SPI if SPI

Ah, damm, I shouldn't have said bmg160 is a good example without actually
looking at its Kconfig entry. Only saw the C files and those looked good.

This is still problematic. The depends on clause allows this driver to be
built-in if either I2C is built-in or SPI_MASTER is built-in. And then the
respective I2C and SPI modules will also be selected as built-in even though
the I2C symbol is only selected as a module. So you now have built-in code
that tries to reference code that is only available as a module.

A better solution is to make the Kconfig entries for the I2C and SPI modules
user selectable and then let them select the main module.

> +	help
> +	  Say yes here to build support for the Freescale MMA7455L and
> +	  MMA7456L 3-axis accelerometer.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mma7455_i2c or mma7455_spi.
> +
> +config MMA7455_I2C
> +	tristate
> +	select REGMAP_I2C
> +
> +config MMA7455_SPI
> +	tristate
> +	select REGMAP_SPI
> +

