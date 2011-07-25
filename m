Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/3] staging:iio:gyro:adxrs450 fix: wrong variable for IIO_TEMP reading.
Date: Mon, 25 Jul 2011 14:04:30 +0100
Message-Id: <1311599072-14637-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311599072-14637-1-git-send-email-jic23@cam.ac.uk>
References: <1311599072-14637-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Silly mistake during chan_spec conversion.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adxrs450_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 196c172..f65ad49 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -279,7 +279,7 @@ static int adxrs450_read_raw(struct iio_dev *indio_dev,
 						       ADXRS450_TEMP1, &ut);
 			if (ret)
 				break;
-			*val = t;
+			*val = ut;
 			ret = IIO_VAL_INT;
 			break;
 		default:
-- 
1.7.3.4
