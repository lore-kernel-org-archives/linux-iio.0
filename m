Return-Path: <jic23@jic23.retrosnub.co.uk>
References: <1341060763-9602-1-git-send-email-jic23@kernel.org> <1341060763-9602-3-git-send-email-jic23@kernel.org> <201208242342.59307.marex@denx.de>
In-Reply-To: <201208242342.59307.marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 2/2] iio: kfifo - add poll support.
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Sat, 25 Aug 2012 09:24:15 +0100
To: Marek Vasut <marex@denx.de>,Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Message-ID: <5ab3b5d5-5667-45c5-931d-a158e4c553dd@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



Marek Vasut <marex@denx.de> wrote:

>Dear Jonathan Cameron,
>
>> This buffer implementation was missing poll support.
>> 
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>
>Was this ever applied ?
On todo  list.  Always easier to not get around to my own patches when running low on time.  Will hopefully get time on Monday...
>
>> ---
>>  drivers/iio/kfifo_buf.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
>> index 6ec763f..63da424 100644
>> --- a/drivers/iio/kfifo_buf.c
>> +++ b/drivers/iio/kfifo_buf.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/kfifo.h>
>>  #include <linux/mutex.h>
>>  #include <linux/iio/kfifo_buf.h>
>> +#include <linux/sched.h>
>> 
>>  struct iio_kfifo {
>>  	struct iio_buffer buffer;
>> @@ -36,6 +37,7 @@ static int iio_request_update_kfifo(struct
>iio_buffer *r)
>>  	kfifo_free(&buf->kf);
>>  	ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
>>  				   buf->buffer.length);
>> +	r->stufftoread = false;
>>  error_ret:
>>  	return ret;
>>  }
>> @@ -82,6 +84,9 @@ static int iio_set_bytes_per_datum_kfifo(struct
>> iio_buffer *r, size_t bpd)
>> 
>>  static int iio_set_length_kfifo(struct iio_buffer *r, int length)
>>  {
>> +	/* Avoid an invalid state */
>> +	if (length < 2)
>> +		length = 2;
>>  	if (r->length != length) {
>>  		r->length = length;
>>  		iio_mark_update_needed_kfifo(r);
>> @@ -98,6 +103,8 @@ static int iio_store_to_kfifo(struct iio_buffer
>*r,
>>  	ret = kfifo_in(&kf->kf, data, 1);
>>  	if (ret != 1)
>>  		return -EBUSY;
>> +	r->stufftoread = true;
>> +	wake_up_interruptible(&r->pollq);
>> 
>>  	return 0;
>>  }
>> @@ -115,6 +122,12 @@ static int iio_read_first_n_kfifo(struct
>iio_buffer
>> *r, if (ret < 0)
>>  		return ret;
>> 
>> +	if (kfifo_is_empty(&kf->kf))
>> +		r->stufftoread = false;
>> +	/* verify it is still empty to avoid race */
>> +	if (!kfifo_is_empty(&kf->kf))
>> +		r->stufftoread = true;
>> +
>>  	return copied;
>>  }
>> 
>> @@ -139,7 +152,7 @@ struct iio_buffer *iio_kfifo_allocate(struct
>iio_dev
>> *indio_dev) iio_buffer_init(&kf->buffer);
>>  	kf->buffer.attrs = &iio_kfifo_attribute_group;
>>  	kf->buffer.access = &kfifo_access_funcs;
>> -
>> +	kf->buffer.length = 2;
>>  	return &kf->buffer;
>>  }
>>  EXPORT_SYMBOL(iio_kfifo_allocate);
>
>Best regards,
>Marek Vasut
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
