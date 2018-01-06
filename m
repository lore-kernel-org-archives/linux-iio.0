Return-Path: <SRS0=aItP=EB=gmail.com=pundirsumit11@kernel.org>
From: Sumit Pundir <pundirsumit11@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Staging: iio: cdc: Prefer using BIT macro
Date: Sat,  6 Jan 2018 20:35:24 +0530
Message-Id: <1515251124-5954-1-git-send-email-pundirsumit11@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the following checkpatch.pl issue at multiple lines:

CHECK: Prefer using the BIT macro

Signed-off-by: Sumit Pundir <pundirsumit11@gmail.com>
---
v2:
 Added the specific driver being changed to the patch title
 and the appropriate fixes as suggested.

 drivers/staging/iio/cdc/ad7152.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 59d1b35..19dc896 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -47,7 +47,7 @@
 #define AD7152_STATUS_PWDN		BIT(7)
 
 /* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
-#define AD7152_SETUP_CAPDIFF		(1 << 5)
+#define AD7152_SETUP_CAPDIFF		BIT(5)
 #define AD7152_SETUP_RANGE_2pF		(0 << 6)
 #define AD7152_SETUP_RANGE_0_5pF	(1 << 6)
 #define AD7152_SETUP_RANGE_1pF		(2 << 6)
@@ -55,8 +55,8 @@
 #define AD7152_SETUP_RANGE(x)		((x) << 6)
 
 /* Config Register Bit Designations (AD7152_REG_CFG) */
-#define AD7152_CONF_CH2EN		(1 << 3)
-#define AD7152_CONF_CH1EN		(1 << 4)
+#define AD7152_CONF_CH2EN		BIT(3)
+#define AD7152_CONF_CH1EN		BIT(4)
 #define AD7152_CONF_MODE_IDLE		(0 << 0)
 #define AD7152_CONF_MODE_CONT_CONV	(1 << 0)
 #define AD7152_CONF_MODE_SINGLE_CONV	(2 << 0)
@@ -64,7 +64,7 @@
 #define AD7152_CONF_MODE_GAIN_CAL	(6 << 0)
 
 /* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
-#define AD7152_CAPDAC_DACEN		(1 << 7)
+#define AD7152_CAPDAC_DACEN		BIT(7)
 #define AD7152_CAPDAC_DACP(x)		((x) & 0x1F)
 
 /* CFG2 Register Bit Designations (AD7152_REG_CFG2) */
-- 
2.7.4
