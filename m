Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:24603 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753412AbdKVWzG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Nov 2017 17:55:06 -0500
From: Marc CAPDEVILLE <m.capdeville@no-log.org>
To: Kevin Tsai <ktsai@capellamicro.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc CAPDEVILLE <m.capdeville@no-log.org>
Subject: [PATCH v5 1/2] iio : Add cm3218 smbus ara and acpi support
Date: Wed, 22 Nov 2017 23:52:33 +0100
Message-Id: <20171122225234.954-1-m.capdeville@no-log.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On asus T100, Capella cm3218 chip is implemented as ambiant light
sensor. This chip expose an smbus ARA protocol device on standard
address 0x0c. The chip is not functional before all alerts are
acknowledged.
On asus T100, this device is enumerated on ACPI bus and the description
give two I2C connection. The first is the connection to the ARA device
and the second gives the real address of the device.

So, on device probe,If the i2c address is the ARA address and the
device is enumerated via acpi, we lookup for the real address in
the ACPI resource list and create an i2c dummy device with that address.
If the client address is already the real one, we create an i2c dummy
device for the ara function.

if an interrupt resource is given, we request a treaded interrupt to
acknowledge the smbus alert for cm3218 chip.

Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>
---
v5 :
   - dont use smbus_alert driver anymore
   - implement threaded interrupt to acknowledge alert from cm3218
   - dont touch address in i2c_client structur
   - register new dummy i2c client for second address

v4 :
   - rework acpi i2c adress lookup due to bad commit being sent.

v3 :
   - rework acpi i2c adress lookup
   - comment style cleanup
   - add prefix cm32181_to constantes and macros

v2 :
   - cm3218 support always build
   - Cleanup of unneeded #if statement
   - Beter identifying chip in platform device, acpi and of_device

 drivers/iio/light/cm32181.c | 247 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 239 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index d6fd0dace74f..9b412dbb3248 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -18,6 +18,9 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
 #include <linux/init.h>
+#include <linux/i2c-smbus.h>
+#include <linux/acpi.h>
+#include <linux/of_device.h>
 
 /* Registers Address */
 #define CM32181_REG_ADDR_CMD		0x00
@@ -47,6 +50,11 @@
 #define CM32181_CALIBSCALE_RESOLUTION	1000
 #define MLUX_PER_LUX			1000
 
+#define CM32181_ID			0x81
+#define CM3218_ID			0x18
+
+#define CM3218_ARA_ADDR			0x0c
+
 static const u8 cm32181_reg[CM32181_CONF_REG_NUM] = {
 	CM32181_REG_ADDR_CMD,
 };
