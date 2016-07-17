Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43107 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbcGQFbJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Jul 2016 01:31:09 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Jean Delvare <jdelvare@suse.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Punit Agrawal <punit.agrawal@arm.com>,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 7/9] hwmon: (core) Add fan attribute support to new API
Date: Sat, 16 Jul 2016 22:30:30 -0700
Message-Id: <1468733432-15730-8-git-send-email-linux@roeck-us.net>
In-Reply-To: <1468733432-15730-1-git-send-email-linux@roeck-us.net>
References: <1468733432-15730-1-git-send-email-linux@roeck-us.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Acked-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No change

 drivers/hwmon/hwmon.c | 16 ++++++++++++++++
 include/linux/hwmon.h | 27 +++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index f5de80a8bd1e..38c217e64d41 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -365,6 +365,20 @@ static const char * const hwmon_humidity_attr_templates[] = {
 	[hwmon_humidity_fault] = "humidity%d_fault",
 };
 
+static const char * const hwmon_fan_attr_templates[] = {
+	[hwmon_fan_input] = "fan%d_input",
+	[hwmon_fan_label] = "fan%d_label",
+	[hwmon_fan_min] = "fan%d_min",
+	[hwmon_fan_max] = "fan%d_max",
+	[hwmon_fan_div] = "fan%d_div",
+	[hwmon_fan_pulses] = "fan%d_pulses",
+	[hwmon_fan_target] = "fan%d_target",
+	[hwmon_fan_alarm] = "fan%d_alarm",
+	[hwmon_fan_min_alarm] = "fan%d_min_alarm",
+	[hwmon_fan_max_alarm] = "fan%d_max_alarm",
+	[hwmon_fan_fault] = "fan%d_fault",
+};
+
 static const char * const *__templates[] = {
 	[hwmon_chip] = hwmon_chip_attr_templates,
 	[hwmon_temp] = hwmon_temp_attr_templates,
@@ -373,6 +387,7 @@ static const char * const *__templates[] = {
 	[hwmon_power] = hwmon_power_attr_templates,
 	[hwmon_energy] = hwmon_energy_attr_templates,
 	[hwmon_humidity] = hwmon_humidity_attr_templates,
+	[hwmon_fan] = hwmon_fan_attr_templates,
 };
 
 static const int __templates_size[] = {
@@ -383,6 +398,7 @@ static const int __templates_size[] = {
 	[hwmon_power] = ARRAY_SIZE(hwmon_power_attr_templates),
 	[hwmon_energy] = ARRAY_SIZE(hwmon_energy_attr_templates),
 	[hwmon_humidity] = ARRAY_SIZE(hwmon_humidity_attr_templates),
+	[hwmon_fan] = ARRAY_SIZE(hwmon_fan_attr_templates),
 };
 
 static int hwmon_num_channel_attrs(const struct hwmon_channel_info *info)
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 57d92f1d779b..74e89d45ff67 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -27,6 +27,7 @@ enum hwmon_sensor_types {
 	hwmon_power,
 	hwmon_energy,
 	hwmon_humidity,
+	hwmon_fan,
 };
 
 enum hwmon_chip_attributes {
@@ -245,6 +246,32 @@ enum hwmon_humidity_attributes {
 #define HWMON_H_ALARM			BIT(hwmon_humidity_alarm)
 #define HWMON_H_FAULT			BIT(hwmon_humidity_fault)
 
+enum hwmon_fan_attributes {
+	hwmon_fan_input,
+	hwmon_fan_label,
+	hwmon_fan_min,
+	hwmon_fan_max,
+	hwmon_fan_div,
+	hwmon_fan_pulses,
+	hwmon_fan_target,
+	hwmon_fan_alarm,
+	hwmon_fan_min_alarm,
+	hwmon_fan_max_alarm,
+	hwmon_fan_fault,
+};
+
+#define HWMON_F_INPUT			BIT(hwmon_fan_input)
+#define HWMON_F_LABEL			BIT(hwmon_fan_label)
+#define HWMON_F_MIN			BIT(hwmon_fan_min)
+#define HWMON_F_MAX			BIT(hwmon_fan_max)
+#define HWMON_F_DIV			BIT(hwmon_fan_div)
+#define HWMON_F_PULSES			BIT(hwmon_fan_pulses)
+#define HWMON_F_TARGET			BIT(hwmon_fan_target)
+#define HWMON_F_ALARM			BIT(hwmon_fan_alarm)
+#define HWMON_F_MIN_ALARM		BIT(hwmon_fan_min_alarm)
+#define HWMON_F_MAX_ALARM		BIT(hwmon_fan_max_alarm)
+#define HWMON_F_FAULT			BIT(hwmon_fan_fault)
+
 /**
  * struct hwmon_ops - hwmon device operations
  * @is_visible: Callback to return attribute visibility. Mandatory.
-- 
2.5.0

