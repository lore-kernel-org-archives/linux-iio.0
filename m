Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-145.synserver.de ([212.40.185.145]:1039 "EHLO
	smtp-out-133.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755225AbbCRJTZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2015 05:19:25 -0400
Message-ID: <55094327.9040903@metafoo.de>
Date: Wed, 18 Mar 2015 10:19:35 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
CC: srinivas.pandruvada@linux.intel.com,
	Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Subject: Re: [PATCH v5 1/3] iio: add watermark logic to iio read and poll
References: <1425491773-28499-1-git-send-email-octavian.purdila@intel.com> <1425491773-28499-2-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1425491773-28499-2-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Looks good mostly, two things.

On 03/04/2015 06:56 PM, Octavian Purdila wrote:
[...]
> @@ -61,19 +80,24 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>   	if (!rb || !rb->access->read_first_n)
>   		return -EINVAL;
>
> +	/*
> +	 * If datum_size is 0 there will never be anything to read from the
> +	 * buffer, so signal end of file now.
> +	 */
> +	if (!datum_size)
> +		return 0;
> +
> +	if (!(filp->f_flags & O_NONBLOCK))
> +		to_wait = min_t(size_t, n / datum_size, rb->watermark);
> +
>   	do {
> -		if (!iio_buffer_data_available(rb)) {
> -			if (filp->f_flags & O_NONBLOCK)
> -				return -EAGAIN;

If I understand this correctly we no longer return -EAGAIN if no data is 
available in non blocking mode, but rather return 0. Which means 
end-of-file, so it is not correct.

> +		ret = wait_event_interruptible(rb->pollq,
> +				      iio_buffer_ready(indio_dev, rb, to_wait));
> +		if (ret)
> +			return ret;
>
> -			ret = wait_event_interruptible(rb->pollq,
> -					iio_buffer_data_available(rb) ||
> -					indio_dev->info == NULL);
> -			if (ret)
> -				return ret;
> -			if (indio_dev->info == NULL)
> -				return -ENODEV;
> -		}
> +		if (!indio_dev->info)
> +			return -ENODEV;
>   [...]
> +
> +static ssize_t iio_buffer_store_watermark(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf,
> +					  size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +	if (!val)
> +		return -EINVAL;
> +
> +	mutex_lock(&indio_dev->mlock);
> +
> +	if (val > buffer->length) {
> +		ret = -EINVAL;
> +		goto out;
> +	}

This is missing the check for val == 0.

> +
> +	if (iio_buffer_is_active(indio_dev->buffer)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	buffer->watermark = val;
> +out:
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return ret ? ret : len;
> +}

