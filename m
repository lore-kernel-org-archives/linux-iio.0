Return-Path: <k.wrona@samsung.com>
From: Karol Wrona <k.wrona@samsung.com>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Karol Wrona <wrona.vy@gmail.com>, Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH] iio: common: ssp_sensors: Fix uninitialized warning for
 timestamp
Date: Thu, 16 Apr 2015 11:30:23 +0200
Message-id: <1429176624-19223-1-git-send-email-k.wrona@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

calculated_time variable caused warning as uninitialized.  It was not harmful
because it was evaluated in the path in which was used later but it is to
satisfy the checkers.

Signed-off-by: Karol Wrona <k.wrona@samsung.com>
---
 drivers/iio/common/ssp_sensors/ssp_iio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
index a3ae165..16180e6 100644
--- a/drivers/iio/common/ssp_sensors/ssp_iio.c
+++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
@@ -80,7 +80,7 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
 			    unsigned int len, int64_t timestamp)
 {
 	__le32 time;
-	int64_t calculated_time;
+	int64_t calculated_time = 0;
 	struct ssp_sensor_data *spd = iio_priv(indio_dev);
 
 	if (indio_dev->scan_bytes == 0)
-- 
1.7.9.5
