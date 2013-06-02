Return-Path: <jic23@kernel.org>
Message-ID: <51AB6B74.4090604@kernel.org>
Date: Sun, 02 Jun 2013 16:57:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, mirq-linux@rere.qmqm.pl
Subject: Re: [PATCH] iio:callback buffer: free the scan_mask
References: <1369258877-7308-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1369258877-7308-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 05/22/2013 10:41 PM, Jonathan Cameron wrote:
> Reported-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>

Applied to fixes-togreg branch of iio.git

Sometimes I think no one cares, then I remember that there are no
in tree users of this code so probably no one does ;)
> ---
> As per original discussion I've now put together a minimal patch.
> The rework suggested was reasonable but had no place in a fix patch.
> 
>  drivers/iio/buffer_cb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/buffer_cb.c b/drivers/iio/buffer_cb.c
> index 9201022..9d19ba7 100644
> --- a/drivers/iio/buffer_cb.c
> +++ b/drivers/iio/buffer_cb.c
> @@ -64,7 +64,7 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
>  	while (chan->indio_dev) {
>  		if (chan->indio_dev != indio_dev) {
>  			ret = -EINVAL;
> -			goto error_release_channels;
> +			goto error_free_scan_mask;
>  		}
>  		set_bit(chan->channel->scan_index,
>  			cb_buff->buffer.scan_mask);
> @@ -73,6 +73,8 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
>  
>  	return cb_buff;
>  
> +error_free_scan_mask:
> +	kfree(cb_buff->buffer.scan_mask);
>  error_release_channels:
>  	iio_channel_release_all(cb_buff->channels);
>  error_free_cb_buff:
> @@ -100,6 +102,7 @@ EXPORT_SYMBOL_GPL(iio_channel_stop_all_cb);
>  
>  void iio_channel_release_all_cb(struct iio_cb_buffer *cb_buff)
>  {
> +	kfree(cb_buff->buffer.scan_mask);
>  	iio_channel_release_all(cb_buff->channels);
>  	kfree(cb_buff);
>  }
> 
