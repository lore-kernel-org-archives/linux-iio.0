Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3] iio: accel: kxcjk1013 3-axis accelerometer driver
Date: Wed, 11 Jun 2014 15:06:59 -0700
Message-Id: <1402524420-26531-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

v3
Addressed issues raised by Jonathan:
- validate trigger
- Resume implementation for cases where user space doesn't issue close before
putting system to suspend
- probe fn:  trigger path: Instead of goto use client->irq >= 0
- probe fn: Use if (data->trig_mode) to cleanup triggers
- probe fn: Call kxcjk1013_acpi_gpio_probe only if the i2c irq < 0
- raw interface for SAMP_FREQ: Pre-multiply to micros
- Removed separate function to adjust polarity
- Add platform data interface to get interrupt polarity
- Still kxcjk1013_get_acc_reg as it is called from multiple places, to keep clean
- ODR change after buffer enable: The chip is set back to operation mode
- Some alignment issue

v1 and v2
Addressed formatting and endianess issue 
identified by Peter Meerwald

v0
base version

Srinivas Pandruvada (1):
  iio: accel: kxcjk1013 3-axis accelerometer driver

 drivers/iio/accel/Kconfig            |  12 +
 drivers/iio/accel/Makefile           |   1 +
 drivers/iio/accel/kxcjk-1013.c       | 762 +++++++++++++++++++++++++++++++++++
 include/linux/iio/accel/kxcjk_1013.h |  22 +
 4 files changed, 797 insertions(+)
 create mode 100644 drivers/iio/accel/kxcjk-1013.c
 create mode 100644 include/linux/iio/accel/kxcjk_1013.h

-- 
1.7.11.7
