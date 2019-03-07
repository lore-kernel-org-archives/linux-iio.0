Return-Path: <SRS0=p+Fr=RK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D82C43381
	for <linux-iio@archiver.kernel.org>; Thu,  7 Mar 2019 00:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB3F206DD
	for <linux-iio@archiver.kernel.org>; Thu,  7 Mar 2019 00:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nPE7nfXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCGAfw (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:35:52 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:35148 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfCGAfw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Mar 2019 19:35:52 -0500
Received: by mail-io1-f71.google.com with SMTP id s9so11268981ioj.2
        for <linux-iio@vger.kernel.org>; Wed, 06 Mar 2019 16:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N5U9RLd2iVcRcO7kJlN84xuzh0i56f2UInfFfWq8ieU=;
        b=nPE7nfXUYw/u45LI/6tHWbaI0lShZMriZl3+t9AWbbvvWMHPD5wh/6CleFhWHuTigM
         y75e3sOoEtdQH/qXhdqQoKXFUXRKpf5MllS2WvtvuQnQY/UUBtqNyWM6h8yT1P523Nd0
         safvJLhOIPxtWK/UYJrKJ94J/Z37cSnUD9gdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N5U9RLd2iVcRcO7kJlN84xuzh0i56f2UInfFfWq8ieU=;
        b=W6xWKNlHdfL7t0yUwCLNEeCRE2HxzPXD4vPLPD/jV61aklxFBkG2g1jXpr+UCeqTHZ
         fHrKhUHXHHgCpkSrUZzPrY+2j+GW1ycFpBIKkX0OJiSgrtrxpyJ8x1vyMNzeSu3lh7Mh
         WIVR/J4X0QGFpBW+G1koKLZjsnCRyje+7em/6yqxdegAfD1HJuCcuxg+B4AIautZPoam
         IRuJw3hUKkOodnOKzZNze8acCzCzdvatFZoxSEor3vHkxnTJJCNuLZM4PUL4qorHZEYU
         jeLAgdi8Xlnpo98uu33he9nO5AKPQ1T/lawjoRjfBr0NbuCc6gr6Wk53Jhp7jrjbW38B
         7wRQ==
X-Gm-Message-State: APjAAAXLVxdC6zxhvDO4f+OIis0MLJcZwgYvG9FqSCOByzNWPGrbRm8q
        UionLrVpCRlw3PzIJGUJNfcRBPYAokoGynJE
X-Google-Smtp-Source: APXvYqy5sFq4uH6bRJne0bpE3zPWyfNRD7JXUV8eksAcY7wP4vxMvSnyswreqkA0ESe13uxjCeyq2U6qI2ck6CCq
X-Received: by 2002:a24:612:: with SMTP id 18mr7795306itv.7.1551918950779;
 Wed, 06 Mar 2019 16:35:50 -0800 (PST)
Date:   Wed,  6 Mar 2019 16:35:45 -0800
In-Reply-To: <CAPUE2uutkNsiVtsVfF81WcJyvSvOFWNMYbA86dSd589JnON+JA@mail.gmail.com>
Message-Id: <20190307003545.29260-1-gwendal@chromium.org>
Mime-Version: 1.0
References: <CAPUE2uutkNsiVtsVfF81WcJyvSvOFWNMYbA86dSd589JnON+JA@mail.gmail.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH v3] iio: cros_ec: Add lid angle driver
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
Changes in v3:
- Use static channel array, simplify code because index is always 0.

Changes in v2:
- Fix license, remove driver_module field.

 drivers/iio/common/cros_ec_sensors/Kconfig    |   9 ++
 drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
 .../cros_ec_sensors/cros_ec_lid_angle.c       | 138 ++++++++++++++++++
 drivers/mfd/cros_ec_dev.c                     |  15 +-
 4 files changed, 160 insertions(+), 3 deletions(-)
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
index 000000000000..92be07d7fa36
--- /dev/null
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
@@ -0,0 +1,138 @@
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
+static const struct iio_chan_spec cros_ec_lid_angle_channels[] = {
+	{
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_type.realbits = CROS_EC_SENSOR_BITS,
+		.scan_type.storagebits = CROS_EC_SENSOR_BITS,
+		.scan_type.sign = 'u',
+		.type = IIO_ANGL
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1)
+};
+
+/* State data for ec_sensors iio driver. */
+struct cros_ec_lid_angle_state {
+	/* Shared by all sensors */
+	struct cros_ec_sensors_core_state core;
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
+	*data = st->resp->lid_angle.value;
+	return 0;
+}
+
+static int cros_ec_lid_angle_read(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    int *val, int *val2, long mask)
+{
+	struct cros_ec_lid_angle_state *st = iio_priv(indio_dev);
+	s16 data;
+	int ret;
+
+	mutex_lock(&st->core.cmd_lock);
+	ret = cros_ec_sensors_read_lid_angle(indio_dev, 1, &data);
+	if (ret)
+		return ret;
+	*val = data;
+	mutex_unlock(&st->core.cmd_lock);
+	return IIO_VAL_INT;
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
+	indio_dev->channels = cros_ec_lid_angle_channels;
+	indio_dev->num_channels = ARRAY_SIZE(cros_ec_lid_angle_channels);
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
2.21.0.352.gf09ad66450-goog

