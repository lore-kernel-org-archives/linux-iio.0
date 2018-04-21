Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbeDUQbI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 12:31:08 -0400
Date: Sat, 21 Apr 2018 17:31:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 08/13] staging: iio: tsl2x7x: add range checking to
 three sysfs attributes
Message-ID: <20180421173103.07a73ffb@archlinux>
In-Reply-To: <20180421004153.19073-9-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
        <20180421004153.19073-9-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 20:41:48 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The sysfs attributes in_illuminance0_target_input,
> in_illuminance0_calibrate, and in_proximity0_calibrate did not have
> proper range checking in place so this patch adds the correct range
> checks.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Comment inline.


> ---
>  drivers/staging/iio/light/tsl2x7x.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 56730baea927..15bc0af1bb6c 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -835,9 +835,10 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
>  	if (kstrtoul(buf, 0, &value))
>  		return -EINVAL;
>  
> -	if (value)
> -		chip->settings.als_cal_target = value;
> +	if (value < 0 || value > 65535)
> +		return -ERANGE;
How about using kstrtou16 which does this check internally...

>  
> +	chip->settings.als_cal_target = value;
>  	ret = tsl2x7x_invoke_change(indio_dev);
>  	if (ret < 0)
>  		return ret;
> @@ -853,14 +854,12 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
>  	bool value;
>  	int ret;
>  
> -	if (strtobool(buf, &value))
> +	if (kstrtobool(buf, &value) || !value)
>  		return -EINVAL;
>  
> -	if (value) {
> -		ret = tsl2x7x_als_calibrate(indio_dev);
> -		if (ret < 0)
> -			return ret;
> -	}
> +	ret = tsl2x7x_als_calibrate(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = tsl2x7x_invoke_change(indio_dev);
>  	if (ret < 0)
> @@ -946,14 +945,12 @@ static ssize_t in_proximity0_calibrate_store(struct device *dev,
>  	bool value;
>  	int ret;
>  
> -	if (strtobool(buf, &value))
> +	if (kstrtobool(buf, &value) || !value)
>  		return -EINVAL;
>  
> -	if (value) {
> -		ret = tsl2x7x_prox_cal(indio_dev);
> -		if (ret < 0)
> -			return ret;
> -	}
> +	ret = tsl2x7x_prox_cal(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = tsl2x7x_invoke_change(indio_dev);
>  	if (ret < 0)

