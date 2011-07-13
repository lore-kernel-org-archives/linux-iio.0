Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/3] staging:iio:kfifo_buf fix double initialization of the ring device structure.
Date: Wed, 13 Jul 2011 12:52:00 +0100
Message-Id: <1310557920-30519-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310557920-30519-1-git-send-email-jic23@cam.ac.uk>
References: <1310557920-30519-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Looks like this moved into the core at somepoint and kfifo buf got left
behind.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/kfifo_buf.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index cc14b96..6002368 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -110,9 +110,7 @@ struct iio_ring_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
 	iio_ring_buffer_init(&kf->ring, indio_dev);
 	__iio_init_kfifo(kf);
 	kf->ring.dev.type = &iio_kfifo_type;
-	device_initialize(&kf->ring.dev);
 	kf->ring.dev.parent = &indio_dev->dev;
-	kf->ring.dev.bus = &iio_bus_type;
 	dev_set_drvdata(&kf->ring.dev, (void *)&(kf->ring));
 
 	return &kf->ring;
-- 
1.7.3.4
