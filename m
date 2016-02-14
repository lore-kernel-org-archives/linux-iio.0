Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: switch regmap cache
To: Jonathan Cameron <jic23@kernel.org>, Matt Ranostay <mranostay@gmail.com>
References: <1455412842-750-1-git-send-email-mranostay@gmail.com>
 <56C096F3.9070908@kernel.org>
Cc: linux-iio@vger.kernel.org, Mark Brown <broonie@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56C0BBFF.5040703@metafoo.de>
Date: Sun, 14 Feb 2016 18:40:15 +0100
MIME-Version: 1.0
In-Reply-To: <56C096F3.9070908@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 02/14/2016 04:02 PM, Jonathan Cameron wrote:
> On 14/02/16 01:20, Matt Ranostay wrote:
>> switch from using REGCACHE_FLAT to REGCACHE_RBTREE so initial hw values
>> are read from device. This also allows some volatile ranges to be
>> dropped.
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> I'm lost here. Why should changing the storage of the register cache result
> in different behaviour other than in efficiency of access to cached values?

And if there is really a difference this should probably be addressed at the
regmap level.

- Lars

> 
> Jonathan
>> ---
>>  drivers/iio/chemical/atlas-ph-sensor.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
>> index 06cd49c..71c8e02 100644
>> --- a/drivers/iio/chemical/atlas-ph-sensor.c
>> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
>> @@ -65,8 +65,6 @@ struct atlas_data {
>>  
>>  static const struct regmap_range atlas_volatile_ranges[] = {
>>  	regmap_reg_range(ATLAS_REG_INT_CONTROL, ATLAS_REG_INT_CONTROL),
>> -	regmap_reg_range(ATLAS_REG_CALIB_STATUS, ATLAS_REG_CALIB_STATUS),
>> -	regmap_reg_range(ATLAS_REG_TEMP_DATA, ATLAS_REG_TEMP_DATA + 4),
>>  	regmap_reg_range(ATLAS_REG_PH_DATA, ATLAS_REG_PH_DATA + 4),
>>  };
>>  
>> @@ -83,7 +81,7 @@ static const struct regmap_config atlas_regmap_config = {
>>  
>>  	.volatile_table = &atlas_volatile_table,
>>  	.max_register = ATLAS_REG_PH_DATA + 4,
>> -	.cache_type = REGCACHE_FLAT,
>> +	.cache_type = REGCACHE_RBTREE,
>>  };
>>  
>>  static const struct iio_chan_spec atlas_channels[] = {
>>
