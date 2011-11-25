Return-Path: <abogani@kernel.org>
From: Alessio Igor Bogani <abogani@kernel.org>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Alessio Igor Bogani <abogani@kernel.org>
Subject: [PATCH] iio: Fix build error
Date: Fri, 25 Nov 2011 09:42:46 +0100
Message-Id: <1322210566-16841-1-git-send-email-abogani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

drivers/staging/iio/industrialio-core.c: In function
‘iio_event_getfd’:
drivers/staging/iio/industrialio-core.c:262:17:
error: ‘ev_int’ undeclared (first use in this function)
drivers/staging/iio/industrialio-core.c:262:17: note: each undeclared
identifier is reported only once for each function it appears in

Signed-off-by: Alessio Igor Bogani <abogani@kernel.org>
---
 drivers/staging/iio/industrialio-core.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 2656409..da17136 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -242,25 +242,26 @@ static const struct file_operations iio_event_chrdev_fileops = {
 
 static int iio_event_getfd(struct iio_dev *indio_dev)
 {
+	struct iio_event_interface *ev_int = indio_dev->event_interface;
 	int fd;
 
-	if (indio_dev->event_interface == NULL)
+	if (ev_int == NULL)
 		return -ENODEV;
 
-	mutex_lock(&indio_dev->event_interface->event_list_lock);
+	mutex_lock(&ev_int->event_list_lock);
 	if (test_and_set_bit(IIO_BUSY_BIT_POS,
-			     &indio_dev->event_interface->flags)) {
-		mutex_unlock(&indio_dev->event_interface->event_list_lock);
+			     &ev_int->flags)) {
+		mutex_unlock(&ev_int->event_list_lock);
 		return -EBUSY;
 	}
-	mutex_unlock(&indio_dev->event_interface->event_list_lock);
+	mutex_unlock(&ev_int->event_list_lock);
 	fd = anon_inode_getfd("iio:event",
 				&iio_event_chrdev_fileops,
-				indio_dev->event_interface, O_RDONLY);
+				ev_int, O_RDONLY);
 	if (fd < 0) {
-		mutex_lock(&indio_dev->event_interface->event_list_lock);
+		mutex_lock(&ev_int->event_list_lock);
 		clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
-		mutex_unlock(&indio_dev->event_interface->event_list_lock);
+		mutex_unlock(&ev_int->event_list_lock);
 	}
 	return fd;
 }
-- 
1.7.4.1
