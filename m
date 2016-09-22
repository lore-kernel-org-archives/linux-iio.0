Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48077 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966179AbcIVS1A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2016 14:27:00 -0400
Subject: Re: [PATCH v5 1/2] iio: inkern: add iio_read_channel_offset helper
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1474340018-26647-1-git-send-email-matt@ranostay.consulting>
 <1474340018-26647-2-git-send-email-matt@ranostay.consulting>
Cc: Matt Ranostay <matt@ranostay.consulting>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9e76487a-6586-3c53-2f4d-777d80b8faa8@kernel.org>
Date: Thu, 22 Sep 2016 19:26:58 +0100
MIME-Version: 1.0
In-Reply-To: <1474340018-26647-2-git-send-email-matt@ranostay.consulting>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/09/16 03:53, Matt Ranostay wrote:
> Allow access to underlying channel IIO_CHAN_INFO_OFFSET from a consumer
> 
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Hmm. This one is useful enough to justify it's own function, but
sooner or later we should just have a single query that reads any
of the info_mask elements if present.

Bonus points for a generic function that allows code sharing even
for just the scale and offset cases that are now present.

If that function was also exported then all the better - would 
need moving the info_mask define out to types.h probably so the
stuff in iio.h can remain opaque to consumers that aren't IIO
drivers.

Thanks,

Jonathan
> ---
>  drivers/iio/inkern.c         | 18 ++++++++++++++++++
>  include/linux/iio/consumer.h | 13 +++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index c4757e6367e7..d90af439b0a3 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -658,6 +658,24 @@ err_unlock:
>  }
>  EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
>  
> +int iio_read_channel_offset(struct iio_channel *chan, int *val, int *val2)
> +{
> +	int ret;
> +
> +	mutex_lock(&chan->indio_dev->info_exist_lock);
> +	if (chan->indio_dev->info == NULL) {
> +		ret = -ENODEV;
> +		goto err_unlock;
> +	}
> +
> +	ret = iio_channel_read(chan, val, val2, IIO_CHAN_INFO_OFFSET);
> +err_unlock:
> +	mutex_unlock(&chan->indio_dev->info_exist_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iio_read_channel_offset);
> +
>  int iio_read_channel_processed(struct iio_channel *chan, int *val)
>  {
>  	int ret;
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 9edccfba1ffb..638157234357 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -236,6 +236,19 @@ int iio_get_channel_type(struct iio_channel *channel,
>  			 enum iio_chan_type *type);
>  
>  /**
> + * iio_read_channel_offset() - read the offset value for a channel
> + * @chan:		The channel being queried.
> + * @val:		First part of value read back.
> + * @val2:		Second part of value read back.
> + *
> + * Note returns a description of what is in val and val2, such
> + * as IIO_VAL_INT_PLUS_MICRO telling us we have a value of val
> + * + val2/1e6
> + */
> +int iio_read_channel_offset(struct iio_channel *chan, int *val,
> +			   int *val2);
> +
> +/**
>   * iio_read_channel_scale() - read the scale value for a channel
>   * @chan:		The channel being queried.
>   * @val:		First part of value read back.
> 

