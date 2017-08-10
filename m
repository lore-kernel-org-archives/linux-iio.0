Return-Path: <SRS0=acV6=7M=microchip.com=Eugen.Hristev@kernel.org>
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
	<linux-iio@vger.kernel.org>, <jic23@kernel.org>,
	<alexandre.belloni@free-electrons.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lars@metafoo.de>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH 3/3] iio: adc: at91-sama5d2_adc: add support for DMA
Date: Thu, 10 Aug 2017 15:34:59 +0300
Message-ID: <1502368499-6739-4-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1502368499-6739-1-git-send-email-eugen.hristev@microchip.com>
References: <1502368499-6739-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Added support for DMA transfers. The implementation uses the user watermark
to decide whether DMA will be used or not. For watermark 1, DMA will not be
used. If watermark is bigger, DMA will be used.
Sysfs attributes are created to indicate whether the DMA is used,
with hwfifo_enabled, and the current DMA watermark is readable
in hwfifo_watermark. Minimum and maximum values are in hwfifo_watermark_min
and hwfifo_watermark_max.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 366 +++++++++++++++++++++++++++++++++++--
 1 file changed, 350 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index bc5b38e..6a6ca32 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -16,6 +16,8 @@
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -174,6 +176,9 @@
 
 #define AT91_BUFFER_MAX_HWORDS (AT91_BUFFER_MAX_BYTES / 2)
 
