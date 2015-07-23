Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55831 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbbGWTkF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2015 15:40:05 -0400
Subject: Re: [PATCH V4 4/5] iio: st-accel: add support for lsm303agr
 accelerometer
To: Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe BARBA <giuseppe.barba@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1437467745-18435-1-git-send-email-giuseppe.barba@st.com>
 <1437467745-18435-5-git-send-email-giuseppe.barba@st.com>
 <55AE228A.2080505@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55B14316.9030507@kernel.org>
Date: Thu, 23 Jul 2015 20:40:06 +0100
MIME-Version: 1.0
In-Reply-To: <55AE228A.2080505@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/07/15 11:44, Denis Ciocca wrote:
> Acked-by: Denis Ciocca <denis.ciocca@st.com>
Applied.
> 
> 
> On 07/21/2015 04:35 PM, Giuseppe BARBA wrote:
>> This adds support for the lsm303agr accelerometer.
>>
>> Signed-off-by: Giuseppe Barba <giuseppe.barba@st.com>
>> ---
>>   Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
>>   drivers/iio/accel/st_accel.h                         | 1 +
>>   drivers/iio/accel/st_accel_core.c                    | 1 +
>>   drivers/iio/accel/st_accel_i2c.c                     | 5 +++++
>>   drivers/iio/accel/st_accel_spi.c                     | 1 +
>>   5 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
>> index 8a6be3b..d80bdaa 100644
>> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
>> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
>> @@ -35,6 +35,7 @@ Accelerometers:
>>   - st,lsm303dl-accel
>>   - st,lsm303dlm-accel
>>   - st,lsm330-accel
>> +- st,lsm303agr-accel
>>     Gyroscopes:
>>   - st,l3g4200d-gyro
>> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
>> index aa10019..468f21f 100644
>> --- a/drivers/iio/accel/st_accel.h
>> +++ b/drivers/iio/accel/st_accel.h
>> @@ -26,6 +26,7 @@
>>   #define LSM303DLH_ACCEL_DEV_NAME    "lsm303dlh_accel"
>>   #define LSM303DLM_ACCEL_DEV_NAME    "lsm303dlm_accel"
>>   #define LSM330_ACCEL_DEV_NAME        "lsm330_accel"
>> +#define LSM303AGR_ACCEL_DEV_NAME    "lsm303agr_accel"
>>     /**
>>   * struct st_sensors_platform_data - default accel platform data
>> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
>> index 12b42f6..ff30f88 100644
>> --- a/drivers/iio/accel/st_accel_core.c
>> +++ b/drivers/iio/accel/st_accel_core.c
>> @@ -233,6 +233,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>>               [2] = LSM330D_ACCEL_DEV_NAME,
>>               [3] = LSM330DL_ACCEL_DEV_NAME,
>>               [4] = LSM330DLC_ACCEL_DEV_NAME,
>> +            [5] = LSM303AGR_ACCEL_DEV_NAME,
>>           },
>>           .ch = (struct iio_chan_spec *)st_accel_12bit_channels,
>>           .odr = {
>> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
>> index a2f1c20..8b9cc84 100644
>> --- a/drivers/iio/accel/st_accel_i2c.c
>> +++ b/drivers/iio/accel/st_accel_i2c.c
>> @@ -68,6 +68,10 @@ static const struct of_device_id st_accel_of_match[] = {
>>           .compatible = "st,lsm330-accel",
>>           .data = LSM330_ACCEL_DEV_NAME,
>>       },
>> +    {
>> +        .compatible = "st,lsm303agr-accel",
>> +        .data = LSM303AGR_ACCEL_DEV_NAME,
>> +    },
>>       {},
>>   };
>>   MODULE_DEVICE_TABLE(of, st_accel_of_match);
>> @@ -116,6 +120,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>>       { LSM303DL_ACCEL_DEV_NAME },
>>       { LSM303DLM_ACCEL_DEV_NAME },
>>       { LSM330_ACCEL_DEV_NAME },
>> +    { LSM303AGR_ACCEL_DEV_NAME },
>>       {},
>>   };
>>   MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
>> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
>> index 12ec293..54b61a3 100644
>> --- a/drivers/iio/accel/st_accel_spi.c
>> +++ b/drivers/iio/accel/st_accel_spi.c
>> @@ -57,6 +57,7 @@ static const struct spi_device_id st_accel_id_table[] = {
>>       { LSM303DL_ACCEL_DEV_NAME },
>>       { LSM303DLM_ACCEL_DEV_NAME },
>>       { LSM330_ACCEL_DEV_NAME },
>> +    { LSM303AGR_ACCEL_DEV_NAME },
>>       {},
>>   };
>>   MODULE_DEVICE_TABLE(spi, st_accel_id_table);
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

