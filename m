Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:37844 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932593AbeEaCGw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 May 2018 22:06:52 -0400
Received: by mail-it0-f66.google.com with SMTP id l6-v6so12746649iti.2
        for <linux-iio@vger.kernel.org>; Wed, 30 May 2018 19:06:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530142312.GA5434@arch>
References: <20180528153859.813-1-tduszyns@gmail.com> <CAJCx=gnatQnSDFa_XqULgTibov-s=qec-Z3688xZj8dZzY-8Cw@mail.gmail.com>
 <9e2d3be3-bc59-eb62-9410-107091cb17ed@electromag.com.au> <CAJCx=gnDRvDLNwBQ=aJLdmExx+cTDQdOO2Vp5Q8_j=RTGCQKXQ@mail.gmail.com>
 <CAJCx=gkQDpdw7jGdyT72UMOkYkb7bDoMuQW_O_LEvNWApCVHqA@mail.gmail.com> <20180530142312.GA5434@arch>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Thu, 31 May 2018 10:06:50 +0800
Message-ID: <CAJCx=g=TKfyojOH3d7m_4xhFRsGw19Z+aJbA+maGBLnCiJXvKg@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: fix relative humidity unit
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: Phil Reid <preid@electromag.com.au>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, May 30, 2018 at 10:23 PM, Tomasz Duszynski <tduszyns@gmail.com> wrote:
> On Wed, May 30, 2018 at 03:20:37PM +0800, Matt Ranostay wrote:
>> On Wed, May 30, 2018 at 1:05 PM, Matt Ranostay
>> <matt.ranostay@konsulko.com> wrote:
>> > On Wed, May 30, 2018 at 9:17 AM, Phil Reid <preid@electromag.com.au> wrote:
>> >> On 30/05/2018 08:44, Matt Ranostay wrote:
>> >>>
>> >>> On Mon, May 28, 2018 at 11:38 PM, Tomasz Duszynski <tduszyns@gmail.com>
>> >>> wrote:
>> >>>>
>> >>>> According to IIO ABI relative humidity reading should be
>> >>>> returned in milli percent.
>> >>>>
>> >>>> This patch addresses that by applying proper scaling and
>> >>>> returning integer instead of fractional format type specifier.
>> >>>>
>> >>>
>> >>> *sigh* seems this is my mistake, but good catch.  Slight nitpick
>> >>> below.. otherwise looks good
>> >>>
>> >>>> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
>> >>>> ---
>> >>>>   drivers/iio/pressure/bmp280-core.c | 5 ++---
>> >>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>> >>>>
>> >>>> diff --git a/drivers/iio/pressure/bmp280-core.c
>> >>>> b/drivers/iio/pressure/bmp280-core.c
>> >>>> index 5ec3e41b65f2..fe87d27779d9 100644
>> >>>> --- a/drivers/iio/pressure/bmp280-core.c
>> >>>> +++ b/drivers/iio/pressure/bmp280-core.c
>> >>>> @@ -415,10 +415,9 @@ static int bmp280_read_humid(struct bmp280_data
>> >>>> *data, int *val, int *val2)
>> >>>>          }
>> >>>>          comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
>> >>>>
>> >>>> -       *val = comp_humidity;
>> >>>> -       *val2 = 1024;
>> >>>> +       *val = comp_humidity * 1000 / 1024;
>> >>>
>> >>>
>> >>> Minor nitpick  that it would look cleaner as:   (comp_humidity / 1024) *
>> >>> 1000
>> >>>
>> >> be careful of integer division.
>> >>
>> >
>> > Ah yes good point. You will have to check if comp_humidity isn't zero
>> > or it is possible to have a divide-by-zero.
>>
>> D'oh actually divide by zero would be an issue. But you'll want to be
>> sure of possible overflows (doubt that would be an issue here).
>
> What kind of division-by-zero are you meaning? When would that happen
> in this case?
>
>>
>> However it may be better to just add the scaling factor of 1000 with
>> IIO_CHAN_INFO_SCALE  and make the processed value now a raw one.
>
> Is measurement precision your concern here? I would not bother with that
> since the sensor is not a top-notch anyway. Even datasheet itself specifies
> error margin of +/-3% for relative humidity.

As Phil mentioned the original patchset is okay as it is. Now I agree
with him after thinking it through.

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>


>
>>
>> >
>> > - Matt
>> >
>> >>
>> >>>>
>> >>>> -       return IIO_VAL_FRACTIONAL;
>> >>>> +       return IIO_VAL_INT;
>> >>>>   }
>> >>>>
>> >>>>   static int bmp280_read_raw(struct iio_dev *indio_dev,
>> >>>> --
>> >>>> 2.17.0
>> >>
>> >>
>> >>>
>> >>
>> >>
>> >> --
>> >> Regards
>> >> Phil Reid
>> >>
