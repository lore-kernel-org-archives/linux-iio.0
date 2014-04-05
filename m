Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39791 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbaDEKOj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Apr 2014 06:14:39 -0400
Message-ID: <533FD7DA.1090403@kernel.org>
Date: Sat, 05 Apr 2014 11:15:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [Patch v2 2/3] IIO: core: Modify scan element type
References: <1396647041-22551-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1396647041-22551-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1396647041-22551-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/04/14 22:30, Srinivas Pandruvada wrote:
> The current scan element type uses the following format:
>    [be|le]:[s|u]bits/storagebits[>>shift].
> To specify multiple elements in this type, added a repeat value.
> So new format is:
>    [be|le]:([s|u]bits/storagebits){repeat}[>>shift].
Hi Srinivas.  I'd missed the addition of the brackets in this string previously.
I'm not keen on this purely because it will complicate any userspace handling
code. It may be a little simplistic but how about
[be|le]:[s|u]bits/storagebits{x[repeat]}[>>shift]
I thought about moving it to the end, but it might be slightly unclear that
we are repeating the data before or after the shift (and whether the shift
inherently reduces the length of the data - which it doesn't, but that
might not stop people getting confused ;)
> Here repeat is specifying how may times, real/storage bits are repeating.
>
> When repeat is value is 0 or 1, then repeat value is not used in the format,
> and it will be same as existing format.
>
Other than the brackets vs x suggestion this looks fine to me.
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>   drivers/iio/industrialio-buffer.c | 41 +++++++++++++++++++++++++++++++++------
>   include/linux/iio/iio.h           |  9 +++++++++
>   2 files changed, 44 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index c67d83b..598eacd 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -150,7 +150,16 @@ static ssize_t iio_show_fixed_type(struct device *dev,
>   		type = IIO_BE;
>   #endif
>   	}
> -	return sprintf(buf, "%s:%c%d/%d>>%u\n",
> +	if (this_attr->c->scan_type.repeat > 1)
> +		return sprintf(buf, "%s:(%c%d/%d){%d}>>%u\n",
> +		       iio_endian_prefix[type],
> +		       this_attr->c->scan_type.sign,
> +		       this_attr->c->scan_type.realbits,
> +		       this_attr->c->scan_type.storagebits,
> +		       this_attr->c->scan_type.repeat,
> +		       this_attr->c->scan_type.shift);
> +		else
> +			return sprintf(buf, "%s:%c%d/%d>>%u\n",
>   		       iio_endian_prefix[type],
>   		       this_attr->c->scan_type.sign,
>   		       this_attr->c->scan_type.realbits,
> @@ -475,14 +484,22 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>   	for_each_set_bit(i, mask,
>   			 indio_dev->masklength) {
>   		ch = iio_find_channel_from_si(indio_dev, i);
> -		length = ch->scan_type.storagebits / 8;
> +		if (ch->scan_type.repeat > 1)
> +			length = ch->scan_type.storagebits / 8 *
> +				ch->scan_type.repeat;
> +		else
> +			length = ch->scan_type.storagebits / 8;
>   		bytes = ALIGN(bytes, length);
>   		bytes += length;
>   	}
>   	if (timestamp) {
>   		ch = iio_find_channel_from_si(indio_dev,
>   					      indio_dev->scan_index_timestamp);
> -		length = ch->scan_type.storagebits / 8;
> +		if (ch->scan_type.repeat > 1)
> +			length = ch->scan_type.storagebits / 8 *
> +				ch->scan_type.repeat;
> +		else
> +			length = ch->scan_type.storagebits / 8;
>   		bytes = ALIGN(bytes, length);
>   		bytes += length;
>   	}
> @@ -961,7 +978,11 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>   					       indio_dev->masklength,
>   					       in_ind + 1);
>   			ch = iio_find_channel_from_si(indio_dev, in_ind);
> -			length = ch->scan_type.storagebits/8;
> +			if (ch->scan_type.repeat > 1)
> +				length = ch->scan_type.storagebits / 8 *
> +					ch->scan_type.repeat;
> +			else
> +				length = ch->scan_type.storagebits / 8;
>   			/* Make sure we are aligned */
>   			in_loc += length;
>   			if (in_loc % length)
> @@ -973,7 +994,11 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>   			goto error_clear_mux_table;
>   		}
>   		ch = iio_find_channel_from_si(indio_dev, in_ind);
> -		length = ch->scan_type.storagebits/8;
> +		if (ch->scan_type.repeat > 1)
> +			length = ch->scan_type.storagebits / 8 *
> +				ch->scan_type.repeat;
> +		else
> +			length = ch->scan_type.storagebits / 8;
>   		if (out_loc % length)
>   			out_loc += length - out_loc % length;
>   		if (in_loc % length)
> @@ -994,7 +1019,11 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>   		}
>   		ch = iio_find_channel_from_si(indio_dev,
>   			indio_dev->scan_index_timestamp);
> -		length = ch->scan_type.storagebits/8;
> +		if (ch->scan_type.repeat > 1)
> +			length = ch->scan_type.storagebits / 8 *
> +				ch->scan_type.repeat;
> +		else
> +			length = ch->scan_type.storagebits / 8;
>   		if (out_loc % length)
>   			out_loc += length - out_loc % length;
>   		if (in_loc % length)
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 75a8a20..9f1483b 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -177,6 +177,14 @@ struct iio_event_spec {
>    *			shift:		Shift right by this before masking out
>    *					realbits.
>    *			endianness:	little or big endian
> + *			repeat:		No. of times real/storage bits repeats.
> + *					By default, when repeat is set to 0
> + *					repeat value is treated as 1. When
> + *					repeat value is 0 or 1, then there is
> + *					no change in existing scan element
> + *					type, in sysfs. When set to more than
> + *					1, then the type element in sysfs will
> + *					show repeat value.
>    * @info_mask_separate: What information is to be exported that is specific to
>    *			this channel.
>    * @info_mask_shared_by_type: What information is to be exported that is shared
> @@ -219,6 +227,7 @@ struct iio_chan_spec {
>   		u8	realbits;
>   		u8	storagebits;
>   		u8	shift;
> +		u8	repeat;
>   		enum iio_endian endianness;
>   	} scan_type;
>   	long			info_mask_separate;
>

