Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-050.synserver.de ([212.40.185.50]:1065 "EHLO
	smtp-out-049.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757310Ab2BAVQq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2012 16:16:46 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/6] staging:iio: Update iio_event_interface documentation
Date: Wed,  1 Feb 2012 22:17:49 +0100
Message-Id: <1328131074-2739-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1328131074-2739-1-git-send-email-lars@metafoo.de>
References: <1328131074-2739-1-git-send-email-lars@metafoo.de>
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

