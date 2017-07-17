Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33456 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdGQRjQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jul 2017 13:39:16 -0400
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH v2 04/10] iio: humidity: hts221: avoid useless ODR reconfiguration
Date: Mon, 17 Jul 2017 19:38:59 +0200
Message-Id: <20170717173905.8209-5-lorenzo.bianconi@st.com>
In-Reply-To: <20170717173905.8209-1-lorenzo.bianconi@st.com>
References: <20170717173905.8209-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Configure sensor ODR just in hts221_write_raw() in order to avoid
to set device sample rate multiple times.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/humidity/hts221_core.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 6e5847386a45..f99adc44139e 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -208,11 +208,6 @@ static int hts221_update_odr(struct hts221_hw *hw, u8 odr)
 	if (err < 0)
 		return err;
 
-	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
-				     HTS221_ENABLE_MASK, 1);
-	if (err < 0)
-		return err;
-
 	hw->odr = odr;
 
 	return 0;
@@ -294,7 +289,8 @@ int hts221_power_on(struct hts221_hw *hw)
 {
 	int err;
 
-	err = hts221_update_odr(hw, hw->odr);
+	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
+				     HTS221_ENABLE_MASK, true);
 	if (err < 0)
 		return err;
 
@@ -627,8 +623,6 @@ int hts221_probe(struct iio_dev *iio_dev)
 	if (err < 0)
 		return err;
 
-	hw->odr = hts221_odr_table[0].hz;
-
 	iio_dev->modes = INDIO_DIRECT_MODE;
 	iio_dev->dev.parent = hw->dev;
 	iio_dev->available_scan_masks = hts221_scan_masks;
@@ -643,6 +637,10 @@ int hts221_probe(struct iio_dev *iio_dev)
 	if (err < 0)
 		return err;
 
+	err = hts221_update_odr(hw, hts221_odr_table[0].hz);
+	if (err < 0)
+		return err;
+
 	/* configure humidity sensor */
 	err = hts221_parse_rh_caldata(hw);
 	if (err < 0) {
@@ -706,7 +704,8 @@ static int __maybe_unused hts221_resume(struct device *dev)
 	int err = 0;
 
 	if (hw->enabled)
-		err = hts221_update_odr(hw, hw->odr);
+		err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
+					     HTS221_ENABLE_MASK, true);
 
 	return err;
 }
-- 
2.13.2

