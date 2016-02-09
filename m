Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36196 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755446AbcBIQ26 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 11:28:58 -0500
Received: by mail-ig0-f195.google.com with SMTP id 5so1189971igt.3
        for <linux-iio@vger.kernel.org>; Tue, 09 Feb 2016 08:28:58 -0800 (PST)
Date: Tue, 9 Feb 2016 10:28:45 -0600
From: Michael Welling <mwelling@ieee.org>
To: Adriana Reus <adriana.reus@intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	daniel.baluta@intel.com, lucas.de.marchi@gmail.com,
	adi.reus@gmail.com
Subject: Re: [PATCH v3 0/4] iio: imu: inv_mpu6050: Split driver into core and
 I2C/SPI functionality
Message-ID: <20160209162845.GA3798@deathstar>
References: <1455032300-12466-1-git-send-email-adriana.reus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455032300-12466-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Feb 09, 2016 at 05:38:16PM +0200, Adriana Reus wrote:
> This series splits this driver into general and I2C/SPI specific functionality.
> The first patch is a fix for a bug in the interrupt pin configuration.
> The second patch changes all the I2C specific calls into regmap calls.
> The third patch separated the remaining I2C specific part into a different component.
> Finally the fourth patch adds SPI support for the MPU6000 chip.
> 
> No changes since v2 for the first two patches.
> Adressed comments for the last two patches
>

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
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c    |  18 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 258 ++++++--------------------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 207 +++++++++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  19 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  35 ++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     | 106 +++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  10 +-
>  9 files changed, 440 insertions(+), 242 deletions(-)
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> 
> -- 
> 1.9.1
> 
