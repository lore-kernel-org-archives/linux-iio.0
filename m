Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:46606 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbcGRLyG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2016 07:54:06 -0400
Subject: Re: [PATCH] iio: accel: add support for the Domintech DMARD09 3-axis
 accelerometer
To: Jelle van der Waa <jelle@vdwaa.nl>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20160716195152.30109-1-jelle@vdwaa.nl>
 <20160716195152.30109-2-jelle@vdwaa.nl>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <60b24be0-fb59-49b4-71c3-60e254043f86@metafoo.de>
Date: Mon, 18 Jul 2016 13:54:00 +0200
MIME-Version: 1.0
In-Reply-To: <20160716195152.30109-2-jelle@vdwaa.nl>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/16/2016 09:51 PM, Jelle van der Waa wrote:
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index e4a758c..3fb16eb 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -40,6 +40,16 @@ config BMC150_ACCEL_SPI
>  	tristate
>  	select REGMAP_SPI
>  
> +config DMARD09
> +	tristate "Domintech DMARD09 3-axis Accelerometer Driver"
> +	select I2C

This should be 'depends on I2C'. I2C is a feature that can be
enabled/disabled and only when enabled drivers which use I2C should be
available.

> +	help
> +	  Say yes here to get support for the Domintech DMARD09 3-axis
> +	  accelerometer.
> +
> +	  Choosing M will build the driver as a module. If so, the module
> +	  will be called dmard09.
> +

