Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] staging:iio: Use userspace types for iio_event_data
Date: Fri, 21 Oct 2011 12:59:38 +0200
Message-ID: <1319194778-7153-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1319194778-7153-1-git-send-email-lars@metafoo.de>
References: <4EA14C87.2020606@metafoo.de>
 <1319194778-7153-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Since we want to export struct iio_event_data to userspace use the userspace
integer types. Also add a include to linux/types.h.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Followup to "staging:iio: header reorganization". Based on linux-iio/master
---
 drivers/staging/iio/events.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
index fbc198e..d1f946e 100644
--- a/drivers/staging/iio/events.h
+++ b/drivers/staging/iio/events.h
@@ -12,6 +12,7 @@
 #define _IIO_EVENTS_H_
 
 #include <linux/ioctl.h>
+#include <linux/types.h>
 
 /**
  * struct iio_event_data - The actual event being pushed to userspace
@@ -20,8 +21,8 @@
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
1.7.6.3
