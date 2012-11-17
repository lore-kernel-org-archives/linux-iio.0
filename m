Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44625 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab2KQKUl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 17 Nov 2012 05:20:41 -0500
Message-ID: <50A764F4.3040008@kernel.org>
Date: Sat, 17 Nov 2012 10:20:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Wei Yongjun <weiyj.lk@gmail.com>
CC: jic23@cam.ac.uk, gregkh@linuxfoundation.org,
	grant.likely@secretlab.ca, rob.herring@calxeda.com,
	yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH -next] iio: isl29018: fix to return error or 0 in isl29018_write_raw()
References: <CAPgLHd873xAvToL7reBbxmS-iEoJ9OqvjEoXf8RsG2esbTyo1A@mail.gmail.com>
In-Reply-To: <CAPgLHd873xAvToL7reBbxmS-iEoJ9OqvjEoXf8RsG2esbTyo1A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/08/2012 09:05 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> We had assigned the return value to 'ret' but ignored it when
> return from isl29018_write_raw(), it's better to return 'ret'
> instead of 0.
> 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
Thanks - merged to togreg branch of

git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git


> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/staging/iio/light/isl29018.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 3b03f6f..1d5b294 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -356,7 +356,7 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
>  	}
>  	mutex_unlock(&chip->lock);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int isl29018_read_raw(struct iio_dev *indio_dev,
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
