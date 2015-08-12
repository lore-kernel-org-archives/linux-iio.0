Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58178 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbbHLVNl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 17:13:41 -0400
Subject: Re: [PATCH v2 7/8] iio:adc:berlin2-adc: enable interrupts with mutex
 locked
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1438035998.git.knaack.h@gmx.de>
 <0c150ffa3c97b5dc7b691efa8ba474e43c282519.1438035998.git.knaack.h@gmx.de>
 <55BC0ABF.5080204@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CBB703.9050506@kernel.org>
Date: Wed, 12 Aug 2015 22:13:39 +0100
MIME-Version: 1.0
In-Reply-To: <55BC0ABF.5080204@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/08/15 00:54, Hartmut Knaack wrote:
> Antoine, any opinion about this one?
> 
> 
> Hartmut Knaack schrieb am 28.07.2015 um 00:39:
>> Move the call to enable channel interrupts into its _read() function to
>> have it protected by a mutex. This ensures that only one channel is
>> sampled at a time.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Looks fine to me and Antoine has had a while to confirm.

Applied to the togreg branch of iio.git

Thanks,

Jonathan
>> ---
>>  drivers/iio/adc/berlin2-adc.c | 17 ++++++++---------
>>  1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
>> index 6e20c856f479..13cfeb494e34 100644
>> --- a/drivers/iio/adc/berlin2-adc.c
>> +++ b/drivers/iio/adc/berlin2-adc.c
>> @@ -111,6 +111,10 @@ static int berlin2_adc_read(struct iio_dev *indio_dev, int channel)
>>  
>>  	mutex_lock(&priv->lock);
>>  
>> +	/* Enable the interrupts */
>> +	regmap_write(priv->regmap, BERLIN2_SM_ADC_STATUS,
>> +		     BERLIN2_SM_ADC_STATUS_INT_EN(channel));
>> +
>>  	/* Configure the ADC */
>>  	regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
>>  			BERLIN2_SM_CTRL_ADC_RESET | BERLIN2_SM_CTRL_ADC_SEL_MASK
>> @@ -149,6 +153,10 @@ static int berlin2_adc_tsen_read(struct iio_dev *indio_dev)
>>  
>>  	mutex_lock(&priv->lock);
>>  
>> +	/* Enable interrupts */
>> +	regmap_write(priv->regmap, BERLIN2_SM_TSEN_STATUS,
>> +		     BERLIN2_SM_TSEN_STATUS_INT_EN);
>> +
>>  	/* Configure the ADC */
>>  	regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
>>  			BERLIN2_SM_CTRL_TSEN_RESET | BERLIN2_SM_CTRL_ADC_ROTATE,
>> @@ -190,7 +198,6 @@ static int berlin2_adc_read_raw(struct iio_dev *indio_dev,
>>  		struct iio_chan_spec const *chan, int *val, int *val2,
>>  		long mask)
>>  {
>> -	struct berlin2_adc_priv *priv = iio_priv(indio_dev);
>>  	int temp;
>>  
>>  	switch (mask) {
>> @@ -198,10 +205,6 @@ static int berlin2_adc_read_raw(struct iio_dev *indio_dev,
>>  		if (chan->type != IIO_VOLTAGE)
>>  			return -EINVAL;
>>  
>> -		/* Enable the interrupts */
>> -		regmap_write(priv->regmap, BERLIN2_SM_ADC_STATUS,
>> -				BERLIN2_SM_ADC_STATUS_INT_EN(chan->channel));
>> -
>>  		*val = berlin2_adc_read(indio_dev, chan->channel);
>>  		if (*val < 0)
>>  			return *val;
>> @@ -211,10 +214,6 @@ static int berlin2_adc_read_raw(struct iio_dev *indio_dev,
>>  		if (chan->type != IIO_TEMP)
>>  			return -EINVAL;
>>  
>> -		/* Enable interrupts */
>> -		regmap_write(priv->regmap, BERLIN2_SM_TSEN_STATUS,
>> -				BERLIN2_SM_TSEN_STATUS_INT_EN);
>> -
>>  		temp = berlin2_adc_tsen_read(indio_dev);
>>  		if (temp < 0)
>>  			return temp;
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

