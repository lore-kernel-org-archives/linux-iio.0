Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:62266 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938657AbcIXGbj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Sep 2016 02:31:39 -0400
Subject: [PATCH 7/7] iio: Adjust checks for null pointers in six functions
To: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <8e0c9fdd-fc9a-0093-278f-00f3beb2a8f6@users.sourceforge.net>
Date: Sat, 24 Sep 2016 08:31:19 +0200
MIME-Version: 1.0
In-Reply-To: <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 24 Sep 2016 08:00:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script "checkpatch.pl" can point information out like the following.

Comparison to NULL could be written !…

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/industrialio-buffer.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 57e201a..6893639 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -310,7 +310,7 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
 	trialmask = kmalloc_array(BITS_TO_LONGS(indio_dev->masklength),
 				  sizeof(*trialmask),
 				  GFP_KERNEL);
-	if (trialmask == NULL)
+	if (!trialmask)
 		return -ENOMEM;
 	if (!indio_dev->masklength) {
 		WARN(1, "Trying to set scanmask prior to registering buffer\n");
@@ -711,7 +711,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	/* What scan mask do we actually have? */
 	compound_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
 				sizeof(long), GFP_KERNEL);
-	if (compound_mask == NULL)
+	if (!compound_mask)
 		return -ENOMEM;
 
 	scan_timestamp = false;
@@ -736,7 +736,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 				    compound_mask,
 				    strict_scanmask);
 		kfree(compound_mask);
-		if (scan_mask == NULL)
+		if (!scan_mask)
 			return -EINVAL;
 	} else {
 	    scan_mask = compound_mask;
@@ -940,7 +940,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 		goto out_unlock;
 	}
 
-	if (indio_dev->info == NULL) {
+	if (!indio_dev->info) {
 		ret = -ENODEV;
 		goto out_unlock;
 	}
@@ -1130,11 +1130,11 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 				indio_dev->scan_index_timestamp =
 					channels[i].scan_index;
 		}
-		if (indio_dev->masklength && buffer->scan_mask == NULL) {
+		if (indio_dev->masklength && !buffer->scan_mask) {
 			buffer->scan_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
 						    sizeof(*buffer->scan_mask),
 						    GFP_KERNEL);
-			if (buffer->scan_mask == NULL) {
+			if (!buffer->scan_mask) {
 				ret = -ENOMEM;
 				goto error_cleanup_dynamic;
 			}
@@ -1146,7 +1146,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	buffer->scan_el_group.attrs = kcalloc(attrcount + 1,
 					      sizeof(buffer->scan_el_group.attrs[0]),
 					      GFP_KERNEL);
-	if (buffer->scan_el_group.attrs == NULL) {
+	if (!buffer->scan_el_group.attrs) {
 		ret = -ENOMEM;
 		goto error_free_scan_mask;
 	}
@@ -1291,7 +1291,7 @@ static int iio_buffer_add_demux(struct iio_buffer *buffer,
 		(*p)->length += length;
 	} else {
 		*p = kmalloc(sizeof(**p), GFP_KERNEL);
-		if (*p == NULL)
+		if (!*p)
 			return -ENOMEM;
 		(*p)->from = in_loc;
 		(*p)->to = out_loc;
@@ -1356,7 +1356,7 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 		in_loc += length;
 	}
 	buffer->demux_bounce = kzalloc(out_loc, GFP_KERNEL);
-	if (buffer->demux_bounce == NULL) {
+	if (!buffer->demux_bounce) {
 		ret = -ENOMEM;
 		goto error_clear_mux_table;
 	}
-- 
2.10.0

