Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:33232 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129Ab1I3KJj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2011 06:09:39 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/2] staging:iio: filter description - low pass 3db frequency.
Date: Fri, 30 Sep 2011 11:17:58 +0100
Message-Id: <1317377879-9264-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317377879-9264-1-git-send-email-jic23@cam.ac.uk>
References: <1317377879-9264-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Introduce the first data filtering related parameter.
For now we are ignoring the filter type and merely specifying its
approximate (I read them off tiny graphs) 3db point.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    2 ++
 drivers/staging/iio/industrialio-core.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 2a6c673..3c39e1c 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -79,6 +79,8 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE,
 	IIO_CHAN_INFO_AVERAGE_RAW_SHARED,
 	IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE,
+	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED,
+	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SEPARATE,
 };
 
 enum iio_endian {
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 647a405..d2af50a 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -86,6 +86,8 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SHARED/2]
 	= "quadrature_correction_raw",
 	[IIO_CHAN_INFO_AVERAGE_RAW_SHARED/2] = "mean_raw",
+	[IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED/2]
+	= "filter_low_pass_3db_frequency",
 };
 
 /**
-- 
1.7.3.4

