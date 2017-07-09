Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36235 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbdGIQ5X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jul 2017 12:57:23 -0400
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH 7/9] iio: humidity: hts221: support open drain mode
Date: Sun,  9 Jul 2017 18:57:02 +0200
Message-Id: <20170709165704.26311-8-lorenzo.bianconi@st.com>
In-Reply-To: <20170709165704.26311-1-lorenzo.bianconi@st.com>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add open drain support in order to share requested IRQ line between
hts221 device and other peripherals

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/humidity/hts221_buffer.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index ad5222295b2c..f29f01a22375 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -20,10 +20,14 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/buffer.h>
 
+#include <linux/platform_data/st_sensors_pdata.h>
+
 #include "hts221.h"
 
 #define HTS221_REG_DRDY_HL_ADDR		0x22
 #define HTS221_REG_DRDY_HL_MASK		BIT(7)
+#define HTS221_REG_DRDY_PP_OD_ADDR	0x22
+#define HTS221_REG_DRDY_PP_OD_MASK	BIT(6)
 #define HTS221_REG_STATUS_ADDR		0x27
 #define HTS221_RH_DRDY_MASK		BIT(1)
 #define HTS221_TEMP_DRDY_MASK		BIT(0)
@@ -69,7 +73,9 @@ static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
 int hts221_allocate_trigger(struct hts221_hw *hw)
 {
 	struct iio_dev *iio_dev = iio_priv_to_dev(hw);
-	bool irq_active_low = false;
+	bool irq_active_low = false, open_drain = false;
+	struct device_node *np = hw->dev->of_node;
+	struct st_sensors_platform_data *pdata;
 	unsigned long irq_type;
 	int err;
 
@@ -95,6 +101,20 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
 				     HTS221_REG_DRDY_HL_MASK, irq_active_low);
 	if (err < 0)
 		return err;
+
+	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
+	if ((np && of_property_read_bool(np, "drive-open-drain")) ||
+	    (pdata && pdata->open_drain)) {
+		irq_type |= IRQF_SHARED;
+		open_drain = true;
+	}
+
+	err = hts221_write_with_mask(hw, HTS221_REG_DRDY_PP_OD_ADDR,
+				     HTS221_REG_DRDY_PP_OD_MASK,
+				     open_drain);
+	if (err < 0)
+		return err;
+
 	err = devm_request_threaded_irq(hw->dev, hw->irq, NULL,
 					hts221_trigger_handler_thread,
 					irq_type | IRQF_ONESHOT,
-- 
2.13.1

