Return-Path: <SRS0=4tHG=RD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96BFC43381
	for <linux-iio@archiver.kernel.org>; Thu, 28 Feb 2019 17:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E49E218AE
	for <linux-iio@archiver.kernel.org>; Thu, 28 Feb 2019 17:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NN6da99N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbfB1RmF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:42:05 -0500
Received: from mail-ot1-f71.google.com ([209.85.210.71]:33758 "EHLO
        mail-ot1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732473AbfB1RmE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Feb 2019 12:42:04 -0500
Received: by mail-ot1-f71.google.com with SMTP id e25so9976915otp.0
        for <linux-iio@vger.kernel.org>; Thu, 28 Feb 2019 09:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SR7XL8anjFk2tK8JH0lAXxA8bsGVP5gAJZC8CDWk3NY=;
        b=NN6da99NjbT6zZPhO6ofZz7aodP9mvDUjinYCmULIIRRhLuc44IXO3asd9Yoo2F6/1
         tkHW0tEoiVRue79C0+vrP2M17SqpCsXOC+0rSdtkEPul4zFxbI6yjKz9v4J4WXbUIBQu
         JwN0TdlE3hEQa/gJJPtqbwo3zT9oz+VUKWqio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SR7XL8anjFk2tK8JH0lAXxA8bsGVP5gAJZC8CDWk3NY=;
        b=ZmTSUwFoVSW5MDQYZ8qR2sIoJjxSqBI04sOxI408KOfV0O73xASAWhKRlrHCkRtS90
         NyFCoiDifbcUdrqzrKp4I2zOULqEjCp0Hzpbg5QnSDFc0oz9pcri0VYD5GePUK2F+rnH
         OPAqDiLvB+6zLfW5gniUv2EF6EzQ0NpidMcbRXRYIjbwneQbMjkj8yn6Y9GNAKF0oBsa
         DjExE2j+eJzlIkEHYFm/eiGfY6TSGzZk0SNrQT9wlJelDfZCGnnpBd0kL+u7SdR+6NgL
         O5ya9rqCLXThMqJ/ITVzhOlCBgfBKJVOA1dnOaKm6AVgKMsiqIYt65IC//MxO0oO20Zu
         h1tg==
X-Gm-Message-State: APjAAAWCF//EWe9zDl6zMdC22GLTSWdO4gSY7GjFls3PXNZqwWmzNtXP
        7RmZDMQZjwtQJdHEgZADpwWga0uhIHA0y4Hi
X-Google-Smtp-Source: APXvYqzxg/O3Gg+22lM+JUIX5jwganVvjkYJKm88KbeOCQ6HAN7z/cZGl+mZsLxBnjsd5UVG87YXJcm+PQSvH9r1
X-Received: by 2002:a05:6830:c8:: with SMTP id x8mr445090oto.12.1551375723694;
 Thu, 28 Feb 2019 09:42:03 -0800 (PST)
Date:   Thu, 28 Feb 2019 09:41:54 -0800
In-Reply-To: <CAPUE2uvHzJR-82yBdY3oxYV_-t=3Lr6n2svaf+FeN7LCzw6saA@mail.gmail.com>
Message-Id: <20190228174154.223930-1-gwendal@chromium.org>
Mime-Version: 1.0
References: <CAPUE2uvHzJR-82yBdY3oxYV_-t=3Lr6n2svaf+FeN7LCzw6saA@mail.gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH v2] iio: cros_ec: Add lid angle driver
From:   Gwendal Grignou <gwendal@chromium.org>
To:     lee.jones@linaro.org, groeck@chromium.org,
        enric.balletbo@collabora.com, bleung@chromium.org, lars@metafoo.de,
        jic23@kernel.org, egranata@chromium.org
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a IIO driver that reports the angle between the lid and the base for
ChromeOS convertible device.

Tested on eve with ToT EC firmware.
Check driver is loaded and lid angle is correct.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v2:
- Fix license, remove driver_module field.

 drivers/iio/common/cros_ec_sensors/Kconfig    |   9 +
 drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
 .../cros_ec_sensors/cros_ec_lid_angle.c       | 163 ++++++++++++++++++
 drivers/mfd/cros_ec_dev.c                     |  15 +-
 4 files changed, 185 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c

diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
index 135f6825903f..aacc2ab9c34f 100644
--- a/drivers/iio/common/cros_ec_sensors/Kconfig
+++ b/drivers/iio/common/cros_ec_sensors/Kconfig
@@ -20,3 +20,12 @@ config IIO_CROS_EC_SENSORS
 	  Accelerometers, Gyroscope and Magnetometer that are
 	  presented by the ChromeOS EC Sensor hub.
 	  Creates an IIO device for each functions.
+
+config IIO_CROS_EC_SENSORS_LID_ANGLE
+	tristate "ChromeOS EC Sensor for lid angle"
+	depends on IIO_CROS_EC_SENSORS_CORE
+	help
+	  Module to report the angle between lid and base for some
+	  convertible devices.
+	  This module is loaded when the EC can calculate the angle between the base
+	  and the lid.
diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
index ec716ff2a775..a35ee232ac07 100644
--- a/drivers/iio/common/cros_ec_sensors/Makefile
+++ b/drivers/iio/common/cros_ec_sensors/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
 obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
