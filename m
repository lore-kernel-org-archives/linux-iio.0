Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:37820 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab1HZKI1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 06:08:27 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 08/12] staging:iio:attrs - make address a u64 to allow event codes to be used.
Date: Fri, 26 Aug 2011 11:16:31 +0100
Message-Id: <1314353795-7437-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
References: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes unusual event related attributes look a lot more like the core ones.

V2: Make sure the utils that set these up can handle the codes.
V3: rebase

Reported-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio_core.h          |    2 +-
 drivers/staging/iio/industrialio-core.c |    5 +++--
 drivers/staging/iio/sysfs.h             |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
index 3a80dbf..803bdd8 100644
--- a/drivers/staging/iio/iio_core.h
+++ b/drivers/staging/iio/iio_core.h
@@ -22,7 +22,7 @@ int __iio_add_chan_devattr(const char *postfix,
 						struct device_attribute *attr,
 						const char *buf,
 						size_t len),
-			   int mask,
+			   u64 mask,
 			   bool generic,
 			   struct device *dev,
 			   struct list_head *attr_list);
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 49322bf..c4985cb 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -515,7 +515,7 @@ int __iio_add_chan_devattr(const char *postfix,
 						struct device_attribute *attr,
 						const char *buf,
 						size_t len),
-			   int mask,
+			   u64 mask,
 			   bool generic,
 			   struct device *dev,
 			   struct list_head *attr_list)
@@ -783,7 +783,8 @@ static ssize_t iio_ev_value_store(struct device *dev,
 static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 				      struct iio_chan_spec const *chan)
 {
-	int ret = 0, i, mask = 0, attrcount = 0;
+	int ret = 0, i, attrcount = 0;
+	u64 mask = 0;
 	char *postfix;
 	if (!chan->event_mask)
 		return 0;
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 30f9a4d..dcb413d 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -22,7 +22,7 @@ struct iio_chan_spec;
  */
 struct iio_dev_attr {
 	struct device_attribute dev_attr;
-	int address;
+	u64 address;
 	struct list_head l;
 	struct iio_chan_spec const *c;
 };
-- 
1.7.3.4

