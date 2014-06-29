Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:56388 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbaF2Opo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 29 Jun 2014 10:45:44 -0400
Message-ID: <53B02713.1070702@kernel.org>
Date: Sun, 29 Jun 2014 15:47:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 01/12] iio:adc:ad799x: Fix reading and writing of event
 values, apply shift
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net> <1402548856-3564-2-git-send-email-pmeerw@pmeerw.net> <53995FD2.1040603@metafoo.de> <539C5A0B.8030407@kernel.org>
In-Reply-To: <539C5A0B.8030407@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/06/14 15:19, Jonathan Cameron wrote:
> On 12/06/14 09:07, Lars-Peter Clausen wrote:
>> On 06/12/2014 06:54 AM, Peter Meerwald wrote:
>>> last two bits of ADC and limit values are zero and should not be reported
>>> (ad7993, ad7997); compare with read_raw()
>>>
>>> event values are 10 (ad7993, ad7997) or 12 bit max., check the range on write
>>>
>>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>>
>> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> Given I've been rather slow on pull requests yet, fixes-togreg has this file
> in the wrong place at the moment.  Hence I've applied this to
> fixes-togreg-post-3.16-rc1.
>
> I'll unwind this over the next day or so.
Oops, took me rather longer that that - sorry.

Anyhow, just sent pull request that includes this first patch so we
are underway!
>>
>> Thanks.
>>
>>> ---
>>>   drivers/iio/adc/ad799x.c | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
>>> index 39b4cb4..6eba301 100644
>>> --- a/drivers/iio/adc/ad799x.c
>>> +++ b/drivers/iio/adc/ad799x.c
>>> @@ -427,9 +427,12 @@ static int ad799x_write_event_value(struct iio_dev *indio_dev,
>>>       int ret;
>>>       struct ad799x_state *st = iio_priv(indio_dev);
>>>
>>> +    if (val < 0 || val > RES_MASK(chan->scan_type.realbits))
>>> +        return -EINVAL;
>>> +
>>>       mutex_lock(&indio_dev->mlock);
>>>       ret = ad799x_i2c_write16(st, ad799x_threshold_reg(chan, dir, info),
>>> -        val);
>>> +        val << chan->scan_type.shift);
>>>       mutex_unlock(&indio_dev->mlock);
>>>
>>>       return ret;
>>> @@ -452,7 +455,8 @@ static int ad799x_read_event_value(struct iio_dev *indio_dev,
>>>       mutex_unlock(&indio_dev->mlock);
>>>       if (ret < 0)
>>>           return ret;
>>> -    *val = valin;
>>> +    *val = (valin >> chan->scan_type.shift) &
>>> +        RES_MASK(chan->scan_type.realbits);
>>>
>>>       return IIO_VAL_INT;
>>>   }
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

