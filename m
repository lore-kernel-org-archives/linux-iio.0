Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay03-haj2.antispameurope.com ([83.246.65.53]:42827 "EHLO
	relay03-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751632Ab0IBPhv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2010 11:37:51 -0400
Received: from iis.fhg.de (iis.iis.fhg.de [153.96.172.2])
	by relay03-haj2.antispameurope.com (ASE-Secure-MTA) with SMTP id 98E5D7D4019
	for <linux-iio@vger.kernel.org>; Thu,  2 Sep 2010 17:37:48 +0200 (CEST)
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: linux-iio@vger.kernel.org
Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: [PATCH 1/2] staging:iio:trigger match leds trigger ABI
Date: Thu,  2 Sep 2010 17:37:33 +0200
Message-Id: <1283441854-31560-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
---
 drivers/staging/iio/industrialio-trigger.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 57dd923..25ee00f 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -293,11 +293,25 @@ static ssize_t iio_trigger_read_current(struct device *dev,
 					char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct iio_trigger *trig;
 	int len = 0;
-	if (dev_info->trig)
-		len = sprintf(buf,
-			      "%s\n",
-			      dev_info->trig->name);
+
+	if (!dev_info->trig)
+		len += sprintf(buf+len, "[none]");
+	else
+		len += sprintf(buf+len, "none ");
+
+	mutex_lock(&iio_trigger_list_lock);
+	list_for_each_entry(trig, &iio_trigger_list, list) {
+		if (dev_info->trig && !strcmp(dev_info->trig->name,
+						trig->name))
+			len += sprintf(buf+len, " [%s]", trig->name);
+		else
+			len += sprintf(buf+len, " %s", trig->name);
+	}
+	mutex_unlock(&iio_trigger_list_lock);
+
+	len += sprintf(len+buf, "\n");
 	return len;
 }
 
@@ -331,17 +345,16 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 	return len;
 }
 
-static DEVICE_ATTR(current_trigger, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(trigger, S_IRUGO | S_IWUSR,
 		   iio_trigger_read_current,
 		   iio_trigger_write_current);
 
 static struct attribute *iio_trigger_consumer_attrs[] = {
-	&dev_attr_current_trigger.attr,
+	&dev_attr_trigger.attr,
 	NULL,
 };
 
 static const struct attribute_group iio_trigger_consumer_attr_group = {
-	.name = "trigger",
 	.attrs = iio_trigger_consumer_attrs,
 };
 
-- 
1.7.0.6

