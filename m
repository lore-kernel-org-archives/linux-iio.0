Return-Path: <wfp5p@viridian.itc.virginia.edu>
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: Jonathan Cameron <jic23@cam.ac.uk> ,
	linux-iio@vger.kernel.org
Subject: [PATCH 067/493] iio: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:20:16 -0500
Message-Id: <1353349642-3677-67-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
List-ID: <linux-iio@vger.kernel.org>

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Jonathan Cameron <jic23@cam.ac.uk> 
Cc: linux-iio@vger.kernel.org 
---
 drivers/iio/adc/ad7266.c        | 2 +-
 drivers/iio/adc/ad7476.c        | 2 +-
 drivers/iio/adc/ad7791.c        | 2 +-
 drivers/iio/adc/ad7887.c        | 2 +-
 drivers/iio/adc/at91_adc.c      | 2 +-
 drivers/iio/adc/lp8788_adc.c    | 2 +-
 drivers/iio/adc/max1363.c       | 2 +-
 drivers/iio/adc/ti_am335x_adc.c | 2 +-
 drivers/iio/amplifiers/ad8366.c | 2 +-
 drivers/iio/dac/ad5064.c        | 4 ++--
 drivers/iio/dac/ad5360.c        | 2 +-
 drivers/iio/dac/ad5380.c        | 4 ++--
 drivers/iio/dac/ad5421.c        | 2 +-
 drivers/iio/dac/ad5446.c        | 4 ++--
 drivers/iio/dac/ad5449.c        | 2 +-
 drivers/iio/dac/ad5504.c        | 2 +-
 drivers/iio/dac/ad5624r_spi.c   | 2 +-
 drivers/iio/dac/ad5686.c        | 2 +-
 drivers/iio/dac/ad5755.c        | 2 +-
 drivers/iio/dac/ad5764.c        | 2 +-
 drivers/iio/dac/ad5791.c        | 2 +-
 drivers/iio/dac/max517.c        | 2 +-
 drivers/iio/dac/mcp4725.c       | 2 +-
 drivers/iio/frequency/ad9523.c  | 2 +-
 drivers/iio/frequency/adf4350.c | 2 +-
 drivers/iio/light/adjd_s311.c   | 2 +-
 drivers/iio/light/lm3533-als.c  | 2 +-
 drivers/iio/light/vcnl4000.c    | 2 +-
 28 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index a6f4fc5..f872f7b 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -525,7 +525,7 @@ static struct spi_driver ad7266_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7266_probe,
-	.remove		= __devexit_p(ad7266_remove),
+	.remove		= ad7266_remove,
 	.id_table	= ad7266_id,
 };
 module_spi_driver(ad7266_driver);
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 330248b..2e88565 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -322,7 +322,7 @@ static struct spi_driver ad7476_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7476_probe,
-	.remove		= __devexit_p(ad7476_remove),
+	.remove		= ad7476_remove,
 	.id_table	= ad7476_id,
 };
 module_spi_driver(ad7476_driver);
diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index e937408..36dd192 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -450,7 +450,7 @@ static struct spi_driver ad7791_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7791_probe,
-	.remove		= __devexit_p(ad7791_remove),
+	.remove		= ad7791_remove,
 	.id_table	= ad7791_spi_ids,
 };
 module_spi_driver(ad7791_driver);
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 81153fa..70e5e74 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -368,7 +368,7 @@ static struct spi_driver ad7887_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7887_probe,
-	.remove		= __devexit_p(ad7887_remove),
+	.remove		= ad7887_remove,
 	.id_table	= ad7887_id,
 };
 module_spi_driver(ad7887_driver);
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 03b8594..34201e6 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -702,7 +702,7 @@ MODULE_DEVICE_TABLE(of, at91_adc_dt_ids);
 
 static struct platform_driver at91_adc_driver = {
 	.probe = at91_adc_probe,
-	.remove = __devexit_p(at91_adc_remove),
+	.remove = at91_adc_remove,
 	.driver = {
 		   .name = "at91_adc",
 		   .of_match_table = of_match_ptr(at91_adc_dt_ids),
diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
index a93aaf0..a053211 100644
--- a/drivers/iio/adc/lp8788_adc.c
+++ b/drivers/iio/adc/lp8788_adc.c
@@ -250,7 +250,7 @@ static int __devexit lp8788_adc_remove(struct platform_device *pdev)
 
 static struct platform_driver lp8788_adc_driver = {
 	.probe = lp8788_adc_probe,
-	.remove = __devexit_p(lp8788_adc_remove),
+	.remove = lp8788_adc_remove,
 	.driver = {
 		.name = LP8788_DEV_ADC,
 		.owner = THIS_MODULE,
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 1e84b5b..fe7bfa2 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1690,7 +1690,7 @@ static struct i2c_driver max1363_driver = {
 		.name = "max1363",
 	},
 	.probe = max1363_probe,
-	.remove = __devexit_p(max1363_remove),
+	.remove = max1363_remove,
 	.id_table = max1363_id,
 };
 module_i2c_driver(max1363_driver);
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 02a43c8..9d6c14a 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -250,7 +250,7 @@ static struct platform_driver tiadc_driver = {
 		.pm	= TIADC_PM_OPS,
 	},
 	.probe	= tiadc_probe,
-	.remove	= __devexit_p(tiadc_remove),
+	.remove	= tiadc_remove,
 };
 
 module_platform_driver(tiadc_driver);
diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index d8281cd..e738add 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -211,7 +211,7 @@ static struct spi_driver ad8366_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad8366_probe,
-	.remove		= __devexit_p(ad8366_remove),
+	.remove		= ad8366_remove,
 	.id_table	= ad8366_id,
 };
 
diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index eb281a2..6c3881b 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -563,7 +563,7 @@ static struct spi_driver ad5064_spi_driver = {
 		   .owner = THIS_MODULE,
 	},
 	.probe = ad5064_spi_probe,
-	.remove = __devexit_p(ad5064_spi_remove),
+	.remove = ad5064_spi_remove,
 	.id_table = ad5064_spi_ids,
 };
 
