Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:33376 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932278AbcFCSaw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 3 Jun 2016 14:30:52 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] iio: inv_mpu6050: Fix use-after-free in ACPI code
Date: Fri,  3 Jun 2016 21:30:24 +0300
Message-Id: <ee0d9476d1312d63f37e73cb65c38fa7dcd3d265.1464978605.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In some cases this can result in incorrectly returning a negative value
from asus_acpi_get_sensor_info and the AK8963 magnetometer failing to
show up.

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index 2771106..f770472 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -56,6 +56,7 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 	int i;
 	acpi_status status;
 	union acpi_object *cpm;
+	int ret;
 
 	status = acpi_evaluate_object(adev->handle, "CNF0", NULL, &buffer);
 	if (ACPI_FAILURE(status))
@@ -82,10 +83,10 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 			}
 		}
 	}
-
+	ret = cpm->package.count;
 	kfree(buffer.pointer);
 
-	return cpm->package.count;
+	return ret;
 }
 
 static int acpi_i2c_check_resource(struct acpi_resource *ares, void *data)
-- 
2.5.5

