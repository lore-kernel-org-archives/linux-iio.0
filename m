Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO-onwards: ADC: free pollfunc->name on remove
Date: Tue, 19 Apr 2011 09:19:17 +0200
Message-ID: <1303197557-32421-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7476_ring.c  |    2 +-
 drivers/staging/iio/adc/max1363_ring.c |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index b6da824..de6006b 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -109,7 +109,6 @@ done:
 	return IRQ_HANDLED;
 }
 
- 
 static struct iio_ring_setup_ops ad7476_ring_setup_ops = {
 	.preenable = &ad7476_ring_preenable,
 	.postenable = &iio_triggered_ring_postenable,
@@ -168,6 +167,7 @@ void ad7476_ring_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
+	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index b8054be..da6b4f6 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -210,6 +210,7 @@ void max1363_ring_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_dettach_poll_func(indio_dev->trig,
 					      indio_dev->pollfunc);
 	}
+	kfree(indio_dev->pollfunc->name);
 	kfree(indio_dev->pollfunc);
 	iio_sw_rb_free(indio_dev->ring);
 }
-- 
1.6.0.2
