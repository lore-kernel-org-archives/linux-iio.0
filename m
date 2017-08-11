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
Subject: [PATCH v2 4/8] platform/chrome: cros_ec: register shutdown function for debugfs
Date: Fri, 11 Aug 2017 16:23:01 +0200
Message-Id: <1502461385-27564-5-git-send-email-thierry.escande@collabora.com>
In-Reply-To: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
References: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Daniel Hung-yu Wu <hywu@google.com>

Reboot or shutdown during delayed works could corrupt communication with
EC and certain I2C controller may not be able to recover from the error
state.

This patch registers a shutdown callback used to cancel the debugfs log
worker thread.

Signed-off-by: Daniel Hung-yu Wu <hywu@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/platform/chrome/cros_ec_dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/chrome/cros_ec_dev.c
index 2571f5e..225d8e9 100644
--- a/drivers/platform/chrome/cros_ec_dev.c
+++ b/drivers/platform/chrome/cros_ec_dev.c
@@ -460,6 +460,14 @@ static int ec_device_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void ec_device_shutdown(struct platform_device *pdev)
+{
+	struct cros_ec_dev *ec = dev_get_drvdata(&pdev->dev);
+
+	/* Be sure to clear up debugfs delayed works */
+	cros_ec_debugfs_remove(ec);
+}
+
 static const struct platform_device_id cros_ec_id[] = {
 	{ "cros-ec-ctl", 0 },
 	{ /* sentinel */ },
@@ -502,6 +510,7 @@ static struct platform_driver cros_ec_dev_driver = {
 	},
 	.probe = ec_device_probe,
 	.remove = ec_device_remove,
+	.shutdown = ec_device_shutdown,
 };
 
 static int __init cros_ec_dev_init(void)
-- 
2.7.4
