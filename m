Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:56690 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754955Ab0IAOxW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2010 10:53:22 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/9] staging:iio: simplify logic in iio_interrupt_handler
Date: Wed,  1 Sep 2010 15:57:56 +0100
Message-Id: <1283353083-31313-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
References: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-core.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 48a2884..406f861 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -125,19 +125,10 @@ static irqreturn_t iio_interrupt_handler(int irq, void *_int_info)
 	}
 
 	time_ns = iio_get_time_ns();
-	/* detect single element list*/
-	if (list_is_singular(&int_info->ev_list)) {
+	list_for_each_entry(p, &int_info->ev_list, list) {
 		disable_irq_nosync(irq);
-		p = list_first_entry(&int_info->ev_list,
-				     struct iio_event_handler_list,
-				     list);
-		/* single event handler - maybe shared */
 		p->handler(dev_info, 1, time_ns, !(p->refcount > 1));
-	} else
-		list_for_each_entry(p, &int_info->ev_list, list) {
-			disable_irq_nosync(irq);
-			p->handler(dev_info, 1, time_ns, 0);
-		}
+	}
 	spin_unlock_irqrestore(&int_info->ev_list_lock, flags);
 
 	return IRQ_HANDLED;
-- 
1.7.1

