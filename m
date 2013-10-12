Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46444 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab3JLKHA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 06:07:00 -0400
Message-ID: <52592D73.4080409@kernel.org>
Date: Sat, 12 Oct 2013 12:07:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio:buffer: Add proper locking for iio_update_buffers()
References: <1380884822-17035-1-git-send-email-lars@metafoo.de> <1380884822-17035-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1380884822-17035-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/13 12:07, Lars-Peter Clausen wrote:
> We need to make sure that in-kernel users of iio_update_buffers() do not race
> against each other or against unregistration of the device. So we need to take
> both the mlock and the info_exist_lock when calling iio_update_buffers() from a
> in-kernel consumer.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
> No changes since v1
> ---
>  drivers/iio/industrialio-buffer.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 5a46c57..d6a5455 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -509,7 +509,7 @@ void iio_disable_all_buffers(struct iio_dev *indio_dev)
>  		indio_dev->setup_ops->postdisable(indio_dev);
>  }
>  
> -int iio_update_buffers(struct iio_dev *indio_dev,
> +static int __iio_update_buffers(struct iio_dev *indio_dev,
>  		       struct iio_buffer *insert_buffer,
>  		       struct iio_buffer *remove_buffer)
>  {
> @@ -674,6 +674,29 @@ error_ret:
>  
>  	return ret;
>  }
> +
> +int iio_update_buffers(struct iio_dev *indio_dev,
> +		       struct iio_buffer *insert_buffer,
> +		       struct iio_buffer *remove_buffer)
> +{
> +	int ret;
> +
> +	mutex_lock(&indio_dev->info_exist_lock);
> +	mutex_lock(&indio_dev->mlock);
> +
> +	if (indio_dev->info == NULL) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +	ret = __iio_update_buffers(indio_dev, insert_buffer, remove_buffer);
> +
> +out_unlock:
> +	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&indio_dev->info_exist_lock);
> +
> +	return ret;
> +}
>  EXPORT_SYMBOL_GPL(iio_update_buffers);
>  
>  ssize_t iio_buffer_store_enable(struct device *dev,
> @@ -699,10 +722,10 @@ ssize_t iio_buffer_store_enable(struct device *dev,
>  		goto done;
>  
>  	if (requested_state)
> -		ret = iio_update_buffers(indio_dev,
> +		ret = __iio_update_buffers(indio_dev,
>  					 indio_dev->buffer, NULL);
>  	else
> -		ret = iio_update_buffers(indio_dev,
> +		ret = __iio_update_buffers(indio_dev,
>  					 NULL, indio_dev->buffer);
>  
>  	if (ret < 0)
> 
