Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] iio: imu: inv_mpu6050: ACPI enumeration
Date: Mon, 15 Dec 2014 13:19:21 -0800
Message-Id: <1418678363-22437-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1418678363-22437-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1418678363-22437-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added changes so that the module can be enumerated via ACPI.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 6d2c115..f73e60b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -24,6 +24,7 @@
 #include <linux/spinlock.h>
 #include <linux/iio/iio.h>
 #include <linux/i2c-mux.h>
+#include <linux/acpi.h>
 #include "inv_mpu_iio.h"
 
 /*
@@ -875,6 +876,13 @@ static const struct i2c_device_id inv_mpu_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
 
+static const struct acpi_device_id inv_acpi_match[] = {
+	{"INVN6500", 0},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
+
 static struct i2c_driver inv_mpu_driver = {
 	.probe		=	inv_mpu_probe,
 	.remove		=	inv_mpu_remove,
@@ -883,6 +891,7 @@ static struct i2c_driver inv_mpu_driver = {
 		.owner	=	THIS_MODULE,
 		.name	=	"inv-mpu6050",
 		.pm     =       INV_MPU6050_PMOPS,
+		.acpi_match_table = ACPI_PTR(inv_acpi_match),
 	},
 };
 
-- 
1.9.3
