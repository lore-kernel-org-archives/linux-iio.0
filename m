Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:52290 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932513Ab1LERCZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2011 12:02:25 -0500
References: <1323032222-21338-1-git-send-email-jic23@kernel.org> <1323032222-21338-5-git-send-email-jic23@kernel.org> <4EDC968D.1090807@metafoo.de>
In-Reply-To: <4EDC968D.1090807@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 4/7] staging:iio: make iio_sw_buffer_preenable much more general.
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Mon, 05 Dec 2011 17:02:13 +0000
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Message-ID: <2be8b6df-476a-4818-9b17-75b33a70633d@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Lars-Peter Clausen <lars@metafoo.de> wrote:

>On 12/04/2011 09:56 PM, Jonathan Cameron wrote:
>> Also introduces active_scan_mask storage to tell the core what is
>> really being currently captured from the device (different from
>> what is desired as often has bonus channels).
>> 
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>
>Tested-and-Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>
>One minor comment inline though.
>
>> ---
>>  drivers/staging/iio/iio.h                 |    2 +
>>  drivers/staging/iio/industrialio-buffer.c |   64
>+++++++++++++++++------------
>>  2 files changed, 40 insertions(+), 26 deletions(-)
>> 
>> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
>> index 4fb8f2f..c225542 100644
>> --- a/drivers/staging/iio/iio.h
>> +++ b/drivers/staging/iio/iio.h
>> @@ -280,6 +280,7 @@ struct iio_info {
>>   * @available_scan_masks: [DRIVER] optional array of allowed
>bitmasks
>>   * @masklength:		[INTERN] the length of the mask established from
>>   *			channels
>> + * @active_scan_mask:	[INTERN] union of all scan masks requested by
>buffers
>>   * @trig:		[INTERN] current device trigger (buffer modes)
>>   * @pollfunc:		[DRIVER] function run on trigger being received
>>   * @channels:		[DRIVER] channel specification structure table
>> @@ -307,6 +308,7 @@ struct iio_dev {
>>  
>>  	unsigned long			*available_scan_masks;
>>  	unsigned			masklength;
>> +	unsigned long			*active_scan_mask;
>>  	struct iio_trigger		*trig;
>>  	struct iio_poll_func		*pollfunc;
>>  
>> diff --git a/drivers/staging/iio/industrialio-buffer.c
>b/drivers/staging/iio/industrialio-buffer.c
>> index b2cf3e3..7dedeca 100644
>> --- a/drivers/staging/iio/industrialio-buffer.c
>> +++ b/drivers/staging/iio/industrialio-buffer.c
>> @@ -531,32 +531,6 @@ ssize_t iio_buffer_show_enable(struct device
>*dev,
>>  }
>>  EXPORT_SYMBOL(iio_buffer_show_enable);
>>  
>> -int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
>> -{
>> -	struct iio_buffer *buffer = indio_dev->buffer;
>> -	size_t size;
>> -	dev_dbg(&indio_dev->dev, "%s\n", __func__);
>> -	/* Check if there are any scan elements enabled, if not fail*/
>> -	if (!(buffer->scan_count || buffer->scan_timestamp))
>> -		return -EINVAL;
>> -	if (buffer->scan_timestamp)
>> -		if (buffer->scan_count)
>> -			/* Timestamp (aligned to s64) and data */
>> -			size = (((buffer->scan_count * buffer->bpe)
>> -					+ sizeof(s64) - 1)
>> -				& ~(sizeof(s64) - 1))
>> -				+ sizeof(s64);
>> -		else /* Timestamp only  */
>> -			size = sizeof(s64);
>> -	else /* Data only */
>> -		size = buffer->scan_count * buffer->bpe;
>> -	buffer->access->set_bytes_per_datum(buffer, size);
>> -
>> -	return 0;
>> -}
>> -EXPORT_SYMBOL(iio_sw_buffer_preenable);
>> -
>> -
>>  /* note NULL used as error indicator as it doesn't make sense. */
>>  static unsigned long *iio_scan_mask_match(unsigned long *av_masks,
>>  					  unsigned int masklength,
>> @@ -572,6 +546,44 @@ static unsigned long
>*iio_scan_mask_match(unsigned long *av_masks,
>>  	return NULL;
>>  }
>>  
>> +int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
>> +{
>> +	struct iio_buffer *buffer = indio_dev->buffer;
>> +	const struct iio_chan_spec *ch;
>> +	unsigned bytes = 0;
>> +	int length, i;
>> +	dev_dbg(&indio_dev->dev, "%s\n", __func__);
>> +
>> +	/* How much space will the demuxed element take? */
>> +	for_each_set_bit(i, buffer->scan_mask,
>> +			 indio_dev->masklength) {
>> +		ch = iio_find_channel_from_si(indio_dev, i);
>> +		length = ch->scan_type.storagebits/8;
>> +		bytes = ALIGN(bytes, length);
>> +		bytes += length;
>> +	}
>> +	if (buffer->scan_timestamp) {
>> +		ch = iio_find_channel_from_si(indio_dev,
>> +					      buffer->scan_index_timestamp);
>> +		length = ch->scan_type.storagebits/8;
>> +		if (bytes % length)
>> +			bytes += length - bytes % length;
>> +		bytes += length;
>
>Could use ALIGN as-well. Btw. ALIGN only works on powers of two. Do we
>expect other storage sizes? If yes we should probably use roundup()
>instead.
>
Probably only powers of 2.  We can change if /when it becomes necessary.
>> +	}
>> +	buffer->access->set_bytes_per_datum(buffer, bytes);
>> +
>> +	/* What scan mask do we actually have ?*/
>> +	if (indio_dev->available_scan_masks)
>> +		indio_dev->active_scan_mask =
>> +			iio_scan_mask_match(indio_dev->available_scan_masks,
>> +					    indio_dev->masklength,
>> +					    buffer->scan_mask);
>> +	else
>> +		indio_dev->active_scan_mask = buffer->scan_mask;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(iio_sw_buffer_preenable);
>> +
>>  /**
>>   * iio_scan_mask_set() - set particular bit in the scan mask
>>   * @buffer: the buffer whose scan mask we are interested in

-- 
Sent from my Android phone 
with K-9 Mail. Please excuse my brevity.
