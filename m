Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:58147 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755419AbbAIJhd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 9 Jan 2015 04:37:33 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: gregkh@linuxfoundation.org, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, rafael.j.wysocki@intel.com
Subject: [PATCH] iio kmx61 / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Fri,  9 Jan 2015 11:39:30 +0200
Message-Id: <1420796370-12158-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
depending on CONFIG_PM_RUNTIME may now be changed to depend on
CONFIG_PM.

Replace CONFIG_PM_RUNTIME with CONFIG_PM everywhere under
drivers/iio/imu/kmx61.c

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
This fixes build break when merging iio patches for 3.20
into Greg's tree.
http://marc.info/?l=linux-iio&m=142077015029632&w=2

 drivers/iio/imu/kmx61.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 841b033..4e2605e 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -735,7 +735,7 @@ static int kmx61_setup_any_motion_interrupt(struct kmx61_data *data,
  */
 static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
 {
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 	int ret;
 
 	if (device & KMX61_ACC) {
@@ -1523,7 +1523,7 @@ static int kmx61_resume(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int kmx61_runtime_suspend(struct device *dev)
 {
 	struct kmx61_data *data = i2c_get_clientdata(to_i2c_client(dev));
-- 
1.9.1

