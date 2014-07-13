Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:35411 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872AbaGMU7h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 13 Jul 2014 16:59:37 -0400
Message-ID: <53C2F3BF.6080909@kernel.org>
Date: Sun, 13 Jul 2014 22:01:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 12/12] iio:adc:ad799x: Allow to write event config
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net> <1402548856-3564-13-git-send-email-pmeerw@pmeerw.net> <53996012.2050606@metafoo.de>
In-Reply-To: <53996012.2050606@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 09:08, Lars-Peter Clausen wrote:
> On 06/12/2014 06:54 AM, Peter Meerwald wrote:
>> allow to enable events
>>
>> previously, events were always reported as enabled, but actually only
>> implicitly enabled when updating the buffer scan mode
>>
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>
> It's not perfect, but is an improvement over the current situation so,
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>
> Thanks.
Applied (with a little bit of description editing).
As ever, these will all get pushed out to testing for the autobuilders
to play.  I will probably send them on to Greg sometime next weekend.

Thanks,

Jonathan
>
>> ---
>>   drivers/iio/adc/ad799x.c | 34 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
>> index 08bcada3..e37412d 100644
>> --- a/drivers/iio/adc/ad799x.c
>> +++ b/drivers/iio/adc/ad799x.c
>> @@ -375,6 +375,39 @@ static int ad799x_read_event_config(struct iio_dev *indio_dev,
>>       return 0;
>>   }
>>
>> +static int ad799x_write_event_config(struct iio_dev *indio_dev,
>> +                     const struct iio_chan_spec *chan,
>> +                     enum iio_event_type type,
>> +                     enum iio_event_direction dir,
>> +                     int state)
>> +{
>> +    struct ad799x_state *st = iio_priv(indio_dev);
>> +    int ret;
>> +
>> +    mutex_lock(&indio_dev->mlock);
>> +    if (iio_buffer_enabled(indio_dev)) {
>> +        ret = -EBUSY;
>> +        goto done;
>> +    }
>> +
>> +    if (state)
>> +        st->config |= BIT(chan->scan_index) << AD799X_CHANNEL_SHIFT;
>> +    else
>> +        st->config &= ~(BIT(chan->scan_index) << AD799X_CHANNEL_SHIFT);
>> +
>> +    if (st->config >> AD799X_CHANNEL_SHIFT)
>> +        st->config |= AD7998_ALERT_EN;
>> +    else
>> +        st->config &= ~AD7998_ALERT_EN;
>> +
>> +    ret = ad799x_write_config(st, st->config);
>> +
>> +done:
>> +    mutex_unlock(&indio_dev->mlock);
>> +
>> +    return ret;
>> +}
>> +
>>   static unsigned int ad799x_threshold_reg(const struct iio_chan_spec *chan,
>>                        enum iio_event_direction dir,
>>                        enum iio_event_info info)
>> @@ -502,6 +535,7 @@ static const struct iio_info ad7993_4_7_8_irq_info = {
>>       .read_raw = &ad799x_read_raw,
>>       .event_attrs = &ad799x_event_attrs_group,
>>       .read_event_config = &ad799x_read_event_config,
>> +    .write_event_config = &ad799x_write_event_config,
>>       .read_event_value = &ad799x_read_event_value,
>>       .write_event_value = &ad799x_write_event_value,
>>       .driver_module = THIS_MODULE,
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

