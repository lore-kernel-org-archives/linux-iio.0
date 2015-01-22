Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: wsa@the-dreams.de,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] iio: imu: inv_mpu6050: client enumeration
Date: Thu, 22 Jan 2015 14:31:54 -0800
Message-Id: <1421965915-19747-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

v2
Add CONFIG_ACPI to call creation of mux clients, instead of relying
on ACPI_HANDLE not present for non ACPI platforms
It is possible that there is no secondary address, this is not an error.

v1
This is an option if auto detect is not desired. 
Here using ACPI magic, by parsing both standard and vendor ACPI
data.

v0
Using autodetect feature.
Using HWMON class as other places in the system for mux and
client sensor drivers.

Srinivas Pandruvada (1):
  iio: imu: inv_mpu6050: Create mux clients for ACPI

 drivers/iio/imu/inv_mpu6050/Makefile       |   2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 196 +++++++++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  11 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |   3 +
 4 files changed, 211 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c

-- 
1.9.3
