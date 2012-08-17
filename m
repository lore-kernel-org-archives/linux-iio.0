Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] iio:trigger_consumer.h: Add missing includes and forward declarations
Date: Fri, 17 Aug 2012 17:57:46 +0200
Message-Id: <1345219066-5338-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1345219066-5338-1-git-send-email-lars@metafoo.de>
References: <1345219066-5338-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Add includes and forward declarations for types used in this file. This avoids
compile errors if the other files have not been included before.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/iio/trigger_consumer.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
index 762a3d3..c4f8c74 100644
--- a/include/linux/iio/trigger_consumer.h
+++ b/include/linux/iio/trigger_consumer.h
@@ -10,6 +10,12 @@
 #ifndef __LINUX_IIO_TRIGGER_CONSUMER_H__
 #define __LINUX_IIO_TRIGGER_CONSUMER_H__
 
+#include <linux/interrupt.h>
+#include <linux/types.h>
+
+struct iio_dev;
+struct iio_trigger;
+
 /**
  * struct iio_poll_func - poll function pair
  *
-- 
1.7.10.4
