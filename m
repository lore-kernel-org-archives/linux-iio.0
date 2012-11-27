Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:23722 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758176Ab2K0Hb4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Nov 2012 02:31:56 -0500
Date: Tue, 27 Nov 2012 10:31:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [patch] iio:imu: adis16480: show_firmware() buffer too small
Message-ID: <20121127073142.GC8239@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Smatch complains that snprintf() returns the number of characters,
not counting the NUL terminator, which *would* have been printed if
there were enough space.  In other words the return value could be more
than sizeof(buf).

In this case, we are printing something like "ff.ff\n" which is at most
6 characters and a NUL so that's not an issue.  I changed snprintf() to
scnprintf() to silence the warning.

But since the buffer doesn't include space for the NUL terminator, we
need to make it bigger or the "\n" will be truncated off.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index a080b35..150d7fa 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -125,7 +125,7 @@ static ssize_t adis16480_show_firmware_revision(struct file *file,
 		char __user *userbuf, size_t count, loff_t *ppos)
 {
 	struct adis16480 *adis16480 = file->private_data;
-	char buf[6];
+	char buf[7];
 	size_t len;
 	u16 rev;
 	int ret;
@@ -134,7 +134,7 @@ static ssize_t adis16480_show_firmware_revision(struct file *file,
 	if (ret < 0)
 		return ret;
 
-	len = snprintf(buf, sizeof(buf), "%x.%x\n", rev >> 8, rev & 0xff);
+	len = scnprintf(buf, sizeof(buf), "%x.%x\n", rev >> 8, rev & 0xff);
 
 	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
 }
