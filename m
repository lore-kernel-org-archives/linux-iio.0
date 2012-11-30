Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56981 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757384Ab2K3NMa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Nov 2012 08:12:30 -0500
Message-ID: <50B8B0BD.4010609@kernel.org>
Date: Fri, 30 Nov 2012 13:12:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Wei Yongjun <weiyj.lk@gmail.com>
CC: jic23@cam.ac.uk, yongjun_wei@trendmicro.com.cn,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH -next] iio: gyro: adis16136: remove duplicated include
 from adis16136.c
References: <CAPgLHd_faAe1PsFWX9pF91YCZ8p37b39JJ8sP7bFDX0JhODm1A@mail.gmail.com>
In-Reply-To: <CAPgLHd_faAe1PsFWX9pF91YCZ8p37b39JJ8sP7bFDX0JhODm1A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/29/2012 02:27 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove duplicated include.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
added to togreg branch of

git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Thanks
> ---
>  drivers/iio/gyro/adis16136.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
> index 05486df..4d60643 100644
> --- a/drivers/iio/gyro/adis16136.c
> +++ b/drivers/iio/gyro/adis16136.c
> @@ -22,7 +22,6 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
> -#include <linux/iio/iio.h>
>  #include <linux/debugfs.h>
>  
>  #define ADIS16136_REG_FLASH_CNT		0x00
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
