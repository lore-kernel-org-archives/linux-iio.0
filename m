Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:57290 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab1HLQBA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2011 12:01:00 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 19/19] staging:iio: Remove deprecated dev_data from iio_dev.
Date: Fri, 12 Aug 2011 17:08:53 +0100
Message-Id: <1313165333-3951-20-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
References: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The equivalent should always be done using iio_alllocate_device
with to create a private area for the driver and then iio_priv
to access it.  There may be other uses for a private data pointer
but right now it just leads driver writers astray.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 42254b4..d86a610 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -276,7 +276,6 @@ struct iio_info {
 /**
  * struct iio_dev - industrial I/O device
  * @id:			[INTERN] used to identify device internally
- * @dev_data:		[DRIVER] device specific data
  * @modes:		[DRIVER] operating modes supported by device
  * @currentmode:	[DRIVER] current operating mode
  * @dev:		[DRIVER] device structure, should be assigned a parent
@@ -296,7 +295,7 @@ struct iio_info {
  **/
 struct iio_dev {
 	int				id;
-	void				*dev_data;
+
 	int				modes;
 	int				currentmode;
 	struct device			dev;
@@ -370,16 +369,6 @@ static inline struct iio_dev *to_iio_dev(struct device *d)
 	return container_of(d, struct iio_dev, dev);
 };
 
-/**
- * iio_dev_get_devdata() - helper function gets device specific data
- * @d: the iio_dev associated with the device
- **/
-static inline void *iio_dev_get_devdata(struct iio_dev *d)
-{
-	return d->dev_data;
-}
-
-
 /* Can we make this smaller? */
 #define IIO_ALIGN L1_CACHE_BYTES
 /**
-- 
1.7.3.4

