Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/9] staging:iio:pollfunc: Make explicit that private data is always pointer to a struct iio_dev.
Date: Wed, 24 Aug 2011 17:28:36 +0100
Message-Id: <1314203321-21926-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314203321-21926-1-git-send-email-jic23@cam.ac.uk>
References: <1314203321-21926-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This is always true, so lets make it explicit.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_ring.c |    2 +-
 drivers/staging/iio/accel/adis16203_ring.c |    2 +-
 drivers/staging/iio/accel/adis16204_ring.c |    2 +-
 drivers/staging/iio/accel/adis16209_ring.c |    2 +-
 drivers/staging/iio/accel/adis16240_ring.c |    2 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c |    2 +-
 drivers/staging/iio/adc/ad7192.c           |    2 +-
 drivers/staging/iio/adc/ad7298_ring.c      |    2 +-
 drivers/staging/iio/adc/ad7476_ring.c      |    2 +-
 drivers/staging/iio/adc/ad7606_ring.c      |    3 +--
 drivers/staging/iio/adc/ad7793.c           |    2 +-
 drivers/staging/iio/adc/ad7887_ring.c      |    2 +-
 drivers/staging/iio/adc/ad799x_ring.c      |    2 +-
 drivers/staging/iio/adc/max1363_ring.c     |    2 +-
 drivers/staging/iio/gyro/adis16260_ring.c  |    2 +-
 drivers/staging/iio/imu/adis16400_ring.c   |    2 +-
 drivers/staging/iio/industrialio-trigger.c |    4 ++--
 drivers/staging/iio/meter/ade7758_ring.c   |    2 +-
 drivers/staging/iio/trigger.h              |    6 +++---
 19 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 9925785..880c490 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -59,7 +59,7 @@ static int adis16201_read_ring_data(struct iio_dev *indio_dev, u8 *rx)
 static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16201_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index 049174d..4398fd9 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -59,7 +59,7 @@ static int adis16203_read_ring_data(struct device *dev, u8 *rx)
 static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16203_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index b173856..385e350 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -57,7 +57,7 @@ static int adis16204_read_ring_data(struct device *dev, u8 *rx)
 static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16204_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	int i = 0;
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 7547ddb..1652f15 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -57,7 +57,7 @@ static int adis16209_read_ring_data(struct device *dev, u8 *rx)
 static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16209_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 9bb4ff8..9d4ba15 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -54,7 +54,7 @@ static int adis16240_read_ring_data(struct device *dev, u8 *rx)
 static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16240_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index c53985e..7f7dca4 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -160,7 +160,7 @@ static int lis3l02dq_get_ring_element(struct iio_dev *indio_dev,
 static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	int len = 0;
 	size_t datasize = ring->access->get_bytes_per_datum(ring);
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index c5a8b50..1b07b63 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -537,7 +537,7 @@ static int ad7192_ring_postdisable(struct iio_dev *indio_dev)
 static irqreturn_t ad7192_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	struct ad7192_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 7423d4a..ab828a9 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -117,7 +117,7 @@ static int ad7298_ring_preenable(struct iio_dev *indio_dev)
 static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7298_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	s64 time_ns;
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index 86bbba8..2597fda 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -76,7 +76,7 @@ static int ad7476_ring_preenable(struct iio_dev *indio_dev)
 static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7476_state *st = iio_priv(indio_dev);
 	s64 time_ns;
 	__u8 *rxbuf;
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index f8f574a..52b0c1d 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -80,8 +80,7 @@ static int ad7606_ring_preenable(struct iio_dev *indio_dev)
 static irqreturn_t ad7606_trigger_handler_th_bh(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
-	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_state *st = iio_priv(pf->indio_dev);
 
 	gpio_set_value(st->pdata->gpio_convst, 1);
 
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index ab6f109..aab7528 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -401,7 +401,7 @@ static int ad7793_ring_postdisable(struct iio_dev *indio_dev)
 static irqreturn_t ad7793_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	struct ad7793_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index b77b120..05ae4a0 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -112,7 +112,7 @@ static int ad7887_ring_postdisable(struct iio_dev *indio_dev)
 static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7887_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	s64 time_ns;
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index d84efd6..7980fe5 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -105,7 +105,7 @@ static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad799x_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	s64 time_ns;
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 696676f..caa63cb 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -104,7 +104,7 @@ static int max1363_ring_preenable(struct iio_dev *indio_dev)
 static irqreturn_t max1363_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct max1363_state *st = iio_priv(indio_dev);
 	s64 time_ns;
 	__u8 *rxbuf;
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 92d1fac..36f72c3 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -60,7 +60,7 @@ static int adis16260_read_ring_data(struct device *dev, u8 *rx)
 static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16260_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	int i = 0;
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index ef38477..56385d3 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -111,7 +111,7 @@ static int adis16350_spi_read_all(struct device *dev, u8 *rx)
 static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16400_state *st = iio_priv(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	int i = 0, j, ret = 0;
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 89a9934..ccfd558 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -274,7 +274,7 @@ struct iio_poll_func
 *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
 		    irqreturn_t (*thread)(int irq, void *p),
 		    int type,
-		    void *private,
+		    struct iio_dev *indio_dev,
 		    const char *fmt,
 		    ...)
 {
@@ -294,7 +294,7 @@ struct iio_poll_func
 	pf->h = h;
 	pf->thread = thread;
 	pf->type = type;
-	pf->private_data = private;
+	pf->indio_dev = indio_dev;
 
 	return pf;
 }
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index c9271d0..c29beec 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -60,7 +60,7 @@ out:
 static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->private_data;
+	struct iio_dev *indio_dev = pf->indio_dev;
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	struct ade7758_state *st = iio_priv(indio_dev);
 	s64 dat64[2];
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 234c774..010da1d 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -76,7 +76,7 @@ struct iio_trigger {
 /**
  * struct iio_poll_func - poll function pair
  *
- * @private_data:		data specific to device (passed into poll func)
+ * @indio_dev:			data specific to device (passed into poll func)
  * @h:				the function that is actually run on trigger
  * @thread:			threaded interrupt part
  * @type:			the type of interrupt (basically if oneshot)
@@ -88,7 +88,7 @@ struct iio_trigger {
  *				passes it via here.
  **/
 struct iio_poll_func {
-	void				*private_data;
+	struct iio_dev *indio_dev;
 	irqreturn_t (*h)(int irq, void *p);
 	irqreturn_t (*thread)(int irq, void *p);
 	int type;
@@ -180,7 +180,7 @@ struct iio_poll_func
 *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
 		    irqreturn_t (*thread)(int irq, void *p),
 		    int type,
-		    void *private,
+		    struct iio_dev *indio_dev,
 		    const char *fmt,
 		    ...);
 void iio_dealloc_pollfunc(struct iio_poll_func *pf);
-- 
1.7.3.4
