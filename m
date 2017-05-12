Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam01on0073.outbound.protection.outlook.com ([104.47.34.73]:59872
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932245AbdELMpi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 May 2017 08:45:38 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PATCH] iio: imu: inv_mpu6050: test whoami against invalid values and
 do it first
Date: Fri, 12 May 2017 12:45:33 +0000
Message-ID: <BLUPR12MB0657CCC7922C6655D88C9FB0C4E20@BLUPR12MB0657.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

SPI bus is never generating error during transfer, so a simple way to check
if a chip is correctly connected on a SPI bus is to check a fixed value lik=
e
whoami against valid values. 0x00 or 0xff can never happened. It is better
to do this test first since if there is a problem with a DTS and an incorre=
ct
chip is wired instead, a write can be more damaging than a read.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 96dabbd..42fb135 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -774,23 +774,28 @@ static int inv_check_and_setup_chip(struct inv_mpu605=
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
+		if (regval =3D=3D 0x00 || regval =3D=3D 0xff) {
+			dev_err(regmap_get_device(st->map),
+					"invalid whoami probably io error\n");
+			return -EIO;
+		}
 		dev_warn(regmap_get_device(st->map),
 				"whoami mismatch got %#02x expected %#02hhx for %s\n",
 				regval, st->hw->whoami, st->hw->name);
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
1.9.1=
