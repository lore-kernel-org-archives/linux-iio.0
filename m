Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [RFC] iio: Release irq if set_trigger_state fails
Date: Thu, 28 Apr 2016 19:40:22 +0300
Message-Id: <28d5b780aa8bd065492e0be1aa2f5c59a0cc0e16.1461861330.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

When attaching a pollfunc iio_trigger_attach_poll_func will allocate a
virtual irq and call the driver's set_trigger_state function. Fix error
handling to release the irq if set_trigger_state fails.

Otherwise when using triggered buffers and the driver's
set_trigger_state fails once then the buffer becomes unusable.

It is not possible to handle this sort of error by calling
iio_trigger_detach_poll_func externally somehow. That function should
only be called if attach is successful.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---

I ran into this while adding some validation in driver's set_trigger_state
function. It's much better to use buffer_ops->predisable for that kind of stuff
but the iio core should still handle set_trigger_state errors correctly.

 drivers/iio/industrialio-trigger.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index ae2806a..cf2be3e 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -214,18 +214,23 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	ret = request_threaded_irq(pf->irq, pf->h, pf->thread,
 				   pf->type, pf->name,
 				   pf);
-	if (ret < 0) {
-		module_put(pf->indio_dev->info->driver_module);
-		return ret;
-	}
+	if (ret < 0)
+		goto out_put_module;
 
 	if (trig->ops && trig->ops->set_trigger_state && notinuse) {
 		ret = trig->ops->set_trigger_state(trig, true);
 		if (ret < 0)
-			module_put(pf->indio_dev->info->driver_module);
+			goto out_put_irq;
 	}
 
 	return ret;
+
+out_put_irq:
+	iio_trigger_put_irq(trig, pf->irq);
+	free_irq(pf->irq, pf);
+out_put_module:
+	module_put(pf->indio_dev->info->driver_module);
+	return ret;
 }
 
 static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
-- 
2.5.5
