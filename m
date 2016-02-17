Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30858 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965212AbcBQRku (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 17 Feb 2016 12:40:50 -0500
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v2 6/6] iio:pressure:ms5611: continuous sampling support
Date: Wed, 17 Feb 2016 18:38:44 +0100
Message-ID: <4ea095797fee0e6c4e035c5345d4b001001bfb82.1455729921.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1455729921.git.gregor.boirie@parrot.com>
References: <cover.1455729921.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Implement INDIO_BUFFER_SOFTWARE mode to allow continuous sampling without
relying upon external trigger.
Sampling is carried out by a kthread which life cycle is bound to samples
buffering: it is created at postenable time and destroyed at predisable
time.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/pressure/ms5611.h      |   8 +++
 drivers/iio/pressure/ms5611_core.c | 117 ++++++++++++++++++++++++++++++-------
 2 files changed, 105 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
index b07897f..27edd384 100644
--- a/drivers/iio/pressure/ms5611.h
+++ b/drivers/iio/pressure/ms5611.h
@@ -44,10 +44,17 @@ struct ms5611_osr {
 	unsigned short rate;
 };
 
+/*
+ * Number of s32 for a complete sample, i.e. s32 (pressure) + s32 (temp) +
+ * 2 * s32 (timestamp).
+ */
+#define MS5611_BUFFER_NR (4U)
+
 struct ms5611_state {
 	void *client;
 	struct mutex lock;
 
+	s32 buf[MS5611_BUFFER_NR];
 	const struct ms5611_osr *pressure_osr;
 	const struct ms5611_osr *temp_osr;
 
@@ -57,6 +64,7 @@ struct ms5611_state {
 					  s32 *temp, s32 *pressure);
 
 	struct ms5611_chip_info *chip_info;
+	struct task_struct *task;
 };
 
 int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 06d453c..443a0ce 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -14,16 +14,22 @@
  */
 
 #include <linux/module.h>
-#include <linux/iio/iio.h>
 #include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/freezer.h>
 #include <linux/regulator/consumer.h>
-
+#include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include "ms5611.h"
 
+enum {
+	MS5611_PRESSURE = 0,
+	MS5611_TEMP = 1
+};
+
 #define MS5611_INIT_OSR(_cmd, _conv_usec, _rate) \
 	{ .cmd = _cmd, .conv_usec = _conv_usec, .rate = _rate }
 
@@ -210,25 +216,28 @@ static int ms5611_reset(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static irqreturn_t ms5611_trigger_handler(int irq, void *p)
+static void ms5611_push_data(struct iio_dev *indio_dev,
+                             struct ms5611_state *state)
 {
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
-	struct ms5611_state *st = iio_priv(indio_dev);
-	s32 buf[4]; /* s32 (pressure) + s32 (temp) + 2 * s32 (timestamp) */
 	int ret;
 
-	mutex_lock(&st->lock);
-	ret = ms5611_read_temp_and_pressure(indio_dev, &buf[1], &buf[0]);
-	mutex_unlock(&st->lock);
-	if (ret < 0)
-		goto err;
+	mutex_lock(&state->lock);
+	ret = ms5611_read_temp_and_pressure(indio_dev, &state->buf[MS5611_TEMP],
+	                                    &state->buf[MS5611_PRESSURE]);
+	mutex_unlock(&state->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
+	if (!ret)
+		iio_push_to_buffers_with_timestamp(indio_dev, state->buf,
+		                                   iio_get_time_ns());
+}
 
-err:
-	iio_trigger_notify_done(indio_dev->trig);
+static irqreturn_t ms5611_trigger_handler(int irq, void *p)
+{
+	const struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
 
+	ms5611_push_data(indio_dev, iio_priv(indio_dev));
+	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
 }
 
@@ -236,15 +245,24 @@ static int ms5611_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
 {
-	int ret;
+	int ret = 0;
 	s32 temp, pressure;
 	struct ms5611_state *st = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
 		mutex_lock(&st->lock);
-		ret = ms5611_read_temp_and_pressure(indio_dev,
-						    &temp, &pressure);
+		if (iio_buffer_enabled(indio_dev)) {
+			/*
+			 * Return "cached" data since sampling is ongoing in the
+			 * background.
+			 */
+			pressure = st->buf[MS5611_PRESSURE];
+			temp = st->buf[MS5611_TEMP];
+		}
+		else
+			ret = ms5611_read_temp_and_pressure(indio_dev, &temp,
+			                                    &pressure);
 		mutex_unlock(&st->lock);
 		if (ret < 0)
 			return ret;
@@ -384,6 +402,64 @@ static const struct iio_info ms5611_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static int ms5611d(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct ms5611_state *st = iio_priv(indio_dev);
+
+	set_freezable();
+
+	do {
+		ms5611_push_data(indio_dev, st);
+	} while (likely(!kthread_freezable_should_stop(NULL)));
+
+	return 0;
+}
+
+static int ms5611_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ms5611_state *st = iio_priv(indio_dev);
+	int ret;
+
+	/*
+	 * Initialize temperature and pressure so that a client getting samples
+	 * through read_raw retrieves valid data when buffering has just been
+	 * enabled but first sampling round is not yet completed.
+	 */
+	mutex_lock(&st->lock);
+	ret = ms5611_read_temp_and_pressure(indio_dev, &st->buf[MS5611_TEMP],
+	                                    &st->buf[MS5611_PRESSURE]);
+	mutex_unlock(&st->lock);
+	if (ret < 0)
+		return ret;
+
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
+		return iio_triggered_buffer_postenable(indio_dev);
+
+	st->task = kthread_run(ms5611d, indio_dev, indio_dev->name);
+	if (unlikely(IS_ERR(st->task))) {
+		dev_err(&indio_dev->dev, "failed to create buffering task\n");
+		return PTR_ERR(st->task);
+	}
+
+	return 0;
+}
+
+static int ms5611_buffer_predisable(struct iio_dev *indio_dev)
+{
+
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
+		return iio_triggered_buffer_predisable(indio_dev);
+
+	kthread_stop(((struct ms5611_state*) iio_priv(indio_dev))->task);
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ms5611_buffer_ops = {
+	.postenable = ms5611_buffer_postenable,
+	.predisable = ms5611_buffer_predisable,
+};
+
 static int ms5611_init(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -425,7 +501,7 @@ int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
 	indio_dev->info = &ms5611_info;
 	indio_dev->channels = ms5611_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ms5611_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	indio_dev->available_scan_masks = ms5611_scan_masks;
 
 	ret = ms5611_init(indio_dev);
@@ -433,7 +509,8 @@ int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
 		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 ms5611_trigger_handler, NULL);
+	                                 ms5611_trigger_handler,
+	                                 &ms5611_buffer_ops);
 	if (ret < 0) {
 		dev_err(dev, "iio triggered buffer setup failed\n");
 		return ret;
-- 
2.1.4

