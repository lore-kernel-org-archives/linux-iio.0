Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/12] staging:iio: add quadrature correction to chan info types.
Date: Fri, 12 Aug 2011 17:47:53 +0100
Message-Id: <1313167683-11881-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313167683-11881-1-git-send-email-jic23@cam.ac.uk>
References: <1313167683-11881-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    3 +++
 drivers/staging/iio/industrialio-core.c |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index d86a610..07f88aa 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -1,3 +1,4 @@
+
 /* The industrial I/O core
  *
  * Copyright (c) 2008 Jonathan Cameron
@@ -75,6 +76,8 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_PEAK_SEPARATE,
 	IIO_CHAN_INFO_PEAK_SCALE_SHARED,
 	IIO_CHAN_INFO_PEAK_SCALE_SEPARATE,
+	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SHARED,
+	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE,
 };
 
 /**
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index b424649..364964b 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -85,6 +85,8 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_CALIBBIAS_SHARED/2] = "calibbias",
 	[IIO_CHAN_INFO_PEAK_SHARED/2] = "peak_raw",
 	[IIO_CHAN_INFO_PEAK_SCALE_SHARED/2] = "peak_scale",
+	[IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SHARED/2]
+	= "quadrature_correction_raw",
 };
 
 /* Return a negative errno on failure */
-- 
1.7.3.4
