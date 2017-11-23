Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:47042 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbdKWW7M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Nov 2017 17:59:12 -0500
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] iio: light: add support for UVIS25 sensor
Date: Thu, 23 Nov 2017 23:59:05 +0100
Message-Id: <20171123225906.31838-2-lorenzo.bianconi83@gmail.com>
In-Reply-To: <20171123225906.31838-1-lorenzo.bianconi83@gmail.com>
References: <20171123225906.31838-1-lorenzo.bianconi83@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

add support for STMicroelectronics UVIS25 uv sensor
http://www.st.com/resource/en/datasheet/uvis25.pdf

- continuos mode support
- i2c support
- spi support
- trigger mode support
- system PM support

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
---
 drivers/iio/light/Kconfig          |  24 +++
 drivers/iio/light/Makefile         |   3 +
 drivers/iio/light/st_uvis25.h      |  37 ++++
 drivers/iio/light/st_uvis25_core.c | 360 +++++++++++++++++++++++++++++++++++++
 drivers/iio/light/st_uvis25_i2c.c  |  69 +++++++
 drivers/iio/light/st_uvis25_spi.c  |  68 +++++++
 6 files changed, 561 insertions(+)
 create mode 100644 drivers/iio/light/st_uvis25.h
 create mode 100644 drivers/iio/light/st_uvis25_core.c
 create mode 100644 drivers/iio/light/st_uvis25_i2c.c
 create mode 100644 drivers/iio/light/st_uvis25_spi.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 6a5835fab32e..93fd421b10d7 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -334,6 +334,30 @@ config STK3310
 	 Choosing M will build the driver as a module. If so, the module
 	 will be called stk3310.
 
+config ST_UVIS25
+	tristate "STMicroelectronics UVIS25 sensor driver"
+	depends on (I2C || SPI)
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select ST_UVIS25_I2C if (I2C)
+	select ST_UVIS25_SPI if (SPI_MASTER)
+	help
+	  Say yes here to build support for STMicroelectronics UVIS25
+	  uv sensor
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called st_uvis25.
+
+config ST_UVIS25_I2C
+	tristate
+	depends on ST_UVIS25
+	select REGMAP_I2C
+
+config ST_UVIS25_SPI
+	tristate
+	depends on ST_UVIS25
+	select REGMAP_SPI
+
 config TCS3414
 	tristate "TAOS TCS3414 digital color sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index f0176a800e14..f714067a7816 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -33,6 +33,9 @@ obj-$(CONFIG_RPR0521)		+= rpr0521.o
 obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
 obj-$(CONFIG_SI1145)		+= si1145.o
 obj-$(CONFIG_STK3310)          += stk3310.o
+obj-$(CONFIG_ST_UVIS25)		+= st_uvis25_core.o
+obj-$(CONFIG_ST_UVIS25_I2C)	+= st_uvis25_i2c.o
+obj-$(CONFIG_ST_UVIS25_SPI)	+= st_uvis25_spi.o
 obj-$(CONFIG_TCS3414)		+= tcs3414.o
 obj-$(CONFIG_TCS3472)		+= tcs3472.o
 obj-$(CONFIG_TSL2583)		+= tsl2583.o
