Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49245 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab1HXQUc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2011 12:20:32 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/9] staging:iio:trigger:sysfs trigger: Add a release function to avoid warning on module removal.
Date: Wed, 24 Aug 2011 17:28:35 +0100
Message-Id: <1314203321-21926-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314203321-21926-1-git-send-email-jic23@cam.ac.uk>
References: <1314203321-21926-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The device is static and should never actually be deleted. The release
is just to avoid a warning from the kernel.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/trigger/iio-trig-sysfs.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c b/drivers/staging/iio/trigger/iio-trig-sysfs.c
index 346b30c..174dc65 100644
--- a/drivers/staging/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
@@ -77,9 +77,16 @@ static const struct attribute_group *iio_sysfs_trig_groups[] = {
 	NULL
 };
 
+
+/* Nothing to actually do upon release */
+static void iio_trigger_sysfs_release(struct device *dev)
+{
+}
+
 static struct device iio_sysfs_trig_dev = {
 	.bus = &iio_bus_type,
 	.groups = iio_sysfs_trig_groups,
+	.release = &iio_trigger_sysfs_release,
 };
 
 static ssize_t iio_sysfs_trigger_poll(struct device *dev,
-- 
1.7.3.4

