Return-Path: <adriana.reus@intel.com>
Subject: Re: [RFC PATCH 0/5] iio: imu: inv_mpu6050: Split driver into core and
 I2C/SPI functionality
To: Jonathan Cameron <jic23@kernel.org>
References: <1454147028-22449-1-git-send-email-adriana.reus@intel.com>
 <56ACEEBE.20701@kernel.org>
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
 ggao@invensense.com
From: Adriana Reus <adriana.reus@intel.com>
Message-ID: <56AF1EE7.7010900@intel.com>
Date: Mon, 1 Feb 2016 11:01:27 +0200
MIME-Version: 1.0
In-Reply-To: <56ACEEBE.20701@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi,

Thanks for your comments on this series, I'll resend a new version
soon.
It was an RFC because I've done some slight rebasing and shuffling
around between my last tested version of this series and what was
sent out and I wanted to make sure I can give it a final test run
before it gets merged.
As testing goes, I am using an mpu6050 to test the i2c part and an
mpu6000 to test the spi part.

Thanks,
Adriana

On 30.01.2016 19:11, Jonathan Cameron wrote:
> On 30/01/16 09:43, Adriana Reus wrote:
>> This series splits this driver into general and I2C/SPI specific funtionality.
> functionality.
>> The first patch is a fix for a bug in the interrupt pin configuration.
>> The second patch is a minor clean up in preparation for the split.
>> The third patch changes all the I2C specific calls into regmap calls.
>> The third patch separated the remaining I2C specific part into a different component.
>> Finally the fourth patch adds SPI support for the MPU6000 chip.
> If sending an RFC, always state why you think it is not ready to merge
> right now.
>
> Jonathan
>>
>> Adriana Reus (5):
>>    iio: imu: inv-mpu6050: Fix interrupt pin configuration
>>    iio: inv_mpu6050: Remove unused parameter
>>    iio: imu: inv_mpu6050: Use regmap instead of i2c specific functions
>>    iio: imu: inv_mpu6050: Separate driver into core and i2c
>>      functionality.
>>    iio: imu: inv_mpu6050: Add SPI support for MPU6000
>>
>>   drivers/iio/imu/inv_mpu6050/Kconfig           |  15 +-
>>   drivers/iio/imu/inv_mpu6050/Makefile          |   8 +-
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c    |  14 +-
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 259 ++++++--------------------
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 209 +++++++++++++++++++++
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  15 +-
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  34 ++--
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  80 ++++++++
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  10 +-
>>   9 files changed, 402 insertions(+), 242 deletions(-)
>>   create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>>   create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
>>
>
