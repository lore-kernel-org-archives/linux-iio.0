Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/5] staging:iio: Use userspace types for iio_event_data
Date: Wed, 26 Oct 2011 17:41:33 +0100
Message-Id: <1319647296-4374-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319647296-4374-1-git-send-email-jic23@cam.ac.uk>
References: <1319647296-4374-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Lars-Peter Clausen <lars@metafoo.de>

Since we want to export struct iio_event_data to userspace use the userspace
integer types. Also add a include to linux/types.h.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/events.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
index 08cf3d1..389c781 100644
--- a/drivers/staging/iio/events.h
+++ b/drivers/staging/iio/events.h
@@ -10,6 +10,7 @@
 #define _IIO_EVENTS_H_
 
 #include <linux/ioctl.h>
+#include <linux/types.h>
 #include "types.h"
 
 /**
@@ -19,8 +20,8 @@
  *		the interrupt handler)
  */
 struct iio_event_data {
-	u64	id;
-	s64	timestamp;
+	__u64	id;
+	__s64	timestamp;
 };
 
 #define IIO_GET_EVENT_FD_IOCTL _IOR('i', 0x90, int)
-- 
1.7.7
