Return-Path: <wfp5p@viridian.itc.virginia.edu>
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: Jonathan Cameron <jic23@cam.ac.uk> ,
	linux-iio@vger.kernel.org
Subject: [PATCH 209/493] iio: remove use of __devinit
Date: Mon, 19 Nov 2012 13:22:38 -0500
Message-Id: <1353349642-3677-209-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
List-ID: <linux-iio@vger.kernel.org>

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Jonathan Cameron <jic23@cam.ac.uk> 
Cc: linux-iio@vger.kernel.org 
---
 drivers/iio/accel/hid-sensor-accel-3d.c       |  4 ++--
 drivers/iio/adc/ad7266.c                      |  4 ++--
 drivers/iio/adc/ad7476.c                      |  2 +-
 drivers/iio/adc/ad7791.c                      |  4 ++--
 drivers/iio/adc/ad7887.c                      |  2 +-
 drivers/iio/adc/at91_adc.c                    |  2 +-
 drivers/iio/adc/lp8788_adc.c                  |  2 +-
 drivers/iio/adc/max1363.c                     |  6 +++---
 drivers/iio/adc/ti_am335x_adc.c               |  2 +-
 drivers/iio/amplifiers/ad8366.c               |  2 +-
 drivers/iio/dac/ad5064.c                      |  6 +++---
 drivers/iio/dac/ad5360.c                      |  4 ++--
 drivers/iio/dac/ad5380.c                      |  8 ++++----
 drivers/iio/dac/ad5421.c                      |  2 +-
 drivers/iio/dac/ad5446.c                      |  6 +++---
 drivers/iio/dac/ad5449.c                      |  2 +-
 drivers/iio/dac/ad5504.c                      |  2 +-
 drivers/iio/dac/ad5624r_spi.c                 |  2 +-
 drivers/iio/dac/ad5686.c                      |  2 +-
 drivers/iio/dac/ad5755.c                      |  8 ++++----
 drivers/iio/dac/ad5764.c                      |  2 +-
 drivers/iio/dac/ad5791.c                      |  2 +-
 drivers/iio/dac/max517.c                      |  2 +-
 drivers/iio/dac/mcp4725.c                     |  2 +-
 drivers/iio/frequency/ad9523.c                |  2 +-
 drivers/iio/frequency/adf4350.c               |  2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         |  4 ++--
 drivers/iio/light/adjd_s311.c                 |  2 +-
 drivers/iio/light/hid-sensor-als.c            |  4 ++--
 drivers/iio/light/lm3533-als.c                | 12 ++++++------
 drivers/iio/light/vcnl4000.c                  |  2 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c |  4 ++--
 32 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index a95cda0..4745158 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -278,7 +278,7 @@ static int accel_3d_parse_report(struct platform_device *pdev,
 }
 
 /* Function to initialize the processing for usage id */
-static int __devinit hid_accel_3d_probe(struct platform_device *pdev)
+static int hid_accel_3d_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	static const char *name = "accel_3d";
@@ -375,7 +375,7 @@ error_ret:
 }
 
 /* Function to deinitialize the processing for usage id */
-static int __devinit hid_accel_3d_remove(struct platform_device *pdev)
+static int hid_accel_3d_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index f872f7b..f57a8d0 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -367,7 +367,7 @@ static const struct ad7266_chan_info ad7266_chan_infos[] = {
 	},
 };
 
