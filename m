Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53225 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936614AbcJVP12 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 11:27:28 -0400
Subject: Re: [PATCH 04/13] staging:iio:ad7606: Remove out-of-band error
 reporting
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
 <1476896828-10544-5-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8ff1e01c-0700-5e75-6bbb-c14968089de3@kernel.org>
Date: Sat, 22 Oct 2016 16:27:27 +0100
MIME-Version: 1.0
In-Reply-To: <1476896828-10544-5-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/16 18:06, Lars-Peter Clausen wrote:
> Currently the ad7606 driver prints a error message to the kernel log when
> an application writes an invalid value to a sysfs attribute. While for
> initial driver development and testing this might be useful it is quite
> disadvantageous in a production environment. The write() call to the sysfs
> attribute will already return an error if the value was invalid so the
> application is aware that the operation failed. And generally speaking it
> is impossible for an application to reliably match a log message in the
> kernel log to a specific operation it performed, so the message becomes
> just noise and might distract from more critical messages.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7606_core.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
> index a16c6f5..d3a3551 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606_core.c
> @@ -132,10 +132,9 @@ static ssize_t ad7606_store_range(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	if (!(lval == 5000 || lval == 10000)) {
> -		dev_err(dev, "range is not supported\n");
> +	if (!(lval == 5000 || lval == 10000))
>  		return -EINVAL;
> -	}
> +
>  	mutex_lock(&indio_dev->mlock);
>  	gpio_set_value(st->pdata->gpio_range, lval == 10000);
>  	st->range = lval;
> @@ -174,11 +173,8 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  		if (val2)
>  			return -EINVAL;
>  		ret = ad7606_oversampling_get_index(val);
> -		if (ret < 0) {
> -			dev_err(st->dev, "oversampling %d is not supported\n",
> -				val);
> +		if (ret < 0)
>  			return ret;
> -		}
>  
>  		mutex_lock(&indio_dev->mlock);
>  		gpio_set_value(st->pdata->gpio_os0, (ret >> 0) & 1);
> 

