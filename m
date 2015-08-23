Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45127 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbbHWUMR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 23 Aug 2015 16:12:17 -0400
Subject: Re: [PATCH v3 1/2] iio: humidity: si7020: replaced bitmask on
 humidity values with range check
To: Hartmut Knaack <knaack.h@gmx.de>, Nicola Corna <nicola@corna.info>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1440333248-3450-1-git-send-email-nicola@corna.info>
 <55D9EB58.50304@kernel.org> <55DA1A17.2020304@gmx.de>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55DA291F.40403@kernel.org>
Date: Sun, 23 Aug 2015 21:12:15 +0100
MIME-Version: 1.0
In-Reply-To: <55DA1A17.2020304@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/08/15 20:08, Hartmut Knaack wrote:
> Jonathan Cameron schrieb am 23.08.2015 um 17:48:
>> On 23/08/15 13:34, Nicola Corna wrote:
>>> The maximum possible value for the relative humidity is 55575 (100%RH).
>>> This value, if shifted right by 2 bits, uses 14 bits and masking it with
>>> a 12 bit mask removes 2 meaningful bits.
>>> The masking has been replaced with a range check that sets the minimum
>>> value at 786 (0%RH) and the maximum at 13893 (99.998%RH).
>>>
>>> Signed-off-by: Nicola Corna <nicola@corna.info>
>>> Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
>> Applied.  I have taken the view that previously the driver
>> was 'limited' by this rather than a nasty bug.
>> Hence I've queued it up for the next merge window.
>> Applied to the togreg branch of iio.git
>>
> 
> This doesn't work, clamp_val() returns a result, which has to be assigned
> to a variable (*val) in this case. I thought I pointed that out in V2.
backed out...

(hadn't pushed it out anywhere yet anyway ;)

Thanks Harmut.
> 
>> Thanks,
>>
>> Jonathan
>>> ---
>>>  drivers/iio/humidity/si7020.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
>>> index fa3b809..06e6659 100644
>>> --- a/drivers/iio/humidity/si7020.c
>>> +++ b/drivers/iio/humidity/si7020.c
>>> @@ -57,8 +57,12 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
>>>  		if (ret < 0)
>>>  			return ret;
>>>  		*val = ret >> 2;
>>> +		/*
>>> +		 * Humidity values can slightly exceed the 0-100%RH
>>> +		 * range and should be corrected by software
>>> +		 */
>>>  		if (chan->type == IIO_HUMIDITYRELATIVE)
>>> -			*val &= GENMASK(11, 0);
>>> +			clamp_val(*val, 786, 13893);
> 
> This needs to be: *val = clamp_val(...)

> 
>>>  		return IIO_VAL_INT;
>>>  	case IIO_CHAN_INFO_SCALE:
>>>  		if (chan->type == IIO_TEMP)
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 

