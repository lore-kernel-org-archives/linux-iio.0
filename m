Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33080 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755656AbcHSUgZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Aug 2016 16:36:25 -0400
Received: by mail-pa0-f65.google.com with SMTP id vy10so3882863pac.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Aug 2016 13:36:25 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 2/3] iio: chemical: atlas-ph-sensor: switch to REGCACHE_NONE regmap tree
Date: Fri, 19 Aug 2016 13:36:10 -0700
Message-Id: <1471638971-23039-3-git-send-email-mranostay@gmail.com>
In-Reply-To: <1471638971-23039-1-git-send-email-mranostay@gmail.com>
References: <1471638971-23039-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since there are overlapping volatile regions between parts, and only
register that isn't volatile is the temperature compensation provided
from userspace.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/atlas-ph-sensor.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index 696875413d10..c0a0ebbbd54a 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -84,26 +84,10 @@ struct atlas_data {
 	__be32 buffer[6]; /* 96-bit data + 32-bit pad + 64-bit timestamp */
 };
 
-static const struct regmap_range atlas_volatile_ranges[] = {
-	regmap_reg_range(ATLAS_REG_INT_CONTROL, ATLAS_REG_INT_CONTROL),
-	regmap_reg_range(ATLAS_REG_PH_DATA, ATLAS_REG_PH_DATA + 4),
-	regmap_reg_range(ATLAS_REG_EC_DATA, ATLAS_REG_PSS_DATA + 4),
-};
-
-static const struct regmap_access_table atlas_volatile_table = {
-	.yes_ranges	= atlas_volatile_ranges,
-	.n_yes_ranges	= ARRAY_SIZE(atlas_volatile_ranges),
-};
-
 static const struct regmap_config atlas_regmap_config = {
 	.name = ATLAS_REGMAP_NAME,
-
 	.reg_bits = 8,
 	.val_bits = 8,
-
-	.volatile_table = &atlas_volatile_table,
-	.max_register = ATLAS_REG_PSS_DATA + 4,
-	.cache_type = REGCACHE_RBTREE,
 };
 
 static const struct iio_chan_spec atlas_ph_channels[] = {
-- 
2.7.4

