Return-Path: <SRS0=/wsa=AS=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com,
	devicetree@vger.kernel.org
Subject: [PATCH 2/4] iio: common: st_sensors: check odr address value in st_sensors_set_odr()
Date: Sun, 17 Sep 2017 18:17:10 +0200
Message-Id: <20170917161712.14645-3-lorenzo.bianconi@st.com>
In-Reply-To: <20170917161712.14645-1-lorenzo.bianconi@st.com>
References: <20170917161712.14645-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Do not try to configure sample frequency if the sensor do not export
odr register address in register map. That change will be used to
properly support LIS3DHH accel sensor.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 40dfdfc0906b..57db19182e95 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -93,6 +93,9 @@ int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr)
 	struct st_sensor_odr_avl odr_out = {0, 0};
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
+	if (!sdata->sensor_settings->odr.addr)
+		return 0;
+
 	err = st_sensors_match_odr(sdata->sensor_settings, odr, &odr_out);
 	if (err < 0)
 		goto st_sensors_match_odr_error;
-- 
2.14.1
