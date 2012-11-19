Return-Path: <wfp5p@viridian.itc.virginia.edu>
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: Jonathan Cameron <jic23@cam.ac.uk> ,
	linux-iio@vger.kernel.org
Subject: [PATCH 406/493] iio: remove use of __devexit
Date: Mon, 19 Nov 2012 13:25:55 -0500
Message-Id: <1353349642-3677-406-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
List-ID: <linux-iio@vger.kernel.org>

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

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
 drivers/iio/dac/ad5064.c        | 6 +++---
 drivers/iio/dac/ad5360.c        | 2 +-
 drivers/iio/dac/ad5380.c        | 6 +++---
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
 28 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index f57a8d0..4a5f639b 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -494,7 +494,7 @@ error_put_reg:
 	return ret;
 }
 
-static int __devexit ad7266_remove(struct spi_device *spi)
+static int ad7266_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7266_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 72b7555..1491fa6 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -277,7 +277,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad7476_remove(struct spi_device *spi)
+static int ad7476_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7476_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 0935c5f..26db7ae 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -418,7 +418,7 @@ err_iio_free:
 	return ret;
 }
 
-static int __devexit ad7791_remove(struct spi_device *spi)
+static int ad7791_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7791_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 88ee5dc..a33d5cd 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -340,7 +340,7 @@ error_free:
 	return ret;
 }
 
-static int __devexit ad7887_remove(struct spi_device *spi)
+static int ad7887_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7887_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 5975647..04b0135 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -678,7 +678,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit at91_adc_remove(struct platform_device *pdev)
+static int at91_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *idev = platform_get_drvdata(pdev);
 	struct at91_adc_state *st = iio_priv(idev);
diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
index e96c321..72955e4 100644
--- a/drivers/iio/adc/lp8788_adc.c
+++ b/drivers/iio/adc/lp8788_adc.c
@@ -236,7 +236,7 @@ err_iio_map:
 	return ret;
 }
 
-static int __devexit lp8788_adc_remove(struct platform_device *pdev)
+static int lp8788_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct lp8788_adc *adc = iio_priv(indio_dev);
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index f3c244f..b5669be 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1624,7 +1624,7 @@ error_out:
 	return ret;
 }
 
-static int __devexit max1363_remove(struct i2c_client *client)
+static int max1363_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct max1363_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 6a0b375..cd030e1 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -188,7 +188,7 @@ err_ret:
 	return err;
 }
 
-static int __devexit tiadc_remove(struct platform_device *pdev)
+static int tiadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 
diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 1650df8..d6c0af2 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -182,7 +182,7 @@ error_put_reg:
 	return ret;
 }
 
-static int __devexit ad8366_remove(struct spi_device *spi)
+static int ad8366_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad8366_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index c9ed785..b007313 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -495,7 +495,7 @@ error_free:
 	return ret;
 }
 
-static int __devexit ad5064_remove(struct device *dev)
+static int ad5064_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad5064_state *st = iio_priv(indio_dev);
@@ -531,7 +531,7 @@ static int ad5064_spi_probe(struct spi_device *spi)
 				ad5064_spi_write);
 }
 
-static int __devexit ad5064_spi_remove(struct spi_device *spi)
+static int ad5064_spi_remove(struct spi_device *spi)
 {
 	return ad5064_remove(&spi->dev);
 }
@@ -603,7 +603,7 @@ static int ad5064_i2c_probe(struct i2c_client *i2c,
 						ad5064_i2c_write);
 }
 
-static int __devexit ad5064_i2c_remove(struct i2c_client *i2c)
+static int ad5064_i2c_remove(struct i2c_client *i2c)
 {
 	return ad5064_remove(&i2c->dev);
 }
diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index c0fae59..54b46fd 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -524,7 +524,7 @@ error_free:
 	return ret;
 }
 
-static int __devexit ad5360_remove(struct spi_device *spi)
+static int ad5360_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5360_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 835bb7f..e61852e 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -441,7 +441,7 @@ error_out:
 	return ret;
 }
 
-static int __devexit ad5380_remove(struct device *dev)
+static int ad5380_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad5380_state *st = iio_priv(indio_dev);
@@ -491,7 +491,7 @@ static int ad5380_spi_probe(struct spi_device *spi)
 	return ad5380_probe(&spi->dev, regmap, id->driver_data, id->name);
 }
 
-static int __devexit ad5380_spi_remove(struct spi_device *spi)
+static int ad5380_spi_remove(struct spi_device *spi)
 {
 	return ad5380_remove(&spi->dev);
 }
