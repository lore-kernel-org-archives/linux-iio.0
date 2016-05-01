Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34566 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227AbcEAUh3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 1 May 2016 16:37:29 -0400
From: "Andrew F. Davis" <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>, <linux-api@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 12/13] iio: health/afe440x: Remove unused definitions
Date: Sun, 1 May 2016 15:37:02 -0500
Message-ID: <1462135023-14445-13-git-send-email-afd@ti.com>
In-Reply-To: <1462135023-14445-1-git-send-email-afd@ti.com>
References: <1462135023-14445-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These definitions are not currently used and if the functionality
they represent is needed the values should be added back to a table
for easy userspace use.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/iio/health/afe4403.c | 37 -------------------------------------
 drivers/iio/health/afe4404.c | 20 --------------------
 2 files changed, 57 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 059d521..9a08146 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -39,43 +39,6 @@
 #define AFE4403_TIAGAIN			0x20
 #define AFE4403_TIA_AMB_GAIN		0x21
 
-/* AFE4403 LEDCNTRL values */
-#define AFE440X_LEDCNTRL_RANGE_TX_HALF	0x1
-#define AFE440X_LEDCNTRL_RANGE_TX_FULL	0x2
-#define AFE440X_LEDCNTRL_RANGE_TX_OFF	0x3
-
-/* AFE4403 CONTROL2 values */
-#define AFE440X_CONTROL2_TX_REF_025	0x0
-#define AFE440X_CONTROL2_TX_REF_050	0x1
-#define AFE440X_CONTROL2_TX_REF_100	0x2
-#define AFE440X_CONTROL2_TX_REF_075	0x3
-
-/* AFE4403 CONTROL3 values */
-#define AFE440X_CONTROL3_CLK_DIV_2	0x0
-#define AFE440X_CONTROL3_CLK_DIV_4	0x2
-#define AFE440X_CONTROL3_CLK_DIV_6	0x3
-#define AFE440X_CONTROL3_CLK_DIV_8	0x4
-#define AFE440X_CONTROL3_CLK_DIV_12	0x5
-#define AFE440X_CONTROL3_CLK_DIV_1	0x7
-
-/* AFE4403 TIAGAIN_CAP values */
-#define AFE4403_TIAGAIN_CAP_5_P		0x0
-#define AFE4403_TIAGAIN_CAP_10_P	0x1
-#define AFE4403_TIAGAIN_CAP_20_P	0x2
-#define AFE4403_TIAGAIN_CAP_30_P	0x3
-#define AFE4403_TIAGAIN_CAP_55_P	0x8
-#define AFE4403_TIAGAIN_CAP_155_P	0x10
-
-/* AFE4403 TIAGAIN_RES values */
-#define AFE4403_TIAGAIN_RES_500_K	0x0
-#define AFE4403_TIAGAIN_RES_250_K	0x1
-#define AFE4403_TIAGAIN_RES_100_K	0x2
-#define AFE4403_TIAGAIN_RES_50_K	0x3
-#define AFE4403_TIAGAIN_RES_25_K	0x4
-#define AFE4403_TIAGAIN_RES_10_K	0x5
-#define AFE4403_TIAGAIN_RES_1_M		0x6
-#define AFE4403_TIAGAIN_RES_NONE	0x7
-
 enum afe4403_fields {
 	/* Gains */
 	F_RF_LED1, F_CF_LED1,
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index aa8770b..3a8131d 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -51,26 +51,6 @@
 /* AFE4404 CONTROL3 register fields */
 #define AFE440X_CONTROL3_OSC_ENABLE	BIT(9)
 
-/* AFE4404 TIA_GAIN_CAP values */
-#define AFE4404_TIA_GAIN_CAP_5_P	0x0
-#define AFE4404_TIA_GAIN_CAP_2_5_P	0x1
-#define AFE4404_TIA_GAIN_CAP_10_P	0x2
-#define AFE4404_TIA_GAIN_CAP_7_5_P	0x3
-#define AFE4404_TIA_GAIN_CAP_20_P	0x4
-#define AFE4404_TIA_GAIN_CAP_17_5_P	0x5
-#define AFE4404_TIA_GAIN_CAP_25_P	0x6
-#define AFE4404_TIA_GAIN_CAP_22_5_P	0x7
-
-/* AFE4404 TIA_GAIN_RES values */
-#define AFE4404_TIA_GAIN_RES_500_K	0x0
-#define AFE4404_TIA_GAIN_RES_250_K	0x1
-#define AFE4404_TIA_GAIN_RES_100_K	0x2
-#define AFE4404_TIA_GAIN_RES_50_K	0x3
-#define AFE4404_TIA_GAIN_RES_25_K	0x4
-#define AFE4404_TIA_GAIN_RES_10_K	0x5
-#define AFE4404_TIA_GAIN_RES_1_M	0x6
-#define AFE4404_TIA_GAIN_RES_2_M	0x7
-
 enum afe4404_fields {
 	/* Gains */
 	F_TIA_GAIN_SEP, F_TIA_CF_SEP,
-- 
2.8.1

