Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49416 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab3K3M1i (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 07:27:38 -0500
Message-ID: <5299D9B7.3090404@kernel.org>
Date: Sat, 30 Nov 2013 12:27:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Brian Lilly <brian@crystalfontz.com>,
	linux-iio@vger.kernel.org, Brent-Crosby <brent@crystalfontz.com>,
	Jim Wall <jimwall@q.com>,
	Hector Palacios <hector.palacios@digi.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] iio: mxs-lradc: compute temperature from channel 8 and
 9
References: <1384857392-2199-1-git-send-email-maxime.ripard@free-electrons.com> <5299D6E6.2080100@kernel.org> <5299D7D1.3050801@kernel.org> <CAHXqBF++HsFLG84vQjWeb=QmgE4yjJqYEj_zLS34m2WMDJ2CRA@mail.gmail.com>
In-Reply-To: <CAHXqBF++HsFLG84vQjWeb=QmgE4yjJqYEj_zLS34m2WMDJ2CRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/30/13 12:24, Michał Mirosław wrote:
> 2013/11/30 Jonathan Cameron <jic23@kernel.org>:
>> On 11/30/13 12:15, Jonathan Cameron wrote:
>>> On 11/19/13 10:36, Maxime Ripard wrote:
>>>> From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>>>
>>>> The mxs LRADC is able to read an internal die temperature sensor. The
>>>> temperature has to be calculated from the value read on channel 8 and channel 9.
>>>> To be able to expose the result to hwmon, implement iio channel 8 as
>>>> (channel 9 - channel 8). Then, implement IIO_CHAN_INFO_SCALE and
>>>> IIO_CHAN_INFO_OFFSET so that it can be processed by hwmon through the in kernel
>>>> provider/consumer mechanism.
>>>>
>>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>>> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
>>> As this is still in staging, I think we can get away with the resulting
>>> ABI change from this patch.
>>>
>>> Applied to the togreg branch of iio.git
>>>
>>> Thanks,
>>>
>>> Jonathan
>> Having said that, there is an odd bit inline that I've just dropped whilst
>> applying the patch.  Shout if I've done this wrong.
>>>> ---
>>>>  drivers/staging/iio/adc/mxs-lradc.c | 91 +++++++++++++++++++++++++++++++------
>>>>  1 file changed, 78 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
>>>> index a08c1736458b..fec76090dae5 100644
>>>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>>>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>>>> @@ -231,20 +231,11 @@ struct mxs_lradc {
>>>>  /*
>>>>   * Raw I/O operations
>>>>   */
>>>> -static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>>>> -                    const struct iio_chan_spec *chan,
>>>> -                    int *val, int *val2, long m)
>>>> +static int mxs_lradc_read_single(struct iio_dev *iio_dev, int chan, int *val)
> [...]
>>>> @@ -269,7 +260,7 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
> [...]
>>>> -    writel(chan->channel, lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
>>>> +    writel(chan, lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
>>
>> This doesn't make any sense.  I'm guessing it drifted in from a different patch?
> 
> 'chan' changed type here, and the function got a new name. I would
> assume thant this won't build if you dropped the part above.
Right you are... I'll fix this up later if I can.  For now I'll drop it from my tree.
> 
> Best Regards,
> Michał Mirosław
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
