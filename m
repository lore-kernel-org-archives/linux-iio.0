Return-Path: <akinobu.mita@gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2] iio: dac: mcp4725: Add basic support for MCP4726
Date: Sat, 26 Dec 2015 21:17:22 +0900
Message-Id: <1451132242-4274-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

MCP4726 is a single channel 12-bit DAC.  We can support MCP4726 with
a little changes to mcp4725 driver.  In power-down mode, they have
different selection of VOUT pull-down registers.

MCP4726 also has features:
 - Output gain options: 1x, 2x
 - Voltage reference selection: VDD, VREF (Unbuffered or Buffered)

But these are not supported in this change. (1x gain, VDD is selected)

datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/22272C.pdf

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
---
* v2
- add two modes to Documentation/ABI/testing/sysfs-bus-iio
  (suggested by Peter Meerwald-Stadler)

 Documentation/ABI/testing/sysfs-bus-iio |  2 +
 drivers/iio/dac/Kconfig                 |  4 +-
 drivers/iio/dac/mcp4725.c               | 87 +++++++++++++++++++++++++--------
 3 files changed, 71 insertions(+), 22 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 0439c2a..8fadd27 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -497,7 +497,9 @@ Description:
 		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
 		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
 		100kohm_to_gnd: connected to ground via an 100kOhm resistor,
+		125kohm_to_gnd: connected to ground via an 125kOhm resistor,
 		500kohm_to_gnd: connected to ground via a 500kOhm resistor,
+		640kohm_to_gnd: connected to ground via a 640kOhm resistor,
 		three_state: left floating.
 		For a list of available output power down options read
 		outX_powerdown_mode_available. If Y is not present the
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index e701e28..5263c51 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -176,11 +176,11 @@ config MAX5821
 	  10 bits DAC.
 
 config MCP4725
-	tristate "MCP4725 DAC driver"
+	tristate "MCP4725/6 DAC driver"
 	depends on I2C
 	---help---
 	  Say Y here if you want to build a driver for the Microchip
-	  MCP 4725 12-bit digital-to-analog converter (DAC) with I2C
+	  MCP 4725/6 12-bit digital-to-analog converter (DAC) with I2C
 	  interface.
 
 	  To compile this driver as a module, choose M here: the module
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 43d1458..fb4b336 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -1,5 +1,5 @@
 /*
- * mcp4725.c - Support for Microchip MCP4725
+ * mcp4725.c - Support for Microchip MCP4725/6
  *
  * Copyright (C) 2012 Peter Meerwald <pmeerw@pmeerw.net>
  *
@@ -134,6 +134,12 @@ static const char * const mcp4725_powerdown_modes[] = {
 	"500kohm_to_gnd"
 };
 
+static const char * const mcp4726_powerdown_modes[] = {
+	"1kohm_to_gnd",
+	"125kohm_to_gnd",
+	"640kohm_to_gnd"
+};
+
 static int mcp4725_get_powerdown_mode(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan)
 {
@@ -182,11 +188,24 @@ static ssize_t mcp4725_write_powerdown(struct iio_dev *indio_dev,
 	return len;
 }
 
-static const struct iio_enum mcp4725_powerdown_mode_enum = {
-	.items = mcp4725_powerdown_modes,
-	.num_items = ARRAY_SIZE(mcp4725_powerdown_modes),
-	.get = mcp4725_get_powerdown_mode,
-	.set = mcp4725_set_powerdown_mode,
+enum {
+	MCP4725,
+	MCP4726,
+};
+
+static const struct iio_enum mcp472x_powerdown_mode_enum[] = {
+	[MCP4725] = {
+		.items = mcp4725_powerdown_modes,
+		.num_items = ARRAY_SIZE(mcp4725_powerdown_modes),
+		.get = mcp4725_get_powerdown_mode,
+		.set = mcp4725_set_powerdown_mode,
+	},
+	[MCP4726] = {
+		.items = mcp4726_powerdown_modes,
+		.num_items = ARRAY_SIZE(mcp4726_powerdown_modes),
+		.get = mcp4725_get_powerdown_mode,
+		.set = mcp4725_set_powerdown_mode,
+	},
 };
 
 static const struct iio_chan_spec_ext_info mcp4725_ext_info[] = {
@@ -196,19 +215,46 @@ static const struct iio_chan_spec_ext_info mcp4725_ext_info[] = {
 		.write = mcp4725_write_powerdown,
 		.shared = IIO_SEPARATE,
 	},
-	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &mcp4725_powerdown_mode_enum),
-	IIO_ENUM_AVAILABLE("powerdown_mode", &mcp4725_powerdown_mode_enum),
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE,
+			&mcp472x_powerdown_mode_enum[MCP4725]),
+	IIO_ENUM_AVAILABLE("powerdown_mode",
+			&mcp472x_powerdown_mode_enum[MCP4725]),
+	{ },
+};
+
+static const struct iio_chan_spec_ext_info mcp4726_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = mcp4725_read_powerdown,
+		.write = mcp4725_write_powerdown,
+		.shared = IIO_SEPARATE,
+	},
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE,
+			&mcp472x_powerdown_mode_enum[MCP4726]),
+	IIO_ENUM_AVAILABLE("powerdown_mode",
+			&mcp472x_powerdown_mode_enum[MCP4726]),
 	{ },
 };
 
-static const struct iio_chan_spec mcp4725_channel = {
-	.type		= IIO_VOLTAGE,
-	.indexed	= 1,
-	.output		= 1,
-	.channel	= 0,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
-	.ext_info	= mcp4725_ext_info,
+static const struct iio_chan_spec mcp472x_channel[] = {
+	[MCP4725] = {
+		.type		= IIO_VOLTAGE,
+		.indexed	= 1,
+		.output		= 1,
+		.channel	= 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.ext_info	= mcp4725_ext_info,
+	},
+	[MCP4726] = {
+		.type		= IIO_VOLTAGE,
+		.indexed	= 1,
+		.output		= 1,
+		.channel	= 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.ext_info	= mcp4726_ext_info,
+	},
 };
 
 static int mcp4725_set_value(struct iio_dev *indio_dev, int val)
@@ -301,7 +347,7 @@ static int mcp4725_probe(struct i2c_client *client,
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &mcp4725_info;
-	indio_dev->channels = &mcp4725_channel;
+	indio_dev->channels = &mcp472x_channel[id->driver_data];
 	indio_dev->num_channels = 1;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
@@ -315,7 +361,7 @@ static int mcp4725_probe(struct i2c_client *client,
 	}
 	pd = (inbuf[0] >> 1) & 0x3;
 	data->powerdown = pd > 0 ? true : false;
-	data->powerdown_mode = pd ? pd-1 : 2; /* 500kohm_to_gnd */
+	data->powerdown_mode = pd ? pd - 1 : 2; /* largest register to gnd */
 	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
 
 	return iio_device_register(indio_dev);
@@ -328,7 +374,8 @@ static int mcp4725_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id mcp4725_id[] = {
-	{ "mcp4725", 0 },
+	{ "mcp4725", MCP4725 },
+	{ "mcp4726", MCP4726 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp4725_id);
@@ -345,5 +392,5 @@ static struct i2c_driver mcp4725_driver = {
 module_i2c_driver(mcp4725_driver);
 
 MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
-MODULE_DESCRIPTION("MCP4725 12-bit DAC");
+MODULE_DESCRIPTION("MCP4725/6 12-bit DAC");
 MODULE_LICENSE("GPL");
-- 
1.9.1
