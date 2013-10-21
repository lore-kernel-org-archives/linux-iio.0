Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/9] iio: Fix crash in trigger unregister
Date: Mon, 21 Oct 2013 14:01:09 -0700
Message-Id: <1382389277-7932-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

User space can write a triger name via trigger/current_trigger.
But it is possible that it can't find this name. In this case
iio_trigger_find_by_name will return NULL. Even if it is NULL,
it sets indio_dev->trig to this NULL value. But when iio drivers
calls iio_trigger_unregister, it will crash because it will try
to dereference NULL pointer. So either every driver checks for
NULL before calling iio_trigger_unregister or make sure that
NULL is not assigned because of invalid trigger name. The later
is better and has less impact.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/industrialio-trigger.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index bf5e70a..4dc4247 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -342,13 +342,16 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 	if (oldtrig == trig)
 		return len;
 
-	if (trig && indio_dev->info->validate_trigger) {
+	if (!trig)
+		return -EINVAL;
+
+	if (indio_dev->info->validate_trigger) {
 		ret = indio_dev->info->validate_trigger(indio_dev, trig);
 		if (ret)
 			return ret;
 	}
 
-	if (trig && trig->ops && trig->ops->validate_device) {
+	if (trig->ops && trig->ops->validate_device) {
 		ret = trig->ops->validate_device(trig, indio_dev);
 		if (ret)
 			return ret;
-- 
1.8.3.1
