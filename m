Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33606 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeDJGSZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2018 02:18:25 -0400
Received: by mail-pl0-f68.google.com with SMTP id s10-v6so6779410plp.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Apr 2018 23:18:25 -0700 (PDT)
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] iio: chemical: atlas-ph-sensor: use msleep() for long uncritical delays
Date: Mon,  9 Apr 2018 23:18:22 -0700
Message-Id: <20180410061822.12750-1-matt.ranostay@konsulko.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

usleep_range() uses hrtimers and provides no advantage over msleep()
for larger delays.

Cc: Nicholas Mc Guire <hofrat@osadl.org>
Link: http://lkml.org/lkml/2017/1/11/377
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-ph-sensor.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index abfc4bbc4cfc..a406ad31b096 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -61,9 +61,9 @@
 #define ATLAS_REG_ORP_CALIB_STATUS	0x0d
 #define ATLAS_REG_ORP_DATA		0x0e
 
-#define ATLAS_PH_INT_TIME_IN_US		450000
-#define ATLAS_EC_INT_TIME_IN_US		650000
-#define ATLAS_ORP_INT_TIME_IN_US	450000
+#define ATLAS_PH_INT_TIME_IN_MS		450
+#define ATLAS_EC_INT_TIME_IN_MS		650
+#define ATLAS_ORP_INT_TIME_IN_MS	450
 
 enum {
 	ATLAS_PH_SM,
@@ -270,21 +270,21 @@ static struct atlas_device atlas_devices[] = {
 				.num_channels = 3,
 				.data_reg = ATLAS_REG_PH_DATA,
 				.calibration = &atlas_check_ph_calibration,
-				.delay = ATLAS_PH_INT_TIME_IN_US,
+				.delay = ATLAS_PH_INT_TIME_IN_MS,
 	},
 	[ATLAS_EC_SM] = {
 				.channels = atlas_ec_channels,
 				.num_channels = 5,
 				.data_reg = ATLAS_REG_EC_DATA,
 				.calibration = &atlas_check_ec_calibration,
-				.delay = ATLAS_EC_INT_TIME_IN_US,
+				.delay = ATLAS_EC_INT_TIME_IN_MS,
 	},
 	[ATLAS_ORP_SM] = {
 				.channels = atlas_orp_channels,
 				.num_channels = 2,
 				.data_reg = ATLAS_REG_ORP_DATA,
 				.calibration = &atlas_check_orp_calibration,
-				.delay = ATLAS_ORP_INT_TIME_IN_US,
+				.delay = ATLAS_ORP_INT_TIME_IN_MS,
 	},
 };
 
@@ -393,7 +393,7 @@ static int atlas_read_measurement(struct atlas_data *data, int reg, __be32 *val)
 	}
 
 	if (suspended)
-		usleep_range(data->chip->delay, data->chip->delay + 100000);
+		msleep(data->chip->delay);
 
 	ret = regmap_bulk_read(data->regmap, reg, (u8 *) val, sizeof(*val));
 
-- 
2.14.1

