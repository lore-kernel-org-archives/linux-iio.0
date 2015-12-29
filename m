Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33483 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbbL2L2U (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Dec 2015 06:28:20 -0500
Received: by mail-pf0-f193.google.com with SMTP id 78so12395215pfw.0
        for <linux-iio@vger.kernel.org>; Tue, 29 Dec 2015 03:28:19 -0800 (PST)
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 2/5] Staging: iio: cdc: ad7152: Prefer using the BIT macro
Date: Tue, 29 Dec 2015 16:57:28 +0530
Message-Id: <1451388451-10342-3-git-send-email-shraddha.6596@gmail.com>
In-Reply-To: <1451388451-10342-1-git-send-email-shraddha.6596@gmail.com>
References: <1451388451-10342-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace bit shifting on 1 with the BIT(x) macro

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/staging/iio/cdc/ad7152.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 485d0a5..472836d 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -41,30 +41,30 @@
 #define AD7152_REG_CFG2			26
 
 /* Status Register Bit Designations (AD7152_REG_STATUS) */
-#define AD7152_STATUS_RDY1		(1 << 0)
-#define AD7152_STATUS_RDY2		(1 << 1)
-#define AD7152_STATUS_C1C2		(1 << 2)
-#define AD7152_STATUS_PWDN		(1 << 7)
+#define AD7152_STATUS_RDY1		BIT(0)
+#define AD7152_STATUS_RDY2		BIT(1)
+#define AD7152_STATUS_C1C2		BIT(2)
+#define AD7152_STATUS_PWDN		BIT(7)
 
 /* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
-#define AD7152_SETUP_CAPDIFF		(1 << 5)
+#define AD7152_SETUP_CAPDIFF		BIT(5)
 #define AD7152_SETUP_RANGE_2pF		(0 << 6)
-#define AD7152_SETUP_RANGE_0_5pF	(1 << 6)
+#define AD7152_SETUP_RANGE_0_5pF	BIT(6)
 #define AD7152_SETUP_RANGE_1pF		(2 << 6)
 #define AD7152_SETUP_RANGE_4pF		(3 << 6)
 #define AD7152_SETUP_RANGE(x)		((x) << 6)
 
 /* Config Register Bit Designations (AD7152_REG_CFG) */
-#define AD7152_CONF_CH2EN		(1 << 3)
-#define AD7152_CONF_CH1EN		(1 << 4)
+#define AD7152_CONF_CH2EN		BIT(3)
+#define AD7152_CONF_CH1EN		BIT(4)
 #define AD7152_CONF_MODE_IDLE		(0 << 0)
-#define AD7152_CONF_MODE_CONT_CONV	(1 << 0)
+#define AD7152_CONF_MODE_CONT_CONV	BIT(0)
 #define AD7152_CONF_MODE_SINGLE_CONV	(2 << 0)
 #define AD7152_CONF_MODE_OFFS_CAL	(5 << 0)
 #define AD7152_CONF_MODE_GAIN_CAL	(6 << 0)
 
 /* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
-#define AD7152_CAPDAC_DACEN		(1 << 7)
+#define AD7152_CAPDAC_DACEN		BIT(7)
 #define AD7152_CAPDAC_DACP(x)		((x) & 0x1F)
 
 /* CFG2 Register Bit Designations (AD7152_REG_CFG2) */
-- 
2.1.4

