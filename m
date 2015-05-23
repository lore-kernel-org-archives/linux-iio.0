Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50468 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756929AbbEWLpP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 May 2015 07:45:15 -0400
Message-ID: <55606849.1000407@kernel.org>
Date: Sat, 23 May 2015 12:45:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: __iio_update_buffers: Verify configuration
 before starting to apply it
References: <1431948889-24069-1-git-send-email-lars@metafoo.de> <1431948889-24069-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1431948889-24069-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/05/15 12:34, Lars-Peter Clausen wrote:
> Currently __iio_update_buffers() verifies whether the new configuration
> will work in the middle of the update sequence. This means if the new
> configuration is invalid we need to rollback the changes already made. This
> patch moves the validation of the new configuration at the beginning of
> __iio_update_buffers() and will not start to make any changes if the new
> configuration is invalid.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git pushed out as testing
for the autobuilders to work their magic.

Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-buffer.c | 164 +++++++++++++++++++++++---------------
>  1 file changed, 101 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 21ed316..0b4fe63 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -602,20 +602,104 @@ static void iio_free_scan_mask(struct iio_dev *indio_dev,
>  		kfree(mask);
>  }
>  
> +struct iio_device_config {
> +	unsigned int mode;
> +	const unsigned long *scan_mask;
> +	unsigned int scan_bytes;
> +	bool scan_timestamp;
> +};
> +
> +static int iio_verify_update(struct iio_dev *indio_dev,
> +	struct iio_buffer *insert_buffer, struct iio_buffer *remove_buffer,
> +	struct iio_device_config *config)
> +{
> +	unsigned long *compound_mask;
> +	const unsigned long *scan_mask;
> +	struct iio_buffer *buffer;
> +	bool scan_timestamp;
> +
> +	memset(config, 0, sizeof(*config));
> +
> +	/*
> +	 * If there is just one buffer and we are removing it there is nothing
> +	 * to verify.
> +	 */
> +	if (remove_buffer && !insert_buffer &&
> +		list_is_singular(&indio_dev->buffer_list))
> +			return 0;
> +
> +	/* Definitely possible for devices to support both of these. */
> +	if ((indio_dev->modes & INDIO_BUFFER_TRIGGERED) && indio_dev->trig) {
> +		config->mode = INDIO_BUFFER_TRIGGERED;
> +	} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE) {
> +		config->mode = INDIO_BUFFER_HARDWARE;
> +	} else if (indio_dev->modes & INDIO_BUFFER_SOFTWARE) {
> +		config->mode = INDIO_BUFFER_SOFTWARE;
> +	} else {
> +		/* Can only occur on first buffer */
> +		if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
> +			dev_dbg(&indio_dev->dev, "Buffer not started: no trigger\n");
> +		return -EINVAL;
> +	}
> +
> +	/* What scan mask do we actually have? */
> +	compound_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
> +				sizeof(long), GFP_KERNEL);
> +	if (compound_mask == NULL)
> +		return -ENOMEM;
> +
> +	scan_timestamp = false;
> +
> +	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
> +		if (buffer == remove_buffer)
> +			continue;
> +		bitmap_or(compound_mask, compound_mask, buffer->scan_mask,
> +			  indio_dev->masklength);
> +		scan_timestamp |= buffer->scan_timestamp;
> +	}
> +
> +	if (insert_buffer) {
> +		bitmap_or(compound_mask, compound_mask,
> +			  insert_buffer->scan_mask, indio_dev->masklength);
> +		scan_timestamp |= insert_buffer->scan_timestamp;
> +	}
> +
> +	if (indio_dev->available_scan_masks) {
> +		scan_mask = iio_scan_mask_match(indio_dev->available_scan_masks,
> +				    indio_dev->masklength,
> +				    compound_mask);
> +		kfree(compound_mask);
> +		if (scan_mask == NULL)
> +			return -EINVAL;
> +	} else {
> +	    scan_mask = compound_mask;
> +	}
> +
> +	config->scan_bytes = iio_compute_scan_bytes(indio_dev,
> +				    scan_mask, scan_timestamp);
> +	config->scan_mask = scan_mask;
> +	config->scan_timestamp = scan_timestamp;
> +
> +	return 0;
> +}
> +
>  static int __iio_update_buffers(struct iio_dev *indio_dev,
>  		       struct iio_buffer *insert_buffer,
>  		       struct iio_buffer *remove_buffer)
>  {
>  	int ret;
> -	int success = 0;
> -	struct iio_buffer *buffer;
> -	unsigned long *compound_mask;
>  	const unsigned long *old_mask;
> +	struct iio_device_config new_config;
> +
> +	ret = iio_verify_update(indio_dev, insert_buffer, remove_buffer,
> +		&new_config);
> +	if (ret)
> +		return ret;
>  
>  	if (insert_buffer) {
>  		ret = iio_buffer_request_update(indio_dev, insert_buffer);
>  		if (ret)
> -			return ret;
> +			goto err_free_config;
>  	}
>  
>  	/* Wind down existing buffers - iff there are any */
> @@ -623,13 +707,13 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>  		if (indio_dev->setup_ops->predisable) {
>  			ret = indio_dev->setup_ops->predisable(indio_dev);
>  			if (ret)
> -				return ret;
> +				goto err_free_config;
>  		}
>  		indio_dev->currentmode = INDIO_DIRECT_MODE;
>  		if (indio_dev->setup_ops->postdisable) {
>  			ret = indio_dev->setup_ops->postdisable(indio_dev);
>  			if (ret)
> -				return ret;
> +				goto err_free_config;
>  		}
>  	}
>  	/* Keep a copy of current setup to allow roll back */
> @@ -649,44 +733,9 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>  		return 0;
>  	}
>  
> -	/* What scan mask do we actually have? */
> -	compound_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
> -				sizeof(long), GFP_KERNEL);
> -	if (compound_mask == NULL) {
> -		iio_free_scan_mask(indio_dev, old_mask);
> -		return -ENOMEM;
> -	}
> -	indio_dev->scan_timestamp = 0;
> -
> -	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
> -		bitmap_or(compound_mask, compound_mask, buffer->scan_mask,
> -			  indio_dev->masklength);
> -		indio_dev->scan_timestamp |= buffer->scan_timestamp;
> -	}
> -	if (indio_dev->available_scan_masks) {
> -		indio_dev->active_scan_mask =
> -			iio_scan_mask_match(indio_dev->available_scan_masks,
> -					    indio_dev->masklength,
> -					    compound_mask);
> -		kfree(compound_mask);
> -		if (indio_dev->active_scan_mask == NULL) {
> -			/*
> -			 * Roll back.
> -			 * Note can only occur when adding a buffer.
> -			 */
> -			iio_buffer_deactivate(insert_buffer);
> -			if (old_mask) {
> -				indio_dev->active_scan_mask = old_mask;
> -				success = -EINVAL;
> -			}
> -			else {
> -				ret = -EINVAL;
> -				return ret;
> -			}
> -		}
> -	} else {
> -		indio_dev->active_scan_mask = compound_mask;
> -	}
> +	indio_dev->active_scan_mask = new_config.scan_mask;
> +	indio_dev->scan_timestamp = new_config.scan_timestamp;
> +	indio_dev->scan_bytes = new_config.scan_bytes;
>  
>  	iio_update_demux(indio_dev);
>  
> @@ -699,10 +748,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>  			goto error_remove_inserted;
>  		}
>  	}
> -	indio_dev->scan_bytes =
> -		iio_compute_scan_bytes(indio_dev,
> -				       indio_dev->active_scan_mask,
> -				       indio_dev->scan_timestamp);
> +
>  	if (indio_dev->info->update_scan_mode) {
>  		ret = indio_dev->info
>  			->update_scan_mode(indio_dev,
> @@ -714,20 +760,8 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>  			goto error_run_postdisable;
>  		}
>  	}
> -	/* Definitely possible for devices to support both of these. */
> -	if ((indio_dev->modes & INDIO_BUFFER_TRIGGERED) && indio_dev->trig) {
> -		indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
> -	} else if (indio_dev->modes & INDIO_BUFFER_HARDWARE) {
> -		indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
> -	} else if (indio_dev->modes & INDIO_BUFFER_SOFTWARE) {
> -		indio_dev->currentmode = INDIO_BUFFER_SOFTWARE;
> -	} else { /* Should never be reached */
> -		/* Can only occur on first buffer */
> -		if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
> -			dev_dbg(&indio_dev->dev, "Buffer not started: no trigger\n");
> -		ret = -EINVAL;
> -		goto error_run_postdisable;
> -	}
> +
> +	indio_dev->currentmode = new_config.mode;
>  
>  	if (indio_dev->setup_ops->postenable) {
>  		ret = indio_dev->setup_ops->postenable(indio_dev);
> @@ -743,7 +777,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>  
>  	iio_free_scan_mask(indio_dev, old_mask);
>  
> -	return success;
> +	return 0;
>  
>  error_disable_all_buffers:
>  	indio_dev->currentmode = INDIO_DIRECT_MODE;
> @@ -756,6 +790,10 @@ error_remove_inserted:
>  	iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
>  	indio_dev->active_scan_mask = old_mask;
>  	return ret;
> +
> +err_free_config:
> +	iio_free_scan_mask(indio_dev, new_config.scan_mask);
> +	return ret;
>  }
>  
>  int iio_update_buffers(struct iio_dev *indio_dev,
> 

