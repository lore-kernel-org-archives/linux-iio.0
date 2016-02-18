Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32180 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426586AbcBRPvN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 18 Feb 2016 10:51:13 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	wsa@the-dreams.de, linux-i2c@vger.kernel.org,
	lucas.demarchi@intel.com, daniel.baluta@intel.com,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	adi.reus@gmail.com, cmo@melexis.com, mwelling@ieee.org
Subject: [RFC PATCH 4/9] iio: imu: inv_mpu6050: Remove unnecessary parentheses
Date: Thu, 18 Feb 2016 17:53:09 +0200
Message-Id: <1455810794-3188-5-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes the following checkpatch warning:
CHECK: Unnecessary parentheses around cpm->package.elements[i]

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index 231a7af..2771106 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -66,11 +66,11 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 		union acpi_object *elem;
 		int j;
 
-		elem = &(cpm->package.elements[i]);
+		elem = &cpm->package.elements[i];
 		for (j = 0; j < elem->package.count; ++j) {
 			union acpi_object *sub_elem;
 
-			sub_elem = &(elem->package.elements[j]);
+			sub_elem = &elem->package.elements[j];
 			if (sub_elem->type == ACPI_TYPE_STRING)
 				strlcpy(info->type, sub_elem->string.pointer,
 					sizeof(info->type));
-- 
2.5.0

