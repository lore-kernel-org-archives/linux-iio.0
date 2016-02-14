Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35759 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbcBNBUr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Feb 2016 20:20:47 -0500
Received: by mail-pa0-f45.google.com with SMTP id ho8so66722477pac.2
        for <linux-iio@vger.kernel.org>; Sat, 13 Feb 2016 17:20:47 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: chemical: atlas-ph-sensor: switch regmap cache
Date: Sat, 13 Feb 2016 17:20:42 -0800
Message-Id: <1455412842-750-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

switch from using REGCACHE_FLAT to REGCACHE_RBTREE so initial hw values
are read from device. This also allows some volatile ranges to be
dropped.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/atlas-ph-sensor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index 06cd49c..71c8e02 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -65,8 +65,6 @@ struct atlas_data {
 
 static const struct regmap_range atlas_volatile_ranges[] = {
 	regmap_reg_range(ATLAS_REG_INT_CONTROL, ATLAS_REG_INT_CONTROL),
-	regmap_reg_range(ATLAS_REG_CALIB_STATUS, ATLAS_REG_CALIB_STATUS),
-	regmap_reg_range(ATLAS_REG_TEMP_DATA, ATLAS_REG_TEMP_DATA + 4),
 	regmap_reg_range(ATLAS_REG_PH_DATA, ATLAS_REG_PH_DATA + 4),
 };
 
@@ -83,7 +81,7 @@ static const struct regmap_config atlas_regmap_config = {
 
 	.volatile_table = &atlas_volatile_table,
 	.max_register = ATLAS_REG_PH_DATA + 4,
-	.cache_type = REGCACHE_FLAT,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static const struct iio_chan_spec atlas_channels[] = {
-- 
2.7.0

