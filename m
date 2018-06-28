Return-Path: <SRS0=VduX=JO=canonical.com=shrirang.bagul@kernel.org>
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: jic23@kernel.org,
	lorenzo.bianconi@redhat.com
Cc: lorenzo.bianconi83@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: humidity: hts221: Fix sensor reads after resume
Date: Thu, 28 Jun 2018 16:22:15 +0800
Message-Id: <20180628082215.12023-1-shrirang.bagul@canonical.com>
List-ID: <linux-iio@vger.kernel.org>

AV_CONF register (RH & TEMP. oversampling ratio's) and CTRL1 register
(ODR & BDU settings) values are lost after suspend.

While the change in AV_CONF updates the sensor resolution modes
(overriding the user configuration before the device went to suspend);
loss of the contents of the CTRL1 register leads to failure in reading
sensor output.

This patch restores the AV_CONF & CTRL1 registers after resume.

Changes from v1:
- Don't drop enabling the sensor during resume
- Restore AV_CONF register along with CTRL1
  (As demonstrated with i2c register dumps of hts221 captured on Dell
  IoT Gateways 300x before suspend & after resume [1])

Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR reconfiguration)
Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>

[v1] https://marc.info/?l=linux-iio&m=152506543000442&w=2
[1] https://marc.info/?l=linux-iio&m=152534455701742&w=2

This patch is based on:
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git -b testing
---
 drivers/iio/humidity/hts221_core.c | 31 +++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 166946d4978d..fc5599497f55 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -656,14 +656,43 @@ static int __maybe_unused hts221_resume(struct device *dev)
 {
 	struct iio_dev *iio_dev = dev_get_drvdata(dev);
 	struct hts221_hw *hw = iio_priv(iio_dev);
+	const struct hts221_avg *avg;
+	u8 data, idx;
 	int err = 0;
 
+	/* Restore contents of AV_CONF (RH & TEMP. oversampling ratio's) */
+	avg = &hts221_avg_list[HTS221_SENSOR_H];
+	idx = hw->sensors[HTS221_SENSOR_H].cur_avg_idx;
+	data = avg->avg_avl[idx];
+	err = hts221_update_avg(hw, HTS221_SENSOR_H, data);
+	if (err < 0)
+		goto fail_err;
+
+	avg = &hts221_avg_list[HTS221_SENSOR_T];
+	idx = hw->sensors[HTS221_SENSOR_T].cur_avg_idx;
+	data = avg->avg_avl[idx];
+	err = hts221_update_avg(hw, HTS221_SENSOR_T, data);
+	if (err < 0)
+		goto fail_err;
+
+	/* Restore contents of CTRL1 (BDU & ODR) */
+	err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
+				 HTS221_BDU_MASK,
+				 FIELD_PREP(HTS221_BDU_MASK, 1));
+	if (err < 0)
+		goto fail_err;
+
+	err = hts221_update_odr(hw, hw->odr);
+	if (err < 0)
+		goto fail_err;
+
 	if (hw->enabled)
 		err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
 					 HTS221_ENABLE_MASK,
 					 FIELD_PREP(HTS221_ENABLE_MASK,
 						    true));
-	return err;
+fail_err:
+	return err < 0 ? err : 0;
 }
 
 const struct dev_pm_ops hts221_pm_ops = {
-- 
2.17.1
