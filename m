Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43534 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754603AbbA3W0k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 30 Jan 2015 17:26:40 -0500
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: wsa@the-dreams.de, lars@metafoo.de, linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3] iio: imu: inv_mpu6050: client enumeration
Date: Fri, 30 Jan 2015 14:25:44 -0800
Message-Id: <1422656745-13576-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Last comment from Jonathan was
"
This all looks fine to me, though ideally I'd like some input from
others, more familiar with the dmi stuff etc and from Wolfram / others
wrt to the approach.
"

So anybody have a better suggestion, I am still open to take them.
Otherwise please consider as a merge candidate.

v3
Add CONFIG_ACPI protection to avoid compiler warning.

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
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 211 +++++++++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |   7 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |   3 +
 4 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c

-- 
1.9.3

