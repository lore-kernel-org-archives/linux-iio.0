Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51221 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbdANM3K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2017 07:29:10 -0500
Subject: Re: [PATCH] iio: inkern: pass through raw values if no scaling
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org
References: <20170111104839.11129-1-linus.walleij@linaro.org>
 <BD7195F1-A9E6-4538-840D-25A2AAC5D850@jic23.retrosnub.co.uk>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e7fa8767-803b-0396-a329-dd1bd2461b67@kernel.org>
Date: Sat, 14 Jan 2017 12:21:56 +0000
MIME-Version: 1.0
In-Reply-To: <BD7195F1-A9E6-4538-840D-25A2AAC5D850@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/01/17 14:39, Jonathan Cameron wrote:
> 
> 
> On 11 January 2017 10:48:39 GMT+00:00, Linus Walleij <linus.walleij@linaro.org> wrote:
>> When a consumer calls iio_read_channel_processed() the IIO core
>> tries to apply scaling to the value, but if the channel only
>> supports reading raw values, we should return that raw value
>> to the cosumer instead of an error.
>>
>> This is what userspace is expected to do with sensors only
>> providing raw values so the kernel should do the same, so as to
>> avoid adding scaling boilerplate to drivers for hardware that
>> actually return processed values from raw reads.
> Hmm. I guess this is reasonable as it would be correct to have a raw value if the scale was 1
>  and hence not supplied, but there was an offset
> If neither is supplied so scale is 1 and offset 0 
> then having it as raw is a bug.
> 
> Come to think of it the raw element is only useful on the case where we have no known units.
> Otherwise the absence of offset and scale alone would indicate a processed value.
> 
> Upshot is I agree with change but might add info to patch message when I apply it.  Arguably
>  userspace should be specifically indicating that there is no known transform (perhaps by not
>  listing units) rather than sweeping it under the carpet.  This is perfectly valid for many intensity
>  of reflection proximity sensors where the meaning of the value is dependant on the material which we can't know.
> 
> 
> Fun fun fun 
Applied with a note about the above.

Thanks,

Jonathan
> 
> Jonathan
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> drivers/iio/inkern.c | 10 ++++++++--
>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>> index b0f4630a163f..7a13535dc3e9 100644
>> --- a/drivers/iio/inkern.c
>> +++ b/drivers/iio/inkern.c
>> @@ -601,8 +601,14 @@ static int
>> iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>>
>> 	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
>> 					IIO_CHAN_INFO_SCALE);
>> -	if (scale_type < 0)
>> -		return scale_type;
>> +	if (scale_type < 0) {
>> +		/*
>> +		 * Just pass raw values as processed if no scaling is
>> +		 * available.
>> +		 */
>> +		*processed = raw;
>> +		return 0;
>> +	}
>>
>> 	switch (scale_type) {
>> 	case IIO_VAL_INT:
> 

