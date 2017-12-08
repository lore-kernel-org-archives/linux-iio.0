Return-Path: <SRS0=djI4=DE=st.com=arnaud.pouliquen@kernel.org>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, <arnaud.pouliquen@st.com>
Subject: [PATCH v7 10/13] IIO: ADC: add stm32 DFSDM support for PDM microphone
Date: Fri, 8 Dec 2017 15:49:23 +0100
Message-ID: <1512744566-13233-11-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1512744566-13233-1-git-send-email-arnaud.pouliquen@st.com>
References: <1512744566-13233-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This code offers a way to handle PDM audio microphones in
ASOC framework. Audio driver should use consumer API.
A specific management is implemented for DMA, with a
callback, to allows to handle audio buffers efficiently.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
V6 to V7 updates:
- SPDX-Licensing.
- Minor typo fixes.

 .../ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32      |  16 +
 drivers/iio/adc/stm32-dfsdm-adc.c                  | 508 ++++++++++++++++++++-
 include/linux/iio/adc/stm32-dfsdm-adc.h            |  18 +
 3 files changed, 534 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
 create mode 100644 include/linux/iio/adc/stm32-dfsdm-adc.h

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
new file mode 100644
index 0000000..da98223
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
@@ -0,0 +1,16 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_spi_clk_freq
+KernelVersion:	4.14
+Contact:	arnaud.pouliquen@st.com
+Description:
+		For audio purpose only.
+		Used by audio driver to set/get the spi input frequency.
+		This is mandatory if DFSDM is slave on SPI bus, to
+		provide information on the SPI clock frequency during runtime
+		Notice that the SPI frequency should be a multiple of sample
+		frequency to ensure the precision.
+		if DFSDM input is SPI master
+			Reading  SPI clkout frequency,
+			error on writing
+		If DFSDM input is SPI Slave:
+			Reading returns value previously set.
+			Writing value before starting conversions.
\ No newline at end of file
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 68b5920..2d6aed5 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -6,19 +6,25 @@
  * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>.
  */
 
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/hw-consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
 #include "stm32-dfsdm.h"
 
+#define DFSDM_DMA_BUFFER_SIZE (4 * PAGE_SIZE)
+
 /* Conversion timeout */
 #define DFSDM_TIMEOUT_US 100000
 #define DFSDM_TIMEOUT (msecs_to_jiffies(DFSDM_TIMEOUT_US / 1000))
@@ -58,6 +64,18 @@ struct stm32_dfsdm_adc {
 	struct completion completion;
 	u32 *buffer;
 
+	/* Audio specific */
+	unsigned int spi_freq;  /* SPI bus clock frequency */
+	unsigned int sample_freq; /* Sample frequency after filter decimation */
+	int (*cb)(const void *data, size_t size, void *cb_priv);
+	void *cb_priv;
+
+	/* DMA */
+	u8 *rx_buf;
+	unsigned int bufi; /* Buffer current position */
+	unsigned int buf_sz; /* Buffer size */
+	struct dma_chan	*dma_chan;
+	dma_addr_t dma_buf;
 };
 
 struct stm32_dfsdm_str2field {
@@ -351,10 +369,63 @@ int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
 	return 0;
 }
 
+static ssize_t dfsdm_adc_audio_get_spiclk(struct iio_dev *indio_dev,
+					  uintptr_t priv,
+					  const struct iio_chan_spec *chan,
+					  char *buf)
+{
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", adc->spi_freq);
+}
+
+static ssize_t dfsdm_adc_audio_set_spiclk(struct iio_dev *indio_dev,
+					  uintptr_t priv,
+					  const struct iio_chan_spec *chan,
+					  const char *buf, size_t len)
+{
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
+	struct stm32_dfsdm_channel *ch = &adc->dfsdm->ch_list[adc->ch_id];
+	unsigned int sample_freq = adc->sample_freq;
+	unsigned int spi_freq;
+	int ret;
+
+	dev_err(&indio_dev->dev, "enter %s\n", __func__);
+	/* If DFSDM is master on SPI, SPI freq can not be updated */
+	if (ch->src != DFSDM_CHANNEL_SPI_CLOCK_EXTERNAL)
+		return -EPERM;
+
+	ret = kstrtoint(buf, 0, &spi_freq);
+	if (ret)
+		return ret;
+
+	if (!spi_freq)
+		return -EINVAL;
+
+	if (sample_freq) {
+		if (spi_freq % sample_freq)
+			dev_warn(&indio_dev->dev,
+				 "Sampling rate not accurate (%d)\n",
+				 spi_freq / (spi_freq / sample_freq));
+
+		ret = stm32_dfsdm_set_osrs(fl, 0, (spi_freq / sample_freq));
+		if (ret < 0) {
+			dev_err(&indio_dev->dev,
+				"No filter parameters that match!\n");
+			return ret;
+		}
+	}
+	adc->spi_freq = spi_freq;
+
+	return len;
+}
+
 static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc, bool dma)
 {
 	struct regmap *regmap = adc->dfsdm->regmap;
 	int ret;
+	unsigned int dma_en = 0, cont_en = 0;
 
 	ret = stm32_dfsdm_start_channel(adc->dfsdm, adc->ch_id);
 	if (ret < 0)
@@ -365,6 +436,24 @@ static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc, bool dma)
 	if (ret < 0)
 		goto stop_channels;
 
