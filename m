Return-Path: <k.wrona@samsung.com>
Message-id: <54B541DF.9000507@samsung.com>
Date: Tue, 13 Jan 2015 17:03:43 +0100
From: Karol Wrona <k.wrona@samsung.com>
MIME-version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>
Subject: Re: [PATCH v3 3/5] iio: common: ssp_sensors: Add sensorhub iio commons
References: <1417809290-9662-1-git-send-email-k.wrona@samsung.com>
 <1417809290-9662-4-git-send-email-k.wrona@samsung.com>
 <54831539.1020705@kernel.org>
In-reply-to: <54831539.1020705@kernel.org>
Content-type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

[...]
>> +EXPORT_SYMBOL(ssp_common_setup_buffer);
>> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
>> new file mode 100644
>> index 0000000..4b79be0
>> --- /dev/null
>> +++ b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
>> @@ -0,0 +1,56 @@
>> +#ifndef __SSP_IIO_SENSOR_H__
>> +#define __SSP_IIO_SENSOR_H__
>> +
>> +#define SSP_CHANNEL_AG(_type, _mod, _index) \
>> +{ \
>> +		.type = _type,\
>> +		.modified = 1,\
>> +		.channel2 = _mod,\
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
>> +		.scan_index = _index,\
>> +		.scan_type = {\
>> +			.sign = 's',\
>> +			.realbits = 16,\
> Seems a little unlikely unless the device is padding appropriately. Even
> then it is generally a bad idea to claim more accuracy than is real. Very
> few accelerometers etc are 16 bit.  Please confirm.
>> +			.storagebits = 16,\
Physically it is mpu6500:
http://www.invensense.com/mems/gyro/documents/PS-MPU-6500A-01.pdf.
It has 16-bit ADC.  Other thing linux device does not get these data directly
but after some processing by sensorhub and in this case it always will be 16-bit
sample.



>> +			.shift = 0,\
>> +			.endianness = IIO_LE,\
>> +		},\
>> +}
>> +
>> +#define SSP_DIVISOR	1000000ULL
>> +#define SSP_MS_PER_S	1000
[...]
