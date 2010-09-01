Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:56704 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab0IAOxX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2010 10:53:23 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 8/9] staging:iio: lis3l02dqbuffersimple.c bring example up to date.
Date: Wed,  1 Sep 2010 15:58:02 +0100
Message-Id: <1283353083-31313-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
References: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 .../iio/Documentation/lis3l02dqbuffersimple.c      |    4 ++--
 drivers/staging/iio/trigger.h                      |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/Documentation/lis3l02dqbuffersimple.c b/drivers/staging/iio/Documentation/lis3l02dqbuffersimple.c
index 3a58028..2fc3fd8 100644
--- a/drivers/staging/iio/Documentation/lis3l02dqbuffersimple.c
+++ b/drivers/staging/iio/Documentation/lis3l02dqbuffersimple.c
@@ -130,7 +130,7 @@ int main(int argc, char **argv)
 		goto error_free_buf_dir_name;
 
 	/* Enable the buffer */
-	ret = write_sysfs_int("ring_enable", buf_dir_name, 1);
+	ret = write_sysfs_int("enable", buf_dir_name, 1);
 	if (ret < 0)
 		goto error_free_buf_dir_name;
 
@@ -209,7 +209,7 @@ int main(int argc, char **argv)
 	}
 
 	/* Stop the ring buffer */
-	ret = write_sysfs_int("ring_enable", buf_dir_name, 0);
+	ret = write_sysfs_int("enable", buf_dir_name, 0);
 	if (ret < 0)
 		goto error_close_buffer_event;
 
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 200d02e..469beba 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -152,7 +152,7 @@ int iio_alloc_pollfunc(struct iio_dev *indio_dev,
 
 /*
  * Two functions for common case where all that happens is a pollfunc
- * is attached and detached form a trigger
+ * is attached and detached from a trigger
  */
 int iio_triggered_ring_postenable(struct iio_dev *indio_dev);
 int iio_triggered_ring_predisable(struct iio_dev *indio_dev);
-- 
1.7.1

