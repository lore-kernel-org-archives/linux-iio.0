Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:40959 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbdDIKHV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Apr 2017 06:07:21 -0400
Subject: Re: [PATCH] staging: iio: ad5933: Protect DIRECT mode using
 claim/release helpers
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
References: <1490290603-9115-1-git-send-email-narcisaanamaria12@gmail.com>
Cc: linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <cb6f9e84-7b2b-2bb1-4e0a-742a0cc12ab0@metafoo.de>
Date: Sun, 9 Apr 2017 12:07:14 +0200
MIME-Version: 1.0
In-Reply-To: <1490290603-9115-1-git-send-email-narcisaanamaria12@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/23/2017 06:36 PM, Narcisa Ana Maria Vasile wrote:
[...]
> @@ -415,7 +420,10 @@ static ssize_t ad5933_store(struct device *dev,
>  			return ret;
>  	}
>  
> -	mutex_lock(&indio_dev->mlock);
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;

This is a change in semantics. Previously it was possible to change the
attributes while in buffered mode, but now it no longer is. This is probably
OK, but should certainly be noted in the commit message.

> +	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {
>  	case AD5933_OUT_RANGE:
>  		ret = -EINVAL;
> @@ -465,7 +473,8 @@ static ssize_t ad5933_store(struct device *dev,
>  		ret = -EINVAL;
>  	}
>  
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
> +	iio_device_release_direct_mode(indio_dev);
>  	return ret ? ret : len;
>  }
>  
> @@ -532,11 +541,9 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&indio_dev->mlock);
> -		if (iio_buffer_enabled(indio_dev)) {
> -			ret = -EBUSY;
> -			goto out;
> -		}
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
>  		ret = ad5933_cmd(st, AD5933_CTRL_MEASURE_TEMP);
>  		if (ret < 0)
>  			goto out;
> @@ -549,7 +556,7 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
>  				      2, (u8 *)&dat);
>  		if (ret < 0)
>  			goto out;
> -		mutex_unlock(&indio_dev->mlock);
> +		iio_device_release_direct_mode(indio_dev);
>  		*val = sign_extend32(be16_to_cpu(dat), 13);
>  
>  		return IIO_VAL_INT;
> @@ -561,7 +568,7 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
>  
>  	return -EINVAL;
>  out:
> -	mutex_unlock(&indio_dev->mlock);
> +	iio_device_release_direct_mode(indio_dev);
>  	return ret;
>  }
>  

