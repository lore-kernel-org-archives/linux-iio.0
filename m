Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net,
	srinivas.pandruvada@linux.intel.com,
	knaack.h@gmx.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH v4 2/6] iio: imu: kmx61: Add acpi support
Date: Wed,  3 Dec 2014 15:31:49 +0200
Message-Id: <1417613513-28285-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1417613513-28285-1-git-send-email-daniel.baluta@intel.com>
References: <1417613513-28285-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/kmx61.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 5b44371..893f7c8 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -13,10 +13,13 @@
 
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/acpi.h>
+#include <linux/gpio/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
 #define KMX61_DRV_NAME "kmx61"
+#define KMX61_GPIO_NAME "kmx61_int"
 
 #define KMX61_REG_WHO_AM_I	0x00
 
@@ -573,6 +576,44 @@ static const struct iio_info kmx61_mag_info = {
 	.attrs			= &kmx61_mag_attribute_group,
 };
 
+static const char *kmx61_match_acpi_device(struct device *dev)
+{
+	const struct acpi_device_id *id;
+
+	id = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (!id)
+		return NULL;
+	return dev_name(dev);
+}
+
+static int kmx61_gpio_probe(struct i2c_client *client, struct kmx61_data *data)
+{
+	struct device *dev;
+	struct gpio_desc *gpio;
+	int ret;
+
+	if (!client)
+		return -EINVAL;
+
+	dev = &client->dev;
+
+	/* data ready gpio interrupt pin */
+	gpio = devm_gpiod_get_index(dev, KMX61_GPIO_NAME, 0);
+	if (IS_ERR(gpio)) {
+		dev_err(dev, "acpi gpio get index failed\n");
+		return PTR_ERR(gpio);
+	}
+
+	ret = gpiod_direction_input(gpio);
+	if (ret)
+		return ret;
+
+	ret = gpiod_to_irq(gpio);
+
+	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
+	return ret;
+}
+
 static struct iio_dev *kmx61_indiodev_setup(struct kmx61_data *data,
 					    const struct iio_info *info,
 					    const struct iio_chan_spec *chan,
@@ -613,6 +654,13 @@ static int kmx61_probe(struct i2c_client *client,
 
 	mutex_init(&data->lock);
 
+	if (id)
+		name = id->name;
+	else if (ACPI_HANDLE(&client->dev))
+		name = kmx61_match_acpi_device(&client->dev);
+	else
+		return -ENODEV;
+
 	data->acc_indio_dev =
 		kmx61_indiodev_setup(data, &kmx61_acc_info,
 				     kmx61_acc_channels,
@@ -633,6 +681,9 @@ static int kmx61_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	if (client->irq < 0)
+		client->irq = kmx61_gpio_probe(client, data);
+
 	ret = iio_device_register(data->acc_indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to register acc iio device\n");
@@ -668,6 +719,13 @@ static int kmx61_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct acpi_device_id kmx61_acpi_match[] = {
+	{"KMX61021", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(acpi, kmx61_acpi_match);
+
 static const struct i2c_device_id kmx61_id[] = {
 	{"kmx611021", 0},
 	{}
@@ -678,6 +736,7 @@ MODULE_DEVICE_TABLE(i2c, kmx61_id);
 static struct i2c_driver kmx61_driver = {
 	.driver = {
 		.name = KMX61_DRV_NAME,
+		.acpi_match_table = ACPI_PTR(kmx61_acpi_match),
 	},
 	.probe		= kmx61_probe,
 	.remove		= kmx61_remove,
-- 
1.9.1
