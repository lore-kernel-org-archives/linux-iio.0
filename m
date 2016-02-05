Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36553 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbcBEMku (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2016 07:40:50 -0500
Received: by mail-wm0-f67.google.com with SMTP id 128so2836117wmz.3
        for <linux-iio@vger.kernel.org>; Fri, 05 Feb 2016 04:40:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454577628-12708-1-git-send-email-adriana.reus@intel.com>
References: <1454577628-12708-1-git-send-email-adriana.reus@intel.com>
Date: Fri, 5 Feb 2016 14:40:49 +0200
Message-ID: <CAEnQRZBzejEWMnu4YABAquYJGK7J0JSUyreETdykqxa528rG1A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] iio: imu: inv_mpu6050: Split driver into core and
 I2C/SPI functionality
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Adriana Reus <adriana.reus@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	ggao@invensense.com, Lucas De Marchi <lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Feb 4, 2016 at 11:20 AM, Adriana Reus <adriana.reus@intel.com> wrote:
> This series splits this driver into general and I2C/SPI specific functionality.
> The first patch is a fix for a bug in the interrupt pin configuration.
> The second patch changes all the I2C specific calls into regmap calls.
> The third patch separated the remaining I2C specific part into a different component.
> Finally the fourth patch adds SPI support for the MPU6000 chip.
>
> No changes since v1 for the first two patches.
> Small changes since v1 to the last two patches
>
> Adriana Reus (4):
>   iio: imu: inv-mpu6050: Fix interrupt pin configuration
>   iio: imu: inv_mpu6050: Use regmap instead of i2c specific functions
>   iio: imu: inv_mpu6050: Separate driver into core and i2c
>     functionality.
>   iio: imu: inv_mpu6050: Add SPI support for MPU6000

Looks good to me.

Acked-by: Daniel Baluta <daniel.baluta@intel.com>

thanks,
Daniel.
