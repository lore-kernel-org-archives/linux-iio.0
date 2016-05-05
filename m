Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [RFC 5/7] iio: inv_mpu6050: Add support for auxiliary I2C master
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <cover.1461953982.git.leonard.crestez@intel.com>
 <4aeaced7c1c8e222996df4c1b4b71e505ab256f7.1461953982.git.leonard.crestez@intel.com>
 <7168c23b-8b82-5e57-42fd-b164bee9fa85@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Daniel Baluta <daniel.baluta@intel.com>, Ge Gao <GGao@invensense.com>,
 Peter Rosin <peda@axentia.se>, Linux I2C <linux-i2c@vger.kernel.org>,
 Wolfram Sang <wsa@the-dreams.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Rutland <Mark.Rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
 Matt Ranostay <matt.ranostay@intel.com>
Message-ID: <3e520787-1dc4-b703-9a44-1c3ac2200f25@intel.com>
Date: Thu, 5 May 2016 15:38:04 +0300
MIME-Version: 1.0
In-Reply-To: <7168c23b-8b82-5e57-42fd-b164bee9fa85@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 05/01/2016 08:27 PM, Jonathan Cameron wrote:
> On 29/04/16 20:02, Crestez Dan Leonard wrote:
>> --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
>> +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
>> @@ -1,16 +1,27 @@
>>  InvenSense MPU-6050 Six-Axis (Gyro + Accelerometer) MEMS MotionTracking Device
>>  
>> -http://www.invensense.com/mems/gyro/mpu6050.html
> If this is invalid, please add an up to date link if possible.
>> -
>>  Required properties:
>> - - compatible : should be "invensense,mpu6050"
>> - - reg : the I2C address of the sensor
>> + - compatible : should be "invensense,mpuXXXX"
> List them all explicitly here rather than wild cards.
>
But the list is a bit long. I'll just write "see below for valid
compatible strings".

>> + - reg : the I2C or SPI address of the sensor
>>   - interrupt-parent : should be the phandle for the interrupt controller
>>   - interrupts : interrupt mapping for GPIO IRQ
>>  
>>  Optional properties:
>>   - mount-matrix: an optional 3x3 mounting rotation matrix
>> + - inv,i2c-aux-master: operate aux i2c in "master mode" (default is mux).
>> +
>> +Valid compatible strings:
> Vendor prefix? These will work for historical reasons, but now vendor
> prefix should definitely be there as well.
>> + - mpu6000
>> + - mpu6050
>> + - mpu6500
>> + - mpu9150
>
The driver currently only lists i2c_device_id and this will work
ignoring the vendor string. I can prefix all these valid strings with
the vendor prefix but this is not actually a requirement. That would
require a separate unrelated patch adding of_device_id tables.

>> +	/*
>> +	 * Regmap will never ignore writes but it will ignore full-register
>> +	 * updates to the same value.
> Hmm. I'd missed this distinction.  Feels decidely 'interesting'... and makes
> my earlier suggestion invalid as I guess the fields stuff uses update bits
> internally.
> 
I will replace this with if (read() != addr) write(addr) to clarify.
Mentioning a regmap implementation quirk this way is silly.

>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>> index bd2c0fd..9d15633 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>> @@ -42,6 +42,13 @@
>>   *  @int_pin_cfg;	Controls interrupt pin configuration.
>>   *  @accl_offset:	Controls the accelerometer calibration offset.
>>   *  @gyro_offset:	Controls the gyroscope calibration offset.
>> + *  @mst_status:	secondary I2C master interrupt source status
>> + *  @slv4_addr:		I2C slave address for slave 4 transaction
>> + *  @slv4_reg:		I2C register used with slave 4 transaction
>> + *  @slv4_di:		I2C data in register for slave 4 transaction
>> + *  @slv4_ctrl:		I2C slave 4 control register
>> + *  @slv4_do:		I2C data out register for slave 4 transaction
>> +
I forgot to ask about this but this patch adds registers addresses to
struct inv_mpu6050_reg_map and not others. All the supported models have
the same registers for this functionality.

It seems to me that the simplest approach to supporting multiple models
is to only put the registers that vary in a model struct and use
constants for the rest. Is this the correct approach? If so I will use
constants for SLV4_* in the next patch.

It's not clear that adding this kind of indirection for everything is
useful for supporting new models. Different models can also move bits
around, not just registers.

-- 
Regards,
Leonard
