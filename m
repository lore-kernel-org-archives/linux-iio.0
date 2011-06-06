Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: trigger: Add filter callbacks
Date: Mon, 6 Jun 2011 13:01:15 +0200
Message-ID: <1307358075-25797-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Allow devices to reject triggers and vice versa.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/iio.h                  |    2 ++
 drivers/staging/iio/industrialio-trigger.c |   16 +++++++++++++++-
 drivers/staging/iio/trigger.h              |    2 ++
 3 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 78a0927..8ec4f41 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -293,6 +293,8 @@ struct iio_dev {
 
 	u32				*available_scan_masks;
 	struct iio_trigger		*trig;
+	int (*iio_validate_trigger)	(struct iio_dev *indio_dev,
+					 struct iio_trigger *trig);
 	struct iio_poll_func		*pollfunc;
 
 	struct iio_chan_spec const *channels;
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 6159023..1f6bc65 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -294,6 +294,7 @@ struct iio_poll_func
 	pf->h = h;
 	pf->thread = thread;
 	pf->type = type;
+	pf->private_data = private;
 
 	return pf;
 }
@@ -339,6 +340,8 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct iio_trigger *oldtrig = dev_info->trig;
+	struct iio_trigger *trig;
+
 	mutex_lock(&dev_info->mlock);
 	if (dev_info->currentmode == INDIO_RING_TRIGGERED) {
 		mutex_unlock(&dev_info->mlock);
@@ -346,7 +349,18 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 	}
 	mutex_unlock(&dev_info->mlock);
 
-	dev_info->trig = iio_trigger_find_by_name(buf, len);
+	trig = iio_trigger_find_by_name(buf, len);
+
+	if (trig && dev_info->iio_validate_trigger &&
+		dev_info->iio_validate_trigger(dev_info, trig))
+		return -EINVAL;
+
+	if (trig && trig->iio_validate_device &&
+		trig->iio_validate_device(trig, dev_info))
+		return -EINVAL;
+
+	dev_info->trig = trig;
+
 	if (oldtrig && dev_info->trig != oldtrig)
 		iio_put_trigger(oldtrig);
 	if (dev_info->trig)
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index f329fe1..9218200 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -48,6 +48,8 @@ struct iio_trigger {
 
 	int (*set_trigger_state)(struct iio_trigger *trig, bool state);
 	int (*try_reenable)(struct iio_trigger *trig);
+	int (*iio_validate_device)(struct iio_trigger *trig,
+				   struct iio_dev *indio_dev);
 
 	struct irq_chip			subirq_chip;
 	int				subirq_base;
-- 
1.7.0.4
