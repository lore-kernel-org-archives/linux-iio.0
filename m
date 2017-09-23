Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34440 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbdIWTK5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Sep 2017 15:10:57 -0400
Received: by mail-wr0-f194.google.com with SMTP id k20so2175963wre.1
        for <linux-iio@vger.kernel.org>; Sat, 23 Sep 2017 12:10:57 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: remove LIR configuration
Date: Sat, 23 Sep 2017 21:10:51 +0200
Message-Id: <20170923191052.14419-2-lorenzo.bianconi@st.com>
In-Reply-To: <20170923191052.14419-1-lorenzo.bianconi@st.com>
References: <20170923191052.14419-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove Latched Interrupt configuration since it is enabled by default
for FIFO watermark interrupt

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c68cc7c91928..37d6e324ae74 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -56,8 +56,6 @@
 #define ST_LSM6DSX_REG_INT2_ON_INT1_MASK	BIT(5)
 #define ST_LSM6DSX_REG_ROUNDING_ADDR		0x16
 #define ST_LSM6DSX_REG_ROUNDING_MASK		BIT(2)
-#define ST_LSM6DSX_REG_LIR_ADDR			0x58
-#define ST_LSM6DSX_REG_LIR_MASK			BIT(0)
 
 #define ST_LSM6DSX_REG_ACC_ODR_ADDR		0x10
 #define ST_LSM6DSX_REG_ACC_ODR_MASK		GENMASK(7, 4)
@@ -607,12 +605,6 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 
 	msleep(200);
 
-	/* latch interrupts */
-	err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_LIR_ADDR,
-					 ST_LSM6DSX_REG_LIR_MASK, 1);
-	if (err < 0)
-		return err;
-
 	/* enable Block Data Update */
 	err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_BDU_ADDR,
 					 ST_LSM6DSX_REG_BDU_MASK, 1);
-- 
2.14.1

