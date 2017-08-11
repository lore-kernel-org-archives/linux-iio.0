Return-Path: <SRS0=SqLp=7N=collabora.com=thierry.escande@kernel.org>
From: Thierry Escande <thierry.escande@collabora.com>
To: Benson Leung <bleung@chromium.org>,
	Lee Jones <lee.jones@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Joseph Lo <josephl@nvidia.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Hung-yu Wu <hywu@google.com>,
	Vincent Palatin <vpalatin@chromium.org>,
	Wei-Ning Huang <wnhuang@google.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 7/8] platform/chrome: cros_ec: Add sysfs entry to set keyboard wake lid angle
Date: Fri, 11 Aug 2017 16:23:04 +0200
Message-Id: <1502461385-27564-8-git-send-email-thierry.escande@collabora.com>
In-Reply-To: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
References: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Gwendal Grignou <gwendal@chromium.org>

This adds a sysfs attribute (/sys/class/chromeos/cros_ec/kb_wake_angle)
used to set and get the keyboard wake lid angle. This attribute is
present only if 2 accelerometers are controlled by the EC.

This patch also moves the cros_ec features check before the device is
added so the features map obtained from the EC is ready on time.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/platform/chrome/cros_ec_dev.c   | 32 ++++++-------
 drivers/platform/chrome/cros_ec_sysfs.c | 83 +++++++++++++++++++++++++++++++++
 include/linux/mfd/cros_ec.h             |  1 +
 3 files changed, 97 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/chrome/cros_ec_dev.c
index 225d8e9..a7d711c 100644
--- a/drivers/platform/chrome/cros_ec_dev.c
+++ b/drivers/platform/chrome/cros_ec_dev.c
@@ -304,8 +304,8 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 
 	resp = (struct ec_response_motion_sense *)msg->data;
 	sensor_num = resp->dump.sensor_count;
-	/* Allocate 2 extra sensors in case lid angle or FIFO are needed */
-	sensor_cells = kzalloc(sizeof(struct mfd_cell) * (sensor_num + 2),
+	/* Allocate one extra sensor for MOTION_SENSE_FIFO if needed */
+	sensor_cells = kzalloc(sizeof(struct mfd_cell) * (sensor_num + 1),
 			       GFP_KERNEL);
 	if (sensor_cells == NULL)
 		goto error;
@@ -361,16 +361,8 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 		sensor_type[resp->info.type]++;
 		id++;
 	}
-	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2) {
-		sensor_platforms[id].sensor_num = sensor_num;
-
-		sensor_cells[id].name = "cros-ec-angle";
-		sensor_cells[id].id = 0;
-		sensor_cells[id].platform_data = &sensor_platforms[id];
-		sensor_cells[id].pdata_size =
-			sizeof(struct cros_ec_sensor_platform);
-		id++;
-	}
+	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2)
+		ec->has_kb_wake_angle = true;
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
 		sensor_cells[id].name = "cros-ec-ring";
 		id++;
@@ -423,6 +415,15 @@ static int ec_device_probe(struct platform_device *pdev)
 		goto failed;
 	}
 
+	/* check whether this EC is a sensor hub. */
+	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE)) {
+		pr_err("has EC_FEATURE_MOTION_SENSE\n");
+		cros_ec_sensors_register(ec);
+	}
+
+	/* Take control of the lightbar from the EC. */
+	lb_manual_suspend_ctrl(ec, 1);
+
 	retval = cdev_device_add(&ec->cdev, &ec->class_dev);
 	if (retval) {
 		dev_err(dev, "cdev_device_add failed => %d\n", retval);
@@ -432,13 +433,6 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (cros_ec_debugfs_init(ec))
 		dev_warn(dev, "failed to create debugfs directory\n");
 
-	/* check whether this EC is a sensor hub. */
-	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
-		cros_ec_sensors_register(ec);
-
-	/* Take control of the lightbar from the EC. */
-	lb_manual_suspend_ctrl(ec, 1);
-
 	return 0;
 
 failed:
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index f3baf99..77b4ba5 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -278,20 +278,103 @@ static ssize_t show_ec_flashinfo(struct device *dev,
 	return ret;
 }
 
+/* Keyboard wake angle control */
+
+static ssize_t show_kb_wake_angle(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct ec_response_motion_sense *resp;
+	struct ec_params_motion_sense *param;
+	struct cros_ec_command *msg;
+	int ret;
+	struct cros_ec_dev *ec = container_of(
+			dev, struct cros_ec_dev, class_dev);
+
+	msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	param = (struct ec_params_motion_sense *)msg->data;
+	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
+	msg->version = 2;
+	param->cmd = MOTIONSENSE_CMD_KB_WAKE_ANGLE;
+	param->kb_wake_angle.data = EC_MOTION_SENSE_NO_VALUE;
+	msg->outsize = sizeof(*param);
+	msg->insize = sizeof(*resp);
+	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+	if (ret < 0)
+		return ret;
+	if (msg->result != EC_RES_SUCCESS)
+		return scnprintf(buf, PAGE_SIZE, "ERROR: EC returned %d\n",
+				 msg->result);
+	resp = (struct ec_response_motion_sense *)msg->data;
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			 resp->kb_wake_angle.ret);
+}
+
+static ssize_t store_kb_wake_angle(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct ec_params_motion_sense *param;
+	struct cros_ec_command *msg;
+	int ret;
+	struct cros_ec_dev *ec = container_of(
+			dev, struct cros_ec_dev, class_dev);
+	u16 angle;
+
+	ret = kstrtou16(buf, 0, &angle);
+	if (ret)
+		return ret;
+
+	msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	param = (struct ec_params_motion_sense *)msg->data;
+	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
+	msg->version = 2;
+	param->cmd = MOTIONSENSE_CMD_KB_WAKE_ANGLE;
+	param->kb_wake_angle.data = angle;
+	msg->outsize = sizeof(*param);
+	msg->insize = sizeof(struct ec_response_motion_sense);
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+
 /* Module initialization */
 
 static DEVICE_ATTR(reboot, S_IWUSR | S_IRUGO, show_ec_reboot, store_ec_reboot);
 static DEVICE_ATTR(version, S_IRUGO, show_ec_version, NULL);
 static DEVICE_ATTR(flashinfo, S_IRUGO, show_ec_flashinfo, NULL);
+static DEVICE_ATTR(kb_wake_angle, S_IWUSR | S_IRUGO, show_kb_wake_angle,
+		   store_kb_wake_angle);
 
 static struct attribute *__ec_attrs[] = {
+	&dev_attr_kb_wake_angle.attr,
 	&dev_attr_reboot.attr,
 	&dev_attr_version.attr,
 	&dev_attr_flashinfo.attr,
 	NULL,
 };
 
+static umode_t cros_ec_ctrl_visible(struct kobject *kobj,
+				    struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
+					      class_dev);
+
+	if (a == &dev_attr_kb_wake_angle.attr && !ec->has_kb_wake_angle)
+		return 0;
+
+	return a->mode;
+}
+
 struct attribute_group cros_ec_attr_group = {
 	.attrs = __ec_attrs,
+	.is_visible = cros_ec_ctrl_visible,
 };
 
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 4e887ba..350b8a4 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -191,6 +191,7 @@ struct cros_ec_dev {
 	struct cros_ec_device *ec_dev;
 	struct device *dev;
 	struct cros_ec_debugfs *debug_info;
+	bool has_kb_wake_angle;
 	u16 cmd_offset;
 	u32 features[2];
 };
-- 
2.7.4
