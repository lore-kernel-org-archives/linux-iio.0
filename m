Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37698 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdBSMx7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 07:53:59 -0500
Subject: Re: [PATCH v2 2/2] iio: adc: meson-saradc: improve
 meson_sar_adc_read_raw_sample
To: Heiner Kallweit <hkallweit1@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <e6dbc777-25a9-15a1-a415-2a020b8e40f7@gmail.com>
 <f8490439-7ace-c4ad-0152-53e998706a40@gmail.com>
 <3e812ab0-9ae5-199c-ca54-c9d36d8fef5d@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6522393c-34a0-4f92-0c27-f40cdf5d9a89@kernel.org>
Date: Sun, 19 Feb 2017 12:53:57 +0000
MIME-Version: 1.0
In-Reply-To: <3e812ab0-9ae5-199c-ca54-c9d36d8fef5d@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/02/17 12:19, Jonathan Cameron wrote:
> On 15/02/17 19:31, Heiner Kallweit wrote:
>> After sampling there should always be only one value in the FIFO.
>> This also applies to averaging mode as the averaging is done
>> chip-internally. So we don't have to loop and let the driver
>> complain if there's not exactly one value in the FIFO.
>>
>> If the value belongs to a different channel then don't silently
>> swallow the value but complain.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Will pick up once Martin is happy with patch 1.  Give me a poke if I
> seem to have missed this after say a week.
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> 
> Jonathan
>> ---
>> v2:
>> - rebased
>> ---
>>  drivers/iio/adc/meson_saradc.c | 36 +++++++++++++++++-------------------
>>  1 file changed, 17 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
>> index 9f186de2..cde9ca7a 100644
>> --- a/drivers/iio/adc/meson_saradc.c
>> +++ b/drivers/iio/adc/meson_saradc.c
>> @@ -278,33 +278,31 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
>>  					 int *val)
>>  {
>>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>> -	int regval, fifo_chan, fifo_val, sum = 0, count = 0;
>> +	int regval, fifo_chan, fifo_val, count;
>>  
>>  	if(!wait_for_completion_timeout(&priv->done,
>>  				msecs_to_jiffies(MESON_SAR_ADC_TIMEOUT)))
>>  		return -ETIMEDOUT;
>>  
>> -	while (meson_sar_adc_get_fifo_count(indio_dev) > 0 &&
>> -	       count < MESON_SAR_ADC_MAX_FIFO_SIZE) {
>> -		regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
>> -
>> -		fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK,
>> -				      regval);
>> -		if (fifo_chan != chan->channel)
>> -			continue;
>> -
>> -		fifo_val = FIELD_GET(MESON_SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK,
>> -				     regval);
>> -		fifo_val &= (BIT(priv->data->resolution) - 1);
>> -
>> -		sum += fifo_val;
>> -		count++;
>> +	count = meson_sar_adc_get_fifo_count(indio_dev);
>> +	if (count != 1) {
>> +		dev_err(&indio_dev->dev,
>> +			"ADC FIFO has %d element(s) instead of one\n", count);
>> +		return -EINVAL;
>>  	}
>>  
>> -	if (!count)
>> -		return -ENOENT;
>> +	regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
>> +	fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK, regval);
>> +	if (fifo_chan != chan->channel) {
>> +		dev_err(&indio_dev->dev,
>> +			"ADC FIFO entry belongs to channel %d instead of %d\n",
>> +			fifo_chan, chan->channel);
>> +		return -EINVAL;
>> +	}
>>  
>> -	*val = sum / count;
>> +	fifo_val = FIELD_GET(MESON_SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK, regval);
>> +	fifo_val &= GENMASK(priv->data->resolution - 1, 0);
>> +	*val = fifo_val;
>>  
>>  	return 0;
>>  }
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

