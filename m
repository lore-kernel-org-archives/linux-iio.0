Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:49995 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756613Ab3KLVtw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 12 Nov 2013 16:49:52 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/2] iio: Minor kerneldoc fix for iio_trigger_write_current()
Date: Tue, 12 Nov 2013 22:49:46 +0100
Message-Id: <1384292987-6250-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1384292987-6250-1-git-send-email-pmeerw@pmeerw.net>
References: <1384292987-6250-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/industrialio-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index bf5e70a..021d735 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -318,7 +318,7 @@ static ssize_t iio_trigger_read_current(struct device *dev,
  * iio_trigger_write_current() - trigger consumer sysfs set current trigger
  *
  * For trigger consumers the current_trigger interface allows the trigger
- * used for this device to be specified at run time based on the triggers
+ * used for this device to be specified at run time based on the trigger's
  * name.
  **/
 static ssize_t iio_trigger_write_current(struct device *dev,
-- 
1.8.4.3

