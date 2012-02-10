Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-177.synserver.de ([212.40.185.177]:1073 "EHLO
	smtp-out-171.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751086Ab2BJSNp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Feb 2012 13:13:45 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] staging:iio:events: Remove obsolete documentation
Date: Fri, 10 Feb 2012 19:14:58 +0100
Message-Id: <1328897701-24032-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit 43ba1100 ("staging:iio:events: Use waitqueue lock to protect event
queue") removed the event_list_lock field from the iio_event_interface struct,
but missed to remove the same field from the documentation for that function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/industrialio-event.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/staging/iio/industrialio-event.c
index 66d320b..5fdf739 100644
--- a/drivers/staging/iio/industrialio-event.c
+++ b/drivers/staging/iio/industrialio-event.c
@@ -28,7 +28,6 @@
 /**
  * struct iio_event_interface - chrdev interface for an event line
  * @wait:		wait queue to allow blocking reads of events
- * @event_list_lock:	mutex to protect the list of detected events
  * @det_events:		list of detected events
  * @dev_attr_list:	list of event interface sysfs attribute
  * @flags:		file operations related flags including busy flag.
-- 
1.7.9

