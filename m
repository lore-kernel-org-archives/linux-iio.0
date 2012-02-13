Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:50370
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753692Ab2BMJYR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 13 Feb 2012 04:24:17 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	<devel@driverdev.osuosl.org>, <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/4] staging:iio:events: Remove obsolete documentation
Date: Mon, 13 Feb 2012 10:25:31 +0100
Message-ID: <1329125134-24150-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
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


