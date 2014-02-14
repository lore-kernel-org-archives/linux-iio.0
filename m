Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog121.obsmtp.com ([207.126.144.151]:35768 "EHLO
	eu1sys200aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750975AbaBNOz0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2014 09:55:26 -0500
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 43C2A11A
	for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2014 14:55:24 +0000 (GMT)
Received: from mail7.sgp.st.com (unknown [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 36520167A5
	for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2014 14:55:24 +0000 (GMT)
From: Denis CIOCCA <denis.ciocca@st.com>
To: linux-iio@vger.kernel.org
Cc: Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 3/4] iio:magnetometer: call device unregister function if common_proble fails
Date: Fri, 14 Feb 2014 15:55:17 +0100
Message-Id: <1392389718-26079-3-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1392389718-26079-1-git-send-email-denis.ciocca@st.com>
References: <1392389718-26079-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If st_magn_common_probe function fails, the device must be unregistered.
Used devm_iio_device_unregister function instead of iio_device_unregister
also in the common remove function.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/magnetometer/st_magn_core.c | 2 +-
 drivers/iio/magnetometer/st_magn_i2c.c  | 6 +++++-
 drivers/iio/magnetometer/st_magn_spi.c  | 6 +++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 52bbcfa..344b9cd 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -403,7 +403,7 @@ void st_magn_common_remove(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	devm_iio_device_unregister(mdata->dev, indio_dev);
 	if (mdata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
 
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 892e0fe..02c6da1 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -36,9 +36,13 @@ static int st_magn_i2c_probe(struct i2c_client *client,
 
 	err = st_magn_common_probe(indio_dev, NULL);
 	if (err < 0)
-		return err;
+		goto device_unregister;
 
 	return 0;
+
+device_unregister:
+	devm_iio_device_unregister(&client->dev, indio_dev);
+	return err;
 }
 
 static int st_magn_i2c_remove(struct i2c_client *client)
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index a6143ea..5c2f6fa 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -35,9 +35,13 @@ static int st_magn_spi_probe(struct spi_device *spi)
 
 	err = st_magn_common_probe(indio_dev, NULL);
 	if (err < 0)
-		return err;
+		goto device_unregister;
 
 	return 0;
+
+device_unregister:
+	devm_iio_device_unregister(&spi->dev, indio_dev);
+	return err;
 }
 
 static int st_magn_spi_remove(struct spi_device *spi)
-- 
1.8.5.4

