Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751751AbeEFSBv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 May 2018 14:01:51 -0400
Date: Sun, 6 May 2018 19:01:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        drew.paterson@ams.com
Subject: Re: [PATCH v2 02/11] staging: iio: tsl2x7x: add range checking to
 three sysfs attributes
Message-ID: <20180506190146.5317da10@archlinux>
In-Reply-To: <20180504025319.28953-3-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
        <20180504025319.28953-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  3 May 2018 22:53:10 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The sysfs attributes in_illuminance0_target_input,
> in_illuminance0_calibrate, and in_proximity0_calibrate did not have
> proper range checking in place so this patch adds the correct range
> checks.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 01bff4593640..b4d77f65ca12 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -814,15 +814,13 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	unsigned long value;
> +	u16 value;
>  	int ret;
>  
> -	if (kstrtoul(buf, 0, &value))
> +	if (kstrtou16(buf, 0, &value))
>  		return -EINVAL;
>  
> -	if (value)
> -		chip->settings.als_cal_target = value;
> -
> +	chip->settings.als_cal_target = value;
>  	ret = tsl2x7x_invoke_change(indio_dev);
>  	if (ret < 0)
>  		return ret;
> @@ -838,14 +836,12 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
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
> @@ -932,14 +928,12 @@ static ssize_t in_proximity0_calibrate_store(struct device *dev,
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