@@ -565,7 +565,7 @@ static int ad5380_i2c_probe(struct i2c_client *i2c,
 	return ad5380_probe(&i2c->dev, regmap, id->driver_data, id->name);
 }
 
-static int __devexit ad5380_i2c_remove(struct i2c_client *i2c)
+static int ad5380_i2c_remove(struct i2c_client *i2c)
 {
 	return ad5380_remove(&i2c->dev);
 }
diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 5026bfa..43be948 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -516,7 +516,7 @@ error_free:
 	return ret;
 }
 
-static int __devexit ad5421_remove(struct spi_device *spi)
+static int ad5421_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 02087a9..607126f 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -469,7 +469,7 @@ static int ad5446_spi_probe(struct spi_device *spi)
 		&ad5446_spi_chip_info[id->driver_data]);
 }
 
-static int __devexit ad5446_spi_remove(struct spi_device *spi)
+static int ad5446_spi_remove(struct spi_device *spi)
 {
 	return ad5446_remove(&spi->dev);
 }
@@ -546,7 +546,7 @@ static int ad5446_i2c_probe(struct i2c_client *i2c,
 		&ad5446_i2c_chip_info[id->driver_data]);
 }
 
-static int __devexit ad5446_i2c_remove(struct i2c_client *i2c)
+static int ad5446_i2c_remove(struct i2c_client *i2c)
 {
 	return ad5446_remove(&i2c->dev);
 }
diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index 4184be6..c4731b7 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -333,7 +333,7 @@ error_free:
 	return ret;
 }
 
-static int __devexit ad5449_spi_remove(struct spi_device *spi)
+static int ad5449_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5449 *st = iio_priv(indio_dev);
diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 531c9f4..b2a31a0 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -352,7 +352,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad5504_remove(struct spi_device *spi)
+static int ad5504_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5504_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index 4d7ff95..e994796 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -282,7 +282,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad5624r_remove(struct spi_device *spi)
+static int ad5624r_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5624r_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index a153c680..36e5138 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -379,7 +379,7 @@ error_put_reg:
 	return ret;
 }
 
-static int __devexit ad5686_remove(struct spi_device *spi)
+static int ad5686_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5686_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 3083d45..3d56620 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -614,7 +614,7 @@ error_free:
 	return ret;
 }
 
-static int __devexit ad5755_remove(struct spi_device *spi)
+static int ad5755_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
index 80302b0..7f9045e 100644
--- a/drivers/iio/dac/ad5764.c
+++ b/drivers/iio/dac/ad5764.c
@@ -340,7 +340,7 @@ error_free:
 	return ret;
 }
 
-static int __devexit ad5764_remove(struct spi_device *spi)
+static int ad5764_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5764_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 34f3c5f..c84180f 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -439,7 +439,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad5791_remove(struct spi_device *spi)
+static int ad5791_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5791_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 25b2e9c..e15fb7f 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -210,7 +210,7 @@ exit:
 	return err;
 }
 
-static int __devexit max517_remove(struct i2c_client *client)
+static int max517_remove(struct i2c_client *client)
 {
 	iio_device_unregister(i2c_get_clientdata(client));
 	iio_device_free(i2c_get_clientdata(client));
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 1f5c99a..1ccb734 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -195,7 +195,7 @@ exit:
 	return err;
 }
 
-static int __devexit mcp4725_remove(struct i2c_client *client)
+static int mcp4725_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 00c382d..8030747 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -1020,7 +1020,7 @@ error_put_reg:
 	return ret;
 }
 
-static int __devexit ad9523_remove(struct spi_device *spi)
+static int ad9523_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad9523_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index cdee2ee..e5033b4 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -440,7 +440,7 @@ error_put_reg:
 	return ret;
 }
 
-static int __devexit adf4350_remove(struct spi_device *spi)
+static int adf4350_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct adf4350_state *st = iio_priv(indio_dev);
diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index 4ad9b3d..bee3670 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -330,7 +330,7 @@ exit:
 	return err;
 }
 
-static int __devexit adjd_s311_remove(struct i2c_client *client)
+static int adjd_s311_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct adjd_s311_data *data = iio_priv(indio_dev);
diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 54d00ab..e2e54b0 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -901,7 +901,7 @@ err_free_dev:
 	return ret;
 }
 
-static int __devexit lm3533_als_remove(struct platform_device *pdev)
+static int lm3533_als_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct lm3533_als *als = iio_priv(indio_dev);
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 92b072e..a5fb5ee 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -190,7 +190,7 @@ error_free_dev:
 	return ret;
 }
 
-static int __devexit vcnl4000_remove(struct i2c_client *client)
+static int vcnl4000_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-- 
1.8.0