-static void __devinit ad7266_init_channels(struct iio_dev *indio_dev)
+static void ad7266_init_channels(struct iio_dev *indio_dev)
 {
 	struct ad7266_state *st = iio_priv(indio_dev);
 	bool is_differential, is_signed;
@@ -391,7 +391,7 @@ static const char * const ad7266_gpio_labels[] = {
 	"AD0", "AD1", "AD2",
 };
 
-static int __devinit ad7266_probe(struct spi_device *spi)
+static int ad7266_probe(struct spi_device *spi)
 {
 	struct ad7266_platform_data *pdata = spi->dev.platform_data;
 	struct iio_dev *indio_dev;
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 2e88565..72b7555 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -207,7 +207,7 @@ static const struct iio_info ad7476_info = {
 	.read_raw = &ad7476_read_raw,
 };
 
-static int __devinit ad7476_probe(struct spi_device *spi)
+static int ad7476_probe(struct spi_device *spi)
 {
 	struct ad7476_state *st;
 	struct iio_dev *indio_dev;
diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 36dd192..0935c5f 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -325,7 +325,7 @@ static const struct iio_info ad7791_no_filter_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ad7791_setup(struct ad7791_state *st,
+static int ad7791_setup(struct ad7791_state *st,
 	struct ad7791_platform_data *pdata)
 {
 	/* Set to poweron-reset default values */
@@ -349,7 +349,7 @@ static int __devinit ad7791_setup(struct ad7791_state *st,
 		st->mode);
 }
 
-static int __devinit ad7791_probe(struct spi_device *spi)
+static int ad7791_probe(struct spi_device *spi)
 {
 	struct ad7791_platform_data *pdata = spi->dev.platform_data;
 	struct iio_dev *indio_dev;
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 70e5e74..88ee5dc 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -233,7 +233,7 @@ static const struct iio_info ad7887_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ad7887_probe(struct spi_device *spi)
+static int ad7887_probe(struct spi_device *spi)
 {
 	struct ad7887_platform_data *pdata = spi->dev.platform_data;
 	struct ad7887_state *st;
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 34201e6..5975647 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -514,7 +514,7 @@ static const struct iio_info at91_adc_info = {
 	.read_raw = &at91_adc_read_raw,
 };
 
-static int __devinit at91_adc_probe(struct platform_device *pdev)
+static int at91_adc_probe(struct platform_device *pdev)
 {
 	unsigned int prsc, mstrclk, ticks, adc_clk;
 	int ret;
diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
index a053211..e96c321 100644
--- a/drivers/iio/adc/lp8788_adc.c
+++ b/drivers/iio/adc/lp8788_adc.c
@@ -193,7 +193,7 @@ static inline void lp8788_iio_map_unregister(struct iio_dev *indio_dev,
 	iio_map_array_unregister(indio_dev, adc->map);
 }
 
-static int __devinit lp8788_adc_probe(struct platform_device *pdev)
+static int lp8788_adc_probe(struct platform_device *pdev)
 {
 	struct lp8788 *lp = dev_get_drvdata(pdev->dev.parent);
 	struct iio_dev *indio_dev;
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index fe7bfa2..f3c244f 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1402,7 +1402,7 @@ static int max1363_initial_setup(struct max1363_state *st)
 	return max1363_set_scan_mode(st);
 }
 
-static int __devinit max1363_alloc_scan_masks(struct iio_dev *indio_dev)
+static int max1363_alloc_scan_masks(struct iio_dev *indio_dev)
 {
 	struct max1363_state *st = iio_priv(indio_dev);
 	unsigned long *masks;
@@ -1525,8 +1525,8 @@ static void max1363_buffer_cleanup(struct iio_dev *indio_dev)
 	iio_kfifo_free(indio_dev->buffer);
 }
 
-static int __devinit max1363_probe(struct i2c_client *client,
-				   const struct i2c_device_id *id)
+static int max1363_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
 {
 	int ret;
 	struct max1363_state *st;
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 9d6c14a..6a0b375 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -136,7 +136,7 @@ static const struct iio_info tiadc_info = {
 	.read_raw = &tiadc_read_raw,
 };
 
-static int __devinit tiadc_probe(struct platform_device *pdev)
+static int tiadc_probe(struct platform_device *pdev)
 {
 	struct iio_dev		*indio_dev;
 	struct tiadc_device	*adc_dev;
diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index e738add..1650df8 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -133,7 +133,7 @@ static const struct iio_chan_spec ad8366_channels[] = {
 	AD8366_CHAN(1),
 };
 
-static int __devinit ad8366_probe(struct spi_device *spi)
+static int ad8366_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct ad8366_state *st;
diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 6c3881b..c9ed785 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -424,7 +424,7 @@ static const char * const ad5064_vref_name(struct ad5064_state *st,
 	return st->chip_info->shared_vref ? "vref" : ad5064_vref_names[vref];
 }
 
-static int __devinit ad5064_probe(struct device *dev, enum ad5064_type type,
+static int ad5064_probe(struct device *dev, enum ad5064_type type,
 	const char *name, ad5064_write_func write)
 {
 	struct iio_dev *indio_dev;
@@ -523,7 +523,7 @@ static int ad5064_spi_write(struct ad5064_state *st, unsigned int cmd,
 	return spi_write(spi, &st->data.spi, sizeof(st->data.spi));
 }
 
-static int __devinit ad5064_spi_probe(struct spi_device *spi)
+static int ad5064_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
 
@@ -596,7 +596,7 @@ static int ad5064_i2c_write(struct ad5064_state *st, unsigned int cmd,
 	return i2c_master_send(i2c, st->data.i2c, 3);
 }
 
-static int __devinit ad5064_i2c_probe(struct i2c_client *i2c,
+static int ad5064_i2c_probe(struct i2c_client *i2c,
 	const struct i2c_device_id *id)
 {
 	return ad5064_probe(&i2c->dev, id->driver_data, id->name,
diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index e2c0635..c0fae59 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -433,7 +433,7 @@ static const char * const ad5360_vref_name[] = {
 	 "vref0", "vref1", "vref2"
 };
 
-static int __devinit ad5360_alloc_channels(struct iio_dev *indio_dev)
+static int ad5360_alloc_channels(struct iio_dev *indio_dev)
 {
 	struct ad5360_state *st = iio_priv(indio_dev);
 	struct iio_chan_spec *channels;
@@ -456,7 +456,7 @@ static int __devinit ad5360_alloc_channels(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int __devinit ad5360_probe(struct spi_device *spi)
+static int ad5360_probe(struct spi_device *spi)
 {
 	enum ad5360_type type = spi_get_device_id(spi)->driver_data;
 	struct iio_dev *indio_dev;
diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index e93e120..835bb7f 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -338,7 +338,7 @@ static const struct ad5380_chip_info ad5380_chip_info_tbl[] = {
 	},
 };
 
-static int __devinit ad5380_alloc_channels(struct iio_dev *indio_dev)
+static int ad5380_alloc_channels(struct iio_dev *indio_dev)
 {
 	struct ad5380_state *st = iio_priv(indio_dev);
 	struct iio_chan_spec *channels;
@@ -361,7 +361,7 @@ static int __devinit ad5380_alloc_channels(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int __devinit ad5380_probe(struct device *dev, struct regmap *regmap,
+static int ad5380_probe(struct device *dev, struct regmap *regmap,
 	enum ad5380_type type, const char *name)
 {
 	struct iio_dev *indio_dev;
@@ -478,7 +478,7 @@ static const struct regmap_config ad5380_regmap_config = {
 
 #if IS_ENABLED(CONFIG_SPI_MASTER)
 
-static int __devinit ad5380_spi_probe(struct spi_device *spi)
+static int ad5380_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct regmap *regmap;
@@ -552,7 +552,7 @@ static inline void ad5380_spi_unregister_driver(void)
 
 #if IS_ENABLED(CONFIG_I2C)
 
-static int __devinit ad5380_i2c_probe(struct i2c_client *i2c,
+static int ad5380_i2c_probe(struct i2c_client *i2c,
 	const struct i2c_device_id *id)
 {
 	struct regmap *regmap;
diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index cf80a7e..5026bfa 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -449,7 +449,7 @@ static const struct iio_info ad5421_info = {
 	.driver_module =	THIS_MODULE,
 };
 
-static int __devinit ad5421_probe(struct spi_device *spi)
+static int ad5421_probe(struct spi_device *spi)
 {
 	struct ad5421_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct iio_dev *indio_dev;
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 0b3c962..02087a9 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -212,7 +212,7 @@ static const struct iio_info ad5446_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ad5446_probe(struct device *dev, const char *name,
+static int ad5446_probe(struct device *dev, const char *name,
 	const struct ad5446_chip_info *chip_info)
 {
 	struct ad5446_state *st;
@@ -461,7 +461,7 @@ static const struct spi_device_id ad5446_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad5446_spi_ids);
 
-static int __devinit ad5446_spi_probe(struct spi_device *spi)
+static int ad5446_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
 
@@ -539,7 +539,7 @@ static const struct ad5446_chip_info ad5446_i2c_chip_info[] = {
 	},
 };
 
-static int __devinit ad5446_i2c_probe(struct i2c_client *i2c,
+static int ad5446_i2c_probe(struct i2c_client *i2c,
 	const struct i2c_device_id *id)
 {
 	return ad5446_probe(&i2c->dev, id->name,
diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index 01d4749..4184be6 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -266,7 +266,7 @@ static const char *ad5449_vref_name(struct ad5449 *st, int n)
 		return "VREFB";
 }
 
-static int __devinit ad5449_spi_probe(struct spi_device *spi)
+static int ad5449_spi_probe(struct spi_device *spi)
 {
 	struct ad5449_platform_data *pdata = spi->dev.platform_data;
 	const struct spi_device_id *id = spi_get_device_id(spi);
diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 2c7a2e0..531c9f4 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -277,7 +277,7 @@ static const struct iio_chan_spec ad5504_channels[] = {
 	AD5504_CHANNEL(3),
 };
 
-static int __devinit ad5504_probe(struct spi_device *spi)
+static int ad5504_probe(struct spi_device *spi)
 {
 	struct ad5504_platform_data *pdata = spi->dev.platform_data;
 	struct iio_dev *indio_dev;
diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index cf75ded..4d7ff95 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -220,7 +220,7 @@ static const struct ad5624r_chip_info ad5624r_chip_info_tbl[] = {
 	},
 };
 
-static int __devinit ad5624r_probe(struct spi_device *spi)
+static int ad5624r_probe(struct spi_device *spi)
 {
 	struct ad5624r_state *st;
 	struct iio_dev *indio_dev;
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 061ddb1..a153c680 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -313,7 +313,7 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 };
 
 
-static int __devinit ad5686_probe(struct spi_device *spi)
+static int ad5686_probe(struct spi_device *spi)
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index f9e112e..3083d45 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -447,7 +447,7 @@ static bool ad5755_is_valid_mode(struct ad5755_state *st, enum ad5755_mode mode)
 	}
 }
 
-static int __devinit ad5755_setup_pdata(struct iio_dev *indio_dev,
+static int ad5755_setup_pdata(struct iio_dev *indio_dev,
 	const struct ad5755_platform_data *pdata)
 {
 	struct ad5755_state *st = iio_priv(indio_dev);
@@ -503,7 +503,7 @@ static int __devinit ad5755_setup_pdata(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static bool __devinit ad5755_is_voltage_mode(enum ad5755_mode mode)
+static bool ad5755_is_voltage_mode(enum ad5755_mode mode)
 {
 	switch (mode) {
 	case AD5755_MODE_VOLTAGE_0V_5V:
@@ -516,7 +516,7 @@ static bool __devinit ad5755_is_voltage_mode(enum ad5755_mode mode)
 	}
 }
 
-static int __devinit ad5755_init_channels(struct iio_dev *indio_dev,
+static int ad5755_init_channels(struct iio_dev *indio_dev,
 	const struct ad5755_platform_data *pdata)
 {
 	struct ad5755_state *st = iio_priv(indio_dev);
@@ -562,7 +562,7 @@ static const struct ad5755_platform_data ad5755_default_pdata = {
 	},
 };
 
-static int __devinit ad5755_probe(struct spi_device *spi)
+static int ad5755_probe(struct spi_device *spi)
 {
 	enum ad5755_type type = spi_get_device_id(spi)->driver_data;
 	const struct ad5755_platform_data *pdata = dev_get_platdata(&spi->dev);
diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
index 587e7b1..80302b0 100644
--- a/drivers/iio/dac/ad5764.c
+++ b/drivers/iio/dac/ad5764.c
@@ -273,7 +273,7 @@ static const struct iio_info ad5764_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ad5764_probe(struct spi_device *spi)
+static int ad5764_probe(struct spi_device *spi)
 {
 	enum ad5764_type type = spi_get_device_id(spi)->driver_data;
 	struct iio_dev *indio_dev;
diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index f40aecd..34f3c5f 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -346,7 +346,7 @@ static const struct iio_info ad5791_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ad5791_probe(struct spi_device *spi)
+static int ad5791_probe(struct spi_device *spi)
 {
 	struct ad5791_platform_data *pdata = spi->dev.platform_data;
 	struct iio_dev *indio_dev;
diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index cf281ff..25b2e9c 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -156,7 +156,7 @@ static const struct iio_chan_spec max517_channels[] = {
 	MAX517_CHANNEL(1)
 };
 
-static int __devinit max517_probe(struct i2c_client *client,
+static int max517_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct max517_data *data;
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index aff873f..1f5c99a 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -141,7 +141,7 @@ static const struct iio_info mcp4725_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit mcp4725_probe(struct i2c_client *client,
+static int mcp4725_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct mcp4725_data *data;
diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 73e2cd8..00c382d 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -959,7 +959,7 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int __devinit ad9523_probe(struct spi_device *spi)
+static int ad9523_probe(struct spi_device *spi)
 {
 	struct ad9523_platform_data *pdata = spi->dev.platform_data;
 	struct iio_dev *indio_dev;
diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 4c03d63..cdee2ee 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -355,7 +355,7 @@ static const struct iio_info adf4350_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit adf4350_probe(struct spi_device *spi)
+static int adf4350_probe(struct spi_device *spi)
 {
 	struct adf4350_platform_data *pdata = spi->dev.platform_data;
 	struct iio_dev *indio_dev;
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 02ef989..a54cadb 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -278,7 +278,7 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 }
 
 /* Function to initialize the processing for usage id */
-static int __devinit hid_gyro_3d_probe(struct platform_device *pdev)
+static int hid_gyro_3d_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	static const char *name = "gyro_3d";
@@ -375,7 +375,7 @@ error_ret:
 }
 
 /* Function to deinitialize the processing for usage id */
-static int __devinit hid_gyro_3d_remove(struct platform_device *pdev)
+static int hid_gyro_3d_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index 82a6d71..4ad9b3d 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -286,7 +286,7 @@ static const struct iio_info adjd_s311_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit adjd_s311_probe(struct i2c_client *client,
+static int adjd_s311_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct adjd_s311_data *data;
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 8e1f698..695d58b 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -245,7 +245,7 @@ static int als_parse_report(struct platform_device *pdev,
 }
 
 /* Function to initialize the processing for usage id */
-static int __devinit hid_als_probe(struct platform_device *pdev)
+static int hid_als_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	static const char *name = "als";
@@ -342,7 +342,7 @@ error_ret:
 }
 
 /* Function to deinitialize the processing for usage id */
-static int __devinit hid_als_remove(struct platform_device *pdev)
+static int hid_als_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index c56f537..54d00ab 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -718,7 +718,7 @@ static struct attribute_group lm3533_als_attribute_group = {
 	.attrs = lm3533_als_attributes
 };
 
-static int __devinit lm3533_als_set_input_mode(struct lm3533_als *als,
+static int lm3533_als_set_input_mode(struct lm3533_als *als,
 								bool pwm_mode)
 {
 	u8 mask = LM3533_ALS_INPUT_MODE_MASK;
@@ -740,7 +740,7 @@ static int __devinit lm3533_als_set_input_mode(struct lm3533_als *als,
 	return 0;
 }
 
-static int __devinit lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
+static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
 {
 	int ret;
 
@@ -756,7 +756,7 @@ static int __devinit lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
 	return 0;
 }
 
-static int __devinit lm3533_als_setup(struct lm3533_als *als,
+static int lm3533_als_setup(struct lm3533_als *als,
 					struct lm3533_als_platform_data *pdata)
 {
 	int ret;
@@ -775,7 +775,7 @@ static int __devinit lm3533_als_setup(struct lm3533_als *als,
 	return 0;
 }
 
-static int __devinit lm3533_als_setup_irq(struct lm3533_als *als, void *dev)
+static int lm3533_als_setup_irq(struct lm3533_als *als, void *dev)
 {
 	u8 mask = LM3533_ALS_INT_ENABLE_MASK;
 	int ret;
@@ -799,7 +799,7 @@ static int __devinit lm3533_als_setup_irq(struct lm3533_als *als, void *dev)
 	return 0;
 }
 
-static int __devinit lm3533_als_enable(struct lm3533_als *als)
+static int lm3533_als_enable(struct lm3533_als *als)
 {
 	u8 mask = LM3533_ALS_ENABLE_MASK;
 	int ret;
@@ -830,7 +830,7 @@ static const struct iio_info lm3533_als_info = {
 	.read_raw	= &lm3533_als_read_raw,
 };
 
-static int __devinit lm3533_als_probe(struct platform_device *pdev)
+static int lm3533_als_probe(struct platform_device *pdev)
 {
 	struct lm3533 *lm3533;
 	struct lm3533_als_platform_data *pdata;
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 2556788..92b072e 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -150,7 +150,7 @@ static const struct iio_info vcnl4000_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit vcnl4000_probe(struct i2c_client *client,
+static int vcnl4000_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct vcnl4000_data *data;
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index d1b5fb7..0de8084 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -279,7 +279,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 }
 
 /* Function to initialize the processing for usage id */
-static int __devinit hid_magn_3d_probe(struct platform_device *pdev)
+static int hid_magn_3d_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	static char *name = "magn_3d";
@@ -376,7 +376,7 @@ error_ret:
 }
 
 /* Function to deinitialize the processing for usage id */
-static int __devinit hid_magn_3d_remove(struct platform_device *pdev)
+static int hid_magn_3d_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-- 
1.8.0
