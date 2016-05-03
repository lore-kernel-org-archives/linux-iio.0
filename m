Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17758 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932655AbcECM1Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 May 2016 08:27:25 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCHv2] iio: Fix error handling in iio_trigger_attach_poll_func
Date: Tue,  3 May 2016 15:27:09 +0300
Message-Id: <0045891ad86e52d9b7c93ed297d060f252f69381.1462278295.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When attaching a pollfunc iio_trigger_attach_poll_func will allocate a
virtual irq and call the driver's set_trigger_state function. Fix error
handling to undo previous steps if any fails.

In particular this fixes handling errors from a driver's
set_trigger_state function. When using triggered buffers a failure to
enable the trigger used to make the buffer unusable.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---

Previous version was sent as a RFC. This version also properly handles errors
from iio_trigger_get_irq and request_threaded_irq.

Calling request_threaded_irq with a negative/invalid irq parameter might work
and return an error but let's not rely on that.

 drivers/iio/industrialio-trigger.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index ae2806a..0c52dfe 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -210,22 +210,35 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 
 	/* Prevent the module from being removed whilst attached to a trigger */
 	__module_get(pf->indio_dev->info->driver_module);
+
+	/* Get irq number */
 	pf->irq = iio_trigger_get_irq(trig);
+	if (pf->irq < 0)
+		goto out_put_module;
+
+	/* Request irq */
 	ret = request_threaded_irq(pf->irq, pf->h, pf->thread,
 				   pf->type, pf->name,
 				   pf);
-	if (ret < 0) {
-		module_put(pf->indio_dev->info->driver_module);
-		return ret;
-	}
+	if (ret < 0)
+		goto out_put_irq;
 
+	/* Enable trigger in driver */
 	if (trig->ops && trig->ops->set_trigger_state && notinuse) {
 		ret = trig->ops->set_trigger_state(trig, true);
 		if (ret < 0)
-			module_put(pf->indio_dev->info->driver_module);
+			goto out_free_irq;
 	}
 
 	return ret;
+
+out_free_irq:
+	free_irq(pf->irq, pf);
+out_put_irq:
+	iio_trigger_put_irq(trig, pf->irq);
+out_put_module:
+	module_put(pf->indio_dev->info->driver_module);
+	return ret;
 }
 
 static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
-- 
2.5.5

