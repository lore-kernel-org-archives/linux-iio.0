Return-Path: <Ezequiel.Garcia@imgtec.com>
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Naidu Tellapati <naidu.tellapati@imgtec.com>, James Hartley
	<james.hartley@imgtec.com>, <phani.movva@imgtec.com>, Ezequiel Garcia
	<ezequiel.garcia@imgtec.com>
Subject: [PATCH 5/5] iio: adc: cc10001: Power-up the ADC at probe time when used remotely
Date: Thu, 7 May 2015 18:24:02 -0300
Message-ID: <1431033842-1149-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Naidu Tellapati <naidu.tellapati@imgtec.com>

The ADC is typically shared with remote CPUs not running Linux.
However, there is only one register to power-up/power-down. Remote CPUs
aren't able to power-up the ADC, and rely in Linux doing it instead.

This commit uses the adc-reserved-channels devicetree property to
distinguish shared usage. In this case, the ADC is powered up at
probe time.

If the ADC is used only by the CPU running Linux, power-up/down
at runtime, only when neeeded.

Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/iio/adc/cc10001_adc.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index 10c734d..7d1b2ae 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -62,6 +62,7 @@ struct cc10001_adc_device {
 	struct regulator *reg;
 	u16 *buf;
 
+	bool shared;
 	struct mutex lock;
 	unsigned int start_delay_ns;
 	unsigned int eoc_delay_ns;
@@ -155,7 +156,8 @@ static irqreturn_t cc10001_adc_trigger_h(int irq, void *p)
 
 	mutex_lock(&adc_dev->lock);
 
-	cc10001_adc_power_up(adc_dev);
+	if (!adc_dev->shared)
+		cc10001_adc_power_up(adc_dev);
 
 	/* Calculate delay step for eoc and sampled data */
 	delay_ns = adc_dev->eoc_delay_ns / CC10001_MAX_POLL_COUNT;
@@ -179,7 +181,8 @@ static irqreturn_t cc10001_adc_trigger_h(int irq, void *p)
 	}
 
 done:
-	cc10001_adc_power_down(adc_dev);
+	if (!adc_dev->shared)
+		cc10001_adc_power_down(adc_dev);
 
 	mutex_unlock(&adc_dev->lock);
 
@@ -198,7 +201,8 @@ static u16 cc10001_adc_read_raw_voltage(struct iio_dev *indio_dev,
 	unsigned int delay_ns;
 	u16 val;
 
-	cc10001_adc_power_up(adc_dev);
+	if (!adc_dev->shared)
+		cc10001_adc_power_up(adc_dev);
 
 	/* Calculate delay step for eoc and sampled data */
 	delay_ns = adc_dev->eoc_delay_ns / CC10001_MAX_POLL_COUNT;
@@ -207,7 +211,8 @@ static u16 cc10001_adc_read_raw_voltage(struct iio_dev *indio_dev,
 
 	val = cc10001_adc_poll_done(indio_dev, chan->channel, delay_ns);
 
-	cc10001_adc_power_down(adc_dev);
+	if (!adc_dev->shared)
+		cc10001_adc_power_down(adc_dev);
 
 	return val;
 }
@@ -324,8 +329,10 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 	adc_dev = iio_priv(indio_dev);
 
 	channel_map = GENMASK(CC10001_ADC_NUM_CHANNELS - 1, 0);
-	if (!of_property_read_u32(node, "adc-reserved-channels", &ret))
+	if (!of_property_read_u32(node, "adc-reserved-channels", &ret)) {
+		adc_dev->shared = true;
 		channel_map &= ~ret;
+	}
 
 	adc_dev->reg = devm_regulator_get(&pdev->dev, "vref");
 	if (IS_ERR(adc_dev->reg))
@@ -370,6 +377,14 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 	adc_dev->eoc_delay_ns = NSEC_PER_SEC / adc_clk_rate;
 	adc_dev->start_delay_ns = adc_dev->eoc_delay_ns * CC10001_WAIT_CYCLES;
 
+	/*
+	 * There is only one register to power-up/power-down the AUX ADC.
+	 * If the ADC is shared among multiple CPUs, always power it up here.
+	 * If the ADC is used only by the MIPS, power-up/power-down at runtime.
+	 */
+	if (adc_dev->shared)
+		cc10001_adc_power_up(adc_dev);
+
 	/* Setup the ADC channels available on the device */
 	ret = cc10001_adc_channel_init(indio_dev, channel_map);
 	if (ret < 0)
@@ -404,6 +419,7 @@ static int cc10001_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct cc10001_adc_device *adc_dev = iio_priv(indio_dev);
 
+	cc10001_adc_power_down(adc_dev);
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	clk_disable_unprepare(adc_dev->adc_clk);
-- 
2.3.3
