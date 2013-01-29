Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:35177 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751155Ab3A2Vnz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Jan 2013 16:43:55 -0500
Message-ID: <510842F4.1020008@metafoo.de>
Date: Tue, 29 Jan 2013 22:45:24 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis Ciocca <denis.ciocca@gmail.com>
CC: jic23@kernel.org, linux-iio@vger.kernel.org,
	Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH 1/4] iio:common: Add STMicroelectronics common library
References: <1359157488-15969-1-git-send-email-denis.ciocca@st.com> <1359157488-15969-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1359157488-15969-2-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

here is one of the rough edges I was talking about earlier.

On 01/26/2013 12:44 AM, Denis Ciocca wrote:

> +int st_sensors_get_sampling_frequency_avl(struct iio_dev *indio_dev, char *buf)
> +{
> +	int i, len = 0;
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
> +
> +	return len;
> +}
> +EXPORT_SYMBOL(st_sensors_get_sampling_frequency_avl);

This function is no longer used outside the st_sensors core module, so there is
no need to export it anymore. In fact it is only used in
st_sensors_sysfs_sampling_frequency_avail, which itself is not more than the
call to st_sensors_get_sampling_frequency_avl, so I'd just move the contents of
st_sensors_get_sampling_frequency_avl to st_sensors_sysfs_sampling_frequency_avail.

> +
> +int st_sensors_get_scale_avl(struct iio_dev *indio_dev, char *buf)
> +{
> +	int i, len = 0;
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
> +
> +	return len;
> +}
> +EXPORT_SYMBOL(st_sensors_get_scale_avl);

Similar here.


> +
[...]

