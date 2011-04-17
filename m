Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 60/70] staging:iio: Add chan info support for 'peak_raw' attributes.
Date: Sun, 17 Apr 2011 20:06:33 +0100
Message-Id: <1303067203-4894-61-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    6 +++++-
 drivers/staging/iio/industrialio-core.c |    2 ++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index febf20e..4946006 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -57,7 +57,11 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_CALIBSCALE_SHARED,
 	IIO_CHAN_INFO_CALIBSCALE_SEPARATE,
 	IIO_CHAN_INFO_CALIBBIAS_SHARED,
-	IIO_CHAN_INFO_CALIBBIAS_SEPARATE
+	IIO_CHAN_INFO_CALIBBIAS_SEPARATE,
+	IIO_CHAN_INFO_PEAK_SHARED,
+	IIO_CHAN_INFO_PEAK_SEPARATE,
+	IIO_CHAN_INFO_PEAK_SCALE_SHARED,
+	IIO_CHAN_INFO_PEAK_SCALE_SEPARATE,
 };
 
 /**
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 67e7ade..79145df 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -74,6 +74,8 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_OFFSET_SHARED/2] = "offset",
 	[IIO_CHAN_INFO_CALIBSCALE_SHARED/2] = "calibscale",
 	[IIO_CHAN_INFO_CALIBBIAS_SHARED/2] = "calibbias",
+	[IIO_CHAN_INFO_PEAK_SHARED/2] = "peak_raw",
+	[IIO_CHAN_INFO_PEAK_SCALE_SHARED/2] = "peak_scale",
 };
 
 int iio_push_event(struct iio_dev *dev_info,
-- 
1.7.3.4
