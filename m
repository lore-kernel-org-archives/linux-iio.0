Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56059 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbdDNNqX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2017 09:46:23 -0400
Subject: Re: [PATCH] iio: dac: ad7303: fix channel description
To: Lars-Peter Clausen <lars@metafoo.de>, plroskin@gmail.com,
        linux-iio@vger.kernel.org
References: <20170413215423.22070-1-plroskin@gmail.com>
 <852c2b7b-b539-0903-2b02-da73f648e5f0@metafoo.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <427fc3f3-3df0-c003-ca6a-07d3af583005@kernel.org>
Date: Fri, 14 Apr 2017 14:46:21 +0100
MIME-Version: 1.0
In-Reply-To: <852c2b7b-b539-0903-2b02-da73f648e5f0@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/17 09:25, Lars-Peter Clausen wrote:
> On 04/13/2017 11:54 PM, plroskin@gmail.com wrote:
>> From: Pavel Roskin <plroskin@gmail.com>
>>
>> realbits, storagebits and shift should be numbers, not ASCII characters.
>>
>> Signed-off-by: Pavel Roskin <plroskin@gmail.com>
> 
> Thanks for the fix.
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> You really have to wonder how somebody would be able to get that wrong
> in the first place... ;)
Applied and marked for stable. Big oops on this one.

Jonathan
> 
> 
>> ---
>>  drivers/iio/dac/ad7303.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
>> index e690dd11e99f..4b0f942b8914 100644
>> --- a/drivers/iio/dac/ad7303.c
>> +++ b/drivers/iio/dac/ad7303.c
>> @@ -184,9 +184,9 @@ static const struct iio_chan_spec_ext_info ad7303_ext_info[] = {
>>  	.address = (chan),					\
>>  	.scan_type = {						\
>>  		.sign = 'u',					\
>> -		.realbits = '8',				\
>> -		.storagebits = '8',				\
>> -		.shift = '0',					\
>> +		.realbits = 8,					\
>> +		.storagebits = 8,				\
>> +		.shift = 0,					\
>>  	},							\
>>  	.ext_info = ad7303_ext_info,				\
>>  }
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

