Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:44059 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035364AbcIWPTw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2016 11:19:52 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 1/4] iio:trigger: Add helper function to verify that a trigger belongs to the same device
Date: Fri, 23 Sep 2016 17:19:41 +0200
Message-Id: <1474643984-14262-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some triggers can only be attached to the IIO device that corresponds to
the same physical device. Currently each driver that requires this
implements its own trigger validation function.

Introduce a new helper function called iio_trigger_validate_own_device()
that can be used to do this check. Having a common implementation avoids
code duplication and unnecessary boiler-plate code.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
New in v3
---
 drivers/iio/industrialio-trigger.c | 21 +++++++++++++++++++++
 include/linux/iio/trigger.h        |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index e1e1048..05b2011 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -717,6 +717,27 @@ bool iio_trigger_using_own(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL(iio_trigger_using_own);
 
+/**
+ * iio_trigger_validate_own_device - Check if a trigger and IIO device belong to
+ *  the same device
+ * @trig: The IIO trigger to check
+ * @indio_devdev: the IIO device to check
+ *
+ * This function can be used as the validate_device callback for triggers that
+ * can only be attached to their own device.
+ *
+ * Return: 0 if both the trigger and the IIO device belong to the same
+ * device, -EINVAL otherwise.
+ */
+int iio_trigger_validate_own_device(struct iio_trigger *trig,
+	struct iio_dev *indio_dev)
+{
+	if (indio_dev->dev.parent != trig->dev.parent)
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL(iio_trigger_validate_own_device);
+
 void iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
 {
 	indio_dev->groups[indio_dev->groupcounter++] =
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 4f1154f..ea08302 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -170,6 +170,8 @@ void iio_trigger_free(struct iio_trigger *trig);
  */
 bool iio_trigger_using_own(struct iio_dev *indio_dev);
 
+int iio_trigger_validate_own_device(struct iio_trigger *trig,
+				     struct iio_dev *indio_dev);
 
 #else
 struct iio_trigger;
-- 
2.1.4

