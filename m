Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54075 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933235Ab1ERNkH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 09:40:07 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 072/111] staging:iio: Add channel types IIO_CURRENT and IIO_POWER.
Date: Wed, 18 May 2011 14:42:02 +0100
Message-Id: <1305726161-5606-73-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

This is required for the ADE7758 driver cleanup.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    2 ++
 drivers/staging/iio/industrialio-core.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 1a6bedc..c6fda58 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -36,6 +36,8 @@ enum iio_chan_type {
 
 	/* real channel types */
 	IIO_IN,
+	IIO_CURRENT,
+	IIO_POWER,
 	IIO_ACCEL,
 	IIO_IN_DIFF,
 	IIO_GYRO,
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index e3582c9..fc20a06 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -48,6 +48,8 @@ static const char * const iio_chan_type_name_spec_shared[] = {
 	[IIO_TIMESTAMP] = "timestamp",
 	[IIO_ACCEL] = "accel",
 	[IIO_IN] = "in",
+	[IIO_CURRENT] = "current",
+	[IIO_POWER] = "power",
 	[IIO_IN_DIFF] = "in-in",
 	[IIO_GYRO] = "gyro",
 	[IIO_TEMP] = "temp",
-- 
1.7.3.4