+#define AT91_HWFIFO_MAX_SIZE_STR	"128"
+#define AT91_HWFIFO_MAX_SIZE		128
+
 #define AT91_SAMA5D2_CHAN_SINGLE(num, addr)				\
 	{								\
 		.type = IIO_VOLTAGE,					\
@@ -227,6 +232,26 @@ struct at91_adc_trigger {
 	unsigned int			edge_type;
 };
 
+/**
+ * at91_adc_dma - at91-sama5d2 dma information struct
+ * @dma_chan:	the dma channel acquired
+ * @rx_buf:	dma coherent allocated area
+ * @rx_dma_buf:	dma handler for the buffer
+ * @phys_addr:	physical address of the ADC base register
+ * @buf_idx:	index inside the dma buffer where reading was last done
+ * @rx_buf_sz:	size of buffer used by DMA operation
+ * @watermark:	number of conversions to copy before DMA triggers irq
+ */
+struct at91_adc_dma {
+	struct dma_chan			*dma_chan;
+	u8				*rx_buf;
+	dma_addr_t			rx_dma_buf;
+	phys_addr_t			phys_addr;
+	int				buf_idx;
+	int				rx_buf_sz;
+	int				watermark;
+};
+
 struct at91_adc_state {
 	void __iomem			*base;
 	int				irq;
@@ -241,6 +266,7 @@ struct at91_adc_state {
 	u32				conversion_value;
 	struct at91_adc_soc_info	soc_info;
 	wait_queue_head_t		wq_data_available;
+	struct at91_adc_dma		dma_st;
 	u16				buffer[AT91_BUFFER_MAX_HWORDS];
 	/*
 	 * lock to prevent concurrent 'single conversion' requests through
@@ -312,11 +338,17 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 		if (state) {
 			at91_adc_writel(st, AT91_SAMA5D2_CHER,
 					BIT(chan->channel));
-			at91_adc_writel(st, AT91_SAMA5D2_IER,
-					BIT(chan->channel));
+			/* enable irq only if not using DMA */
+			if (!st->dma_st.dma_chan) {
+				at91_adc_writel(st, AT91_SAMA5D2_IER,
+						BIT(chan->channel));
+			}
 		} else {
-			at91_adc_writel(st, AT91_SAMA5D2_IDR,
-					BIT(chan->channel));
+			/* disable irq only if not using DMA */
+			if (!st->dma_st.dma_chan) {
+				at91_adc_writel(st, AT91_SAMA5D2_IDR,
+						BIT(chan->channel));
+			}
 			at91_adc_writel(st, AT91_SAMA5D2_CHDR,
 					BIT(chan->channel));
 		}
@@ -330,6 +362,10 @@ static int at91_adc_reenable_trigger(struct iio_trigger *trig)
 	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
 	struct at91_adc_state *st = iio_priv(indio);
 
+	/* if we are using DMA, we must not reenable irq after each trigger */
+	if (st->dma_st.dma_chan)
+		return 0;
+
 	enable_irq(st->irq);
 
 	/* Needed to ACK the DRDY interruption */
@@ -343,6 +379,115 @@ static const struct iio_trigger_ops at91_adc_trigger_ops = {
 	.try_reenable = &at91_adc_reenable_trigger,
 };
 
+static int at91_adc_dma_size_done(struct at91_adc_state *st)
+{
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(st->dma_st.dma_chan,
+				     st->dma_st.dma_chan->cookie,
+				     &state);
+	if (status == DMA_IN_PROGRESS) {
+		/* Transferred length is size in bytes from end of buffer */
+		int i = st->dma_st.rx_buf_sz - state.residue;
+		int size;
+
+		/* Return available bytes */
+		if (i >= st->dma_st.buf_idx)
+			size = i - st->dma_st.buf_idx;
+		else
+			size = st->dma_st.rx_buf_sz + i - st->dma_st.buf_idx;
+		return size;
+	}
+
+	return 0;
+}
+
+static void at91_dma_buffer_done(void *data)
+{
+	struct iio_dev *indio_dev = data;
+
+	iio_trigger_poll_chained(indio_dev->trig);
+}
+
+static int at91_adc_dma_start(struct iio_dev *indio_dev)
+{
+	struct at91_adc_state *st = iio_priv(indio_dev);
+	struct dma_async_tx_descriptor *desc;
+	dma_cookie_t cookie;
+	int ret;
+
+	if (!st->dma_st.dma_chan)
+		return 0;
+
+	/* we start a new DMA, so set buffer index to start */
+	st->dma_st.buf_idx = 0;
+
+	/* compute buffer size w.r.t. watermark */
+	st->dma_st.rx_buf_sz = st->dma_st.watermark * indio_dev->scan_bytes * 2;
+	/* Prepare a DMA cyclic transaction */
+	desc = dmaengine_prep_dma_cyclic(st->dma_st.dma_chan,
+					 st->dma_st.rx_dma_buf,
+					 st->dma_st.rx_buf_sz,
+					 st->dma_st.rx_buf_sz / 2,
+					 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+
+	if (!desc) {
+		dev_err(&indio_dev->dev, "cannot prepare DMA cyclic\n");
+		return -EBUSY;
+	}
+
+	desc->callback = at91_dma_buffer_done;
+	desc->callback_param = indio_dev;
+
+	cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dev_err(&indio_dev->dev, "cannot submit DMA cyclic\n");
+		dmaengine_terminate_async(st->dma_st.dma_chan);
+		return ret;
+	}
+
+	/* Issue pending DMA requests */
+	dma_async_issue_pending(st->dma_st.dma_chan);
+	dev_dbg(&indio_dev->dev, "DMA cyclic started\n");
+
+	return 0;
+}
+
+static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
+{
+	int ret;
+
+	ret = iio_triggered_buffer_postenable(indio_dev);
+	if (ret) {
+		dev_err(&indio_dev->dev, "buffer postenable failed\n");
+		return ret;
+	}
+
+	return at91_adc_dma_start(indio_dev);
+}
+
+static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct at91_adc_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (st->dma_st.dma_chan)
+		dmaengine_terminate_sync(st->dma_st.dma_chan);
+
+	ret = iio_triggered_buffer_predisable(indio_dev);
+	if (ret < 0)
+		dev_err(&indio_dev->dev, "buffer predisable failed\n");
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops at91_buffer_setup_ops = {
+	.postenable = &at91_adc_buffer_postenable,
+	.predisable = &at91_adc_buffer_predisable,
+};
+
 static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *indio,
 						     char *trigger_name)
 {
@@ -379,24 +524,55 @@ static int at91_adc_trigger_init(struct iio_dev *indio)
 	return 0;
 }
 
-static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
+static inline void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
+						  struct iio_poll_func *pf)
 {
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio = pf->indio_dev;
-	struct at91_adc_state *st = iio_priv(indio);
+	struct at91_adc_state *st = iio_priv(indio_dev);
 	int i = 0;
 	u8 bit;
 
-	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
-		struct iio_chan_spec const *chan = indio->channels + bit;
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->num_channels) {
+		struct iio_chan_spec const *chan = indio_dev->channels + bit;
 
 		st->buffer[i] = at91_adc_readl(st, chan->address);
 		i++;
 	}
+	iio_push_to_buffers_with_timestamp(indio_dev, st->buffer,
+					   pf->timestamp);
+}
 
-	iio_push_to_buffers_with_timestamp(indio, st->buffer, pf->timestamp);
+static inline void at91_adc_trigger_handler_dma(struct iio_dev *indio_dev)
+{
+	struct at91_adc_state *st = iio_priv(indio_dev);
+	int transferred_len = at91_adc_dma_size_done(st);
+	s64 ns = iio_get_time_ns(indio_dev);
+
+	while (transferred_len >= indio_dev->scan_bytes) {
+		iio_push_to_buffers_with_timestamp(indio_dev,
+			      (st->dma_st.rx_buf + st->dma_st.buf_idx), ns);
+		/* adjust remaining length */
+		transferred_len -= indio_dev->scan_bytes;
+		/* adjust buffer index */
+		st->dma_st.buf_idx += indio_dev->scan_bytes;
+		/* in case of reaching end of buffer, reset index */
+		if (st->dma_st.buf_idx >= st->dma_st.rx_buf_sz)
+			st->dma_st.buf_idx = 0;
+	}
+}
 
