Return-Path: <slm9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: greg@kroah.com
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org,
        Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: [PATCH 2/6] staging:iio:lis3l02dq adjust lis3l02dq_configure_ring
Date: Tue, 31 Aug 2010 11:32:51 +0200
Message-Id: <1283247175-12835-3-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1283247175-12835-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
References: <1283247175-12835-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
List-ID: <linux-iio@vger.kernel.org>

Now fits other driver's structure for easier modification.

Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 4c1b36a..9ad04f0 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -479,7 +479,7 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
-
+	struct iio_ring_buffer *ring;
 	INIT_WORK(&h->work_trigger_to_ring, lis3l02dq_trigger_bh_to_ring);
 	/* Set default scan mode */
 	h->get_ring_element = &lis3l02dq_get_ring_element;
@@ -490,17 +490,18 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 
 	indio_dev->scan_el_attrs = &lis3l02dq_scan_el_group;
 
-	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
-	if (!indio_dev->ring)
+	ring = iio_sw_rb_allocate(indio_dev);
+	if (!ring)
 		return -ENOMEM;
 
+	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&indio_dev->ring->access);
-	indio_dev->ring->bpe = 2;
-	indio_dev->ring->preenable = &iio_sw_ring_preenable;
-	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
-	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
-	indio_dev->ring->owner = THIS_MODULE;
+	iio_ring_sw_register_funcs(&ring->access);
+	ring->bpe = 2;
+	ring->preenable = &iio_sw_ring_preenable;
+	ring->postenable = &iio_triggered_ring_postenable;
+	ring->predisable = &iio_triggered_ring_predisable;
+	ring->owner = THIS_MODULE;
 
 	ret = iio_alloc_pollfunc(indio_dev, NULL, &lis3l02dq_poll_func_th);
 	if (ret)
-- 
1.7.0.6
