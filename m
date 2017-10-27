Return-Path: <SRS0=wbiz=B2=pmeerw.net=pmeerw@kernel.org>
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH 01/13] iio: health: max30102: Fix mode config values
Date: Fri, 27 Oct 2017 21:29:36 +0200
Message-Id: <1509132593-1815-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
References: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Table 4 of the datasheet specifies the mode control, these are not
individual bits; add multi LED mode

Add multi-LED mode and fix MODE_MASK (3 bits wide, not 2)

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/iio/health/max30102.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 203ffb9..7635bef 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -60,9 +60,10 @@
 #define MAX30102_REG_FIFO_CONFIG_AFULL		BIT(0)
 
 #define MAX30102_REG_MODE_CONFIG		0x09
-#define MAX30102_REG_MODE_CONFIG_MODE_SPO2_EN	BIT(0)
-#define MAX30102_REG_MODE_CONFIG_MODE_HR_EN	BIT(1)
-#define MAX30102_REG_MODE_CONFIG_MODE_MASK	0x03
+#define MAX30102_REG_MODE_CONFIG_MODE_HR	0x02 /* red LED */
+#define MAX30102_REG_MODE_CONFIG_MODE_HR_SPO2	0x03 /* red + IR LED */
+#define MAX30102_REG_MODE_CONFIG_MODE_MULTI	0x07 /* multi-LED mode */
+#define MAX30102_REG_MODE_CONFIG_MODE_MASK	GENMASK(2, 0)
 #define MAX30102_REG_MODE_CONFIG_PWR		BIT(7)
 
 #define MAX30102_REG_SPO2_CONFIG		0x0a
@@ -287,11 +288,10 @@ static int max30102_chip_init(struct max30102_data *data)
 	if (ret)
 		return ret;
 
-	/* enable SPO2 mode */
+	/* enable HR + SPO2 mode */
 	ret = regmap_update_bits(data->regmap, MAX30102_REG_MODE_CONFIG,
 				 MAX30102_REG_MODE_CONFIG_MODE_MASK,
-				 MAX30102_REG_MODE_CONFIG_MODE_HR_EN |
-				 MAX30102_REG_MODE_CONFIG_MODE_SPO2_EN);
+				 MAX30102_REG_MODE_CONFIG_MODE_HR_SPO2);
 	if (ret)
 		return ret;
 
-- 
2.7.4
