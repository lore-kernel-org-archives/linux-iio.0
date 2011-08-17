Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:54941 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab1HQIeN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Aug 2011 04:34:13 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/6] staging:iio:attrs - make address a u64 to allow event codes to be used.
Date: Wed, 17 Aug 2011 09:42:13 +0100
Message-Id: <1313570537-26971-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk>
References: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes unusual event related attributes look a lot more like the core ones.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/sysfs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 30f9a4d..dcb413d 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -22,7 +22,7 @@ struct iio_chan_spec;
  */
 struct iio_dev_attr {
 	struct device_attribute dev_attr;
-	int address;
+	u64 address;
 	struct list_head l;
 	struct iio_chan_spec const *c;
 };
-- 
1.7.3.4

