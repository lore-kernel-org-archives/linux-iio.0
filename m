Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:1166 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368AbaLUAnn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 20 Dec 2014 19:43:43 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v2 01/11] iio: buffer: fix custom buffer attributes copy
Date: Sun, 21 Dec 2014 02:42:26 +0200
Message-Id: <1419122556-8100-2-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/iio/industrialio-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 2bd8d39..403b728 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -789,7 +789,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	buffer->buffer_group.attrs[1] = &dev_attr_enable.attr;
 	if (buffer->attrs)
 		memcpy(&buffer->buffer_group.attrs[2], buffer->attrs,
-			sizeof(*&buffer->buffer_group.attrs) * (attrcount - 2));
+			sizeof(*&buffer->buffer_group.attrs) * attrcount);
 	buffer->buffer_group.attrs[attrcount+2] = NULL;
 
 	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
-- 
1.9.1

