Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:37825 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824Ab1HZKI1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 06:08:27 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 10/12] staging:iio: Add capacitance type and average_raw chan info.
Date: Fri, 26 Aug 2011 11:16:33 +0100
Message-Id: <1314353795-7437-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
References: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These are both needed for CAPADCs

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    3 +++
 drivers/staging/iio/industrialio-core.c |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index a59988f..742f6c6 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -42,6 +42,7 @@ enum iio_chan_type {
 	IIO_ROT,
 	IIO_ANGL,
 	IIO_TIMESTAMP,
+	IIO_CAPACITANCE,
 };
 
 /* Nasty hack to avoid massive churn */
@@ -81,6 +82,8 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_PEAK_SCALE_SEPARATE,
 	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SHARED,
 	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE,
+	IIO_CHAN_INFO_AVERAGE_RAW_SHARED,
+	IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE,
 };
 
 enum iio_endian {
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 8c054c0..44a5be5 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -65,6 +65,7 @@ static const char * const iio_chan_type_name_spec_shared[] = {
 	[IIO_ROT] = "rot",
 	[IIO_ANGL] = "angl",
 	[IIO_TIMESTAMP] = "timestamp",
+	[IIO_CAPACITANCE] = "capacitance",
 };
 
 static const char * const iio_chan_type_name_spec_complex[] = {
@@ -89,6 +90,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_PEAK_SCALE_SHARED/2] = "peak_scale",
 	[IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SHARED/2]
 	= "quadrature_correction_raw",
+	[IIO_CHAN_INFO_AVERAGE_RAW_SHARED/2] = "mean_raw",
 };
 
 /**
-- 
1.7.3.4

