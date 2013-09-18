Return-Path: <lars@metafoo.de>
Message-ID: <523A0CCE.3010003@metafoo.de>
Date: Wed, 18 Sep 2013 22:27:58 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/10] iio:buffer: Add proper locking for iio_update_buffers()
References: <1379534574-11213-1-git-send-email-lars@metafoo.de> <1379534574-11213-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1379534574-11213-9-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

[...]
> +int iio_update_buffers(struct iio_dev *indio_dev,
> +		       struct iio_buffer *insert_buffer,
> +		       struct iio_buffer *remove_buffer)
> +{
> +	int ret;
> +
> +	mutex_lock(&indio_dev->info_exist_lock);
> +	mutex_lock(&indio_dev->mlock);
> +
> +	if (indio_dev->info == NULL)
> +		return -ENODEV;

Yea, ok that happens when send patches way to late in the evening. Of course we 
still need to unlock here...

> +	ret = __iio_update_buffers(indio_dev, insert_buffer, remove_buffer);
> +
> +	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&indio_dev->info_exist_lock);
> +
> +	return ret;
> +}
