Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:54944 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab1HQIeN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Aug 2011 04:34:13 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/6] staging:iio: Add capacitance type and average_raw chan info.
Date: Wed, 17 Aug 2011 09:42:12 +0100
Message-Id: <1313570537-26971-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk>
References: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These are both needed for CAPADCs

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    3 +++
 drivers/staging/iio/industrialio-core.c |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 5f72d97..0f7df90 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -44,6 +44,7 @@ enum iio_chan_type {
 	IIO_ROT,
 	IIO_ANGL,
 	IIO_TIMESTAMP,
+	IIO_CAPACITANCE,
 };
 
 /* Nasty hack to avoid massive churn */
@@ -84,6 +85,8 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_PEAK_SCALE_SEPARATE,
 	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SHARED,
 	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE,
+	IIO_CHAN_INFO_AVERAGE_RAW_SHARED,
+	IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE,
 };
 
 enum iio_endian {
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 534cde8..e1e6f07 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -63,6 +63,7 @@ static const char * const iio_chan_type_name_spec_shared[] = {
 	[IIO_ROT] = "rot",
 	[IIO_ANGL] = "angl",
 	[IIO_TIMESTAMP] = "timestamp",
+	[IIO_CAPACITANCE] = "capacitance",
 };
 
 static const char * const iio_chan_type_name_spec_complex[] = {
@@ -87,6 +88,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_PEAK_SCALE_SHARED/2] = "peak_scale",
 	[IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SHARED/2]
 	= "quadrature_correction_raw",
+	[IIO_CHAN_INFO_AVERAGE_RAW_SHARED/2] = "mean_raw",
 };
 
 /**
-- 
1.7.3.4

