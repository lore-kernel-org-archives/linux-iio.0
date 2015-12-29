Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35662 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbbL2L2R (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Dec 2015 06:28:17 -0500
Received: by mail-pf0-f194.google.com with SMTP id e65so11434939pfe.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Dec 2015 03:28:17 -0800 (PST)
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 1/5] Staging: iio: cdc: ad7746: Prefer using the BIT macro
Date: Tue, 29 Dec 2015 16:57:27 +0530
Message-Id: <1451388451-10342-2-git-send-email-shraddha.6596@gmail.com>
In-Reply-To: <1451388451-10342-1-git-send-email-shraddha.6596@gmail.com>
References: <1451388451-10342-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace bit shifting on 1 with the BIT(x) macro

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 2c5d277..a4ad2f1 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -45,20 +45,20 @@
 #define AD7746_STATUS_RDYCAP		BIT(0)
 
 /* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SETUP) */
-#define AD7746_CAPSETUP_CAPEN		(1 << 7)
-#define AD7746_CAPSETUP_CIN2		(1 << 6) /* AD7746 only */
-#define AD7746_CAPSETUP_CAPDIFF		(1 << 5)
-#define AD7746_CAPSETUP_CACHOP		(1 << 0)
+#define AD7746_CAPSETUP_CAPEN		BIT(7)
+#define AD7746_CAPSETUP_CIN2		BIT(6) /* AD7746 only */
+#define AD7746_CAPSETUP_CAPDIFF		BIT(5)
+#define AD7746_CAPSETUP_CACHOP		BIT(0)
 
 /* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SETUP) */
-#define AD7746_VTSETUP_VTEN		(1 << 7)
+#define AD7746_VTSETUP_VTEN		BIT(7)
 #define AD7746_VTSETUP_VTMD_INT_TEMP	(0 << 5)
-#define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
+#define AD7746_VTSETUP_VTMD_EXT_TEMP	BIT(5)
 #define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
 #define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
-#define AD7746_VTSETUP_EXTREF		(1 << 4)
-#define AD7746_VTSETUP_VTSHORT		(1 << 1)
-#define AD7746_VTSETUP_VTCHOP		(1 << 0)
+#define AD7746_VTSETUP_EXTREF		BIT(4)
+#define AD7746_VTSETUP_VTSHORT		BIT(1)
+#define AD7746_VTSETUP_VTCHOP		BIT(0)
 
 /* Excitation Setup Register Bit Designations (AD7746_REG_EXC_SETUP) */
 #define AD7746_EXCSETUP_CLKCTRL		BIT(7)
@@ -73,14 +73,14 @@
 #define AD7746_CONF_VTFS(x)		((x) << 6)
 #define AD7746_CONF_CAPFS(x)		((x) << 3)
 #define AD7746_CONF_MODE_IDLE		(0 << 0)
-#define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
+#define AD7746_CONF_MODE_CONT_CONV	BIT(0)
 #define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
 #define AD7746_CONF_MODE_PWRDN		(3 << 0)
 #define AD7746_CONF_MODE_OFFS_CAL	(5 << 0)
 #define AD7746_CONF_MODE_GAIN_CAL	(6 << 0)
 
 /* CAPDAC Register Bit Designations (AD7746_REG_CAPDACx) */
-#define AD7746_CAPDAC_DACEN		(1 << 7)
+#define AD7746_CAPDAC_DACEN		BIT(7)
 #define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
 
 /*
-- 
2.1.4

