Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 01/11] staging:iio:resolver:ad2s90 fix registration of null pointer
Date: Fri, 30 Sep 2011 11:14:44 +0100
Message-Id: <1317377694-9001-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
References: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

When the new allocation code was introduced a stray pointer
to iio_dev structure was left in the chip state structure.
This was never set but was then registered with the core.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/resolver/ad2s90.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 3739bd2..161442e 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -23,7 +23,6 @@
 
 struct ad2s90_state {
 	struct mutex lock;
-	struct iio_dev *idev;
 	struct spi_device *sdev;
 	u8 rx[2] ____cacheline_aligned;
 };
@@ -87,7 +86,7 @@ static int __devinit ad2s90_probe(struct spi_device *spi)
 	indio_dev->info = &ad2s90_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(st->idev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -99,7 +98,7 @@ static int __devinit ad2s90_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(st->idev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
-- 
1.7.3.4
