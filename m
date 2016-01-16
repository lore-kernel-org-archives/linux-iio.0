Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53614 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbcAPNGU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jan 2016 08:06:20 -0500
Subject: Re: [PATCH] iio:adc:ti_am335x_adc Fix buffered mode by identifying as
 software buffer.
To: linux-iio@vger.kernel.org
References: <1451671534-23708-1-git-send-email-jic23@kernel.org>
Cc: lars-Peter Clausen <lars@metafoo.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <569A404A.9060002@kernel.org>
Date: Sat, 16 Jan 2016 13:06:18 +0000
MIME-Version: 1.0
In-Reply-To: <1451671534-23708-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/01/16 18:05, Jonathan Cameron wrote:
> Whilst this part has a hardware buffer, the identifcation that IIO cares
> about is the userspace facing end.  It this case we push individual elements
> from the hardware fifo into the software interface (specifically a kfifo)
> rather than providing direct reads through to a hardware buffer
> (as we still do in the sca3000 for example).
> 
> Technically the original specification as a hardware buffer could be
> considered wrong, but it didn't matter until the patch listed below.
> 
> Result is that any attempt to enable the buffer will return -EINVAL
> 
> Fixes: 225d59adf1c8 ("iio: Specify supported modes for buffers")
> Cc: lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Long enough - whilst I don't like applying my own patches without review
this one is trivial enough I'm going to do so anyway.

Applied to the fixes-togreg branch of iio.git

Jonathan
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 942320e32753..c1e05532d437 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -289,7 +289,7 @@ static int tiadc_iio_buffered_hardware_setup(struct iio_dev *indio_dev,
>  		goto error_kfifo_free;
>  
>  	indio_dev->setup_ops = setup_ops;
> -	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
> +	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
>  
>  	return 0;
>  
> 

