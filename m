Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:50905 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933179Ab3BSXDF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Feb 2013 18:03:05 -0500
Received: from mailout-de.gmx.net ([10.1.76.17]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0M9tl0-1U1Nh20dMu-00B4nr for
 <linux-iio@vger.kernel.org>; Wed, 20 Feb 2013 00:03:04 +0100
Message-ID: <512404A4.1010200@gmx.de>
Date: Wed, 20 Feb 2013 00:03:00 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/9] hwmon: (adt7410) Clear unwanted bits in the config
 register
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lars-Peter Clausen schrieb:
> Make sure to clear the mode bits from the config register before setting the new
> mode. Otherwise we might end up with a different mode than we want to.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/hwmon/adt7410.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> index 797c2b8..4ccee4f 100644
> --- a/drivers/hwmon/adt7410.c
> +++ b/drivers/hwmon/adt7410.c
> @@ -364,6 +364,7 @@ static int adt7410_probe(struct i2c_client *client,
>  	/*
>  	 * Set to 16 bit resolution, continous conversion and comparator mode.
>  	 */
> +	ret &= ~ADT7410_MODE_MASK;
>  	data->config = ret | ADT7410_FULL | ADT7410_RESOLUTION |
>  			ADT7410_EVENT_MODE;
>  	if (data->config != data->oldconfig) {