@@ -56,7 +64,9 @@ static const int als_it_value[] = {25000, 50000, 100000, 200000, 400000,
 	800000};
 
 struct cm32181_chip {
-	struct i2c_client *client;
+	int chip_id;
+	struct i2c_client *als;
+	struct i2c_client *ara;
 	struct mutex lock;
 	u16 conf_regs[CM32181_CONF_REG_NUM];
 	int calibscale;
@@ -72,7 +82,7 @@ struct cm32181_chip {
  */
 static int cm32181_reg_init(struct cm32181_chip *cm32181)
 {
-	struct i2c_client *client = cm32181->client;
+	struct i2c_client *client = cm32181->als;
 	int i;
 	s32 ret;
 
@@ -81,7 +91,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
 		return ret;
 
 	/* check device ID */
-	if ((ret & 0xFF) != 0x81)
+	if ((ret & 0xFF) != cm32181->chip_id)
 		return -ENODEV;
 
 	/* Default Values */
@@ -138,7 +148,7 @@ static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2)
  */
 static int cm32181_write_als_it(struct cm32181_chip *cm32181, int val)
 {
-	struct i2c_client *client = cm32181->client;
+	struct i2c_client *client = cm32181->als;
 	u16 als_it;
 	int ret, i, n;
 
@@ -175,7 +185,7 @@ static int cm32181_write_als_it(struct cm32181_chip *cm32181, int val)
  */
 static int cm32181_get_lux(struct cm32181_chip *cm32181)
 {
-	struct i2c_client *client = cm32181->client;
+	struct i2c_client *client = cm32181->als;
 	int ret;
 	int als_it;
 	unsigned long lux;
@@ -298,12 +308,107 @@ static const struct iio_info cm32181_info = {
 	.attrs			= &cm32181_attribute_group,
 };
 
+static irqreturn_t cm32181_irq(int irq, void *d)
+{
+	struct cm32181_chip *cm32181 = d;
+	int ret;
+
+	if (cm32181->chip_id == CM3218_ID) {
+		/* this is cm3218 chip, so this irq is from the ara device.
+		 * so acknowledge it
+		 */
+		ret = i2c_smbus_read_byte(cm32181->ara);
+	}
+
+	return IRQ_HANDLED;
+}
+
+#if defined(CONFIG_ACPI)
+/*
+ * Look acpi resources for an i2c address other than smbus ara on same adapter.
+ * When address is found, set client structur then terminate walking acpi
+ * resources.
+ */
+static unsigned int cm3218_acpi_find_i2c_address(struct acpi_resource *ares,
+						 void *data)
+{
+	struct data_S {
+		struct i2c_client *client;
+		unsigned short als_address;
+	} *pdata = data;
+	struct acpi_resource_i2c_serialbus *sb;
+	acpi_status status;
+	acpi_handle adapter_handle;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return AE_OK;
+
+	sb = &ares->data.i2c_serial_bus;
+	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
+		return AE_OK;
+
+	status = acpi_get_handle(ACPI_HANDLE(&pdata->client->dev),
+				 sb->resource_source.string_ptr,
+				 &adapter_handle);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	if (adapter_handle != ACPI_HANDLE(&pdata->client->adapter->dev))
+		return AE_OK;
+
+	if (sb->slave_address == CM3218_ARA_ADDR)
+		return AE_OK;
+
+	/* get the address */
+	pdata->als_address = sb->slave_address;
+
+	/* address found */
+	return AE_CTRL_TERMINATE;
+}
+
+/* Get the real i2c address from acpi resources */
+static int cm3218_acpi_get_als_address(struct i2c_client *client)
+{
+	int ret;
+	struct acpi_handle *client_handle;
+	struct data_S {
+		struct i2c_client *client;
+		unsigned short als_address;
+	} data;
+
+	client_handle = ACPI_HANDLE(&client->dev);
+	if (!client_handle)
+		return -ENODEV;
+
+	data.client = client;
+	data.als_address = 0;
+	ret = acpi_walk_resources(client_handle, METHOD_NAME__CRS,
+				  cm3218_acpi_find_i2c_address,
+				  &data);
+
+	if (ACPI_FAILURE(ret))
+		return ret;
+
+	if (!data.als_address)
+		return -ENODEV;
+
+	return data.als_address;
+}
+#else
+static int cm3218_acpi_get_als_address(struct i2c_client *client)
+{
+	return -ENODEV;
+}
+#endif
+
 static int cm32181_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct cm32181_chip *cm32181;
 	struct iio_dev *indio_dev;
 	int ret;
+	const struct of_device_id *of_id;
+	const struct acpi_device_id *acpi_id;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*cm32181));
 	if (!indio_dev) {
@@ -313,7 +418,6 @@ static int cm32181_probe(struct i2c_client *client,
 
 	cm32181 = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-	cm32181->client = client;
 
 	mutex_init(&cm32181->lock);
 	indio_dev->dev.parent = &client->dev;
@@ -323,11 +427,94 @@ static int cm32181_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	/* Lookup for chip ID from platform, acpi or of device table */
+	if (id) {
+		cm32181->chip_id = id->driver_data;
+	} else if (ACPI_COMPANION(&client->dev)) {
+		acpi_id = acpi_match_device(client->dev.driver->acpi_match_table,
+					    &client->dev);
+		if (!acpi_id)
+			return -ENODEV;
+
+		cm32181->chip_id = (kernel_ulong_t)acpi_id->driver_data;
+	} else if (client->dev.of_node) {
+		of_id = of_match_device(client->dev.driver->of_match_table,
+					&client->dev);
+		if (!of_id)
+			return -ENODEV;
+
+		cm32181->chip_id = (kernel_ulong_t)of_id->data;
+	} else {
+		return -ENODEV;
+	}
+
+	if (cm32181->chip_id == CM3218_ID) {
+		/* cm3218 chip as an internal ARA device.
+		 * So, look for it here.
+		 */
+		if (client->addr == CM3218_ARA_ADDR) {
+			/*
+			 * In case first address is the ARA device
+			 * lookup for a second one in acpi resources if
+			 * this client is enumerated on acpi
+			 */
+			ret = cm3218_acpi_get_als_address(client);
+			if (ret <= 0)
+				return ret;
+
+			/* Create a dummy device for als device address */
+			cm32181->als = i2c_new_dummy(client->adapter, ret);
+			if (!cm32181->als)
+				return -ENODEV;
+
+			/* Link this client to the ara device */
+			cm32181->ara = client;
+		} else {
+			/* Create a dummy device for the ARA device address
+			 * perhaps this will fail, for ex, if an ara device
+			 * is already instantiated on this adapter. So, this
+			 * is ok to fail if no irq is given.
+			 */
+			cm32181->ara = i2c_new_dummy(client->adapter,
+						     CM3218_ARA_ADDR);
+
+			if (!cm32181->ara && client->irq)
+				return -ENODEV;
+
+			/* Link this client to the als device */
+			cm32181->als = client;
+		}
+	} else {
+		/* This is not a cm3218 so link this client to the als device*/
+		cm32181->als = client;
+	}
+
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, cm32181_irq, IRQF_ONESHOT,
+						"cm32181", cm32181);
+		if (ret)
+			return ret;
+	}
+
 	ret = cm32181_reg_init(cm32181);
 	if (ret) {
 		dev_err(&client->dev,
 			"%s: register init failed\n",
 			__func__);
+
+		if (cm32181->chip_id == CM3218_ID) {
+			if (cm32181->als != client) {
+				/* als client is the dummy device */
+				i2c_unregister_device(cm32181->als);
+			}
+
+			if (cm32181->ara != client) {
+				/* ara client is the dummy device */
+				i2c_unregister_device(cm32181->ara);
+			}
+		}
+
 		return ret;
 	}
 
@@ -336,32 +523,76 @@ static int cm32181_probe(struct i2c_client *client,
 		dev_err(&client->dev,
 			"%s: regist device failed\n",
 			__func__);
+
+		if (cm32181->chip_id == CM3218_ID) {
+			if (cm32181->als != client) {
+				/* als client is the dummy device */
+				i2c_unregister_device(cm32181->als);
+			}
+
+			if (cm32181->ara != client) {
+				/* ara client is the dummy device */
+				i2c_unregister_device(cm32181->ara);
+			}
+		}
+
 		return ret;
 	}
 
 	return 0;
 }
 
+static int cm32181_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct cm32181_chip *cm32181 = iio_priv(indio_dev);
+
+	if (cm32181->chip_id == CM3218_ID) {
+		if (cm32181->als != client) {
+			/* als client is the dummy device */
+			i2c_unregister_device(cm32181->als);
+		}
+
+		if (cm32181->ara != client) {
+			/* ara client is the dummy device */
+			i2c_unregister_device(cm32181->ara);
+		}
+	}
+
+	return 0;
+};
+
 static const struct i2c_device_id cm32181_id[] = {
-	{ "cm32181", 0 },
+	{ "cm32181", CM32181_ID },
+	{ "cm3218", CM3218_ID },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, cm32181_id);
 
 static const struct of_device_id cm32181_of_match[] = {
-	{ .compatible = "capella,cm32181" },
+	{ .compatible = "capella,cm32181", (void *)CM32181_ID },
+	{ .compatible = "capella,cm3218",  (void *)CM3218_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, cm32181_of_match);
 
+static const struct acpi_device_id cm32181_acpi_match[] = {
+	{ "CPLM3218", CM3218_ID },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(acpi, cm32181_acpi_match);
+
 static struct i2c_driver cm32181_driver = {
 	.driver = {
 		.name	= "cm32181",
 		.of_match_table = of_match_ptr(cm32181_of_match),
+		.acpi_match_table = ACPI_PTR(cm32181_acpi_match),
 	},
 	.id_table       = cm32181_id,
 	.probe		= cm32181_probe,
+	.remove		= cm32181_remove,
 };
 
 module_i2c_driver(cm32181_driver);
-- 
2.11.0

