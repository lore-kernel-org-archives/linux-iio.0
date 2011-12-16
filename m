Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/8] staging:iio: Use iio_buffer_enabled instead of open coding it
Date: Fri, 16 Dec 2011 11:19:44 +0100
Message-ID: <1324030791-17983-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/industrialio-buffer.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index a03a574..5fe7f83 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -420,7 +420,7 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 	mutex_lock(&indio_dev->mlock);
 	previous_mode = indio_dev->currentmode;
 	requested_state = !(buf[0] == '0');
-	current_state = !!(previous_mode & INDIO_ALL_BUFFER_MODES);
+	current_state = iio_buffer_enabled(indio_dev);
 	if (current_state == requested_state) {
 		printk(KERN_INFO "iio-buffer, current state requested again\n");
 		goto done;
@@ -509,8 +509,7 @@ ssize_t iio_buffer_show_enable(struct device *dev,
 			       char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", !!(indio_dev->currentmode
-				       & INDIO_ALL_BUFFER_MODES));
+	return sprintf(buf, "%d\n", iio_buffer_enabled(indio_dev));
 }
 EXPORT_SYMBOL(iio_buffer_show_enable);
 
-- 
1.7.7.3
