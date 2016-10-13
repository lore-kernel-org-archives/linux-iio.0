Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34208 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbcJMVFL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Oct 2016 17:05:11 -0400
Received: by mail-qk0-f194.google.com with SMTP id n189so7137574qke.1
        for <linux-iio@vger.kernel.org>; Thu, 13 Oct 2016 14:04:56 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH v4 1/2] iio: humidity: add support to hts221 rh/temp combo device
Date: Thu, 13 Oct 2016 22:06:04 +0200
Message-Id: <1476389165-13542-2-git-send-email-lorenzo.bianconi@st.com>
In-Reply-To: <1476389165-13542-1-git-send-email-lorenzo.bianconi@st.com>
References: <1476389165-13542-1-git-send-email-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support to STM HTS221 humidity + temperature sensor

http://www.st.com/resource/en/datasheet/hts221.pdf

- continuous mode support
- i2c support
- spi support
- trigger mode support

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/humidity/Kconfig         |  22 ++
 drivers/iio/humidity/Makefile        |   7 +
 drivers/iio/humidity/hts221.h        |  73 ++++
 drivers/iio/humidity/hts221_buffer.c | 168 +++++++++
 drivers/iio/humidity/hts221_core.c   | 687 +++++++++++++++++++++++++++++++++++
 drivers/iio/humidity/hts221_i2c.c    | 110 ++++++
 drivers/iio/humidity/hts221_spi.c    | 125 +++++++
 7 files changed, 1192 insertions(+)
 create mode 100644 drivers/iio/humidity/hts221.h
 create mode 100644 drivers/iio/humidity/hts221_buffer.c
 create mode 100644 drivers/iio/humidity/hts221_core.c
 create mode 100644 drivers/iio/humidity/hts221_i2c.c
 create mode 100644 drivers/iio/humidity/hts221_spi.c

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index b17e2e2..6fd11d0 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -34,6 +34,28 @@ config HDC100X
 	  To compile this driver as a module, choose M here: the module
 	  will be called hdc100x.
 
+config HTS221
+	tristate "STMicroelectronics HTS221 sensor Driver"
+	depends on (I2C || SPI)
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select HTS221_I2C if (I2C)
+	select HTS221_SPI if (SPI_MASTER)
+	help
+	  Say yes here to build support for STMicroelectronics HTS221
+	  temperature-humidity sensor
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called hts221.
+
+config HTS221_I2C
+	tristate
+	depends on HTS221
+
+config HTS221_SPI
+	tristate
+	depends on HTS221
+
 config HTU21
 	tristate "Measurement Specialties HTU21 humidity & temperature sensor"
 	depends on I2C
diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
index 4a73442..a6850e4 100644
--- a/drivers/iio/humidity/Makefile
+++ b/drivers/iio/humidity/Makefile
@@ -5,6 +5,13 @@
 obj-$(CONFIG_AM2315) += am2315.o
 obj-$(CONFIG_DHT11) += dht11.o
 obj-$(CONFIG_HDC100X) += hdc100x.o
+
+hts221-y := hts221_core.o \
+	    hts221_buffer.o
+obj-$(CONFIG_HTS221) += hts221.o
+obj-$(CONFIG_HTS221_I2C) += hts221_i2c.o
+obj-$(CONFIG_HTS221_SPI) += hts221_spi.o
+
 obj-$(CONFIG_HTU21) += htu21.o
 obj-$(CONFIG_SI7005) += si7005.o
 obj-$(CONFIG_SI7020) += si7020.o
diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
new file mode 100644
index 0000000..0d2993c
--- /dev/null
+++ b/drivers/iio/humidity/hts221.h
@@ -0,0 +1,73 @@
+/*
+ * STMicroelectronics hts221 sensor driver
+ *
+ * Copyright 2016 STMicroelectronics Inc.
+ *
+ * Lorenzo Bianconi <lorenzo.bianconi@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#ifndef HTS221_H
+#define HTS221_H
+
+#define HTS221_DEV_NAME		"hts221"
+
+#include <linux/iio/iio.h>
+
+#define HTS221_RX_MAX_LENGTH	8
+#define HTS221_TX_MAX_LENGTH	8
+
+#define HTS221_DATA_SIZE	2
+
+struct hts221_transfer_buffer {
+	u8 rx_buf[HTS221_RX_MAX_LENGTH];
+	u8 tx_buf[HTS221_TX_MAX_LENGTH] ____cacheline_aligned;
+};
+
+struct hts221_transfer_function {
+	int (*read)(struct device *dev, u8 addr, int len, u8 *data);
+	int (*write)(struct device *dev, u8 addr, int len, u8 *data);
+};
+
+#define HTS221_AVG_DEPTH	8
+struct hts221_avg_avl {
+	u16 avg;
+	u8 val;
+};
+
+enum hts221_sensor_type {
+	HTS221_SENSOR_H,
+	HTS221_SENSOR_T,
+	HTS221_SENSOR_MAX,
+};
+
+struct hts221_sensor {
+	u8 cur_avg_idx;
+	int slope, b_gen;
+};
+
+struct hts221_hw {
+	const char *name;
+	struct device *dev;
+
+	struct mutex lock;
+	struct iio_trigger *trig;
+	int irq;
+
+	struct hts221_sensor sensors[HTS221_SENSOR_MAX];
+
+	u8 odr;
+
+	const struct hts221_transfer_function *tf;
+	struct hts221_transfer_buffer tb;
+};
+
+int hts221_config_drdy(struct hts221_hw *hw, bool enable);
+int hts221_probe(struct iio_dev *iio_dev);
+int hts221_power_on(struct hts221_hw *hw);
+int hts221_power_off(struct hts221_hw *hw);
+int hts221_allocate_buffers(struct hts221_hw *hw);
+int hts221_allocate_triggers(struct hts221_hw *hw);
+
+#endif /* HTS221_H */
diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
new file mode 100644
index 0000000..6b174fd
--- /dev/null
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -0,0 +1,168 @@
+/*
+ * STMicroelectronics hts221 sensor driver
+ *
+ * Copyright 2016 STMicroelectronics Inc.
+ *
+ * Lorenzo Bianconi <lorenzo.bianconi@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/interrupt.h>
+#include <linux/iio/events.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/buffer.h>
+
+#include "hts221.h"
+
+#define HTS221_REG_STATUS_ADDR		0x27
+#define HTS221_RH_DRDY_MASK		BIT(1)
+#define HTS221_TEMP_DRDY_MASK		BIT(0)
+
+static int hts221_trig_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *iio_dev = iio_trigger_get_drvdata(trig);
+	struct hts221_hw *hw = iio_priv(iio_dev);
+
+	return hts221_config_drdy(hw, state);
+}
+
+static const struct iio_trigger_ops hts221_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = hts221_trig_set_state,
+};
+
+static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
+{
+	struct hts221_hw *hw = (struct hts221_hw *)private;
+	u8 status;
+	int err;
+
+	err = hw->tf->read(hw->dev, HTS221_REG_STATUS_ADDR, sizeof(status),
+			   &status);
+	if (err < 0)
+		return IRQ_HANDLED;
+
+	/* H_DA bit (humidity data available) is routed to DRDY line.
+	 * Humidity sample is computed after temperature one.
+	 * Here we can assume data channels are both available if H_DA bit
+	 * is set in status register
+	 */
+	if (!(status & HTS221_RH_DRDY_MASK))
+		return IRQ_NONE;
+
+	iio_trigger_poll_chained(hw->trig);
+
+	return IRQ_HANDLED;
+}
+
+int hts221_allocate_triggers(struct hts221_hw *hw)
+{
+	struct iio_dev *iio_dev = iio_priv_to_dev(hw);
+	unsigned long irq_type;
+	int err;
+
+	irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
+
+	switch (irq_type) {
+	case IRQF_TRIGGER_HIGH:
+	case IRQF_TRIGGER_RISING:
+		break;
+	default:
+		dev_info(hw->dev,
+			 "mode %lx unsupported, using IRQF_TRIGGER_RISING\n",
+			 irq_type);
+		irq_type = IRQF_TRIGGER_RISING;
+		break;
+	}
+
+	err = devm_request_threaded_irq(hw->dev, hw->irq, NULL,
+					hts221_trigger_handler_thread,
+					irq_type | IRQF_ONESHOT,
+					hw->name, hw);
+	if (err) {
+		dev_err(hw->dev, "failed to request trigger irq %d\n",
+			hw->irq);
+		return err;
+	}
+
+	hw->trig = devm_iio_trigger_alloc(hw->dev, "%s-trigger",
+					  iio_dev->name);
+	if (!hw->trig)
+		return -ENOMEM;
+
+	iio_trigger_set_drvdata(hw->trig, iio_dev);
+	hw->trig->ops = &hts221_trigger_ops;
+	hw->trig->dev.parent = hw->dev;
+	iio_dev->trig = iio_trigger_get(hw->trig);
+
+	return devm_iio_trigger_register(hw->dev, hw->trig);
+}
+
+static int hts221_buffer_preenable(struct iio_dev *iio_dev)
+{
+	return hts221_power_on(iio_priv(iio_dev));
+}
+
+static int hts221_buffer_postdisable(struct iio_dev *iio_dev)
+{
+	return hts221_power_off(iio_priv(iio_dev));
+}
+
+static const struct iio_buffer_setup_ops hts221_buffer_ops = {
+	.preenable = hts221_buffer_preenable,
+	.postenable = iio_triggered_buffer_postenable,
+	.predisable = iio_triggered_buffer_predisable,
+	.postdisable = hts221_buffer_postdisable,
+};
+
+static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
+{
+	u8 buffer[ALIGN(2 * HTS221_DATA_SIZE, sizeof(s64)) + sizeof(s64)];
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio_dev = pf->indio_dev;
+	struct hts221_hw *hw = iio_priv(iio_dev);
+	struct iio_chan_spec const *ch;
+	int err;
+
+	/* humidity data */
+	ch = &iio_dev->channels[HTS221_SENSOR_H];
+	err = hw->tf->read(hw->dev, ch->address, HTS221_DATA_SIZE,
+			   buffer);
+	if (err < 0)
+		goto out;
+
+	/* temperature data */
+	ch = &iio_dev->channels[HTS221_SENSOR_T];
+	err = hw->tf->read(hw->dev, ch->address, HTS221_DATA_SIZE,
+			   buffer + HTS221_DATA_SIZE);
+	if (err < 0)
+		goto out;
+
+	iio_push_to_buffers_with_timestamp(iio_dev, buffer,
+					   iio_get_time_ns(iio_dev));
+
+out:
+	iio_trigger_notify_done(hw->trig);
+
+	return IRQ_HANDLED;
+}
+
+int hts221_allocate_buffers(struct hts221_hw *hw)
+{
+	return devm_iio_triggered_buffer_setup(hw->dev, iio_priv_to_dev(hw),
+					NULL, hts221_buffer_handler_thread,
+					&hts221_buffer_ops);
+}
+
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics hts221 buffer driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
new file mode 100644
index 0000000..5a099dd
--- /dev/null
+++ b/drivers/iio/humidity/hts221_core.c
@@ -0,0 +1,687 @@
+/*
+ * STMicroelectronics hts221 sensor driver
+ *
+ * Copyright 2016 STMicroelectronics Inc.
+ *
+ * Lorenzo Bianconi <lorenzo.bianconi@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/iio/sysfs.h>
+#include <linux/delay.h>
+#include <asm/unaligned.h>
+
+#include "hts221.h"
+
+#define HTS221_REG_WHOAMI_ADDR		0x0f
+#define HTS221_REG_WHOAMI_VAL		0xbc
+
+#define HTS221_REG_CNTRL1_ADDR		0x20
+#define HTS221_REG_CNTRL2_ADDR		0x21
+#define HTS221_REG_CNTRL3_ADDR		0x22
+
+#define HTS221_REG_AVG_ADDR		0x10
+#define HTS221_REG_H_OUT_L		0x28
+#define HTS221_REG_T_OUT_L		0x2a
+
+#define HTS221_HUMIDITY_AVG_MASK	0x07
+#define HTS221_TEMP_AVG_MASK		0x38
+
+#define HTS221_ODR_MASK			0x87
+#define HTS221_BDU_MASK			BIT(2)
+
+#define HTS221_DRDY_MASK		BIT(2)
+
+#define HTS221_ENABLE_SENSOR		BIT(7)
+
+#define HTS221_HUMIDITY_AVG_4		0x00 /* 0.4 %RH */
+#define HTS221_HUMIDITY_AVG_8		0x01 /* 0.3 %RH */
+#define HTS221_HUMIDITY_AVG_16		0x02 /* 0.2 %RH */
+#define HTS221_HUMIDITY_AVG_32		0x03 /* 0.15 %RH */
+#define HTS221_HUMIDITY_AVG_64		0x04 /* 0.1 %RH */
+#define HTS221_HUMIDITY_AVG_128		0x05 /* 0.07 %RH */
+#define HTS221_HUMIDITY_AVG_256		0x06 /* 0.05 %RH */
+#define HTS221_HUMIDITY_AVG_512		0x07 /* 0.03 %RH */
+
+#define HTS221_TEMP_AVG_2		0x00 /* 0.08 degC */
+#define HTS221_TEMP_AVG_4		0x08 /* 0.05 degC */
+#define HTS221_TEMP_AVG_8		0x10 /* 0.04 degC */
+#define HTS221_TEMP_AVG_16		0x18 /* 0.03 degC */
+#define HTS221_TEMP_AVG_32		0x20 /* 0.02 degC */
+#define HTS221_TEMP_AVG_64		0x28 /* 0.015 degC */
+#define HTS221_TEMP_AVG_128		0x30 /* 0.01 degC */
+#define HTS221_TEMP_AVG_256		0x38 /* 0.007 degC */
+
+/* calibration registers */
+#define HTS221_REG_0RH_CAL_X_H		0x36
+#define HTS221_REG_1RH_CAL_X_H		0x3a
+#define HTS221_REG_0RH_CAL_Y_H		0x30
+#define HTS221_REG_1RH_CAL_Y_H		0x31
+#define HTS221_REG_0T_CAL_X_L		0x3c
+#define HTS221_REG_1T_CAL_X_L		0x3e
+#define HTS221_REG_0T_CAL_Y_H		0x32
+#define HTS221_REG_1T_CAL_Y_H		0x33
+#define HTS221_REG_T1_T0_CAL_Y_H	0x35
+
+struct hts221_odr {
+	u8 hz;
+	u8 val;
+};
+
+struct hts221_avg {
+	u8 addr;
+	u8 mask;
+	struct hts221_avg_avl avg_avl[HTS221_AVG_DEPTH];
+};
+
+static const struct hts221_odr hts221_odr_table[] = {
+	{  1, 0x01 },	/* 1Hz */
+	{  7, 0x02 },	/* 7Hz */
+	{ 13, 0x03 },	/* 12.5Hz */
+};
+
+static const struct hts221_avg hts221_avg_list[] = {
+	{
+		.addr = HTS221_REG_AVG_ADDR,
+		.mask = HTS221_HUMIDITY_AVG_MASK,
+		.avg_avl = {
+			{ 4, HTS221_HUMIDITY_AVG_4 },
+			{ 8, HTS221_HUMIDITY_AVG_8 },
+			{ 16, HTS221_HUMIDITY_AVG_16 },
+			{ 32, HTS221_HUMIDITY_AVG_32 },
+			{ 64, HTS221_HUMIDITY_AVG_64 },
+			{ 128, HTS221_HUMIDITY_AVG_128 },
+			{ 256, HTS221_HUMIDITY_AVG_256 },
+			{ 512, HTS221_HUMIDITY_AVG_512 },
+		},
+	},
+	{
+		.addr = HTS221_REG_AVG_ADDR,
+		.mask = HTS221_TEMP_AVG_MASK,
+		.avg_avl = {
+			{ 2, HTS221_TEMP_AVG_2 },
+			{ 4, HTS221_TEMP_AVG_4 },
+			{ 8, HTS221_TEMP_AVG_8 },
+			{ 16, HTS221_TEMP_AVG_16 },
+			{ 32, HTS221_TEMP_AVG_32 },
+			{ 64, HTS221_TEMP_AVG_64 },
+			{ 128, HTS221_TEMP_AVG_128 },
+			{ 256, HTS221_TEMP_AVG_256 },
+		},
+	},
+};
+
+static const struct iio_chan_spec hts221_channels[] = {
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.address = HTS221_REG_H_OUT_L,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_OFFSET) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	{
+		.type = IIO_TEMP,
+		.address = HTS221_REG_T_OUT_L,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_OFFSET) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
+};
+
+static int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask,
+				  u8 val)
+{
+	u8 data;
+	int err;
+
+	mutex_lock(&hw->lock);
+
+	err = hw->tf->read(hw->dev, addr, sizeof(data), &data);
+	if (err < 0) {
+		dev_err(hw->dev, "failed to read %02x register\n", addr);
+		goto unlock;
+	}
+
+	data = (data & ~mask) | (val & mask);
+
+	err = hw->tf->write(hw->dev, addr, sizeof(data), &data);
+	if (err < 0)
+		dev_err(hw->dev, "failed to write %02x register\n", addr);
+
+unlock:
+	mutex_unlock(&hw->lock);
+
+	return err;
+}
+
+static int hts221_check_whoami(struct hts221_hw *hw)
+{
+	u8 data;
+	int err;
+
+	err = hw->tf->read(hw->dev, HTS221_REG_WHOAMI_ADDR, sizeof(data),
+			   &data);
+	if (err < 0) {
+		dev_err(hw->dev, "failed to read whoami register\n");
+		return err;
+	}
+
+	if (data != HTS221_REG_WHOAMI_VAL) {
+		dev_err(hw->dev, "wrong whoami {%02x vs %02x}\n",
+			data, HTS221_REG_WHOAMI_VAL);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+int hts221_config_drdy(struct hts221_hw *hw, bool enable)
+{
+	u8 val = enable ? BIT(2) : 0;
+	int err;
+
+	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL3_ADDR,
+				     HTS221_DRDY_MASK, val);
+
+	return err < 0 ? err : 0;
+}
+
+static int hts221_update_odr(struct hts221_hw *hw, u8 odr)
+{
+	int i, err;
+	u8 val;
+
+	for (i = 0; i < ARRAY_SIZE(hts221_odr_table); i++)
+		if (hts221_odr_table[i].hz == odr)
+			break;
+
+	if (i == ARRAY_SIZE(hts221_odr_table))
+		return -EINVAL;
+
+	val = HTS221_ENABLE_SENSOR | HTS221_BDU_MASK | hts221_odr_table[i].val;
+	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
+				     HTS221_ODR_MASK, val);
+	if (err < 0)
+		return err;
+
+	hw->odr = odr;
+
+	return 0;
+}
+
+static int hts221_update_avg(struct hts221_hw *hw,
+			     enum hts221_sensor_type type,
+			     u16 val)
+{
+	int i, err;
+	const struct hts221_avg *avg = &hts221_avg_list[type];
+
+	for (i = 0; i < HTS221_AVG_DEPTH; i++)
+		if (avg->avg_avl[i].avg == val)
+			break;
+
+	if (i == HTS221_AVG_DEPTH)
+		return -EINVAL;
+
+	err = hts221_write_with_mask(hw, avg->addr, avg->mask,
+				     avg->avg_avl[i].val);
+	if (err < 0)
+		return err;
+
+	hw->sensors[type].cur_avg_idx = i;
+
+	return 0;
+}
+
+static ssize_t hts221_sysfs_sampling_freq(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	int i;
+	ssize_t len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(hts221_odr_table); i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
+				 hts221_odr_table[i].hz);
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static ssize_t
+hts221_sysfs_rh_oversampling_avail(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	const struct hts221_avg *avg = &hts221_avg_list[HTS221_SENSOR_H];
+	ssize_t len = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(avg->avg_avl); i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
+				 avg->avg_avl[i].avg);
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static ssize_t
+hts221_sysfs_temp_oversampling_avail(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	const struct hts221_avg *avg = &hts221_avg_list[HTS221_SENSOR_T];
+	ssize_t len = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(avg->avg_avl); i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
+				 avg->avg_avl[i].avg);
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+int hts221_power_on(struct hts221_hw *hw)
+{
+	return hts221_update_odr(hw, hw->odr);
+}
+
+int hts221_power_off(struct hts221_hw *hw)
+{
+	u8 data[] = {0x00, 0x00};
+
+	return hw->tf->write(hw->dev, HTS221_REG_CNTRL1_ADDR, sizeof(data),
+			     data);
+}
+
+static int hts221_parse_temp_caldata(struct hts221_hw *hw)
+{
+	int err, *slope, *b_gen;
+	s16 cal_x0, cal_x1, cal_y0, cal_y1;
+	u8 cal0, cal1;
+
+	err = hw->tf->read(hw->dev, HTS221_REG_0T_CAL_Y_H,
+			   sizeof(cal0), &cal0);
+	if (err < 0)
+		return err;
+
+	err = hw->tf->read(hw->dev, HTS221_REG_T1_T0_CAL_Y_H,
+			   sizeof(cal1), &cal1);
+	if (err < 0)
+		return err;
+	cal_y0 = (le16_to_cpu(cal1 & 0x3) << 8) | cal0;
+
+	err = hw->tf->read(hw->dev, HTS221_REG_1T_CAL_Y_H,
+			   sizeof(cal0), &cal0);
+	if (err < 0)
+		return err;
+	cal_y1 = (((cal1 & 0xc) >> 2) << 8) | cal0;
+
+	err = hw->tf->read(hw->dev, HTS221_REG_0T_CAL_X_L, sizeof(cal_x0),
+			   (u8 *)&cal_x0);
+	if (err < 0)
+		return err;
+	cal_x0 = le16_to_cpu(cal_x0);
+
+	err = hw->tf->read(hw->dev, HTS221_REG_1T_CAL_X_L, sizeof(cal_x1),
+			   (u8 *)&cal_x1);
+	if (err < 0)
+		return err;
+	cal_x1 = le16_to_cpu(cal_x1);
+
+	slope = &hw->sensors[HTS221_SENSOR_T].slope;
+	b_gen = &hw->sensors[HTS221_SENSOR_T].b_gen;
+
+	*slope = ((cal_y1 - cal_y0) * 8000) / (cal_x1 - cal_x0);
+	*b_gen = (((s32)cal_x1 * cal_y0 - (s32)cal_x0 * cal_y1) * 1000) /
+		 (cal_x1 - cal_x0);
+	*b_gen *= 8;
+
+	return 0;
+}
+
+static int hts221_parse_rh_caldata(struct hts221_hw *hw)
+{
+	int err, *slope, *b_gen;
+	s16 cal_x0, cal_x1, cal_y0, cal_y1;
+	u8 data;
+
+	err = hw->tf->read(hw->dev, HTS221_REG_0RH_CAL_Y_H, sizeof(data),
+			   &data);
+	if (err < 0)
+		return err;
+	cal_y0 = data;
+
+	err = hw->tf->read(hw->dev, HTS221_REG_1RH_CAL_Y_H, sizeof(data),
+			   &data);
+	if (err < 0)
+		return err;
+	cal_y1 = data;
+
+	err = hw->tf->read(hw->dev, HTS221_REG_0RH_CAL_X_H, sizeof(cal_x0),
+			   (u8 *)&cal_x0);
+	if (err < 0)
+		return err;
+	cal_x0 = le16_to_cpu(cal_x0);
+
+	err = hw->tf->read(hw->dev, HTS221_REG_1RH_CAL_X_H, sizeof(cal_x1),
+			   (u8 *)&cal_x1);
+	if (err < 0)
+		return err;
+	cal_x1 = le16_to_cpu(cal_x1);
+
+	slope = &hw->sensors[HTS221_SENSOR_H].slope;
+	b_gen = &hw->sensors[HTS221_SENSOR_H].b_gen;
+
+	*slope = ((cal_y1 - cal_y0) * 8000) / (cal_x1 - cal_x0);
+	*b_gen = (((s32)cal_x1 * cal_y0 - (s32)cal_x0 * cal_y1) * 1000) /
+		 (cal_x1 - cal_x0);
+	*b_gen *= 8;
+
+	return 0;
+}
+
+static int hts221_get_sensor_scale(struct hts221_hw *hw,
+				   enum iio_chan_type ch_type,
+				   int *val, int *val2)
+{
+	s64 tmp;
+	s32 rem, div, data;
+
+	switch (ch_type) {
+	case IIO_HUMIDITYRELATIVE:
+		data = hw->sensors[HTS221_SENSOR_H].slope;
+		div = (1 << 4) * 1000;
+		break;
+	case IIO_TEMP:
+		data = hw->sensors[HTS221_SENSOR_T].slope;
+		div = (1 << 6) * 1000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tmp = div_s64(data * 1000000000LL, div);
+	tmp = div_s64_rem(tmp, 1000000000LL, &rem);
+
+	*val = tmp;
+	*val2 = rem;
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int hts221_get_sensor_offset(struct hts221_hw *hw,
+				    enum iio_chan_type ch_type,
+				    int *val, int *val2)
+{
+	s64 tmp;
+	s32 rem, div, data;
+
+	switch (ch_type) {
+	case IIO_HUMIDITYRELATIVE:
+		data = hw->sensors[HTS221_SENSOR_H].b_gen;
+		div = hw->sensors[HTS221_SENSOR_H].slope;
+		break;
+	case IIO_TEMP:
+		data = hw->sensors[HTS221_SENSOR_T].b_gen;
+		div = hw->sensors[HTS221_SENSOR_T].slope;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tmp = div_s64(data * 1000000000LL, div);
+	tmp = div_s64_rem(tmp, 1000000000LL, &rem);
+
+	*val = tmp;
+	*val2 = rem;
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
+{
+	u8 data[HTS221_DATA_SIZE];
+	int err;
+
+	err = hts221_power_on(hw);
+	if (err < 0)
+		return err;
+
+	msleep(50);
+
+	err = hw->tf->read(hw->dev, addr, sizeof(data), data);
+	if (err < 0)
+		return err;
+
+	hts221_power_off(hw);
+
+	*val = (s16)get_unaligned_le16(data);
+
+	return IIO_VAL_INT;
+}
+
+static int hts221_read_raw(struct iio_dev *iio_dev,
+			   struct iio_chan_spec const *ch,
+			   int *val, int *val2, long mask)
+{
+	struct hts221_hw *hw = iio_priv(iio_dev);
+	int ret;
+
+	ret = iio_device_claim_direct_mode(iio_dev);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = hts221_read_oneshot(hw, ch->address, val);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		ret = hts221_get_sensor_scale(hw, ch->type, val, val2);
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		ret = hts221_get_sensor_offset(hw, ch->type, val, val2);
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = hw->odr;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
+		u8 idx;
+		const struct hts221_avg *avg;
+
+		switch (ch->type) {
+		case IIO_HUMIDITYRELATIVE:
+			avg = &hts221_avg_list[HTS221_SENSOR_H];
+			idx = hw->sensors[HTS221_SENSOR_H].cur_avg_idx;
+			*val = avg->avg_avl[idx].avg;
+			ret = IIO_VAL_INT;
+			break;
+		case IIO_TEMP:
+			avg = &hts221_avg_list[HTS221_SENSOR_T];
+			idx = hw->sensors[HTS221_SENSOR_T].cur_avg_idx;
+			*val = avg->avg_avl[idx].avg;
+			ret = IIO_VAL_INT;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		break;
+	}
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	iio_device_release_direct_mode(iio_dev);
+
+	return ret;
+}
+
+static int hts221_write_raw(struct iio_dev *iio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct hts221_hw *hw = iio_priv(iio_dev);
+	int ret;
+
+	ret = iio_device_claim_direct_mode(iio_dev);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = hts221_update_odr(hw, val);
+		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			ret = hts221_update_avg(hw, HTS221_SENSOR_H, val);
+			break;
+		case IIO_TEMP:
+			ret = hts221_update_avg(hw, HTS221_SENSOR_T, val);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	iio_device_release_direct_mode(iio_dev);
+
+	return ret;
+}
+
+static int hts221_validate_trigger(struct iio_dev *iio_dev,
+				   struct iio_trigger *trig)
+{
+	struct hts221_hw *hw = iio_priv(iio_dev);
+
+	return hw->trig == trig ? 0 : -EINVAL;
+}
+
+static IIO_DEVICE_ATTR(in_humidity_oversampling_ratio_available, S_IRUGO,
+		       hts221_sysfs_rh_oversampling_avail, NULL, 0);
+static IIO_DEVICE_ATTR(in_temp_oversampling_ratio_available, S_IRUGO,
+		       hts221_sysfs_temp_oversampling_avail, NULL, 0);
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hts221_sysfs_sampling_freq);
+
+static struct attribute *hts221_attributes[] = {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_in_humidity_oversampling_ratio_available.dev_attr.attr,
+	&iio_dev_attr_in_temp_oversampling_ratio_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group hts221_attribute_group = {
+	.attrs = hts221_attributes,
+};
+
+static const struct iio_info hts221_info = {
+	.driver_module = THIS_MODULE,
+	.attrs = &hts221_attribute_group,
+	.read_raw = hts221_read_raw,
+	.write_raw = hts221_write_raw,
+	.validate_trigger = hts221_validate_trigger,
+};
+
+static const unsigned long hts221_scan_masks[] = {0x3, 0x0};
+
+int hts221_probe(struct iio_dev *iio_dev)
+{
+	struct hts221_hw *hw = iio_priv(iio_dev);
+	int err;
+	u8 data;
+
+	mutex_init(&hw->lock);
+
+	err = hts221_check_whoami(hw);
+	if (err < 0)
+		return err;
+
+	hw->odr = hts221_odr_table[0].hz;
+
+	iio_dev->modes = INDIO_DIRECT_MODE;
+	iio_dev->dev.parent = hw->dev;
+	iio_dev->available_scan_masks = hts221_scan_masks;
+	iio_dev->channels = hts221_channels;
+	iio_dev->num_channels = ARRAY_SIZE(hts221_channels);
+	iio_dev->name = HTS221_DEV_NAME;
+	iio_dev->info = &hts221_info;
+
+	/* configure humidity sensor */
+	err = hts221_parse_rh_caldata(hw);
+	if (err < 0) {
+		dev_err(hw->dev, "failed to get rh calibration data\n");
+		return err;
+	}
+
+	data = hts221_avg_list[HTS221_SENSOR_H].avg_avl[3].avg;
+	err = hts221_update_avg(hw, HTS221_SENSOR_H, data);
+	if (err < 0) {
+		dev_err(hw->dev, "failed to set rh oversampling ratio\n");
+		return err;
+	}
+
+	/* configure temperature sensor */
+	err = hts221_parse_temp_caldata(hw);
+	if (err < 0) {
+		dev_err(hw->dev,
+			"failed to get temperature calibration data\n");
+		return err;
+	}
+
+	data = hts221_avg_list[HTS221_SENSOR_T].avg_avl[3].avg;
+	err = hts221_update_avg(hw, HTS221_SENSOR_T, data);
+	if (err < 0) {
+		dev_err(hw->dev,
+			"failed to set temperature oversampling ratio\n");
+		return err;
+	}
+
+	if (hw->irq > 0) {
+		err = hts221_allocate_buffers(hw);
+		if (err < 0)
+			return err;
+
+		err = hts221_allocate_triggers(hw);
+		if (err)
+			return err;
+	}
+
+	return devm_iio_device_register(hw->dev, iio_dev);
+}
+EXPORT_SYMBOL(hts221_probe);
+
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics hts221 sensor driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
new file mode 100644
index 0000000..367ecd5
--- /dev/null
+++ b/drivers/iio/humidity/hts221_i2c.c
@@ -0,0 +1,110 @@
+/*
+ * STMicroelectronics hts221 i2c driver
+ *
+ * Copyright 2016 STMicroelectronics Inc.
+ *
+ * Lorenzo Bianconi <lorenzo.bianconi@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include "hts221.h"
+
+#define I2C_AUTO_INCREMENT	0x80
+
+static int hts221_i2c_read(struct device *dev, u8 addr, int len, u8 *data)
+{
+	struct i2c_msg msg[2];
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (len > 1)
+		addr |= I2C_AUTO_INCREMENT;
+
+	msg[0].addr = client->addr;
+	msg[0].flags = client->flags;
+	msg[0].len = 1;
+	msg[0].buf = &addr;
+
+	msg[1].addr = client->addr;
+	msg[1].flags = client->flags | I2C_M_RD;
+	msg[1].len = len;
+	msg[1].buf = data;
+
+	return i2c_transfer(client->adapter, msg, 2);
+}
+
+static int hts221_i2c_write(struct device *dev, u8 addr, int len, u8 *data)
+{
+	u8 send[len + 1];
+	struct i2c_msg msg;
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (len > 1)
+		addr |= I2C_AUTO_INCREMENT;
+
+	send[0] = addr;
+	memcpy(&send[1], data, len * sizeof(u8));
+
+	msg.addr = client->addr;
+	msg.flags = client->flags;
+	msg.len = len + 1;
+	msg.buf = send;
+
+	return i2c_transfer(client->adapter, &msg, 1);
+}
+
+static const struct hts221_transfer_function hts221_transfer_fn = {
+	.read = hts221_i2c_read,
+	.write = hts221_i2c_write,
+};
+
+static int hts221_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct hts221_hw *hw;
+	struct iio_dev *iio_dev;
+
+	iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*hw));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, iio_dev);
+
+	hw = iio_priv(iio_dev);
+	hw->name = client->name;
+	hw->dev = &client->dev;
+	hw->irq = client->irq;
+	hw->tf = &hts221_transfer_fn;
+
+	return hts221_probe(iio_dev);
+}
+
+static const struct of_device_id hts221_i2c_of_match[] = {
+	{ .compatible = "st,hts221", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hts221_i2c_of_match);
+
+static const struct i2c_device_id hts221_i2c_id_table[] = {
+	{ HTS221_DEV_NAME },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, hts221_i2c_id_table);
+
+static struct i2c_driver hts221_driver = {
+	.driver = {
+		.name = "hts221_i2c",
+		.of_match_table = of_match_ptr(hts221_i2c_of_match),
+	},
+	.probe = hts221_i2c_probe,
+	.id_table = hts221_i2c_id_table,
+};
+module_i2c_driver(hts221_driver);
+
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics hts221 i2c driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts221_spi.c
new file mode 100644
index 0000000..70df5e7
--- /dev/null
+++ b/drivers/iio/humidity/hts221_spi.c
@@ -0,0 +1,125 @@
+/*
+ * STMicroelectronics hts221 spi driver
+ *
+ * Copyright 2016 STMicroelectronics Inc.
+ *
+ * Lorenzo Bianconi <lorenzo.bianconi@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include "hts221.h"
+
+#define SENSORS_SPI_READ	0x80
+#define SPI_AUTO_INCREMENT	0x40
+
+static int hts221_spi_read(struct device *dev, u8 addr, int len, u8 *data)
+{
+	int err;
+	struct spi_device *spi = to_spi_device(dev);
+	struct iio_dev *iio_dev = spi_get_drvdata(spi);
+	struct hts221_hw *hw = iio_priv(iio_dev);
+
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = hw->tb.tx_buf,
+			.bits_per_word = 8,
+			.len = 1,
+		},
+		{
+			.rx_buf = hw->tb.rx_buf,
+			.bits_per_word = 8,
+			.len = len,
+		}
+	};
+
+	if (len > 1)
+		addr |= SPI_AUTO_INCREMENT;
+	hw->tb.tx_buf[0] = addr | SENSORS_SPI_READ;
+
+	err = spi_sync_transfer(spi, xfers,  ARRAY_SIZE(xfers));
+	if (err < 0)
+		return err;
+
+	memcpy(data, hw->tb.rx_buf, len * sizeof(u8));
+
+	return len;
+}
+
+static int hts221_spi_write(struct device *dev, u8 addr, int len, u8 *data)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct iio_dev *iio_dev = spi_get_drvdata(spi);
+	struct hts221_hw *hw = iio_priv(iio_dev);
+
+	struct spi_transfer xfers = {
+		.tx_buf = hw->tb.tx_buf,
+		.bits_per_word = 8,
+		.len = len + 1,
+	};
+
+	if (len >= HTS221_TX_MAX_LENGTH)
+		return -ENOMEM;
+
+	if (len > 1)
+		addr |= SPI_AUTO_INCREMENT;
+	hw->tb.tx_buf[0] = addr;
+	memcpy(&hw->tb.tx_buf[1], data, len);
+
+	return spi_sync_transfer(spi, &xfers, 1);
+}
+
+static const struct hts221_transfer_function hts221_transfer_fn = {
+	.read = hts221_spi_read,
+	.write = hts221_spi_write,
+};
+
+static int hts221_spi_probe(struct spi_device *spi)
+{
+	struct hts221_hw *hw;
+	struct iio_dev *iio_dev;
+
+	iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*hw));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, iio_dev);
+
+	hw = iio_priv(iio_dev);
+	hw->name = spi->modalias;
+	hw->dev = &spi->dev;
+	hw->irq = spi->irq;
+	hw->tf = &hts221_transfer_fn;
+
+	return hts221_probe(iio_dev);
+}
+
+static const struct of_device_id hts221_spi_of_match[] = {
+	{ .compatible = "st,hts221", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hts221_spi_of_match);
+
+static const struct spi_device_id hts221_spi_id_table[] = {
+	{ HTS221_DEV_NAME },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, hts221_spi_id_table);
+
+static struct spi_driver hts221_driver = {
+	.driver = {
+		.name = "hts221_spi",
+		.of_match_table = of_match_ptr(hts221_spi_of_match),
+	},
+	.probe = hts221_spi_probe,
+	.id_table = hts221_spi_id_table,
+};
+module_spi_driver(hts221_driver);
+
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics hts221 spi driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

