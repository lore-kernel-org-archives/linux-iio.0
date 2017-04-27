Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:34384 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755012AbdD0JQh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 05:16:37 -0400
Subject: Re: [PATCH] iio:ad5064: Add support for ltc2633 and similar devices
To: Jonathan Cameron <jic23@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        linux-iio@vger.kernel.org
References: <1493199875-11912-1-git-send-email-mike.looijmans@topic.nl>
 <20b926f2-58ee-52d8-6520-a99e4640125d@kernel.org>
Cc: linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <646b634f-c0ad-f39c-a395-02461f5e8352@metafoo.de>
Date: Thu, 27 Apr 2017 11:16:32 +0200
MIME-Version: 1.0
In-Reply-To: <20b926f2-58ee-52d8-6520-a99e4640125d@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/27/2017 07:52 AM, Jonathan Cameron wrote:
> On 26/04/17 10:44, Mike Looijmans wrote:
>> The Linear Technology LTC2631, LTC2633 and LTC2635 are very similar
>> to the AD5064 device, in particular the LTC2627.
>>
>> This patch adds support for those devices. Only the LTC2633 has been
>> tested, which is the 2-channel variant. The LTC2631 is the 1-channel,
>> and the LTC2635 the 4-channel version. The actual DAC resolution depends
>> on the exact chip type and can be 12, 10 or 8 bits, using the upper bits
>> so this has no effect on the register map. The internal reference is set
>> to 2.5V on "L" versions, and it's 4.096V for "H" versions.
>>
>> Datasheets:
>>     LTC2631: http://www.linear.com/docs/26553
>>     LTC2633: http://www.linear.com/docs/39529
>>     LTC2635: http://www.linear.com/docs/28754
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Ah, its always good if somebody manages to clear an item from your TODO list
before you :)

> Looks fine to me, but I'd like to give time for Lars to take a look
> as it is his driver.

Patch looks good, but I'd prefer it if we had different entries in the
device table for different resolutions. So you don't have to manually shift
the output value by 12 when you are using the 8-bit version. This is how it
has been done for other DAC drivers and it would be good to stay consistent.

Maybe even include the reset-to-midscale/reset-to-gnd designator of the part
number in the compatible string.

http://cds.linear.com/docs/en/datasheet/2631fc.pdf#page=3


