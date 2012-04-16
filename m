Return-Path: <lars@metafoo.de>
Message-ID: <4F8C41F5.2010807@metafoo.de>
Date: Mon, 16 Apr 2012 17:59:49 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 greg@kroah.com, dmitry.torokhov@gmail.com,
 broonie@opensource.wolfsonmicro.com, alan@lxorguk.ukuu.org.uk,
 arnd@arndb.de, linus.walleij@linaro.org,
 maxime.ripard@free-electrons.com, thomas.petazzoni@free-electrons.com,
 zdevai@gmail.com, w.sang@pengutronix.de, marek.vasut@gmail.com,
 Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/4] staging:iio: make all buffer access pass through
 the buffer_list
References: <1334090294-23407-1-git-send-email-jic23@kernel.org> <1334090294-23407-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1334090294-23407-2-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/10/2012 10:38 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Crucial step in allowing multiple interfaces.
> 
> Main stages:
> 
> 1) Ensure no trigger_handler touches the buffers directly.
> They should only care about active_scan_mask and scan_timestamp
> in indio_dev.
> 2) Ensure all setup ops for the buffers act on the general mode
> and the individual buffers in a consistent fashion.
> 3) Make use of iio_sw_buffer_preenable where possibe. It's never
> in a particular fast path so even if overcomplex it is worth
> using to cut down on code duplication.

In my opinion it would have been better to split 1, 2 and 3 into different
patches.

The driver specific bits look good, but I can't really say I do understand
all that's changed in the core right now.

> [...]
>  
>  int iio_update_demux(struct iio_dev *indio_dev)
>  {
>  	const struct iio_chan_spec *ch;
> -	struct iio_buffer *buffer = indio_dev->buffer;
> -	int ret, in_ind = -1, out_ind, length;
> -	unsigned in_loc = 0, out_loc = 0;
> +	struct iio_buffer *buffer;
>  	struct iio_demux_table *p, *q;
> +	int ret;
>  
> -	/* Clear out any old demux */
> -	list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
> -		list_del(&p->l);
> -		kfree(p);
> -	}
> -	kfree(buffer->demux_bounce);
> -	buffer->demux_bounce = NULL;
> -
> -	/* First work out which scan mode we will actually have */
> -	if (bitmap_equal(indio_dev->active_scan_mask,
> -			 buffer->scan_mask,
> -			 indio_dev->masklength))
> -		return 0;
> +	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
> +		unsigned in_loc = 0, out_loc = 0;
> +		int in_ind = -1, out_ind, length;

How about using a outer function here which loops over the buffers and a
inner function, which handles a single buffer? This keeps the indention
level low and also makes the diffstat a lot more readable.

