Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32949 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbeKLAEc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Nov 2018 19:04:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id f19-v6so7040347wmb.0
        for <linux-iio@vger.kernel.org>; Sun, 11 Nov 2018 06:15:50 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/9] iio: imu: st_lsm6dsx: reload trimming parameter at bootstrap
Date: Sun, 11 Nov 2018 15:15:29 +0100
Message-Id: <9b47f1429ddec5144d52605ef0ccf1f15a310db4.1541945612.git.lorenzo.bianconi@redhat.com>
In-Reply-To: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
References: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Perform a complete device reset at bootstrap reloading trimming parameter
after sw reset is completed. Device sw reset/boot is explained here:
https://www.st.com/resource/en/application_note/dm00517282.pdf,
section 5.7

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c8b993bea757..961ce9d65d82 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -56,6 +56,7 @@
 #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
 #define ST_LSM6DSX_REG_RESET_ADDR		0x12
 #define ST_LSM6DSX_REG_RESET_MASK		BIT(0)
+#define ST_LSM6DSX_REG_BOOT_MASK		BIT(7)
 #define ST_LSM6DSX_REG_BDU_ADDR			0x12
 #define ST_LSM6DSX_REG_BDU_MASK			BIT(6)
 #define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR	0x13
@@ -778,12 +779,23 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 	u8 drdy_int_reg;
 	int err;
 
-	err = regmap_write(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
-			   ST_LSM6DSX_REG_RESET_MASK);
+	/* device sw reset */
+	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
+				 ST_LSM6DSX_REG_RESET_MASK,
+				 FIELD_PREP(ST_LSM6DSX_REG_RESET_MASK, 1));
 	if (err < 0)
 		return err;
 
-	msleep(200);
+	msleep(50);
+
+	/* reload trimming parameter */
+	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
+				 ST_LSM6DSX_REG_BOOT_MASK,
+				 FIELD_PREP(ST_LSM6DSX_REG_BOOT_MASK, 1));
+	if (err < 0)
+		return err;
+
+	msleep(50);
 
 	/* enable Block Data Update */
 	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_BDU_ADDR,
-- 
2.19.1
