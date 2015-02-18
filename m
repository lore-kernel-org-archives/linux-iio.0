Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:20664 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbbBRLUU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Feb 2015 06:20:20 -0500
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Message-id: <54E47571.7060904@samsung.com>
Date: Wed, 18 Feb 2015 12:20:17 +0100
From: Karol Wrona <k.wrona@samsung.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma9551: Protect PM-only functions by #ifdef
 CONFIG_PM_SLEEP
References: <1424256432-20808-1-git-send-email-geert@linux-m68k.org>
In-reply-to: <1424256432-20808-1-git-send-email-geert@linux-m68k.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/18/2015 11:47 AM, Geert Uytterhoeven wrote:
> If CONFIG_PM_SLEEP=n:
> 
>     drivers/iio/common/ssp_sensors/ssp_dev.c:644: warning: ‘ssp_suspend’ defined but not used
>     drivers/iio/common/ssp_sensors/ssp_dev.c:669: warning: ‘ssp_resume’ defined but not used
> 
> Protect the unused functions by #ifdef CONFIG_PM_SLEEP to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/iio/common/ssp_sensors/ssp_dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index 52d70435f5a11c55..55a90082a29bd484 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -640,6 +640,7 @@ static int ssp_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
>  static int ssp_suspend(struct device *dev)
>  {
>  	int ret;
> @@ -688,6 +689,7 @@ static int ssp_resume(struct device *dev)
>  
>  	return 0;
>  }
> +#endif /* CONFIG_PM_SLEEP */
>  
>  static const struct dev_pm_ops ssp_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(ssp_suspend, ssp_resume)
> 

Patch is ok but commit title points to different driver.  Irina would be
surprised and confused to see it on the list and log.

Please, use something like that: iio: common: ssp_sensors: Fix warnings ...

Thanks,
Karol