+	if (dma) {
+		/* Enable DMA transfer*/
+		dma_en =  DFSDM_CR1_RDMAEN(1);
+		/* Enable conversion triggered by SPI clock*/
+		cont_en = DFSDM_CR1_RCONT(1);
+	}
+	/* Enable DMA transfer*/
+	ret = regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
+				 DFSDM_CR1_RDMAEN_MASK, dma_en);
+	if (ret < 0)
+		goto stop_channels;
+
+	/* Enable conversion triggered by SPI clock*/
+	ret = regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
+				 DFSDM_CR1_RCONT_MASK, cont_en);
+	if (ret < 0)
+		goto stop_channels;
+
 	ret = stm32_dfsdm_start_filter(adc->dfsdm, adc->fl_id);
 	if (ret < 0)
 		goto stop_channels;
@@ -398,6 +487,231 @@ static void stm32_dfsdm_stop_conv(struct stm32_dfsdm_adc *adc)
 	stm32_dfsdm_stop_channel(adc->dfsdm, adc->ch_id);
 }
 
+static int stm32_dfsdm_set_watermark(struct iio_dev *indio_dev,
+				     unsigned int val)
+{
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	unsigned int watermark = DFSDM_DMA_BUFFER_SIZE / 2;
+
+	/*
+	 * DMA cyclic transfers are used, buffer is split into two periods.
+	 * There should be :
+	 * - always one buffer (period) DMA is working on
+	 * - one buffer (period) driver pushed to ASoC side.
+	 */
+	watermark = min(watermark, val * (unsigned int)(sizeof(u32)));
+	adc->buf_sz = watermark * 2;
+
+	return 0;
+}
+
+static unsigned int stm32_dfsdm_adc_dma_residue(struct stm32_dfsdm_adc *adc)
+{
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(adc->dma_chan,
+				     adc->dma_chan->cookie,
+				     &state);
+	if (status == DMA_IN_PROGRESS) {
+		/* Residue is size in bytes from end of buffer */
+		unsigned int i = adc->buf_sz - state.residue;
+		unsigned int size;
+
+		/* Return available bytes */
+		if (i >= adc->bufi)
+			size = i - adc->bufi;
+		else
+			size = adc->buf_sz + i - adc->bufi;
+
+		return size;
+	}
+
+	return 0;
+}
+
+static void stm32_dfsdm_audio_dma_buffer_done(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	int available = stm32_dfsdm_adc_dma_residue(adc);
+	size_t old_pos;
+
+	/*
+	 * FIXME: In Kernel interface does not support cyclic DMA buffer,and
+	 * offers only an interface to push data samples per samples.
+	 * For this reason IIO buffer interface is not used and interface is
+	 * bypassed using a private callback registered by ASoC.
+	 * This should be a temporary solution waiting a cyclic DMA engine
+	 * support in IIO.
+	 */
+
+	dev_dbg(&indio_dev->dev, "%s: pos = %d, available = %d\n", __func__,
+		adc->bufi, available);
+	old_pos = adc->bufi;
+
+	while (available >= indio_dev->scan_bytes) {
+		u32 *buffer = (u32 *)&adc->rx_buf[adc->bufi];
+
+		/* Mask 8 LSB that contains the channel ID */
+		*buffer = (*buffer & 0xFFFFFF00) << 8;
+		available -= indio_dev->scan_bytes;
+		adc->bufi += indio_dev->scan_bytes;
+		if (adc->bufi >= adc->buf_sz) {
+			if (adc->cb)
+				adc->cb(&adc->rx_buf[old_pos],
+					 adc->buf_sz - old_pos, adc->cb_priv);
+			adc->bufi = 0;
+			old_pos = 0;
+		}
+	}
+	if (adc->cb)
+		adc->cb(&adc->rx_buf[old_pos], adc->bufi - old_pos,
+			adc->cb_priv);
+}
+
+static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
+{
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	struct dma_async_tx_descriptor *desc;
+	dma_cookie_t cookie;
+	int ret;
+
+	if (!adc->dma_chan)
+		return -EINVAL;
+
+	dev_dbg(&indio_dev->dev, "%s size=%d watermark=%d\n", __func__,
+		adc->buf_sz, adc->buf_sz / 2);
+
+	/* Prepare a DMA cyclic transaction */
+	desc = dmaengine_prep_dma_cyclic(adc->dma_chan,
+					 adc->dma_buf,
+					 adc->buf_sz, adc->buf_sz / 2,
+					 DMA_DEV_TO_MEM,
+					 DMA_PREP_INTERRUPT);
+	if (!desc)
+		return -EBUSY;
+
+	desc->callback = stm32_dfsdm_audio_dma_buffer_done;
+	desc->callback_param = indio_dev;
+
+	cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dmaengine_terminate_all(adc->dma_chan);
+		return ret;
+	}
+
+	/* Issue pending DMA requests */
+	dma_async_issue_pending(adc->dma_chan);
+
+	return 0;
+}
+
+static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
+{
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	/* Reset adc buffer index */
+	adc->bufi = 0;
+
+	ret = stm32_dfsdm_start_dfsdm(adc->dfsdm);
+	if (ret < 0)
+		return ret;
+
+	ret = stm32_dfsdm_start_conv(adc, true);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Can't start conversion\n");
+		goto stop_dfsdm;
+	}
+
+	if (adc->dma_chan) {
+		ret = stm32_dfsdm_adc_dma_start(indio_dev);
+		if (ret) {
+			dev_err(&indio_dev->dev, "Can't start DMA\n");
+			goto err_stop_conv;
+		}
+	}
+
+	return 0;
+
+err_stop_conv:
+	stm32_dfsdm_stop_conv(adc);
+stop_dfsdm:
+	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
+
+	return ret;
+}
+
+static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
+{
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+
+	if (adc->dma_chan)
+		dmaengine_terminate_all(adc->dma_chan);
+
+	stm32_dfsdm_stop_conv(adc);
+
+	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops stm32_dfsdm_buffer_setup_ops = {
+	.postenable = &stm32_dfsdm_postenable,
+	.predisable = &stm32_dfsdm_predisable,
+};
+
+/**
+ * stm32_dfsdm_get_buff_cb() - register a callback that will be called when
+ *                             DMA transfer period is achieved.
+ *
+ * @iio_dev: Handle to IIO device.
+ * @cb: Pointer to callback function:
+ *      - data: pointer to data buffer
+ *      - size: size in byte of the data buffer
+ *      - private: pointer to consumer private structure.
+ * @private: Pointer to consumer private structure.
+ */
+int stm32_dfsdm_get_buff_cb(struct iio_dev *iio_dev,
+			    int (*cb)(const void *data, size_t size,
+				      void *private),
+			    void *private)
+{
+	struct stm32_dfsdm_adc *adc;
+
+	if (!iio_dev)
+		return -EINVAL;
+	adc = iio_priv(iio_dev);
+
+	adc->cb = cb;
+	adc->cb_priv = private;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stm32_dfsdm_get_buff_cb);
+
+/**
+ * stm32_dfsdm_release_buff_cb - unregister buffer callback
+ *
+ * @iio_dev: Handle to IIO device.
+ */
+int stm32_dfsdm_release_buff_cb(struct iio_dev *iio_dev)
+{
+	struct stm32_dfsdm_adc *adc;
+
+	if (!iio_dev)
+		return -EINVAL;
+	adc = iio_priv(iio_dev);
+
+	adc->cb = NULL;
+	adc->cb_priv = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stm32_dfsdm_release_buff_cb);
+
 static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 				   const struct iio_chan_spec *chan, int *res)
 {
@@ -453,15 +767,41 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
+	struct stm32_dfsdm_channel *ch = &adc->dfsdm->ch_list[adc->ch_id];
+	unsigned int spi_freq = adc->spi_freq;
 	int ret = -EINVAL;
 
-	if (mask == IIO_CHAN_INFO_OVERSAMPLING_RATIO) {
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		ret = stm32_dfsdm_set_osrs(fl, 0, val);
 		if (!ret)
 			adc->oversamp = val;
+
+		return ret;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (!val)
+			return -EINVAL;
+		if (ch->src != DFSDM_CHANNEL_SPI_CLOCK_EXTERNAL)
+			spi_freq = adc->dfsdm->spi_master_freq;
+
+		if (spi_freq % val)
+			dev_warn(&indio_dev->dev,
+				 "Sampling rate not accurate (%d)\n",
+				 spi_freq / (spi_freq / val));
+
+		ret = stm32_dfsdm_set_osrs(fl, 0, (spi_freq / val));
+		if (ret < 0) {
+			dev_err(&indio_dev->dev,
+				"Not able to find parameter that match!\n");
+			return ret;
+		}
+		adc->sample_freq = val;
+
+		return 0;
 	}
 
-	return ret;
+	return -EINVAL;
 }
 
 static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
