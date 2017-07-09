Return-Path: <SRS0=3AiK=6M=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 5/9] iio: humidity: hts221: support active-low interrupts
Date: Sun,  9 Jul 2017 18:57:00 +0200
Message-Id: <20170709165704.26311-6-lorenzo.bianconi@st.com>
In-Reply-To: <20170709165704.26311-1-lorenzo.bianconi@st.com>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Add support for active low interrupts (IRQF_TRIGGER_LOW and
IRQF_TRIGGER_FALLING). Configure the device as active high or low
according to the requested irq line.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/humidity/hts221.h        |  1 +
 drivers/iio/humidity/hts221_buffer.c | 11 +++++++++++
 drivers/iio/humidity/hts221_core.c   |  3 +--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
index 7b5691a6df53..0fbc89fe213d 100644
--- a/drivers/iio/humidity/hts221.h
+++ b/drivers/iio/humidity/hts221.h
@@ -67,6 +67,7 @@ struct hts221_hw {
 extern const struct dev_pm_ops hts221_pm_ops;
 
 int hts221_config_drdy(struct hts221_hw *hw, bool enable);
+int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask, u8 val);
 int hts221_probe(struct iio_dev *iio_dev);
 int hts221_set_enable(struct hts221_hw *hw, bool enable);
 int hts221_allocate_buffers(struct hts221_hw *hw);
diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index c4ed153ad397..ad5222295b2c 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -22,6 +22,8 @@
 
 #include "hts221.h"
 
+#define HTS221_REG_DRDY_HL_ADDR		0x22
+#define HTS221_REG_DRDY_HL_MASK		BIT(7)
 #define HTS221_REG_STATUS_ADDR		0x27
 #define HTS221_RH_DRDY_MASK		BIT(1)
 #define HTS221_TEMP_DRDY_MASK		BIT(0)
@@ -67,6 +69,7 @@ static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
 int hts221_allocate_trigger(struct hts221_hw *hw)
 {
 	struct iio_dev *iio_dev = iio_priv_to_dev(hw);
+	bool irq_active_low = false;
 	unsigned long irq_type;
 	int err;
 
@@ -76,6 +79,10 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
 	case IRQF_TRIGGER_HIGH:
 	case IRQF_TRIGGER_RISING:
 		break;
+	case IRQF_TRIGGER_LOW:
+	case IRQF_TRIGGER_FALLING:
+		irq_active_low = true;
+		break;
 	default:
 		dev_info(hw->dev,
 			 "mode %lx unsupported, using IRQF_TRIGGER_RISING\n",
@@ -84,6 +91,10 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
 		break;
 	}
 
+	err = hts221_write_with_mask(hw, HTS221_REG_DRDY_HL_ADDR,
+				     HTS221_REG_DRDY_HL_MASK, irq_active_low);
+	if (err < 0)
+		return err;
 	err = devm_request_threaded_irq(hw->dev, hw->irq, NULL,
 					hts221_trigger_handler_thread,
 					irq_type | IRQF_ONESHOT,
diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 7d30e2594a58..dfacf64a6f2e 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -134,8 +134,7 @@ static const struct iio_chan_spec hts221_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
-static int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask,
-				  u8 val)
+int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask, u8 val)
 {
 	u8 data;
 	int err;
-- 
2.13.1
