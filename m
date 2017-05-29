Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 10/38] iio:dac: drop assignment of iio_info.driver_module
Date: Mon, 29 May 2017 16:51:26 +0100
Message-Id: <20170529155154.22580-11-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of this is now done via macro magic when
the relevant register call is made.  The actual structure
element will shortly go away.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dac/ad5064.c       | 1 -
 drivers/iio/dac/ad5360.c       | 1 -
 drivers/iio/dac/ad5380.c       | 1 -
 drivers/iio/dac/ad5421.c       | 1 -
 drivers/iio/dac/ad5446.c       | 1 -
 drivers/iio/dac/ad5449.c       | 1 -
 drivers/iio/dac/ad5504.c       | 1 -
 drivers/iio/dac/ad5592r-base.c | 1 -
 drivers/iio/dac/ad5624r_spi.c  | 1 -
 drivers/iio/dac/ad5686.c       | 1 -
 drivers/iio/dac/ad5755.c       | 1 -
 drivers/iio/dac/ad5761.c       | 1 -
 drivers/iio/dac/ad5764.c       | 1 -
 drivers/iio/dac/ad5791.c       | 1 -
 drivers/iio/dac/ad7303.c       | 1 -
 drivers/iio/dac/ad8801.c       | 1 -
 drivers/iio/dac/cio-dac.c      | 1 -
 drivers/iio/dac/dpot-dac.c     | 1 -
 drivers/iio/dac/lpc18xx_dac.c  | 1 -
 drivers/iio/dac/ltc2632.c      | 1 -
 drivers/iio/dac/m62332.c       | 1 -
 drivers/iio/dac/max517.c       | 1 -
 drivers/iio/dac/max5821.c      | 1 -
 drivers/iio/dac/mcp4725.c      | 1 -
 drivers/iio/dac/mcp4922.c      | 1 -
 drivers/iio/dac/stm32-dac.c    | 1 -
 drivers/iio/dac/vf610_dac.c    | 1 -
 27 files changed, 27 deletions(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 3f9399c27869..bf4fc40ec84d 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -366,7 +366,6 @@ static int ad5064_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5064_info = {
 	.read_raw = ad5064_read_raw,
 	.write_raw = ad5064_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_chan_spec_ext_info ad5064_ext_info[] = {
diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index 8ba0e9c50176..0209316d5566 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -425,7 +425,6 @@ static const struct iio_info ad5360_info = {
 	.read_raw = ad5360_read_raw,
 	.write_raw = ad5360_write_raw,
 	.attrs = &ad5360_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static const char * const ad5360_vref_name[] = {
diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 97d2c5111f43..845fd1c0fd9d 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -237,7 +237,6 @@ static int ad5380_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5380_info = {
 	.read_raw = ad5380_read_raw,
 	.write_raw = ad5380_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static struct iio_chan_spec_ext_info ad5380_ext_info[] = {
diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 559061ab1982..8e9633d8de67 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -465,7 +465,6 @@ static const struct iio_info ad5421_info = {
 	.read_event_config =	ad5421_read_event_config,
 	.write_event_config =	ad5421_write_event_config,
 	.read_event_value =	ad5421_read_event_value,
-	.driver_module =	THIS_MODULE,
 };
 
 static int ad5421_probe(struct spi_device *spi)
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index b555552a0d80..c6c22f3520eb 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -212,7 +212,6 @@ static int ad5446_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5446_info = {
 	.read_raw = ad5446_read_raw,
 	.write_raw = ad5446_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad5446_probe(struct device *dev, const char *name,
diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index 5f3202339420..317a74129932 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -193,7 +193,6 @@ static int ad5449_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5449_info = {
 	.read_raw = ad5449_read_raw,
 	.write_raw = ad5449_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #define AD5449_CHANNEL(chan, bits) {				\
diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 712d86b4be09..d9037ea59168 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -232,7 +232,6 @@ static const struct iio_info ad5504_info = {
 	.write_raw = ad5504_write_raw,
 	.read_raw = ad5504_read_raw,
 	.event_attrs = &ad5504_ev_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_chan_spec_ext_info ad5504_ext_info[] = {
diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 69bde5909854..9234c6a09a93 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -474,7 +474,6 @@ static const struct iio_info ad5592r_info = {
 	.read_raw = ad5592r_read_raw,
 	.write_raw = ad5592r_write_raw,
 	.write_raw_get_fmt = ad5592r_write_raw_get_fmt,
-	.driver_module = THIS_MODULE,
 };
 
 static ssize_t ad5592r_show_scale_available(struct iio_dev *iio_dev,
diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index 5489ec43b95d..13fdb4dfe356 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -149,7 +149,6 @@ static ssize_t ad5624r_write_dac_powerdown(struct iio_dev *indio_dev,
 static const struct iio_info ad5624r_info = {
 	.write_raw = ad5624r_write_raw,
 	.read_raw = ad5624r_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_chan_spec_ext_info ad5624r_ext_info[] = {
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index d1d8450c19f6..20254df7f9c7 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -252,7 +252,6 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5686_info = {
 	.read_raw = ad5686_read_raw,
 	.write_raw = ad5686_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 5f7968232564..2d03cc89ba50 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -417,7 +417,6 @@ static ssize_t ad5755_write_powerdown(struct iio_dev *indio_dev, uintptr_t priv,
 static const struct iio_info ad5755_info = {
 	.read_raw = ad5755_read_raw,
 	.write_raw = ad5755_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_chan_spec_ext_info ad5755_ext_info[] = {
diff --git a/drivers/iio/dac/ad5761.c b/drivers/iio/dac/ad5761.c
index d6510d6928b3..05017c8bbd00 100644
--- a/drivers/iio/dac/ad5761.c
+++ b/drivers/iio/dac/ad5761.c
@@ -251,7 +251,6 @@ static int ad5761_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5761_info = {
 	.read_raw = &ad5761_read_raw,
 	.write_raw = &ad5761_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #define AD5761_CHAN(_bits) {				\
diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
index 9a547bbf7d2b..033f20eca616 100644
--- a/drivers/iio/dac/ad5764.c
+++ b/drivers/iio/dac/ad5764.c
@@ -268,7 +268,6 @@ static int ad5764_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5764_info = {
 	.read_raw = ad5764_read_raw,
 	.write_raw = ad5764_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad5764_probe(struct spi_device *spi)
diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 33e4ae5c42f8..7569bf6868c2 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -340,7 +340,6 @@ static int ad5791_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5791_info = {
 	.read_raw = &ad5791_read_raw,
 	.write_raw = &ad5791_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad5791_probe(struct spi_device *spi)
diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index 4b0f942b8914..8f3bd19b6dc3 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -161,7 +161,6 @@ static int ad7303_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad7303_info = {
 	.read_raw = ad7303_read_raw,
 	.write_raw = ad7303_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_chan_spec_ext_info ad7303_ext_info[] = {
diff --git a/drivers/iio/dac/ad8801.c b/drivers/iio/dac/ad8801.c
index f06faa1aec09..aef5808c9865 100644
--- a/drivers/iio/dac/ad8801.c
+++ b/drivers/iio/dac/ad8801.c
@@ -92,7 +92,6 @@ static int ad8801_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad8801_info = {
 	.read_raw = ad8801_read_raw,
 	.write_raw = ad8801_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #define AD8801_CHANNEL(chan) {		\
diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
index a8dffd938615..6898b0c79013 100644
--- a/drivers/iio/dac/cio-dac.c
+++ b/drivers/iio/dac/cio-dac.c
@@ -85,7 +85,6 @@ static int cio_dac_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info cio_dac_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = cio_dac_read_raw,
 	.write_raw = cio_dac_write_raw
 };
diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index 960a2b430480..aaa2103d7c2b 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -128,7 +128,6 @@ static const struct iio_info dpot_dac_info = {
 	.read_raw = dpot_dac_read_raw,
 	.read_avail = dpot_dac_read_avail,
 	.write_raw = dpot_dac_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int dpot_dac_channel_max_ohms(struct iio_dev *indio_dev)
diff --git a/drivers/iio/dac/lpc18xx_dac.c b/drivers/iio/dac/lpc18xx_dac.c
index 55d1456a059d..7036f77fdf23 100644
--- a/drivers/iio/dac/lpc18xx_dac.c
+++ b/drivers/iio/dac/lpc18xx_dac.c
@@ -103,7 +103,6 @@ static int lpc18xx_dac_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info lpc18xx_dac_info = {
 	.read_raw = lpc18xx_dac_read_raw,
 	.write_raw = lpc18xx_dac_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int lpc18xx_dac_probe(struct platform_device *pdev)
diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index ac5e05f6eb8b..af2ddd0dd341 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -159,7 +159,6 @@ static ssize_t ltc2632_write_dac_powerdown(struct iio_dev *indio_dev,
 static const struct iio_info ltc2632_info = {
 	.write_raw	= ltc2632_write_raw,
 	.read_raw	= ltc2632_read_raw,
-	.driver_module	= THIS_MODULE,
 };
 
 static const struct iio_chan_spec_ext_info ltc2632_ext_info[] = {
diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 76e8b044b979..19031943dabe 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -174,7 +174,6 @@ static SIMPLE_DEV_PM_OPS(m62332_pm_ops, m62332_suspend, m62332_resume);
 static const struct iio_info m62332_info = {
 	.read_raw = m62332_read_raw,
 	.write_raw = m62332_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #define M62332_CHANNEL(chan) {					\
diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 5507b3970b4b..1d853247a205 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -137,7 +137,6 @@ static SIMPLE_DEV_PM_OPS(max517_pm_ops, max517_suspend, max517_resume);
 static const struct iio_info max517_info = {
 	.read_raw = max517_read_raw,
 	.write_raw = max517_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #define MAX517_CHANNEL(chan) {				\
diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index 193fac3059a3..d0ecc1fdd8fc 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -300,7 +300,6 @@ static SIMPLE_DEV_PM_OPS(max5821_pm_ops, max5821_suspend, max5821_resume);
 static const struct iio_info max5821_info = {
 	.read_raw = max5821_read_raw,
 	.write_raw = max5821_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int max5821_probe(struct i2c_client *client,
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 6ab1f23e5a79..afa856d10c26 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -363,7 +363,6 @@ static const struct iio_info mcp4725_info = {
 	.read_raw = mcp4725_read_raw,
 	.write_raw = mcp4725_write_raw,
 	.attrs = &mcp4725_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index 3854d201a5d6..bf9aa3fc0534 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -119,7 +119,6 @@ static const struct iio_chan_spec mcp4922_channels[3][MCP4922_NUM_CHANNELS] = {
 static const struct iio_info mcp4922_info = {
 	.read_raw = &mcp4922_read_raw,
 	.write_raw = &mcp4922_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int mcp4922_probe(struct spi_device *spi)
diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index 50f8ec091058..7790d30d52a0 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -156,7 +156,6 @@ static const struct iio_info stm32_dac_iio_info = {
 	.read_raw = stm32_dac_read_raw,
 	.write_raw = stm32_dac_write_raw,
 	.debugfs_reg_access = stm32_dac_debugfs_reg_access,
-	.driver_module = THIS_MODULE,
 };
 
 static const char * const stm32_dac_powerdown_modes[] = {
diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index c4ec7779b394..5dccdd16cab3 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -167,7 +167,6 @@ static int vf610_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info vf610_dac_iio_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &vf610_read_raw,
 	.write_raw = &vf610_write_raw,
 };
-- 
2.13.0
