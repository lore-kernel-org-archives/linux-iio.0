Return-Path: <SRS0=ySyy=HT=canonical.com=shrirang.bagul@kernel.org>
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: jic23@kernel.org
Cc: lorenzo.bianconi83@gmail.com,
	linux-iio@vger.kernel.org
Subject: [PATCH][for iio-for-4.17b] iio: humidity: hts221: Fix sensor reads after resume
Date: Mon, 30 Apr 2018 13:16:58 +0800
Message-Id: <20180430051658.9856-1-shrirang.bagul@canonical.com>
List-ID: <linux-iio@vger.kernel.org>

CTRL1 register (ODR & BDU settings) gets reset after system comes back
from suspend, causing subsequent reads from the sensor to fail.

This patch restores the CTRL1 register after resume.

Based on:
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git iio-for-4.17b

Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR reconfiguration)
Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
---
 drivers/iio/humidity/hts221_core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 166946d4978d..5d7a652aa6d9 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -658,12 +658,13 @@ static int __maybe_unused hts221_resume(struct device *dev)
 	struct hts221_hw *hw = iio_priv(iio_dev);
 	int err = 0;
 
-	if (hw->enabled)
-		err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
-					 HTS221_ENABLE_MASK,
-					 FIELD_PREP(HTS221_ENABLE_MASK,
-						    true));
-	return err;
+	err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
+				 HTS221_BDU_MASK,
+				 FIELD_PREP(HTS221_BDU_MASK, 1));
+	if (err < 0)
+		return err;
+
+	return hts221_update_odr(hw, hw->odr);
 }
 
 const struct dev_pm_ops hts221_pm_ops = {
-- 
2.14.1
