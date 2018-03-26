Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-dm3nam03on0057.outbound.protection.outlook.com ([104.47.41.57]:62126
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750983AbeCZOBX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Mar 2018 10:01:23 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH 3/3] iio: imu: inv_mpu6050: clean double declaration of
 set_power_itg
Date: Mon, 26 Mar 2018 14:01:20 +0000
Message-ID: <CY4PR1201MB0184FA5F5A0E0F5902E86879C4AD0@CY4PR1201MB0184.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h
index 0657941..c3d6225 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -298,5 +298,4 @@ void inv_mpu_acpi_delete_mux_client(struct i2c_client *=
client);
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
 int inv_mpu_core_remove(struct device *dev);
-int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)=
;
 extern const struct dev_pm_ops inv_mpu_pmops;
--=20
2.7.4
