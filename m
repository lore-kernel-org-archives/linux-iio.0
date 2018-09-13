Return-Path: <SRS0=CzA9=L3=gmail.com=songqiang1304521@kernel.org>
From: Song Qiang <songqiang1304521@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	andriy.shevchenko@linux.intel.com,
	matt.ranostay@konsulko.com,
	tglx@linutronix.de,
	himanshujha199640@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Qiang <songqiang.1304521@gmail.com>
Subject: [PATCH] iio: proximity: Add driver support for ST's VL53L0X ToF ranging sensor.
Date: Thu, 13 Sep 2018 10:22:29 +0800
Message-Id: <20180913022229.21563-1-songqiang.1304521@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This driver was originally written by ST in 2016 as a misc input device
driver, and hasn't been maintained for a long time. I grabbed some code
from it's API and reformed it into a iio proximity device driver.
This version of driver uses i2c bus to talk to the sensor and
polling for measuring completes, so no irq line is needed.
This version of driver supports only one-shot mode, and it can be
tested with reading from
/sys/bus/iio/devices/iio:deviceX/in_distance_raw

Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
---
Changes in v2:
	- Clean up the register table.
	- Sort header files declarations.
	- Replace some bit definations with GENMASK() and BIT().
	- Clean up some code and comments that's useless for now.
	- Change the order of some the definations of some variables to reversed
	  xmas tree order.
	- Using do...while() rather while and check.
	- Replace pr_err() with dev_err().
	- Remove device id declaration since we recommend to use DT.
	- Remove .owner = THIS_MODULE.
	- Replace probe() with probe_new() hook.
	- Remove IIO_BUFFER and IIO_TRIGGERED_BUFFER dependences.
	- Change the driver module name to vl53l0x-i2c.
	- Align all the parameters if they are in the same function with open
	  parentheses.
	- Replace iio_device_register() with devm_iio_device_register
	  for better resource management.
	- Remove the vl53l0x_remove() since it's not needed.
	- Remove dev_set_drvdata() since it's already setted above.

Changes in v3:
	- Recover ST's copyright.
	- Clean up indio_dev member in vl53l0x_data struct since it's
	  useless now.
	- Replace __le16_to_cpu() with le16_to_cpu().
	- Remove the iio_device_{claim|release}_direct_mode() since it's
	  only needed when we use buffered mode.
	- Clean up some coding style problems.

Changes in v4:
	- Add datasheet link, default i2c address and TODO list.
	- Make capitalization of defines consistent.
	- Replace i2c_transfer() with i2c_smbus_read_i2c_block_data().
	- Remove IIO_CHAN_SOFT_TIMESTAMP() since no buffer/trigger
	  support.
	- Add information to MAINTAINERS.

 .../bindings/iio/proximity/vl53l0x.txt        |  12 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/proximity/Kconfig                 |  11 ++
 drivers/iio/proximity/Makefile                |   2 +
 drivers/iio/proximity/vl53l0x-i2c.c           | 178 ++++++++++++++++++
 5 files changed, 210 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
 create mode 100644 drivers/iio/proximity/vl53l0x-i2c.c

diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
new file mode 100644
index 000000000000..64b69442f08e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
@@ -0,0 +1,12 @@
+ST's VL53L0X ToF ranging sensor
+
+Required properties:
+	- compatible: must be "st,vl53l0x-i2c"
+	- reg: i2c address where to find the device
+
+Example:
+
+vl53l0x@29 {
+	compatible = "st,vl53l0x-i2c";
+	reg = <0x29>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 967ce8cdd1cc..a35d80e63506 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13510,6 +13510,13 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-stm32*
 
+ST VL53L0X ToF RANGER(I2C) IIO DRIVER
+M:	Song Qiang <songqiang.1304521@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/proximity/vl53l0x-i2c.c
+F:	Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
+
 STABLE BRANCH
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 L:	stable@vger.kernel.org
diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index f726f9427602..5f421cbd37f3 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -79,4 +79,15 @@ config SRF08
 	  To compile this driver as a module, choose M here: the
 	  module will be called srf08.
 
+config VL53L0X_I2C
+	tristate "STMicroelectronics VL53L0X ToF ranger sensor (I2C)"
+	depends on I2C
+	help
+	  Say Y here to build a driver for STMicroelectronics VL53L0X
+	  ToF ranger sensors with i2c interface.
+	  This driver can be used to measure the distance of objects.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called vl53l0x-i2c.
+
 endmenu
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index 4f4ed45e87ef..dedfb5bf3475 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_RFD77402)		+= rfd77402.o
 obj-$(CONFIG_SRF04)		+= srf04.o
 obj-$(CONFIG_SRF08)		+= srf08.o
 obj-$(CONFIG_SX9500)		+= sx9500.o
+obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
+
diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
new file mode 100644
index 000000000000..9f0357231a36
--- /dev/null
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Support for ST's VL53L0X FlightSense ToF Ranger Sensor on a i2c bus.
+ *
+ * Copyright (C) 2016 STMicroelectronics Imaging Division.
+ * Copyright (C) 2018 Song Qiang <songqiang.1304521@gmail.com>
+ *
+ * Datasheet available at
+ * <https://www.st.com/resource/en/datasheet/vl53l0x.pdf>
+ * Default 7-bit I2C slave address 0x29.
+ *
+ * TODO: FIFO buffer, continuous mode, interrupts, range selection.
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#define VL53L0X_DRV_NAME				"vl53l0x-i2c"
+
+#define VL_REG_SYSRANGE_MODE_MASK			GENMASK(3, 0)
+#define VL_REG_SYSRANGE_START				0x00
+#define VL_REG_SYSRANGE_MODE_SINGLESHOT			0x00
+#define VL_REG_SYSRANGE_MODE_START_STOP			BIT(0)
+#define VL_REG_SYSRANGE_MODE_BACKTOBACK			BIT(1)
+#define VL_REG_SYSRANGE_MODE_TIMED			BIT(2)
+#define VL_REG_SYSRANGE_MODE_HISTOGRAM			BIT(3)
+
+#define VL_REG_SYS_SEQUENCE_CFG				BIT(0)
+#define VL_REG_SYS_INTERMEASUREMENT_PERIOD		BIT(2)
+#define VL_REG_SYS_RANGE_CFG				0x09
+
+#define VL_REG_SYS_INT_GPIO_DISABLED			0x00
+#define VL_REG_SYS_INT_GPIO_LEVEL_LOW			BIT(0)
+#define VL_REG_SYS_INT_GPIO_LEVEL_HIGH			BIT(1)
+#define VL_REG_SYS_INT_GPIO_OUT_OF_WINDOW		0x03
+#define VL_REG_SYS_INT_GPIO_NEW_SAMPLE_READY		BIT(2)
+#define VL_REG_SYS_INT_CFG_GPIO				0x0A
+#define VL_REG_SYS_INT_CLEAR				0x0B
+#define VL_REG_GPIO_HV_MUX_ACTIVE_HIGH			0x84
+
+#define VL_REG_RESULT_INT_STATUS			0x13
+#define VL_REG_RESULT_RANGE_STATUS			0x14
+#define VL_REG_RESULT_RANGE_SATTUS_COMPLETE		BIT(0)
+
+#define VL_REG_I2C_SLAVE_DEVICE_ADDRESS			0x8A
+
+#define VL_REG_IDENTIFICATION_MODEL_ID			0xC0
+#define VL_REG_IDENTIFICATION_REVISION_ID		0xC2
+
+struct vl53l0x_data {
+	struct i2c_client *client;
+};
+
+static int vl53l0x_read_proximity(struct vl53l0x_data *data,
+				  const struct iio_chan_spec *chan,
+				  int *val)
+{
+	struct i2c_client *client = data->client;
+	unsigned int tries = 20;
+	u8 buffer[12];
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client,
+					VL_REG_SYSRANGE_START, 1);
+	if (ret < 0)
+		return ret;
+
+	do {
+		ret = i2c_smbus_read_byte_data(client,
+					       VL_REG_RESULT_RANGE_STATUS);
+		if (ret < 0)
+			return ret;
+
+		if (ret & VL_REG_RESULT_RANGE_SATTUS_COMPLETE)
+			break;
+
+		usleep_range(1000, 5000);
+	} while (tries--);
+	if (!tries)
+		return -ETIMEDOUT;
+
+	ret = i2c_smbus_read_i2c_block_data(client, VL_REG_RESULT_RANGE_STATUS,
+		12, buffer);
+	if (ret < 0)
+		return ret;
+	else if (ret != 12)
+		return -EREMOTEIO;
+
+	*val = le16_to_cpu((buffer[10] << 8) + buffer[11]);
+
+	return 0;
+}
+
+static const struct iio_chan_spec vl53l0x_channels[] = {
+	{
+		.type = IIO_DISTANCE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
+	},
+};
+
+static int vl53l0x_read_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct vl53l0x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_DISTANCE) {
+		dev_err(&data->client->dev, "iio type error");
+		return -EINVAL;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = vl53l0x_read_proximity(data, chan, val);
+		if (ret < 0)
+			dev_err(&data->client->dev,
+				"raw value read error with %d", ret);
+
+		return IIO_VAL_INT;
+	default:
+		dev_err(&data->client->dev, "IIO_CHAN_* not recognzed.");
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info vl53l0x_info = {
+	.read_raw = vl53l0x_read_raw,
+};
+
+static int vl53l0x_probe(struct i2c_client *client)
+{
+	struct vl53l0x_data *data;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	i2c_set_clientdata(client, indio_dev);
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = VL53L0X_DRV_NAME;
+	indio_dev->info = &vl53l0x_info;
+	indio_dev->channels = vl53l0x_channels;
+	indio_dev->num_channels = ARRAY_SIZE(vl53l0x_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct of_device_id st_vl53l0x_dt_match[] = {
+	{ .compatible = "st,vl53l0x-i2c", },
+	{ }
+};
+
+static struct i2c_driver vl53l0x_driver = {
+	.driver = {
+		.name = VL53L0X_DRV_NAME,
+		.of_match_table = st_vl53l0x_dt_match,
+	},
+	.probe_new = vl53l0x_probe,
+};
+module_i2c_driver(vl53l0x_driver);
+
+MODULE_AUTHOR("Song Qiang <songqiang.1304521@gmail.com>");
+MODULE_DESCRIPTION("ST vl53l0x ToF ranging sensor");
+MODULE_LICENSE("GPL");
-- 
2.17.1
