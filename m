Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 30/38] staging:iio:gyro:adis16060 drop assign iio_info.driver_module
Date: Mon, 29 May 2017 16:51:46 +0100
Message-Id: <20170529155154.22580-31-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of this is now done via macro magic when
the relevant register call is made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/gyro/adis16060_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 967524583d8a..4e7630caf7d3 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -103,7 +103,6 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info adis16060_info = {
 	.read_raw = adis16060_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_chan_spec adis16060_channels[] = {
-- 
2.13.0
