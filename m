Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:49996 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756105Ab3KLVtw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 12 Nov 2013 16:49:52 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/2] iio: Remove redundant check that new trigger is different from old
Date: Tue, 12 Nov 2013 22:49:47 +0100
Message-Id: <1384292987-6250-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1384292987-6250-1-git-send-email-pmeerw@pmeerw.net>
References: <1384292987-6250-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

same check is performed a new lines above

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/industrialio-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 021d735..5bf13ed 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -356,7 +356,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 
 	indio_dev->trig = trig;
 
-	if (oldtrig && indio_dev->trig != oldtrig)
+	if (oldtrig)
 		iio_trigger_put(oldtrig);
 	if (indio_dev->trig)
 		iio_trigger_get(indio_dev->trig);
-- 
1.8.4.3

