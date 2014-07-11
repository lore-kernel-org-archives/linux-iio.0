Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mta1.parkeon.com ([91.121.43.66]:48242 "EHLO mta1.parkeon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753856AbaGKNG5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 11 Jul 2014 09:06:57 -0400
Subject: [PATCH] iio: mma8452: add DT support
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Date: Fri, 11 Jul 2014 15:06:54 +0200
Message-ID: <20140711130654.22566.53801.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Allow the mma8452 to be described in the device tree.

Since no device specific binding attributes exist the trivial
I2C binding is sufficient to describe the compatible string.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 .../devicetree/bindings/i2c/trivial-devices.txt    |    1 +
 drivers/iio/accel/mma8452.c                        |    6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index b1cb341..1705f36 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -34,6 +34,7 @@ epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
 fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
 fsl,mc13892		MC13892: Power Management Integrated Circuit (PMIC) for i.MX35/51
 fsl,mma8450		MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
+fsl,mma8452		MMA8452Q: 3-axis 12-bit / 8-bit Digital Accelerometer
 fsl,mpr121		MPR121: Proximity Capacitive Touch Sensor Controller
 fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
 gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 61eba5a..6804c2e 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -428,9 +428,15 @@ static const struct i2c_device_id mma8452_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mma8452_id);
 
+static const struct of_device_id mma8452_dt_ids[] = {
+	{ .compatible = "fsl,mma8452" },
+	{ }
+};
+
 static struct i2c_driver mma8452_driver = {
 	.driver = {
 		.name	= "mma8452",
+		.of_match_table = of_match_ptr(mma8452_dt_ids),
 		.pm	= MMA8452_PM_OPS,
 	},
 	.probe = mma8452_probe,

