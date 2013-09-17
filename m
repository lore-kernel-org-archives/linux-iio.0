Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58271 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab3IQSgF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2013 14:36:05 -0400
Message-ID: <5238AF33.6010201@kernel.org>
Date: Tue, 17 Sep 2013 20:36:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?xYF1a2FzeiBDemVyd2nFhHNraQ==?= <l.czerwinski@samsung.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: st_sensors: Add threshold events support
References: <1372767338-13179-1-git-send-email-l.czerwinski@samsung.com> <1372767338-13179-3-git-send-email-l.czerwinski@samsung.com> <51FE6B68.2040202@kernel.org> <5238262E.1000901@samsung.com>
In-Reply-To: <5238262E.1000901@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


>>>
>>> +#define ST_SENSORS_LSM_EVENTS_MASK \
>>> +        (IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) | \
>>> +        IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
>>> +
>>>   #define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
>>> -                    ch2, s, endian, rbits, sbits, addr) \
>>> +                    ch, s, endian, rbits, sbits, addr) \
>>>   { \
>>>       .type = device_type, \
>>>       .modified = mod, \
>>>       .info_mask_separate = mask, \
>>>       .scan_index = index, \
>>> -    .channel2 = ch2, \
>>> +    .channel = ch, \
>>> +    .channel2 = ch, \
>> This is 'interesting'.  What is the intent?
>>
>> The result will be writing the modifier to both channel and channel2.
>> I don't htink that will have any effect, but it is incorrect so please
>> drop the setting of channel.  It might be more appropriate to name
>> you ch instead as mod or something like that to make it clear what
>> is going on?
>>
> Sorry for no explanation. This was my quick workaround. Probably there is a bug in the industrialio-event.c.
> Documentation says
> 
>  * @channel2:        If there is a second number for a differential
>  *            channel then this is it. If modified is set then the
>  *            value here specifies the modifier.
> 
> So when channel is modified third parameter passed to the IIO_MOD_EVENT_CODE should be chan->channel2 not chan->channel
> 
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 10aa9ef..f146acd 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -276,7 +276,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
>                         goto error_ret;
>                 }
>                 if (chan->modified)
> -                       mask = IIO_MOD_EVENT_CODE(chan->type, 0, chan->channel,
> +                       mask = IIO_MOD_EVENT_CODE(chan->type, 0, chan->channel2,
>                                                   i/IIO_EV_DIR_MAX,
>                                                   i%IIO_EV_DIR_MAX);
>                 else if (chan->differential)
> 
>>>       .address = addr, \
>>>       .scan_type = { \
>>>           .sign = s, \

Ahh, you are quite correct.
Please could you post that patch formally and I'll push it out as a fix.
If not I'll sort it out at the weekend.

Thanks,

Jonathan
