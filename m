Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:45180 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751214AbeEDCxa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 May 2018 22:53:30 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, drew.paterson@ams.com
Subject: [PATCH v2 08/11] staging: iio: tsl2x7x: add device ids for code readability
Date: Thu,  3 May 2018 22:53:16 -0400
Message-Id: <20180504025319.28953-9-masneyb@onstation.org>
In-Reply-To: <20180504025319.28953-1-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the device IDs to the device_channel_config array to
improve code readability.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index e3e37501829f..39de5e60fd33 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -273,16 +273,16 @@ enum {
 };
 
 static const u8 device_channel_config[] = {
-	ALS,
-	PRX,
-	PRX,
-	ALSPRX,
-	ALSPRX,
-	ALS,
-	PRX2,
-	PRX2,
-	ALSPRX2,
-	ALSPRX2
+	[tsl2571] = ALS,
+	[tsl2671] = PRX,
+	[tmd2671] = PRX,
+	[tsl2771] = ALSPRX,
+	[tmd2771] = ALSPRX,
+	[tsl2572] = ALS,
+	[tsl2672] = PRX2,
+	[tmd2672] = PRX2,
+	[tsl2772] = ALSPRX2,
+	[tmd2772] = ALSPRX2
 };
 
 static int tsl2x7x_read_status(struct tsl2X7X_chip *chip)
-- 
2.14.3

