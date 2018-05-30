Return-Path: <SRS0=SmN6=IR=konsulko.com=matt.ranostay@kernel.org>
MIME-Version: 1.0
In-Reply-To: <9e2d3be3-bc59-eb62-9410-107091cb17ed@electromag.com.au>
References: <20180528153859.813-1-tduszyns@gmail.com> <CAJCx=gnatQnSDFa_XqULgTibov-s=qec-Z3688xZj8dZzY-8Cw@mail.gmail.com>
 <9e2d3be3-bc59-eb62-9410-107091cb17ed@electromag.com.au>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Wed, 30 May 2018 13:05:15 +0800
Message-ID: <CAJCx=gnDRvDLNwBQ=aJLdmExx+cTDQdOO2Vp5Q8_j=RTGCQKXQ@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: fix relative humidity unit
To: Phil Reid <preid@electromag.com.au>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 30, 2018 at 9:17 AM, Phil Reid <preid@electromag.com.au> wrote:
> On 30/05/2018 08:44, Matt Ranostay wrote:
>>
>> On Mon, May 28, 2018 at 11:38 PM, Tomasz Duszynski <tduszyns@gmail.com>
>> wrote:
>>>
>>> According to IIO ABI relative humidity reading should be
>>> returned in milli percent.
>>>
>>> This patch addresses that by applying proper scaling and
>>> returning integer instead of fractional format type specifier.
>>>
>>
>> *sigh* seems this is my mistake, but good catch.  Slight nitpick
>> below.. otherwise looks good
>>
>>> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
>>> ---
>>>   drivers/iio/pressure/bmp280-core.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/pressure/bmp280-core.c
>>> b/drivers/iio/pressure/bmp280-core.c
>>> index 5ec3e41b65f2..fe87d27779d9 100644
>>> --- a/drivers/iio/pressure/bmp280-core.c
>>> +++ b/drivers/iio/pressure/bmp280-core.c
>>> @@ -415,10 +415,9 @@ static int bmp280_read_humid(struct bmp280_data
>>> *data, int *val, int *val2)
>>>          }
>>>          comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
>>>
>>> -       *val = comp_humidity;
>>> -       *val2 = 1024;
>>> +       *val = comp_humidity * 1000 / 1024;
>>
>>
>> Minor nitpick  that it would look cleaner as:   (comp_humidity / 1024) *
>> 1000
>>
> be careful of integer division.
>

Ah yes good point. You will have to check if comp_humidity isn't zero
or it is possible to have a divide-by-zero.

- Matt

>
>>>
>>> -       return IIO_VAL_FRACTIONAL;
>>> +       return IIO_VAL_INT;
>>>   }
>>>
>>>   static int bmp280_read_raw(struct iio_dev *indio_dev,
>>> --
>>> 2.17.0
>
>
>>
>
>
> --
> Regards
> Phil Reid
>
