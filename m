Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:36313 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586Ab3HTXPZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 20 Aug 2013 19:15:25 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: Remove trailing ; from function definitions
Date: Wed, 21 Aug 2013 01:15:17 +0200
Message-Id: <1377040517-11928-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 include/linux/iio/iio.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 45a99ef..c8e94a8 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -458,7 +458,7 @@ static inline void iio_device_put(struct iio_dev *indio_dev)
 {
 	if (indio_dev)
 		put_device(&indio_dev->dev);
-};
+}
 
 /**
  * dev_to_iio_dev() - Get IIO device struct from a device struct
@@ -565,7 +565,7 @@ static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
 {
 	return indio_dev->currentmode
 		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE);
-};
+}
 
 /**
  * iio_get_debugfs_dentry() - helper function to get the debugfs_dentry
@@ -575,12 +575,12 @@ static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
 static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
 {
 	return indio_dev->debugfs_dentry;
-};
+}
 #else
 static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
 {
 	return NULL;
-};
+}
 #endif
 
 int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
-- 
1.8.3.4

