Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57507 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbdEGWBG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 18:01:06 -0400
Subject: Re: [PATCH 2/2] iio: adc: Fix bad GENMASK use, typos, whitespace
To: "Andrew F. Davis" <afd@ti.com>,
        =?UTF-8?Q?Stefan_Br=c3=bcns?= <stefan.bruens@rwth-aachen.de>,
        linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marc Titinger <mtitinger@baylibre.com>
References: <20170501111942.12736-1-stefan.bruens@rwth-aachen.de>
 <f2f869d571e34f39964b087452addf64@rwthex-w2-b.rwth-ad.de>
 <64dfaa1b-5979-5b7a-be1a-64ca7148e0ef@ti.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <10fe5c8f-e3c8-08aa-cd18-f9c4e08f2eb1@kernel.org>
Date: Sun, 7 May 2017 14:42:48 +0100
MIME-Version: 1.0
In-Reply-To: <64dfaa1b-5979-5b7a-be1a-64ca7148e0ef@ti.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/17 21:06, Andrew F. Davis wrote:
> On 05/01/2017 06:19 AM, Stefan Brüns wrote:
>> Commit 7906dd52c5a0 ("iio: ina2xx: Fix whitespace and re-order code")
>> changed the register number of the MASK_ENABLE register from 0x06 to the
>> value equivalent GENMASK(2,1), although its no mask.
>> Also fix a typo (INA2_6_6 instead of INA2_2_6), and use the datasheet
>> name ("Mask/Enable") for the register number define.
>> Fix bad indentation for channel attributes.
>>
>> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
>> ---
> 
> Good catches,
> 
> Acked-by: Andrew F. Davis <afd@ti.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> 
>>  drivers/iio/adc/ina2xx-adc.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
>> index 3263231276ca..f395101d68d7 100644
>> --- a/drivers/iio/adc/ina2xx-adc.c
>> +++ b/drivers/iio/adc/ina2xx-adc.c
>> @@ -41,8 +41,8 @@
>>  #define INA2XX_CURRENT                  0x04	/* readonly */
>>  #define INA2XX_CALIBRATION              0x05
>>  
>> -#define INA226_ALERT_MASK		GENMASK(2, 1)
>> -#define INA266_CVRF			BIT(3)
>> +#define INA226_MASK_ENABLE		0x06
>> +#define INA226_CVRF			BIT(3)
>>  
>>  #define INA2XX_MAX_REGISTERS            8
>>  
>> @@ -416,8 +416,8 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
>>  	.address = (_address), \
>>  	.indexed = 1, \
>>  	.channel = (_index), \
>> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) \
>> -	| BIT(IIO_CHAN_INFO_SCALE), \
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
>> +			      BIT(IIO_CHAN_INFO_SCALE), \
>>  	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
>>  				   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
>>  	.scan_index = (_index), \
>> @@ -480,12 +480,12 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>>  	 */
>>  	if (!chip->allow_async_readout)
>>  		do {
>> -			ret = regmap_read(chip->regmap, INA226_ALERT_MASK,
>> +			ret = regmap_read(chip->regmap, INA226_MASK_ENABLE,
>>  					  &alert);
>>  			if (ret < 0)
>>  				return ret;
>>  
>> -			alert &= INA266_CVRF;
>> +			alert &= INA226_CVRF;
>>  		} while (!alert);
>>  
>>  	/*
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

