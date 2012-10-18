Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-124.synserver.de ([212.40.185.124]:1038 "EHLO
	smtp-out-124.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826Ab2JRNpy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2012 09:45:54 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: Use strict_strtouint instead of kstrtoul
Date: Thu, 18 Oct 2012 15:47:07 +0200
Message-Id: <1350568027-25101-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

strict_strto* has been deprecated in favor of kstrto*. Use strict_strtouint
respective strict_strtoint, since that is what the functions we pass the
converted values to expect.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c |    6 +++---
 drivers/iio/industrialio-event.c  |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index d4ad374..722a83f 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -371,12 +371,12 @@ ssize_t iio_buffer_write_length(struct device *dev,
 				const char *buf,
 				size_t len)
 {
-	int ret;
-	ulong val;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_buffer *buffer = indio_dev->buffer;
+	unsigned int val;
+	int ret;
 
-	ret = strict_strtoul(buf, 10, &val);
+	ret = kstrtouint(buf, 10, &val);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index fa6543b..857e630 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -239,13 +239,13 @@ static ssize_t iio_ev_value_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	unsigned long val;
+	int val;
 	int ret;
 
 	if (!indio_dev->info->write_event_value)
 		return -EINVAL;
 
-	ret = strict_strtoul(buf, 10, &val);
+	ret = kstrtoint(buf, 10, &val);
 	if (ret)
 		return ret;
 
-- 
1.7.10.4

