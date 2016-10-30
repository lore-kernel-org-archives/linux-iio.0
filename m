Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42924 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932858AbcJ3Qtf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 12:49:35 -0400
Subject: Re: [PATCH] iio: st_sensors: fix scale configuration for h3lis331dl
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <1477429658-27590-1-git-send-email-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e00b6e06-2e27-ad29-e61a-8e2ffbdab710@kernel.org>
Date: Sun, 30 Oct 2016 16:49:32 +0000
MIME-Version: 1.0
In-Reply-To: <1477429658-27590-1-git-send-email-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/10/16 22:07, Lorenzo Bianconi wrote:
> fix scale configuration/parsing for h3lis331dl accel driver
> when sensitivity is higher than 1(m/s^2)/digit
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Ideally would have had a fixes tag (I added one hopefully to
the right patch ;)

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/st_accel_core.c               | 12 ++++++++----
>  drivers/iio/common/st_sensors/st_sensors_core.c |  8 +++++---
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index da3fb06..ce69048 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -743,8 +743,8 @@ static int st_accel_read_raw(struct iio_dev *indio_dev,
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = 0;
> -		*val2 = adata->current_fullscale->gain;
> +		*val = adata->current_fullscale->gain / 1000000;
> +		*val2 = adata->current_fullscale->gain % 1000000;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*val = adata->odr;
> @@ -763,9 +763,13 @@ static int st_accel_write_raw(struct iio_dev *indio_dev,
>  	int err;
>  
>  	switch (mask) {
> -	case IIO_CHAN_INFO_SCALE:
> -		err = st_sensors_set_fullscale_by_gain(indio_dev, val2);
> +	case IIO_CHAN_INFO_SCALE: {
> +		int gain;
> +
> +		gain = val * 1000000 + val2;
> +		err = st_sensors_set_fullscale_by_gain(indio_dev, gain);
>  		break;
> +	}
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (val2)
>  			return -EINVAL;
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 285a64a..975a1f1 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -612,7 +612,7 @@ EXPORT_SYMBOL(st_sensors_sysfs_sampling_frequency_avail);
>  ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> -	int i, len = 0;
> +	int i, len = 0, q, r;
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
> @@ -621,8 +621,10 @@ ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
>  		if (sdata->sensor_settings->fs.fs_avl[i].num == 0)
>  			break;
>  
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
> -				sdata->sensor_settings->fs.fs_avl[i].gain);
> +		q = sdata->sensor_settings->fs.fs_avl[i].gain / 1000000;
> +		r = sdata->sensor_settings->fs.fs_avl[i].gain % 1000000;
> +
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%u.%06u ", q, r);
>  	}
>  	mutex_unlock(&indio_dev->mlock);
>  	buf[len - 1] = '\n';
> 

