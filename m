Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/11] staging:iio:accel:adis16xxx: Do not return error code in the interrupt handler
Date: Wed,  4 Jul 2012 18:09:31 +0200
Message-Id: <1341418173-3217-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1341418173-3217-1-git-send-email-lars@metafoo.de>
References: <1341418173-3217-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The interrupt handler should only ever return one of the three irqreturn_t
constants and not an error code. Also make sure to always call
iio_trigger_notify_done before leaving the trigger handler.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/adis16201_ring.c |    5 +++--
 drivers/staging/iio/accel/adis16203_ring.c |    5 +++--
 drivers/staging/iio/accel/adis16204_ring.c |    5 +++--
 drivers/staging/iio/accel/adis16209_ring.c |    5 +++--
 drivers/staging/iio/accel/adis16240_ring.c |    5 +++--
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 247602a..03fcf6e 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -70,7 +70,7 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return -ENOMEM;
+		goto done;
 	}
 
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)
@@ -85,8 +85,9 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 
 	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
 
-	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
+done:
+	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index 7bbd2c2..c16b2b7 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -69,7 +69,7 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return -ENOMEM;
+		goto done;
 	}
 
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength) &&
@@ -86,8 +86,9 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 			      (u8 *)data,
 			      pf->timestamp);
 
-	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
+done:
+	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index f73518b..1d2b31c 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -66,7 +66,7 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return -ENOMEM;
+		goto done;
 	}
 
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength) &&
@@ -81,8 +81,9 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 
 	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
 
-	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
+done:
+	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 0906075..1a4a55c 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -66,7 +66,7 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return -ENOMEM;
+		goto done;
 	}
 
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength) &&
@@ -81,8 +81,9 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 
 	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
 
-	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
+done:
+	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 86a2a47..360dfed 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -64,7 +64,7 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return -ENOMEM;
+		goto done;
 	}
 
 	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength) &&
@@ -79,8 +79,9 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 
 	ring->access->store_to(ring, (u8 *)data, pf->timestamp);
 
-	iio_trigger_notify_done(indio_dev->trig);
 	kfree(data);
+done:
+	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.10
