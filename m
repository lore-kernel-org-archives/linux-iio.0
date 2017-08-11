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
Subject: [PATCH v2 6/8] mfd: cros_ec_i2c: add ACPI module device table
Date: Fri, 11 Aug 2017 16:23:03 +0200
Message-Id: <1502461385-27564-7-git-send-email-thierry.escande@collabora.com>
In-Reply-To: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
References: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Wei-Ning Huang <wnhuang@google.com>

Add ACPI module device table for matching cros-ec devices to load the
cros_ec_i2c driver automatically.

Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
---
 drivers/mfd/cros_ec_i2c.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/cros_ec_i2c.c b/drivers/mfd/cros_ec_i2c.c
index 576fcc4..56fc667 100644
--- a/drivers/mfd/cros_ec_i2c.c
+++ b/drivers/mfd/cros_ec_i2c.c
@@ -13,6 +13,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -345,11 +346,13 @@ const struct dev_pm_ops cros_ec_i2c_pm_ops = {
 	SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_i2c_suspend, cros_ec_i2c_resume)
 };
 
+#ifdef CONFIG_OF
 static const struct of_device_id cros_ec_i2c_of_match[] = {
 	{ .compatible = "google,cros-ec-i2c", },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, cros_ec_i2c_of_match);
+#endif
 
 static const struct i2c_device_id cros_ec_i2c_id[] = {
 	{ "cros-ec-i2c", 0 },
@@ -357,9 +360,18 @@ static const struct i2c_device_id cros_ec_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cros_ec_i2c_id);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cros_ec_i2c_acpi_id[] = {
+	{ "GOOG0008", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, cros_ec_i2c_acpi_id);
+#endif
+
 static struct i2c_driver cros_ec_driver = {
 	.driver	= {
 		.name	= "cros-ec-i2c",
+		.acpi_match_table = ACPI_PTR(cros_ec_i2c_acpi_id),
 		.of_match_table = of_match_ptr(cros_ec_i2c_of_match),
 		.pm	= &cros_ec_i2c_pm_ops,
 	},
-- 
2.7.4
