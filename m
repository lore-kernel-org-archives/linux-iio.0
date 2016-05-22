Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52436 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbcEVTzy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2016 15:55:54 -0400
Subject: Re: [PATCH 3/3] iio: proximity: as3935: fix buffer stack trashing
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1463886063-20004-1-git-send-email-mranostay@gmail.com>
 <1463886063-20004-4-git-send-email-mranostay@gmail.com>
 <861A0A5C-29E2-432A-9E9C-0AD3844426AF@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <524a6be8-bd1f-9319-9eaf-63638aaa190c@kernel.org>
Date: Sun, 22 May 2016 20:55:52 +0100
MIME-Version: 1.0
In-Reply-To: <861A0A5C-29E2-432A-9E9C-0AD3844426AF@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/05/16 07:28, Matt Ranostay wrote:
> 
>> On May 21, 2016, at 20:01, Matt Ranostay <mranostay@gmail.com> wrote:
>>
>> Buffer wasn't of a valid size to allow the timestamp, and correct padding.
>> This patchset also moves the buffer off the stack, and onto the heap.
>>
>> Cc: george.mccollister@gmail.com
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied as per the other 2.
>> ---
>> drivers/iio/proximity/as3935.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
>> index 6aed024..8730451 100644
>> --- a/drivers/iio/proximity/as3935.c
>> +++ b/drivers/iio/proximity/as3935.c
>> @@ -64,6 +64,7 @@ struct as3935_state {
>>    struct delayed_work work;
>>
>>    u32 tune_cap;
>> +    u8 buffer[16]; /* 8-bit data + 54-bit padding + 64-bit timestamp */
> 
> Just noticed that should be noted as 56-bit
Fixed up.
> 
>>    u8 buf[2] ____cacheline_aligned;
>> };
>>
>> @@ -212,9 +213,10 @@ static irqreturn_t as3935_trigger_handler(int irq, void *private)
>>    ret = as3935_read(st, AS3935_DATA, &val);
>>    if (ret)
>>        goto err_read;
>> -    val &= AS3935_DATA_MASK;
>>
>> -    iio_push_to_buffers_with_timestamp(indio_dev, &val, pf->timestamp);
>> +    st->buffer[0] = val & AS3935_DATA_MASK;
>> +    iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
>> +                       pf->timestamp);
>> err_read:
>>    iio_trigger_notify_done(indio_dev->trig);
>>
>> -- 
>> 2.7.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

