Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45017 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab3AZKcy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 26 Jan 2013 05:32:54 -0500
Message-ID: <5103B0D4.6020802@kernel.org>
Date: Sat, 26 Jan 2013 10:32:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/7] staging:iio:adis16080: Perform sign extension
References: <1357740079-12326-1-git-send-email-lars@metafoo.de> <50EDCE61.8000001@kernel.org> <50EDD472.7000604@metafoo.de> <50EDDE25.4040101@kernel.org>
In-Reply-To: <50EDDE25.4040101@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2013 09:16 PM, Jonathan Cameron wrote:
> On 01/09/2013 08:34 PM, Lars-Peter Clausen wrote:
>> On 01/09/2013 09:09 PM, Jonathan Cameron wrote:
>>> On 01/09/2013 02:01 PM, Lars-Peter Clausen wrote:
>>>> The adis16080 reports sample values in twos complement. So we need to perform a
>>>> sign extension on the result, otherwise negative values will be reported
>>>> incorrectly as large positive values.
>>>>
>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> Added to fixes-togreg branch of iio.git
All now applied was a little fiddly as somehow the small change
here propogated to the context of about half the remaining patches.

Result all looks fine though...

>>>>
>>>> ---
>>>> This one should go into 3.8 if possible, the rest of the series is for 3.9
>>>> ---
>>>>  drivers/staging/iio/gyro/adis16080_core.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
>>>> index 3525a68..149ff99 100644
>>>> --- a/drivers/staging/iio/gyro/adis16080_core.c
>>>> +++ b/drivers/staging/iio/gyro/adis16080_core.c
>>>> @@ -69,7 +69,7 @@ static int adis16080_spi_read(struct iio_dev *indio_dev,
>>>>  	ret = spi_read(st->us, st->buf, 2);
>>>>  
>>>>  	if (ret == 0)
>>>> -		*val = ((st->buf[0] & 0xF) << 8) | st->buf[1];
>>>> +		*val = sign_extend32(12, ((st->buf[0] & 0xF) << 8) | st->buf[1]);
>>>>  	mutex_unlock(&st->buf_lock);
>>>>  
>>
>> Sorry, now that I look at it from a distance: This is completely wrong...
>> It needs to be,
>>
>> sign_extend32((st->buf[0] & 0xF) << 8) | st->buf[1], 11);
>>
>> Sorry again,
>> - Lars
>>
> Fixed up.
> 
> Hadn't pushed out yet anyway so only messing in my local tree.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
