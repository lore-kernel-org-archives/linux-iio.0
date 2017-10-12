Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35701 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755110AbdJLJlW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Oct 2017 05:41:22 -0400
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] iio: make config_item_type const
Date: Thu, 12 Oct 2017 11:41:16 +0200
Message-Id: <1507801276-1716-1-git-send-email-bhumirks@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a followup patch for:
https://lkml.org/lkml/2017/10/11/375
https://patchwork.kernel.org/patch/9999649/
https://lkml.org/lkml/2017/10/11/469 and
https://lkml.org/lkml/2017/10/11/661

Make the config_item_type structures const as they are either passed to
the functions having the argument as const (link 2,3,4) or they are
stored in the const "ci_type" field of a config_item structure (link 1).

Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/iio/dummy/iio_simple_dummy.c   | 2 +-
 drivers/iio/industrialio-configfs.c    | 2 +-
 drivers/iio/industrialio-sw-device.c   | 6 +++---
 drivers/iio/industrialio-sw-trigger.c  | 6 +++---
 drivers/iio/trigger/iio-trig-hrtimer.c | 2 +-
 drivers/iio/trigger/iio-trig-loop.c    | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index a45d01e..6205247 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -26,7 +26,7 @@
 #include <linux/iio/sw_device.h>
 #include "iio_simple_dummy.h"
 
-static struct config_item_type iio_dummy_type = {
+static const struct config_item_type iio_dummy_type = {
 	.ct_owner = THIS_MODULE,
 };
 
diff --git a/drivers/iio/industrialio-configfs.c b/drivers/iio/industrialio-configfs.c
index 45ce2bc..5a0aae1 100644
--- a/drivers/iio/industrialio-configfs.c
+++ b/drivers/iio/industrialio-configfs.c
@@ -17,7 +17,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/configfs.h>
 
-static struct config_item_type iio_root_group_type = {
+static const struct config_item_type iio_root_group_type = {
 	.ct_owner       = THIS_MODULE,
 };
 
diff --git a/drivers/iio/industrialio-sw-device.c b/drivers/iio/industrialio-sw-device.c
index 81b49cf..90df97c 100644
--- a/drivers/iio/industrialio-sw-device.c
+++ b/drivers/iio/industrialio-sw-device.c
@@ -19,9 +19,9 @@
 #include <linux/configfs.h>
 
 static struct config_group *iio_devices_group;
-static struct config_item_type iio_device_type_group_type;
+static const struct config_item_type iio_device_type_group_type;
 
-static struct config_item_type iio_devices_group_type = {
+static const struct config_item_type iio_devices_group_type = {
 	.ct_owner = THIS_MODULE,
 };
 
@@ -156,7 +156,7 @@ static void device_drop_group(struct config_group *group,
 	.drop_item	= &device_drop_group,
 };
 
-static struct config_item_type iio_device_type_group_type = {
+static const struct config_item_type iio_device_type_group_type = {
 	.ct_group_ops = &device_ops,
 	.ct_owner       = THIS_MODULE,
 };
diff --git a/drivers/iio/industrialio-sw-trigger.c b/drivers/iio/industrialio-sw-trigger.c
index 8d24fb1..bc6b7fb 100644
--- a/drivers/iio/industrialio-sw-trigger.c
+++ b/drivers/iio/industrialio-sw-trigger.c
@@ -19,9 +19,9 @@
 #include <linux/configfs.h>
 
 static struct config_group *iio_triggers_group;
-static struct config_item_type iio_trigger_type_group_type;
+static const struct config_item_type iio_trigger_type_group_type;
 
-static struct config_item_type iio_triggers_group_type = {
+static const struct config_item_type iio_triggers_group_type = {
 	.ct_owner = THIS_MODULE,
 };
 
@@ -156,7 +156,7 @@ static void trigger_drop_group(struct config_group *group,
 	.drop_item	= &trigger_drop_group,
 };
 
-static struct config_item_type iio_trigger_type_group_type = {
+static const struct config_item_type iio_trigger_type_group_type = {
 	.ct_group_ops = &trigger_ops,
 	.ct_owner       = THIS_MODULE,
 };
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index 3ee9216..7accd01 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -30,7 +30,7 @@ struct iio_hrtimer_info {
 	ktime_t period;
 };
 
-static struct config_item_type iio_hrtimer_type = {
+static const struct config_item_type iio_hrtimer_type = {
 	.ct_owner = THIS_MODULE,
 };
 
diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
index b4b02db..94a90e0 100644
--- a/drivers/iio/trigger/iio-trig-loop.c
+++ b/drivers/iio/trigger/iio-trig-loop.c
@@ -36,7 +36,7 @@ struct iio_loop_info {
 	struct task_struct *task;
 };
 
-static struct config_item_type iio_loop_type = {
+static const struct config_item_type iio_loop_type = {
 	.ct_owner = THIS_MODULE,
 };
 
-- 
1.9.1

