Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam01on0042.outbound.protection.outlook.com ([104.47.34.42]:3040
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750995AbdE2NRS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 May 2017 09:17:18 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH v2] iio: imu: inv_mpu6050: test whoami against invalid values
 and do it first
Date: Mon, 29 May 2017 13:17:14 +0000
Message-ID: <BLUPR12MB06575D31F4F7233ED58923E1C4F30@BLUPR12MB0657.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

SPI bus is never generating error during transfer, so to check if
a chip is correctly connected on a SPI bus we enforce whoami check
to be correct.
In this way we can assure SPI probe is failing if there is no chip
connected.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 96dabbd..57b3442 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -774,23 +774,24 @@ static int inv_check_and_setup_chip(struct inv_mpu605=
0_state *st)
 	st->hw  =3D &hw_info[st->chip_type];
 	st->reg =3D hw_info[st->chip_type].reg;
=20
-	/* reset to make sure previous state are not there */
-	result =3D regmap_write(st->map, st->reg->pwr_mgmt_1,
-			      INV_MPU6050_BIT_H_RESET);
-	if (result)
-		return result;
-	msleep(INV_MPU6050_POWER_UP_TIME);
-
 	/* check chip self-identification */
 	result =3D regmap_read(st->map, INV_MPU6050_REG_WHOAMI, &regval);
 	if (result)
 		return result;
 	if (regval !=3D st->hw->whoami) {
-		dev_warn(regmap_get_device(st->map),
-				"whoami mismatch got %#02x expected %#02hhx for %s\n",
-				regval, st->hw->whoami, st->hw->name);
+		dev_err(regmap_get_device(st->map),
+			"invalid whoami got %#02x expected %#02hhx for %s\n",
+			regval, st->hw->whoami, st->hw->name);
+		return -ENODEV;
 	}
=20
+	/* reset to make sure previous state are not there */
+	result =3D regmap_write(st->map, st->reg->pwr_mgmt_1,
+			      INV_MPU6050_BIT_H_RESET);
+	if (result)
+		return result;
+	msleep(INV_MPU6050_POWER_UP_TIME);
+
 	/*
 	 * toggle power state. After reset, the sleep bit could be on
 	 * or off depending on the OTP settings. Toggling power would
--=20
1.9.1
