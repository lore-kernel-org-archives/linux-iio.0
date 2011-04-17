Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 31/70] staging:iio: add generic data ready poll function.
Date: Sun, 17 Apr 2011 20:06:04 +0100
Message-Id: <1303067203-4894-32-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This case is extremely common, so let us only have the one
copy.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-trigger.c |    7 +++++++
 drivers/staging/iio/trigger.h              |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 9ccc789..b2c48d5b 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -215,6 +215,13 @@ void iio_trigger_poll(struct iio_trigger *trig, s64 time)
 }
 EXPORT_SYMBOL(iio_trigger_poll);
 
+irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private)
+{
+	iio_trigger_poll(private, iio_get_time_ns());
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL(iio_trigger_generic_data_rdy_poll);
+
 void iio_trigger_notify_done(struct iio_trigger *trig)
 {
 	trig->use_count--;
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 0c44c5e..8e25c00 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -127,6 +127,8 @@ int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
 void iio_trigger_poll(struct iio_trigger *trig, s64 time);
 void iio_trigger_notify_done(struct iio_trigger *trig);
 
+irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private);
+
 static inline int iio_trigger_get_irq(struct iio_trigger *trig)
 {
 	int ret;
-- 
1.7.3.4
