Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:49823 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116AbaDMTJY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 13 Apr 2014 15:09:24 -0400
Received: by mail-wi0-f173.google.com with SMTP id z2so3128727wiv.6
        for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2014 12:09:23 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/6] iio: st_sensors: announce registered sensors
Date: Sun, 13 Apr 2014 21:08:58 +0200
Message-Id: <1397416143-4396-2-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1397416143-4396-1-git-send-email-linus.walleij@linaro.org>
References: <1397416143-4396-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It is pretty helpful to know already from dmesg that a certain
device is successfully registered, instead of having to browse
sysfs to see if it's actually there.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Denis CIOCCA <denis.ciocca@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/st_accel_core.c       | 3 +++
 drivers/iio/gyro/st_gyro_core.c         | 3 +++
 drivers/iio/magnetometer/st_magn_core.c | 3 +++
 drivers/iio/pressure/st_pressure_core.c | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 38caedc76b98..4e06fcf5b891 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -496,6 +496,9 @@ int st_accel_common_probe(struct iio_dev *indio_dev,
 	if (err)
 		goto st_accel_device_register_error;
 
+	dev_info(&indio_dev->dev, "registered accelerometer %s\n",
+		 indio_dev->name);
+
 	return 0;
 
 st_accel_device_register_error:
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index a8e174a47bc4..bc71f4d1e2ce 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -344,6 +344,9 @@ int st_gyro_common_probe(struct iio_dev *indio_dev,
 	if (err)
 		goto st_gyro_device_register_error;
 
+	dev_info(&indio_dev->dev, "registered gyroscope %s\n",
+		 indio_dev->name);
+
 	return 0;
 
 st_gyro_device_register_error:
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 52bbcfa1e077..8e33a7682d33 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -387,6 +387,9 @@ int st_magn_common_probe(struct iio_dev *indio_dev,
 	if (err)
 		goto st_magn_device_register_error;
 
+	dev_info(&indio_dev->dev, "registered magnetometer %s\n",
+		 indio_dev->name);
+
 	return 0;
 
 st_magn_device_register_error:
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 7418768ed49c..013becbe8f47 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -474,6 +474,9 @@ int st_press_common_probe(struct iio_dev *indio_dev,
 	if (err)
 		goto st_press_device_register_error;
 
+	dev_info(&indio_dev->dev, "registered pressure sensor %s\n",
+		 indio_dev->name);
+
 	return err;
 
 st_press_device_register_error:
-- 
1.9.0