>  
> -	/* Now we have the two masks, work from least sig and build up sizes */
> -	for_each_set_bit(out_ind,
> -			 indio_dev->active_scan_mask,
> -			 indio_dev->masklength) {
> -		in_ind = find_next_bit(indio_dev->active_scan_mask,
> -				       indio_dev->masklength,
> -				       in_ind + 1);
> -		while (in_ind != out_ind) {
> +		/* Clear out any old demux */
> +		list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
> +			list_del(&p->l);
> +			kfree(p);
> +		}
> +		kfree(buffer->demux_bounce);
> +		buffer->demux_bounce = NULL;
> +
> +		/* First work out which scan mode we will actually have */
> +		if (bitmap_equal(indio_dev->active_scan_mask,
> +				 buffer->scan_mask,
> +				 indio_dev->masklength))
> +			return 0;
> +
> +		/*
> +		 * Now we have the two masks, work from least sig
> +		 * and build up sizes.
> +		 */
> +		for_each_set_bit(out_ind,
> +				 indio_dev->active_scan_mask,
> +				 indio_dev->masklength) {
>  			in_ind = find_next_bit(indio_dev->active_scan_mask,
>  					       indio_dev->masklength,
>  					       in_ind + 1);
> +			while (in_ind != out_ind) {
> +				in_ind = find_next_bit(indio_dev->
> +						       active_scan_mask,
> +						       indio_dev->masklength,
> +						       in_ind + 1);
> +				ch = iio_find_channel_from_si(indio_dev,
> +							      in_ind);
> +				length = ch->scan_type.storagebits/8;
> +				/* Make sure we are aligned */
> +				in_loc += length;
> +				if (in_loc % length)
> +					in_loc += length - in_loc % length;
> +			}
> +			p = kmalloc(sizeof(*p), GFP_KERNEL);
> +			if (p == NULL) {
> +				ret = -ENOMEM;
> +				goto error_clear_mux_table;
> +			}
>  			ch = iio_find_channel_from_si(indio_dev, in_ind);
>  			length = ch->scan_type.storagebits/8;
> -			/* Make sure we are aligned */
> -			in_loc += length;
> +			if (out_loc % length)
> +				out_loc += length - out_loc % length;
>  			if (in_loc % length)
>  				in_loc += length - in_loc % length;
> +			p->from = in_loc;
> +			p->to = out_loc;
> +			p->length = length;
> +			list_add_tail(&p->l, &buffer->demux_list);
> +			out_loc += length;
> +			in_loc += length;
>  		}
> -		p = kmalloc(sizeof(*p), GFP_KERNEL);
> -		if (p == NULL) {
> -			ret = -ENOMEM;
> -			goto error_clear_mux_table;
> +		/* Relies on scan_timestamp being last */
> +		if (buffer->scan_timestamp) {
> +			p = kmalloc(sizeof(*p), GFP_KERNEL);
> +			if (p == NULL) {
> +				ret = -ENOMEM;
> +				goto error_clear_mux_table;
> +			}
> +			ch = iio_find_channel_from_si(indio_dev,
> +						      indio_dev->
> +						      scan_index_timestamp);
> +			length = ch->scan_type.storagebits/8;
> +			if (out_loc % length)
> +				out_loc += length - out_loc % length;
> +			if (in_loc % length)
> +				in_loc += length - in_loc % length;
> +			p->from = in_loc;
> +			p->to = out_loc;
> +			p->length = length;
> +			list_add_tail(&p->l, &buffer->demux_list);
> +			out_loc += length;
> +			in_loc += length;
>  		}
> -		ch = iio_find_channel_from_si(indio_dev, in_ind);
> -		length = ch->scan_type.storagebits/8;
> -		if (out_loc % length)
> -			out_loc += length - out_loc % length;
> -		if (in_loc % length)
> -			in_loc += length - in_loc % length;
> -		p->from = in_loc;
> -		p->to = out_loc;
> -		p->length = length;
> -		list_add_tail(&p->l, &buffer->demux_list);
> -		out_loc += length;
> -		in_loc += length;
> -	}
> -	/* Relies on scan_timestamp being last */
> -	if (buffer->scan_timestamp) {
> -		p = kmalloc(sizeof(*p), GFP_KERNEL);
> -		if (p == NULL) {
> +		buffer->demux_bounce = kzalloc(out_loc, GFP_KERNEL);
> +		if (buffer->demux_bounce == NULL) {
>  			ret = -ENOMEM;
>  			goto error_clear_mux_table;
>  		}
> -		ch = iio_find_channel_from_si(indio_dev,
> -			buffer->scan_index_timestamp);
> -		length = ch->scan_type.storagebits/8;
> -		if (out_loc % length)
> -			out_loc += length - out_loc % length;
> -		if (in_loc % length)
> -			in_loc += length - in_loc % length;
> -		p->from = in_loc;
> -		p->to = out_loc;
> -		p->length = length;
> -		list_add_tail(&p->l, &buffer->demux_list);
> -		out_loc += length;
> -		in_loc += length;
> -	}
> -	buffer->demux_bounce = kzalloc(out_loc, GFP_KERNEL);
> -	if (buffer->demux_bounce == NULL) {
> -		ret = -ENOMEM;
> -		goto error_clear_mux_table;
>  	}
>  	return 0;
>  
>  error_clear_mux_table:
> -	list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
> -		list_del(&p->l);
> -		kfree(p);
> +	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
> +		list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
> +			list_del(&p->l);
> +			kfree(p);
> +		}
>  	}
>  	return ret;
>  }
