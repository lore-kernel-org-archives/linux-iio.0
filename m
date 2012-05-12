Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/23] staging:iio:__lis3l02dq_write_data_ready_config: Pass IIO device directly
Date: Sat, 12 May 2012 15:39:38 +0200
Message-Id: <1336829994-7857-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1336829994-7857-1-git-send-email-lars@metafoo.de>
References: <1336829994-7857-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

When calling __lis3l02dq_write_data_ready_config we pass the device struct of
embedded in the IIO device only to look up the IIO device from the device struct
again right away. This patch changes the code to pass the IIO device directly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 9306f93..51b00df 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -163,12 +163,11 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 
 /* Caller responsible for locking as necessary. */
 static int
-__lis3l02dq_write_data_ready_config(struct device *dev, bool state)
+__lis3l02dq_write_data_ready_config(struct iio_dev *indio_dev, bool state)
 {
 	int ret;
 	u8 valold;
 	bool currentlyset;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct lis3l02dq_state *st = iio_priv(indio_dev);
 
 /* Get the current event mask register */
@@ -236,7 +235,7 @@ static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	int ret = 0;
 	u8 t;
 
-	__lis3l02dq_write_data_ready_config(&indio_dev->dev, state);
+	__lis3l02dq_write_data_ready_config(indio_dev, state);
 	if (state == false) {
 		/*
 		 * A possible quirk with the handler is currently worked around
-- 
1.7.10
