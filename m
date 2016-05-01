Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34568 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbcEAUha (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 1 May 2016 16:37:30 -0400
From: "Andrew F. Davis" <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>, <linux-api@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 13/13] iio: health/afe4404: ENSEPGAIN is part of CONTROL2 register
Date: Sun, 1 May 2016 15:37:03 -0500
Message-ID: <1462135023-14445-14-git-send-email-afd@ti.com>
In-Reply-To: <1462135023-14445-1-git-send-email-afd@ti.com>
References: <1462135023-14445-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Rename this definition, no functional changes.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/iio/health/afe4404.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 3a8131d..4526640 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -48,8 +48,8 @@
 #define AFE4404_AVG_LED2_ALED2VAL	0x3f
 #define AFE4404_AVG_LED1_ALED1VAL	0x40
 
-/* AFE4404 CONTROL3 register fields */
-#define AFE440X_CONTROL3_OSC_ENABLE	BIT(9)
+/* AFE4404 CONTROL2 register fields */
+#define AFE440X_CONTROL2_OSC_ENABLE	BIT(9)
 
 enum afe4404_fields {
 	/* Gains */
@@ -398,7 +398,7 @@ static const struct reg_sequence afe4404_reg_sequences[] = {
 	AFE4404_TIMING_PAIRS,
 	{ AFE440X_CONTROL1, AFE440X_CONTROL1_TIMEREN },
 	{ AFE4404_TIA_GAIN_SEP, AFE440X_TIAGAIN_ENSEPGAIN },
-	{ AFE440X_CONTROL2, AFE440X_CONTROL3_OSC_ENABLE	},
+	{ AFE440X_CONTROL2, AFE440X_CONTROL2_OSC_ENABLE	},
 };
 
 static const struct regmap_range afe4404_yes_ranges[] = {
-- 
2.8.1

