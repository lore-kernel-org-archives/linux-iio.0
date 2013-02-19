Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:55952 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933194Ab3BSXRN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Feb 2013 18:17:13 -0500
Received: from mailout-de.gmx.net ([10.1.76.31]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MHJXh-1U4Pmd0n5v-00E1tP for
 <linux-iio@vger.kernel.org>; Wed, 20 Feb 2013 00:17:12 +0100
Message-ID: <512407F5.2050802@gmx.de>
Date: Wed, 20 Feb 2013 00:17:09 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/9] hwmon: (adt7410) Use I2C_ADDRS helper macro
References: <1360947438-2550-1-git-send-email-lars@metafoo.de> <1360947438-2550-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lars-Peter Clausen schrieb:
> Use the I2C_ADDRS macro to initialize the I2C device's address_list. Doing so
> saves a few lines of boilerplate code.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/hwmon/adt7410.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> index 4ae16e0..99f6d32 100644
> --- a/drivers/hwmon/adt7410.c
> +++ b/drivers/hwmon/adt7410.c
> @@ -78,10 +78,6 @@ enum adt7410_type {		/* keep sorted in alphabetical order */
>  	adt7410,
>  };
>  
> -/* Addresses scanned */
> -static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
> -					I2C_CLIENT_END };
> -
>  static const u8 ADT7410_REG_TEMP[4] = {
>  	ADT7410_TEMPERATURE,		/* input */
>  	ADT7410_T_ALARM_HIGH,		/* high */
> @@ -453,7 +449,7 @@ static struct i2c_driver adt7410_driver = {
>  	.probe		= adt7410_probe,
>  	.remove		= adt7410_remove,
>  	.id_table	= adt7410_ids,
> -	.address_list	= normal_i2c,
> +	.address_list	= I2C_ADDRS(0x48, 0x49, 0x4a, 0x4b),
>  };
>  
>  module_i2c_driver(adt7410_driver);

