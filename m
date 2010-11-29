Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [RFC] staging: iio: dds: ad9834: Enable driver support for AD9833 and AD9834 DDS devices
Date: Mon, 29 Nov 2010 16:05:57 +0100
Message-ID: <1291043157-10698-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>



---
 drivers/staging/iio/dds/Kconfig  |   11 +-
 drivers/staging/iio/dds/Makefile |    1 +
 drivers/staging/iio/dds/ad9834.c |  348 ++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/dds/dds.h    |   99 +++++++++++
 4 files changed, 457 insertions(+), 2 deletions(-)
 create mode 100644 drivers/staging/iio/dds/ad9834.c
 create mode 100644 drivers/staging/iio/dds/dds.h

diff --git a/drivers/staging/iio/dds/Kconfig b/drivers/staging/iio/dds/Kconfig
index d045ed6..4c9cce3 100644
--- a/drivers/staging/iio/dds/Kconfig
+++ b/drivers/staging/iio/dds/Kconfig
@@ -11,11 +11,18 @@ config AD5930
 	  ad5930/ad5932, provides direct access via sysfs.

 config AD9832
-	tristate "Analog Devices ad9832/3/4/5 driver"
+	tristate "Analog Devices ad9832/5 driver"
 	depends on SPI
 	help
 	  Say yes here to build support for Analog Devices DDS chip
-	  ad9832/3/4/5, provides direct access via sysfs.
+	  ad9832 and ad9835, provides direct access via sysfs.
+
+config AD9834
+	tristate "Analog Devices ad9833/4/ driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices DDS chip
+	  AD9833 and AD9834, provides direct access via sysfs.

 config AD9850
 	tristate "Analog Devices ad9850/1 driver"
diff --git a/drivers/staging/iio/dds/Makefile b/drivers/staging/iio/dds/Makefile
index 6f274ac..1477461 100644
--- a/drivers/staging/iio/dds/Makefile
+++ b/drivers/staging/iio/dds/Makefile
@@ -4,6 +4,7 @@

 obj-$(CONFIG_AD5930) += ad5930.o
 obj-$(CONFIG_AD9832) += ad9832.o
+obj-$(CONFIG_AD9834) += ad9834.o
 obj-$(CONFIG_AD9850) += ad9850.o
 obj-$(CONFIG_AD9852) += ad9852.o
 obj-$(CONFIG_AD9910) += ad9910.o
diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
new file mode 100644
index 0000000..1b5d32c
--- /dev/null
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -0,0 +1,348 @@
+/*
+ * AD9834 SPI DAC driver
+ *
+ * Copyright 2010 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/list.h>
+#include <linux/spi/spi.h>
+#include <linux/regulator/consumer.h>
+#include <linux/err.h>
+#include <asm/div64.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "dds.h"
+
+#include "ad9834.h"
+
+static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
+{
+	unsigned long long freqreg = (u64) fout * (u64) (1 << AD9834_FREQ_BITS);
+	do_div(freqreg, mclk);
+	return freqreg;
+}
+
+static int ad9834_write_frequency(struct ad9834_state *st,
+				  unsigned long addr, unsigned long fout)
+{
+	unsigned long regval;
+
+	if (fout > (st->mclk / 2))
+		return -EINVAL;
+
+	regval = ad9834_calc_freqreg(st->mclk, fout);
+
+	st->freq_data[0] = cpu_to_be16(addr | (regval &
+				       RES_MASK(AD9834_FREQ_BITS / 2)));
+	st->freq_data[1] = cpu_to_be16(addr | ((regval >>
+				       (AD9834_FREQ_BITS / 2)) &
+				       RES_MASK(AD9834_FREQ_BITS / 2)));
+
+	return spi_sync(st->spi, &st->freq_msg);;
+}
+
+static int ad9834_write_phase(struct ad9834_state *st,
+				  unsigned long addr, unsigned long phase)
+{
+	if (phase > (1 << AD9834_PHASE_BITS))
+		return -EINVAL;
+	st->data = cpu_to_be16(addr | phase);
+
+	return spi_sync(st->spi, &st->msg);
+}
+
+static ssize_t ad9834_write(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad9834_state *st = dev_info->dev_data;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret;
+	long val;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret)
+		goto error_ret;
+
+	mutex_lock(&dev_info->mlock);
+	switch (this_attr->address) {
+	case AD9834_REG_FREQ0:
+	case AD9834_REG_FREQ1:
+		ret = ad9834_write_frequency(st, this_attr->address, val);
+		break;
+	case AD9834_REG_PHASE0:
+	case AD9834_REG_PHASE1:
+		ret = ad9834_write_phase(st, this_attr->address, val);
+		break;
+	case AD9834_PIN_SW:
+	case AD9834_OPBITEN:
+		if (val)
+			st->control |= this_attr->address;
+		else
+			st->control &= ~this_attr->address;
+			st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
+		ret = spi_sync(st->spi, &st->msg);
+		break;
+	case AD9834_FSEL:
+	case AD9834_PSEL:
+		if (val == 0)
+			st->control &= ~(this_attr->address | AD9834_PIN_SW);
+		else if (val == 1) {
+			st->control |= this_attr->address;
+			st->control &= ~AD9834_PIN_SW;
+		}
+		st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
+		ret = spi_sync(st->spi, &st->msg);
+		break;
+	case AD9834_RESET:
+		if (val)
+			st->control |= AD9834_RESET;
+		else
+			st->control &= ~AD9834_RESET;
+			st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
+		ret = spi_sync(st->spi, &st->msg);
+		break;
+	default:
+		ret = -ENODEV;
+	}
+	mutex_unlock(&dev_info->mlock);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+static ssize_t ad9834_store_mode(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t len)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad9834_state *st = dev_info->dev_data;
+	int ret;
+
+	mutex_lock(&dev_info->mlock);
+	if (strncmp(buf, "sine", 4) == 0)
+		st->control &= ~AD9834_MODE;
+	else if (strncmp(buf, "triangle", 8) == 0)
+		st->control |= AD9834_MODE;
+	else
+		ret = -EINVAL;
+	mutex_unlock(&dev_info->mlock);
+
+	return ret ? ret : len;
+}
+
+static ssize_t ad9834_show_name(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad9834_state *st = iio_dev_get_devdata(dev_info);
+
+	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
+}
+static IIO_DEVICE_ATTR(name, S_IRUGO, ad9834_show_name, NULL, 0);
+
+static IIO_DEV_ATTR_FREQ(0, ad9834_write, AD9834_REG_FREQ0);
+static IIO_DEV_ATTR_FREQ(1, ad9834_write, AD9834_REG_FREQ1);
+static IIO_DEV_ATTR_FREQ_EN(ad9834_write, AD9834_FSEL);
+static IIO_CONST_ATTR_FREQ_SCALE("1"); /* 1Hz */
+
+static IIO_DEV_ATTR_PHASE(0, ad9834_write, AD9834_REG_PHASE0);
+static IIO_DEV_ATTR_PHASE(1, ad9834_write, AD9834_REG_PHASE1);
+static IIO_DEV_ATTR_PHASE_EN(ad9834_write, AD9834_PSEL);
+static IIO_CONST_ATTR_PHASE_SCALE("0.0015339808"); /* 2PI/2^12 rad*/
+
+static IIO_DEV_ATTR_PINCONTROL_EN(ad9834_write, AD9834_PIN_SW);
+static IIO_DEV_ATTR_DISABLE(ad9834_write, AD9834_RESET);
+static IIO_DEV_ATTR_SIGNBIT_OUTPUT_EN(ad9834_write, AD9834_OPBITEN);
+static IIO_DEV_ATTR_SIGNBIT_OUTPUT_MODE(ad9834_store_mode, 0);
+static IIO_CONST_ATTR_AVAILABLE_OUTPUT_MODES("sine triangle");
+
+static struct attribute *ad9834_attributes[] = {
+	&iio_dev_attr_freq0.dev_attr.attr,
+	&iio_dev_attr_freq1.dev_attr.attr,
+	&iio_const_attr_freq_scale.dev_attr.attr,
+	&iio_dev_attr_phase0.dev_attr.attr,
+	&iio_dev_attr_phase1.dev_attr.attr,
+	&iio_const_attr_phase_scale.dev_attr.attr,
+	&iio_dev_attr_pincontrol_en.dev_attr.attr,
+	&iio_dev_attr_freq_en.dev_attr.attr,
+	&iio_dev_attr_phase_en.dev_attr.attr,
+	&iio_dev_attr_disable.dev_attr.attr,
+	&iio_dev_attr_signbit_output_en.dev_attr.attr,
+	&iio_dev_attr_output_mode.dev_attr.attr,
+	&iio_const_attr_available_output_modes.dev_attr.attr,
+	&iio_dev_attr_name.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad9834_attribute_group = {
+	.attrs = ad9834_attributes,
+};
+
+static int __devinit ad9834_probe(struct spi_device *spi)
+{
+	struct ad9834_platform_data *pdata = spi->dev.platform_data;
+	struct ad9834_state *st;
+	int ret, voltage_uv = 0;
+
+	if (!pdata) {
+		dev_dbg(&spi->dev, "no platform data?\n");
+		return -ENODEV;
+	}
+
+	st = kzalloc(sizeof(*st), GFP_KERNEL);
+	if (st == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	st->reg = regulator_get(&spi->dev, "vcc");
+	if (!IS_ERR(st->reg)) {
+		ret = regulator_enable(st->reg);
+		if (ret)
+			goto error_put_reg;
+
+		voltage_uv = regulator_get_voltage(st->reg);
+	}
+
+	st->mclk = pdata->mclk;
+
+	spi_set_drvdata(spi, st);
+
+	st->spi = spi;
+
+	st->indio_dev = iio_allocate_device();
+	if (st->indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_disable_reg;
+	}
+
+	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->attrs = &ad9834_attribute_group;
+	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	/* Setup default messages */
+
+	st->xfer.tx_buf = &st->data;
+	st->xfer.len = 2;
+
+	spi_message_init(&st->msg);
+	spi_message_add_tail(&st->xfer, &st->msg);
+
+	st->freq_xfer[0].tx_buf = &st->freq_data[0];
+	st->freq_xfer[0].len = 2;
+	st->freq_xfer[0].cs_change = 1;
+	st->freq_xfer[1].tx_buf = &st->freq_data[1];
+	st->freq_xfer[1].len = 2;
+
+	spi_message_init(&st->freq_msg);
+	spi_message_add_tail(&st->freq_xfer[0], &st->freq_msg);
+	spi_message_add_tail(&st->freq_xfer[1], &st->freq_msg);
+
+	st->control = AD9834_B28 | AD9834_RESET;
+
+	if (!pdata->en_div2)
+		st->control |= AD9834_DIV2;
+
+	if (!pdata->en_signbit_msb_out)
+		st->control |= AD9834_SIGN_PIB;
+
+	st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
+	ret = spi_sync(st->spi, &st->msg);
+
+	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, pdata->freq0);
+	ret |= ad9834_write_frequency(st, AD9834_REG_FREQ1, pdata->freq1);
+	ret |= ad9834_write_phase(st, AD9834_REG_PHASE0, pdata->phase0);
+	ret |= ad9834_write_phase(st, AD9834_REG_PHASE1, pdata->phase1);
+
+	st->control &= ~AD9834_RESET;
+
+	st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
+	ret |= spi_sync(st->spi, &st->msg);
+
+	if (ret) {
+		dev_err(&spi->dev, "device init failed\n");
+		goto error_free_device;
+	}
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_free_device;
+
+	return 0;
+
+error_free_device:
+	iio_free_device(st->indio_dev);
+error_disable_reg:
+	if (!IS_ERR(st->reg))
+		regulator_disable(st->reg);
+error_put_reg:
+	if (!IS_ERR(st->reg))
+		regulator_put(st->reg);
+	kfree(st);
+error_ret:
+	return ret;
+}
+
+static int ad9834_remove(struct spi_device *spi)
+{
+	struct ad9834_state *st = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = st->indio_dev;
+
+	iio_device_unregister(indio_dev);
+	if (!IS_ERR(st->reg)) {
+		regulator_disable(st->reg);
+		regulator_put(st->reg);
+	}
+	kfree(st);
+	return 0;
+}
+
+static const struct spi_device_id ad9834_id[] = {
+	{"ad9833", ID_AD9833},
+	{"ad9834", ID_AD9834},
+	{}
+};
+
+static struct spi_driver ad9834_driver = {
+	.driver = {
+		.name	= "ad9834",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ad9834_probe,
+	.remove		= __devexit_p(ad9834_remove),
+	.id_table	= ad9834_id,
+};
+
+static int __init ad9834_init(void)
+{
+	return spi_register_driver(&ad9834_driver);
+}
+module_init(ad9834_init);
+
+static void __exit ad9834_exit(void)
+{
+	spi_unregister_driver(&ad9834_driver);
+}
+module_exit(ad9834_exit);
+
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("Analog Devices AD9833/AD9834 DAC");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:ad9834");
diff --git a/drivers/staging/iio/dds/dds.h b/drivers/staging/iio/dds/dds.h
new file mode 100644
index 0000000..9326281
--- /dev/null
+++ b/drivers/staging/iio/dds/dds.h
@@ -0,0 +1,99 @@
+/*
+ * dds.h - sysfs attributes associated with DDS devices
+ */
+
+/**
+ * /sys/bus/iio/devices/deviceX/freqX
+ * Description:
+ * Stores frequency into tuning word register X.
+ * There can be more than one freqX file, which allows for pin controlled FSK
+ * Frequency Shift Keying (en_pincontrol is active) or the user can control
+ * the desired active tuning word by writing X to the en_freq file.
+ */
+
+#define IIO_DEV_ATTR_FREQ(_num, _store, _addr)				\
+	IIO_DEVICE_ATTR(freq##_num, S_IWUSR, NULL, _store, _addr)
+
+/**
+ * /sys/bus/iio/devices/deviceX/freq_en
+ * Description:
+ * Specifies the active output frequency tuning word.
+ * To exit this mode the user can write pincontrol_en or disable file.
+ */
+
+#define IIO_DEV_ATTR_FREQ_EN(_store, _addr)				\
+	IIO_DEVICE_ATTR(freq_en, S_IWUSR, NULL, _store, _addr);
+
+#define IIO_CONST_ATTR_FREQ_SCALE(_string)		\
+	IIO_CONST_ATTR(freq_scale, _string)
+
+/**
+ * /sys/bus/iio/devices/deviceX/phaseX
+ * Description:
+ * Stores phase into phase register X.
+ * There can be more than one phaseX file, which allows for pin controlled PSK
+ * Phase Shift Keying (en_pincontrol is active) or the user can control
+ * the desired phase X which is added to the phase accumulator output
+ * by writing X to the en_phase file.
+ */
+
+#define IIO_DEV_ATTR_PHASE(_num, _store, _addr)				\
+	IIO_DEVICE_ATTR(phase##_num, S_IWUSR, NULL, _store, _addr)
+
+/**
+ * /sys/bus/iio/devices/deviceX/phase_en
+ * Description:
+ * Specifies the active phase which is added to the phase accumulator output.
+ * To exit this mode the user can write pincontrol_en or disable file.
+ */
+
+#define IIO_DEV_ATTR_PHASE_EN(_store, _addr)				\
+	IIO_DEVICE_ATTR(phase_en, S_IWUSR, NULL, _store, _addr);
+
+#define IIO_CONST_ATTR_PHASE_SCALE(_string)		\
+	IIO_CONST_ATTR(phase_scale, _string)
+
+
+/**
+ * /sys/bus/iio/devices/deviceX/pincontrol_en
+ * Description:
+ * The active frequency and phase is controlled by the respective
+ * phase and frequency control inputs.
+ */
+
+#define IIO_DEV_ATTR_PINCONTROL_EN(_store, _addr)			\
+	IIO_DEVICE_ATTR(pincontrol_en, S_IWUSR, NULL, _store, _addr);
+
+/**
+ * /sys/bus/iio/devices/deviceX/disable
+ * Description:
+ * Disables any signal generation, the output is set to midscale
+ */
+
+#define IIO_DEV_ATTR_DISABLE(_store, _addr)				\
+	IIO_DEVICE_ATTR(disable, S_IWUSR, NULL, _store, _addr);
+
+/**
+ * /sys/bus/iio/devices/deviceX/signbit_output_en
+ * Description:
+ * Enables an auxiliary square wave output
+ */
+#define IIO_DEV_ATTR_SIGNBIT_OUTPUT_EN(_store, _addr)				\
+	IIO_DEVICE_ATTR(signbit_output_en, S_IWUSR, NULL, _store, _addr);
+
+/**
+ * /sys/bus/iio/devices/deviceX/output_mode
+ * Description:
+ * Specifies the output waveform.
+ * For a list of available output waveform modes read available_output_modes.
+ */
+#define IIO_DEV_ATTR_SIGNBIT_OUTPUT_MODE(_store, _addr)				\
+	IIO_DEVICE_ATTR(output_mode, S_IWUSR, NULL, _store, _addr);
+
+/**
+ * /sys/bus/iio/devices/deviceX/available_output_modes
+ * Description:
+ * Lists all available output waveform modes
+ */
+#define IIO_CONST_ATTR_AVAILABLE_OUTPUT_MODES(_modes)			\
+	IIO_CONST_ATTR(available_output_modes, _modes);
--
1.6.0.2
