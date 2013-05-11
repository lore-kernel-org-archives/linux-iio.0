Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49502 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955Ab3EKJur (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 May 2013 05:50:47 -0400
Message-ID: <518E1472.70907@kernel.org>
Date: Sat, 11 May 2013 10:50:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Wei Yongjun <weiyj.lk@gmail.com>
CC: gregkh@linuxfoundation.org, lars@metafoo.de, wfp5p@virginia.edu,
	pmeerw@pmeerw.net, yongjun_wei@trendmicro.com.cn,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging:iio:light:tsl2x7x: fix the error handling in
 tsl2x7x_probe()
References: <CAPgLHd-yecqmE_v5oawQ_K_7e-em=369G7VYjPi-v3bREnwWHA@mail.gmail.com>
In-Reply-To: <CAPgLHd-yecqmE_v5oawQ_K_7e-em=369G7VYjPi-v3bREnwWHA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/07/2013 12:51 PM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return -EINVAL in the i2c device found error handling
> case instead of 0, as done elsewhere in this function.
> And also correct the fail1 and fail2 lable to do the right thing.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Applied to fixes-togreg branch of iio.git
Thanks,
> ---
>  drivers/staging/iio/light/tsl2x7x_core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> index d060f25..c99f890 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -1869,6 +1869,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  		dev_info(&chip->client->dev,
>  				"%s: i2c device found does not match expected id\n",
>  				__func__);
> +		ret = -EINVAL;
>  		goto fail1;
>  	}
>  
> @@ -1907,7 +1908,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  		if (ret) {
>  			dev_err(&clientp->dev,
>  				"%s: irq request failed", __func__);
> -			goto fail2;
> +			goto fail1;
>  		}
>  	}
>  
> @@ -1920,17 +1921,17 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  	if (ret) {
>  		dev_err(&clientp->dev,
>  			"%s: iio registration failed\n", __func__);
> -		goto fail1;
> +		goto fail2;
>  	}
>  
>  	dev_info(&clientp->dev, "%s Light sensor found.\n", id->name);
>  
>  	return 0;
>  
> -fail1:
> +fail2:
>  	if (clientp->irq)
>  		free_irq(clientp->irq, indio_dev);
> -fail2:
> +fail1:
>  	iio_device_free(indio_dev);
>  
>  	return ret;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
