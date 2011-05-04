Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 67/99] staging:iio: Add chan info support for 'peak_raw' attributes.
Date: Wed,  4 May 2011 12:58:39 +0100
Message-Id: <1304510351-10922-68-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    6 +++++-
 drivers/staging/iio/industrialio-core.c |    2 ++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 914ced7..ebf8bae 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -73,7 +73,11 @@ enum iio_chan_info_enum {
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
index e943dac..e3582c9 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -80,6 +80,8 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_OFFSET_SHARED/2] = "offset",
 	[IIO_CHAN_INFO_CALIBSCALE_SHARED/2] = "calibscale",
 	[IIO_CHAN_INFO_CALIBBIAS_SHARED/2] = "calibbias",
+	[IIO_CHAN_INFO_PEAK_SHARED/2] = "peak_raw",
+	[IIO_CHAN_INFO_PEAK_SCALE_SHARED/2] = "peak_scale",
 };
 
 int iio_push_event(struct iio_dev *dev_info,
-- 
1.7.3.4
