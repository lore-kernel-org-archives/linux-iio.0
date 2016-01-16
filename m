Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53605 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbcAPNE5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jan 2016 08:04:57 -0500
Subject: Re: [PATCH] iio: adc: mcp320x: support more differential voltage
 measurement
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org
References: <1452181230-21877-1-git-send-email-akinobu.mita@gmail.com>
 <56913539.2080904@kernel.org>
Cc: Oskar Andero <oskar.andero@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <569A3FF7.4040809@kernel.org>
Date: Sat, 16 Jan 2016 13:04:55 +0000
MIME-Version: 1.0
In-Reply-To: <56913539.2080904@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/01/16 16:28, Jonathan Cameron wrote:
> On 07/01/16 15:40, Akinobu Mita wrote:
>> mcp320x driver supports the pseudo-differential mode by
>> in_voltage'IN+'-voltage'IN-'_raw where (IN+, IN-) = (0, 1), (2, 3), ...
>>
>> mcp320x chips except MCP3X01 can also select swapped IN+ and IN-
>> pairs in the pseudo-differential mode.
>> i.e. in_voltage'IN+'-voltage'IN-'_raw where (IN+, IN-) = (1, 0),
>> (3, 2), ...
>>
>> If the voltage level of IN+ is equal to or less than IN-, the
>> resultant code will be 000h.  So it is useful to provide these, too.
>>
>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> Cc: Oskar Andero <oskar.andero@gmail.com>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Hartmut Knaack <knaack.h@gmx.de>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Peter Meerwald <pmeerw@pmeerw.net>
>> Cc: linux-iio@vger.kernel.org
> Looks good to me.   Will let it sit for a while longer on the list
> as we have lots of time at this point in a kernel cycle (new one
> has just started as far as IIO is concerned)
> 
Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan

> Jonathan
>> ---
>>  drivers/iio/adc/mcp320x.c | 31 +++++++++++++++++++------------
>>  1 file changed, 19 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
>> index 8569c8e..a9c4acd 100644
>> --- a/drivers/iio/adc/mcp320x.c
>> +++ b/drivers/iio/adc/mcp320x.c
>> @@ -187,26 +187,27 @@ out:
>>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
>>  	}
>>  
>> -#define MCP320X_VOLTAGE_CHANNEL_DIFF(num)			\
>> +#define MCP320X_VOLTAGE_CHANNEL_DIFF(chan1, chan2)		\
>>  	{							\
>>  		.type = IIO_VOLTAGE,				\
>>  		.indexed = 1,					\
>> -		.channel = (num * 2),				\
>> -		.channel2 = (num * 2 + 1),			\
>> -		.address = (num * 2),				\
>> +		.channel = (chan1),				\
>> +		.channel2 = (chan2),				\
>> +		.address = (chan1),				\
>>  		.differential = 1,				\
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
>>  	}
>>  
>>  static const struct iio_chan_spec mcp3201_channels[] = {
>> -	MCP320X_VOLTAGE_CHANNEL_DIFF(0),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1),
>>  };
>>  
>>  static const struct iio_chan_spec mcp3202_channels[] = {
>>  	MCP320X_VOLTAGE_CHANNEL(0),
>>  	MCP320X_VOLTAGE_CHANNEL(1),
>> -	MCP320X_VOLTAGE_CHANNEL_DIFF(0),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0),
>>  };
>>  
>>  static const struct iio_chan_spec mcp3204_channels[] = {
>> @@ -214,8 +215,10 @@ static const struct iio_chan_spec mcp3204_channels[] = {
>>  	MCP320X_VOLTAGE_CHANNEL(1),
>>  	MCP320X_VOLTAGE_CHANNEL(2),
>>  	MCP320X_VOLTAGE_CHANNEL(3),
>> -	MCP320X_VOLTAGE_CHANNEL_DIFF(0),
>> -	MCP320X_VOLTAGE_CHANNEL_DIFF(1),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(2, 3),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(3, 2),
>>  };
>>  
>>  static const struct iio_chan_spec mcp3208_channels[] = {
>> @@ -227,10 +230,14 @@ static const struct iio_chan_spec mcp3208_channels[] = {
>>  	MCP320X_VOLTAGE_CHANNEL(5),
>>  	MCP320X_VOLTAGE_CHANNEL(6),
>>  	MCP320X_VOLTAGE_CHANNEL(7),
>> -	MCP320X_VOLTAGE_CHANNEL_DIFF(0),
>> -	MCP320X_VOLTAGE_CHANNEL_DIFF(1),
>> -	MCP320X_VOLTAGE_CHANNEL_DIFF(2),
>> -	MCP320X_VOLTAGE_CHANNEL_DIFF(3),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(2, 3),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(3, 2),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(4, 5),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(5, 4),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(6, 7),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(7, 6),
>>  };
>>  
>>  static const struct iio_info mcp320x_info = {
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

