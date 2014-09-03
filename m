Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34092 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbaICO4d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Sep 2014 10:56:33 -0400
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Karol Wrona <k.wrona@samsung.com>
Subject: [RFC/PATCH 1/6] iio:sensorhub: Add sensorhub common library
Date: Wed, 03 Sep 2014 16:55:45 +0200
Message-id: <1409756150-30889-2-git-send-email-k.wrona@samsung.com>
In-reply-to: <1409756150-30889-1-git-send-email-k.wrona@samsung.com>
References: <1409756150-30889-1-git-send-email-k.wrona@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds common sensorhub library for sensorhub driver and iio drivers
which uses sensorhub MCU to communicate with sensors.

Signed-off-by: Karol Wrona <k.wrona@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/linux/iio/common/ssp_sensors.h |   82 ++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 include/linux/iio/common/ssp_sensors.h

diff --git a/include/linux/iio/common/ssp_sensors.h b/include/linux/iio/common/ssp_sensors.h
new file mode 100644
index 0000000..ca4bdc4
--- /dev/null
+++ b/include/linux/iio/common/ssp_sensors.h
@@ -0,0 +1,82 @@
+/*
+ *  Copyright (C) 2014, Samsung Electronics Co. Ltd. All Rights Reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+#ifndef _SSP_SENSORS_H_
+#define _SSP_SENSORS_H_
+
+#define SSP_TIME_SIZE	4
+
+#define SSP_ACCELEROMETER_SIZE			6
+#define SSP_GYROSCOPE_SIZE			6
+#define	SSP_BIO_HRM_RAW_SIZE			8
+#define	SSP_BIO_HRM_RAW_FAC_SIZE		36
+#define	SSP_BIO_HRM_LIB_SIZE			8
+
+/**
+ * enum ssp_sensor_tyoe - SSP sensor type
+ */
+enum ssp_sensor_type {
+	SSP_ACCELEROMETER_SENSOR = 0,
+	SSP_GYROSCOPE_SENSOR,
+	SSP_GEOMAGNETIC_UNCALIB_SENSOR,
+	SSP_GEOMAGNETIC_RAW,
+	SSP_GEOMAGNETIC_SENSOR,
+	SSP_PRESSURE_SENSOR,
+	SSP_GESTURE_SENSOR,
+	SSP_PROXIMITY_SENSOR,
+	SSP_TEMPERATURE_HUMIDITY_SENSOR,
+	SSP_LIGHT_SENSOR,
+	SSP_PROXIMITY_RAW,
+	SSP_ORIENTATION_SENSOR,
+	SSP_STEP_DETECTOR,
+	SSP_SIG_MOTION_SENSOR,
+	SSP_GYRO_UNCALIB_SENSOR,
+	SSP_GAME_ROTATION_VECTOR,
+	SSP_ROTATION_VECTOR,
+	SSP_STEP_COUNTER,
+	SSP_BIO_HRM_RAW,
+	SSP_BIO_HRM_RAW_FAC,
+	SSP_BIO_HRM_LIB,
+	SSP_SENSOR_MAX,
+};
+
+struct ssp_data;
+
+/**
+ * struct ssp_sensor_data - Sensor object
+ * @process_data:	Callback to feed sensor data.
+ * @destroy:		Callback to destroy and cleanup sensor object.
+ * @prv_data:		Sensor private data.
+ * @type:		Used sensor type.
+ */
+struct ssp_sensor_data {
+	int (*process_data)(struct iio_dev *indio_dev, void *buf,
+			    s64 timestamp);
+	void *prv_data;
+	enum ssp_sensor_type type;
+};
+
+void ssp_register_consumer(struct iio_dev *indio_dev, enum ssp_sensor_type);
+
+int ssp_enable_sensor(struct ssp_data *data, enum ssp_sensor_type type,
+		       u32 delay);
+
+int ssp_disable_sensor(struct ssp_data *data, enum ssp_sensor_type type);
+
+u32 ssp_get_sensor_delay(struct ssp_data *data, enum ssp_sensor_type);
+
+int ssp_change_delay(struct ssp_data *data, enum ssp_sensor_type type,
+		     u32 delay);
+
+#endif /* _SSP_SENSORS_H_ */
-- 
1.7.9.5

