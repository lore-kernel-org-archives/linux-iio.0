Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47164 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752022AbcLDCUV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:21 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH 05/19] staging: iio: isl29028: made alignment of #defines consistent
Date: Sat,  3 Dec 2016 21:19:29 -0500
Message-Id: <1480817983-32359-6-git-send-email-masneyb@onstation.org>
In-Reply-To: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The alignment of the #defines at the top of the file is not consistent.
This changes all of the defines to use consistent alignment to improve
the code readability.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 42 ++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index e96a8cb..d5b069e 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -27,38 +27,38 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#define ISL29028_CONV_TIME_MS		100
+#define ISL29028_CONV_TIME_MS			100
 
-#define ISL29028_REG_CONFIGURE		0x01
+#define ISL29028_REG_CONFIGURE			0x01
 
-#define ISL29028_CONF_ALS_IR_MODE_ALS	0
-#define ISL29028_CONF_ALS_IR_MODE_IR	BIT(0)
-#define ISL29028_CONF_ALS_IR_MODE_MASK	BIT(0)
+#define ISL29028_CONF_ALS_IR_MODE_ALS		0
+#define ISL29028_CONF_ALS_IR_MODE_IR		BIT(0)
+#define ISL29028_CONF_ALS_IR_MODE_MASK		BIT(0)
 
-#define ISL29028_CONF_ALS_RANGE_LOW_LUX	0
+#define ISL29028_CONF_ALS_RANGE_LOW_LUX		0
 #define ISL29028_CONF_ALS_RANGE_HIGH_LUX	BIT(1)
-#define ISL29028_CONF_ALS_RANGE_MASK	BIT(1)
+#define ISL29028_CONF_ALS_RANGE_MASK		BIT(1)
 
-#define ISL29028_CONF_ALS_DIS		0
-#define ISL29028_CONF_ALS_EN		BIT(2)
-#define ISL29028_CONF_ALS_EN_MASK	BIT(2)
+#define ISL29028_CONF_ALS_DIS			0
+#define ISL29028_CONF_ALS_EN			BIT(2)
+#define ISL29028_CONF_ALS_EN_MASK		BIT(2)
 
-#define ISL29028_CONF_PROX_SLP_SH	4
-#define ISL29028_CONF_PROX_SLP_MASK	(7 << ISL29028_CONF_PROX_SLP_SH)
+#define ISL29028_CONF_PROX_SLP_SH		4
+#define ISL29028_CONF_PROX_SLP_MASK		(7 << ISL29028_CONF_PROX_SLP_SH)
 
-#define ISL29028_CONF_PROX_EN		BIT(7)
-#define ISL29028_CONF_PROX_EN_MASK	BIT(7)
+#define ISL29028_CONF_PROX_EN			BIT(7)
+#define ISL29028_CONF_PROX_EN_MASK		BIT(7)
 
-#define ISL29028_REG_INTERRUPT		0x02
+#define ISL29028_REG_INTERRUPT			0x02
 
-#define ISL29028_REG_PROX_DATA		0x08
-#define ISL29028_REG_ALSIR_L		0x09
-#define ISL29028_REG_ALSIR_U		0x0A
+#define ISL29028_REG_PROX_DATA			0x08
+#define ISL29028_REG_ALSIR_L			0x09
+#define ISL29028_REG_ALSIR_U			0x0A
 
-#define ISL29028_REG_TEST1_MODE		0x0E
-#define ISL29028_REG_TEST2_MODE		0x0F
+#define ISL29028_REG_TEST1_MODE			0x0E
+#define ISL29028_REG_TEST2_MODE			0x0F
 
-#define ISL29028_NUM_REGS		(ISL29028_REG_TEST2_MODE + 1)
+#define ISL29028_NUM_REGS			(ISL29028_REG_TEST2_MODE + 1)
 
 enum isl29028_als_ir_mode {
 	ISL29028_MODE_NONE = 0,
-- 
2.7.4

