Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 08/10] staging:iio:events: Make sure userspace buffer is large enough
Date: Wed, 26 Oct 2011 17:27:43 +0100
Message-Id: <1319646465-2788-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319646465-2788-1-git-send-email-jic23@cam.ac.uk>
References: <1319646465-2788-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Lars-Peter Clausen <lars@metafoo.de>

Make sure that the userspace buffer is large enough to hold a iio_event_data
struct before writing to it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 555877d..6379a08 100644
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
