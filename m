Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:12519 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab3FAHLA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jun 2013 03:11:00 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNP00CEUDA6NSF0@mailout3.samsung.com> for
 linux-iio@vger.kernel.org; Sat, 01 Jun 2013 16:10:59 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Jonathan Cameron' <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] iio: replace strict_strtoul() with kstrtoul()
Date: Sat, 01 Jun 2013 16:10:58 +0900
Message-id: <000401ce5e97$2aa80490$7ff80db0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The usage of strict_strtoul() is not preferred, because
strict_strtoul() is obsolete. Thus, kstrtoul() should be
used.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/iio/adc/max1363.c            |    2 +-
 drivers/iio/trigger/iio-trig-sysfs.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 9e6da72..f148d00 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -660,7 +660,7 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
 	unsigned long val;
 	bool found = false;
 
-	ret = strict_strtoul(buf, 10, &val);
+	ret = kstrtoul(buf, 10, &val);
 	if (ret)
 		return -EINVAL;
 	for (i = 0; i < ARRAY_SIZE(max1363_monitor_speeds); i++)
diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index b727bde..effcd0a 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -34,7 +34,7 @@ static ssize_t iio_sysfs_trig_add(struct device *dev,
 	int ret;
 	unsigned long input;
 
-	ret = strict_strtoul(buf, 10, &input);
+	ret = kstrtoul(buf, 10, &input);
 	if (ret)
 		return ret;
 	ret = iio_sysfs_trigger_probe(input);
@@ -53,7 +53,7 @@ static ssize_t iio_sysfs_trig_remove(struct device *dev,
 	int ret;
 	unsigned long input;
 
-	ret = strict_strtoul(buf, 10, &input);
+	ret = kstrtoul(buf, 10, &input);
 	if (ret)
 		return ret;
 	ret = iio_sysfs_trigger_remove(input);
-- 
1.7.10.4