@@ -625,7 +625,7 @@ static struct i2c_driver ad5064_i2c_driver = {
 		   .owner = THIS_MODULE,
 	},
 	.probe = ad5064_i2c_probe,
-	.remove = __devexit_p(ad5064_i2c_remove),
+	.remove = ad5064_i2c_remove,
 	.id_table = ad5064_i2c_ids,
 };
 
diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index 8fce84f..e2c0635 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -560,7 +560,7 @@ static struct spi_driver ad5360_driver = {
 		   .owner = THIS_MODULE,
 	},
 	.probe = ad5360_probe,
-	.remove = __devexit_p(ad5360_remove),
+	.remove = ad5360_remove,
 	.id_table = ad5360_ids,
 };
 module_spi_driver(ad5360_driver);
diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 14991ac..e93e120 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -523,7 +523,7 @@ static struct spi_driver ad5380_spi_driver = {
 		   .owner = THIS_MODULE,
 	},
 	.probe = ad5380_spi_probe,
-	.remove = __devexit_p(ad5380_spi_remove),
+	.remove = ad5380_spi_remove,
 	.id_table = ad5380_spi_ids,
 };
 
@@ -597,7 +597,7 @@ static struct i2c_driver ad5380_i2c_driver = {
 		   .owner = THIS_MODULE,
 	},
 	.probe = ad5380_i2c_probe,
-	.remove = __devexit_p(ad5380_i2c_remove),
+	.remove = ad5380_i2c_remove,
 	.id_table = ad5380_i2c_ids,
 };
 
diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index cdbc5bf..cf80a7e 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -534,7 +534,7 @@ static struct spi_driver ad5421_driver = {
 		   .owner = THIS_MODULE,
 	},
 	.probe = ad5421_probe,
-	.remove = __devexit_p(ad5421_remove),
+	.remove = ad5421_remove,
 };
 module_spi_driver(ad5421_driver);
 
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 3310cbb..0b3c962 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -480,7 +480,7 @@ static struct spi_driver ad5446_spi_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad5446_spi_probe,
-	.remove		= __devexit_p(ad5446_spi_remove),
+	.remove		= ad5446_spi_remove,
 	.id_table	= ad5446_spi_ids,
 };
 
@@ -568,7 +568,7 @@ static struct i2c_driver ad5446_i2c_driver = {
 		   .owner = THIS_MODULE,
 	},
 	.probe = ad5446_i2c_probe,
-	.remove = __devexit_p(ad5446_i2c_remove),
+	.remove = ad5446_i2c_remove,
 	.id_table = ad5446_i2c_ids,
 };
 
diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index 0ee6f8e..01d4749 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -366,7 +366,7 @@ static struct spi_driver ad5449_spi_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad5449_spi_probe,
-	.remove = __devexit_p(ad5449_spi_remove),
+	.remove = ad5449_spi_remove,
 	.id_table = ad5449_spi_ids,
 };
 module_spi_driver(ad5449_spi_driver);
diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 242bdc7..2c7a2e0 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -383,7 +383,7 @@ static struct spi_driver ad5504_driver = {
 		   .owner = THIS_MODULE,
 		   },
 	.probe = ad5504_probe,
