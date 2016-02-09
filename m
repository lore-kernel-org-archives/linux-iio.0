Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43689 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778AbcBIIkN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 9 Feb 2016 03:40:13 -0500
Subject: Re: [PATCH v2 0/4] iio: imu: inv_mpu6050: Split driver into core and
 I2C/SPI functionality
To: Michael Welling <mwelling@ieee.org>
References: <1454577628-12708-1-git-send-email-adriana.reus@intel.com>
 <20160208071634.GA26438@deathstar>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	lucas.de.marchi@gmail.com
From: Adriana Reus <adriana.reus@intel.com>
Message-ID: <56B9A5AC.5040003@intel.com>
Date: Tue, 9 Feb 2016 10:39:08 +0200
MIME-Version: 1.0
In-Reply-To: <20160208071634.GA26438@deathstar>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Thanks!
Are you using the MPU on your board via SPI or via I2C?

On 08.02.2016 09:16, Michael Welling wrote:
> On Thu, Feb 04, 2016 at 11:20:24AM +0200, Adriana Reus wrote:
>> This series splits this driver into general and I2C/SPI specific functionality.
>> The first patch is a fix for a bug in the interrupt pin configuration.
>> The second patch changes all the I2C specific calls into regmap calls.
>> The third patch separated the remaining I2C specific part into a different component.
>> Finally the fourth patch adds SPI support for the MPU6000 chip.
>>
>> No changes since v1 for the first two patches.
>> Small changes since v1 to the last two patches
>>
>
> After fixing the compilation error, I was able to get the driver to run
> on the Dragonboard 410c. I tested it with a robotics mezzanine board that
> I designed. The driver appears to work with the MPU-9250 as it has the
> same core funtionality.
>
> Tested-by: Michael Welling <mwelling@ieee.org>
>
>> Adriana Reus (4):
>>    iio: imu: inv-mpu6050: Fix interrupt pin configuration
>>    iio: imu: inv_mpu6050: Use regmap instead of i2c specific functions
>>    iio: imu: inv_mpu6050: Separate driver into core and i2c
>>      functionality.
>>    iio: imu: inv_mpu6050: Add SPI support for MPU6000
>>
>>   drivers/iio/imu/inv_mpu6050/Kconfig           |  21 ++-
>>   drivers/iio/imu/inv_mpu6050/Makefile          |   8 +-
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c    |  14 +-
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 253 +++++---------------------
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 207 +++++++++++++++++++++
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  17 +-
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  35 ++--
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  87 +++++++++
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  10 +-
>>   9 files changed, 412 insertions(+), 240 deletions(-)
>>   create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>>   create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
>>
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
