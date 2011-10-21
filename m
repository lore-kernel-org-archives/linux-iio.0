Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:37013 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525Ab1JULtd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2011 07:49:33 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de
Subject: [PATCH 2/2] staging:iio: Use userspace types for iio_event_data
Date: Fri, 21 Oct 2011 12:49:38 +0100
Message-Id: <1319197778-32347-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319197778-32347-1-git-send-email-jic23@cam.ac.uk>
References: <1319197778-32347-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Since we want to export struct iio_event_data to userspace use the userspace
integer types. Also add a include to linux/types.h.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
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

