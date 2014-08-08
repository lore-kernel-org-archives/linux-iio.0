Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:40465 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755594AbaHHKYA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 8 Aug 2014 06:24:00 -0400
Message-ID: <53E4A53C.8090907@kernel.org>
Date: Fri, 08 Aug 2014 11:23:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:buffer: Wrong sized allocation of demux table elements.
References: <1407487392-1671-1-git-send-email-jic23@kernel.org> <53E48F7D.5030402@metafoo.de>
In-Reply-To: <53E48F7D.5030402@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/08/14 09:51, Lars-Peter Clausen wrote:
> On 08/08/2014 10:43 AM, Jonathan Cameron wrote:
>> The size of the allocation is currently set to the size of the pointer
>> rather than the structure we should actually be allocating.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> Reported-by: kbuild@01.org
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>
> Ok, that answers the earlier question.
>
> Thanks.
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git and pushed out as testing...

Thanks,
>
>> ---
>>   drivers/iio/industrialio-buffer.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index 84a952931f9f..ec82cb0bea38 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -951,7 +951,7 @@ static int iio_buffer_add_demux(struct iio_buffer *buffer,
>>           (*p)->to + (*p)->length == out_loc) {
>>           (*p)->length += length;
>>       } else {
>> -        *p = kmalloc(sizeof(*p), GFP_KERNEL);
>> +        *p = kmalloc(sizeof(**p), GFP_KERNEL);
>>           if (*p == NULL)
>>               return -ENOMEM;
>>           (*p)->from = in_loc;
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

