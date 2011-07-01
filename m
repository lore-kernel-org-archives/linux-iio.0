Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:49292 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066Ab1GAKDN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Jul 2011 06:03:13 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, ldewangan@nvidia.com,
	shubhrajyoti@ti.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/25] staging:iio: add quadrature correction to chan info types.
Date: Fri,  1 Jul 2011 11:10:53 +0100
Message-Id: <1309515076-12323-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
References: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    3 +++
 drivers/staging/iio/industrialio-core.c |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index bc7bc9d..2a8c8e2 100644
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
index 8fa2be6..ae490e5 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -84,6 +84,8 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_CALIBBIAS_SHARED/2] = "calibbias",
 	[IIO_CHAN_INFO_PEAK_SHARED/2] = "peak_raw",
 	[IIO_CHAN_INFO_PEAK_SCALE_SHARED/2] = "peak_scale",
+	[IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SHARED/2]
+	= "quadrature_correction_raw",
 };
 
 int iio_push_event(struct iio_dev *dev_info,
-- 
1.7.3.4

