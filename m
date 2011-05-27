Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 50/50] staging:iio: Remove deprecated dev_data from iio_dev.
Date: Fri, 27 May 2011 19:36:30 +0100
Message-Id: <1306521390-24897-51-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The equivalent should always be done using iio_alllocate_device
with to create a private area for the driver and then iio_priv
to access it.  There may be other uses for a private data pointer
but right now it just leads driver writers astray.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 38f1425..7640f33 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -260,7 +260,6 @@ struct iio_info {
 /**
  * struct iio_dev - industrial I/O device
  * @id:			[INTERN] used to identify device internally
- * @dev_data:		[DRIVER] device specific data
  * @modes:		[DRIVER] operating modes supported by device
  * @currentmode:	[DRIVER] current operating mode
  * @dev:		[DRIVER] device structure, should be assigned a parent
@@ -280,7 +279,7 @@ struct iio_info {
  **/
 struct iio_dev {
 	int				id;
-	void				*dev_data;
+
 	int				modes;
 	int				currentmode;
 	struct device			dev;
@@ -354,16 +353,6 @@ static inline struct iio_dev *to_iio_dev(struct device *d)
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
