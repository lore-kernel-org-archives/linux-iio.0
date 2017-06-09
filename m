Return-Path: <SRS0=wzNZ=5O=microchip.com=Eugen.Hristev@kernel.org>
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>,
	<linux-iio@vger.kernel.org>, <lars@metafoo.de>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
	<jic23@kernel.org>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH v4 4/4] iio: adc: at91-sama5d2_adc: add hw trigger and buffer support
Date: Fri, 9 Jun 2017 10:07:19 +0300
Message-ID: <1496992039-17964-5-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1496992039-17964-1-git-send-email-eugen.hristev@microchip.com>
References: <1496992039-17964-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Added support for the external hardware trigger on pin ADTRG,
integrated the three possible edges into the driver
and created buffer management for data retrieval

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
  Changes in v4:
 - Used iio claim direct to make sure buffer is not enabled when someone might
   try to use a software triggered conversion

  Changes in v3:
 - No longer have all three possible triggers registered in the subsystem and
   available in the sysfs. Only registering one trigger, and the possible edge
   is being read from the device tree. In the device tree, any possible edge
   can be set. There are three already made nodes for each possible edge which
   can be selected.
 - Fixed a bug where software triggered conversion could be started even if
   the hardware trigger was enabled.
 - Preallocate enough space for the buffer, considering all the channels
   and timestamp

  Changes in v2:
 - Moved buffer allocation and freeing into the preenable and postdisable
   callbacks.
   We have a total of scan bytes that can vary a lot depending on each channel
   enabled at a certain point.
 - made the at91 trigger list part of state structure
 - made the iio trigger list preallocated in state structure
 - moved irq enabling/disabling into the try_reenable callback
 - on trigger disable must write disable registries as well

 drivers/iio/adc/at91-sama5d2_adc.c | 236 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 231 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index e10dca3..0d1c475 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -25,6 +25,10 @@
 #include <linux/wait.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/regulator/consumer.h>
 
 /* Control Register */
@@ -132,6 +136,17 @@
 #define AT91_SAMA5D2_PRESSR	0xbc
 /* Trigger Register */
 #define AT91_SAMA5D2_TRGR	0xc0
+/* Mask for TRGMOD field of TRGR register */
+#define AT91_SAMA5D2_TRGR_TRGMOD_MASK GENMASK(2, 0)
+/* No trigger, only software trigger can start conversions */
+#define AT91_SAMA5D2_TRGR_TRGMOD_NO_TRIGGER 0
+/* Trigger Mode external trigger rising edge */
+#define AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_RISE 1
+/* Trigger Mode external trigger falling edge */
+#define AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_FALL 2
+/* Trigger Mode external trigger any edge */
+#define AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_ANY 3
+
 /* Correction Select Register */
 #define AT91_SAMA5D2_COSR	0xd0
 /* Correction Value Register */
@@ -145,14 +160,28 @@
 /* Version Register */
 #define AT91_SAMA5D2_VERSION	0xfc
 
+#define AT91_SAMA5D2_HW_TRIG_CNT 3
+#define AT91_SAMA5D2_SINGLE_CHAN_CNT 12
+#define AT91_SAMA5D2_DIFF_CHAN_CNT 6
+
+/* Preferred number of bytes to hold conversion from all channels
+ * plus the timestamp
+ */
+#define AT91_BUFFER_MAX_BYTES ((AT91_SAMA5D2_SINGLE_CHAN_CNT +		\
+				AT91_SAMA5D2_DIFF_CHAN_CNT) * 2 + 8)
+
+#define AT91_BUFFER_MAX_HWORDS (AT91_BUFFER_MAX_BYTES / 2)
+
 #define AT91_SAMA5D2_CHAN_SINGLE(num, addr)				\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.channel = num,						\
 		.address = addr,					\
