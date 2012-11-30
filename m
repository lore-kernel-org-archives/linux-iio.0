Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56993 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756702Ab2K3NMn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Nov 2012 08:12:43 -0500
Message-ID: <50B8B0CC.4000500@kernel.org>
Date: Fri, 30 Nov 2012 13:12:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Wei Yongjun <weiyj.lk@gmail.com>
CC: jic23@cam.ac.uk, yongjun_wei@trendmicro.com.cn,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH -next] iio: imu: adis16480: remove duplicated include
 from adis16480.c
References: <CAPgLHd-_56zxuFc4-SBEEED0q51xUyiaq7qkNQG=3som6imDuw@mail.gmail.com>
In-Reply-To: <CAPgLHd-_56zxuFc4-SBEEED0q51xUyiaq7qkNQG=3som6imDuw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/29/2012 02:27 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove duplicated include.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Added to togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git


> ---
>  drivers/iio/imu/adis16480.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index a080b35..3456d48 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -24,7 +24,6 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
> -#include <linux/iio/iio.h>
>  #include <linux/debugfs.h>
>  
>  #define ADIS16480_PAGE_SIZE 0x80
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
