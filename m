Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47330 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751343Ab3KSPzG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Nov 2013 10:55:06 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Shawn Guo <shawn.guo@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Brian Lilly <brian@crystalfontz.com>,
	Brent-Crosby <brent@crystalfontz.com>, Jim Wall <jimwall@q.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [RFC PATCH 2/3] iio: accel: Add device tree probing for STMicro gyroscopes
Date: Tue, 19 Nov 2013 16:50:32 +0100
Message-Id: <1384876234-1211-3-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add the compatibles supported by the st_sensors library. This uses kind
of a hack, since the st_sensors core will actively check at probe time
that the device name matches the one reported when using old style i2c
probing, and that this name will be different with device tree.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/iio/gyro/st_gyro_i2c.txt   | 20 ++++++++++++++
 drivers/iio/gyro/st_gyro_i2c.c                     | 31 ++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyro/st_gyro_i2c.txt

diff --git a/Documentation/devicetree/bindings/iio/gyro/st_gyro_i2c.txt b/Documentation/devicetree/bindings/iio/gyro/st_gyro_i2c.txt
new file mode 100644
index 000000000000..39e434c80771
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyro/st_gyro_i2c.txt
@@ -0,0 +1,20 @@
+* ST Micro gyroscopes sensors 
+
+Required properties:
+  - compatible : should be either:
+	* "st,l3g4200d"
+	* "st,lsm330-gyro"
+	* "st,lsm330d-gyro"
+	* "st,lsm330dl-gyro"
+	* "st,lsm330dlc-gyro"
+	* "st,l3gd20"
+	* "st,l3gd20h"
+	* "st,l3g4is-ui"
+  - reg : the I2C address of the sensor
+
+Example:
+
+gyro: gyro@6a {
+	compatible = "st,lsm330dlc-gyro";
+	reg = <0x6a>;
+};
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 16b8b8d70bf1..f82c1d9c4be9 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -13,11 +13,25 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
+#include <linux/of_device.h>
 
 #include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_gyro.h"
 
+static const struct of_device_id st_gyro_of_table[] = {
+	{ .compatible = "st,l3g4200d", .data = L3G4200D_GYRO_DEV_NAME },
+	{ .compatible = "st,lsm330-gyro", .data = LSM330_GYRO_DEV_NAME },
+	{ .compatible = "st,lsm330d-gyro", .data = LSM330D_GYRO_DEV_NAME },
+	{ .compatible = "st,lsm330dl-gyro", .data = LSM330DL_GYRO_DEV_NAME },
+	{ .compatible = "st,lsm330dlc-gyro", .data = LSM330DLC_GYRO_DEV_NAME },
+	{ .compatible = "st,l3gd20", .data = L3GD20_GYRO_DEV_NAME },
+	{ .compatible = "st,l3gd20h", .data = L3GD20H_GYRO_DEV_NAME },
+	{ .compatible = "st,l3g4is-ui", .data = L3G4IS_GYRO_DEV_NAME },
+	{},
+};
+MODULE_DEVICE_TABLE(of, st_gyro_of_table);
+
 static int st_gyro_i2c_probe(struct i2c_client *client,
 						const struct i2c_device_id *id)
 {
@@ -34,6 +48,22 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 
 	st_sensors_i2c_configure(indio_dev, client, gdata);
 
+	/*
+	 * If we are probed through DT, st_sensors_i2c_configure will
+	 * fill the indio_dev->name string with the client->name,
+	 * which is the compatible without the vendor prefix.  Since
+	 * compatibles separators are usually "-", and that the
+	 * convention in this driver is using "_", we obviously have a
+	 * problem when the st-sensors core checks that the two
+	 * strings matches. We need to set again the indio_dev->name
+	 * string to the real value used by the core later on.
+	 */
+	if (client->dev.of_node) {
+		const struct of_device_id *device;
+		device = of_match_device(st_gyro_of_table, &client->dev);
+		indio_dev->name = device->data;
+	}
+
 	err = st_gyro_common_probe(indio_dev,
 				(struct st_sensors_platform_data *)&gyro_pdata);
 	if (err < 0)
@@ -66,6 +96,7 @@ static struct i2c_driver st_gyro_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-gyro-i2c",
+		.of_match_table = of_match_ptr(st_gyro_of_table),
 	},
 	.probe = st_gyro_i2c_probe,
 	.remove = st_gyro_i2c_remove,
-- 
1.8.4.2