+obj-$(CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE) += cros_ec_lid_angle.o
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
new file mode 100644
index 000000000000..09d30976a743
--- /dev/null
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * cros_ec_lid_angle - Driver for CrOS EC lid angle sensor.
+ *
+ * Copyright 2018 Google, Inc
+ *
+ * This driver uses the cros-ec interface to communicate with the Chrome OS
+ * EC about counter sensors. Counters are presented through
+ * iio sysfs.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/cros_ec_sensors_core.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/kernel.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/mfd/cros_ec_commands.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define DRV_NAME "cros-ec-lid-angle"
+
+/*
+ * One channel for the lid angle, the other for timestamp.
+ */
+#define MAX_CHANNELS (1 + 1)
+
+/* State data for ec_sensors iio driver. */
+struct cros_ec_lid_angle_state {
+	/* Shared by all sensors */
+	struct cros_ec_sensors_core_state core;
+
+	struct iio_chan_spec channels[MAX_CHANNELS];
+};
+
+static int cros_ec_sensors_read_lid_angle(struct iio_dev *indio_dev,
+					  unsigned long scan_mask, s16 *data)
+{
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+	int ret;
+
+	st->param.cmd = MOTIONSENSE_CMD_LID_ANGLE;
+	ret = cros_ec_motion_send_host_cmd(st, sizeof(st->resp->lid_angle));
+	if (ret) {
+		dev_warn(&indio_dev->dev, "Unable to read lid angle\n");
+		return ret;
+	}
+
+	if (scan_mask & 1)
+		*data = st->resp->lid_angle.value;
+	return 0;
+}
+
+static int cros_ec_lid_angle_read(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    int *val, int *val2, long mask)
+{
+	struct cros_ec_lid_angle_state *st = iio_priv(indio_dev);
+	u16 data;
+	int ret;
+	int idx = chan->scan_index;
+
+	mutex_lock(&st->core.cmd_lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = cros_ec_sensors_read_lid_angle(
+				indio_dev, 1 << idx, &data);
+		if (ret)
+			break;
+		ret = IIO_VAL_INT;
+		*val = data;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&st->core.cmd_lock);
+	return ret;
+}
+
+static const struct iio_info cros_ec_lid_angle_info = {
+	.read_raw = &cros_ec_lid_angle_read,
+};
+
+static int cros_ec_lid_angle_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct cros_ec_lid_angle_state *state;
+	struct iio_chan_spec *channel;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, false);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &cros_ec_lid_angle_info;
+	state = iio_priv(indio_dev);
+	channel = state->channels;
+
+	channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
+	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
+	channel->scan_type.shift = 0;
+	channel->scan_index = 0;
+	channel->scan_type.sign = 'u';
+	channel->type = IIO_ANGL;
+
+	state->core.calib[0] = 0;
+
+	/* Timestamp */
+	channel++;
+	channel->type = IIO_TIMESTAMP;
+	channel->channel = -1;
+	channel->scan_index = 1;
+	channel->scan_type.sign = 's';
+	channel->scan_type.realbits = 64;
+	channel->scan_type.storagebits = 64;
+
+	indio_dev->channels = state->channels;
+	indio_dev->num_channels = MAX_CHANNELS;
+
+	state->core.read_ec_sensors_data = cros_ec_sensors_read_lid_angle;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+			cros_ec_sensors_capture, NULL);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct platform_device_id cros_ec_lid_angle_ids[] = {
+	{
+		.name = DRV_NAME,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
+
+static struct platform_driver cros_ec_lid_angle_platform_driver = {
+	.driver = {
+		.name	= DRV_NAME,
+		.pm	= &cros_ec_sensors_pm_ops,
+	},
+	.probe		= cros_ec_lid_angle_probe,
+	.id_table	= cros_ec_lid_angle_ids,
+};
+module_platform_driver(cros_ec_lid_angle_platform_driver);
+
+MODULE_DESCRIPTION("ChromeOS EC driver for reporting convertible lid angle.");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index d275deaecb12..11b5b2fd1f33 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -297,13 +297,17 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 
 	resp = (struct ec_response_motion_sense *)msg->data;
 	sensor_num = resp->dump.sensor_count;
-	/* Allocate 1 extra sensors in FIFO are needed */
-	sensor_cells = kcalloc(sensor_num + 1, sizeof(struct mfd_cell),
+	/*
+	 * Allocate extra sensors if lid angle sensor or FIFO are needed.
+	 */
+#define NUM_EXTRA_SENSORS 2
+	sensor_cells = kcalloc(sensor_num + NUM_EXTRA_SENSORS,
+			       sizeof(struct mfd_cell),
 			       GFP_KERNEL);
 	if (sensor_cells == NULL)
 		goto error;
 
-	sensor_platforms = kcalloc(sensor_num + 1,
+	sensor_platforms = kcalloc(sensor_num,
 				   sizeof(struct cros_ec_sensor_platform),
 				   GFP_KERNEL);
 	if (sensor_platforms == NULL)
@@ -363,6 +367,11 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 		sensor_cells[id].name = "cros-ec-ring";
 		id++;
 	}
+	if (cros_ec_check_features(ec,
+				EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
+		sensor_cells[id].name = "cros-ec-lid-angle";
+		id++;
+	}
 
 	ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
 			      NULL, 0, NULL);
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

