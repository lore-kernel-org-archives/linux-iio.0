Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:29380
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752369Ab1LSOXY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Dec 2011 09:23:24 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	<devel@driverdev.osuosl.org>, <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/8] staging:iio: Make sure a device is only opened once at a time
Date: Mon, 19 Dec 2011 15:23:45 +0100
Message-ID: <1324304629-24720-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1324304629-24720-1-git-send-email-lars@metafoo.de>
References: <1324304629-24720-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Our buffer implementation does not support multiple concurrent readers. So we
have to ensure that a device is only opened once at a time. So do the same thing
we do for the event fd and introduce a per device busy flag. The flag gets set
when opening the device and gets cleared when closing the device. If a open is
attempted while the busy flag is set we return -EBUSY.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/iio.h               |    3 +++
 drivers/staging/iio/industrialio-core.c |   17 ++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 45b6d75..be6ced3 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -313,6 +313,7 @@ struct iio_buffer_setup_ops {
  * @chrdev:		[INTERN] associated character device
  * @groups:		[INTERN] attribute groups
  * @groupcounter:	[INTERN] index of next attribute group
+ * @flags:		[INTERN] file ops related flags including busy flag.
  **/
 struct iio_dev {
 	int				id;
@@ -344,6 +345,8 @@ struct iio_dev {
 #define IIO_MAX_GROUPS 6
 	const struct attribute_group	*groups[IIO_MAX_GROUPS + 1];
 	int				groupcounter;
+
+	unsigned long			flags;
 };
 
 /**
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 2eef85f..12d1576 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -1083,9 +1083,18 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
 {
 	struct iio_dev *indio_dev = container_of(inode->i_cdev,
 						struct iio_dev, chrdev);
+	unsigned int ret;
+
+	if (test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->flags))
+		return -EBUSY;
+
 	filp->private_data = indio_dev;
 
-	return iio_chrdev_buffer_open(indio_dev);
+	ret = iio_chrdev_buffer_open(indio_dev);
+	if (ret < 0)
+		clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
+
+	return ret;
 }
 
 /**
@@ -1093,8 +1102,10 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
  **/
 static int iio_chrdev_release(struct inode *inode, struct file *filp)
 {
-	iio_chrdev_buffer_release(container_of(inode->i_cdev,
-					     struct iio_dev, chrdev));
+	struct iio_dev *indio_dev = container_of(inode->i_cdev,
+						struct iio_dev, chrdev);
+	iio_chrdev_buffer_release(indio_dev);
+	clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
 	return 0;
 }
 
-- 
1.7.7.3


