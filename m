Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:53734
	"EHLO VA3EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753353Ab2BASos (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2012 13:44:48 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/6] staging:iio: Update iio_event_interface documentation
Date: Wed, 1 Feb 2012 19:45:51 +0100
Message-ID: <1328121956-29596-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1328121956-29596-1-git-send-email-lars@metafoo.de>
References: <1328121956-29596-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The documentation for the iio_event_interface does not match the actual struct
anymore. This patch removes the documentation for non-existing fields and adds
documentation for missing fields.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/industrialio-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 19f897f..580f373 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -112,13 +112,14 @@ struct iio_detected_event_list {
 
 /**
  * struct iio_event_interface - chrdev interface for an event line
- * @dev:		device assocated with event interface
  * @wait:		wait queue to allow blocking reads of events
  * @event_list_lock:	mutex to protect the list of detected events
  * @det_events:		list of detected events
  * @max_events:		maximum number of events before new ones are dropped
  * @current_events:	number of events in detected list
+ * @dev_attr_list:	list of event interface sysfs attribute
  * @flags:		file operations related flags including busy flag.
+ * @group:		event interface sysfs attribute group
  */
 struct iio_event_interface {
 	wait_queue_head_t			wait;
-- 
1.7.8.3


