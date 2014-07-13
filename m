Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:35371 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872AbaGMU5O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 13 Jul 2014 16:57:14 -0400
Message-ID: <53C2F32F.8090102@kernel.org>
Date: Sun, 13 Jul 2014 21:59:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 11/12] iio:adc:ad799x: Return more meaningful event
 enabled state
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net> <1402548856-3564-12-git-send-email-pmeerw@pmeerw.net> <53995FEB.5070207@metafoo.de>
In-Reply-To: <53995FEB.5070207@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 09:08, Lars-Peter Clausen wrote:
> On 06/12/2014 06:54 AM, Peter Meerwald wrote:
>> only report an event as enabled if it actually is enabled
>>
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.
>
> Thanks.
>
>> ---
>>   drivers/iio/adc/ad799x.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
>> index abc36c8..08bcada3 100644
>> --- a/drivers/iio/adc/ad799x.c
>> +++ b/drivers/iio/adc/ad799x.c
>> @@ -364,7 +364,15 @@ static int ad799x_read_event_config(struct iio_dev *indio_dev,
>>                       enum iio_event_type type,
>>                       enum iio_event_direction dir)
>>   {
>> -    return 1;
>> +    struct ad799x_state *st = iio_priv(indio_dev);
>> +
>> +    if (!(st->config & AD7998_ALERT_EN))
>> +        return 0;
>> +
>> +    if ((st->config >> AD799X_CHANNEL_SHIFT) & BIT(chan->scan_index))
>> +        return 1;
>> +
>> +    return 0;
>>   }
>>
>>   static unsigned int ad799x_threshold_reg(const struct iio_chan_spec *chan,
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

