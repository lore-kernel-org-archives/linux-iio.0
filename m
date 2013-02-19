Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:59629 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933422Ab3BSXWB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Feb 2013 18:22:01 -0500
Received: from mailout-de.gmx.net ([10.1.76.12]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0M38kj-1Uyg1A2k0V-00sytf for
 <linux-iio@vger.kernel.org>; Wed, 20 Feb 2013 00:21:59 +0100
Message-ID: <51240914.80206@gmx.de>
Date: Wed, 20 Feb 2013 00:21:56 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/9] hwmon: (adt7410) Add device table entry for the adt7420
References: <1360947438-2550-1-git-send-email-lars@metafoo.de> <1360947438-2550-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-5-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lars-Peter Clausen schrieb:
> The adt7420 is software compatible to the adt7410.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/hwmon/Kconfig   | 4 ++--
>  drivers/hwmon/adt7410.c | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 52d5174..89ac1cb 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -180,11 +180,11 @@ config SENSORS_ADM9240
>  	  will be called adm9240.
>  
>  config SENSORS_ADT7410
> -	tristate "Analog Devices ADT7410"
> +	tristate "Analog Devices ADT7410/ADT7420"
>  	depends on I2C
>  	help
>  	  If you say yes here you get support for the Analog Devices
> -	  ADT7410 temperature monitoring chip.
> +	  ADT7410 and ADT7420 temperature monitoring chips.
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called adt7410.
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> index 99f6d32..99a7290 100644
> --- a/drivers/hwmon/adt7410.c
> +++ b/drivers/hwmon/adt7410.c
> @@ -407,6 +407,7 @@ static int adt7410_remove(struct i2c_client *client)
>  
>  static const struct i2c_device_id adt7410_ids[] = {
>  	{ "adt7410", adt7410, },
> +	{ "adt7420", adt7410, },
>  	{ /* LIST END */ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adt7410_ids);
> @@ -455,5 +456,5 @@ static struct i2c_driver adt7410_driver = {
>  module_i2c_driver(adt7410_driver);
>  
>  MODULE_AUTHOR("Hartmut Knaack");
> -MODULE_DESCRIPTION("ADT7410 driver");
> +MODULE_DESCRIPTION("ADT7410/ADT7420 driver");
>  MODULE_LICENSE("GPL");

