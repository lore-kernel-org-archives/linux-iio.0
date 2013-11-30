Return-Path: <mirqus@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5299D7D1.3050801@kernel.org>
References: <1384857392-2199-1-git-send-email-maxime.ripard@free-electrons.com>
 <5299D6E6.2080100@kernel.org> <5299D7D1.3050801@kernel.org>
From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date: Sat, 30 Nov 2013 13:24:23 +0100
Message-ID: <CAHXqBF++HsFLG84vQjWeb=QmgE4yjJqYEj_zLS34m2WMDJ2CRA@mail.gmail.com>
Subject: Re: [PATCH] iio: mxs-lradc: compute temperature from channel 8 and 9
To: Jonathan Cameron <jic23@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Brian Lilly <brian@crystalfontz.com>, linux-iio@vger.kernel.org,
	Brent-Crosby <brent@crystalfontz.com>, Jim Wall <jimwall@q.com>,
	Hector Palacios <hector.palacios@digi.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2013/11/30 Jonathan Cameron <jic23@kernel.org>:
> On 11/30/13 12:15, Jonathan Cameron wrote:
>> On 11/19/13 10:36, Maxime Ripard wrote:
>>> From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>>
>>> The mxs LRADC is able to read an internal die temperature sensor. The
>>> temperature has to be calculated from the value read on channel 8 and c=
hannel 9.
>>> To be able to expose the result to hwmon, implement iio channel 8 as
>>> (channel 9 - channel 8). Then, implement IIO_CHAN_INFO_SCALE and
>>> IIO_CHAN_INFO_OFFSET so that it can be processed by hwmon through the i=
n kernel
>>> provider/consumer mechanism.
>>>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
>> As this is still in staging, I think we can get away with the resulting
>> ABI change from this patch.
>>
>> Applied to the togreg branch of iio.git
>>
>> Thanks,
>>
>> Jonathan
> Having said that, there is an odd bit inline that I've just dropped whils=
t
> applying the patch.  Shout if I've done this wrong.
>>> ---
>>>  drivers/staging/iio/adc/mxs-lradc.c | 91 +++++++++++++++++++++++++++++=
++------
>>>  1 file changed, 78 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/=
adc/mxs-lradc.c
>>> index a08c1736458b..fec76090dae5 100644
>>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>>> @@ -231,20 +231,11 @@ struct mxs_lradc {
>>>  /*
>>>   * Raw I/O operations
>>>   */
>>> -static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>>> -                    const struct iio_chan_spec *chan,
>>> -                    int *val, int *val2, long m)
>>> +static int mxs_lradc_read_single(struct iio_dev *iio_dev, int chan, in=
t *val)
[...]
>>> @@ -269,7 +260,7 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_d=
ev,
[...]
>>> -    writel(chan->channel, lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_=
SET);
>>> +    writel(chan, lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
>
> This doesn't make any sense.  I'm guessing it drifted in from a different=
 patch?

'chan' changed type here, and the function got a new name. I would
assume thant this won't build if you dropped the part above.

Best Regards,
Micha=C5=82 Miros=C5=82aw
