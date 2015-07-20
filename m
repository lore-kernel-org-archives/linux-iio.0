Return-Path: <denis.ciocca@st.com>
Message-ID: <55AC6F6B.6030901@st.com>
Date: Mon, 20 Jul 2015 11:47:55 +0800
From: Denis Ciocca <denis.ciocca@st.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
        Giuseppe BARBA
	<giuseppe.barba@st.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/5] iio: st-sensors: add configuration for WhoAmI address
References: <1437038264-12936-1-git-send-email-giuseppe.barba@st.com> <1437038264-12936-2-git-send-email-giuseppe.barba@st.com> <55AB841F.5020306@kernel.org>
In-Reply-To: <55AB841F.5020306@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Giuseppe, Jonathan,

my comments inline.


On 07/19/2015 07:03 PM, Jonathan Cameron wrote:
> On 16/07/15 10:17, Giuseppe Barba wrote:
>> This patch permits to configure the WhoAmI register address
>> because some device could doesn't have a standard address
>> for this register.
>>
>> Signed-off-by: Giuseppe Barba <giuseppe.barba@st.com>
> Hmm. I'd be tempted to rename the DEFAULT WAIT ADDRESS as it's clearly
> only the default in the sense it was there first.  Still probably not
> worth the hassle..
>
> Looks good to me, but will leave this (and the rest of the series)
> on the list for a few days for others to comment.
>
> cc'd Denis for comments. Ideally patches should also cc the reviewers
> listed in MAINTAINERS (I don't care if you cc me as I have filters
> set to squash stuff that comes to me and the list into one).
>
>>   drivers/iio/accel/st_accel_core.c               |  4 +++
>>   drivers/iio/common/st_sensors/st_sensors_core.c | 44 +++++++++++++++----------
>>   drivers/iio/gyro/st_gyro_core.c                 |  3 ++
>>   drivers/iio/magnetometer/st_magn_core.c         |  2 ++
>>   include/linux/iio/common/st_sensors.h           |  2 ++
>>   5 files changed, 37 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
>> index 4002e64..7ce027b 100644
>> --- a/drivers/iio/accel/st_accel_core.c
>> +++ b/drivers/iio/accel/st_accel_core.c
>> @@ -226,6 +226,7 @@ static const struct iio_chan_spec st_accel_16bit_channels[] = {
>>   static const struct st_sensor_settings st_accel_sensors_settings[] = {
>>   	{
>>   		.wai = ST_ACCEL_1_WAI_EXP,
>> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>>   		.sensors_supported = {
>>   			[0] = LIS3DH_ACCEL_DEV_NAME,
>>   			[1] = LSM303DLHC_ACCEL_DEV_NAME,
>> @@ -297,6 +298,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>>   	},
>>   	{
>>   		.wai = ST_ACCEL_2_WAI_EXP,
>> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>>   		.sensors_supported = {
>>   			[0] = LIS331DLH_ACCEL_DEV_NAME,
>>   			[1] = LSM303DL_ACCEL_DEV_NAME,
>> @@ -359,6 +361,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>>   	},
>>   	{
>>   		.wai = ST_ACCEL_3_WAI_EXP,
>> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>>   		.sensors_supported = {
>>   			[0] = LSM330_ACCEL_DEV_NAME,
>>   		},
>> @@ -437,6 +440,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>>   	},
>>   	{
>>   		.wai = ST_ACCEL_4_WAI_EXP,
>> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>>   		.sensors_supported = {
>>   			[0] = LIS3LV02DL_ACCEL_DEV_NAME,
>>   		},
>> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
>> index 8086cbc..c0a611e 100644
>> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
>> @@ -479,35 +479,43 @@ int st_sensors_check_device_support(struct iio_dev *indio_dev,
>>   			int num_sensors_list,
>>   			const struct st_sensor_settings *sensor_settings)
>>   {
>> -	u8 wai;
>>   	int i, n, err;
>> +	u8 wai, wai_addr, found_it;
>>   	struct st_sensor_data *sdata = iio_priv(indio_dev);
>>   
>> +	found_it = 0;
>> +	for (i = 0; i < num_sensors_list; i++) {
>> +		for (n = 0; n < ST_SENSORS_MAX_4WAI; n++) {
>> +			if (strcmp(indio_dev->name,
>> +				sensor_settings[i].sensors_supported[n]) == 0) {
>> +				found_it = 1;
>> +				break;
>> +			}
>> +		}
>> +		if (found_it)
>> +			break;
found_it is very ugly :). No need to use the variable, if (n != 
ST_SENSORS_MAX_4WAI) it means sensor found.

>> +	}
>> +	if (!found_it) {
here just if (i == num_sensors_list)

>> +		dev_err(&indio_dev->dev, "device name %s not recognized.\n",
>> +							indio_dev->name);
>> +		goto sensor_name_mismatch;
>> +	}
>> +
>> +	if (sensor_settings[i].wai_addr != 0)
>> +		wai_addr = sensor_settings[i].wai_addr;
>> +	else
>> +		wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS;
No need. All sensors must be filled with wai_addr in the static array. 
You forget to fill pressure sensors...

>> +
>>   	err = sdata->tf->read_byte(&sdata->tb, sdata->dev,
>> -					ST_SENSORS_DEFAULT_WAI_ADDRESS, &wai);
>> +					wai_addr, &wai);
>>   	if (err < 0) {
>>   		dev_err(&indio_dev->dev, "failed to read Who-Am-I register.\n");
>>   		goto read_wai_error;
>>   	}
>>   
>> -	for (i = 0; i < num_sensors_list; i++) {
>> -		if (sensor_settings[i].wai == wai)
>> -			break;
>> -	}
>> -	if (i == num_sensors_list)
>> +	if (sensor_settings[i].wai != wai)
>>   		goto device_not_supported;
>>   
>> -	for (n = 0; n < ARRAY_SIZE(sensor_settings[i].sensors_supported); n++) {
>> -		if (strcmp(indio_dev->name,
>> -				&sensor_settings[i].sensors_supported[n][0]) == 0)
>> -			break;
>> -	}
>> -	if (n == ARRAY_SIZE(sensor_settings[i].sensors_supported)) {
>> -		dev_err(&indio_dev->dev, "device name \"%s\" and WhoAmI (0x%02x) mismatch",
>> -			indio_dev->name, wai);
>> -		goto sensor_name_mismatch;
>> -	}
>> -
>>   	sdata->sensor_settings =
>>   			(struct st_sensor_settings *)&sensor_settings[i];
>>   
>> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
>> index ffe9664..4b993a5 100644
>> --- a/drivers/iio/gyro/st_gyro_core.c
>> +++ b/drivers/iio/gyro/st_gyro_core.c
>> @@ -131,6 +131,7 @@ static const struct iio_chan_spec st_gyro_16bit_channels[] = {
>>   static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>>   	{
>>   		.wai = ST_GYRO_1_WAI_EXP,
>> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>>   		.sensors_supported = {
>>   			[0] = L3G4200D_GYRO_DEV_NAME,
>>   			[1] = LSM330DL_GYRO_DEV_NAME,
>> @@ -190,6 +191,7 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>>   	},
>>   	{
>>   		.wai = ST_GYRO_2_WAI_EXP,
>> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>>   		.sensors_supported = {
>>   			[0] = L3GD20_GYRO_DEV_NAME,
>>   			[1] = LSM330D_GYRO_DEV_NAME,
>> @@ -252,6 +254,7 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>>   	},
>>   	{
>>   		.wai = ST_GYRO_3_WAI_EXP,
>> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>>   		.sensors_supported = {
>>   			[0] = L3GD20_GYRO_DEV_NAME,
>>   		},
>> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
>> index b4bcfb7..63da293 100644
>> --- a/drivers/iio/magnetometer/st_magn_core.c
>> +++ b/drivers/iio/magnetometer/st_magn_core.c
>> @@ -268,6 +268,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
>>   	},
>>   	{
>>   		.wai = ST_MAGN_1_WAI_EXP,
>> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>>   		.sensors_supported = {
>>   			[0] = LSM303DLHC_MAGN_DEV_NAME,
>>   			[1] = LSM303DLM_MAGN_DEV_NAME,
>> @@ -346,6 +347,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
>>   	},
>>   	{
>>   		.wai = ST_MAGN_2_WAI_EXP,
>> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>>   		.sensors_supported = {
>>   			[0] = LIS3MDL_MAGN_DEV_NAME,
>>   		},
>> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
>> index 2c476ac..f7c77b4 100644
>> --- a/include/linux/iio/common/st_sensors.h
>> +++ b/include/linux/iio/common/st_sensors.h
>> @@ -166,6 +166,7 @@ struct st_sensor_transfer_function {
>>   /**
>>    * struct st_sensor_settings - ST specific sensor settings
>>    * @wai: Contents of WhoAmI register.
>> + * @wai_addr: The address of WhoAmI register
Forget . at the end.

>>    * @sensors_supported: List of supported sensors by struct itself.
>>    * @ch: IIO channels for the sensor.
>>    * @odr: Output data rate register and ODR list available.
>> @@ -179,6 +180,7 @@ struct st_sensor_transfer_function {
>>    */
>>   struct st_sensor_settings {
>>   	u8 wai;
>> +	u8 wai_addr;
>>   	char sensors_supported[ST_SENSORS_MAX_4WAI][ST_SENSORS_MAX_NAME];
>>   	struct iio_chan_spec *ch;
>>   	int num_ch;
>>
