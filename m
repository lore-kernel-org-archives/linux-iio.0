Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:52446 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759608AbcJYT1W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 15:27:22 -0400
From: Paul Kocialkowski <contact@paulk.fr>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH] iio: si7020: Add devicetree support and trivial bindings
Date: Tue, 25 Oct 2016 21:20:10 +0200
Message-Id: <20161025192010.11195-1-contact@paulk.fr>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds devicetree support for the si7020 iio driver. Since it works
well without requiring any additional property, its compatible string is
added to the trivial i2c devices bindings list.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt |  1 +
 drivers/iio/humidity/si7020.c                             | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 5c70ce9..6afba26 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -145,6 +145,7 @@ ricoh,rv5c387a		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 samsung,24ad0xd1	S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
 sgx,vz89x		SGX Sensortech VZ89X Sensors
 sii,s35390a		2-wire CMOS real-time clock
+silabs,si7020		Relative Humidity and Temperature Sensors
 skyworks,sky81452	Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
 st,24c256		i2c serial eeprom  (24cxx)
 st,m41t00		Serial real-time clock (RTC)
diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index ffc2ccf..345a765 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -154,8 +154,17 @@ static const struct i2c_device_id si7020_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, si7020_id);
 
+static const struct of_device_id si7020_dt_ids[] = {
+	{ .compatible = "silabs,si7020" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, si7020_dt_ids);
+
 static struct i2c_driver si7020_driver = {
-	.driver.name	= "si7020",
+	.driver = {
+		.name = "si7020",
+		.of_match_table = of_match_ptr(si7020_dt_ids),
+	},
 	.probe		= si7020_probe,
 	.id_table	= si7020_id,
 };
-- 
2.10.0

