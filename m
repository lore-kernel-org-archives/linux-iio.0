Return-Path: <SRS0=C534=6U=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH v2 03/10] iio: humidity: hts221: do not overwrite reserved data during power-down
Date: Mon, 17 Jul 2017 19:38:58 +0200
Message-Id: <20170717173905.8209-4-lorenzo.bianconi@st.com>
In-Reply-To: <20170717173905.8209-1-lorenzo.bianconi@st.com>
References: <20170717173905.8209-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

GENMASK(6, 3) in CTRL_REG1 and GENMASK(6, 2) in CTRL_REG2 are marked
reserved. Do not changed the original value (not declared in the
datasheet) during power-down/suspend routines.

Fixes: e4a70e3e7d84 (iio: humidity: add support to hts221 rh/temp device)
Fixes: b7079eeac5da (iio: humidity: hts221: add power management support)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/humidity/hts221_core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 47a29b2da1ce..6e5847386a45 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -305,11 +305,10 @@ int hts221_power_on(struct hts221_hw *hw)
 
 int hts221_power_off(struct hts221_hw *hw)
 {
-	__le16 data = 0;
 	int err;
 
-	err = hw->tf->write(hw->dev, HTS221_REG_CNTRL1_ADDR, sizeof(data),
-			    (u8 *)&data);
+	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
+				     HTS221_ENABLE_MASK, false);
 	if (err < 0)
 		return err;
 
@@ -692,11 +691,10 @@ static int __maybe_unused hts221_suspend(struct device *dev)
 {
 	struct iio_dev *iio_dev = dev_get_drvdata(dev);
 	struct hts221_hw *hw = iio_priv(iio_dev);
-	__le16 data = 0;
 	int err;
 
-	err = hw->tf->write(hw->dev, HTS221_REG_CNTRL1_ADDR, sizeof(data),
-			    (u8 *)&data);
+	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
+				     HTS221_ENABLE_MASK, false);
 
 	return err < 0 ? err : 0;
 }
-- 
2.13.2
