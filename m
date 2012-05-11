Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-184.synserver.de ([212.40.185.184]:1072 "EHLO
	smtp-out-167.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752089Ab2EKMBm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2012 08:01:42 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:dummy: Remove outdated comment
Date: Fri, 11 May 2012 14:04:29 +0200
Message-Id: <1336737869-16186-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

iio_device_free has to be called regardless of whether the device has been
registered or not when freeing it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/iio_simple_dummy.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index 3b4513c..3104119 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -470,8 +470,6 @@ error_unconfigure_buffer:
 error_unregister_events:
 	iio_simple_dummy_events_unregister(indio_dev);
 error_free_device:
-	/* Note free device should only be called, before registration
-	 * has succeeded. */
 	iio_device_free(indio_dev);
 error_ret:
 	return ret;
-- 
1.7.10

