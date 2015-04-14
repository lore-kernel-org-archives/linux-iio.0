Return-Path: <tiberiu.a.breana@intel.com>
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/3] iio: light: Add Power Management for STK3310
Date: Tue, 14 Apr 2015 12:32:41 +0300
Message-Id: <1429003962-13922-3-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1429003962-13922-1-git-send-email-tiberiu.a.breana@intel.com>
References: <1429003962-13922-1-git-send-email-tiberiu.a.breana@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added suspend & resume functions to the stk3310 driver.

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
 drivers/iio/light/stk3310.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 5bcf5a0..bc09304 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -82,6 +82,8 @@ enum stk3310_config_type {
 struct stk3310_data {
 	struct i2c_client *client;
 	struct mutex lock;
+	int als_enabled;
+	int ps_enabled;
 	/* Cache table for storing config values */
 	int cache[2][STK3310_TYPE_COUNT];
 };
@@ -385,6 +387,12 @@ static int stk3310_set_state(struct stk3310_data *data, u8 state)
 
 	mutex_unlock(&data->lock);
 
+	/* Don't reset the 'enabled' flags if we're going in standby */
+	if (state != STK3310_STATE_STANDBY) {
+		data->ps_enabled = (state & 0x01) ? 1 : 0;
+		data->als_enabled = (state & 0x02) ? 1 : 0;
+	}
+
 	return ret;
 }
 
@@ -461,6 +469,38 @@ static int stk3310_remove(struct i2c_client *client)
 	return stk3310_set_state(data, STK3310_STATE_STANDBY);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int stk3310_suspend(struct device *dev)
+{
+	struct stk3310_data *data;
+
+	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
+
+	return stk3310_set_state(data, STK3310_STATE_STANDBY);
+}
+
+static int stk3310_resume(struct device *dev)
+{
+	int state;
+	struct stk3310_data *data;
+
+	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
+	state = 0;
+	if (data->ps_enabled)
+		state |= STK3310_STATE_EN_PS;
+	if (data->als_enabled)
+		state |= STK3310_STATE_EN_ALS;
+
+	return stk3310_set_state(data, state);
+}
+
+static SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend, stk3310_resume);
+
+#define STK3310_PM_OPS (&stk3310_pm_ops)
+#else
+#define STK3310_PM_OPS NULL
+#endif
+
 static const struct i2c_device_id stk3310_i2c_id[] = {
 	{"STK3310", 0},
 	{"STK3311", 0},
@@ -478,6 +518,7 @@ MODULE_DEVICE_TABLE(acpi, stk3310_acpi_id);
 static struct i2c_driver stk3310_driver = {
 	.driver = {
 		.name = "stk3310",
+		.pm = STK3310_PM_OPS,
 		.acpi_match_table = ACPI_PTR(stk3310_acpi_id),
 	},
 	.probe =            stk3310_probe,
-- 
1.9.1
