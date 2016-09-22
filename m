Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2] iio:adc: Add support for AD7766/AD7767
Date: Thu, 22 Sep 2016 13:48:21 +0200
Message-Id: <1474544901-14712-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Add support for the AD7766, AD7766-1, AD7766-2, AD7767, AD7767-1, AD7767-2
Analog to Digital converters. It's a family of single channel 24-bit SAR
ADCs. They are all digital interface compatible and the main difference is
the internal decimation rate and analog performance. For communication with
the host processor a SPI interface is used.

In addition the part has a data ready pin that is pulsed for one MCLK cycle
when a conversion has completed and can be used as a IIO trigger.

Datasheets:
	http://www.analog.com/media/en/technical-documentation/data-sheets/AD7766.pdf
	http://www.analog.com/media/en/technical-documentation/data-sheets/AD7767.pdf

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Changes since v1: (Thanks to Peter Meerwald-Stadler for the review)
	* Whitespace cleanup
	* Introduce symbolic constants for regulator indices
	* Document in the driver that AD7766 and AD7767 are fully register map
	  compatible and only differ in analog performance
---
 drivers/iio/adc/Kconfig  |  10 ++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7766.c | 353 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 364 insertions(+)
 create mode 100644 drivers/iio/adc/ad7766.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7edcf32..8d1ce02 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -58,6 +58,16 @@ config AD7476
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7476.
 
+config AD7766
+	tristate "Analog Devices AD7766/AD7767 ADC driver"
+	depends on SPI_MASTER
+	help
+	  Say yes here to build support for Analog Devices AD7766, AD7766-1,
+	  AD7766-2, AD7767, AD7767-1, AD7767-2 SPI analog to digital converters.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7766.
+
 config AD7791
 	tristate "Analog Devices AD7791 ADC driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 7a40c04..96894b3 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7298) += ad7298.o
 obj-$(CONFIG_AD7923) += ad7923.o
 obj-$(CONFIG_AD7476) += ad7476.o
+obj-$(CONFIG_AD7766) += ad7766.o
 obj-$(CONFIG_AD7791) += ad7791.o
 obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7887) += ad7887.o
diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
new file mode 100644
index 0000000..9e7cafb
--- /dev/null
+++ b/drivers/iio/adc/ad7766.c
@@ -0,0 +1,353 @@
+/*
+ * AD7766/AD7767 SPI ADC driver
+ *
+ * Copyright 2016 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+struct ad7766_chip_info {
+	unsigned int decimation_factor;
+};
+
+enum {
+	AD7766_SUPPLY_AVDD = 0,
+	AD7766_SUPPLY_DVDD = 1,
+	AD7766_SUPPLY_VREF = 2,
+	AD7766_NUM_SUPPLIES = 3
+};
+
+struct ad7766 {
+	const struct ad7766_chip_info *chip_info;
+	struct spi_device *spi;
+	struct clk *mclk;
+	struct gpio_desc *pd_gpio;
+	struct regulator_bulk_data reg[AD7766_NUM_SUPPLIES];
+
+	struct iio_trigger *trig;
+
+	struct spi_transfer xfer;
+	struct spi_message msg;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 * Make the buffer large enough for one 24 bit sample and one 64 bit
+	 * aligned 64 bit timestamp.
+	 */
+	unsigned char data[ALIGN(3, sizeof(s64)) + sizeof(s64)]
+			____cacheline_aligned;
+};
+
+/*
+ * AD7766 and AD7767 variations are interface compatible, the main difference is
+ * analog performance. Both parts will use the same ID.
+ */
+enum ad7766_device_ids {
+	ID_AD7766,
+	ID_AD7766_1,
+	ID_AD7766_2,
+};
+
+static irqreturn_t ad7766_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad7766 *ad7766 = iio_priv(indio_dev);
+	int ret;
+
+	ret = spi_sync(ad7766->spi, &ad7766->msg);
+	if (ret < 0)
+		goto done;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, ad7766->data,
+		pf->timestamp);
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int ad7766_preenable(struct iio_dev *indio_dev)
+{
+	struct ad7766 *ad7766 = iio_priv(indio_dev);
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ad7766->reg), ad7766->reg);
+	if (ret < 0) {
+		dev_err(&ad7766->spi->dev, "Failed to enable supplies: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(ad7766->mclk);
+	if (ret < 0) {
+		dev_err(&ad7766->spi->dev, "Failed to enable MCLK: %d\n", ret);
+		regulator_bulk_disable(ARRAY_SIZE(ad7766->reg), ad7766->reg);
+		return ret;
+	}
+
+	if (ad7766->pd_gpio)
+		gpiod_set_value(ad7766->pd_gpio, 0);
+
+	return 0;
+}
+
+static int ad7766_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad7766 *ad7766 = iio_priv(indio_dev);
+
+	if (ad7766->pd_gpio)
+		gpiod_set_value(ad7766->pd_gpio, 1);
+
+	/*
+	 * The PD pin is synchronous to the clock, so give it some time to
+	 * notice the change before we disable the clock.
+	 */
+	msleep(20);
+
+	clk_disable_unprepare(ad7766->mclk);
+	regulator_bulk_disable(ARRAY_SIZE(ad7766->reg), ad7766->reg);
+
+	return 0;
+}
+
+static int ad7766_read_raw(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, int *val, int *val2, long info)
+{
+	struct ad7766 *ad7766 = iio_priv(indio_dev);
+	struct regulator *vref = ad7766->reg[AD7766_SUPPLY_VREF].consumer;
+	int scale_uv;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		scale_uv = regulator_get_voltage(vref);
+		if (scale_uv < 0)
+			return scale_uv;
+		*val = scale_uv / 1000;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = clk_get_rate(ad7766->mclk) /
+			ad7766->chip_info->decimation_factor;
+		return IIO_VAL_INT;
+	}
+	return -EINVAL;
+}
+
+static const struct iio_chan_spec ad7766_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.scan_type = {
+			.sign = 's',
+			.realbits = 24,
+			.storagebits = 32,
+			.endianness = IIO_BE,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7766_chip_info ad7766_chip_info[] = {
+	[ID_AD7766] = {
+		.decimation_factor = 8,
+	},
+	[ID_AD7766_1] = {
+		.decimation_factor = 16,
+	},
+	[ID_AD7766_2] = {
+		.decimation_factor = 32,
+	},
+};
+
+static const struct iio_buffer_setup_ops ad7766_buffer_setup_ops = {
+	.preenable = &ad7766_preenable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
+	.postdisable = &ad7766_postdisable,
+};
+
+static const struct iio_info ad7766_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &ad7766_read_raw,
+};
+
+static irqreturn_t ad7766_irq(int irq, void *private)
+{
+	iio_trigger_poll(private);
+	return IRQ_HANDLED;
+}
+
+static int ad7766_set_trigger_state(struct iio_trigger *trig, bool enable)
+{
+	struct ad7766 *ad7766 = iio_trigger_get_drvdata(trig);
+
+	if (enable)
+		enable_irq(ad7766->spi->irq);
+	else
+		disable_irq(ad7766->spi->irq);
+
+	return 0;
+}
+
+static const struct iio_trigger_ops ad7766_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = ad7766_set_trigger_state,
+};
+
+static int ad7766_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct iio_dev *indio_dev;
+	struct ad7766 *ad7766;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*ad7766));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ad7766 = iio_priv(indio_dev);
+	ad7766->chip_info = &ad7766_chip_info[id->driver_data];
+
+	ad7766->mclk = devm_clk_get(&spi->dev, "mclk");
+	if (IS_ERR(ad7766->mclk))
+		return PTR_ERR(ad7766->mclk);
+
+	ad7766->reg[AD7766_SUPPLY_AVDD].supply = "avdd";
+	ad7766->reg[AD7766_SUPPLY_DVDD].supply = "dvdd";
+	ad7766->reg[AD7766_SUPPLY_VREF].supply = "vref";
+
+	ret = devm_regulator_bulk_get(&spi->dev, ARRAY_SIZE(ad7766->reg),
+		ad7766->reg);
+	if (IS_ERR(ad7766->reg))
+		return PTR_ERR(ad7766->reg);
+
+	ad7766->pd_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
+		GPIOD_OUT_HIGH);
+	if (IS_ERR(ad7766->pd_gpio))
+		return PTR_ERR(ad7766->pd_gpio);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad7766_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad7766_channels);
+	indio_dev->info = &ad7766_info;
+
+	if (spi->irq > 0) {
+		ad7766->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
+			indio_dev->name, indio_dev->id);
+		if (!ad7766->trig)
+			return -ENOMEM;
+
+		ad7766->trig->ops = &ad7766_trigger_ops;
+		iio_trigger_set_drvdata(ad7766->trig, ad7766);
+
+		ret = request_irq(spi->irq, ad7766_irq, IRQF_TRIGGER_FALLING,
+			dev_name(&spi->dev), ad7766->trig);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * The device generates interrupts as long as it is powered up.
+		 * Some platforms might not allow the option to power it down so
+		 * disable the interrupt to avoid extra load on the system
+		 */
+		disable_irq(spi->irq);
+
+		ret = iio_trigger_register(ad7766->trig);
+		if (ret)
+			goto err_free_irq;
+	}
+
+	spi_set_drvdata(spi, indio_dev);
+
+	ad7766->spi = spi;
+
+	/* First byte always 0 */
+	ad7766->xfer.rx_buf = &ad7766->data[1];
+	ad7766->xfer.len = 3;
+
+	spi_message_init(&ad7766->msg);
+	spi_message_add_tail(&ad7766->xfer, &ad7766->msg);
+
+	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+		&ad7766_trigger_handler, &ad7766_buffer_setup_ops);
+	if (ret)
+		goto err_trigger_unregister;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto err_triggered_buffer_cleanup;
+	return 0;
+
+err_triggered_buffer_cleanup:
+	iio_triggered_buffer_cleanup(indio_dev);
+err_trigger_unregister:
+	if (spi->irq > 0)
+		iio_trigger_unregister(ad7766->trig);
+err_free_irq:
+	if (spi->irq > 0)
+		free_irq(spi->irq, ad7766->trig);
+
+	return ret;
+}
+
+static int ad7766_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad7766 *ad7766 = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	if (spi->irq > 0) {
+		iio_trigger_unregister(ad7766->trig);
+		free_irq(spi->irq, ad7766->trig);
+	}
+
+	return 0;
+}
+
+static const struct spi_device_id ad7766_id[] = {
+	{"ad7766", ID_AD7766},
+	{"ad7766-1", ID_AD7766_1},
+	{"ad7766-2", ID_AD7766_2},
+	{"ad7767", ID_AD7766},
+	{"ad7767-1", ID_AD7766_1},
+	{"ad7767-2", ID_AD7766_2},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad7766_id);
+
+static struct spi_driver ad7766_driver = {
+	.driver = {
+		.name	= "ad7766",
+	},
+	.probe		= ad7766_probe,
+	.remove		= ad7766_remove,
+	.id_table	= ad7766_id,
+};
+module_spi_driver(ad7766_driver);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("Analog Devices AD7766 and AD7767 ADCs driver support");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4
