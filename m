Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:38384 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747Ab1GMOF6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Jul 2011 10:05:58 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/6] staging:iio: prevent removal of module connected to trigger.
Date: Wed, 13 Jul 2011 15:05:53 +0100
Message-Id: <1310565955-13469-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310565955-13469-1-git-send-email-jic23@cam.ac.uk>
References: <1310565955-13469-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7298_ring.c      |    5 -----
 drivers/staging/iio/adc/ad7476_ring.c      |    6 ------
 drivers/staging/iio/adc/ad7606_ring.c      |    5 -----
 drivers/staging/iio/adc/ad7793.c           |    6 ------
 drivers/staging/iio/adc/ad7887_ring.c      |    6 ------
 drivers/staging/iio/adc/ad799x_ring.c      |    6 ------
 drivers/staging/iio/adc/max1363_ring.c     |    5 -----
 drivers/staging/iio/industrialio-trigger.c |    3 +++
 drivers/staging/iio/meter/ade7758_ring.c   |    6 ------
 9 files changed, 3 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index ab828a9..5b87926 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -189,11 +189,6 @@ error_ret:
 
 void ad7298_ring_cleanup(struct iio_dev *indio_dev)
 {
-	if (indio_dev->trig) {
-		iio_put_trigger(indio_dev->trig);
-		iio_trigger_dettach_poll_func(indio_dev->trig,
-					      indio_dev->pollfunc);
-	}
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index 2597fda..41d6b8d 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -152,12 +152,6 @@ error_ret:
 
 void ad7476_ring_cleanup(struct iio_dev *indio_dev)
 {
-	/* ensure that the trigger has been detached */
-	if (indio_dev->trig) {
-		iio_put_trigger(indio_dev->trig);
-		iio_trigger_dettach_poll_func(indio_dev->trig,
-					      indio_dev->pollfunc);
-	}
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 52b0c1d..1c563ec 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -197,11 +197,6 @@ error_ret:
 
 void ad7606_ring_cleanup(struct iio_dev *indio_dev)
 {
-	if (indio_dev->trig) {
-		iio_put_trigger(indio_dev->trig);
-		iio_trigger_dettach_poll_func(indio_dev->trig,
-					      indio_dev->pollfunc);
-	}
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index aab7528..8a5857c 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -469,12 +469,6 @@ error_ret:
 
 static void ad7793_ring_cleanup(struct iio_dev *indio_dev)
 {
-	/* ensure that the trigger has been detached */
-	if (indio_dev->trig) {
-		iio_put_trigger(indio_dev->trig);
-		iio_trigger_dettach_poll_func(indio_dev->trig,
-					      indio_dev->pollfunc);
-	}
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index 05ae4a0..cc39eee 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -188,12 +188,6 @@ error_ret:
 
 void ad7887_ring_cleanup(struct iio_dev *indio_dev)
 {
-	/* ensure that the trigger has been detached */
-	if (indio_dev->trig) {
-		iio_put_trigger(indio_dev->trig);
-		iio_trigger_dettach_poll_func(indio_dev->trig,
-					      indio_dev->pollfunc);
-	}
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 7980fe5..e268a61 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -204,12 +204,6 @@ error_ret:
 
 void ad799x_ring_cleanup(struct iio_dev *indio_dev)
 {
-	/* ensure that the trigger has been detached */
-	if (indio_dev->trig) {
-		iio_put_trigger(indio_dev->trig);
-		iio_trigger_dettach_poll_func(indio_dev->trig,
-					      indio_dev->pollfunc);
-	}
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index caa63cb..d4db91d 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -195,11 +195,6 @@ error_ret:
 void max1363_ring_cleanup(struct iio_dev *indio_dev)
 {
 	/* ensure that the trigger has been detached */
-	if (indio_dev->trig) {
-		iio_put_trigger(indio_dev->trig);
-		iio_trigger_dettach_poll_func(indio_dev->trig,
-					      indio_dev->pollfunc);
-	}
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 602be5c..1bc3f14 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -229,6 +229,8 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	bool notinuse
 		= bitmap_empty(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 
+	/* Prevent the module being removed whilst attached to a trigger */
+	__module_get(pf->indio_dev->info->driver_module);
 	pf->irq = iio_trigger_get_irq(trig);
 	ret = request_threaded_irq(pf->irq, pf->h, pf->thread,
 				   pf->type, pf->name,
@@ -255,6 +257,7 @@ int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
 	}
 	iio_trigger_put_irq(trig, pf->irq);
 	free_irq(pf->irq, pf);
+	module_put(pf->indio_dev->info->driver_module);
 
 error_ret:
 	return ret;
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index c29beec..2dec532 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -127,12 +127,6 @@ static const struct iio_ring_setup_ops ade7758_ring_setup_ops = {
 
 void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
 {
-	/* ensure that the trigger has been detached */
-	if (indio_dev->trig) {
-		iio_put_trigger(indio_dev->trig);
-		iio_trigger_dettach_poll_func(indio_dev->trig,
-					      indio_dev->pollfunc);
-	}
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
-- 
1.7.3.4

