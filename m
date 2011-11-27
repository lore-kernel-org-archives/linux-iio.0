Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:48640 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab1K0LjK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2011 06:39:10 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/3] staging:iio: filter description - low pass 3db frequency.
Date: Sun, 27 Nov 2011 11:39:12 +0000
Message-Id: <1322393954-31525-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1322393954-31525-1-git-send-email-jic23@kernel.org>
References: <1322393954-31525-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@cam.ac.uk>

Introduce the first data filtering related parameter.
For now we are ignoring the filter type and merely specifying its
approximate (I read them off tiny graphs) 3db point.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    7 +++++++
 drivers/staging/iio/industrialio-core.c |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 66c2604..4aed915 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -35,6 +35,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_PEAK_SCALE,
 	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW,
 	IIO_CHAN_INFO_AVERAGE_RAW,
+	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
 };
 
 #define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
@@ -74,6 +75,12 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_AVERAGE_RAW)
 #define IIO_CHAN_INFO_AVERAGE_RAW_SHARED_BIT			\
 	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_AVERAGE_RAW)
+#define IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT \
+	IIO_CHAN_INFO_SHARED_BIT(			       \
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)
+#define IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SEPARATE_BIT \
+	IIO_CHAN_INFO_SEPARATE_BIT(			       \
+		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)
 
 enum iio_endian {
 	IIO_CPU,
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 0b67166..55c0b48 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -85,6 +85,8 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_PEAK_SCALE] = "peak_scale",
 	[IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW] = "quadrature_correction_raw",
 	[IIO_CHAN_INFO_AVERAGE_RAW] = "mean_raw",
+	[IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY]
+	= "filter_low_pass_3db_frequency",
 };
 
 /**
-- 
1.7.7.3

