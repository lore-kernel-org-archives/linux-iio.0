Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:42405 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab1JXJtM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2011 05:49:12 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:core shared attrs do not work with modifier.
Date: Mon, 24 Oct 2011 10:49:18 +0100
Message-Id: <1319449758-26883-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319449758-26883-1-git-send-email-jic23@cam.ac.uk>
References: <1319449758-26883-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The logic building the name had a small bug where
it did not verify if it was generic before applying the
modifier.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 326e967..555877d 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -408,7 +408,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 	sysfs_attr_init(&dev_attr->attr);
 
 	/* Build up postfix of <extend_name>_<modifier>_postfix */
-	if (chan->modified) {
+	if (chan->modified && !generic) {
 		if (chan->extend_name)
 			full_postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
 						 iio_modifier_names[chan
-- 
1.7.7

