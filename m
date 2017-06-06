Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam01on0056.outbound.protection.outlook.com ([104.47.32.56]:6992
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751384AbdFFK35 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Jun 2017 06:29:57 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH v3] iio: imu: inv_mpu6050: test whoami first and against all
 known values
Date: Tue, 6 Jun 2017 10:29:52 +0000
Message-ID: <BLUPR12MB06572FF309979BB42C095E07C4CB0@BLUPR12MB0657.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

SPI bus is never generating error during transfer, so to check if
a chip is correctly connected on a SPI bus we enforce whoami check
to be correct. In this way we can assure SPI probe is failing if
there is no chip connected.

Fixes: cec0154556f8 ("iio: inv_mpu6050: Check WHO_AM_I register on probe")
Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: <stable@vger.kernel.org>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 33 ++++++++++++++++++++++----=
----
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 96dabbd..af1b536 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -770,27 +770,42 @@ static int inv_check_and_setup_chip(struct inv_mpu605=
0_state *st)
 {
 	int result;
 	unsigned int regval;
+	int i;
=20
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
+		/* check whoami against all possible values */
+		for (i =3D 0; i < INV_NUM_PARTS; ++i) {
+			if (regval =3D=3D hw_info[i].whoami) {
+				dev_warn(regmap_get_device(st->map),
+					"whoami mismatch got %#02x (%s)"
+					"expected %#02hhx (%s)\n",
+					regval, hw_info[i].name,
+					st->hw->whoami, st->hw->name);
+				break;
+			}
+		}
+		if (i >=3D INV_NUM_PARTS) {
+			dev_err(regmap_get_device(st->map),
+				"invalid whoami %#02x expected %#02hhx (%s)\n",
 				regval, st->hw->whoami, st->hw->name);
+			return -ENODEV;
+		}
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
