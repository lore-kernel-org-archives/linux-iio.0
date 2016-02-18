Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32180 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425202AbcBRPvK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 18 Feb 2016 10:51:10 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	wsa@the-dreams.de, linux-i2c@vger.kernel.org,
	lucas.demarchi@intel.com, daniel.baluta@intel.com,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	adi.reus@gmail.com, cmo@melexis.com, mwelling@ieee.org
Subject: [RFC PATCH 3/9] iio: imu: inv_mpu6050: Fix newlines to make code easier to read
Date: Thu, 18 Feb 2016 17:53:08 +0200
Message-Id: <1455810794-3188-4-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This fixes the following checkpatch.pl warnings:
	* WARNING: Missing a blank line after declarations
	* CHECK: Blank lines aren't necessary before a close brace '}'

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index 0bcfa8d..231a7af 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -186,7 +186,6 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client *client)
 		st->mux_client = i2c_new_device(st->mux_adapter, &info);
 		if (!st->mux_client)
 			return -ENODEV;
-
 	}
 
 	return 0;
@@ -195,6 +194,7 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client *client)
 void inv_mpu_acpi_delete_mux_client(struct i2c_client *client)
 {
 	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(&client->dev));
+
 	if (st->mux_client)
 		i2c_unregister_device(st->mux_client);
 }
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index c550ebb..72cc478 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -365,6 +365,7 @@ static int inv_write_raw_get_fmt(struct iio_dev *indio_dev,
 
 	return -EINVAL;
 }
+
 static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, int val)
 {
 	int result, i;
-- 
2.5.0

