Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50914 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760012AbcJ1KAc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Oct 2016 06:00:32 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Mark.Rutland@arm.com
Subject: [PATCH 10/10] staging: iio: tsl2583: add locking to sysfs attributes
Date: Fri, 28 Oct 2016 06:00:21 -0400
Message-Id: <1477648821-3786-11-git-send-email-masneyb@onstation.org>
In-Reply-To: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
References: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

in_illuminance_input_target_show(), in_illuminance_input_target_store(),
in_illuminance_calibrate_store(), and in_illuminance_lux_table_store()
accesses data from the tsl2583_chip struct. Some of these fields can be
modified by other parts of the driver concurrently. This patch adds the
mutex locking to these sysfs attributes.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 98afa5b..49b19f5 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -513,8 +513,13 @@ static ssize_t in_illuminance_input_target_show(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&chip->als_mutex);
+	ret = sprintf(buf, "%d\n", chip->taos_settings.als_cal_target);
+	mutex_unlock(&chip->als_mutex);
 
-	return sprintf(buf, "%d\n", chip->taos_settings.als_cal_target);
+	return ret;
 }
 
 static ssize_t in_illuminance_input_target_store(struct device *dev,
@@ -528,7 +533,9 @@ static ssize_t in_illuminance_input_target_store(struct device *dev,
 	if (kstrtoint(buf, 0, &value) || !value)
 		return -EINVAL;
 
+	mutex_lock(&chip->als_mutex);
 	chip->taos_settings.als_cal_target = value;
+	mutex_unlock(&chip->als_mutex);
 
 	return len;
 }
@@ -538,12 +545,15 @@ static ssize_t in_illuminance_calibrate_store(struct device *dev,
 					      const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int value;
 
 	if (kstrtoint(buf, 0, &value) || value != 1)
 		return -EINVAL;
 
+	mutex_lock(&chip->als_mutex);
 	taos_als_calibrate(indio_dev);
+	mutex_unlock(&chip->als_mutex);
 
 	return len;
 }
@@ -583,6 +593,8 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
 	int value[ARRAY_SIZE(taos_device_lux) * 3 + 1];
 	int n, ret = -EINVAL;
 
+	mutex_lock(&chip->als_mutex);
+
 	get_options(buf, ARRAY_SIZE(value), value);
 
 	/* We now have an array of ints starting at value[1], and
@@ -617,6 +629,8 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
 	ret = len;
 
 done:
+	mutex_unlock(&chip->als_mutex);
+
 	return ret;
 }
 
-- 
2.7.4

