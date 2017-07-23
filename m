Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 05/45] iio:adc: drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Sun, 23 Jul 2017 17:25:47 +0100
Message-Id: <20170723162627.22534-6-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7266.c            | 1 -
 drivers/iio/adc/ad7291.c            | 1 -
 drivers/iio/adc/ad7298.c            | 1 -
 drivers/iio/adc/ad7476.c            | 1 -
 drivers/iio/adc/ad7766.c            | 2 --
 drivers/iio/adc/ad7791.c            | 2 --
 drivers/iio/adc/ad7793.c            | 2 --
 drivers/iio/adc/ad7887.c            | 1 -
 drivers/iio/adc/ad7923.c            | 1 -
 drivers/iio/adc/ad799x.c            | 3 ---
 drivers/iio/adc/ad_sigma_delta.c    | 1 -
 drivers/iio/adc/aspeed_adc.c        | 1 -
 drivers/iio/adc/at91-sama5d2_adc.c  | 2 --
 drivers/iio/adc/at91_adc.c          | 2 --
 drivers/iio/adc/axp20x_adc.c        | 2 --
 drivers/iio/adc/axp288_adc.c        | 1 -
 drivers/iio/adc/bcm_iproc_adc.c     | 1 -
 drivers/iio/adc/berlin2-adc.c       | 1 -
 drivers/iio/adc/cc10001_adc.c       | 1 -
 drivers/iio/adc/cpcap-adc.c         | 1 -
 drivers/iio/adc/da9150-gpadc.c      | 1 -
 drivers/iio/adc/dln2-adc.c          | 6 ------
 drivers/iio/adc/envelope-detector.c | 1 -
 drivers/iio/adc/exynos_adc.c        | 1 -
 drivers/iio/adc/hi8435.c            | 1 -
 drivers/iio/adc/hx711.c             | 1 -
 drivers/iio/adc/imx7d_adc.c         | 1 -
 drivers/iio/adc/ina2xx-adc.c        | 2 --
 drivers/iio/adc/lp8788_adc.c        | 1 -
 drivers/iio/adc/lpc18xx_adc.c       | 1 -
 drivers/iio/adc/lpc32xx_adc.c       | 1 -
 drivers/iio/adc/ltc2471.c           | 1 -
 drivers/iio/adc/ltc2485.c           | 1 -
 drivers/iio/adc/ltc2497.c           | 1 -
 drivers/iio/adc/max1027.c           | 2 --
 drivers/iio/adc/max11100.c          | 1 -
 drivers/iio/adc/max1118.c           | 1 -
 drivers/iio/adc/max1363.c           | 2 --
 drivers/iio/adc/max9611.c           | 1 -
 drivers/iio/adc/mcp320x.c           | 1 -
 drivers/iio/adc/mcp3422.c           | 1 -
 drivers/iio/adc/men_z188_adc.c      | 1 -
 drivers/iio/adc/meson_saradc.c      | 1 -
 drivers/iio/adc/mt6577_auxadc.c     | 1 -
 drivers/iio/adc/mxs-lradc-adc.c     | 2 --
 drivers/iio/adc/nau7802.c           | 1 -
 drivers/iio/adc/palmas_gpadc.c      | 1 -
 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 1 -
 drivers/iio/adc/qcom-spmi-iadc.c    | 1 -
 drivers/iio/adc/qcom-spmi-vadc.c    | 1 -
 drivers/iio/adc/rcar-gyroadc.c      | 1 -
 drivers/iio/adc/rockchip_saradc.c   | 1 -
 drivers/iio/adc/spear_adc.c         | 1 -
 drivers/iio/adc/stm32-adc.c         | 1 -
 drivers/iio/adc/stx104.c            | 1 -
 drivers/iio/adc/sun4i-gpadc-iio.c   | 1 -
 drivers/iio/adc/ti-adc081c.c        | 1 -
 drivers/iio/adc/ti-adc0832.c        | 1 -
 drivers/iio/adc/ti-adc084s021.c     | 1 -
 drivers/iio/adc/ti-adc108s102.c     | 1 -
 drivers/iio/adc/ti-adc12138.c       | 1 -
 drivers/iio/adc/ti-adc128s052.c     | 1 -
 drivers/iio/adc/ti-adc161s626.c     | 1 -
 drivers/iio/adc/ti-ads1015.c        | 2 --
 drivers/iio/adc/ti-ads7950.c        | 1 -
 drivers/iio/adc/ti-ads8688.c        | 1 -
 drivers/iio/adc/ti-tlc4541.c        | 1 -
 drivers/iio/adc/ti_am335x_adc.c     | 1 -
 drivers/iio/adc/twl4030-madc.c      | 1 -
 drivers/iio/adc/twl6030-gpadc.c     | 1 -
 drivers/iio/adc/vf610_adc.c         | 1 -
 drivers/iio/adc/viperboard_adc.c    | 1 -
 drivers/iio/adc/xilinx-xadc-core.c  | 2 --
 73 files changed, 92 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index b8d5cfd57ec4..605eb5e7e829 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -280,7 +280,6 @@ static AD7266_DECLARE_DIFF_CHANNELS_FIXED(u, 'u');
 static const struct iio_info ad7266_info = {
 	.read_raw = &ad7266_read_raw,
 	.update_scan_mode = &ad7266_update_scan_mode,
-	.driver_module = THIS_MODULE,
 };
 
 static const unsigned long ad7266_available_scan_masks[] = {
diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
index 1d90b02732bb..a862b5d8fb4b 100644
--- a/drivers/iio/adc/ad7291.c
+++ b/drivers/iio/adc/ad7291.c
@@ -461,7 +461,6 @@ static const struct iio_info ad7291_info = {
 	.write_event_config = &ad7291_write_event_config,
 	.read_event_value = &ad7291_read_event_value,
 	.write_event_value = &ad7291_write_event_value,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad7291_probe(struct i2c_client *client,
diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index e399bf04c73a..2b20c6c8ec7f 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -280,7 +280,6 @@ static int ad7298_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad7298_info = {
 	.read_raw = &ad7298_read_raw,
 	.update_scan_mode = ad7298_update_scan_mode,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad7298_probe(struct spi_device *spi)
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index b7ecf9aab90f..b7706bf10ffe 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -195,7 +195,6 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 };
 
 static const struct iio_info ad7476_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &ad7476_read_raw,
 };
 
diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index ce45037295d8..3ae14fc8c649 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -185,7 +185,6 @@ static const struct iio_buffer_setup_ops ad7766_buffer_setup_ops = {
 };
 
 static const struct iio_info ad7766_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &ad7766_read_raw,
 };
 
@@ -208,7 +207,6 @@ static int ad7766_set_trigger_state(struct iio_trigger *trig, bool enable)
 }
 
 static const struct iio_trigger_ops ad7766_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = ad7766_set_trigger_state,
 	.validate_device = iio_trigger_validate_own_device,
 };
diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 34e353c43ac8..70fbf92f9827 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -308,13 +308,11 @@ static const struct iio_info ad7791_info = {
 	.read_raw = &ad7791_read_raw,
 	.attrs = &ad7791_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ad7791_no_filter_info = {
 	.read_raw = &ad7791_read_raw,
 	.validate_trigger = ad_sd_validate_trigger,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad7791_setup(struct ad7791_state *st,
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index e6706a09e100..c40263ad881f 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -563,7 +563,6 @@ static const struct iio_info ad7793_info = {
 	.write_raw_get_fmt = &ad7793_write_raw_get_fmt,
 	.attrs = &ad7793_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ad7797_info = {
@@ -572,7 +571,6 @@ static const struct iio_info ad7797_info = {
 	.write_raw_get_fmt = &ad7793_write_raw_get_fmt,
 	.attrs = &ad7793_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
-	.driver_module = THIS_MODULE,
 };
 
 #define DECLARE_AD7793_CHANNELS(_name, _b, _sb, _s) \
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 7a483bfbd70c..205c0f1761aa 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -229,7 +229,6 @@ static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
 
 static const struct iio_info ad7887_info = {
 	.read_raw = &ad7887_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad7887_probe(struct spi_device *spi)
diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 77a675e11ebb..ffb7e089969c 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -262,7 +262,6 @@ static int ad7923_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad7923_info = {
 	.read_raw = &ad7923_read_raw,
 	.update_scan_mode = ad7923_update_scan_mode,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad7923_probe(struct spi_device *spi)
diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 22426ae4af97..e1da67d5ee22 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -526,13 +526,11 @@ static const struct attribute_group ad799x_event_attrs_group = {
 
 static const struct iio_info ad7991_info = {
 	.read_raw = &ad799x_read_raw,
-	.driver_module = THIS_MODULE,
 	.update_scan_mode = ad799x_update_scan_mode,
 };
 
 static const struct iio_info ad7993_4_7_8_noirq_info = {
 	.read_raw = &ad799x_read_raw,
-	.driver_module = THIS_MODULE,
 	.update_scan_mode = ad799x_update_scan_mode,
 };
 
@@ -543,7 +541,6 @@ static const struct iio_info ad7993_4_7_8_irq_info = {
 	.write_event_config = &ad799x_write_event_config,
 	.read_event_value = &ad799x_read_event_value,
 	.write_event_value = &ad799x_write_event_value,
-	.driver_module = THIS_MODULE,
 	.update_scan_mode = ad799x_update_scan_mode,
 };
 
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d10bd0c97233..e3ed74ee41d1 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -435,7 +435,6 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig)
 EXPORT_SYMBOL_GPL(ad_sd_validate_trigger);
 
 static const struct iio_trigger_ops ad_sd_trigger_ops = {
-	.owner = THIS_MODULE,
 };
 
 static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index e0ea411a0b2d..1c233d71a23f 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -158,7 +158,6 @@ static int aspeed_adc_reg_access(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info aspeed_adc_iio_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = aspeed_adc_read_raw,
 	.write_raw = aspeed_adc_write_raw,
 	.debugfs_reg_access = aspeed_adc_reg_access,
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index bc5b38e3a147..318601bad354 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -338,7 +338,6 @@ static int at91_adc_reenable_trigger(struct iio_trigger *trig)
 }
 
 static const struct iio_trigger_ops at91_adc_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = &at91_adc_configure_trigger,
 	.try_reenable = &at91_adc_reenable_trigger,
 };
@@ -574,7 +573,6 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info at91_adc_info = {
 	.read_raw = &at91_adc_read_raw,
 	.write_raw = &at91_adc_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static void at91_adc_hw_init(struct at91_adc_state *st)
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 15109728cae7..3836d4222a3e 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -594,7 +594,6 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 }
 
 static const struct iio_trigger_ops at91_adc_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = &at91_adc_configure_trigger,
 };
 
@@ -976,7 +975,6 @@ static int at91_adc_probe_pdata(struct at91_adc_state *st,
 }
 
 static const struct iio_info at91_adc_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &at91_adc_read_raw,
 };
 
diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 11e177180ea0..a30a97245e91 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -464,12 +464,10 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info axp20x_adc_iio_info = {
 	.read_raw = axp20x_read_raw,
 	.write_raw = axp20x_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info axp22x_adc_iio_info = {
 	.read_raw = axp22x_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int axp20x_adc_rate(int rate)
diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 64799ad7ebad..bc9fd54868f2 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -143,7 +143,6 @@ static int axp288_adc_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info axp288_adc_iio_info = {
 	.read_raw = &axp288_adc_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int axp288_adc_probe(struct platform_device *pdev)
diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 7f4f9c4150e3..7af59a4bbd8d 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -492,7 +492,6 @@ static int iproc_adc_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info iproc_adc_iio_info = {
 	.read_raw = &iproc_adc_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #define IPROC_ADC_CHANNEL(_index, _id) {                \
diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index 71c806ecc722..72d8fa94ab31 100644
--- a/drivers/iio/adc/berlin2-adc.c
+++ b/drivers/iio/adc/berlin2-adc.c
@@ -277,7 +277,6 @@ static irqreturn_t berlin2_adc_tsen_irq(int irq, void *private)
 }
 
 static const struct iio_info berlin2_adc_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= berlin2_adc_read_raw,
 };
 
diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index 91636c0ba5b5..707d8b24b072 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -262,7 +262,6 @@ static int cc10001_update_scan_mode(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info cc10001_adc_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &cc10001_adc_read_raw,
 	.update_scan_mode = &cc10001_update_scan_mode,
 };
diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index 6e419d5a7c14..3576ec73ec23 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -932,7 +932,6 @@ static int cpcap_adc_read(struct iio_dev *indio_dev,
 
 static const struct iio_info cpcap_adc_info = {
 	.read_raw = &cpcap_adc_read,
-	.driver_module = THIS_MODULE,
 };
 
 /*
diff --git a/drivers/iio/adc/da9150-gpadc.c b/drivers/iio/adc/da9150-gpadc.c
index 3445107e10b7..0a5d9ce79164 100644
--- a/drivers/iio/adc/da9150-gpadc.c
+++ b/drivers/iio/adc/da9150-gpadc.c
@@ -249,7 +249,6 @@ static int da9150_gpadc_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info da9150_gpadc_info = {
 	.read_raw = &da9150_gpadc_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #define DA9150_GPADC_CHANNEL(_id, _hw_id, _type, chan_info,	\
diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index ab8d6aed5085..c64c6675cae6 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -479,7 +479,6 @@ static const struct iio_info dln2_adc_info = {
 	.read_raw = dln2_adc_read_raw,
 	.write_raw = dln2_adc_write_raw,
 	.update_scan_mode = dln2_update_scan_mode,
-	.driver_module = THIS_MODULE,
 };
 
 static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
@@ -604,10 +603,6 @@ static void dln2_adc_event(struct platform_device *pdev, u16 echo,
 	iio_trigger_poll(dln2->trig);
 }
 
-static const struct iio_trigger_ops dln2_adc_trigger_ops = {
-	.owner = THIS_MODULE,
-};
-
 static int dln2_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -665,7 +660,6 @@ static int dln2_adc_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to allocate trigger\n");
 		return -ENOMEM;
 	}
-	dln2->trig->ops = &dln2_adc_trigger_ops;
 	iio_trigger_set_drvdata(dln2->trig, dln2);
 	devm_iio_trigger_register(dev, dln2->trig);
 	iio_trigger_set_immutable(indio_dev, dln2->trig);
diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index fef15c0d7c9c..4ebda8ab54fe 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -322,7 +322,6 @@ static const struct iio_chan_spec envelope_detector_iio_channel = {
 
 static const struct iio_info envelope_detector_info = {
 	.read_raw = &envelope_detector_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int envelope_detector_probe(struct platform_device *pdev)
diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 6c5a7be9f8c1..f10443f92e4c 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -657,7 +657,6 @@ static int exynos_adc_reg_access(struct iio_dev *indio_dev,
 static const struct iio_info exynos_adc_iio_info = {
 	.read_raw = &exynos_read_raw,
 	.debugfs_reg_access = &exynos_adc_reg_access,
-	.driver_module = THIS_MODULE,
 };
 
 #define ADC_CHANNEL(_index, _id) {			\
diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index adf7dc712937..6f6c9a348158 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -408,7 +408,6 @@ static const struct iio_chan_spec hi8435_channels[] = {
 };
 
 static const struct iio_info hi8435_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = hi8435_read_raw,
 	.read_event_config = hi8435_read_event_config,
 	.write_event_config = hi8435_write_event_config,
diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 27005d84ed73..d10b9f13d557 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -374,7 +374,6 @@ static const struct attribute_group hx711_attribute_group = {
 };
 
 static const struct iio_info hx711_iio_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= hx711_read_raw,
 	.write_raw		= hx711_write_raw,
 	.write_raw_get_fmt	= hx711_write_raw_get_fmt,
diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 254b29a68b9d..cfab31162845 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -412,7 +412,6 @@ static int imx7d_adc_reg_access(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info imx7d_adc_iio_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &imx7d_adc_read_raw,
 	.debugfs_reg_access = &imx7d_adc_reg_access,
 };
diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 68884d26b50c..cc5eda453a13 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -778,7 +778,6 @@ static const struct attribute_group ina226_attribute_group = {
 };
 
 static const struct iio_info ina219_info = {
-	.driver_module = THIS_MODULE,
 	.attrs = &ina219_attribute_group,
 	.read_raw = ina2xx_read_raw,
 	.write_raw = ina2xx_write_raw,
@@ -786,7 +785,6 @@ static const struct iio_info ina219_info = {
 };
 
 static const struct iio_info ina226_info = {
-	.driver_module = THIS_MODULE,
 	.attrs = &ina226_attribute_group,
 	.read_raw = ina2xx_read_raw,
 	.write_raw = ina2xx_write_raw,
diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
index 152cfc8e1c7b..3bc4df916420 100644
--- a/drivers/iio/adc/lp8788_adc.c
+++ b/drivers/iio/adc/lp8788_adc.c
@@ -125,7 +125,6 @@ static int lp8788_adc_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info lp8788_adc_info = {
 	.read_raw = &lp8788_adc_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #define LP8788_CHAN(_id, _type) {				\
diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
index 3ef18f4b27f0..041dc4a3f66c 100644
--- a/drivers/iio/adc/lpc18xx_adc.c
+++ b/drivers/iio/adc/lpc18xx_adc.c
@@ -116,7 +116,6 @@ static int lpc18xx_adc_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info lpc18xx_adc_info = {
 	.read_raw = lpc18xx_adc_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int lpc18xx_adc_probe(struct platform_device *pdev)
diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index 6a5b9a9bc662..20b36690fa4f 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -104,7 +104,6 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info lpc32xx_adc_iio_info = {
 	.read_raw = &lpc32xx_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #define LPC32XX_ADC_CHANNEL(_index) {			\
diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
index 29b7ed60cdb0..b88102b751cf 100644
--- a/drivers/iio/adc/ltc2471.c
+++ b/drivers/iio/adc/ltc2471.c
@@ -98,7 +98,6 @@ static const struct iio_chan_spec ltc2473_channel[] = {
 
 static const struct iio_info ltc2471_info = {
 	.read_raw = ltc2471_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int ltc2471_i2c_probe(struct i2c_client *client,
diff --git a/drivers/iio/adc/ltc2485.c b/drivers/iio/adc/ltc2485.c
index eab91f12454a..b24c14037fd4 100644
--- a/drivers/iio/adc/ltc2485.c
+++ b/drivers/iio/adc/ltc2485.c
@@ -90,7 +90,6 @@ static const struct iio_chan_spec ltc2485_channel[] = {
 
 static const struct iio_info ltc2485_info = {
 	.read_raw = ltc2485_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int ltc2485_probe(struct i2c_client *client,
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 5bf8011dcde9..f1f7cdf66fbd 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -186,7 +186,6 @@ static const struct iio_chan_spec ltc2497_channel[] = {
 
 static const struct iio_info ltc2497_info = {
 	.read_raw = ltc2497_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int ltc2497_probe(struct i2c_client *client,
diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index ebc715927e63..375da6491499 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -381,13 +381,11 @@ static irqreturn_t max1027_trigger_handler(int irq, void *private)
 }
 
 static const struct iio_trigger_ops max1027_trigger_ops = {
-	.owner = THIS_MODULE,
 	.validate_device = &iio_trigger_validate_own_device,
 	.set_trigger_state = &max1027_set_trigger_state,
 };
 
 static const struct iio_info max1027_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &max1027_read_raw,
 	.validate_trigger = &max1027_validate_trigger,
 	.debugfs_reg_access = &max1027_debugfs_reg_access,
diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
index 1180bcc22ff1..af59ab2e650c 100644
--- a/drivers/iio/adc/max11100.c
+++ b/drivers/iio/adc/max11100.c
@@ -100,7 +100,6 @@ static int max11100_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info max11100_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = max11100_read_raw,
 };
 
diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
index 2e9648a078c4..49db9e9ae625 100644
--- a/drivers/iio/adc/max1118.c
+++ b/drivers/iio/adc/max1118.c
@@ -155,7 +155,6 @@ static int max1118_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info max1118_info = {
 	.read_raw = max1118_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static irqreturn_t max1118_trigger_handler(int irq, void *p)
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 80eada4886b3..7f1848dac9bf 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1029,7 +1029,6 @@ static int max1363_update_scan_mode(struct iio_dev *indio_dev,
 
 static const struct iio_info max1238_info = {
 	.read_raw = &max1363_read_raw,
-	.driver_module = THIS_MODULE,
 	.update_scan_mode = &max1363_update_scan_mode,
 };
 
@@ -1040,7 +1039,6 @@ static const struct iio_info max1363_info = {
 	.write_event_config = &max1363_write_event_config,
 	.read_raw = &max1363_read_raw,
 	.update_scan_mode = &max1363_update_scan_mode,
-	.driver_module = THIS_MODULE,
 	.event_attrs = &max1363_event_attribute_group,
 };
 
diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index b1dd17cbce58..9edfbabf4e4d 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -460,7 +460,6 @@ static const struct attribute_group max9611_attribute_group = {
 };
 
 static const struct iio_info indio_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= max9611_read_raw,
 	.attrs		= &max9611_attribute_group,
 };
diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 634717ae12f3..06bc2453caf9 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -242,7 +242,6 @@ static const struct iio_chan_spec mcp3208_channels[] = {
 
 static const struct iio_info mcp320x_info = {
 	.read_raw = mcp320x_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct mcp320x_chip_info mcp320x_chip_infos[] = {
diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 63de705086ed..819f26011500 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -327,7 +327,6 @@ static const struct iio_info mcp3422_info = {
 	.write_raw = mcp3422_write_raw,
 	.write_raw_get_fmt = mcp3422_write_raw_get_fmt,
 	.attrs = &mcp3422_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int mcp3422_probe(struct i2c_client *client,
diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
index 8f3606de4eaf..c80261748d8f 100644
--- a/drivers/iio/adc/men_z188_adc.c
+++ b/drivers/iio/adc/men_z188_adc.c
@@ -80,7 +80,6 @@ static int z188_iio_read_raw(struct iio_dev *iio_dev,
 
 static const struct iio_info z188_adc_info = {
 	.read_raw = &z188_iio_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static void men_z188_config_channels(void __iomem *addr)
diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 2e8dbb89c8c9..9c6932ffc0af 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -840,7 +840,6 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
 
 static const struct iio_info meson_sar_adc_iio_info = {
 	.read_raw = meson_sar_adc_iio_info_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct meson_sar_adc_data meson_sar_adc_meson8_data = {
diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 414cf44bf19d..a2a23958c2a2 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -180,7 +180,6 @@ static int mt6577_auxadc_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info mt6577_auxadc_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &mt6577_auxadc_read_raw,
 };
 
diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index d32b34638c2f..c627513d9f0f 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -382,7 +382,6 @@ static const struct attribute_group mxs_lradc_adc_attribute_group = {
 };
 
 static const struct iio_info mxs_lradc_adc_iio_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= mxs_lradc_adc_read_raw,
 	.write_raw		= mxs_lradc_adc_write_raw,
 	.write_raw_get_fmt	= mxs_lradc_adc_write_raw_get_fmt,
@@ -455,7 +454,6 @@ static int mxs_lradc_adc_configure_trigger(struct iio_trigger *trig, bool state)
 }
 
 static const struct iio_trigger_ops mxs_lradc_adc_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = &mxs_lradc_adc_configure_trigger,
 };
 
diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index 08f446695f97..8997e74a8847 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -402,7 +402,6 @@ static int nau7802_write_raw_get_fmt(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info nau7802_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &nau7802_read_raw,
 	.write_raw = &nau7802_write_raw,
 	.write_raw_get_fmt = nau7802_write_raw_get_fmt,
diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 7d61b566e148..69b9affeef1e 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -430,7 +430,6 @@ static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info palmas_gpadc_iio_info = {
 	.read_raw = palmas_gpadc_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #define PALMAS_ADC_CHAN_IIO(chan, _type, chan_info)	\
diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index cea8f1fb444a..b093ecddf1a8 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -728,7 +728,6 @@ static int pm8xxx_of_xlate(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info pm8xxx_xoadc_info = {
-	.driver_module = THIS_MODULE,
 	.of_xlate = pm8xxx_of_xlate,
 	.read_raw = pm8xxx_read_raw,
 };
diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
index fabd24edc2a1..3f062cd61aba 100644
--- a/drivers/iio/adc/qcom-spmi-iadc.c
+++ b/drivers/iio/adc/qcom-spmi-iadc.c
@@ -356,7 +356,6 @@ static int iadc_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info iadc_info = {
 	.read_raw = iadc_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static irqreturn_t iadc_isr(int irq, void *dev_id)
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index 9e600bfd1765..3680e0d47412 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -506,7 +506,6 @@ static int vadc_of_xlate(struct iio_dev *indio_dev,
 static const struct iio_info vadc_info = {
 	.read_raw = vadc_read_raw,
 	.of_xlate = vadc_of_xlate,
-	.driver_module = THIS_MODULE,
 };
 
 struct vadc_channels {
diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 27a318164619..2cb5397ceeea 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -277,7 +277,6 @@ static int rcar_gyroadc_reg_access(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info rcar_gyroadc_iio_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= rcar_gyroadc_read_raw,
 	.debugfs_reg_access	= rcar_gyroadc_reg_access,
 };
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 2bf2ed15a870..b019ed806db3 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -125,7 +125,6 @@ static irqreturn_t rockchip_saradc_isr(int irq, void *dev_id)
 
 static const struct iio_info rockchip_saradc_iio_info = {
 	.read_raw = rockchip_saradc_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #define ADC_CHANNEL(_index, _id) {				\
diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 5dd61f6a57b9..b1da2c46107c 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -254,7 +254,6 @@ static int spear_adc_configure(struct spear_adc_state *st)
 static const struct iio_info spear_adc_info = {
 	.read_raw = &spear_adc_read_raw,
 	.write_raw = &spear_adc_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int spear_adc_probe(struct platform_device *pdev)
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5bfcc1f13105..989f85bab7c4 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1283,7 +1283,6 @@ static const struct iio_info stm32_adc_iio_info = {
 	.update_scan_mode = stm32_adc_update_scan_mode,
 	.debugfs_reg_access = stm32_adc_debugfs_reg_access,
 	.of_xlate = stm32_adc_of_xlate,
-	.driver_module = THIS_MODULE,
 };
 
 static unsigned int stm32_adc_dma_residue(struct stm32_adc *adc)
diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index 2da741d27540..17b021f33180 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -172,7 +172,6 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info stx104_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = stx104_read_raw,
 	.write_raw = stx104_write_raw
 };
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 81d4c39e414a..60ea7796e894 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -351,7 +351,6 @@ static int sun4i_gpadc_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info sun4i_gpadc_iio_info = {
 	.read_raw = sun4i_gpadc_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static irqreturn_t sun4i_gpadc_temp_data_irq_handler(int irq, void *dev_id)
diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 319172cf7da8..405e3779c0c5 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -124,7 +124,6 @@ static struct adcxx1c_model adcxx1c_models[] = {
 
 static const struct iio_info adc081c_info = {
 	.read_raw = adc081c_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static irqreturn_t adc081c_trigger_handler(int irq, void *p)
diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
index e952e94a14af..188dae705bf7 100644
--- a/drivers/iio/adc/ti-adc0832.c
+++ b/drivers/iio/adc/ti-adc0832.c
@@ -195,7 +195,6 @@ static int adc0832_read_raw(struct iio_dev *iio,
 
 static const struct iio_info adc0832_info = {
 	.read_raw = adc0832_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static irqreturn_t adc0832_trigger_handler(int irq, void *p)
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index a355121c11a4..25504640e126 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -186,7 +186,6 @@ static int adc084s021_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_info adc084s021_info = {
 	.read_raw = adc084s021_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_buffer_setup_ops adc084s021_buffer_setup_ops = {
diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index de4e5ac98c6e..841203edaac5 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -220,7 +220,6 @@ static int adc108s102_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info adc108s102_info = {
 	.read_raw		= &adc108s102_read_raw,
 	.update_scan_mode	= &adc108s102_update_scan_mode,
-	.driver_module		= THIS_MODULE,
 };
 
 static int adc108s102_probe(struct spi_device *spi)
diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
index 072f03bfe6a0..bf890244789a 100644
--- a/drivers/iio/adc/ti-adc12138.c
+++ b/drivers/iio/adc/ti-adc12138.c
@@ -277,7 +277,6 @@ static int adc12138_read_raw(struct iio_dev *iio,
 
 static const struct iio_info adc12138_info = {
 	.read_raw = adc12138_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int adc12138_init(struct adc12138 *adc)
diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 89dfbd31be5c..7cf39b3e2416 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -130,7 +130,6 @@ static const struct adc128_configuration adc128_config[] = {
 
 static const struct iio_info adc128_info = {
 	.read_raw = adc128_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int adc128_probe(struct spi_device *spi)
diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 4836a0d7aef5..10fa7677ac4b 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -173,7 +173,6 @@ static int ti_adc_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info ti_adc_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = ti_adc_read_raw,
 };
 
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 5866118fafbf..f99d40f12c0a 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -474,14 +474,12 @@ static const struct attribute_group ads1115_attribute_group = {
 };
 
 static const struct iio_info ads1015_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= ads1015_read_raw,
 	.write_raw	= ads1015_write_raw,
 	.attrs          = &ads1015_attribute_group,
 };
 
 static const struct iio_info ads1115_info = {
-	.driver_module	= THIS_MODULE,
 	.read_raw	= ads1015_read_raw,
 	.write_raw	= ads1015_write_raw,
 	.attrs          = &ads1115_attribute_group,
diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 16a06633332c..9e1c864d3901 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -360,7 +360,6 @@ static int ti_ads7950_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info ti_ads7950_info = {
 	.read_raw		= &ti_ads7950_read_raw,
 	.update_scan_mode	= ti_ads7950_update_scan_mode,
-	.driver_module		= THIS_MODULE,
 };
 
 static int ti_ads7950_probe(struct spi_device *spi)
diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 4a163496d9e4..ff4756352ac1 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -369,7 +369,6 @@ static const struct iio_info ads8688_info = {
 	.write_raw = &ads8688_write_raw,
 	.write_raw_get_fmt = &ads8688_write_raw_get_fmt,
 	.attrs = &ads8688_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct ads8688_chip_info ads8688_chip_info_tbl[] = {
diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
index 78d91a069ea4..2290024c89fc 100644
--- a/drivers/iio/adc/ti-tlc4541.c
+++ b/drivers/iio/adc/ti-tlc4541.c
@@ -157,7 +157,6 @@ static int tlc4541_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info tlc4541_info = {
 	.read_raw = &tlc4541_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int tlc4541_probe(struct spi_device *spi)
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 6cbed7eb118a..b3e573cc6f5f 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -533,7 +533,6 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info tiadc_info = {
 	.read_raw = &tiadc_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int tiadc_request_dma(struct platform_device *pdev,
diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index bd3d37fc2144..cf2089e01636 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -212,7 +212,6 @@ static int twl4030_madc_read(struct iio_dev *iio_dev,
 
 static const struct iio_info twl4030_madc_iio_info = {
 	.read_raw = &twl4030_madc_read,
-	.driver_module = THIS_MODULE,
 };
 
 #define TWL4030_ADC_CHANNEL(_channel, _type, _name) {	\
diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index becbb0aef232..3c5a73ccb1cc 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -843,7 +843,6 @@ static const struct iio_chan_spec twl6032_gpadc_iio_channels[] = {
 
 static const struct iio_info twl6030_gpadc_iio_info = {
 	.read_raw = &twl6030_gpadc_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct twl6030_gpadc_platform_data twl6030_pdata = {
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 01fc76f7d660..b851b44cf1be 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -799,7 +799,6 @@ static int vf610_adc_reg_access(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info vf610_adc_iio_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &vf610_read_raw,
 	.write_raw = &vf610_write_raw,
 	.debugfs_reg_access = &vf610_adc_reg_access,
diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
index 3be2e35721cc..53eb5a4136fe 100644
--- a/drivers/iio/adc/viperboard_adc.c
+++ b/drivers/iio/adc/viperboard_adc.c
@@ -107,7 +107,6 @@ static int vprbrd_iio_read_raw(struct iio_dev *iio_dev,
 
 static const struct iio_info vprbrd_adc_iio_info = {
 	.read_raw = &vprbrd_iio_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int vprbrd_adc_probe(struct platform_device *pdev)
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 4a60497a1f19..d4f21d1be6c8 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -675,7 +675,6 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 }
 
 static const struct iio_trigger_ops xadc_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = &xadc_trigger_set_state,
 };
 
@@ -1028,7 +1027,6 @@ static const struct iio_info xadc_info = {
 	.read_event_value = &xadc_read_event_value,
 	.write_event_value = &xadc_write_event_value,
 	.update_scan_mode = &xadc_update_scan_mode,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct of_device_id xadc_of_match_table[] = {
-- 
2.13.3
