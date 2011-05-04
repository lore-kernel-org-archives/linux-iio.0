Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:57566 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab1EDL4w (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2011 07:56:52 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de, Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 31/99] staging:iio: add generic data ready poll function.
Date: Wed,  4 May 2011 12:58:03 +0100
Message-Id: <1304510351-10922-32-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

