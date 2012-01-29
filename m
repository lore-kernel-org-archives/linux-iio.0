Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 5/5] staging:iio:adc:adt7310/7410 sticking plaster fix for broken event attrs.
Date: Sun, 29 Jan 2012 11:07:04 +0000
Message-Id: <1327835224-20956-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1327835224-20956-1-git-send-email-jic23@kernel.org>
References: <1327835145-20886-1-git-send-email-jic23@kernel.org>
 <1327835224-20956-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Neither of these drivers has ever been anywhere near the iio abi.
Probably as a result of this the fact they had two event groups
each was not picked up when we restricted IIO to having only
1 event line per device (as part of the chrdev merge set).

As such these definitely didn't work before.  This patch squishes
the only element from the 'comparator' event line that isn't in the
'interrupt' one into it and kills off the 'comparator' one.

Ultimately both of these drivers belong in hwmon not IIO and are just
waiting here because I don't want to kill off a driver that may
prove useful to someone.  (Ultimately I will ask Greg to scrap
these two if no one steps up to deal with them.)

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/adt7310.c |   21 ++++-----------------
 drivers/staging/iio/adc/adt7410.c |   21 ++++-----------------
 2 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index eec2f32..caf57c1 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -725,32 +725,19 @@ static struct attribute *adt7310_event_int_attributes[] = {
 	&iio_dev_attr_fault_queue.dev_attr.attr,
 	&iio_dev_attr_t_alarm_high.dev_attr.attr,
 	&iio_dev_attr_t_alarm_low.dev_attr.attr,
-	&iio_dev_attr_t_hyst.dev_attr.attr,
-	NULL,
-};
-
-static struct attribute *adt7310_event_ct_attributes[] = {
-	&iio_dev_attr_event_mode.dev_attr.attr,
-	&iio_dev_attr_available_event_modes.dev_attr.attr,
-	&iio_dev_attr_fault_queue.dev_attr.attr,
 	&iio_dev_attr_t_crit.dev_attr.attr,
 	&iio_dev_attr_t_hyst.dev_attr.attr,
 	NULL,
 };
 
-static struct attribute_group adt7310_event_attribute_group[ADT7310_IRQS] = {
-	{
-		.attrs = adt7310_event_int_attributes,
-		.name = "events",
-	}, {
-		.attrs = adt7310_event_ct_attributes,
-		.name = "events",
-	}
+static struct attribute_group adt7310_event_attribute_group = {
+	.attrs = adt7310_event_int_attributes,
+	.name = "events",
 };
 
 static const struct iio_info adt7310_info = {
 	.attrs = &adt7310_attribute_group,
-	.event_attrs = adt7310_event_attribute_group,
+	.event_attrs = &adt7310_event_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index c62248c..dff3e8c 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -693,32 +693,19 @@ static struct attribute *adt7410_event_int_attributes[] = {
 	&iio_dev_attr_fault_queue.dev_attr.attr,
 	&iio_dev_attr_t_alarm_high.dev_attr.attr,
 	&iio_dev_attr_t_alarm_low.dev_attr.attr,
-	&iio_dev_attr_t_hyst.dev_attr.attr,
-	NULL,
-};
-
-static struct attribute *adt7410_event_ct_attributes[] = {
-	&iio_dev_attr_event_mode.dev_attr.attr,
-	&iio_dev_attr_available_event_modes.dev_attr.attr,
-	&iio_dev_attr_fault_queue.dev_attr.attr,
 	&iio_dev_attr_t_crit.dev_attr.attr,
 	&iio_dev_attr_t_hyst.dev_attr.attr,
 	NULL,
 };
 
-static struct attribute_group adt7410_event_attribute_group[ADT7410_IRQS] = {
-	{
-		.attrs = adt7410_event_int_attributes,
-		.name = "events",
-	}, {
-		.attrs = adt7410_event_ct_attributes,
-		.name = "events",
-	}
+static struct attribute_group adt7410_event_attribute_group = {
+	.attrs = adt7410_event_int_attributes,
+	.name = "events",
 };
 
 static const struct iio_info adt7410_info = {
 	.attrs = &adt7410_attribute_group,
-	.event_attrs = adt7410_event_attribute_group,
+	.event_attrs = &adt7410_event_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
-- 
1.7.8.4
