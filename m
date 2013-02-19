Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:58411 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932846Ab3BSXNT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Feb 2013 18:13:19 -0500
Received: from mailout-de.gmx.net ([10.1.76.12]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0Lqod2-1UmF0Z1qz4-00eP9l for
 <linux-iio@vger.kernel.org>; Wed, 20 Feb 2013 00:13:17 +0100
Message-ID: <5124070A.6080205@gmx.de>
Date: Wed, 20 Feb 2013 00:13:14 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/9] hwmon: (adt7410) Use the SIMPLE_DEV_PM_OPS helper
 macro
References: <1360947438-2550-1-git-send-email-lars@metafoo.de> <1360947438-2550-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lars-Peter Clausen schrieb:
> Use the SIMPLE_DEV_PM_OPS macro to declare the driver's pm_ops.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/hwmon/adt7410.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> index ae80815..4ae16e0 100644
> --- a/drivers/hwmon/adt7410.c
> +++ b/drivers/hwmon/adt7410.c
> @@ -437,10 +437,8 @@ static int adt7410_resume(struct device *dev)
>  	return ret;
>  }
>  
> -static const struct dev_pm_ops adt7410_dev_pm_ops = {
> -	.suspend	= adt7410_suspend,
> -	.resume		= adt7410_resume,
> -};
> +static SIMPLE_DEV_PM_OPS(adt7410_dev_pm_ops, adt7410_suspend, adt7410_resume);
> +
>  #define ADT7410_DEV_PM_OPS (&adt7410_dev_pm_ops)
>  #else
>  #define ADT7410_DEV_PM_OPS NULL

