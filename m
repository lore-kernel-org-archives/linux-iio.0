Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36514 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab2GIRa1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jul 2012 13:30:27 -0400
Message-ID: <4FFB1526.3010808@kernel.org>
Date: Mon, 09 Jul 2012 18:30:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iio: Add callback to check whether a scan mask
 is valid
References: <1341824452-28803-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1341824452-28803-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/09/2012 10:00 AM, Lars-Peter Clausen wrote:
> This is useful for cases where the number of valid scan masks grows
> exponentially, but it is rather easy to check whether a mask is valid or not
> programmatically.
> 
> An example of such a case is a device with multiple ADCs where each ADC has a
> upstream MUX, which allows to select from a number of physical channels.
> 
>   +-------+   +-------+
>   |       |   |       | --- Channel 1
>   | ADC 1 |---| MUX 1 | ---   ...
>   |       |   |       | --- Channel M
>   +-------+   +-------+
> 
>      .            .            .
>      .            .            .
>      .            .            .
> 
>   +-------+   +-------+
>   |       |   |       | --- Channel M * N + 1
>   | ADC N |---| MUX N | ---       ...
>   |       |   |       | --- Channel M * N + M
>   +-------+   +-------+
> 
> The number of necessary scan masks for this case is (M+1)**N - 1, on the other
> hand it is easy to check whether subsets for each ADC of the scanmask have only
> one bit set.
> 
merged first 5 to togreg branch.  Pull request may be a few days.

Jonathan
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> ---
> No changes since v1
> ---
>  drivers/iio/industrialio-buffer.c |   27 ++++++++++++++++++++-------
>  include/linux/iio/iio.h           |    4 ++++
>  2 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 3d8d187..cc5db36 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -570,6 +570,15 @@ int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
>  }
>  EXPORT_SYMBOL(iio_sw_buffer_preenable);
>  
> +static bool iio_validate_scan_mask(struct iio_dev *indio_dev,
> +	const unsigned long *mask)
> +{
> +	if (!indio_dev->setup_ops->validate_scan_mask)
> +		return true;
> +
> +	return indio_dev->setup_ops->validate_scan_mask(indio_dev, mask);
> +}
> +
>  /**
>   * iio_scan_mask_set() - set particular bit in the scan mask
>   * @buffer: the buffer whose scan mask we are interested in
> @@ -589,27 +598,31 @@ int iio_scan_mask_set(struct iio_dev *indio_dev,
>  		return -ENOMEM;
>  	if (!indio_dev->masklength) {
>  		WARN_ON("trying to set scanmask prior to registering buffer\n");
> -		kfree(trialmask);
> -		return -EINVAL;
> +		goto err_invalid_mask;
>  	}
>  	bitmap_copy(trialmask, buffer->scan_mask, indio_dev->masklength);
>  	set_bit(bit, trialmask);
>  
> +	if (!iio_validate_scan_mask(indio_dev, trialmask))
> +		goto err_invalid_mask;
> +
>  	if (indio_dev->available_scan_masks) {
>  		mask = iio_scan_mask_match(indio_dev->available_scan_masks,
>  					   indio_dev->masklength,
>  					   trialmask);
> -		if (!mask) {
> -			kfree(trialmask);
> -			return -EINVAL;
> -		}
> +		if (!mask)
> +			goto err_invalid_mask;
>  	}
>  	bitmap_copy(buffer->scan_mask, trialmask, indio_dev->masklength);
>  
>  	kfree(trialmask);
>  
>  	return 0;
> -};
> +
> +err_invalid_mask:
> +	kfree(trialmask);
> +	return -EINVAL;
> +}
>  EXPORT_SYMBOL_GPL(iio_scan_mask_set);
>  
>  int iio_scan_mask_query(struct iio_dev *indio_dev,
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 2afbb6f..be82936 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -363,12 +363,16 @@ struct iio_info {
>   * @predisable:		[DRIVER] function to run prior to marking buffer
>   *			disabled
>   * @postdisable:	[DRIVER] function to run after marking buffer disabled
> + * @validate_scan_mask: [DRIVER] function callback to check whether a given
> + *			scan mask is valid for the device.
>   */
>  struct iio_buffer_setup_ops {
>  	int				(*preenable)(struct iio_dev *);
>  	int				(*postenable)(struct iio_dev *);
>  	int				(*predisable)(struct iio_dev *);
>  	int				(*postdisable)(struct iio_dev *);
> +	bool (*validate_scan_mask)(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask);
>  };
>  
>  /**
> 


