Return-Path: <jic23@kernel.org>
Message-ID: <4EE087E2.5040901@kernel.org>
Date: Thu, 08 Dec 2011 09:48:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH] staging:iio: Fix scan mask update
References: <1323269024-21656-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1323269024-21656-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/07/2011 02:43 PM, Lars-Peter Clausen wrote:
> When updating the scan mask we have to check the actual scan mask for if the
> channel is already enabled, not the matching scan mask from the available
> scan masks. The bit will already be set there and as a result the actual
> scan mask will not get updated and the channel stays disabled.
Dratt, I messed this case up didn't I!  I guess my tests only make
changes that effect the scan mask.  Oops.

Thanks for the catch.  This is clearly a hole in my tests...

> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>

> ---
>  drivers/staging/iio/industrialio-buffer.c |   12 ++----------
>  1 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
> index f629e8b..a539c7c 100644
> --- a/drivers/staging/iio/industrialio-buffer.c
> +++ b/drivers/staging/iio/industrialio-buffer.c
> @@ -171,7 +171,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
>  error_ret:
>  	mutex_unlock(&indio_dev->mlock);
>  
> -	return ret ? ret : len;
> +	return ret < 0 ? ret : len;
>  
>  }
>  
> @@ -617,16 +617,8 @@ int iio_scan_mask_query(struct iio_dev *indio_dev,
>  
>  	if (!buffer->scan_mask)
>  		return 0;
> -	if (indio_dev->available_scan_masks)
> -		mask = iio_scan_mask_match(indio_dev->available_scan_masks,
> -					   indio_dev->masklength,
> -					   buffer->scan_mask);
> -	else
> -		mask = buffer->scan_mask;
> -	if (!mask)
> -		return 0;
>  
> -	return test_bit(bit, mask);
> +	return test_bit(bit, buffer->scan_mask);
>  };
>  EXPORT_SYMBOL_GPL(iio_scan_mask_query);
>  
