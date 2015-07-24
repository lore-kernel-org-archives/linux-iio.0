Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35906 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbbGXNRK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2015 09:17:10 -0400
Date: Fri, 24 Jul 2015 16:16:19 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH 1/6] iio: core: Add function params for kernel docs
Message-ID: <0301f753bd699ce58336c5418443a9e0358b8ffb.1437737942.git.cristina.opriceana@gmail.com>
References: <cover.1437737942.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1437737942.git.cristina.opriceana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the missing fields in kernel docs to remove
some warnings that appear when the IIO Documentation DocBook
is generated.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 drivers/iio/industrialio-core.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d8051cd..da643b9 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -406,10 +406,16 @@ EXPORT_SYMBOL_GPL(iio_enum_write);
 
 /**
  * iio_format_value() - Formats a IIO value into its string representation
- * @buf: The buffer to which the formated value gets written
- * @type: One of the IIO_VAL_... constants. This decides how the val and val2
- *        parameters are formatted.
- * @vals: pointer to the values, exact meaning depends on the type parameter.
+ * @buf:	The buffer to which the formated value gets written
+ * @type:	One of the IIO_VAL_... constants. This decides how the val
+ *		and val2 parameters are formatted.
+ * @size:	Number of IIO value entries contained in vals
+ * @vals:	Pointer to the values, exact meaning depends on the
+ *		type parameter.
+ *
+ * Return: 0 by default, a negative number on failiure or the
+ *	   total number of characters written for a type that belongs
+ *	   to the IIO_VAL_... constant.
  */
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
 {
@@ -1096,6 +1102,11 @@ EXPORT_SYMBOL_GPL(devm_iio_device_free);
 
 /**
  * iio_chrdev_open() - chrdev file open for buffer access and ioctls
+ * @inode:	Inode structure for identifying the device in the file system
+ * @filp:	File structure for iio device used to keep and later access
+ *		private data
+ *
+ * Return: 0 on success or -EBUSY if the device is already opened
  **/
 static int iio_chrdev_open(struct inode *inode, struct file *filp)
 {
@@ -1114,7 +1125,11 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
 
 /**
  * iio_chrdev_release() - chrdev file close buffer access and ioctls
- **/
+ * @inode:	Inode structure pointer for the char device
+ * @filp:	File structure pointer for the char device
+ *
+ * Return: 0 for successful release
+ */
 static int iio_chrdev_release(struct inode *inode, struct file *filp)
 {
 	struct iio_dev *indio_dev = container_of(inode->i_cdev,
-- 
1.9.1

