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
Subject: [PATCH v2 3/8] mfd: cros_ec: Stop the debugfs work when suspended
Date: Fri, 11 Aug 2017 16:23:00 +0200
Message-Id: <1502461385-27564-4-git-send-email-thierry.escande@collabora.com>
In-Reply-To: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
References: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Douglas Anderson <dianders@chromium.org>

This patch stops the debugfs worker thread when the device is suspended.
This change avoids messages like:

  cros-ec-spi spi5.0: spi transfer failed: -108
  cros-ec-spi spi5.0: cs-deassert spi transfer failed: -108
  cros-ec-ctl cros-ec-ctl.0.auto: EC communication failed

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/platform/chrome/cros_ec_debugfs.c | 18 ++++++++++++++++++
 drivers/platform/chrome/cros_ec_debugfs.h |  2 ++
 drivers/platform/chrome/cros_ec_dev.c     |  4 ++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 4cc66f4..515f411 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -399,3 +399,21 @@ void cros_ec_debugfs_remove(struct cros_ec_dev *ec)
 	debugfs_remove_recursive(ec->debug_info->dir);
 	cros_ec_cleanup_console_log(ec->debug_info);
 }
+
+void cros_ec_debugfs_suspend(struct cros_ec_dev *ec)
+{
+	/*
+	 * cros_ec_debugfs_init() failures are non-fatal; it's also possible
+	 * that we initted things but decided that console log wasn't supported.
+	 * We'll use the same set of checks that cros_ec_debugfs_remove() +
+	 * cros_ec_cleanup_console_log() end up using to handle those cases.
+	 */
+	if (ec->debug_info && ec->debug_info->log_buffer.buf)
+		cancel_delayed_work_sync(&ec->debug_info->log_poll_work);
+}
+
+void cros_ec_debugfs_resume(struct cros_ec_dev *ec)
+{
+	if (ec->debug_info && ec->debug_info->log_buffer.buf)
+		schedule_delayed_work(&ec->debug_info->log_poll_work, 0);
+}
diff --git a/drivers/platform/chrome/cros_ec_debugfs.h b/drivers/platform/chrome/cros_ec_debugfs.h
index 1ff3a50..d29e410 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.h
+++ b/drivers/platform/chrome/cros_ec_debugfs.h
@@ -23,5 +23,7 @@
 /* debugfs stuff */
 int cros_ec_debugfs_init(struct cros_ec_dev *ec);
 void cros_ec_debugfs_remove(struct cros_ec_dev *ec);
+void cros_ec_debugfs_suspend(struct cros_ec_dev *ec);
+void cros_ec_debugfs_resume(struct cros_ec_dev *ec);
 
 #endif  /* _DRV_CROS_EC_DEBUGFS_H_ */
diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/chrome/cros_ec_dev.c
index cf6c4f0..2571f5e 100644
--- a/drivers/platform/chrome/cros_ec_dev.c
+++ b/drivers/platform/chrome/cros_ec_dev.c
@@ -470,6 +470,8 @@ static __maybe_unused int ec_device_suspend(struct device *dev)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(dev);
 
+	cros_ec_debugfs_suspend(ec);
+
 	lb_suspend(ec);
 
 	return 0;
@@ -481,6 +483,8 @@ static __maybe_unused int ec_device_resume(struct device *dev)
 
 	lb_resume(ec);
 
+	cros_ec_debugfs_resume(ec);
+
 	return 0;
 }
 
-- 
2.7.4
