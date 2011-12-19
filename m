Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/6] staging:iio: Update iio_event_interface documentation
Date: Mon, 19 Dec 2011 11:29:35 +0100
Message-ID: <1324290580-17511-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The documentation for the iio_event_interface does not match the actual struct
anymore. This patch removes the documentation for non-existing fields and adds
documentation for missing fields.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/industrialio-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 2eef85f..23dd624 100644
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
1.7.7.3
