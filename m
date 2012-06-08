Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38606 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760334Ab2FHXRD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 8 Jun 2012 19:17:03 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q58NH2sK009530
	for <linux-iio@vger.kernel.org>; Fri, 8 Jun 2012 18:17:02 -0500
Received: from DFLE70.ent.ti.com (dfle70.ent.ti.com [128.247.5.40])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q58NH1aL032570
	for <linux-iio@vger.kernel.org>; Fri, 8 Jun 2012 18:17:02 -0500
From: Leed Aguilar <leed.aguilar@ti.com>
To: <linux-iio@vger.kernel.org>
CC: <leed.aguilar@ti.com>
Subject: [PATCH 1/9] iio: industrialio-buffer: use kstrtoul instead of strict_strtoul
Date: Fri, 8 Jun 2012 18:13:16 -0400
Message-ID: <1339193596-24134-1-git-send-email-leed.aguilar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix the following checkpatch.pl warning:

WARNING: strict_strtoul is obsolete, use kstrtoul instead

Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
---
 drivers/staging/iio/industrialio-buffer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index db6e930..c61f757 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -380,7 +380,7 @@ ssize_t iio_buffer_write_length(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_buffer *buffer = indio_dev->buffer;
 
-	ret = strict_strtoul(buf, 10, &val);
+	ret = kstrtoul(buf, 10, &val);
 	if (ret)
 		return ret;
 
-- 
1.7.1