+		.scan_index = num,					\
 		.scan_type = {						\
 			.sign = 'u',					\
 			.realbits = 12,					\
+			.storagebits = 16,				\
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
@@ -168,9 +197,11 @@
 		.channel = num,						\
 		.channel2 = num2,					\
 		.address = addr,					\
+		.scan_index = num + AT91_SAMA5D2_SINGLE_CHAN_CNT,	\
 		.scan_type = {						\
 			.sign = 's',					\
 			.realbits = 12,					\
+			.storagebits = 16,				\
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
@@ -188,6 +219,12 @@ struct at91_adc_soc_info {
 	unsigned			max_sample_rate;
 };
 
+struct at91_adc_trigger {
+	char				*name;
+	unsigned int			trgmod_value;
+	unsigned int			edge_type;
+};
+
 struct at91_adc_state {
 	void __iomem			*base;
 	int				irq;
@@ -195,11 +232,14 @@ struct at91_adc_state {
 	struct regulator		*reg;
 	struct regulator		*vref;
 	int				vref_uv;
+	struct iio_trigger		*trig;
+	const struct at91_adc_trigger	*selected_trig;
 	const struct iio_chan_spec	*chan;
 	bool				conversion_done;
 	u32				conversion_value;
 	struct at91_adc_soc_info	soc_info;
 	wait_queue_head_t		wq_data_available;
+	u16				buffer[AT91_BUFFER_MAX_HWORDS];
 	/*
 	 * lock to prevent concurrent 'single conversion' requests through
 	 * sysfs.
@@ -207,6 +247,24 @@ struct at91_adc_state {
 	struct mutex			lock;
 };
 
+static const struct at91_adc_trigger at91_adc_trigger_list[] = {
+	{
+		.name = "external_rising",
+		.trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_RISE,
+		.edge_type = IRQ_TYPE_EDGE_RISING,
+	},
+	{
+		.name = "external_falling",
+		.trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_FALL,
+		.edge_type = IRQ_TYPE_EDGE_FALLING,
+	},
+	{
+		.name = "external_any",
+		.trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_ANY,
+		.edge_type = IRQ_TYPE_EDGE_BOTH,
+	},
+};
+
 static const struct iio_chan_spec at91_adc_channels[] = {
 	AT91_SAMA5D2_CHAN_SINGLE(0, 0x50),
 	AT91_SAMA5D2_CHAN_SINGLE(1, 0x54),
@@ -226,8 +284,128 @@ static const struct iio_chan_spec at91_adc_channels[] = {
 	AT91_SAMA5D2_CHAN_DIFF(6, 7, 0x68),
 	AT91_SAMA5D2_CHAN_DIFF(8, 9, 0x70),
 	AT91_SAMA5D2_CHAN_DIFF(10, 11, 0x78),
+	IIO_CHAN_SOFT_TIMESTAMP(AT91_SAMA5D2_SINGLE_CHAN_CNT
+				+ AT91_SAMA5D2_DIFF_CHAN_CNT + 1),
+};
+
+static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
+	struct at91_adc_state *st = iio_priv(indio);
+	u32 status = at91_adc_readl(st, AT91_SAMA5D2_TRGR);
+	u8 bit;
+
+	/* clear TRGMOD */
+	status &= ~AT91_SAMA5D2_TRGR_TRGMOD_MASK;
+
+	if (state)
+		status |= st->selected_trig->trgmod_value;
+
+	/* set/unset hw trigger */
+	at91_adc_writel(st, AT91_SAMA5D2_TRGR, status);
+
+	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
+		struct iio_chan_spec const *chan = indio->channels + bit;
+
+		if (state) {
+			at91_adc_writel(st, AT91_SAMA5D2_CHER,
+					BIT(chan->channel));
+			at91_adc_writel(st, AT91_SAMA5D2_IER,
+					BIT(chan->channel));
+		} else {
+			at91_adc_writel(st, AT91_SAMA5D2_IDR,
+					BIT(chan->channel));
+			at91_adc_writel(st, AT91_SAMA5D2_CHDR,
+					BIT(chan->channel));
+		}
+	}
+
+	return 0;
+}
+
+static int at91_adc_reenable_trigger(struct iio_trigger *trig)
+{
+	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
+	struct at91_adc_state *st = iio_priv(indio);
+
+	enable_irq(st->irq);
+	return 0;
+}
+
+static const struct iio_trigger_ops at91_adc_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &at91_adc_configure_trigger,
+	.try_reenable = &at91_adc_reenable_trigger,
 };
 
+static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *indio,
+						     char *trigger_name)
+{
+	struct iio_trigger *trig;
+	int ret;
+
+	trig = devm_iio_trigger_alloc(&indio->dev, "%s-dev%d-%s", indio->name,
+				      indio->id, trigger_name);
+	if (!trig)
+		return NULL;
+
+	trig->dev.parent = indio->dev.parent;
+	iio_trigger_set_drvdata(trig, indio);
+	trig->ops = &at91_adc_trigger_ops;
+
+	ret = devm_iio_trigger_register(&indio->dev, trig);
+	if (ret)
+		return NULL;
+
+	return trig;
+}
+
+static int at91_adc_trigger_init(struct iio_dev *indio)
+{
+	struct at91_adc_state *st = iio_priv(indio);
+
+	st->trig = at91_adc_allocate_trigger(indio, st->selected_trig->name);
+	if (!st->trig) {
+		dev_err(&indio->dev,
+			"could not allocate trigger\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio = pf->indio_dev;
+	struct at91_adc_state *st = iio_priv(indio);
+	int i = 0;
+	u8 bit;
+
+	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
+		struct iio_chan_spec const *chan = indio->channels + bit;
+
+		st->buffer[i] = at91_adc_readl(st, chan->address);
+		i++;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio, st->buffer, pf->timestamp);
+
+	iio_trigger_notify_done(indio->trig);
+
+	/* Needed to ACK the DRDY interruption */
+	at91_adc_readl(st, AT91_SAMA5D2_LCDR);
+
+	return IRQ_HANDLED;
+}
+
+static int at91_adc_buffer_init(struct iio_dev *indio)
+{
+	return devm_iio_triggered_buffer_setup(&indio->dev, indio,
+			&iio_pollfunc_store_time,
+			&at91_adc_trigger_handler, NULL);
+}
+
 static unsigned at91_adc_startup_time(unsigned startup_time_min,
 				      unsigned adc_clk_khz)
 {
@@ -293,14 +471,18 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
 	u32 status = at91_adc_readl(st, AT91_SAMA5D2_ISR);
 	u32 imr = at91_adc_readl(st, AT91_SAMA5D2_IMR);
 
-	if (status & imr) {
+	if (!(status & imr))
+		return IRQ_NONE;
+
+	if (iio_buffer_enabled(indio)) {
+		disable_irq_nosync(irq);
+		iio_trigger_poll(indio->trig);
+	} else {
 		st->conversion_value = at91_adc_readl(st, st->chan->address);
 		st->conversion_done = true;
 		wake_up_interruptible(&st->wq_data_available);
-		return IRQ_HANDLED;
 	}
-
-	return IRQ_NONE;
+	return IRQ_HANDLED;
 }
 
 static int at91_adc_read_raw(struct iio_dev *indio_dev,
@@ -313,6 +495,11 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		/* we cannot use software trigger if hw trigger enabled */
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
 		mutex_lock(&st->lock);
 
 		st->chan = chan;
@@ -344,6 +531,8 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 		at91_adc_writel(st, AT91_SAMA5D2_CHDR, BIT(chan->channel));
 
 		mutex_unlock(&st->lock);
+
+		iio_device_release_direct_mode(indio_dev);
 		return ret;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -391,7 +580,8 @@ static int at91_adc_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct at91_adc_state *st;
 	struct resource	*res;
-	int ret;
+	int ret, i;
+	u32 edge_type;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
 	if (!indio_dev)
@@ -432,6 +622,27 @@ static int at91_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = of_property_read_u32(pdev->dev.of_node,
+				   "atmel,trigger-edge-type", &edge_type);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"invalid or missing value for atmel,trigger-edge-type\n");
+		return ret;
+	}
+
+	st->selected_trig = NULL;
+
+	for (i = 0; i < AT91_SAMA5D2_HW_TRIG_CNT; i++)
+		if (at91_adc_trigger_list[i].edge_type == edge_type) {
+			st->selected_trig = &at91_adc_trigger_list[i];
+			break;
+		}
+
+	if (!st->selected_trig) {
+		dev_err(&pdev->dev, "invalid external trigger edge value\n");
+		return -EINVAL;
+	}
+
 	init_waitqueue_head(&st->wq_data_available);
 	mutex_init(&st->lock);
 
@@ -499,10 +710,25 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
+	ret = at91_adc_buffer_init(indio_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "couldn't initialize the buffer.\n");
+		goto per_clk_disable_unprepare;
+	}
+
+	ret = at91_adc_trigger_init(indio_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "couldn't setup the triggers.\n");
+		goto per_clk_disable_unprepare;
+	}
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
 		goto per_clk_disable_unprepare;
 
+	dev_info(&pdev->dev, "setting up trigger as %s\n",
+		 st->selected_trig->name);
+
 	dev_info(&pdev->dev, "version: %x\n",
 		 readl_relaxed(st->base + AT91_SAMA5D2_VERSION));
 
-- 
2.7.4
