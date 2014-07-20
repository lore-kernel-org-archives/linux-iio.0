Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:40619 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbaGTPMU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Jul 2014 11:12:20 -0400
Message-ID: <53CBDCE1.6020403@kernel.org>
Date: Sun, 20 Jul 2014 16:14:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: buffer: Coalesce adjacent demux table entries
References: <1405612789-27964-1-git-send-email-lars@metafoo.de> <1405612789-27964-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1405612789-27964-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/07/14 16:59, Lars-Peter Clausen wrote:
> When copying multiple multiple samples that are adjacent in both the source as
> well as the destination buffer, instead of creating a new demux table entry for
> each sample just increase the length of the previous entry by the size of the
> new sample. This makes the demuxing process slightly more efficient.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Nice.  Will hold these last two until the first one is in and we have decided
what to do about the second one.

J
> ---
>   drivers/iio/industrialio-buffer.c | 47 +++++++++++++++++++++++----------------
>   1 file changed, 28 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 5063703..779e5b3 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -942,13 +942,34 @@ int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data)
>   }
>   EXPORT_SYMBOL_GPL(iio_push_to_buffers);
>
> +static int iio_buffer_add_demux(struct iio_buffer *buffer,
> +	struct iio_demux_table **p, unsigned int in_loc, unsigned int out_loc,
> +	unsigned int length)
> +{
> +
> +	if (*p && (*p)->from + (*p)->length == in_loc &&
> +		(*p)->to + (*p)->length == out_loc) {
> +		(*p)->length += length;
> +	} else {
> +		*p = kmalloc(sizeof(*p), GFP_KERNEL);
> +		if (*p == NULL)
> +			return -ENOMEM;
> +		(*p)->from = in_loc;
> +		(*p)->to = out_loc;
> +		(*p)->length = length;
> +		list_add_tail(&(*p)->l, &buffer->demux_list);
> +	}
> +
> +	return 0;
> +}
> +
>   static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>   				   struct iio_buffer *buffer)
>   {
>   	const struct iio_chan_spec *ch;
>   	int ret, in_ind = -1, out_ind, length;
>   	unsigned in_loc = 0, out_loc = 0;
> -	struct iio_demux_table *p;
> +	struct iio_demux_table *p = NULL;
>
>   	/* Clear out any old demux */
>   	iio_buffer_demux_free(buffer);
> @@ -981,11 +1002,6 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>   			/* Make sure we are aligned */
>   			in_loc = roundup(in_loc, length) + length;
>   		}
> -		p = kmalloc(sizeof(*p), GFP_KERNEL);
> -		if (p == NULL) {
> -			ret = -ENOMEM;
> -			goto error_clear_mux_table;
> -		}
>   		ch = iio_find_channel_from_si(indio_dev, in_ind);
>   		if (ch->scan_type.repeat > 1)
>   			length = ch->scan_type.storagebits / 8 *
> @@ -994,20 +1010,14 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>   			length = ch->scan_type.storagebits / 8;
>   		out_loc = roundup(out_loc, length);
>   		in_loc = roundup(in_loc, length);
> -		p->from = in_loc;
> -		p->to = out_loc;
> -		p->length = length;
> -		list_add_tail(&p->l, &buffer->demux_list);
> +		ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
> +		if (ret)
> +			goto error_clear_mux_table;
>   		out_loc += length;
>   		in_loc += length;
>   	}
>   	/* Relies on scan_timestamp being last */
>   	if (buffer->scan_timestamp) {
> -		p = kmalloc(sizeof(*p), GFP_KERNEL);
> -		if (p == NULL) {
> -			ret = -ENOMEM;
> -			goto error_clear_mux_table;
> -		}
>   		ch = iio_find_channel_from_si(indio_dev,
>   			indio_dev->scan_index_timestamp);
>   		if (ch->scan_type.repeat > 1)
> @@ -1017,10 +1027,9 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>   			length = ch->scan_type.storagebits / 8;
>   		out_loc = roundup(out_loc, length);
>   		in_loc = roundup(in_loc, length);
> -		p->from = in_loc;
> -		p->to = out_loc;
> -		p->length = length;
> -		list_add_tail(&p->l, &buffer->demux_list);
> +		ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
> +		if (ret)
> +			goto error_clear_mux_table;
>   		out_loc += length;
>   		in_loc += length;
>   	}
>

