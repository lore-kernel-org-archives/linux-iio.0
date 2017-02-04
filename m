Return-Path: <SRS0=hQO8=ZR=gmail.com=marek.vasut@kernel.org>
Subject: Re: [PATCH] iio: adc: handle unknow of_device_id data
To: Arnd Bergmann <arnd@arndb.de>
References: <20170203193756.3848151-1-arnd@arndb.de>
 <d38423fb-2759-4774-1ead-86176908d4b0@gmail.com>
 <CAK8P3a3ROogAmh0g7yPX62UqQ0mTNa5mPMS0Qb1MGsFWFs82aw@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>, Hartmut Knaack
 <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <94e9f5e1-0892-428e-66ed-81d5dd5bf388@gmail.com>
Date: Sat, 4 Feb 2017 22:47:52 +0100
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3ROogAmh0g7yPX62UqQ0mTNa5mPMS0Qb1MGsFWFs82aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 02/04/2017 10:44 PM, Arnd Bergmann wrote:
> On Sat, Feb 4, 2017 at 10:11 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 02/03/2017 06:01 PM, Arnd Bergmann wrote:
>>> diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
>>> index 0c44f72c32a8..331ff9a673be 100644
>>> --- a/drivers/iio/adc/rcar-gyroadc.c
>>> +++ b/drivers/iio/adc/rcar-gyroadc.c
>>> @@ -336,7 +336,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>>>       struct device_node *child;
>>>       struct regulator *vref;
>>>       unsigned int reg;
>>> -     unsigned int adcmode, childmode;
>>> +     unsigned int adcmode = -1, childmode;
>>>       unsigned int sample_width;
>>>       unsigned int num_channels;
>>>       int ret, first = 1;
>>> @@ -366,6 +366,9 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>>>                       channels = rcar_gyroadc_iio_channels_3;
>>>                       num_channels = ARRAY_SIZE(rcar_gyroadc_iio_channels_3);
>>>                       break;
>>> +             default:
>>> +                     dev_err(dev, "unknown device type");
>>
>> Is this verbose output really needed ?
> 
> I don't care much either way, I was just trying to follow what the function does
> for the other failure cases. We can probably drop it though, as this
> would indicate
> a bug in the driver implementation, while the others are about
> incorrect DT data.

I don't really want to pester you too much with minor details, let's
wait for JIC's opinion. If you're resending, please add my Ack,
otherwise consider this patch:

Acked-by: Marek Vasut <marek.vasut@gmail.com>

-- 
Best regards,
Marek Vasut
