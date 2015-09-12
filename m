Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56011 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324AbbILKOv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Sep 2015 06:14:51 -0400
Subject: Re: [PATCH 1/6] iio:dac:m62332: share scale and offset
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1440459082.git.knaack.h@gmx.de>
 <1d2903d19cf988620b155b16ea58dd13d392f598.1440459082.git.knaack.h@gmx.de>
 <55E46A68.5080906@kernel.org> <55F3FA53.60104@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55F3FB19.6070705@kernel.org>
Date: Sat, 12 Sep 2015 11:14:49 +0100
MIME-Version: 1.0
In-Reply-To: <55F3FA53.60104@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/09/15 11:11, Jonathan Cameron wrote:
> On 31/08/15 15:53, Jonathan Cameron wrote:
>> On 28/08/15 22:59, Hartmut Knaack wrote:
>>> This device simply uses its Vcc as reference voltage, so the same scale
>>> applies for all channels. Also offset doesn't appear to be different for
>>> any channel. Represent this by switching these two attributes to
>>> info_mask_shared_by_type.
>>>
>>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>> This sort of tidy up is always a little interesting.  Technically it
>> is an ABI change (be it one that changes from one possible representation
>> to a better one).  Unfortunately technically we can't rely on users
>> using a library or similar that would hide this detail for them.
>>
>> Still we can make the change if no one notices.  Perhaps
>> Dmitry will want to comment on this however, so I'll let it sit for a while
>> longer.
>>
>> Jonathan
> Applied to the togreg branch of iio.git.  As ever, pushed out first as
> testing for the autobuilders to play with it.
Oops, had forgotten these were waiting on a tested-by from Dmitry.
Backed out again for now.

Sorry about that.

Jonathan
> 
> Thanks,
> 
> Jonathan
>>> ---
>>> Hope you don't mind too much, that I inserted an extra tab in the whole
>>> block rather than messing up style and cleaning it up later.
>>>
>>>  drivers/iio/dac/m62332.c | 18 +++++++++---------
>>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
>>> index c23d7fa889ee..cffc0630ed32 100644
>>> --- a/drivers/iio/dac/m62332.c
>>> +++ b/drivers/iio/dac/m62332.c
>>> @@ -173,15 +173,15 @@ static const struct iio_info m62332_info = {
>>>  	.driver_module = THIS_MODULE,
>>>  };
>>>  
>>> -#define M62332_CHANNEL(chan) {				\
>>> -	.type = IIO_VOLTAGE,				\
>>> -	.indexed = 1,					\
>>> -	.output = 1,					\
>>> -	.channel = (chan),				\
>>> -	.datasheet_name = "CH" #chan,			\
>>> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
>>> -		BIT(IIO_CHAN_INFO_SCALE) |		\
>>> -		BIT(IIO_CHAN_INFO_OFFSET),		\
>>> +#define M62332_CHANNEL(chan) {					\
>>> +	.type = IIO_VOLTAGE,					\
>>> +	.indexed = 1,						\
>>> +	.output = 1,						\
>>> +	.channel = (chan),					\
>>> +	.datasheet_name = "CH" #chan,				\
>>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
>>> +				    BIT(IIO_CHAN_INFO_OFFSET),	\
>>>  }
>>>  
>>>  static const struct iio_chan_spec m62332_channels[M62332_CHANNELS] = {
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

