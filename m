Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54071 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbcHAJyt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Aug 2016 05:54:49 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Olof Johansson <olof@lixom.net>, Lee Jones <lee.jones@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Vincent Palatin <vpalatin@chromium.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v4 3/4] platform/chrome: Introduce a new function to check EC features.
Date: Mon,  1 Aug 2016 11:54:37 +0200
Message-Id: <1470045278-18161-4-git-send-email-enric.balletbo@collabora.com>
In-Reply-To: <1470045278-18161-1-git-send-email-enric.balletbo@collabora.com>
References: <1470045278-18161-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Vincent Palatin <vpalatin@chromium.org>

Use the EC_CMD_GET_FEATURES message to check the supported features for
each MCU.

Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
[tomeu: adapted to changes in mainline]
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
[enric: remove references to USB PD feature and do it more generic]
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

Changes since v3:
 - Add Reviewed-by tag.

 drivers/platform/chrome/cros_ec_dev.c | 37 +++++++++++++++
 include/linux/mfd/cros_ec.h           |  1 +
 include/linux/mfd/cros_ec_commands.h  | 84 +++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/chrome/cros_ec_dev.c
index 8abd80d..7eb5307 100644
--- a/drivers/platform/chrome/cros_ec_dev.c
+++ b/drivers/platform/chrome/cros_ec_dev.c
@@ -87,6 +87,41 @@ exit:
 	return ret;
 }
 
+static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
+{
+	struct cros_ec_command *msg;
+	int ret;
+
+	if (ec->features[0] == -1U && ec->features[1] == -1U) {
+		/* features bitmap not read yet */
+
+		msg = kmalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
+		if (!msg)
+			return -ENOMEM;
+
+		msg->version = 0;
+		msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
+		msg->insize = sizeof(ec->features);
+		msg->outsize = 0;
+
+		ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+		if (ret < 0 || msg->result != EC_RES_SUCCESS) {
+			dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
+				 ret, msg->result);
+			memset(ec->features, 0, sizeof(ec->features));
+		}
+
+		memcpy(ec->features, msg->data, sizeof(ec->features));
+
+		dev_dbg(ec->dev, "EC features %08x %08x\n",
+			ec->features[0], ec->features[1]);
+
+		kfree(msg);
+	}
+
+	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
+}
+
 /* Device file ops */
 static int ec_device_open(struct inode *inode, struct file *filp)
 {
@@ -245,6 +280,8 @@ static int ec_device_probe(struct platform_device *pdev)
 	ec->ec_dev = dev_get_drvdata(dev->parent);
 	ec->dev = dev;
 	ec->cmd_offset = ec_platform->cmd_offset;
+	ec->features[0] = -1U; /* Not cached yet */
+	ec->features[1] = -1U; /* Not cached yet */
 	device_initialize(&ec->class_dev);
 	cdev_init(&ec->cdev, &fops);
 
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 7769ea6..7f039b2 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -187,6 +187,7 @@ struct cros_ec_dev {
 	struct cros_ec_device *ec_dev;
 	struct device *dev;
 	u16 cmd_offset;
+	u32 features[2];
 };
 
 /**
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 8826e0f..1683003 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -713,6 +713,90 @@ struct ec_response_get_set_value {
 /* More than one command can use these structs to get/set paramters. */
 #define EC_CMD_GSV_PAUSE_IN_S5	0x0c
 
+/*****************************************************************************/
+/* List the features supported by the firmware */
+#define EC_CMD_GET_FEATURES  0x0d
+
+/* Supported features */
+enum ec_feature_code {
+	/*
+	 * This image contains a limited set of features. Another image
+	 * in RW partition may support more features.
+	 */
+	EC_FEATURE_LIMITED = 0,
+	/*
+	 * Commands for probing/reading/writing/erasing the flash in the
+	 * EC are present.
+	 */
+	EC_FEATURE_FLASH = 1,
+	/*
+	 * Can control the fan speed directly.
+	 */
+	EC_FEATURE_PWM_FAN = 2,
+	/*
+	 * Can control the intensity of the keyboard backlight.
+	 */
+	EC_FEATURE_PWM_KEYB = 3,
+	/*
+	 * Support Google lightbar, introduced on Pixel.
+	 */
+	EC_FEATURE_LIGHTBAR = 4,
+	/* Control of LEDs  */
+	EC_FEATURE_LED = 5,
+	/* Exposes an interface to control gyro and sensors.
+	 * The host goes through the EC to access these sensors.
+	 * In addition, the EC may provide composite sensors, like lid angle.
+	 */
+	EC_FEATURE_MOTION_SENSE = 6,
+	/* The keyboard is controlled by the EC */
+	EC_FEATURE_KEYB = 7,
+	/* The AP can use part of the EC flash as persistent storage. */
+	EC_FEATURE_PSTORE = 8,
+	/* The EC monitors BIOS port 80h, and can return POST codes. */
+	EC_FEATURE_PORT80 = 9,
+	/*
+	 * Thermal management: include TMP specific commands.
+	 * Higher level than direct fan control.
+	 */
+	EC_FEATURE_THERMAL = 10,
+	/* Can switch the screen backlight on/off */
+	EC_FEATURE_BKLIGHT_SWITCH = 11,
+	/* Can switch the wifi module on/off */
+	EC_FEATURE_WIFI_SWITCH = 12,
+	/* Monitor host events, through for example SMI or SCI */
+	EC_FEATURE_HOST_EVENTS = 13,
+	/* The EC exposes GPIO commands to control/monitor connected devices. */
+	EC_FEATURE_GPIO = 14,
+	/* The EC can send i2c messages to downstream devices. */
+	EC_FEATURE_I2C = 15,
+	/* Command to control charger are included */
+	EC_FEATURE_CHARGER = 16,
+	/* Simple battery support. */
+	EC_FEATURE_BATTERY = 17,
+	/*
+	 * Support Smart battery protocol
+	 * (Common Smart Battery System Interface Specification)
+	 */
+	EC_FEATURE_SMART_BATTERY = 18,
+	/* EC can dectect when the host hangs. */
+	EC_FEATURE_HANG_DETECT = 19,
+	/* Report power information, for pit only */
+	EC_FEATURE_PMU = 20,
+	/* Another Cros EC device is present downstream of this one */
+	EC_FEATURE_SUB_MCU = 21,
+	/* Support USB Power delivery (PD) commands */
+	EC_FEATURE_USB_PD = 22,
+	/* Control USB multiplexer, for audio through USB port for instance. */
+	EC_FEATURE_USB_MUX = 23,
+	/* Motion Sensor code has an internal software FIFO */
+	EC_FEATURE_MOTION_SENSE_FIFO = 24,
+};
+
+#define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
+#define EC_FEATURE_MASK_1(event_code) (1UL << (event_code - 32))
+struct ec_response_get_features {
+	uint32_t flags[2];
+} __packed;
 
 /*****************************************************************************/
 /* Flash commands */
-- 
2.1.0

