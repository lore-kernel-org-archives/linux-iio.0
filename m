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
Subject: [PATCH v2 2/8] mfd: cros_ec_i2c: move the system sleep pm ops to late
Date: Fri, 11 Aug 2017 16:22:59 +0200
Message-Id: <1502461385-27564-3-git-send-email-thierry.escande@collabora.com>
In-Reply-To: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
References: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Joseph Lo <josephl@nvidia.com>

The cros_ec_i2c driver is still active after it had suspended or before it
resumes. Besides that, it also tried to transfer data even after the I2C
host had been suspended. This leads the system to crash.

During the test, we also observed that the EC needs to be resumed
earlier due to some status polling from the EC firmware (e.g. battery
status). This patch moves the PM ops to late stage to make it work
normally.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
---
 drivers/mfd/cros_ec_i2c.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cros_ec_i2c.c b/drivers/mfd/cros_ec_i2c.c
index 9f70de1..576fcc4 100644
--- a/drivers/mfd/cros_ec_i2c.c
+++ b/drivers/mfd/cros_ec_i2c.c
@@ -341,8 +341,9 @@ static int cros_ec_i2c_resume(struct device *dev)
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(cros_ec_i2c_pm_ops, cros_ec_i2c_suspend,
-			  cros_ec_i2c_resume);
+const struct dev_pm_ops cros_ec_i2c_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_i2c_suspend, cros_ec_i2c_resume)
+};
 
 static const struct of_device_id cros_ec_i2c_of_match[] = {
 	{ .compatible = "google,cros-ec-i2c", },
-- 
2.7.4