-	iio_trigger_notify_done(indio->trig);
+static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct at91_adc_state *st = iio_priv(indio_dev);
+
+	if (st->dma_st.dma_chan)
+		at91_adc_trigger_handler_dma(indio_dev);
+	else
+		at91_adc_trigger_handler_nodma(indio_dev, pf);
+
+	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
 }
@@ -405,7 +581,7 @@ static int at91_adc_buffer_init(struct iio_dev *indio)
 {
 	return devm_iio_triggered_buffer_setup(&indio->dev, indio,
 			&iio_pollfunc_store_time,
-			&at91_adc_trigger_handler, NULL);
+			&at91_adc_trigger_handler, &at91_buffer_setup_ops);
 }
 
 static unsigned at91_adc_startup_time(unsigned startup_time_min,
@@ -476,13 +652,16 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
 	if (!(status & imr))
 		return IRQ_NONE;
 
-	if (iio_buffer_enabled(indio)) {
+	if (iio_buffer_enabled(indio) && !st->dma_st.dma_chan) {
 		disable_irq_nosync(irq);
 		iio_trigger_poll(indio->trig);
-	} else {
+	} else if (!iio_buffer_enabled(indio)) {
 		st->conversion_value = at91_adc_readl(st, st->chan->address);
 		st->conversion_done = true;
 		wake_up_interruptible(&st->wq_data_available);
+	} else {
+		disable_irq_nosync(irq);
+		WARN(true, "Unexpected irq occurred\n");
 	}
 	return IRQ_HANDLED;
 }
@@ -571,9 +750,111 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static void at91_adc_dma_init(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct at91_adc_state *st = iio_priv(indio_dev);
+	struct dma_slave_config config = {0};
+	unsigned int pages = DIV_ROUND_UP(AT91_HWFIFO_MAX_SIZE *
+					  AT91_BUFFER_MAX_BYTES * 2, PAGE_SIZE);
+
+	if (st->dma_st.dma_chan)
+		return;
+
+	st->dma_st.dma_chan = dma_request_slave_channel(&pdev->dev, "rx");
+
+	if (!st->dma_st.dma_chan)  {
+		dev_info(&pdev->dev, "can't get DMA channel\n");
+		goto dma_exit;
+	}
+
+	st->dma_st.rx_buf = dma_alloc_coherent(st->dma_st.dma_chan->device->dev,
+					       pages * PAGE_SIZE,
+					       &st->dma_st.rx_dma_buf,
+					       GFP_KERNEL);
+	if (!st->dma_st.rx_buf) {
+		dev_info(&pdev->dev, "can't allocate coherent DMA area\n");
+		goto dma_chan_disable;
+	}
+
+	/* Configure DMA channel to read data register */
+	config.direction = DMA_DEV_TO_MEM;
+	config.src_addr = (phys_addr_t)(st->dma_st.phys_addr
+			  + AT91_SAMA5D2_LCDR);
+	config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	config.src_maxburst = 1;
+	config.dst_maxburst = 1;
+
+	if (dmaengine_slave_config(st->dma_st.dma_chan, &config)) {
+		dev_info(&pdev->dev, "can't configure DMA slave\n");
+		goto dma_free_area;
+	}
+
+	dev_info(&pdev->dev, "using %s for rx DMA transfers\n",
+		 dma_chan_name(st->dma_st.dma_chan));
+
+	return;
+
+dma_free_area:
+	dma_free_coherent(st->dma_st.dma_chan->device->dev, pages * PAGE_SIZE,
+			  st->dma_st.rx_buf, st->dma_st.rx_dma_buf);
+dma_chan_disable:
+	dma_release_channel(st->dma_st.dma_chan);
+	st->dma_st.dma_chan = 0;
+dma_exit:
+	dev_info(&pdev->dev, "continuing without DMA support\n");
+}
+
+static void at91_adc_dma_disable(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct at91_adc_state *st = iio_priv(indio_dev);
+	unsigned int pages = DIV_ROUND_UP(AT91_HWFIFO_MAX_SIZE *
+					  AT91_BUFFER_MAX_BYTES * 2, PAGE_SIZE);
+
+	/* if we are not using DMA, just return */
+	if (!st->dma_st.dma_chan)
+		return;
+
+	/* wait for all transactions to be terminated first*/
+	dmaengine_terminate_sync(st->dma_st.dma_chan);
+
+	dma_free_coherent(st->dma_st.dma_chan->device->dev, pages * PAGE_SIZE,
+			  st->dma_st.rx_buf, st->dma_st.rx_dma_buf);
+	dma_release_channel(st->dma_st.dma_chan);
+	st->dma_st.dma_chan = 0;
+
+	dev_info(&pdev->dev, "continuing without DMA support\n");
+}
+
+static int at91_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
+{
+	struct at91_adc_state *st = iio_priv(indio_dev);
+
+	if (val > AT91_HWFIFO_MAX_SIZE)
+		return -EINVAL;
+
+	dev_dbg(&indio_dev->dev, "new watermark is %u\n", val);
+	st->dma_st.watermark = val;
+
+	/*
+	 * The logic here is: if we have watermark 1, it means we do
+	 * each conversion with it's own IRQ, thus we don't need DMA.
+	 * If the watermark is higher, we do DMA to do all the transfers in bulk
+	 */
+
+	if (val == 1)
+		at91_adc_dma_disable(to_platform_device(&indio_dev->dev));
+	else if (val > 1)
+		at91_adc_dma_init(to_platform_device(&indio_dev->dev));
+
+	return 0;
+}
+
 static const struct iio_info at91_adc_info = {
 	.read_raw = &at91_adc_read_raw,
 	.write_raw = &at91_adc_write_raw,
+	.hwfifo_set_watermark = &at91_adc_set_watermark,
 	.driver_module = THIS_MODULE,
 };
 
@@ -591,6 +872,42 @@ static void at91_adc_hw_init(struct at91_adc_state *st)
 	at91_adc_setup_samp_freq(st, st->soc_info.min_sample_rate);
 }
 
