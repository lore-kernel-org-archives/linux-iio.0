Return-Path: <SRS0=YBbj=KZ=gmail.com=marcus.folkesson@kernel.org>
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: mcp4725: avoid using CONFIG_PM_SLEEP
Date: Fri, 10 Aug 2018 20:51:10 +0200
Message-Id: <20180810185110.12710-3-marcus.folkesson@gmail.com>
In-Reply-To: <20180810185110.12710-1-marcus.folkesson@gmail.com>
References: <20180810185110.12710-1-marcus.folkesson@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

SIMPLE_DEV_PM_OPS() is already doing this.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/dac/mcp4725.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 8b5aad4c32d9..6d71fd905e29 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -45,7 +45,7 @@ struct mcp4725_data {
 	struct regulator *vref_reg;
 };
 
-static int mcp4725_suspend(struct device *dev)
+static int __maybe_unused mcp4725_suspend(struct device *dev)
 {
 	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
@@ -58,7 +58,7 @@ static int mcp4725_suspend(struct device *dev)
 	return i2c_master_send(data->client, outbuf, 2);
 }
 
-static int mcp4725_resume(struct device *dev)
+static int __maybe_unused mcp4725_resume(struct device *dev)
 {
 	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
@@ -71,13 +71,7 @@ static int mcp4725_resume(struct device *dev)
 
 	return i2c_master_send(data->client, outbuf, 2);
 }
-
-#ifdef CONFIG_PM_SLEEP
 static SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend, mcp4725_resume);
-#define MCP4725_PM_OPS (&mcp4725_pm_ops)
-#else
-#define MCP4725_PM_OPS NULL
-#endif
 
 static ssize_t mcp4725_store_eeprom(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
@@ -547,7 +541,7 @@ static struct i2c_driver mcp4725_driver = {
 	.driver = {
 		.name	= MCP4725_DRV_NAME,
 		.of_match_table = of_match_ptr(mcp4725_of_match),
-		.pm	= MCP4725_PM_OPS,
+		.pm	= &mcp4725_pm_ops,
 	},
 	.probe		= mcp4725_probe,
 	.remove		= mcp4725_remove,
-- 
2.11.0.rc2
