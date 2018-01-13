Return-Path: <SRS0=o2nv=EI=no-log.org=m.capdeville@kernel.org>
From: Marc CAPDEVILLE <m.capdeville@no-log.org>
To: Kevin Tsai <ktsai@capellamicro.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Marc CAPDEVILLE <m.capdeville@no-log.org>
Subject: [PATCH v7 3/4] iio : Add cm3218 smbus ARA and ACPI support
Date: Sat, 13 Jan 2018 14:37:04 +0100
Message-Id: <20180113133705.25044-3-m.capdeville@no-log.org>
In-Reply-To: <20180113133705.25044-1-m.capdeville@no-log.org>
References: <20180113133705.25044-1-m.capdeville@no-log.org>
List-ID: <linux-iio@vger.kernel.org>

On asus T100, Capella cm3218 chip is implemented as ambiant light
sensor. This chip expose an smbus ARA protocol device on standard
address 0x0c. The chip is not functional before all alerts are
acknowledged.

The driver call i2c_require_smbus_alert() to set the smbus alert
protocol driver on its adapter. If an interrupt resource is given,
we register this irq with the smbus alert driver.
If no irq is given, the driver call i2c_smbus_alert_event() to trigger
the alert process to clear the initial alert event before initializing
cm3218 registers.

Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>
---
 drivers/iio/light/cm32181.c | 94 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index aebf7dd071af..eae5b7cc6878 100644
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
@@ -47,6 +50,9 @@
 #define CM32181_CALIBSCALE_RESOLUTION	1000
 #define MLUX_PER_LUX			1000
 
+#define CM32181_ID			0x81
+#define CM3218_ID			0x18
+
 static const u8 cm32181_reg[CM32181_CONF_REG_NUM] = {
 	CM32181_REG_ADDR_CMD,
 };
@@ -57,6 +63,7 @@ static const int als_it_value[] = {25000, 50000, 100000, 200000, 400000,
 
 struct cm32181_chip {
 	struct i2c_client *client;
+	int chip_id;
 	struct mutex lock;
 	u16 conf_regs[CM32181_CONF_REG_NUM];
 	int calibscale;
@@ -81,7 +88,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
 		return ret;
 
 	/* check device ID */
-	if ((ret & 0xFF) != 0x81)
+	if ((ret & 0xFF) != cm32181->chip_id)
 		return -ENODEV;
 
 	/* Default Values */
@@ -297,12 +304,23 @@ static const struct iio_info cm32181_info = {
 	.attrs			= &cm32181_attribute_group,
 };
 
+static void cm3218_alert(struct i2c_client *client,
+			 enum i2c_alert_protocol type,
+			 unsigned int data)
+{
+	/*
+	 * nothing to do for now.
+	 * This is just here to acknownledge the cm3218 alert.
+	 */
+}
+
 static int cm32181_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct cm32181_chip *cm32181;
 	struct iio_dev *indio_dev;
 	int ret;
+	const struct acpi_device_id *a_id;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*cm32181));
 	if (!indio_dev) {
@@ -322,11 +340,55 @@ static int cm32181_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	/* Lookup for chip ID from platform, ACPI or of device table */
+	if (id) {
+		cm32181->chip_id = id->driver_data;
+	} else if (ACPI_COMPANION(&client->dev)) {
+		a_id = acpi_match_device(client->dev.driver->acpi_match_table,
+					 &client->dev);
+		if (!a_id)
+			return -ENODEV;
+
+		cm32181->chip_id = (int)a_id->driver_data;
+	} else if (client->dev.of_node) {
+		cm32181->chip_id = (int)of_device_get_match_data(&client->dev);
+		if (!cm32181->chip_id)
+			return -ENODEV;
+	} else {
+		return -ENODEV;
+	}
+
+	if (cm32181->chip_id == CM3218_ID) {
+		/* cm3218 chip require an ARA device on his adapter */
+		ret = i2c_require_smbus_alert(client);
+		if (ret < 0)
+			return ret;
+
+		/* If irq is given, register it with the smbus alert driver */
+		if (client->irq > 0) {
+			ret = i2c_smbus_alert_add_irq(client, client->irq);
+			if (ret < 0)
+				return ret;
+		} else {
+			/*
+			 * if no irq is given, acknownledge initial ARA
+			 * event so cm32181_reg_init() will not fail.
+			 */
+			ret = i2c_smbus_alert_event(client);
+			if (ret)
+				return ret;
+		}
+	}
+
 	ret = cm32181_reg_init(cm32181);
 	if (ret) {
 		dev_err(&client->dev,
 			"%s: register init failed\n",
 			__func__);
+
+		if (cm32181->chip_id == CM3218_ID && client->irq)
+			i2c_smbus_alert_free_irq(client, client->irq);
+
 		return ret;
 	}
 
@@ -335,32 +397,58 @@ static int cm32181_probe(struct i2c_client *client,
 		dev_err(&client->dev,
 			"%s: regist device failed\n",
 			__func__);
+
+		if (cm32181->chip_id == CM3218_ID && client->irq)
+			i2c_smbus_alert_free_irq(client, client->irq);
+
 		return ret;
 	}
 
 	return 0;
 }
 
+static int cm32181_remove(struct i2c_client *client)
+{
+	struct cm32181_chip *cm32181 = i2c_get_clientdata(client);
+
+	if (cm32181->chip_id == CM3218_ID && client->irq)
+		i2c_smbus_alert_free_irq(client, client->irq);
+
+	return 0;
+}
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
+	.alert		= cm3218_alert,
 };
 
 module_i2c_driver(cm32181_driver);
-- 
2.11.0
