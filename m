Return-Path: <SRS0=eKUd=IR=electromag.com.au=preid@kernel.org>
Subject: Re: [PATCH] iio: pressure: bmp280: fix relative humidity unit
To: Matt Ranostay <matt.ranostay@konsulko.com>,
  Tomasz Duszynski <tduszyns@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
  Linus Walleij <linus.walleij@linaro.org>
References: <20180528153859.813-1-tduszyns@gmail.com>
 <CAJCx=gnatQnSDFa_XqULgTibov-s=qec-Z3688xZj8dZzY-8Cw@mail.gmail.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <9e2d3be3-bc59-eb62-9410-107091cb17ed@electromag.com.au>
Date: Wed, 30 May 2018 09:17:37 +0800
MIME-Version: 1.0
In-Reply-To: <CAJCx=gnatQnSDFa_XqULgTibov-s=qec-Z3688xZj8dZzY-8Cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 30/05/2018 08:44, Matt Ranostay wrote:
> On Mon, May 28, 2018 at 11:38 PM, Tomasz Duszynski <tduszyns@gmail.com> wrote:
>> According to IIO ABI relative humidity reading should be
>> returned in milli percent.
>>
>> This patch addresses that by applying proper scaling and
>> returning integer instead of fractional format type specifier.
>>
> 
> *sigh* seems this is my mistake, but good catch.  Slight nitpick
> below.. otherwise looks good
> 
>> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
>> ---
>>   drivers/iio/pressure/bmp280-core.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
>> index 5ec3e41b65f2..fe87d27779d9 100644
>> --- a/drivers/iio/pressure/bmp280-core.c
>> +++ b/drivers/iio/pressure/bmp280-core.c
>> @@ -415,10 +415,9 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
>>          }
>>          comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
>>
>> -       *val = comp_humidity;
>> -       *val2 = 1024;
>> +       *val = comp_humidity * 1000 / 1024;
> 
> Minor nitpick  that it would look cleaner as:   (comp_humidity / 1024) * 1000
> 
be careful of integer division.


>>
>> -       return IIO_VAL_FRACTIONAL;
>> +       return IIO_VAL_INT;
>>   }
>>
>>   static int bmp280_read_raw(struct iio_dev *indio_dev,
>> --
>> 2.17.0

> 


-- 
Regards
Phil Reid