> Jonathan
>> ---
>>  drivers/iio/dac/Kconfig  |  3 ++-
>>  drivers/iio/dac/ad5064.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 58 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
>> index d3084028..31ffb67 100644
>> --- a/drivers/iio/dac/Kconfig
>> +++ b/drivers/iio/dac/Kconfig
>> @@ -13,7 +13,8 @@ config AD5064
>>  	  AD5045, AD5064, AD5064-1, AD5065, AD5625, AD5625R, AD5627, AD5627R,
>>  	  AD5628, AD5629R, AD5645R, AD5647R, AD5648, AD5665, AD5665R, AD5666,
>>  	  AD5667, AD5667R, AD5668, AD5669R, LTC2606, LTC2607, LTC2609, LTC2616,
>> -	  LTC2617, LTC2619, LTC2626, LTC2627, LTC2629 Digital to Analog Converter.
>> +	  LTC2617, LTC2619, LTC2626, LTC2627, LTC2629, LTC2631, LTC2633, LTC2635
>> +	  Digital to Analog Converter.
>>  
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called ad5064.
>> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
>> index 6803e4a..b440180 100644
>> --- a/drivers/iio/dac/ad5064.c
>> +++ b/drivers/iio/dac/ad5064.c
>> @@ -2,8 +2,8 @@
>>   * AD5024, AD5025, AD5044, AD5045, AD5064, AD5064-1, AD5065, AD5625, AD5625R,
>>   * AD5627, AD5627R, AD5628, AD5629R, AD5645R, AD5647R, AD5648, AD5665, AD5665R,
>>   * AD5666, AD5667, AD5667R, AD5668, AD5669R, LTC2606, LTC2607, LTC2609, LTC2616,
>> - * LTC2617, LTC2619, LTC2626, LTC2627, LTC2629 Digital to analog converters
>> - * driver
>> + * LTC2617, LTC2619, LTC2626, LTC2627, LTC2629, LTC2631, LTC2633, LTC2635
>> + * Digital to analog converters driver
>>   *
>>   * Copyright 2011 Analog Devices Inc.
>>   *
>> @@ -168,6 +168,12 @@ enum ad5064_type {
>>  	ID_LTC2626,
>>  	ID_LTC2627,
>>  	ID_LTC2629,
>> +	ID_LTC2631_L,
>> +	ID_LTC2631_H,
>> +	ID_LTC2633_L,
>> +	ID_LTC2633_H,
>> +	ID_LTC2635_L,
>> +	ID_LTC2635_H,
>>  };
>>  
>>  static int ad5064_write(struct ad5064_state *st, unsigned int cmd,
>> @@ -724,6 +730,48 @@ static int ad5064_write_raw(struct iio_dev *indio_dev,
>>  		.num_channels = 4,
>>  		.regmap_type = AD5064_REGMAP_LTC,
>>  	},
>> +	[ID_LTC2631_L] = {
>> +		.shared_vref = true,
>> +		.internal_vref = 2500000,
>> +		.channels = ltc2627_channels,
>> +		.num_channels = 1,
>> +		.regmap_type = AD5064_REGMAP_LTC,
>> +	},
>> +	[ID_LTC2631_H] = {
>> +		.shared_vref = true,
>> +		.internal_vref = 4096000,
>> +		.channels = ltc2627_channels,
>> +		.num_channels = 1,
>> +		.regmap_type = AD5064_REGMAP_LTC,
>> +	},
>> +	[ID_LTC2633_L] = {
>> +		.shared_vref = true,
>> +		.internal_vref = 2500000,
>> +		.channels = ltc2627_channels,
>> +		.num_channels = 2,
>> +		.regmap_type = AD5064_REGMAP_LTC,
>> +	},
>> +	[ID_LTC2633_H] = {
>> +		.shared_vref = true,
>> +		.internal_vref = 4096000,
>> +		.channels = ltc2627_channels,
>> +		.num_channels = 2,
>> +		.regmap_type = AD5064_REGMAP_LTC,
>> +	},
>> +	[ID_LTC2635_L] = {
>> +		.shared_vref = true,
>> +		.internal_vref = 2500000,
>> +		.channels = ltc2627_channels,
>> +		.num_channels = 4,
>> +		.regmap_type = AD5064_REGMAP_LTC,
>> +	},
>> +	[ID_LTC2635_H] = {
>> +		.shared_vref = true,
>> +		.internal_vref = 4096000,
>> +		.channels = ltc2627_channels,
>> +		.num_channels = 4,
>> +		.regmap_type = AD5064_REGMAP_LTC,
>> +	},
>>  };
>>  
>>  static inline unsigned int ad5064_num_vref(struct ad5064_state *st)
>> @@ -982,6 +1030,12 @@ static int ad5064_i2c_remove(struct i2c_client *i2c)
>>  	{"ltc2626", ID_LTC2626},
>>  	{"ltc2627", ID_LTC2627},
>>  	{"ltc2629", ID_LTC2629},
>> +	{"ltc2631-l", ID_LTC2631_L},
>> +	{"ltc2631-h", ID_LTC2631_H},
>> +	{"ltc2633-l", ID_LTC2633_L},
>> +	{"ltc2633-h", ID_LTC2633_H},
>> +	{"ltc2635-l", ID_LTC2635_L},
>> +	{"ltc2635-h", ID_LTC2635_H},
>>  	{}
>>  };
>>  MODULE_DEVICE_TABLE(i2c, ad5064_i2c_ids);
>>
> 

