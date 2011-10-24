Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:events: Make sure userspace buffer is large enough
Date: Mon, 24 Oct 2011 13:52:43 +0200
Message-ID: <1319457163-15889-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Make sure that the userspace buffer is large enough to hold a iio_event_data
struct before writing to it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/industrialio-core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 74904f1..733e83a 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -169,8 +169,11 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 {
 	struct iio_event_interface *ev_int = filep->private_data;
 	struct iio_detected_event_list *el;
+	size_t len = sizeof(el->ev);
 	int ret;
-	size_t len;
+
+	if (count < len)
+		return -EINVAL;
 
 	mutex_lock(&ev_int->event_list_lock);
 	if (list_empty(&ev_int->det_events)) {
@@ -192,7 +195,6 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 	el = list_first_entry(&ev_int->det_events,
 			      struct iio_detected_event_list,
 			      list);
-	len = sizeof el->ev;
 	if (copy_to_user(buf, &(el->ev), len)) {
 		ret = -EFAULT;
 		goto error_mutex_unlock;
-- 
1.7.7
