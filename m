Return-Path: <SRS0=l9d5=AA=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linus.walleij@linaro.org,
	lorenzo.bianconi@st.com,
	devicetree@vger.kernel.org
Subject: [PATCH v3 3/5] iio: st_sensors: do not always write enable_axis register
Date: Wed, 30 Aug 2017 13:50:41 +0200
Message-Id: <20170830115043.3738-4-lorenzo.bianconi@st.com>
In-Reply-To: <20170830115043.3738-1-lorenzo.bianconi@st.com>
References: <20170830115043.3738-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

New devices (e.g. LIS2DW12) enable all axis by default and do not export
that capability in register map. Check if the enable_axis register
address has been declared in st_sensor_settings map in order to verify if
the driver needs to enable all sensor axis

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index af702fa8fa84..6657160b5a73 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -221,11 +221,14 @@ EXPORT_SYMBOL(st_sensors_set_enable);
 int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	int err = 0;
 
-	return st_sensors_write_data_with_mask(indio_dev,
+	if (sdata->sensor_settings->enable_axis.addr)
+		err = st_sensors_write_data_with_mask(indio_dev,
 				sdata->sensor_settings->enable_axis.addr,
 				sdata->sensor_settings->enable_axis.mask,
 				axis_enable);
+	return err;
 }
 EXPORT_SYMBOL(st_sensors_set_axis_enable);
 
-- 
2.14.1
