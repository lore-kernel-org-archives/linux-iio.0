Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:57437 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932846Ab3BSXHq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Feb 2013 18:07:46 -0500
Received: from mailout-de.gmx.net ([10.1.76.17]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0M0NrX-1V0JrR3K2P-00uduJ for
 <linux-iio@vger.kernel.org>; Wed, 20 Feb 2013 00:07:44 +0100
Message-ID: <512405BD.9030505@gmx.de>
Date: Wed, 20 Feb 2013 00:07:41 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/9] hwmon: (adt7410) Let suspend/resume depend on CONFIG_PM_SLEEP
References: <1360947438-2550-1-git-send-email-lars@metafoo.de> <1360947438-2550-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lars-Peter Clausen schrieb:
> Only build the suspend/resume code if CONFIG_PM_SLEEP is selected. Currently the
> code is built if CONFIG_PM is selected, but it will also be selected if only
> runtime PM support is built into the kernel.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/hwmon/adt7410.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> index 4ccee4f..ae80815 100644
> --- a/drivers/hwmon/adt7410.c
> +++ b/drivers/hwmon/adt7410.c
> @@ -415,7 +415,7 @@ static const struct i2c_device_id adt7410_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, adt7410_ids);
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int adt7410_suspend(struct device *dev)
>  {
>  	int ret;

