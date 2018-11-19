Return-Path: <MAILER-DAEMON>
From: Martin Kelly <martin@martingkelly.com>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Martin Kelly <martin@martingkelly.com>
Subject: [PATCH 1/2] iio: bmi160: snap timestamp closer to event
Date: Sun, 18 Nov 2018 16:53:46 -0800
Message-Id: <20181119005347.747-1-martin@martingkelly.com>
List-ID: <linux-iio@vger.kernel.org>

From: Martin Kelly <martin@martingkelly.com>

Currently, we snap the timestamp after reading from the buffer and
processing the event. Technically, we can get a slightly more accurate
timestamp by snapping it prior to reading the data, since the data was
already generated prior to entering the trigger handler. This is not going
to make a huge difference, but we might as well improve slightly.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index c85659ca9507..4d9d59d9e3a9 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -384,6 +384,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
+	s64 ts = iio_get_time_ns(indio_dev);
 	struct bmi160_data *data = iio_priv(indio_dev);
 	__le16 buf[16];
 	/* 3 sens x 3 axis x __le16 + 3 x __le16 pad + 4 x __le16 tstamp */
@@ -399,8 +400,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 		buf[j++] = sample;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_timestamp(indio_dev, buf, ts);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
-- 
2.11.0
