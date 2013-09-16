Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:59195 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab3IPQCz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 12:02:55 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so2141097eaj.11
        for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2013 09:02:54 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 17/20] iio: pressure-core: st: Provide support for the Vdd_IO power supply
Date: Mon, 16 Sep 2013 17:02:23 +0100
Message-Id: <1379347346-823-18-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
References: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The power to some of the sensors are controlled by regulators. In most
cases these are 'always on', but if not they will fail to work until
the regulator is enabled using the relevant APIs. This patch allows for
the Vdd_IO power supply to be specified by either platform data or
Device Tree.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/pressure/st_pressure_core.c | 13 ++++++++++++-
 include/linux/iio/common/st_sensors.h   |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index c801c80..e3f3888 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -319,7 +319,7 @@ void st_press_power_enable(struct iio_dev *indio_dev)
 	struct st_sensor_data *pdata = iio_priv(indio_dev);
 	int err;
 
-	/* Regulators not mandatory, but if requested we should enable it. */
+	/* Regulators not mandatory, but if requested we should enable them. */
 	pdata->vdd = devm_regulator_get_optional(&indio_dev->dev, "vdd");
 	if (!IS_ERR(pdata->vdd)) {
 		err = regulator_enable(pdata->vdd);
@@ -327,6 +327,14 @@ void st_press_power_enable(struct iio_dev *indio_dev)
 			dev_warn(&indio_dev->dev,
 				 "Failed to enable specified Vdd supply\n");
 	}
+
+	pdata->vdd_io = devm_regulator_get_optional(&indio_dev->dev, "vddio");
+	if (!IS_ERR(pdata->vdd_io)) {
+		err = regulator_enable(pdata->vdd_io);
+		if (err != 0)
+			dev_warn(&indio_dev->dev,
+				 "Failed to enable specified Vdd_IO supply\n");
+	}
 }
 
 void st_press_power_disable(struct iio_dev *indio_dev)
@@ -335,6 +343,9 @@ void st_press_power_disable(struct iio_dev *indio_dev)
 
 	if (!IS_ERR(pdata->vdd))
 		regulator_disable(pdata->vdd);
+
+	if (!IS_ERR(pdata->vdd_io))
+		regulator_disable(pdata->vdd_io);
 }
 
 int st_press_common_probe(struct iio_dev *indio_dev,
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 968b84e..3c005eb 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -203,6 +203,7 @@ struct st_sensors {
  * @sensor: Pointer to the current sensor struct in use.
  * @current_fullscale: Maximum range of measure by the sensor.
  * @vdd: Pointer to sensor's Vdd power supply
+ * @vdd_io: Pointer to sensor's Vdd-IO power supply
  * @enabled: Status of the sensor (false->off, true->on).
  * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
  * @buffer_data: Data used by buffer part.
@@ -219,6 +220,7 @@ struct st_sensor_data {
 	struct st_sensors *sensor;
 	struct st_sensor_fullscale_avl *current_fullscale;
 	struct regulator *vdd;
+	struct regulator *vdd_io;
 
 	bool enabled;
 	bool multiread_bit;
-- 
1.8.1.2

