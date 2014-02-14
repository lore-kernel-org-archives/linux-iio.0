Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:49219 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751970AbaBNPQX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2014 10:16:23 -0500
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2922FEF
	for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2014 14:55:23 +0000 (GMT)
Received: from mail7.sgp.st.com (unknown [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 142D81678A
	for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2014 14:55:23 +0000 (GMT)
From: Denis CIOCCA <denis.ciocca@st.com>
To: linux-iio@vger.kernel.org
Cc: Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 2/4] iio:gyro: call device unregister function if common_proble fails
Date: Fri, 14 Feb 2014 15:55:16 +0100
Message-Id: <1392389718-26079-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1392389718-26079-1-git-send-email-denis.ciocca@st.com>
References: <1392389718-26079-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If st_gyro_common_probe function fails, the device must be unregistered.
Used devm_iio_device_unregister function instead of iio_device_unregister
also in the common remove function.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/gyro/st_gyro_core.c | 2 +-
 drivers/iio/gyro/st_gyro_i2c.c  | 6 +++++-
 drivers/iio/gyro/st_gyro_spi.c  | 6 +++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index a8e174a..67f88ed 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -360,7 +360,7 @@ void st_gyro_common_remove(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	devm_iio_device_unregister(gdata->dev, indio_dev);
 	if (gdata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
 
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 23c12f3..41def78 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -37,9 +37,13 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 	err = st_gyro_common_probe(indio_dev,
 				(struct st_sensors_platform_data *)&gyro_pdata);
 	if (err < 0)
-		return err;
+		goto device_unregister;
 
 	return 0;
+
+device_unregister:
+	devm_iio_device_unregister(&client->dev, indio_dev);
+	return err;
 }
 
 static int st_gyro_i2c_remove(struct i2c_client *client)
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index b4ad3be..9fc1a57 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -36,9 +36,13 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 	err = st_gyro_common_probe(indio_dev,
 				(struct st_sensors_platform_data *)&gyro_pdata);
 	if (err < 0)
-		return err;
+		goto device_unregister;
 
 	return 0;
+
+device_unregister:
+	devm_iio_device_unregister(&spi->dev, indio_dev);
+	return err;
 }
 
 static int st_gyro_spi_remove(struct spi_device *spi)
-- 
1.8.5.4

