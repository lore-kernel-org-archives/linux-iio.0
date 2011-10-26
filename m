Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 06/10] staging:iio: trigger fixes for repeat request of same trigger and allocation failure
Date: Wed, 26 Oct 2011 17:27:41 +0100
Message-Id: <1319646465-2788-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319646465-2788-1-git-send-email-jic23@cam.ac.uk>
References: <1319646465-2788-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Both of these are decidedly silly bugs show up whilst testing
completely different code paths.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-trigger.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 9412013..20dc8e8 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -220,8 +220,16 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	ret = request_threaded_irq(pf->irq, pf->h, pf->thread,
 				   pf->type, pf->name,
 				   pf);
-	if (trig->ops && trig->ops->set_trigger_state && notinuse)
+	if (ret < 0) {
+		module_put(pf->indio_dev->info->driver_module);
+		return ret;
+	}
+
+	if (trig->ops && trig->ops->set_trigger_state && notinuse) {
 		ret = trig->ops->set_trigger_state(trig, true);
+		if (ret < 0)
+			module_put(pf->indio_dev->info->driver_module);
+	}
 
 	return ret;
 }
@@ -334,6 +342,8 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 	mutex_unlock(&indio_dev->mlock);
 
 	trig = iio_trigger_find_by_name(buf, len);
+	if (oldtrig == trig)
+		return len;
 
 	if (trig && indio_dev->info->validate_trigger) {
 		ret = indio_dev->info->validate_trigger(indio_dev, trig);
-- 
1.7.7
