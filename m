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
Subject: [PATCH v2 8/8] platform/chrome: cros_ec: sysfs: Modify error handling
Date: Fri, 11 Aug 2017 16:23:05 +0200
Message-Id: <1502461385-27564-9-git-send-email-thierry.escande@collabora.com>
In-Reply-To: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
References: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Gwendal Grignou <gwendal@chromium.org>

When accessing a sysfs attribute, if the EC command fails, -EPROTO is
now returned instead of an error message as it is unlikely an app is
parsing the error message to do something meaningful.
Also, this patch makes use of cros_ec_cmd_xfer_status() instead of
cros_ec_cmd_xfer() so an error message is printed in the syslog.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/platform/chrome/cros_ec_sysfs.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index 77b4ba5..0fd88eb 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -116,15 +116,9 @@ static ssize_t store_ec_reboot(struct device *dev,
 	msg->command = EC_CMD_REBOOT_EC + ec->cmd_offset;
 	msg->outsize = sizeof(*param);
 	msg->insize = 0;
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
-	if (ret < 0) {
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	if (ret < 0)
 		count = ret;
-		goto exit;
-	}
-	if (msg->result != EC_RES_SUCCESS) {
-		dev_dbg(ec->dev, "EC result %d\n", msg->result);
-		count = -EINVAL;
-	}
 exit:
 	kfree(msg);
 	return count;
@@ -152,17 +146,11 @@ static ssize_t show_ec_version(struct device *dev,
 	msg->command = EC_CMD_GET_VERSION + ec->cmd_offset;
 	msg->insize = sizeof(*r_ver);
 	msg->outsize = 0;
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0) {
 		count = ret;
 		goto exit;
 	}
-	if (msg->result != EC_RES_SUCCESS) {
-		count = scnprintf(buf, PAGE_SIZE,
-				  "ERROR: EC returned %d\n", msg->result);
-		goto exit;
-	}
-
 	r_ver = (struct ec_response_get_version *)msg->data;
 	/* Strings should be null-terminated, but let's be sure. */
 	r_ver->version_string_ro[sizeof(r_ver->version_string_ro) - 1] = '\0';
@@ -257,14 +245,9 @@ static ssize_t show_ec_flashinfo(struct device *dev,
 	msg->command = EC_CMD_FLASH_INFO + ec->cmd_offset;
 	msg->insize = sizeof(*resp);
 	msg->outsize = 0;
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0)
 		goto exit;
-	if (msg->result != EC_RES_SUCCESS) {
-		ret = scnprintf(buf, PAGE_SIZE,
-				"ERROR: EC returned %d\n", msg->result);
-		goto exit;
-	}
 
 	resp = (struct ec_response_flash_info *)msg->data;
 
@@ -301,12 +284,9 @@ static ssize_t show_kb_wake_angle(struct device *dev,
 	param->kb_wake_angle.data = EC_MOTION_SENSE_NO_VALUE;
 	msg->outsize = sizeof(*param);
 	msg->insize = sizeof(*resp);
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0)
 		return ret;
-	if (msg->result != EC_RES_SUCCESS)
-		return scnprintf(buf, PAGE_SIZE, "ERROR: EC returned %d\n",
-				 msg->result);
 	resp = (struct ec_response_motion_sense *)msg->data;
 	return scnprintf(buf, PAGE_SIZE, "%d\n",
 			 resp->kb_wake_angle.ret);
-- 
2.7.4
