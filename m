Return-Path: <levinsasha928@gmail.com>
From: Sasha Levin <levinsasha928@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Sasha Levin <levinsasha928@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: [PATCH] iio: Fix build error in industrialio-core.c
Date: Wed, 23 Nov 2011 12:13:59 +0200
Message-Id: <1322043239-26082-1-git-send-email-levinsasha928@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The error was introduced in commit b4641336 ("iio: fix a leak due to
improper use of anon_inode_getfd()").

Looks like the code wasn't even compile tested. Instead of just fixing the
error I changed the function a bit to make it nicer.

Cc: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org
Signed-off-by: Sasha Levin <levinsasha928@gmail.com>
---
 drivers/staging/iio/industrialio-core.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 2656409..5367914 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -242,25 +242,24 @@ static const struct file_operations iio_event_chrdev_fileops = {
 
 static int iio_event_getfd(struct iio_dev *indio_dev)
 {
+	struct iio_event_interface *ev_int = indio_dev->event_interface;
 	int fd;
 
-	if (indio_dev->event_interface == NULL)
+	if (ev_int == NULL)
 		return -ENODEV;
 
-	mutex_lock(&indio_dev->event_interface->event_list_lock);
-	if (test_and_set_bit(IIO_BUSY_BIT_POS,
-			     &indio_dev->event_interface->flags)) {
-		mutex_unlock(&indio_dev->event_interface->event_list_lock);
+	mutex_lock(&ev_int->event_list_lock);
+	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
+		mutex_unlock(&ev_int->event_list_lock);
 		return -EBUSY;
 	}
-	mutex_unlock(&indio_dev->event_interface->event_list_lock);
-	fd = anon_inode_getfd("iio:event",
-				&iio_event_chrdev_fileops,
-				indio_dev->event_interface, O_RDONLY);
+	mutex_unlock(&ev_int->event_list_lock);
+	fd = anon_inode_getfd("iio:event", &iio_event_chrdev_fileops,
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
1.7.8.rc3
