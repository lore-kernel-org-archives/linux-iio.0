Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:50185 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752002AbaBNPQw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2014 10:16:52 -0500
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C28E3B4
	for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2014 15:16:49 +0000 (GMT)
Received: from mail7.sgp.st.com (unknown [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 49E2D1696D
	for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2014 15:16:49 +0000 (GMT)
From: Denis CIOCCA <denis.ciocca@st.com>
To: linux-iio@vger.kernel.org
Cc: Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 3/4] iio:magnetometer: call devm_iio_device_free function if common_proble fails
Date: Fri, 14 Feb 2014 16:16:42 +0100
Message-Id: <1392391005-2719-4-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1392391005-2719-1-git-send-email-denis.ciocca@st.com>
References: <1392391005-2719-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If st_magn_common_probe function fails, the device must be freed.
Added devm_iio_device_free also on common_remove function.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/magnetometer/st_magn_core.c | 1 +
 drivers/iio/magnetometer/st_magn_i2c.c  | 6 +++++-
 drivers/iio/magnetometer/st_magn_spi.c  | 6 +++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 52bbcfa..018f01c 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -408,6 +408,7 @@ void st_magn_common_remove(struct iio_dev *indio_dev)
 		st_sensors_deallocate_trigger(indio_dev);
 
 	st_magn_deallocate_ring(indio_dev);
+	devm_iio_device_free(mdata->dev, indio_dev);
 }
 EXPORT_SYMBOL(st_magn_common_remove);
 
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 892e0fe..5e33e2d 100644
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
+	devm_iio_device_free(&client->dev, indio_dev);
+	return err;
 }
 
 static int st_magn_i2c_remove(struct i2c_client *client)
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index a6143ea..09c5845 100644
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
+	devm_iio_device_free(&spi->dev, indio_dev);
+	return err;
 }
 
 static int st_magn_spi_remove(struct spi_device *spi)
-- 
1.8.5.4

