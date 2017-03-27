Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2nam02on0085.outbound.protection.outlook.com ([104.47.38.85]:53205
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751457AbdC0HWz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Mar 2017 03:22:55 -0400
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH v2] iio:adc: Driver for Linear Technology LTC2497 ADC
Date: Mon, 27 Mar 2017 09:23:53 +0200
Message-ID: <1490599433-6103-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

This patch adds support for the Analog Devices / Linear Technology
LTC2497 ADCs. The LTC2497 is a 16-channel (eight differential),
16-bit, high precision, delta-sigma ADC with an automatic, differential,
input current cancellation front end and a 2-wire, I2C interface.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

---

Changes since v1:

 - remove confusing kconfig help text
 - use proper defines
 - add descriptive comment
 - fix removal order
 - add poper commit mssage
---
 .../devicetree/bindings/iio/adc/ltc2497.txt        |  13 +
 MAINTAINERS                                        |   1 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ltc2497.c                          | 269 +++++++++++++++++++++
 5 files changed, 294 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ltc2497.txt
 create mode 100644 drivers/iio/adc/ltc2497.c

diff --git a/Documentation/devicetree/bindings/iio/adc/ltc2497.txt b/Documentation/devicetree/bindings/iio/adc/ltc2497.txt
new file mode 100644
index 0000000..c2829c19
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ltc2497.txt
@@ -0,0 +1,13 @@
+* Linear Technology / Analog Devices LTC2497 ADC
+
+Required properties:
+ - compatible: Should be "lltc,ltc2497"
+ - reg: Should contain the ADC I2C address
+ - vref-supply: The regulator supply for ADC reference voltage
+
+Example:
+	ltc2497: adc@76 {
+		compatible = "lltc,ltc2497";
+		reg = <0x76>;
+		vref-supply = <&ltc2497_reg>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index a7d6f9a..173043c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -813,6 +813,7 @@ W:	http://wiki.analog.com/
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/*/ad*
+F:	drivers/iio/adc/ltc2497*
 X:	drivers/iio/*/adjd*
 F:	drivers/staging/iio/*/ad*
 F:	drivers/staging/iio/trigger/iio-trig-bfin-timer.c
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 2268a6f..acc115b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -326,6 +326,16 @@ config LTC2485
 	  To compile this driver as a module, choose M here: the module will be
 	  called ltc2485.
 
+config LTC2497
+	tristate "Linear Technology LTC2497 ADC driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Linear Technology LTC2497
+	  16-Bit 8-/16-Channel Delta Sigma ADC.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ltc2497.
+
 config MAX1027
 	tristate "Maxim max1027 ADC driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 73dbe39..9d626b5 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
 obj-$(CONFIG_LTC2485) += ltc2485.o
+obj-$(CONFIG_LTC2497) += ltc2497.o
 obj-$(CONFIG_MAX1027) += max1027.o
 obj-$(CONFIG_MAX11100) += max11100.o
 obj-$(CONFIG_MAX1363) += max1363.o
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
new file mode 100644
index 0000000..7907534
--- /dev/null
+++ b/drivers/iio/adc/ltc2497.c
@@ -0,0 +1,269 @@
+/*
+ * ltc2497.c - Driver for Linear Technology LTC2497 ADC
+ *
+ * Copyright (C) 2017 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ *
+ * Datasheet: http://cds.linear.com/docs/en/datasheet/2497fd.pdf
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/regulator/consumer.h>
+#include <linux/of.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define LTC2497_ENABLE			0xA0
+#define LTC2497_SGL			(1 << 4)
+#define LTC2497_DIFF			(0 << 4)
+#define LTC2497_SIGN			(1 << 3)
+#define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
+#define LTC2497_CONVERSION_TIME_MS	150ULL
+
+struct ltc2497_st {
+	struct i2c_client *client;
+	struct regulator *ref;
+	ktime_t	time_prev;
+	u8 addr_prev;
+};
+
+static int ltc2497_wait_conv(struct ltc2497_st *st)
+{
+	s64 time_elapsed;
+
+	time_elapsed = ktime_ms_delta(ktime_get(), st->time_prev);
+
+	if (time_elapsed < LTC2497_CONVERSION_TIME_MS) {
+		/* delay if conversion time not passed
+		 * since last read or write
+		 */
+		msleep(LTC2497_CONVERSION_TIME_MS - time_elapsed);
+		return 0;
+	}
+
+	if (time_elapsed - LTC2497_CONVERSION_TIME_MS <= 0) {
+		/* We're in automatic mode -
+		 * so the last reading is stil not outdated
+		 */
+		return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int ltc2497_read(struct ltc2497_st *st, u8 address, int *val)
+{
+	struct i2c_client *client = st->client;
+	__be32 buf = 0;
+	int ret;
+
+	ret = ltc2497_wait_conv(st);
+	if (ret < 0 || st->addr_prev != address) {
+		ret = i2c_smbus_write_byte(st->client,
+					   LTC2497_ENABLE | address);
+		if (ret < 0)
+			return ret;
+		st->addr_prev = address;
+		msleep(LTC2497_CONVERSION_TIME_MS);
+	}
+	ret = i2c_master_recv(client, (char *)&buf, 3);
+	if (ret < 0)  {
+		dev_err(&client->dev, "i2c_master_recv failed\n");
+		return ret;
+	}
+	st->time_prev = ktime_get();
+
+	/* convert and shift the result,
+	 * and finally convert from offset binary to signed integer
+	 */
+	*val = (be32_to_cpu(buf) >> 14) - (1 << 17);
+
+	return ret;
+}
+
+static int ltc2497_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ltc2497_st *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&indio_dev->mlock);
+		ret = ltc2497_read(st, chan->address, val);
+		mutex_unlock(&indio_dev->mlock);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = regulator_get_voltage(st->ref);
+		if (ret < 0)
+			return ret;
+
+		*val = ret / 1000;
+		*val2 = 17;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+#define LTC2497_CHAN(_chan, _addr) { \
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.channel = (_chan), \
+	.address = (_addr | (_chan / 2) | ((_chan & 1) ? LTC2497_SIGN : 0)), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+#define LTC2497_CHAN_DIFF(_chan, _addr) { \
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.channel = (_chan) * 2 + ((_addr) & LTC2497_SIGN ? 1 : 0), \
+	.channel2 = (_chan) * 2 + ((_addr) & LTC2497_SIGN ? 0 : 1),\
+	.address = (_addr | _chan), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+	.differential = 1, \
+}
+
+static const struct iio_chan_spec ltc2497_channel[] = {
+	LTC2497_CHAN(0, LTC2497_SGL),
+	LTC2497_CHAN(1, LTC2497_SGL),
+	LTC2497_CHAN(2, LTC2497_SGL),
+	LTC2497_CHAN(3, LTC2497_SGL),
+	LTC2497_CHAN(4, LTC2497_SGL),
+	LTC2497_CHAN(5, LTC2497_SGL),
+	LTC2497_CHAN(6, LTC2497_SGL),
+	LTC2497_CHAN(7, LTC2497_SGL),
+	LTC2497_CHAN(8, LTC2497_SGL),
+	LTC2497_CHAN(9, LTC2497_SGL),
+	LTC2497_CHAN(10, LTC2497_SGL),
+	LTC2497_CHAN(11, LTC2497_SGL),
+	LTC2497_CHAN(12, LTC2497_SGL),
+	LTC2497_CHAN(13, LTC2497_SGL),
+	LTC2497_CHAN(14, LTC2497_SGL),
+	LTC2497_CHAN(15, LTC2497_SGL),
+	LTC2497_CHAN_DIFF(0, LTC2497_DIFF),
+	LTC2497_CHAN_DIFF(1, LTC2497_DIFF),
+	LTC2497_CHAN_DIFF(2, LTC2497_DIFF),
+	LTC2497_CHAN_DIFF(3, LTC2497_DIFF),
+	LTC2497_CHAN_DIFF(4, LTC2497_DIFF),
+	LTC2497_CHAN_DIFF(5, LTC2497_DIFF),
+	LTC2497_CHAN_DIFF(6, LTC2497_DIFF),
+	LTC2497_CHAN_DIFF(7, LTC2497_DIFF),
+	LTC2497_CHAN_DIFF(0, LTC2497_DIFF | LTC2497_SIGN),
+	LTC2497_CHAN_DIFF(1, LTC2497_DIFF | LTC2497_SIGN),
+	LTC2497_CHAN_DIFF(2, LTC2497_DIFF | LTC2497_SIGN),
+	LTC2497_CHAN_DIFF(3, LTC2497_DIFF | LTC2497_SIGN),
+	LTC2497_CHAN_DIFF(4, LTC2497_DIFF | LTC2497_SIGN),
+	LTC2497_CHAN_DIFF(5, LTC2497_DIFF | LTC2497_SIGN),
+	LTC2497_CHAN_DIFF(6, LTC2497_DIFF | LTC2497_SIGN),
+	LTC2497_CHAN_DIFF(7, LTC2497_DIFF | LTC2497_SIGN),
+};
+
+static const struct iio_info ltc2497_info = {
+	.read_raw = ltc2497_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static int ltc2497_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct ltc2497_st *st;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
+				     I2C_FUNC_SMBUS_WRITE_BYTE))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	st->client = client;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = id->name;
+	indio_dev->info = &ltc2497_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ltc2497_channel;
+	indio_dev->num_channels = ARRAY_SIZE(ltc2497_channel);
+
+	st->ref = devm_regulator_get(&client->dev, "vref");
+	if (IS_ERR(st->ref))
+		return PTR_ERR(st->ref);
+
+	ret = regulator_enable(st->ref);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte(st->client, LTC2497_CONFIG_DEFAULT);
+	if (ret < 0)
+		goto err_regulator_disable;
+
+	st->addr_prev = LTC2497_CONFIG_DEFAULT;
+	st->time_prev = ktime_get();
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto err_regulator_disable;
+
+	return 0;
+
+err_regulator_disable:
+	regulator_disable(st->ref);
+
+	return ret;
+}
+
+static int ltc2497_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ltc2497_st *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	regulator_disable(st->ref);
+
+	return 0;
+}
+
+static const struct i2c_device_id ltc2497_id[] = {
+	{ "ltc2497", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ltc2497_id);
+
+static const struct of_device_id ltc2497_of_match[] = {
+	{ .compatible = "lltc,ltc2497", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ltc2497_of_match);
+
+static struct i2c_driver ltc2497_driver = {
+	.driver = {
+		.name = "ltc2497",
+		.of_match_table = of_match_ptr(ltc2497_of_match),
+	},
+	.probe = ltc2497_probe,
+	.remove = ltc2497_remove,
+	.id_table = ltc2497_id,
+};
+module_i2c_driver(ltc2497_driver);
+
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_DESCRIPTION("Linear Technology LTC2497 ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

