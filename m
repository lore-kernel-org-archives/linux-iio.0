Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49340 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751440AbdAQJnW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Jan 2017 04:43:22 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH v2 14/15] staging: iio: isl29028: only set ALS scale when ALS/IR sensing is enabled
Date: Tue, 17 Jan 2017 04:25:01 -0500
Message-Id: <20170117092502.6951-15-masneyb@onstation.org>
In-Reply-To: <20170117092502.6951-1-masneyb@onstation.org>
References: <20170117092502.6951-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

isl29028_chip_init_and_power_on() calls isl29028_set_als_scale() and
this is not needed until the user actually needs to take a reading from
the ALS/IR sensor. This patch moves the isl29028_set_als_scale() call
from isl29028_chip_init_and_power_on() to isl29028_set_als_ir_mode().
This sets the stage for faster resume times from runtime power
management if the user is only querying the proximity sensor.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index fa58d08..598a5a5 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -146,11 +146,15 @@ static int isl29028_set_als_scale(struct isl29028_chip *chip, int lux_scale)
 static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
 				    enum isl29028_als_ir_mode mode)
 {
-	int ret = 0;
+	int ret;
 
 	if (chip->als_ir_mode == mode)
 		return 0;
 
+	ret = isl29028_set_als_scale(chip, chip->lux_scale);
+	if (ret < 0)
+		return ret;
+
 	switch (mode) {
 	case ISL29028_MODE_ALS:
 		ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
@@ -453,7 +457,7 @@ static int isl29028_chip_init_and_power_on(struct isl29028_chip *chip)
 		return ret;
 	}
 
-	return isl29028_set_als_scale(chip, chip->lux_scale);
+	return ret;
 }
 
 static bool isl29028_is_volatile_reg(struct device *dev, unsigned int reg)
-- 
2.9.3

