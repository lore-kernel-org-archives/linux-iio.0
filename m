Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59444 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbbJYNmq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Oct 2015 09:42:46 -0400
Subject: Re: [PATCH v3 1/6] iio: Set device watermark based on watermark of
 all attached buffers
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1444752629-3532-1-git-send-email-lars@metafoo.de>
 <1444752629-3532-2-git-send-email-lars@metafoo.de>
Cc: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <562CDC54.6060305@kernel.org>
Date: Sun, 25 Oct 2015 13:42:44 +0000
MIME-Version: 1.0
In-Reply-To: <1444752629-3532-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/10/15 17:10, Lars-Peter Clausen wrote:
> Currently the watermark of the device is only set based on the watermark
> that is set for the user space buffer. This doesn't consider the watermarks
> set on any attached in-kernel buffers.
> 
> Change this so that the watermark of the device should be the minimum of
> the watermarks over all attached buffers.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git - initially pushed out as testing.

These have missed the coming merge window, but in someways I'm happier having
these have a very long bake in linux-next (and hopefully some user get added
before they mainline!)

Jonathan
> ---
>  drivers/iio/industrialio-buffer.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index d7e908a..7340922 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -610,6 +610,7 @@ static void iio_free_scan_mask(struct iio_dev *indio_dev,
>  
>  struct iio_device_config {
>  	unsigned int mode;
> +	unsigned int watermark;
>  	const unsigned long *scan_mask;
>  	unsigned int scan_bytes;
>  	bool scan_timestamp;
> @@ -642,10 +643,14 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  		if (buffer == remove_buffer)
>  			continue;
>  		modes &= buffer->access->modes;
> +		config->watermark = min(config->watermark, buffer->watermark);
>  	}
>  
> -	if (insert_buffer)
> +	if (insert_buffer) {
>  		modes &= insert_buffer->access->modes;
> +		config->watermark = min(config->watermark,
> +			insert_buffer->watermark);
> +	}
>  
>  	/* Definitely possible for devices to support both of these. */
>  	if ((modes & INDIO_BUFFER_TRIGGERED) && indio_dev->trig) {
> @@ -743,6 +748,10 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  		}
>  	}
>  
> +	if (indio_dev->info->hwfifo_set_watermark)
> +		indio_dev->info->hwfifo_set_watermark(indio_dev,
> +			config->watermark);
> +
>  	indio_dev->currentmode = config->mode;
>  
>  	if (indio_dev->setup_ops->postenable) {
> @@ -974,9 +983,6 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
>  	}
>  
>  	buffer->watermark = val;
> -
> -	if (indio_dev->info->hwfifo_set_watermark)
> -		indio_dev->info->hwfifo_set_watermark(indio_dev, val);
>  out:
>  	mutex_unlock(&indio_dev->mlock);
>  
> 

