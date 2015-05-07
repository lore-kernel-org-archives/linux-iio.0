Return-Path: <Ezequiel.Garcia@imgtec.com>
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Naidu Tellapati <naidu.tellapati@imgtec.com>, James Hartley
	<james.hartley@imgtec.com>, <phani.movva@imgtec.com>, Ezequiel Garcia
	<ezequiel.garcia@imgtec.com>
Subject: [PATCH 2/5] iio: adc: cc10001: Fix incorrect use of power-up/power-down register
Date: Thu, 7 May 2015 18:22:18 -0300
Message-ID: <1431033741-1088-3-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1431033741-1088-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1431033741-1088-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Naidu Tellapati <naidu.tellapati@imgtec.com>

At present we are incorrectly setting the register to 0x1 to power up
the ADC. Since it is an active high power down register, we need to set
the register to 0x0 to actually power up. Conversely, writing 0x1 to the
register powers it down.

This commit adds a couple of helpers to make the code clearer and then
use them to do the power-up/power-down properly.

Fixes: 1664f6a5b0c8 ("iio: adc: Cosmic Circuits 10001 ADC driver")
Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/iio/adc/cc10001_adc.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index 357e6c2..cf6c6fb 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -35,8 +35,9 @@
 #define CC10001_ADC_EOC_SET		BIT(0)
 
 #define CC10001_ADC_CHSEL_SAMPLED	0x0c
-#define CC10001_ADC_POWER_UP		0x10
-#define CC10001_ADC_POWER_UP_SET	BIT(0)
+#define CC10001_ADC_POWER_DOWN		0x10
+#define CC10001_ADC_POWER_DOWN_SET	BIT(0)
+
 #define CC10001_ADC_DEBUG		0x14
 #define CC10001_ADC_DATA_COUNT		0x20
 
@@ -78,6 +79,20 @@ static inline u32 cc10001_adc_read_reg(struct cc10001_adc_device *adc_dev,
 	return readl(adc_dev->reg_base + reg);
 }
 
+static void cc10001_adc_power_up(struct cc10001_adc_device *adc_dev)
+{
+	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_DOWN,
+			      ~CC10001_ADC_POWER_DOWN_SET);
+
+	ndelay(adc_dev->start_delay_ns);
+}
+
+static void cc10001_adc_power_down(struct cc10001_adc_device *adc_dev)
+{
+	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_DOWN,
+			      CC10001_ADC_POWER_DOWN_SET);
+}
+
 static void cc10001_adc_start(struct cc10001_adc_device *adc_dev,
 			      unsigned int channel)
 {
@@ -139,11 +154,7 @@ static irqreturn_t cc10001_adc_trigger_h(int irq, void *p)
 
 	mutex_lock(&adc_dev->lock);
 
-	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_UP,
-			      CC10001_ADC_POWER_UP_SET);
-
-	/* Wait for 8 (6+2) clock cycles before activating START */
-	ndelay(adc_dev->start_delay_ns);
+	cc10001_adc_power_up(adc_dev);
 
 	/* Calculate delay step for eoc and sampled data */
 	delay_ns = adc_dev->eoc_delay_ns / CC10001_MAX_POLL_COUNT;
@@ -167,7 +178,7 @@ static irqreturn_t cc10001_adc_trigger_h(int irq, void *p)
 	}
 
 done:
-	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_UP, 0);
+	cc10001_adc_power_down(adc_dev);
 
 	mutex_unlock(&adc_dev->lock);
 
@@ -186,11 +197,7 @@ static u16 cc10001_adc_read_raw_voltage(struct iio_dev *indio_dev,
 	unsigned int delay_ns;
 	u16 val;
 
-	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_UP,
-			      CC10001_ADC_POWER_UP_SET);
-
-	/* Wait for 8 (6+2) clock cycles before activating START */
-	ndelay(adc_dev->start_delay_ns);
+	cc10001_adc_power_up(adc_dev);
 
 	/* Calculate delay step for eoc and sampled data */
 	delay_ns = adc_dev->eoc_delay_ns / CC10001_MAX_POLL_COUNT;
@@ -199,7 +206,7 @@ static u16 cc10001_adc_read_raw_voltage(struct iio_dev *indio_dev,
 
 	val = cc10001_adc_poll_done(indio_dev, chan->channel, delay_ns);
 
-	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_UP, 0);
+	cc10001_adc_power_down(adc_dev);
 
 	return val;
 }
-- 
2.3.3