@@ -494,11 +834,22 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 		*val = adc->oversamp;
 
 		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = adc->sample_freq;
+
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
 }
 
+static const struct iio_info stm32_dfsdm_info_audio = {
+	.hwfifo_set_watermark = stm32_dfsdm_set_watermark,
+	.read_raw = stm32_dfsdm_read_raw,
+	.write_raw = stm32_dfsdm_write_raw,
+};
+
 static const struct iio_info stm32_dfsdm_info_adc = {
 	.read_raw = stm32_dfsdm_read_raw,
 	.write_raw = stm32_dfsdm_write_raw,
@@ -531,6 +882,60 @@ static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+/*
+ * Define external info for SPI Frequency and audio sampling rate that can be
+ * configured by ASoC driver through consumer.h API
+ */
+static const struct iio_chan_spec_ext_info dfsdm_adc_audio_ext_info[] = {
+	/* spi_clk_freq : clock freq on SPI/manchester bus used by channel */
+	{
+		.name = "spi_clk_freq",
+		.shared = IIO_SHARED_BY_TYPE,
+		.read = dfsdm_adc_audio_get_spiclk,
+		.write = dfsdm_adc_audio_set_spiclk,
+	},
+	{},
+};
+
+static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
+{
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	struct dma_slave_config config;
+	int ret;
+
+	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
+	if (!adc->dma_chan)
+		return -EINVAL;
+
+	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
+					 DFSDM_DMA_BUFFER_SIZE,
+					 &adc->dma_buf, GFP_KERNEL);
+	if (!adc->rx_buf) {
+		ret = -ENOMEM;
+		goto err_release;
+	}
+
+	/* Configure DMA channel to read data register */
+	memset(&config, 0, sizeof(config));
+	config.src_addr = (dma_addr_t)adc->dfsdm->phys_base;
+	config.src_addr += DFSDM_RDATAR(adc->fl_id);
+	config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	ret = dmaengine_slave_config(adc->dma_chan, &config);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	dma_free_coherent(adc->dma_chan->device->dev, DFSDM_DMA_BUFFER_SIZE,
+			  adc->rx_buf, adc->dma_buf);
+err_release:
+	dma_release_channel(adc->dma_chan);
+
+	return ret;
+}
+
 static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
 					 struct iio_chan_spec *ch)
 {
@@ -551,7 +956,12 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
 	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
 	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
 
-	ch->scan_type.sign = 'u';
+	if (adc->dev_data->type == DFSDM_AUDIO) {
+		ch->scan_type.sign = 's';
+		ch->ext_info = dfsdm_adc_audio_ext_info;
+	} else {
+		ch->scan_type.sign = 'u';
+	}
 	ch->scan_type.realbits = 24;
 	ch->scan_type.storagebits = 32;
 	adc->ch_id = ch->channel;
@@ -560,6 +970,64 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
 					  &adc->dfsdm->ch_list[ch->channel]);
 }
 
