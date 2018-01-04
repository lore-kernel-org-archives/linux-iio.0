Return-Path: <SRS0=o1aO=D7=gmail.com=pundirsumit11@kernel.org>
From: Sumit Pundir <pundirsumit11@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org
Subject: [PATCH] Staging: iio: Prefer using BIT macro
Date: Thu,  4 Jan 2018 22:06:31 +0530
Message-Id: <1515083791-19049-1-git-send-email-pundirsumit11@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the following checkpatch.pl error at multiple lines:

CHECK: Prefer using the BIT macro

Signed-off-by: Sumit Pundir <pundirsumit11@gmail.com>
---
 drivers/staging/iio/cdc/ad7152.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 59d1b35..b2b15b9 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -47,24 +47,24 @@
 #define AD7152_STATUS_PWDN		BIT(7)
 
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
2.7.4
