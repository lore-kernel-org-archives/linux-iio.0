Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59124 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175Ab3H1SnK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Aug 2013 14:43:10 -0400
Message-ID: <521E52CA.5010108@kernel.org>
Date: Wed, 28 Aug 2013 20:43:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Wei Yongjun <weiyj.lk@gmail.com>
CC: jic23@cam.ac.uk, grant.likely@linaro.org, rob.herring@calxeda.com,
	oleksandr.kozaruk@ti.com, gg@slimlogic.co.uk, balajitk@ti.com,
	yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH -next] iio: adc: twl6030-gpadc: fix error return code
 in twl6030_gpadc_read_raw()
References: <CAPgLHd_cnp+Gm8vSwhB+dmV+bk7Wz8Qh7VbJmY=KdrmfS55fNg@mail.gmail.com>
In-Reply-To: <CAPgLHd_cnp+Gm8vSwhB+dmV+bk7Wz8Qh7VbJmY=KdrmfS55fNg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/23/13 03:47, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return -EINTR in the error handling case instead
> of 0 (ret is assigned after goto, which has no effect),
> as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Thanks. Applied to the togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Given timing I might end up ripping this out to separate it from new
stuff.

Jonathan
> ---
>  drivers/iio/adc/twl6030-gpadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index a558516..0ea96c0 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -537,8 +537,8 @@ static int twl6030_gpadc_read_raw(struct iio_dev *indio_dev,
>  		ret = -ETIMEDOUT;
>  		goto err;
>  	} else if (timeout < 0) {
> -		goto err;
>  		ret = -EINTR;
> +		goto err;
>  	}
>  
>  	switch (mask) {
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
