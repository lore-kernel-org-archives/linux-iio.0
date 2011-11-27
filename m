Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:57674 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859Ab1K0NNy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2011 08:13:54 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/5] staging;iio: move iio data return types into types.h for use by inkern
Date: Sun, 27 Nov 2011 13:14:01 +0000
Message-Id: <1322399642-22924-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1322399642-22924-1-git-send-email-jic23@kernel.org>
References: <1322399642-22924-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@cam.ac.uk>

In kernel interfaces need these, so make them available.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 4650a2b..e30d33d 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -197,12 +197,6 @@ static inline s64 iio_get_time_ns(void)
 #define INDIO_ALL_BUFFER_MODES					\
 	(INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE)
 
-/* Vast majority of this is set by the industrialio subsystem on a
- * call to iio_device_register. */
-#define IIO_VAL_INT 1
-#define IIO_VAL_INT_PLUS_MICRO 2
-#define IIO_VAL_INT_PLUS_NANO 3
-
 struct iio_trigger; /* forward declaration */
 struct iio_dev;
 
-- 
1.7.7.3

