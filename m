Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-070.synserver.de ([212.40.185.70]:1218 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759924Ab2FURHW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jun 2012 13:07:22 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] iio:trigger: Use to_iio_trigger() instead of dev_get_drvdata()
Date: Thu, 21 Jun 2012 19:11:00 +0200
Message-Id: <1340298660-9362-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1340298660-9362-1-git-send-email-lars@metafoo.de>
References: <1340298660-9362-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use to_iio_trigger(dev) instead of dev_get_drvdata(dev). Both will return the
trigger which belongs to the device, but the the first on is a bit more
lightweight.

Since this is the last location where we used dev_get_drvdata() for retrieving
the trigger there is no need anymore to assign the the trigger to the devices
drvdata, so we can remove that as well.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-trigger.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 0f582df..ec653fb 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -45,7 +45,7 @@ static ssize_t iio_trigger_read_name(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
-	struct iio_trigger *trig = dev_get_drvdata(dev);
+	struct iio_trigger *trig = to_iio_trigger(dev);
 	return sprintf(buf, "%s\n", trig->name);
 }
 
@@ -436,7 +436,6 @@ struct iio_trigger *iio_trigger_alloc(const char *fmt, ...)
 		trig->dev.type = &iio_trig_type;
 		trig->dev.bus = &iio_bus_type;
 		device_initialize(&trig->dev);
-		dev_set_drvdata(&trig->dev, (void *)trig);
 
 		mutex_init(&trig->pool_lock);
 		trig->subirq_base
-- 
1.7.10

