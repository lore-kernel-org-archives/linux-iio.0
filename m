Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55298 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754225AbdKJV4P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Nov 2017 16:56:15 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>, bleung@chromium.org
Cc: Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rtc-linux@googlegroups.com, Stephen Barber <smbarber@chromium.org>
Subject: [PATCH v4 2/2] rtc: cros-ec: add cros-ec-rtc driver.
Date: Fri, 10 Nov 2017 22:55:53 +0100
Message-Id: <20171110215553.20696-3-enric.balletbo@collabora.com>
In-Reply-To: <20171110215553.20696-1-enric.balletbo@collabora.com>
References: <20171110215553.20696-1-enric.balletbo@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Stephen Barber <smbarber@chromium.org>

On platforms with a Chrome OS EC, the EC can function as a simple RTC.
Add a basic driver with this functionality.

Signed-off-by: Stephen Barber <smbarber@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Benson Leung <bleung@chromium.org>
---
 drivers/rtc/Kconfig       |  10 ++
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-cros-ec.c | 413 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 424 insertions(+)
 create mode 100644 drivers/rtc/rtc-cros-ec.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e0e58f3..f157288 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1231,6 +1231,16 @@ config RTC_DRV_ZYNQMP
 	  If you say yes here you get support for the RTC controller found on
 	  Xilinx Zynq Ultrascale+ MPSoC.
 
+config RTC_DRV_CROS_EC
+	tristate "Chrome OS EC RTC driver"
+	depends on MFD_CROS_EC
+	help
+	  If you say yes here you will get support for the
+	  Chrome OS Embedded Controller's RTC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-cros-ec.
+
 comment "on-CPU RTC drivers"
 
 config RTC_DRV_ASM9260
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 0bf1fc0..08789d7 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_RTC_DRV_BQ4802)	+= rtc-bq4802.o
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc-cmos.o
 obj-$(CONFIG_RTC_DRV_COH901331)	+= rtc-coh901331.o
 obj-$(CONFIG_RTC_DRV_CPCAP)	+= rtc-cpcap.o
+obj-$(CONFIG_RTC_DRV_CROS_EC)	+= rtc-cros-ec.o
 obj-$(CONFIG_RTC_DRV_DA9052)	+= rtc-da9052.o
 obj-$(CONFIG_RTC_DRV_DA9055)	+= rtc-da9055.o
 obj-$(CONFIG_RTC_DRV_DA9063)	+= rtc-da9063.o
diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
new file mode 100644
index 0000000..f0ea689
--- /dev/null
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -0,0 +1,413 @@
+/*
+ * RTC driver for Chrome OS Embedded Controller
+ *
+ * Copyright (c) 2017, Google, Inc
+ *
+ * Author: Stephen Barber <smbarber@chromium.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/mfd/cros_ec_commands.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
+
+#define DRV_NAME	"cros-ec-rtc"
+
+/**
+ * struct cros_ec_rtc - Driver data for EC RTC
+ *
+ * @cros_ec: Pointer to EC device
+ * @rtc: Pointer to RTC device
+ * @notifier: Notifier info for responding to EC events
+ * @saved_alarm: Alarm to restore when interrupts are reenabled
+ */
+struct cros_ec_rtc {
+	struct cros_ec_device *cros_ec;
+	struct rtc_device *rtc;
+	struct notifier_block notifier;
+	u32 saved_alarm;
+};
+
+static int cros_ec_rtc_get(struct cros_ec_device *cros_ec, u32 command,
+			   u32 *response)
+{
+	int ret;
+	struct {
+		struct cros_ec_command msg;
+		struct ec_response_rtc data;
+	} __packed msg;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg.command = command;
+	msg.msg.insize = sizeof(msg.data);
+
+	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
+	if (ret < 0) {
+		dev_err(cros_ec->dev,
+			"error getting %s from EC: %d\n",
+			command == EC_CMD_RTC_GET_VALUE ? "time" : "alarm",
+			ret);
+		return ret;
+	}
+
+	*response = msg.data.time;
+
+	return 0;
+}
+
+static int cros_ec_rtc_set(struct cros_ec_device *cros_ec, u32 command,
+			   u32 param)
+{
+	int ret = 0;
+	struct {
+		struct cros_ec_command msg;
+		struct ec_response_rtc data;
+	} __packed msg;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg.command = command;
+	msg.msg.outsize = sizeof(msg.data);
+	msg.data.time = param;
+
+	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
+	if (ret < 0) {
+		dev_err(cros_ec->dev, "error setting %s on EC: %d\n",
+			command == EC_CMD_RTC_SET_VALUE ? "time" : "alarm",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/* Read the current time from the EC. */
+static int cros_ec_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct cros_ec_rtc *cros_ec_rtc = dev_get_drvdata(dev);
+	struct cros_ec_device *cros_ec = cros_ec_rtc->cros_ec;
+	int ret;
+	u32 time;
+
+	ret = cros_ec_rtc_get(cros_ec, EC_CMD_RTC_GET_VALUE, &time);
+	if (ret) {
+		dev_err(dev, "error getting time: %d\n", ret);
+		return ret;
+	}
+
+	rtc_time64_to_tm(time, tm);
+
+	return 0;
+}
+
+/* Set the current EC time. */
+static int cros_ec_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct cros_ec_rtc *cros_ec_rtc = dev_get_drvdata(dev);
+	struct cros_ec_device *cros_ec = cros_ec_rtc->cros_ec;
+	int ret;
+	time64_t time;
+
+	time = rtc_tm_to_time64(tm);
+	if (time < 0 || time > U32_MAX)
+		return -EINVAL;
+
+	ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_VALUE, (u32)time);
+	if (ret < 0) {
+		dev_err(dev, "error setting time: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/* Read alarm time from RTC. */
+static int cros_ec_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct cros_ec_rtc *cros_ec_rtc = dev_get_drvdata(dev);
+	struct cros_ec_device *cros_ec = cros_ec_rtc->cros_ec;
+	int ret;
+	u32 current_time, alarm_offset;
+
+	/*
+	 * The EC host command for getting the alarm is relative (i.e. 5
+	 * seconds from now) whereas rtc_wkalrm is absolute. Get the current
+	 * RTC time first so we can calculate the relative time.
+	 */
+	ret = cros_ec_rtc_get(cros_ec, EC_CMD_RTC_GET_VALUE, &current_time);
+	if (ret < 0) {
+		dev_err(dev, "error getting time: %d\n", ret);
+		return ret;
+	}
+
+	ret = cros_ec_rtc_get(cros_ec, EC_CMD_RTC_GET_ALARM, &alarm_offset);
+	if (ret < 0) {
+		dev_err(dev, "error getting alarm: %d\n", ret);
+		return ret;
+	}
+
+	rtc_time64_to_tm(current_time + alarm_offset, &alrm->time);
+
+	return 0;
+}
+
+/* Set the EC's RTC alarm. */
+static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct cros_ec_rtc *cros_ec_rtc = dev_get_drvdata(dev);
+	struct cros_ec_device *cros_ec = cros_ec_rtc->cros_ec;
+	int ret;
+	time64_t alarm_time;
+	u32 current_time, alarm_offset;
+
+	/*
+	 * The EC host command for setting the alarm is relative
+	 * (i.e. 5 seconds from now) whereas rtc_wkalrm is absolute.
+	 * Get the current RTC time first so we can calculate the
+	 * relative time.
+	 */
+	ret = cros_ec_rtc_get(cros_ec, EC_CMD_RTC_GET_VALUE, &current_time);
+	if (ret < 0) {
+		dev_err(dev, "error getting time: %d\n", ret);
+		return ret;
+	}
+
+	alarm_time = rtc_tm_to_time64(&alrm->time);
+
+	if (alarm_time < 0 || alarm_time > U32_MAX)
+		return -EINVAL;
+
+	if (!alrm->enabled) {
+		/*
+		 * If the alarm is being disabled, send an alarm
+		 * clear command.
+		 */
+		alarm_offset = EC_RTC_ALARM_CLEAR;
+		cros_ec_rtc->saved_alarm = (u32)alarm_time;
+	} else {
+		/* Don't set an alarm in the past. */
+		if ((u32)alarm_time < current_time)
+			alarm_offset = EC_RTC_ALARM_CLEAR;
+		else
+			alarm_offset = (u32)alarm_time - current_time;
+	}
+
+	ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM, alarm_offset);
+	if (ret < 0) {
+		dev_err(dev, "error setting alarm: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cros_ec_rtc_alarm_irq_enable(struct device *dev,
+					unsigned int enabled)
+{
+	struct cros_ec_rtc *cros_ec_rtc = dev_get_drvdata(dev);
+	struct cros_ec_device *cros_ec = cros_ec_rtc->cros_ec;
+	int ret;
+	u32 current_time, alarm_offset, alarm_value;
+
+	ret = cros_ec_rtc_get(cros_ec, EC_CMD_RTC_GET_VALUE, &current_time);
+	if (ret < 0) {
+		dev_err(dev, "error getting time: %d\n", ret);
+		return ret;
+	}
+
+	if (enabled) {
+		/* Restore saved alarm if it's still in the future. */
+		if (cros_ec_rtc->saved_alarm < current_time)
+			alarm_offset = EC_RTC_ALARM_CLEAR;
+		else
+			alarm_offset = cros_ec_rtc->saved_alarm - current_time;
+
+		ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM,
+				      alarm_offset);
+		if (ret < 0) {
+			dev_err(dev, "error restoring alarm: %d\n", ret);
+			return ret;
+		}
+	} else {
+		/* Disable alarm, saving the old alarm value. */
+		ret = cros_ec_rtc_get(cros_ec, EC_CMD_RTC_GET_ALARM,
+				      &alarm_offset);
+		if (ret < 0) {
+			dev_err(dev, "error saving alarm: %d\n", ret);
+			return ret;
+		}
+
+		alarm_value = current_time + alarm_offset;
+
+		/*
+		 * If the current EC alarm is already past, we don't want
+		 * to set an alarm when we go through the alarm irq enable
+		 * path.
+		 */
+		if (alarm_value < current_time)
+			cros_ec_rtc->saved_alarm = EC_RTC_ALARM_CLEAR;
+		else
+			cros_ec_rtc->saved_alarm = alarm_value;
+
+		alarm_offset = EC_RTC_ALARM_CLEAR;
+		ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM,
+				      alarm_offset);
+		if (ret < 0) {
+			dev_err(dev, "error disabling alarm: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int cros_ec_rtc_event(struct notifier_block *nb,
+			     unsigned long queued_during_suspend,
+			     void *_notify)
+{
+	struct cros_ec_rtc *cros_ec_rtc;
+	struct rtc_device *rtc;
+	struct cros_ec_device *cros_ec;
+	u32 host_event;
+
+	cros_ec_rtc = container_of(nb, struct cros_ec_rtc, notifier);
+	rtc = cros_ec_rtc->rtc;
+	cros_ec = cros_ec_rtc->cros_ec;
+
+	host_event = cros_ec_get_host_event(cros_ec);
+	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_RTC)) {
+		rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
+		return NOTIFY_OK;
+	} else {
+		return NOTIFY_DONE;
+	}
+}
+
+static const struct rtc_class_ops cros_ec_rtc_ops = {
+	.read_time = cros_ec_rtc_read_time,
+	.set_time = cros_ec_rtc_set_time,
+	.read_alarm = cros_ec_rtc_read_alarm,
+	.set_alarm = cros_ec_rtc_set_alarm,
+	.alarm_irq_enable = cros_ec_rtc_alarm_irq_enable,
+};
+
+#ifdef CONFIG_PM_SLEEP
+static int cros_ec_rtc_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct cros_ec_rtc *cros_ec_rtc = dev_get_drvdata(&pdev->dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(cros_ec_rtc->cros_ec->irq);
+
+	return 0;
+}
+
+static int cros_ec_rtc_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct cros_ec_rtc *cros_ec_rtc = dev_get_drvdata(&pdev->dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(cros_ec_rtc->cros_ec->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(cros_ec_rtc_pm_ops, cros_ec_rtc_suspend,
+			 cros_ec_rtc_resume);
+
+static int cros_ec_rtc_probe(struct platform_device *pdev)
+{
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(pdev->dev.parent);
+	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
+	struct cros_ec_rtc *cros_ec_rtc;
+	struct rtc_time tm;
+	int ret;
+
+	cros_ec_rtc = devm_kzalloc(&pdev->dev, sizeof(*cros_ec_rtc),
+				   GFP_KERNEL);
+	if (!cros_ec_rtc)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, cros_ec_rtc);
+	cros_ec_rtc->cros_ec = cros_ec;
+
+	/* Get initial time */
+	ret = cros_ec_rtc_read_time(&pdev->dev, &tm);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to read RTC time\n");
+		return ret;
+	}
+
+	ret = device_init_wakeup(&pdev->dev, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize wakeup\n");
+		return ret;
+	}
+
+	cros_ec_rtc->rtc = devm_rtc_device_register(&pdev->dev, DRV_NAME,
+						    &cros_ec_rtc_ops,
+						    THIS_MODULE);
+	if (IS_ERR(cros_ec_rtc->rtc)) {
+		ret = PTR_ERR(cros_ec_rtc->rtc);
+		dev_err(&pdev->dev, "failed to register rtc device\n");
+		return ret;
+	}
+
+	/* Get RTC events from the EC. */
+	cros_ec_rtc->notifier.notifier_call = cros_ec_rtc_event;
+	ret = blocking_notifier_chain_register(&cros_ec->event_notifier,
+					       &cros_ec_rtc->notifier);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register notifier\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cros_ec_rtc_remove(struct platform_device *pdev)
+{
+	struct cros_ec_rtc *cros_ec_rtc = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = blocking_notifier_chain_unregister(
+				&cros_ec_rtc->cros_ec->event_notifier,
+				&cros_ec_rtc->notifier);
+	if (ret) {
+		dev_err(dev, "failed to unregister notifier\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver cros_ec_rtc_driver = {
+	.probe = cros_ec_rtc_probe,
+	.remove = cros_ec_rtc_remove,
+	.driver = {
+		.name = DRV_NAME,
+		.pm = &cros_ec_rtc_pm_ops,
+	},
+};
+
+module_platform_driver(cros_ec_rtc_driver);
+
+MODULE_DESCRIPTION("RTC driver for Chrome OS ECs");
+MODULE_AUTHOR("Stephen Barber <smbarber@chromium.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.9.3

