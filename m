Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39380 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933621Ab3AIVQZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jan 2013 16:16:25 -0500
Message-ID: <50EDDE25.4040101@kernel.org>
Date: Wed, 09 Jan 2013 21:16:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/7] staging:iio:adis16080: Perform sign extension
References: <1357740079-12326-1-git-send-email-lars@metafoo.de> <50EDCE61.8000001@kernel.org> <50EDD472.7000604@metafoo.de>
In-Reply-To: <50EDD472.7000604@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2013 08:34 PM, Lars-Peter Clausen wrote:
> On 01/09/2013 09:09 PM, Jonathan Cameron wrote:
>> On 01/09/2013 02:01 PM, Lars-Peter Clausen wrote:
>>> The adis16080 reports sample values in twos complement. So we need to perform a
>>> sign extension on the result, otherwise negative values will be reported
>>> incorrectly as large positive values.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Added to fixes-togreg branch of iio.git
>>>
>>> ---
>>> This one should go into 3.8 if possible, the rest of the series is for 3.9
>>> ---
>>>  drivers/staging/iio/gyro/adis16080_core.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
>>> index 3525a68..149ff99 100644
>>> --- a/drivers/staging/iio/gyro/adis16080_core.c
>>> +++ b/drivers/staging/iio/gyro/adis16080_core.c
>>> @@ -69,7 +69,7 @@ static int adis16080_spi_read(struct iio_dev *indio_dev,
>>>  	ret = spi_read(st->us, st->buf, 2);
>>>  
>>>  	if (ret == 0)
>>> -		*val = ((st->buf[0] & 0xF) << 8) | st->buf[1];
>>> +		*val = sign_extend32(12, ((st->buf[0] & 0xF) << 8) | st->buf[1]);
>>>  	mutex_unlock(&st->buf_lock);
>>>  
> 
> Sorry, now that I look at it from a distance: This is completely wrong...
> It needs to be,
> 
> sign_extend32((st->buf[0] & 0xF) << 8) | st->buf[1], 11);
> 
> Sorry again,
> - Lars
> 
Fixed up.

Hadn't pushed out yet anyway so only messing in my local tree.
