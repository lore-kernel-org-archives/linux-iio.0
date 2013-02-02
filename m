Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43497 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661Ab3BBKGE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2013 05:06:04 -0500
Message-ID: <510CE50A.1080703@kernel.org>
Date: Sat, 02 Feb 2013 10:06:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:common: removed unused functions outside st_sensors
 library
References: <1359537358-28899-1-git-send-email-denis.ciocca@st.com> <1359537358-28899-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1359537358-28899-2-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/30/2013 09:15 AM, Denis CIOCCA wrote:
> This patch remove st_sensors_get_sampling_frequency_avl and st_sensors_get_scale_avl functions used only in st_sensors_sysfs_sampling_frequency_avail and st_sensors_sysfs_scale_avail sysfs functions.

I added your sign off to this on the assumption it was intended and
applied to togreg branch of iio.git

> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c |   70 +++++++++--------------
>  include/linux/iio/common/st_sensors.h           |    4 --
>  2 files changed, 28 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index fba6d68..0198324 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -38,46 +38,6 @@ st_sensors_write_data_with_mask_error:
>  	return err;
>  }
>  
> -int st_sensors_get_sampling_frequency_avl(struct iio_dev *indio_dev, char *buf)
> -{
> -	int i, len = 0;
> -	struct st_sensor_data *sdata = iio_priv(indio_dev);
> -
> -	mutex_lock(&indio_dev->mlock);
> -	for (i = 0; i < ST_SENSORS_ODR_LIST_MAX; i++) {
> -		if (sdata->sensor->odr.odr_avl[i].hz == 0)
> -			break;
> -
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> -					sdata->sensor->odr.odr_avl[i].hz);
> -	}
> -	mutex_unlock(&indio_dev->mlock);
> -	buf[len - 1] = '\n';
> -
> -	return len;
> -}
> -EXPORT_SYMBOL(st_sensors_get_sampling_frequency_avl);
> -
> -int st_sensors_get_scale_avl(struct iio_dev *indio_dev, char *buf)
> -{
> -	int i, len = 0;
> -	struct st_sensor_data *sdata = iio_priv(indio_dev);
> -
> -	mutex_lock(&indio_dev->mlock);
> -	for (i = 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
> -		if (sdata->sensor->fs.fs_avl[i].num == 0)
> -			break;
> -
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
> -					sdata->sensor->fs.fs_avl[i].gain);
> -	}
> -	mutex_unlock(&indio_dev->mlock);
> -	buf[len - 1] = '\n';
> -
> -	return len;
> -}
> -EXPORT_SYMBOL(st_sensors_get_scale_avl);
> -
>  static int st_sensors_match_odr(struct st_sensors *sensor,
>  			unsigned int odr, struct st_sensor_odr_avl *odr_out)
>  {
> @@ -440,18 +400,44 @@ EXPORT_SYMBOL(st_sensors_sysfs_set_sampling_frequency);
>  ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> +	int i, len = 0;
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +
> +	mutex_lock(&indio_dev->mlock);
> +	for (i = 0; i < ST_SENSORS_ODR_LIST_MAX; i++) {
> +		if (sdata->sensor->odr.odr_avl[i].hz == 0)
> +			break;
> +
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> +					sdata->sensor->odr.odr_avl[i].hz);
> +	}
> +	mutex_unlock(&indio_dev->mlock);
> +	buf[len - 1] = '\n';
>  
> -	return st_sensors_get_sampling_frequency_avl(indio_dev, buf);
> +	return len;
>  }
>  EXPORT_SYMBOL(st_sensors_sysfs_sampling_frequency_avail);
>  
>  ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> +	int i, len = 0;
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +
> +	mutex_lock(&indio_dev->mlock);
> +	for (i = 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
> +		if (sdata->sensor->fs.fs_avl[i].num == 0)
> +			break;
> +
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
> +					sdata->sensor->fs.fs_avl[i].gain);
> +	}
> +	mutex_unlock(&indio_dev->mlock);
> +	buf[len - 1] = '\n';
>  
> -	return st_sensors_get_scale_avl(indio_dev, buf);
> +	return len;
>  }
>  EXPORT_SYMBOL(st_sensors_sysfs_scale_avail);
>  
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 3cc8571..c40fdf5 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -243,10 +243,6 @@ int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable);
>  
>  int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable);
>  
> -int st_sensors_get_sampling_frequency_avl(struct iio_dev *indio_dev, char *buf);
> -
> -int st_sensors_get_scale_avl(struct iio_dev *indio_dev, char *buf);
> -
>  int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr);
>  
>  int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable);
> 
