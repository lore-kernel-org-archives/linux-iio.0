Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33032 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932314AbcE2O5X (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 10:57:23 -0400
Subject: Re: [RFC PATCH v1 6/9] iio:st_pressure: temperature triggered
 buffering
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1461056711.git.gregor.boirie@parrot.com>
 <daed8183e0916a573de8e40f166bdd8fb364395d.1461056711.git.gregor.boirie@parrot.com>
 <940bb299-878f-0799-1b04-c241ae165127@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <17774c86-fe01-19ee-e945-2ccf987c112e@kernel.org>
Date: Sun, 29 May 2016 15:57:20 +0100
MIME-Version: 1.0
In-Reply-To: <940bb299-878f-0799-1b04-c241ae165127@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/04/16 11:58, Jonathan Cameron wrote:
> On 19/04/16 10:18, Gregor Boirie wrote:
>> Enable support for triggered buffering of temperature samples.
>>
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> I was a little curious as to why this wasn't done previously!
Reading this series more closely, precisely because of the 24bit alignment of
the pressure channels. We need your earlier patches for this one to work.

Anyhow, this is clearly dependant on a new version of patch 4 so it's stalled
for now.

Jonathan
> 
> Anyhow, again ideally would like an Ack from Denis.
> 
> Jonathan
>> ---
>>  drivers/iio/pressure/st_pressure_core.c | 20 +++++++++-----------
>>  1 file changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
>> index 13f1c2d..bacdf6c 100644
>> --- a/drivers/iio/pressure/st_pressure_core.c
>> +++ b/drivers/iio/pressure/st_pressure_core.c
>> @@ -39,8 +39,6 @@
>>  #define ST_PRESS_LSB_PER_CELSIUS		480UL
>>  #define ST_PRESS_MILLI_CELSIUS_OFFSET		42500UL
>>  
>> -#define ST_PRESS_NUMBER_DATA_CHANNELS		1
>> -
>>  /* FULLSCALE */
>>  #define ST_PRESS_FS_AVL_1100MB			1100
>>  #define ST_PRESS_FS_AVL_1260MB			1260
>> @@ -163,7 +161,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
>>  		.type = IIO_PRESSURE,
>>  		.channel2 = IIO_NO_MOD,
>>  		.address = ST_PRESS_1_OUT_XL_ADDR,
>> -		.scan_index = ST_SENSORS_SCAN_X,
>> +		.scan_index = 0,
>>  		.scan_type = {
>>  			.sign = 'u',
>>  			.realbits = 24,
>> @@ -178,7 +176,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
>>  		.type = IIO_TEMP,
>>  		.channel2 = IIO_NO_MOD,
>>  		.address = ST_TEMP_1_OUT_L_ADDR,
>> -		.scan_index = -1,
>> +		.scan_index = 1,
>>  		.scan_type = {
>>  			.sign = 'u',
>>  			.realbits = 16,
>> @@ -191,7 +189,7 @@ static const struct iio_chan_spec st_press_1_channels[] = {
>>  			BIT(IIO_CHAN_INFO_OFFSET),
>>  		.modified = 0,
>>  	},
>> -	IIO_CHAN_SOFT_TIMESTAMP(1)
>> +	IIO_CHAN_SOFT_TIMESTAMP(2)
>>  };
>>  
>>  static const struct iio_chan_spec st_press_lps001wp_channels[] = {
>> @@ -199,7 +197,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
>>  		.type = IIO_PRESSURE,
>>  		.channel2 = IIO_NO_MOD,
>>  		.address = ST_PRESS_LPS001WP_OUT_L_ADDR,
>> -		.scan_index = ST_SENSORS_SCAN_X,
>> +		.scan_index = 0,
>>  		.scan_type = {
>>  			.sign = 'u',
>>  			.realbits = 16,
>> @@ -215,7 +213,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
>>  		.type = IIO_TEMP,
>>  		.channel2 = IIO_NO_MOD,
>>  		.address = ST_TEMP_LPS001WP_OUT_L_ADDR,
>> -		.scan_index = -1,
>> +		.scan_index = 1,
>>  		.scan_type = {
>>  			.sign = 'u',
>>  			.realbits = 16,
>> @@ -227,7 +225,7 @@ static const struct iio_chan_spec st_press_lps001wp_channels[] = {
>>  			BIT(IIO_CHAN_INFO_SCALE),
>>  		.modified = 0,
>>  	},
>> -	IIO_CHAN_SOFT_TIMESTAMP(1)
>> +	IIO_CHAN_SOFT_TIMESTAMP(2)
>>  };
>>  
>>  static const struct iio_chan_spec st_press_lps22hb_channels[] = {
>> @@ -252,7 +250,7 @@ static const struct iio_chan_spec st_press_lps22hb_channels[] = {
>>  		.type = IIO_TEMP,
>>  		.channel2 = IIO_NO_MOD,
>>  		.address = ST_TEMP_1_OUT_L_ADDR,
>> -		.scan_index = -1,
>> +		.scan_index = 1,
>>  		.scan_type = {
>>  			.sign = 'u',
>>  			.realbits = 16,
>> @@ -265,7 +263,7 @@ static const struct iio_chan_spec st_press_lps22hb_channels[] = {
>>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>  		.modified = 0,
>>  	},
>> -	IIO_CHAN_SOFT_TIMESTAMP(1)
>> +	IIO_CHAN_SOFT_TIMESTAMP(2)
>>  };
>>  
>>  static const struct st_sensor_settings st_press_sensors_settings[] = {
>> @@ -598,7 +596,7 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>>  	if (err < 0)
>>  		return err;
>>  
>> -	press_data->num_data_channels = ST_PRESS_NUMBER_DATA_CHANNELS;
>> +	press_data->num_data_channels = press_data->sensor_settings->num_ch - 1;
>>  	press_data->multiread_bit = press_data->sensor_settings->multi_read_bit;
>>  	indio_dev->channels = press_data->sensor_settings->ch;
>>  	indio_dev->num_channels = press_data->sensor_settings->num_ch;
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

