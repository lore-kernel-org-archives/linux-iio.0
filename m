Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] iio:consumer.h: Fix include guard
Date: Fri, 17 Aug 2012 17:57:44 +0200
Message-Id: <1345219066-5338-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The symbol name for the #ifndef and the #define of the include guard do not
match and thus it becomes quite ineffective. Add the missing '_' to fix this.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/iio/consumer.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index e2657e6..06ab4ec 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -8,7 +8,7 @@
  * the Free Software Foundation.
  */
 #ifndef _IIO_INKERN_CONSUMER_H_
-#define _IIO_INKERN_CONSUMER_H
+#define _IIO_INKERN_CONSUMER_H_
 #include <linux/iio/types.h>
 
 struct iio_dev;
-- 
1.7.10.4
