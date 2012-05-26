Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48609 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab2EZJKi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 26 May 2012 05:10:38 -0400
Message-ID: <4FC0AC19.6080903@kernel.org>
Date: Sat, 26 May 2012 11:10:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, stefani@seibold.net, ggao@invensense.com
Subject: Re: [PATCH] iio:kfifo_buf  Take advantage of the fixed record size
 used in IIO
References: <1337426045-6890-1-git-send-email-jic23@kernel.org> <4FBB2AA7.2020009@metafoo.de>
In-Reply-To: <4FBB2AA7.2020009@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/22/2012 06:56 AM, Lars-Peter Clausen wrote:
> On 05/19/2012 01:14 PM, Jonathan Cameron wrote:
>> By bypassing the standard macros for setting up the kfifo we can
>> take advantage of the fixed record size implementation without
>> having to have a type to pass in (from which the size of an element
>> is normally established).
>>
>> In IIO we have variable 'scans' as our records in which any element
>> can be present or not.  They do not however vary when we are
>> actually filling or reading from the buffer.  Thus we have a fixed
>> record size whenever we are actually running.  As setup and tear
>> down are not in the fast path we can take the overhead of reinitializing
>> the kfifo every time.
>>
>> This is an RFC as
>>
>> a) I'm far from sure I got it right.
>> b) There is probably a better way of doing it!
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>> Note this is against current staging-next.
>>
>>
>>  drivers/iio/kfifo_buf.c |    7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
>> index 6bf9d05..74b1cb8 100644
>> --- a/drivers/iio/kfifo_buf.c
>> +++ b/drivers/iio/kfifo_buf.c
>> @@ -22,7 +22,8 @@ static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
>>  		return -EINVAL;
>>  
>>  	__iio_update_buffer(&buf->buffer, bytes_per_datum, length);
>> -	return kfifo_alloc(&buf->kf, bytes_per_datum*length, GFP_KERNEL);
>> +	return __kfifo_alloc((struct __kfifo *)&buf->kf, length,
>> +			     bytes_per_datum, GFP_KERNEL);
>>  }
>>  
>>  static int iio_request_update_kfifo(struct iio_buffer *r)
>> @@ -94,7 +95,7 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
>>  {
>>  	int ret;
>>  	struct iio_kfifo *kf = iio_to_kfifo(r);
>> -	ret = kfifo_in(&kf->kf, data, r->bytes_per_datum);
>> +	ret = __kfifo_in((struct __kfifo *)&kf->kf, data, r->bytes_per_datum);
> 
> The last parameter has to be 1 now, since we want to store one record. And I
> think we can still use kfifo_in(...), the macro magic take care of doing the
> right thing.
good point on the macro. I got lost following that the first time, but
with the alloc as above, recsize will be zero and all it will fall
through to this.
> 
>>  	if (ret != r->bytes_per_datum)
>>  		return -EBUSY;
>>  	return 0;
>> @@ -110,7 +111,7 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
>>  		return -EINVAL;
>>  
>>  	n = rounddown(n, r->bytes_per_datum);
>> -	ret = kfifo_to_user(&kf->kf, buf, n, &copied);
> 
> Same here. n needs to be n / r->bytes_per_datum
indeed it does. also looks like the kfifo_to_user macro will work I think...

Will resend.  Having one of those fun days of bisecting at the moment to
find out what broke my test board...
> 
>> +	ret = __kfifo_to_user((struct __kfifo *)&kf->kf, buf, n, &copied);
>>  
>>  	return copied;
>>  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

