Return-Path: <SRS0=Behn=5C=gmail.com=paolocretaro@kernel.org>
Subject: Re: [PATCH] iio: adc: meson-saradc: use NULL instead of 0 for pointer
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20170528112438.10427-1-paolocretaro@gmail.com>
 <20170528154309.243555e3@kernel.org>
From: Paolo Cretaro <paolocretaro@gmail.com>
Message-ID: <41db6c75-c29b-8c58-ff6d-126969dbce38@gmail.com>
Date: Sun, 28 May 2017 19:52:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170528154309.243555e3@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 28/05/2017 16:43, Jonathan Cameron wrote:
> On Sun, 28 May 2017 13:24:38 +0200
> Paolo Cretaro <paolocretaro@gmail.com> wrote:
> 
>> Fix sparse warning: Using plain integer as NULL pointer
>>
>> Signed-off-by: Paolo Cretaro <paolocretaro@gmail.com>
> This looks fine to me, but ideally you should always try to include
> the driver author - particularly in the case of patches to a recent
> driver such as this one.
Sure, thanks for pointing this out, I just felt a bit embarrassed to bother
too many people with such a trivial patch.

Paolo
> 
> To that end I've cc'd Martin.
> 
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
>>  		if (!meson_sar_adc_get_fifo_count(indio_dev))
>>  			break;
>>  
>> -		regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, 0);
>> +		regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, NULL);
>>  	}
>>  }
>>  
> 
