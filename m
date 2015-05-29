Return-Path: <rodriguez.twister@gmail.com>
From: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
To: jic23@kernel.org,
	daniel.baluta@intel.com,
	dan.carpenter@oracle.com,
	gregkh@linuxfoundation.org
Cc: cristina.opriceana@gmail.com,
	driverdev-devel@linuxdriverproject.org,
	linux-iio@vger.kernel.org,
	Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
Subject: [PATCH v2 2/3] staging: iio_simple_dummy: fix return types
Date: Sat, 30 May 2015 00:45:22 +0300
Message-Id: <1432935923-28928-3-git-send-email-rodriguez.twister@gmail.com>
In-Reply-To: <1432935923-28928-1-git-send-email-rodriguez.twister@gmail.com>
References: <1432935923-28928-1-git-send-email-rodriguez.twister@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The functions iio_dummy_remove(), iio_simple_dummy_events_unregister() and
iio_dummy_evgen_release_irq() were changed to return void instead of int, 
because these functions always return 0.

Signed-off-by: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
---
 drivers/staging/iio/iio_dummy_evgen.c         |  4 +---
 drivers/staging/iio/iio_simple_dummy.c        | 10 ++--------
 drivers/staging/iio/iio_simple_dummy_events.c |  4 +---
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/iio_dummy_evgen.c b/drivers/staging/iio/iio_dummy_evgen.c
index 0c9c86d..c54d5b5 100644
--- a/drivers/staging/iio/iio_dummy_evgen.c
+++ b/drivers/staging/iio/iio_dummy_evgen.c
@@ -128,13 +128,11 @@ EXPORT_SYMBOL_GPL(iio_dummy_evgen_get_irq);
  *
  * Used by client driver instances to give the irqs back when they disconnect
  */
-int iio_dummy_evgen_release_irq(int irq)
+void iio_dummy_evgen_release_irq(int irq)
 {
 	mutex_lock(&iio_evgen->lock);
 	iio_evgen->inuse[irq - iio_evgen->base] = false;
 	mutex_unlock(&iio_evgen->lock);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(iio_dummy_evgen_release_irq);
 
diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index d0a9963..dc9482c7 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -665,9 +665,8 @@ error_ret:
  *
  * Parameters follow those of iio_dummy_probe for buses.
  */
-static int iio_dummy_remove(int index)
+static void iio_dummy_remove(int index)
 {
-	int ret;
 	/*
 	 * Get a pointer to the device instance iio_dev structure
 	 * from the bus subsystem. E.g.
@@ -685,15 +684,10 @@ static int iio_dummy_remove(int index)
 	/* Buffered capture related cleanup */
 	iio_simple_dummy_unconfigure_buffer(indio_dev);
 
-	ret = iio_simple_dummy_events_unregister(indio_dev);
-	if (ret)
-		goto error_ret;
+	iio_simple_dummy_events_unregister(indio_dev);
 
 	/* Free all structures */
 	iio_device_free(indio_dev);
-
-error_ret:
-	return ret;
 }
 
 /**
diff --git a/drivers/staging/iio/iio_simple_dummy_events.c b/drivers/staging/iio/iio_simple_dummy_events.c
index c32ef78..ecc563c 100644
--- a/drivers/staging/iio/iio_simple_dummy_events.c
+++ b/drivers/staging/iio/iio_simple_dummy_events.c
@@ -257,13 +257,11 @@ error_ret:
  * iio_simple_dummy_events_unregister() - tidy up interrupt handling on remove
  * @indio_dev: device instance data
  */
-int iio_simple_dummy_events_unregister(struct iio_dev *indio_dev)
+void iio_simple_dummy_events_unregister(struct iio_dev *indio_dev)
 {
 	struct iio_dummy_state *st = iio_priv(indio_dev);
 
 	free_irq(st->event_irq, indio_dev);
 	/* Not part of normal driver */
 	iio_dummy_evgen_release_irq(st->event_irq);
-
-	return 0;
 }
-- 
2.4.1
