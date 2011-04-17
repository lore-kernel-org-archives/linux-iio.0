Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:35598 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab1DQTFJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2011 15:05:09 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 62/70] staging:iio: Add angl parameters to the chan spec code.
Date: Sun, 17 Apr 2011 20:06:35 +0100
Message-Id: <1303067203-4894-63-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    1 +
 drivers/staging/iio/industrialio-core.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 4946006..0bba445 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -45,6 +45,7 @@ enum iio_chan_type {
 	IIO_TEMP,
 	IIO_INCLI,
 	IIO_ROT,
+	IIO_ANGL,
 	IIO_TIMESTAMP,
 };
 
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 79145df..3f7df85 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -54,6 +54,7 @@ static const char * const iio_chan_type_name_spec_shared[] = {
 	[IIO_MAGN] = "magn",
 	[IIO_INCLI] = "incli",
 	[IIO_ROT] = "rot",
+	[IIO_ANGL] = "angl",
 };
 
 static const char * const iio_chan_type_name_spec[] = {
@@ -66,6 +67,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_MAGN] = "magn_%c",
 	[IIO_INCLI] = "incli_%c",
 	[IIO_ROT] = "rot_%c",
+	[IIO_ANGL] = "angl_%c",
 };
 
 /* relies on pairs of these shared then separate */
-- 
1.7.3.4

