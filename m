Return-Path: <axel.lin@ingics.com>
Message-ID: <1385953044.30717.5.camel@phoenix>
Subject: [PATCH] iio:trigger: Convert to use ATTRIBUTE_GROUPS
From: Axel Lin <axel.lin@ingics.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Date: Mon, 02 Dec 2013 10:57:24 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Use new ATTRIBUTE_GROUPS macro to declare attribute groups.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/iio/industrialio-trigger.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 7ba2f00..766fab2 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -55,15 +55,7 @@ static struct attribute *iio_trig_dev_attrs[] = {
 	&dev_attr_name.attr,
 	NULL,
 };
-
-static struct attribute_group iio_trig_attr_group = {
-	.attrs	= iio_trig_dev_attrs,
-};
-
-static const struct attribute_group *iio_trig_attr_groups[] = {
-	&iio_trig_attr_group,
-	NULL
-};
+ATTRIBUTE_GROUPS(iio_trig_dev);
 
 int iio_trigger_register(struct iio_trigger *trig_info)
 {
@@ -403,7 +395,7 @@ static void iio_trig_release(struct device *device)
 
 static struct device_type iio_trig_type = {
 	.release = iio_trig_release,
-	.groups = iio_trig_attr_groups,
+	.groups = iio_trig_dev_groups,
 };
 
 static void iio_trig_subirqmask(struct irq_data *d)
-- 
1.8.1.2