+static ssize_t at91_adc_get_fifo_state(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =
+			platform_get_drvdata(to_platform_device(dev));
+	struct at91_adc_state *st = iio_priv(indio_dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", !!st->dma_st.dma_chan);
+}
+
+static ssize_t at91_adc_get_watermark(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =
+			platform_get_drvdata(to_platform_device(dev));
+	struct at91_adc_state *st = iio_priv(indio_dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", st->dma_st.watermark);
+}
+
+static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
+		       at91_adc_get_fifo_state, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
+		       at91_adc_get_watermark, NULL, 0);
+
+static IIO_CONST_ATTR(hwfifo_watermark_min, "2");
+static IIO_CONST_ATTR(hwfifo_watermark_max, AT91_HWFIFO_MAX_SIZE_STR);
+
+static const struct attribute *at91_adc_fifo_attributes[] = {
+	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
+	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
+	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+	NULL,
+};
+
 static int at91_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -666,6 +983,9 @@ static int at91_adc_probe(struct platform_device *pdev)
 	if (!res)
 		return -EINVAL;
 
+	/* if we plan to use DMA, we need the physical address of the regs */
+	st->dma_st.phys_addr = res->start;
+
 	st->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(st->base))
 		return PTR_ERR(st->base);
@@ -729,18 +1049,30 @@ static int at91_adc_probe(struct platform_device *pdev)
 		goto per_clk_disable_unprepare;
 	}
 
+	if (dma_coerce_mask_and_coherent(&indio_dev->dev, DMA_BIT_MASK(32)))
+		dev_info(&pdev->dev, "cannot set DMA mask to 32-bit\n");
+
+	/* the iio buffer has initially a length of 2 and a watermark of 1 */
+	st->dma_st.watermark = 1;
+
+	iio_buffer_set_attrs(indio_dev->buffer, at91_adc_fifo_attributes);
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto per_clk_disable_unprepare;
+		goto dma_disable;
 
 	dev_info(&pdev->dev, "setting up trigger as %s\n",
 		 st->selected_trig->name);
 
+	dev_info(&pdev->dev, "continuing without DMA support\n");
+
 	dev_info(&pdev->dev, "version: %x\n",
 		 readl_relaxed(st->base + AT91_SAMA5D2_VERSION));
 
 	return 0;
 
+dma_disable:
+	at91_adc_dma_disable(pdev);
 per_clk_disable_unprepare:
 	clk_disable_unprepare(st->per_clk);
 vref_disable:
@@ -757,6 +1089,8 @@ static int at91_adc_remove(struct platform_device *pdev)
 
 	iio_device_unregister(indio_dev);
 
+	at91_adc_dma_disable(pdev);
+
 	clk_disable_unprepare(st->per_clk);
 
 	regulator_disable(st->vref);
-- 
2.7.4
