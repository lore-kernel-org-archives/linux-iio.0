Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 031/111] staging:iio: add generic data ready poll function.
Date: Wed, 18 May 2011 14:41:21 +0100
Message-Id: <1305726161-5606-32-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This case is extremely common, so let us only have the one
copy.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-trigger.c |    7 +++++++
 drivers/staging/iio/trigger.h              |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 5496ee2..d045b6c 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -189,6 +189,13 @@ void iio_trigger_poll(struct iio_trigger *trig, s64 time)
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