-	.remove = __devexit_p(ad5504_remove),
+	.remove = ad5504_remove,
 	.id_table = ad5504_id,
 };
 module_spi_driver(ad5504_driver);
diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index 6a7d6a4..cf75ded 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -314,7 +314,7 @@ static struct spi_driver ad5624r_driver = {
 		   .owner = THIS_MODULE,
 		   },
 	.probe = ad5624r_probe,
-	.remove = __devexit_p(ad5624r_remove),
+	.remove = ad5624r_remove,
 	.id_table = ad5624r_id,
 };
 module_spi_driver(ad5624r_driver);
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index bc92ff9..061ddb1 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -408,7 +408,7 @@ static struct spi_driver ad5686_driver = {
 		   .owner = THIS_MODULE,
 		   },
 	.probe = ad5686_probe,
-	.remove = __devexit_p(ad5686_remove),
+	.remove = ad5686_remove,
 	.id_table = ad5686_id,
 };
 module_spi_driver(ad5686_driver);
diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 5db3506..f9e112e 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -640,7 +640,7 @@ static struct spi_driver ad5755_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad5755_probe,
-	.remove = __devexit_p(ad5755_remove),
+	.remove = ad5755_remove,
 	.id_table = ad5755_id,
 };
 module_spi_driver(ad5755_driver);
diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
index ffce304..587e7b1 100644
--- a/drivers/iio/dac/ad5764.c
+++ b/drivers/iio/dac/ad5764.c
@@ -372,7 +372,7 @@ static struct spi_driver ad5764_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad5764_probe,
-	.remove = __devexit_p(ad5764_remove),
+	.remove = ad5764_remove,
 	.id_table = ad5764_ids,
 };
 module_spi_driver(ad5764_driver);
diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 2bd2e37..f40aecd 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -475,7 +475,7 @@ static struct spi_driver ad5791_driver = {
 		   .owner = THIS_MODULE,
 		   },
 	.probe = ad5791_probe,
-	.remove = __devexit_p(ad5791_remove),
+	.remove = ad5791_remove,
 	.id_table = ad5791_id,
 };
 module_spi_driver(ad5791_driver);
diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index c3d748c..cf281ff 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -232,7 +232,7 @@ static struct i2c_driver max517_driver = {
 		.pm		= MAX517_PM_OPS,
 	},
 	.probe		= max517_probe,
-	.remove		=  __devexit_p(max517_remove),
+	.remove		=  max517_remove,
 	.id_table	= max517_id,
 };
 module_i2c_driver(max517_driver);
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index e0e168b..aff873f 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -217,7 +217,7 @@ static struct i2c_driver mcp4725_driver = {
 		.pm	= MCP4725_PM_OPS,
 	},
 	.probe		= mcp4725_probe,
-	.remove		= __devexit_p(mcp4725_remove),
+	.remove		= mcp4725_remove,
 	.id_table	= mcp4725_id,
 };
 module_i2c_driver(mcp4725_driver);
diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index b737c64..73e2cd8 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -1049,7 +1049,7 @@ static struct spi_driver ad9523_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad9523_probe,
-	.remove		= __devexit_p(ad9523_remove),
+	.remove		= ad9523_remove,
 	.id_table	= ad9523_id,
 };
 module_spi_driver(ad9523_driver);
diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index e35bb8f..4c03d63 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -476,7 +476,7 @@ static struct spi_driver adf4350_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= adf4350_probe,
-	.remove		= __devexit_p(adf4350_remove),
+	.remove		= adf4350_remove,
 	.id_table	= adf4350_id,
 };
 module_spi_driver(adf4350_driver);
diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index 36d210a..82a6d71 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -354,7 +354,7 @@ static struct i2c_driver adjd_s311_driver = {
 		.name	= ADJD_S311_DRV_NAME,
 	},
 	.probe		= adjd_s311_probe,
-	.remove		= __devexit_p(adjd_s311_remove),
+	.remove		= adjd_s311_remove,
 	.id_table	= adjd_s311_id,
 };
 module_i2c_driver(adjd_s311_driver);
diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index e45712a9..c56f537 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -922,7 +922,7 @@ static struct platform_driver lm3533_als_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= lm3533_als_probe,
-	.remove		= __devexit_p(lm3533_als_remove),
+	.remove		= lm3533_als_remove,
 };
 module_platform_driver(lm3533_als_driver);
 
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index e49cb97..2556788 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -206,7 +206,7 @@ static struct i2c_driver vcnl4000_driver = {
 		.owner  = THIS_MODULE,
 	},
 	.probe  = vcnl4000_probe,
-	.remove = __devexit_p(vcnl4000_remove),
+	.remove = vcnl4000_remove,
 	.id_table = vcnl4000_id,
 };
 
-- 
1.8.0
