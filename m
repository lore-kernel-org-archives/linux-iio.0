Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33494 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbcBHHQr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2016 02:16:47 -0500
Received: by mail-io0-f194.google.com with SMTP id f81so9263907iof.0
        for <linux-iio@vger.kernel.org>; Sun, 07 Feb 2016 23:16:47 -0800 (PST)
Date: Mon, 8 Feb 2016 01:16:34 -0600
From: Michael Welling <mwelling@ieee.org>
To: Adriana Reus <adriana.reus@intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	lucas.de.marchi@gmail.com
Subject: Re: [PATCH v2 0/4] iio: imu: inv_mpu6050: Split driver into core and
 I2C/SPI functionality
Message-ID: <20160208071634.GA26438@deathstar>
References: <1454577628-12708-1-git-send-email-adriana.reus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454577628-12708-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Feb 04, 2016 at 11:20:24AM +0200, Adriana Reus wrote:
> This series splits this driver into general and I2C/SPI specific functionality.
> The first patch is a fix for a bug in the interrupt pin configuration.
> The second patch changes all the I2C specific calls into regmap calls.
> The third patch separated the remaining I2C specific part into a different component.
> Finally the fourth patch adds SPI support for the MPU6000 chip.
> 
> No changes since v1 for the first two patches.
> Small changes since v1 to the last two patches
>

After fixing the compilation error, I was able to get the driver to run
on the Dragonboard 410c. I tested it with a robotics mezzanine board that
I designed. The driver appears to work with the MPU-9250 as it has the
same core funtionality.

Tested-by: Michael Welling <mwelling@ieee.org>
 
> Adriana Reus (4):
>   iio: imu: inv-mpu6050: Fix interrupt pin configuration
>   iio: imu: inv_mpu6050: Use regmap instead of i2c specific functions
>   iio: imu: inv_mpu6050: Separate driver into core and i2c
>     functionality.
>   iio: imu: inv_mpu6050: Add SPI support for MPU6000
> 
>  drivers/iio/imu/inv_mpu6050/Kconfig           |  21 ++-
>  drivers/iio/imu/inv_mpu6050/Makefile          |   8 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c    |  14 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 253 +++++---------------------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 207 +++++++++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  17 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  35 ++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  87 +++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  10 +-
>  9 files changed, 412 insertions(+), 240 deletions(-)
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> 
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
