Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44851 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbeKDXyb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Nov 2018 18:54:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id j17-v6so1520518wrq.11
        for <linux-iio@vger.kernel.org>; Sun, 04 Nov 2018 06:39:17 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/7] iio: imu: st_lsm6dsx: reboot memory content after reset
Date: Sun,  4 Nov 2018 15:39:01 +0100
Message-Id: <71f6b6a308a74c863926a9de28cf51d42d26b859.1541341926.git.lorenzo.bianconi@redhat.com>
In-Reply-To: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
References: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Perform a memory content reboot after device reset

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c8b993bea757..e3ebd04d8078 100644
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
@@ -778,12 +779,21 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 	u8 drdy_int_reg;
 	int err;
 
-	err = regmap_write(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
-			   ST_LSM6DSX_REG_RESET_MASK);
+	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
+				 ST_LSM6DSX_REG_RESET_MASK,
+				 FIELD_PREP(ST_LSM6DSX_REG_RESET_MASK, 1));
 	if (err < 0)
 		return err;
 
-	msleep(200);
+	msleep(50);
+
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
