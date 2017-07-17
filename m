Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34890 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdGQRjR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jul 2017 13:39:17 -0400
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH v2 05/10] iio: humidity: hts221: squash hts221_power_on/off in hts221_set_enable
Date: Mon, 17 Jul 2017 19:39:00 +0200
Message-Id: <20170717173905.8209-6-lorenzo.bianconi@st.com>
In-Reply-To: <20170717173905.8209-1-lorenzo.bianconi@st.com>
References: <20170717173905.8209-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/humidity/hts221.h        |  3 +--
 drivers/iio/humidity/hts221_buffer.c |  4 ++--
 drivers/iio/humidity/hts221_core.c   | 24 +++++-------------------
 3 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
index bf33d8f6396c..69dfa5c63ec2 100644
--- a/drivers/iio/humidity/hts221.h
+++ b/drivers/iio/humidity/hts221.h
@@ -62,8 +62,7 @@ extern const struct dev_pm_ops hts221_pm_ops;
 
 int hts221_config_drdy(struct hts221_hw *hw, bool enable);
 int hts221_probe(struct iio_dev *iio_dev);
-int hts221_power_on(struct hts221_hw *hw);
-int hts221_power_off(struct hts221_hw *hw);
+int hts221_set_enable(struct hts221_hw *hw, bool enable);
 int hts221_allocate_buffers(struct hts221_hw *hw);
 int hts221_allocate_trigger(struct hts221_hw *hw);
 
diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 7d19a3da7ab7..c4ed153ad397 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -109,12 +109,12 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
 
 static int hts221_buffer_preenable(struct iio_dev *iio_dev)
 {
-	return hts221_power_on(iio_priv(iio_dev));
+	return hts221_set_enable(iio_priv(iio_dev), true);
 }
 
 static int hts221_buffer_postdisable(struct iio_dev *iio_dev)
 {
-	return hts221_power_off(iio_priv(iio_dev));
+	return hts221_set_enable(iio_priv(iio_dev), false);
 }
 
 static const struct iio_buffer_setup_ops hts221_buffer_ops = {
diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index f99adc44139e..dc55d9fbc702 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -285,30 +285,16 @@ hts221_sysfs_temp_oversampling_avail(struct device *dev,
 	return len;
 }
 
-int hts221_power_on(struct hts221_hw *hw)
+int hts221_set_enable(struct hts221_hw *hw, bool enable)
 {
 	int err;
 
 	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
-				     HTS221_ENABLE_MASK, true);
+				     HTS221_ENABLE_MASK, enable);
 	if (err < 0)
 		return err;
 
-	hw->enabled = true;
-
-	return 0;
-}
-
-int hts221_power_off(struct hts221_hw *hw)
-{
-	int err;
-
-	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
-				     HTS221_ENABLE_MASK, false);
-	if (err < 0)
-		return err;
-
-	hw->enabled = false;
+	hw->enabled = enable;
 
 	return 0;
 }
@@ -463,7 +449,7 @@ static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
 	u8 data[HTS221_DATA_SIZE];
 	int err;
 
-	err = hts221_power_on(hw);
+	err = hts221_set_enable(hw, true);
 	if (err < 0)
 		return err;
 
@@ -473,7 +459,7 @@ static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
 	if (err < 0)
 		return err;
 
-	hts221_power_off(hw);
+	hts221_set_enable(hw, false);
 
 	*val = (s16)get_unaligned_le16(data);
 
-- 
2.13.2

