Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 09/17] iio:st_magn: Remove redundant call to iio_sw_buffer_preenable().
Date: Mon, 14 Oct 2013 18:49:22 +0200
Message-Id: <1381769370-17100-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-1-git-send-email-lars@metafoo.de>
References: <1381769370-17100-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
so there is no need to do this from the driver anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/magnetometer/st_magn_buffer.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index 708857b..bf427dc 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -25,16 +25,7 @@
 
 static int st_magn_buffer_preenable(struct iio_dev *indio_dev)
 {
-	int err;
-
-	err = st_sensors_set_enable(indio_dev, true);
-	if (err < 0)
-		goto st_magn_set_enable_error;
-
-	err = iio_sw_buffer_preenable(indio_dev);
-
-st_magn_set_enable_error:
-	return err;
+	return st_sensors_set_enable(indio_dev, true);
 }
 
 static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
-- 
1.8.0
