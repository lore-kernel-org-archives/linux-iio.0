Return-Path: <SRS0=C534=6U=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH v2 10/10] iio: humidity: hts221: move drdy enable logic in hts221_trig_set_state()
Date: Mon, 17 Jul 2017 19:39:05 +0200
Message-Id: <20170717173905.8209-11-lorenzo.bianconi@st.com>
In-Reply-To: <20170717173905.8209-1-lorenzo.bianconi@st.com>
References: <20170717173905.8209-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Move data-ready configuration in hts221_buffer.c since it is only related
to trigger logic

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/humidity/hts221.h        |  1 -
 drivers/iio/humidity/hts221_buffer.c |  8 +++++++-
 drivers/iio/humidity/hts221_core.c   | 14 --------------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
index c3de6e494f8c..51d021966222 100644
--- a/drivers/iio/humidity/hts221.h
+++ b/drivers/iio/humidity/hts221.h
@@ -60,7 +60,6 @@ struct hts221_hw {
 
 extern const struct dev_pm_ops hts221_pm_ops;
 
-int hts221_config_drdy(struct hts221_hw *hw, bool enable);
 int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask, u8 val);
 int hts221_probe(struct iio_dev *iio_dev);
 int hts221_set_enable(struct hts221_hw *hw, bool enable);
diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index f29f01a22375..9690dfe9a844 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -28,6 +28,8 @@
 #define HTS221_REG_DRDY_HL_MASK		BIT(7)
 #define HTS221_REG_DRDY_PP_OD_ADDR	0x22
 #define HTS221_REG_DRDY_PP_OD_MASK	BIT(6)
+#define HTS221_REG_DRDY_EN_ADDR		0x22
+#define HTS221_REG_DRDY_EN_MASK		BIT(2)
 #define HTS221_REG_STATUS_ADDR		0x27
 #define HTS221_RH_DRDY_MASK		BIT(1)
 #define HTS221_TEMP_DRDY_MASK		BIT(0)
@@ -36,8 +38,12 @@ static int hts221_trig_set_state(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *iio_dev = iio_trigger_get_drvdata(trig);
 	struct hts221_hw *hw = iio_priv(iio_dev);
+	int err;
+
+	err = hts221_write_with_mask(hw, HTS221_REG_DRDY_EN_ADDR,
+				     HTS221_REG_DRDY_EN_MASK, state);
 
-	return hts221_config_drdy(hw, state);
+	return err < 0 ? err : 0;
 }
 
 static const struct iio_trigger_ops hts221_trigger_ops = {
diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 25fcb9993998..32524a8dc66f 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -23,7 +23,6 @@
 
 #define HTS221_REG_CNTRL1_ADDR		0x20
 #define HTS221_REG_CNTRL2_ADDR		0x21
-#define HTS221_REG_CNTRL3_ADDR		0x22
 
 #define HTS221_REG_AVG_ADDR		0x10
 #define HTS221_REG_H_OUT_L		0x28
@@ -36,9 +35,6 @@
 #define HTS221_BDU_MASK			BIT(2)
 #define HTS221_ENABLE_MASK		BIT(7)
 
-#define HTS221_DRDY_MASK		BIT(2)
-
-
 /* calibration registers */
 #define HTS221_REG_0RH_CAL_X_H		0x36
 #define HTS221_REG_1RH_CAL_X_H		0x3a
@@ -181,16 +177,6 @@ static int hts221_check_whoami(struct hts221_hw *hw)
 	return 0;
 }
 
-int hts221_config_drdy(struct hts221_hw *hw, bool enable)
-{
-	int err;
-
-	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL3_ADDR,
-				     HTS221_DRDY_MASK, enable);
-
-	return err < 0 ? err : 0;
-}
-
 static int hts221_update_odr(struct hts221_hw *hw, u8 odr)
 {
 	int i, err;
-- 
2.13.2
