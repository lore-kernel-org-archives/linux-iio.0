Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46252 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933620Ab1JZQ1j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 26 Oct 2011 12:27:39 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 04/10] staging:iio:industrialio-trigger.c Trivial code style brackets fix
Date: Wed, 26 Oct 2011 17:27:39 +0100
Message-Id: <1319646465-2788-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319646465-2788-1-git-send-email-jic23@cam.ac.uk>
References: <1319646465-2788-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-trigger.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index ca4124a..9412013 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -159,13 +159,12 @@ EXPORT_SYMBOL(iio_trigger_generic_data_rdy_poll);
 void iio_trigger_poll_chained(struct iio_trigger *trig, s64 time)
 {
 	int i;
-	if (!trig->use_count) {
+	if (!trig->use_count)
 		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++)
 			if (trig->subirqs[i].enabled) {
 				trig->use_count++;
 				handle_nested_irq(trig->subirq_base + i);
 			}
-	}
 }
 EXPORT_SYMBOL(iio_trigger_poll_chained);
 
@@ -173,10 +172,9 @@ void iio_trigger_notify_done(struct iio_trigger *trig)
 {
 	trig->use_count--;
 	if (trig->use_count == 0 && trig->ops && trig->ops->try_reenable)
-		if (trig->ops->try_reenable(trig)) {
+		if (trig->ops->try_reenable(trig))
 			/* Missed and interrupt so launch new poll now */
 			iio_trigger_poll(trig, 0);
-		}
 }
 EXPORT_SYMBOL(iio_trigger_notify_done);
 
-- 
1.7.7

