Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58433 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932074Ab2GBVnt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Jul 2012 17:43:49 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: fix spelling of detach in static func
Date: Mon,  2 Jul 2012 23:43:47 +0200
Message-Id: <1341265427-1647-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/industrialio-trigger.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index ec653fb..2ef36d1 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -234,7 +234,7 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	return ret;
 }
 
-static int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
+static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 					 struct iio_poll_func *pf)
 {
 	int ret = 0;
@@ -502,7 +502,7 @@ EXPORT_SYMBOL(iio_triggered_buffer_postenable);
 
 int iio_triggered_buffer_predisable(struct iio_dev *indio_dev)
 {
-	return iio_trigger_dettach_poll_func(indio_dev->trig,
+	return iio_trigger_detach_poll_func(indio_dev->trig,
 					     indio_dev->pollfunc);
 }
 EXPORT_SYMBOL(iio_triggered_buffer_predisable);
-- 
1.7.9.5

