Return-Path: <SRS0=hh5H=RH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4030C43381
	for <linux-iio@archiver.kernel.org>; Mon,  4 Mar 2019 08:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B643F20823
	for <linux-iio@archiver.kernel.org>; Mon,  4 Mar 2019 08:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfCDIzq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:55:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:40145 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfCDIzp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 4 Mar 2019 03:55:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 00:55:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,439,1544515200"; 
   d="scan'208";a="128804533"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 04 Mar 2019 00:55:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4E5F614E; Mon,  4 Mar 2019 10:55:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] iio: buffer: Switch to bitmap_zalloc()
Date:   Mon,  4 Mar 2019 10:55:40 +0200
Message-Id: <20190304085540.87775-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/buffer/industrialio-buffer-cb.c | 10 ++++-----
 drivers/iio/industrialio-buffer.c           | 24 +++++++++------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index ea63c838eeae..df21e7dbec40 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -36,7 +36,8 @@ static int iio_buffer_cb_store_to(struct iio_buffer *buffer, const void *data)
 static void iio_buffer_cb_release(struct iio_buffer *buffer)
 {
 	struct iio_cb_buffer *cb_buff = buffer_to_cb_buffer(buffer);
-	kfree(cb_buff->buffer.scan_mask);
+
+	bitmap_free(cb_buff->buffer.scan_mask);
 	kfree(cb_buff);
 }
 
@@ -74,9 +75,8 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 	}
 
 	cb_buff->indio_dev = cb_buff->channels[0].indio_dev;
-	cb_buff->buffer.scan_mask
-		= kcalloc(BITS_TO_LONGS(cb_buff->indio_dev->masklength),
-			  sizeof(long), GFP_KERNEL);
+	cb_buff->buffer.scan_mask = bitmap_zalloc(cb_buff->indio_dev->masklength,
+						  GFP_KERNEL);
 	if (cb_buff->buffer.scan_mask == NULL) {
 		ret = -ENOMEM;
 		goto error_release_channels;
@@ -95,7 +95,7 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 	return cb_buff;
 
 error_free_scan_mask:
-	kfree(cb_buff->buffer.scan_mask);
+	bitmap_free(cb_buff->buffer.scan_mask);
 error_release_channels:
 	iio_channel_release_all(cb_buff->channels);
 error_free_cb_buff:
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index cd5bfe39591b..3c7e7380d1c3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -320,9 +320,7 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
 	const unsigned long *mask;
 	unsigned long *trialmask;
 
-	trialmask = kmalloc_array(BITS_TO_LONGS(indio_dev->masklength),
-				  sizeof(*trialmask),
-				  GFP_KERNEL);
+	trialmask = bitmap_alloc(indio_dev->masklength, GFP_KERNEL);
 	if (trialmask == NULL)
 		return -ENOMEM;
 	if (!indio_dev->masklength) {
@@ -344,12 +342,12 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
 	}
 	bitmap_copy(buffer->scan_mask, trialmask, indio_dev->masklength);
 
-	kfree(trialmask);
+	bitmap_free(trialmask);
 
 	return 0;
 
 err_invalid_mask:
-	kfree(trialmask);
+	bitmap_free(trialmask);
 	return -EINVAL;
 }
 
@@ -666,7 +664,7 @@ static void iio_free_scan_mask(struct iio_dev *indio_dev,
 {
 	/* If the mask is dynamically allocated free it, otherwise do nothing */
 	if (!indio_dev->available_scan_masks)
-		kfree(mask);
+		bitmap_free(mask);
 }
 
 struct iio_device_config {
@@ -736,8 +734,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	}
 
 	/* What scan mask do we actually have? */
-	compound_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
-				sizeof(long), GFP_KERNEL);
+	compound_mask = bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
 	if (compound_mask == NULL)
 		return -ENOMEM;
 
@@ -762,7 +759,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 				    indio_dev->masklength,
 				    compound_mask,
 				    strict_scanmask);
-		kfree(compound_mask);
+		bitmap_free(compound_mask);
 		if (scan_mask == NULL)
 			return -EINVAL;
 	} else {
@@ -1303,9 +1300,8 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 					channels[i].scan_index;
 		}
 		if (indio_dev->masklength && buffer->scan_mask == NULL) {
-			buffer->scan_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
-						    sizeof(*buffer->scan_mask),
-						    GFP_KERNEL);
+			buffer->scan_mask = bitmap_zalloc(indio_dev->masklength,
+							  GFP_KERNEL);
 			if (buffer->scan_mask == NULL) {
 				ret = -ENOMEM;
 				goto error_cleanup_dynamic;
@@ -1334,7 +1330,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	return 0;
 
 error_free_scan_mask:
-	kfree(buffer->scan_mask);
+	bitmap_free(buffer->scan_mask);
 error_cleanup_dynamic:
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
 	kfree(indio_dev->buffer->buffer_group.attrs);
@@ -1347,7 +1343,7 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!indio_dev->buffer)
 		return;
 
-	kfree(indio_dev->buffer->scan_mask);
+	bitmap_free(indio_dev->buffer->scan_mask);
 	kfree(indio_dev->buffer->buffer_group.attrs);
 	kfree(indio_dev->buffer->scan_el_group.attrs);
 	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
-- 
2.20.1

