Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38210 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbbGXNTA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2015 09:19:00 -0400
Date: Fri, 24 Jul 2015 16:18:09 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH 2/6] iio: buffer: Fix kernel docs warnings
Message-ID: <b36f8de1969bd0650e07bbac57d7120d700a8d32.1437737942.git.cristina.opriceana@gmail.com>
References: <cover.1437737942.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1437737942.git.cristina.opriceana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix kernel docs for structures and functions in order to
remove some warnings when the documentation gets generated.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 drivers/iio/industrialio-buffer.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b13f941..a671953 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -91,9 +91,16 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
 
 /**
  * iio_buffer_read_first_n_outer() - chrdev read for buffer access
+ * @filp:	File structure pointer for the char device
+ * @buf:	Destination buffer for iio buffer read
+ * @n:		First n bytes to read
+ * @f_ps:	Long offset provided by the user as a seek position
  *
  * This function relies on all buffer implementations having an
  * iio_buffer as their first element.
+ *
+ * Return: negative values corresponding to error codes or ret != 0
+ *	   for ending the reading activity
  **/
 ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 				      size_t n, loff_t *f_ps)
@@ -143,6 +150,12 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
 
 /**
  * iio_buffer_poll() - poll the buffer to find out if it has data
+ * @filp:	File structure poiner for device access
+ * @wait:	Poll table structure pointer for which the driver adds
+ *		a wait queue
+ *
+ * Return: (POLLIN | POLLRDNORM) if data is available for reading
+ *	   or 0 for other cases
  */
 unsigned int iio_buffer_poll(struct file *filp,
 			     struct poll_table_struct *wait)
@@ -1136,7 +1149,7 @@ int iio_scan_mask_query(struct iio_dev *indio_dev,
 EXPORT_SYMBOL_GPL(iio_scan_mask_query);
 
 /**
- * struct iio_demux_table() - table describing demux memcpy ops
+ * struct iio_demux_table - table describing demux memcpy ops
  * @from:	index to copy from
  * @to:		index to copy to
  * @length:	how many bytes to copy
-- 
1.9.1

