Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33316 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbdIWTK6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Sep 2017 15:10:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id m127so3928371wmm.0
        for <linux-iio@vger.kernel.org>; Sat, 23 Sep 2017 12:10:58 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH 2/2] iio: imu: st_lsm6dsx: remove rounding configuration
Date: Sat, 23 Sep 2017 21:10:52 +0200
Message-Id: <20170923191052.14419-3-lorenzo.bianconi@st.com>
In-Reply-To: <20170923191052.14419-1-lorenzo.bianconi@st.com>
References: <20170923191052.14419-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove rounding configuration since it is enabled by default for the
FIFO output registers

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 37d6e324ae74..debf4064f474 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -54,8 +54,6 @@
 #define ST_LSM6DSX_REG_BDU_MASK			BIT(6)
 #define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR	0x13
 #define ST_LSM6DSX_REG_INT2_ON_INT1_MASK	BIT(5)
-#define ST_LSM6DSX_REG_ROUNDING_ADDR		0x16
-#define ST_LSM6DSX_REG_ROUNDING_MASK		BIT(2)
 
 #define ST_LSM6DSX_REG_ACC_ODR_ADDR		0x10
 #define ST_LSM6DSX_REG_ACC_ODR_MASK		GENMASK(7, 4)
@@ -611,11 +609,6 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 	if (err < 0)
 		return err;
 
-	err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_ROUNDING_ADDR,
-					 ST_LSM6DSX_REG_ROUNDING_MASK, 1);
-	if (err < 0)
-		return err;
-
 	/* enable FIFO watermak interrupt */
 	err = st_lsm6dsx_get_drdy_reg(hw, &drdy_int_reg);
 	if (err < 0)
-- 
2.14.1

