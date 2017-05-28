Return-Path: <SRS0=M4Vo=5C=googlemail.com=martin.blumenstingl@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170528154309.243555e3@kernel.org>
References: <20170528112438.10427-1-paolocretaro@gmail.com> <20170528154309.243555e3@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 28 May 2017 23:17:57 +0200
Message-ID: <CAFBinCC9OQ1P-0K5DZyiFrod97xEuhk__bCSbmvPciXB3KnBBg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson-saradc: use NULL instead of 0 for pointer
To: Jonathan Cameron <jic23@kernel.org>
Cc: Paolo Cretaro <paolocretaro@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Paolo, Hi Jonathan,

On Sun, May 28, 2017 at 4:43 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Sun, 28 May 2017 13:24:38 +0200
> Paolo Cretaro <paolocretaro@gmail.com> wrote:
>
>> Fix sparse warning: Using plain integer as NULL pointer
>>
>> Signed-off-by: Paolo Cretaro <paolocretaro@gmail.com>
> This looks fine to me, but ideally you should always try to include
> the driver author - particularly in the case of patches to a recent
> driver such as this one.
>
> To that end I've cc'd Martin.
thanks for spotting this (and providing a patch to fix it)
this looks good to me, so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

if you can wait until next weekend then I can also test this on real hardware.

> Jonathan
>> ---
>>  drivers/iio/adc/meson_saradc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
>> index 81cd39a57fe3..fb3f67a9ae1f 100644
>> --- a/drivers/iio/adc/meson_saradc.c
>> +++ b/drivers/iio/adc/meson_saradc.c
>> @@ -481,7 +481,7 @@ static void meson_sar_adc_clear_fifo(struct iio_dev *indio_dev)
>>               if (!meson_sar_adc_get_fifo_count(indio_dev))
>>                       break;
>>
>> -             regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, 0);
>> +             regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, NULL);
>>       }
>>  }
>>
>

Regards,
Martin
