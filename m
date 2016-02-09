Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-011.synserver.de ([212.40.185.11]:1102 "EHLO
	smtp-out-189.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754747AbcBIVSq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 16:18:46 -0500
Subject: Re: [PATCH v3 0/4] iio: imu: inv_mpu6050: Split driver into core and
 I2C/SPI functionality
To: Jonathan Cameron <jic23@kernel.org>,
	Adriana Reus <adriana.reus@intel.com>
References: <1455032300-12466-1-git-send-email-adriana.reus@intel.com>
 <56BA4F97.40002@kernel.org>
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, daniel.baluta@intel.com, mwelling@ieee.org,
	lucas.de.marchi@gmail.com, adi.reus@gmail.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56BA5078.9090307@metafoo.de>
Date: Tue, 9 Feb 2016 21:47:52 +0100
MIME-Version: 1.0
In-Reply-To: <56BA4F97.40002@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/09/2016 09:44 PM, Jonathan Cameron wrote:
> On 09/02/16 15:38, Adriana Reus wrote:
>> This series splits this driver into general and I2C/SPI specific functionality.
>> The first patch is a fix for a bug in the interrupt pin configuration.
>> The second patch changes all the I2C specific calls into regmap calls.
>> The third patch separated the remaining I2C specific part into a different component.
>> Finally the fourth patch adds SPI support for the MPU6000 chip.
>>
>> No changes since v2 for the first two patches.
>> Adressed comments for the last two patches
>>
>> Adriana Reus (4):
>>   iio: imu: inv-mpu6050: Fix interrupt pin configuration
>>   iio: imu: inv_mpu6050: Use regmap instead of i2c specific functions
>>   iio: imu: inv_mpu6050: Separate driver into core and i2c
>>     functionality.
>>   iio: imu: inv_mpu6050: Add SPI support for MPU6000
>>
>>  drivers/iio/imu/inv_mpu6050/Kconfig           |  21 ++-
>>  drivers/iio/imu/inv_mpu6050/Makefile          |   8 +-
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c    |  18 +-
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 258 ++++++--------------------
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 207 +++++++++++++++++++++
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  19 +-
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  35 ++--
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     | 106 +++++++++++
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  10 +-
>>  9 files changed, 440 insertions(+), 242 deletions(-)
>>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
>>
> Just to make sure you don't miss it, (and for my reference as I 
> might forget those emails before I apply this)
> there are some additional comments on V2 from Lars that crossed
> with V3 that need addressing.

Oh, sorry, I though I was replying to v3, but yeah, same issues still in v3.