diff --git a/drivers/iio/light/st_uvis25.h b/drivers/iio/light/st_uvis25.h
new file mode 100644
index 000000000000..5e970ab480cd
--- /dev/null
+++ b/drivers/iio/light/st_uvis25.h
@@ -0,0 +1,37 @@
+/*
+ * STMicroelectronics uvis25 sensor driver
+ *
+ * Copyright 2017 STMicroelectronics Inc.
+ *
+ * Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#ifndef ST_UVIS25_H
+#define ST_UVIS25_H
+
+#define ST_UVIS25_DEV_NAME		"uvis25"
+
+#include <linux/iio/iio.h>
+
+/**
+ * struct st_uvis25_hw - ST UVIS25 sensor instance
+ * @regmap: Register map of the device.
+ * @trig: The trigger in use by the driver.
+ * @enabled: Status of the sensor (false->off, true->on).
+ * @irq: Device interrupt line (I2C or SPI).
+ */
+struct st_uvis25_hw {
+	struct regmap *regmap;
+
+	struct iio_trigger *trig;
+	bool enabled;
+	int irq;
+};
+
+extern const struct dev_pm_ops st_uvis25_pm_ops;
+
+int st_uvis25_probe(struct device *dev, int irq, struct regmap *regmap);
+
+#endif /* ST_UVIS25_H */
diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
new file mode 100644
index 000000000000..013da48df571
--- /dev/null
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -0,0 +1,360 @@
+/*
+ * STMicroelectronics uvis25 sensor driver
+ *
+ * Copyright 2017 STMicroelectronics Inc.
+ *
+ * Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/iio/sysfs.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/buffer.h>
+#include <linux/regmap.h>
+
+#include "st_uvis25.h"
+
+#define ST_UVIS25_REG_WHOAMI_ADDR	0x0f
+#define ST_UVIS25_REG_WHOAMI_VAL	0xca
+#define ST_UVIS25_REG_CTRL1_ADDR	0x20
+#define ST_UVIS25_REG_ODR_MASK		BIT(0)
+#define ST_UVIS25_REG_BDU_MASK		BIT(1)
+#define ST_UVIS25_REG_CTRL2_ADDR	0x21
+#define ST_UVIS25_REG_BOOT_MASK		BIT(7)
+#define ST_UVIS25_REG_CTRL3_ADDR	0x22
+#define ST_UVIS25_REG_HL_MASK		BIT(7)
+#define ST_UVIS25_REG_STATUS_ADDR	0x27
+#define ST_UVIS25_REG_UV_DA_MASK	BIT(0)
+#define ST_UVIS25_REG_OUT_ADDR		0x28
+
+static const struct iio_chan_spec st_uvis25_channels[] = {
+	{
+		.type = IIO_UVINDEX,
+		.address = ST_UVIS25_REG_OUT_ADDR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 8,
+			.storagebits = 8,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static int st_uvis25_check_whoami(struct st_uvis25_hw *hw)
+{
+	int err, data;
+
+	err = regmap_read(hw->regmap, ST_UVIS25_REG_WHOAMI_ADDR, &data);
+	if (err < 0) {
+		dev_err(regmap_get_device(hw->regmap),
+			"failed to read whoami register\n");
+		return err;
+	}
+
+	if (data != ST_UVIS25_REG_WHOAMI_VAL) {
+		dev_err(regmap_get_device(hw->regmap),
+			"wrong whoami {%02x vs %02x}\n",
+			data, ST_UVIS25_REG_WHOAMI_VAL);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int st_uvis25_set_enable(struct st_uvis25_hw *hw, bool enable)
+{
+	int err;
+
+	err = regmap_update_bits(hw->regmap, ST_UVIS25_REG_CTRL1_ADDR,
+				 ST_UVIS25_REG_ODR_MASK, enable);
+	if (err < 0)
+		return err;
+
+	hw->enabled = enable;
+
+	return 0;
+}
+
+static int st_uvis25_read_oneshot(struct st_uvis25_hw *hw, u8 addr, int *val)
+{
+	int err;
+
+	err = st_uvis25_set_enable(hw, true);
+	if (err < 0)
+		return err;
+
+	msleep(1500);
+
+	/*
+	 * in order to avoid possible race conditions with interrupt
+	 * generation, disable the sensor first and then poll output
+	 * register. That sequence guarantees the interrupt will be reset
+	 * when irq line is unmasked
+	 */
+	err = st_uvis25_set_enable(hw, false);
+	if (err < 0)
+		return err;
+
+	err = regmap_read(hw->regmap, addr, val);
+
+	return err < 0 ? err : IIO_VAL_INT;
+}
+
+static int st_uvis25_read_raw(struct iio_dev *iio_dev,
+			      struct iio_chan_spec const *ch,
+			      int *val, int *val2, long mask)
+{
+	int ret;
+
+	ret = iio_device_claim_direct_mode(iio_dev);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED: {
+		struct st_uvis25_hw *hw = iio_priv(iio_dev);
+
+		/*
+		 * mask irq line during oneshot read since the sensor
+		 * does not export the capability to disable data-ready line
+		 * in the register map and it is enabled by default.
+		 * If the line is unmasked during read_raw() it will be set
+		 * active and never reset since the trigger is disabled
+		 */
+		if (hw->irq > 0)
+			disable_irq(hw->irq);
+		ret = st_uvis25_read_oneshot(hw, ch->address, val);
+		if (hw->irq > 0)
+			enable_irq(hw->irq);
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
+static irqreturn_t st_uvis25_trigger_handler_thread(int irq, void *private)
+{
+	struct st_uvis25_hw *hw = private;
+	int err, status;
+
+	err = regmap_read(hw->regmap, ST_UVIS25_REG_STATUS_ADDR, &status);
+	if (err < 0)
+		return IRQ_HANDLED;
+
+	if (!(status & ST_UVIS25_REG_UV_DA_MASK))
+		return IRQ_NONE;
+
+	iio_trigger_poll_chained(hw->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int st_uvis25_allocate_trigger(struct iio_dev *iio_dev)
+{
+	struct st_uvis25_hw *hw = iio_priv(iio_dev);
+	struct device *dev = regmap_get_device(hw->regmap);
+	bool irq_active_low = false;
+	unsigned long irq_type;
+	int err;
+
+	irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
+
+	switch (irq_type) {
+	case IRQF_TRIGGER_HIGH:
+	case IRQF_TRIGGER_RISING:
+		break;
+	case IRQF_TRIGGER_LOW:
+	case IRQF_TRIGGER_FALLING:
+		irq_active_low = true;
+		break;
+	default:
+		dev_info(dev, "mode %lx unsupported\n", irq_type);
+		return -EINVAL;
+	}
+
+	err = regmap_update_bits(hw->regmap, ST_UVIS25_REG_CTRL3_ADDR,
+				 ST_UVIS25_REG_HL_MASK, irq_active_low);
+	if (err < 0)
+		return err;
+
+	err = devm_request_threaded_irq(dev, hw->irq, NULL,
+					st_uvis25_trigger_handler_thread,
+					irq_type | IRQF_ONESHOT,
+					iio_dev->name, hw);
+	if (err) {
+		dev_err(dev, "failed to request trigger irq %d\n",
+			hw->irq);
+		return err;
+	}
+
+	hw->trig = devm_iio_trigger_alloc(dev, "%s-trigger",
+					  iio_dev->name);
+	if (!hw->trig)
+		return -ENOMEM;
+
+	iio_trigger_set_drvdata(hw->trig, iio_dev);
+	hw->trig->dev.parent = dev;
+
+	return devm_iio_trigger_register(dev, hw->trig);
+}
+
+static int st_uvis25_buffer_preenable(struct iio_dev *iio_dev)
+{
+	return st_uvis25_set_enable(iio_priv(iio_dev), true);
+}
+
+static int st_uvis25_buffer_postdisable(struct iio_dev *iio_dev)
+{
+	return st_uvis25_set_enable(iio_priv(iio_dev), false);
+}
+
+static const struct iio_buffer_setup_ops st_uvis25_buffer_ops = {
+	.preenable = st_uvis25_buffer_preenable,
+	.postenable = iio_triggered_buffer_postenable,
+	.predisable = iio_triggered_buffer_predisable,
+	.postdisable = st_uvis25_buffer_postdisable,
+};
+
+static irqreturn_t st_uvis25_buffer_handler_thread(int irq, void *p)
+{
+	u8 buffer[ALIGN(sizeof(u8), sizeof(s64)) + sizeof(s64)];
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio_dev = pf->indio_dev;
+	struct st_uvis25_hw *hw = iio_priv(iio_dev);
+	int err;
+
+	err = regmap_read(hw->regmap, ST_UVIS25_REG_OUT_ADDR, (int *)buffer);
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
+static int st_uvis25_allocate_buffer(struct iio_dev *iio_dev)
+{
+	struct st_uvis25_hw *hw = iio_priv(iio_dev);
+
+	return devm_iio_triggered_buffer_setup(regmap_get_device(hw->regmap),
+					       iio_dev, NULL,
+					       st_uvis25_buffer_handler_thread,
+					       &st_uvis25_buffer_ops);
+}
+
+static const struct iio_info st_uvis25_info = {
+	.read_raw = st_uvis25_read_raw,
+};
+
+static int st_uvis25_init_sensor(struct st_uvis25_hw *hw)
+{
+	int err;
+
+	err = regmap_update_bits(hw->regmap, ST_UVIS25_REG_CTRL2_ADDR,
+				 ST_UVIS25_REG_BOOT_MASK, 1);
+	if (err < 0)
+		return err;
+
+	msleep(2000);
+
+	return regmap_update_bits(hw->regmap, ST_UVIS25_REG_CTRL1_ADDR,
+				  ST_UVIS25_REG_BDU_MASK, 1);
+}
+
+int st_uvis25_probe(struct device *dev, int irq, struct regmap *regmap)
+{
+	struct st_uvis25_hw *hw;
+	struct iio_dev *iio_dev;
+	int err;
+
+	iio_dev = devm_iio_device_alloc(dev, sizeof(*hw));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, (void *)iio_dev);
+
+	hw = iio_priv(iio_dev);
+	hw->irq = irq;
+	hw->regmap = regmap;
+
+	err = st_uvis25_check_whoami(hw);
+	if (err < 0)
+		return err;
+
+	iio_dev->modes = INDIO_DIRECT_MODE;
+	iio_dev->dev.parent = dev;
+	iio_dev->channels = st_uvis25_channels;
+	iio_dev->num_channels = ARRAY_SIZE(st_uvis25_channels);
+	iio_dev->name = ST_UVIS25_DEV_NAME;
+	iio_dev->info = &st_uvis25_info;
+
+	err = st_uvis25_init_sensor(hw);
+	if (err < 0)
+		return err;
+
+	if (hw->irq > 0) {
+		err = st_uvis25_allocate_buffer(iio_dev);
+		if (err < 0)
+			return err;
+
+		err = st_uvis25_allocate_trigger(iio_dev);
+		if (err)
+			return err;
+	}
+
+	return devm_iio_device_register(dev, iio_dev);
+}
+EXPORT_SYMBOL(st_uvis25_probe);
+
+static int __maybe_unused st_uvis25_suspend(struct device *dev)
+{
+	struct iio_dev *iio_dev = dev_get_drvdata(dev);
+	struct st_uvis25_hw *hw = iio_priv(iio_dev);
+
+	return regmap_update_bits(hw->regmap, ST_UVIS25_REG_CTRL1_ADDR,
+				  ST_UVIS25_REG_ODR_MASK, 0);
+}
+
+static int __maybe_unused st_uvis25_resume(struct device *dev)
+{
+	struct iio_dev *iio_dev = dev_get_drvdata(dev);
+	struct st_uvis25_hw *hw = iio_priv(iio_dev);
+	int err = 0;
+
+	if (hw->enabled)
+		err = regmap_update_bits(hw->regmap, ST_UVIS25_REG_CTRL1_ADDR,
+					 ST_UVIS25_REG_ODR_MASK, 1);
+
+	return err;
+}
+
+const struct dev_pm_ops st_uvis25_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(st_uvis25_suspend, st_uvis25_resume)
+};
+EXPORT_SYMBOL(st_uvis25_pm_ops);
+
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>");
+MODULE_DESCRIPTION("STMicroelectronics uvis25 sensor driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
new file mode 100644
index 000000000000..e49ec46e9bb8
--- /dev/null
+++ b/drivers/iio/light/st_uvis25_i2c.c
@@ -0,0 +1,69 @@
+/*
+ * STMicroelectronics uvis25 i2c driver
+ *
+ * Copyright 2017 STMicroelectronics Inc.
+ *
+ * Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+
+#include "st_uvis25.h"
+
+#define I2C_AUTO_INCREMENT	BIT(7)
+
+const struct regmap_config st_uvis25_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.write_flag_mask = I2C_AUTO_INCREMENT,
+	.read_flag_mask = I2C_AUTO_INCREMENT,
+};
+
+static int st_uvis25_i2c_probe(struct i2c_client *client,
+			       const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &st_uvis25_i2c_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
+			(int)PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return st_uvis25_probe(&client->dev, client->irq, regmap);
+}
+
+static const struct of_device_id st_uvis25_i2c_of_match[] = {
+	{ .compatible = "st,uvis25", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, st_uvis25_i2c_of_match);
+
+static const struct i2c_device_id st_uvis25_i2c_id_table[] = {
+	{ ST_UVIS25_DEV_NAME },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, st_uvis25_i2c_id_table);
+
+static struct i2c_driver st_uvis25_driver = {
+	.driver = {
+		.name = "st_uvis25_i2c",
+		.pm = &st_uvis25_pm_ops,
+		.of_match_table = of_match_ptr(st_uvis25_i2c_of_match),
+	},
+	.probe = st_uvis25_i2c_probe,
+	.id_table = st_uvis25_i2c_id_table,
+};
+module_i2c_driver(st_uvis25_driver);
+
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>");
+MODULE_DESCRIPTION("STMicroelectronics uvis25 i2c driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/light/st_uvis25_spi.c b/drivers/iio/light/st_uvis25_spi.c
new file mode 100644
index 000000000000..06e9f7cbe1e7
--- /dev/null
+++ b/drivers/iio/light/st_uvis25_spi.c
@@ -0,0 +1,68 @@
+/*
+ * STMicroelectronics uvis25 spi driver
+ *
+ * Copyright 2017 STMicroelectronics Inc.
+ *
+ * Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+
+#include "st_uvis25.h"
+
+#define SENSORS_SPI_READ	BIT(7)
+#define SPI_AUTO_INCREMENT	BIT(6)
+
+const struct regmap_config st_uvis25_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.read_flag_mask = SENSORS_SPI_READ | SPI_AUTO_INCREMENT,
+	.write_flag_mask = SPI_AUTO_INCREMENT,
+};
+
+static int st_uvis25_spi_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_spi(spi, &st_uvis25_spi_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
+			(int)PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return st_uvis25_probe(&spi->dev, spi->irq, regmap);
+}
+
+static const struct of_device_id st_uvis25_spi_of_match[] = {
+	{ .compatible = "st,uvis25", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, st_uvis25_spi_of_match);
+
+static const struct spi_device_id st_uvis25_spi_id_table[] = {
+	{ ST_UVIS25_DEV_NAME },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, st_uvis25_spi_id_table);
+
+static struct spi_driver st_uvis25_driver = {
+	.driver = {
+		.name = "st_uvis25_spi",
+		.pm = &st_uvis25_pm_ops,
+		.of_match_table = of_match_ptr(st_uvis25_spi_of_match),
+	},
+	.probe = st_uvis25_spi_probe,
+	.id_table = st_uvis25_spi_id_table,
+};
+module_spi_driver(st_uvis25_driver);
+
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>");
+MODULE_DESCRIPTION("STMicroelectronics uvis25 spi driver");
+MODULE_LICENSE("GPL v2");
-- 
2.15.0