+static int stm32_dfsdm_audio_init(struct iio_dev *indio_dev)
+{
+	struct iio_chan_spec *ch;
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	struct stm32_dfsdm_channel *d_ch;
+	int ret;
+
+	ret = stm32_dfsdm_dma_request(indio_dev);
+	if (ret) {
+		dev_err(&indio_dev->dev, "DMA request failed\n");
+		return ret;
+	}
+
+	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
+
+	ret = iio_triggered_buffer_setup(indio_dev,
+					 &iio_pollfunc_store_time,
+					 NULL,
+					 &stm32_dfsdm_buffer_setup_ops);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Buffer setup failed\n");
+		goto err_dma_disable;
+	}
+
+	ch = devm_kzalloc(&indio_dev->dev, sizeof(*ch), GFP_KERNEL);
+	if (!ch)
+		return -ENOMEM;
+
+	ch->scan_index = 0;
+	ret = stm32_dfsdm_adc_chan_init_one(indio_dev, ch);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "channels init failed\n");
+		goto err_buffer_cleanup;
+	}
+	ch->info_mask_separate = BIT(IIO_CHAN_INFO_SAMP_FREQ);
+
+	d_ch = &adc->dfsdm->ch_list[adc->ch_id];
+	if (d_ch->src != DFSDM_CHANNEL_SPI_CLOCK_EXTERNAL)
+		adc->spi_freq = adc->dfsdm->spi_master_freq;
+
+	indio_dev->num_channels = 1;
+	indio_dev->channels = ch;
+
+	return 0;
+
+err_buffer_cleanup:
+	iio_triggered_buffer_cleanup(indio_dev);
+
+err_dma_disable:
+	if (adc->dma_chan) {
+		dma_free_coherent(adc->dma_chan->device->dev,
+				  DFSDM_DMA_BUFFER_SIZE,
+				  adc->rx_buf, adc->dma_buf);
+		dma_release_channel(adc->dma_chan);
+	}
+	return ret;
+}
+
 static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
 {
 	struct iio_chan_spec *ch;
@@ -612,11 +1080,20 @@ static const struct stm32_dfsdm_dev_data stm32h7_dfsdm_adc_data = {
 	.init = stm32_dfsdm_adc_init,
 };
 
+static const struct stm32_dfsdm_dev_data stm32h7_dfsdm_audio_data = {
+	.type = DFSDM_AUDIO,
+	.init = stm32_dfsdm_audio_init,
+};
+
 static const struct of_device_id stm32_dfsdm_adc_match[] = {
 	{
 		.compatible = "st,stm32-dfsdm-adc",
 		.data = &stm32h7_dfsdm_adc_data,
 	},
+	{
+		.compatible = "st,stm32-dfsdm-dmic",
+		.data = &stm32h7_dfsdm_audio_data,
+	},
 	{}
 };
 
@@ -667,8 +1144,13 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	name = devm_kzalloc(dev, sizeof("dfsdm-adc0"), GFP_KERNEL);
 	if (!name)
 		return -ENOMEM;
-	iio->info = &stm32_dfsdm_info_adc;
-	snprintf(name, sizeof("dfsdm-adc0"), "dfsdm-adc%d", adc->fl_id);
+	if (dev_data->type == DFSDM_AUDIO) {
+		iio->info = &stm32_dfsdm_info_audio;
+		snprintf(name, sizeof("dfsdm-pdm0"), "dfsdm-pdm%d", adc->fl_id);
+	} else {
+		iio->info = &stm32_dfsdm_info_adc;
+		snprintf(name, sizeof("dfsdm-adc0"), "dfsdm-adc%d", adc->fl_id);
+	}
 	iio->name = name;
 
 	/*
@@ -700,7 +1182,10 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	return iio_device_register(iio);
+	iio_device_register(iio);
+	if (dev_data->type == DFSDM_AUDIO)
+		return devm_of_platform_populate(&pdev->dev);
+	return 0;
 }
 
 static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
@@ -709,7 +1194,14 @@ static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
 
 	iio_device_unregister(indio_dev);
-
+	if (indio_dev->pollfunc)
+		iio_triggered_buffer_cleanup(indio_dev);
+	if (adc->dma_chan) {
+		dma_free_coherent(adc->dma_chan->device->dev,
+				  DFSDM_DMA_BUFFER_SIZE,
+				  adc->rx_buf, adc->dma_buf);
+		dma_release_channel(adc->dma_chan);
+	}
 	return 0;
 }
 
diff --git a/include/linux/iio/adc/stm32-dfsdm-adc.h b/include/linux/iio/adc/stm32-dfsdm-adc.h
new file mode 100644
index 0000000..e7dc7a5
--- /dev/null
+++ b/include/linux/iio/adc/stm32-dfsdm-adc.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This file discribe the STM32 DFSDM IIO driver API for audio part
+ *
+ * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+ * Author(s): Arnaud Pouliquen <arnaud.pouliquen@st.com>.
+ */
+
+#ifndef STM32_DFSDM_ADC_H
+#define STM32_DFSDM_ADC_H
+
+int stm32_dfsdm_get_buff_cb(struct iio_dev *iio_dev,
+			    int (*cb)(const void *data, size_t size,
+				      void *private),
+			    void *private);
+int stm32_dfsdm_release_buff_cb(struct iio_dev *iio_dev);
+
+#endif
-- 
2.7.4
