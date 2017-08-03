Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36469 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbdHCL2x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Aug 2017 07:28:53 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: jikos@kernel.org, benjamin.tissoires@redhat.com, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 2/4] HID: sensor: constify attribute_group structures.
Date: Thu,  3 Aug 2017 16:58:35 +0530
Message-Id: <1501759715-18206-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

attribute_group are not supposed to change at runtime. All functions
working with attribute_group provided by <linux/sysfs.h> work with
const attribute_group. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hid/hid-sensor-custom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 3a84aaf..fb86f86 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -276,7 +276,7 @@ static ssize_t enable_sensor_store(struct device *dev,
 	NULL,
 };
 
-static struct attribute_group enable_sensor_attr_group = {
+static const struct attribute_group enable_sensor_attr_group = {
 	.attrs = enable_sensor_attrs,
 };
 
-- 
1.9.1

