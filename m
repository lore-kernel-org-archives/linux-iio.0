Return-Path: <SRS0=9eR3=JI=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <jic23@kernel.org>
CC: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH][RFC] iio: Move attach/detach of the poll func to the core
Date: Fri, 22 Jun 2018 16:53:22 +0300
Message-ID: <20180622135322.3459-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

All devices using a triggered buffer need to attach and detach the trigger
to the device in order to properly work. Instead of doing this in each and
every driver by hand move this into the core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Note: `Signed-off-by` is also Lars-Peter Clausen because he is the
original author of this patch [on an older kernel].
The patch has been updated since the original patch from Lars.

There has been a (small) discussion about whether such a patch makes
sense to implement (for reducing code duplication), or whether it's too
risky to do it.

The reason for the risky-ness is that there is no consistent way in which
drivers attach/detach the poll function.
i.e.
   1. some drivers call `iio_triggered_buffer_postenable()` before doing HW
      stuff, some after (for attaching the poll func)
   2. similarly, for `iio_triggered_buffer_predisable()` some drivers do it
      before HW stuff, some after (for detaching the poll func)

Common sense would dictate that (in the case of
`iio_triggered_buffer_postenable()`) there would normally be HW setup first
and then attach the poll func.
And the reverse done for `iio_triggered_buffer_predisable()`.

However, it's unclear whether this reasoning is completely sound for all
drivers.

Hence this RFC.

 drivers/iio/accel/bmc150-accel-core.c         |  4 +--
 drivers/iio/accel/kxcjk-1013.c                |  2 --
 drivers/iio/accel/kxsd9.c                     |  2 --
 drivers/iio/accel/st_accel_buffer.c           |  8 ------
 drivers/iio/accel/stk8312.c                   |  2 --
 drivers/iio/accel/stk8ba50.c                  |  2 --
 drivers/iio/adc/ad7266.c                      |  2 --
 drivers/iio/adc/ad7766.c                      |  2 --
 drivers/iio/adc/ad7887.c                      |  2 --
 drivers/iio/adc/ad_sigma_delta.c              |  5 ----
 drivers/iio/adc/at91-sama5d2_adc.c            |  6 +----
 drivers/iio/adc/dln2-adc.c                    |  4 +--
 drivers/iio/adc/mxs-lradc-adc.c               |  2 --
 drivers/iio/adc/stm32-adc.c                   | 11 --------
 drivers/iio/adc/ti-adc084s021.c               |  2 --
 drivers/iio/adc/ti-ads1015.c                  |  2 --
 drivers/iio/adc/vf610_adc.c                   |  6 +----
 drivers/iio/adc/xilinx-xadc-core.c            |  2 --
 .../buffer/industrialio-triggered-buffer.c    | 10 +-------
 drivers/iio/chemical/atlas-ph-sensor.c        |  8 ------
 drivers/iio/dummy/iio_simple_dummy_buffer.c   | 14 -----------
 drivers/iio/gyro/bmg160_core.c                |  2 --
 drivers/iio/gyro/mpu3050-core.c               |  2 --
 drivers/iio/gyro/st_gyro_buffer.c             |  8 ------
 drivers/iio/humidity/hdc100x.c                |  7 +-----
 drivers/iio/humidity/hts221_buffer.c          |  2 --
 drivers/iio/iio_core_trigger.h                | 17 +++++++++++++
 drivers/iio/industrialio-buffer.c             | 13 ++++++++++
 drivers/iio/industrialio-trigger.c            | 22 +++-------------
 drivers/iio/light/gp2ap020a00f.c              | 11 +-------
 drivers/iio/light/isl29125.c                  |  5 ----
 drivers/iio/light/rpr0521.c                   |  2 --
 drivers/iio/light/si1145.c                    |  2 --
 drivers/iio/light/st_uvis25_core.c            |  2 --
 drivers/iio/light/tcs3414.c                   |  5 ----
 drivers/iio/magnetometer/bmc150_magn.c        |  2 --
 drivers/iio/magnetometer/st_magn_buffer.c     | 23 +++--------------
 drivers/iio/potentiostat/lmp91000.c           |  1 -
 drivers/iio/pressure/st_pressure_buffer.c     | 25 +++----------------
 drivers/iio/pressure/zpa2326.c                |  6 -----
 drivers/iio/proximity/sx9500.c                |  3 ---
 drivers/staging/iio/meter/ade7758_ring.c      |  2 --
 include/linux/iio/trigger_consumer.h          |  7 ------
 43 files changed, 50 insertions(+), 217 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 383c802eb5b8..dcce3e178f10 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1403,7 +1403,7 @@ static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
 	int ret = 0;
 
 	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
-		return iio_triggered_buffer_postenable(indio_dev);
+		return 0;
 
 	mutex_lock(&data->mutex);
 
@@ -1435,7 +1435,7 @@ static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 
 	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
-		return iio_triggered_buffer_predisable(indio_dev);
+		return 0;
 
 	mutex_lock(&data->mutex);
 
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index af53a1084ee5..62a1c86e5049 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1019,9 +1019,7 @@ static const struct iio_chan_spec kxcjk1013_channels[] = {
 
 static const struct iio_buffer_setup_ops kxcjk1013_buffer_setup_ops = {
 	.preenable		= kxcjk1013_buffer_preenable,
-	.postenable		= iio_triggered_buffer_postenable,
 	.postdisable		= kxcjk1013_buffer_postdisable,
-	.predisable		= iio_triggered_buffer_predisable,
 };
 
 static const struct iio_info kxcjk1013_info = {
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 0c0df4fce420..9da366bedaa0 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -255,8 +255,6 @@ static int kxsd9_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops kxsd9_buffer_setup_ops = {
 	.preenable = kxsd9_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = kxsd9_buffer_postdisable,
 };
 
diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index 7fddc137e91e..cfa189774a1a 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -51,10 +51,6 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 	if (err < 0)
 		goto st_accel_buffer_postenable_error;
 
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err < 0)
-		goto st_accel_buffer_postenable_error;
-
 	return err;
 
 st_accel_buffer_postenable_error:
@@ -68,10 +64,6 @@ static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
 	int err;
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 
-	err = iio_triggered_buffer_predisable(indio_dev);
-	if (err < 0)
-		goto st_accel_buffer_predisable_error;
-
 	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
 	if (err < 0)
 		goto st_accel_buffer_predisable_error;
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index cacc0da2f874..7c05f8b91f1f 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -495,8 +495,6 @@ static int stk8312_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops stk8312_buffer_setup_ops = {
 	.preenable   = stk8312_buffer_preenable,
-	.postenable  = iio_triggered_buffer_postenable,
-	.predisable  = iio_triggered_buffer_predisable,
 	.postdisable = stk8312_buffer_postdisable,
 };
 
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 576b6b140f08..4e15da997d96 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -379,8 +379,6 @@ static int stk8ba50_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops stk8ba50_buffer_setup_ops = {
 	.preenable   = stk8ba50_buffer_preenable,
-	.postenable  = iio_triggered_buffer_postenable,
-	.predisable  = iio_triggered_buffer_predisable,
 	.postdisable = stk8ba50_buffer_postdisable,
 };
 
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 605eb5e7e829..93b02b28e377 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -75,8 +75,6 @@ static int ad7266_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
 	.preenable = &ad7266_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &ad7266_postdisable,
 };
 
diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 3ae14fc8c649..39e7e4004706 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -179,8 +179,6 @@ static const struct ad7766_chip_info ad7766_chip_info[] = {
 
 static const struct iio_buffer_setup_ops ad7766_buffer_setup_ops = {
 	.preenable = &ad7766_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &ad7766_postdisable,
 };
 
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 205c0f1761aa..02e0e75a3a71 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -131,8 +131,6 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 
 static const struct iio_buffer_setup_ops ad7887_ring_setup_ops = {
 	.preenable = &ad7887_ring_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &ad7887_ring_postdisable,
 };
 
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index cf1b048b0665..ef046277bf7b 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -338,10 +338,6 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	unsigned int channel;
 	int ret;
 
-	ret = iio_triggered_buffer_postenable(indio_dev);
-	if (ret < 0)
-		return ret;
-
 	channel = find_first_bit(indio_dev->active_scan_mask,
 				 indio_dev->masklength);
 	ret = ad_sigma_delta_set_channel(sigma_delta,
@@ -426,7 +422,6 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 
 static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
 	.postenable = &ad_sd_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &ad_sd_buffer_postdisable,
 	.validate_scan_mask = &iio_validate_scan_mask_onehot,
 };
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 4eff8351ce29..9c23d4bbcc47 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -500,7 +500,7 @@ static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
 		return ret;
 	}
 
-	return iio_triggered_buffer_postenable(indio_dev);
+	return 0;
 }
 
 static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
@@ -509,10 +509,6 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
 	int ret;
 	u8 bit;
 
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret < 0)
-		dev_err(&indio_dev->dev, "buffer predisable failed\n");
-
 	if (!st->dma_st.dma_chan)
 		return ret;
 
diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index c64c6675cae6..51135e7c0d4f 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -560,7 +560,7 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
 		mutex_unlock(&dln2->mutex);
 	}
 
-	return iio_triggered_buffer_postenable(indio_dev);
+	return 0;
 }
 
 static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
@@ -585,7 +585,7 @@ static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
 		return ret;
 	}
 
-	return iio_triggered_buffer_predisable(indio_dev);
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops dln2_adc_buffer_setup_ops = {
diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index c627513d9f0f..4a44d4c787be 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -575,8 +575,6 @@ static bool mxs_lradc_adc_validate_scan_mask(struct iio_dev *iio,
 
 static const struct iio_buffer_setup_ops mxs_lradc_adc_buffer_ops = {
 	.preenable = &mxs_lradc_adc_buffer_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &mxs_lradc_adc_buffer_postdisable,
 	.validate_scan_mask = &mxs_lradc_adc_validate_scan_mask,
 };
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 378411853d75..ce0d17c03d7e 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1482,10 +1482,6 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 		goto err_clr_trig;
 	}
 
-	ret = iio_triggered_buffer_postenable(indio_dev);
-	if (ret < 0)
-		goto err_stop_dma;
-
 	/* Reset adc buffer index */
 	adc->bufi = 0;
 
@@ -1496,9 +1492,6 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 
 	return 0;
 
-err_stop_dma:
-	if (adc->dma_chan)
-		dmaengine_terminate_all(adc->dma_chan);
 err_clr_trig:
 	stm32_adc_set_trig(indio_dev, NULL);
 err_unprepare:
@@ -1517,10 +1510,6 @@ static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
 	if (!adc->dma_chan)
 		stm32_adc_conv_irq_disable(adc);
 
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret < 0)
-		dev_err(&indio_dev->dev, "predisable failed\n");
-
 	if (adc->dma_chan)
 		dmaengine_terminate_all(adc->dma_chan);
 
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index 25504640e126..b5557ecb667e 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -190,8 +190,6 @@ static const struct iio_info adc084s021_info = {
 
 static const struct iio_buffer_setup_ops adc084s021_buffer_setup_ops = {
 	.preenable = adc084s021_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = adc084s021_buffer_postdisable,
 };
 
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 6a114dcb4a3a..2a4725ec68ce 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -784,8 +784,6 @@ static int ads1015_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops ads1015_buffer_setup_ops = {
 	.preenable	= ads1015_buffer_preenable,
-	.postenable	= iio_triggered_buffer_postenable,
-	.predisable	= iio_triggered_buffer_predisable,
 	.postdisable	= ads1015_buffer_postdisable,
 	.validate_scan_mask = &iio_validate_scan_mask_onehot,
 };
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index bbcb7a4d7edf..3a15b98cfd39 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -740,10 +740,6 @@ static int vf610_adc_buffer_postenable(struct iio_dev *indio_dev)
 	int ret;
 	int val;
 
-	ret = iio_triggered_buffer_postenable(indio_dev);
-	if (ret)
-		return ret;
-
 	val = readl(info->regs + VF610_REG_ADC_GC);
 	val |= VF610_ADC_ADCON;
 	writel(val, info->regs + VF610_REG_ADC_GC);
@@ -774,7 +770,7 @@ static int vf610_adc_buffer_predisable(struct iio_dev *indio_dev)
 
 	writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
 
-	return iio_triggered_buffer_predisable(indio_dev);
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index d4f21d1be6c8..bc5b4f124a15 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -804,8 +804,6 @@ static int xadc_preenable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops xadc_buffer_ops = {
 	.preenable = &xadc_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &xadc_postdisable,
 };
 
diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index d3db1fce54d2..6d2d7e953904 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -16,11 +16,6 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
-static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
-};
-
 /**
  * iio_triggered_buffer_setup() - Setup triggered buffer and pollfunc
  * @indio_dev:		IIO device structure
@@ -70,10 +65,7 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
 	}
 
 	/* Ring buffer functions - here trigger setup related */
-	if (setup_ops)
-		indio_dev->setup_ops = setup_ops;
-	else
-		indio_dev->setup_ops = &iio_triggered_buffer_setup_ops;
+	indio_dev->setup_ops = setup_ops;
 
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index a406ad31b096..8fed75f9e95d 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -305,10 +305,6 @@ static int atlas_buffer_postenable(struct iio_dev *indio_dev)
 	struct atlas_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_triggered_buffer_postenable(indio_dev);
-	if (ret)
-		return ret;
-
 	ret = pm_runtime_get_sync(&data->client->dev);
 	if (ret < 0) {
 		pm_runtime_put_noidle(&data->client->dev);
@@ -323,10 +319,6 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
 	struct atlas_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret)
-		return ret;
-
 	ret = atlas_set_interrupt(data, false);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 744ca92c3c99..72b0a874d0c6 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -102,20 +102,6 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 }
 
 static const struct iio_buffer_setup_ops iio_simple_dummy_buffer_setup_ops = {
-	/*
-	 * iio_triggered_buffer_postenable:
-	 * Generic function that simply attaches the pollfunc to the trigger.
-	 * Replace this to mess with hardware state before we attach the
-	 * trigger.
-	 */
-	.postenable = &iio_triggered_buffer_postenable,
-	/*
-	 * iio_triggered_buffer_predisable:
-	 * Generic function that simple detaches the pollfunc from the trigger.
-	 * Replace this to put hardware state back again after the trigger is
-	 * detached but before userspace knows we have disabled the ring.
-	 */
-	.predisable = &iio_triggered_buffer_predisable,
 };
 
 int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 63ca31628a93..018d5aef9cdf 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -1043,8 +1043,6 @@ static int bmg160_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops bmg160_buffer_setup_ops = {
 	.preenable = bmg160_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = bmg160_buffer_postdisable,
 };
 
diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 77fac81a3adc..159fb7cd6e2e 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -660,8 +660,6 @@ static int mpu3050_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops mpu3050_buffer_setup_ops = {
 	.preenable = mpu3050_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = mpu3050_buffer_postdisable,
 };
 
diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index a5377044e42f..21501ffd879e 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -51,10 +51,6 @@ static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
 	if (err < 0)
 		goto st_gyro_buffer_postenable_error;
 
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err < 0)
-		goto st_gyro_buffer_postenable_error;
-
 	return err;
 
 st_gyro_buffer_postenable_error:
@@ -68,10 +64,6 @@ static int st_gyro_buffer_predisable(struct iio_dev *indio_dev)
 	int err;
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
 
-	err = iio_triggered_buffer_predisable(indio_dev);
-	if (err < 0)
-		goto st_gyro_buffer_predisable_error;
-
 	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
 	if (err < 0)
 		goto st_gyro_buffer_predisable_error;
diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 066e05f92081..959d7e17d471 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -286,7 +286,7 @@ static int hdc100x_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	return iio_triggered_buffer_postenable(indio_dev);
+	return 0;
 }
 
 static int hdc100x_buffer_predisable(struct iio_dev *indio_dev)
@@ -294,11 +294,6 @@ static int hdc100x_buffer_predisable(struct iio_dev *indio_dev)
 	struct hdc100x_data *data = iio_priv(indio_dev);
 	int ret;
 
-	/* First detach poll func, then reset ACQ mode. OK to disable buffer */
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret)
-		return ret;
-
 	mutex_lock(&data->lock);
 	ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE, 0);
 	mutex_unlock(&data->lock);
diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 1a94b0b91721..dc45667b0364 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -156,8 +156,6 @@ static int hts221_buffer_postdisable(struct iio_dev *iio_dev)
 
 static const struct iio_buffer_setup_ops hts221_buffer_ops = {
 	.preenable = hts221_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = hts221_buffer_postdisable,
 };
 
diff --git a/drivers/iio/iio_core_trigger.h b/drivers/iio/iio_core_trigger.h
index 1fdb1e4ea4a5..a6d6e880a8b8 100644
--- a/drivers/iio/iio_core_trigger.h
+++ b/drivers/iio/iio_core_trigger.h
@@ -21,6 +21,12 @@ void iio_device_register_trigger_consumer(struct iio_dev *indio_dev);
  **/
 void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev);
 
+
+int iio_trigger_attach_poll_func(struct iio_trigger *trig,
+				 struct iio_poll_func *pf);
+int iio_trigger_detach_poll_func(struct iio_trigger *trig,
+				 struct iio_poll_func *pf);
+
 #else
 
 /**
@@ -40,4 +46,15 @@ static void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
 {
 }
 
+static inline int iio_trigger_attach_poll_func(struct iio_trigger *trig,
+					       struct iio_poll_func *pf)
+{
+	return 0;
+}
+static inline int iio_trigger_detach_poll_func(struct iio_trigger *trig,
+					       struct iio_poll_func *pf)
+{
+	return 0;
+}
+
 #endif /* CONFIG_TRIGGER_CONSUMER */
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index cd5bfe39591b..d8eb534a9544 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -24,6 +24,7 @@
 
 #include <linux/iio/iio.h>
 #include "iio_core.h"
+#include "iio_core_trigger.h"
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/buffer_impl.h>
@@ -961,6 +962,13 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 		}
 	}
 
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+		ret = iio_trigger_attach_poll_func(indio_dev->trig,
+						   indio_dev->pollfunc);
+		if (ret)
+			goto err_disable_buffers;
+	}
+
 	return 0;
 
 err_disable_buffers:
@@ -987,6 +995,11 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 	if (list_empty(&indio_dev->buffer_list))
 		return 0;
 
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+		iio_trigger_detach_poll_func(indio_dev->trig,
+					     indio_dev->pollfunc);
+	}
+
 	/*
 	 * If things go wrong at some step in disable we still need to continue
 	 * to perform the other steps, otherwise we leave the device in a
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index ce66699c7fcc..a4dacb638a72 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -242,8 +242,8 @@ static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
  * the relevant function is in there may be the best option.
  */
 /* Worth protecting against double additions? */
-static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
-					struct iio_poll_func *pf)
+int iio_trigger_attach_poll_func(struct iio_trigger *trig,
+				 struct iio_poll_func *pf)
 {
 	int ret = 0;
 	bool notinuse
@@ -290,8 +290,8 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	return ret;
 }
 
-static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
-					 struct iio_poll_func *pf)
+int iio_trigger_detach_poll_func(struct iio_trigger *trig,
+				 struct iio_poll_func *pf)
 {
 	int ret = 0;
 	bool no_other_users
@@ -758,17 +758,3 @@ void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
 	if (indio_dev->trig)
 		iio_trigger_put(indio_dev->trig);
 }
-
-int iio_triggered_buffer_postenable(struct iio_dev *indio_dev)
-{
-	return iio_trigger_attach_poll_func(indio_dev->trig,
-					    indio_dev->pollfunc);
-}
-EXPORT_SYMBOL(iio_triggered_buffer_postenable);
-
-int iio_triggered_buffer_predisable(struct iio_dev *indio_dev)
-{
-	return iio_trigger_detach_poll_func(indio_dev->trig,
-					     indio_dev->pollfunc);
-}
-EXPORT_SYMBOL(iio_triggered_buffer_predisable);
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 44b13fbcd093..24d4a57b41be 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1423,12 +1423,8 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 		goto error_unlock;
 
 	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (!data->buffer) {
+	if (!data->buffer)
 		err = -ENOMEM;
-		goto error_unlock;
-	}
-
-	err = iio_triggered_buffer_postenable(indio_dev);
 
 error_unlock:
 	mutex_unlock(&data->lock);
@@ -1443,10 +1439,6 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 
 	mutex_lock(&data->lock);
 
-	err = iio_triggered_buffer_predisable(indio_dev);
-	if (err < 0)
-		goto error_unlock;
-
 	for_each_set_bit(i, indio_dev->active_scan_mask,
 		indio_dev->masklength) {
 		switch (i) {
@@ -1468,7 +1460,6 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 	if (err == 0)
 		kfree(data->buffer);
 
-error_unlock:
 	mutex_unlock(&data->lock);
 
 	return err;
diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index ed38edcd5efe..5fdfce92019b 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -230,10 +230,6 @@ static int isl29125_buffer_predisable(struct iio_dev *indio_dev)
 	struct isl29125_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret < 0)
-		return ret;
-
 	data->conf1 &= ~ISL29125_MODE_MASK;
 	data->conf1 |= ISL29125_MODE_PD;
 	return i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
@@ -242,7 +238,6 @@ static int isl29125_buffer_predisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops isl29125_buffer_setup_ops = {
 	.preenable = isl29125_buffer_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = isl29125_buffer_predisable,
 };
 
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index ffe9ce798ea2..a700f5fed0d8 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -573,8 +573,6 @@ static int rpr0521_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops rpr0521_buffer_setup_ops = {
 	.preenable = rpr0521_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = rpr0521_buffer_postdisable,
 };
 
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 76f16f9c7616..8019cc93251e 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1175,8 +1175,6 @@ static bool si1145_validate_scan_mask(struct iio_dev *indio_dev,
 
 static const struct iio_buffer_setup_ops si1145_buffer_setup_ops = {
 	.preenable = si1145_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.validate_scan_mask = si1145_validate_scan_mask,
 };
 
diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index 302635836e6b..7ef9c8890522 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -228,8 +228,6 @@ static int st_uvis25_buffer_postdisable(struct iio_dev *iio_dev)
 
 static const struct iio_buffer_setup_ops st_uvis25_buffer_ops = {
 	.preenable = st_uvis25_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = st_uvis25_buffer_postdisable,
 };
 
diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 205e5659ce6b..c31ed0c640e9 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -257,10 +257,6 @@ static int tcs3414_buffer_predisable(struct iio_dev *indio_dev)
 	struct tcs3414_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret < 0)
-		return ret;
-
 	data->control &= ~TCS3414_CONTROL_ADC_EN;
 	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
 		data->control);
@@ -268,7 +264,6 @@ static int tcs3414_buffer_predisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops tcs3414_buffer_setup_ops = {
 	.preenable = tcs3414_buffer_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = tcs3414_buffer_predisable,
 };
 
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index d91cb845e3d6..18f5e5013be4 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -828,8 +828,6 @@ static int bmc150_magn_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops bmc150_magn_buffer_setup_ops = {
 	.preenable = bmc150_magn_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
-	.predisable = iio_triggered_buffer_predisable,
 	.postdisable = bmc150_magn_buffer_postdisable,
 };
 
diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index 0a9e8fadfa9d..8a934b597acc 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -37,25 +37,13 @@ static int st_magn_buffer_preenable(struct iio_dev *indio_dev)
 
 static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 {
-	int err;
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
 
 	mdata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (mdata->buffer_data == NULL) {
-		err = -ENOMEM;
-		goto allocate_memory_error;
-	}
-
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err < 0)
-		goto st_magn_buffer_postenable_error;
-
-	return err;
+	if (mdata->buffer_data == NULL)
+		return -ENOMEM;
 
-st_magn_buffer_postenable_error:
-	kfree(mdata->buffer_data);
-allocate_memory_error:
-	return err;
+	return 0;
 }
 
 static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
@@ -63,13 +51,8 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
 	int err;
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
 
-	err = iio_triggered_buffer_predisable(indio_dev);
-	if (err < 0)
-		goto st_magn_buffer_predisable_error;
-
 	err = st_sensors_set_enable(indio_dev, false);
 
-st_magn_buffer_predisable_error:
 	kfree(mdata->buffer_data);
 	return err;
 }
diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 85714055cc74..84f9105cbb37 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -295,7 +295,6 @@ static int lmp91000_buffer_predisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops lmp91000_buffer_setup_ops = {
 	.preenable = lmp91000_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
 	.predisable = lmp91000_buffer_predisable,
 };
 
diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
index 99468d0a64e7..7eff17e3d87c 100644
--- a/drivers/iio/pressure/st_pressure_buffer.c
+++ b/drivers/iio/pressure/st_pressure_buffer.c
@@ -37,25 +37,13 @@ static int st_press_buffer_preenable(struct iio_dev *indio_dev)
 
 static int st_press_buffer_postenable(struct iio_dev *indio_dev)
 {
-	int err;
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
 
 	press_data->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (press_data->buffer_data == NULL) {
-		err = -ENOMEM;
-		goto allocate_memory_error;
-	}
-
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err < 0)
-		goto st_press_buffer_postenable_error;
-
-	return err;
+	if (press_data->buffer_data == NULL)
+		return -ENOMEM;
 
-st_press_buffer_postenable_error:
-	kfree(press_data->buffer_data);
-allocate_memory_error:
-	return err;
+	return 0;
 }
 
 static int st_press_buffer_predisable(struct iio_dev *indio_dev)
@@ -63,14 +51,9 @@ static int st_press_buffer_predisable(struct iio_dev *indio_dev)
 	int err;
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
 
-	err = iio_triggered_buffer_predisable(indio_dev);
-	if (err < 0)
-		goto st_press_buffer_predisable_error;
-
 	err = st_sensors_set_enable(indio_dev, false);
 
-st_press_buffer_predisable_error:
-	kfree(press_data->buffer_data);
+	kfree(pdata->buffer_data);
 	return err;
 }
 
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 81d8f24eaeb4..2c4295087a36 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -1271,11 +1271,6 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
 			goto err;
 	}
 
-	/* Plug our own trigger event handler. */
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err)
-		goto err;
-
 	return 0;
 
 err:
@@ -1294,7 +1289,6 @@ static int zpa2326_postdisable_buffer(struct iio_dev *indio_dev)
 static const struct iio_buffer_setup_ops zpa2326_buffer_setup_ops = {
 	.preenable   = zpa2326_preenable_buffer,
 	.postenable  = zpa2326_postenable_buffer,
-	.predisable  = iio_triggered_buffer_predisable,
 	.postdisable = zpa2326_postdisable_buffer
 };
 
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index ff80409e0c44..73335e61b350 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -707,8 +707,6 @@ static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
 	struct sx9500_data *data = iio_priv(indio_dev);
 	int ret = 0, i;
 
-	iio_triggered_buffer_predisable(indio_dev);
-
 	mutex_lock(&data->mutex);
 
 	for (i = 0; i < SX9500_NUM_CHANNELS; i++)
@@ -730,7 +728,6 @@ static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops sx9500_buffer_setup_ops = {
 	.preenable = sx9500_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
 	.predisable = sx9500_buffer_predisable,
 };
 
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 6d7444d6e880..c1423de43587 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -98,8 +98,6 @@ static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops ade7758_ring_setup_ops = {
 	.preenable = &ade7758_ring_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
 	.validate_scan_mask = &iio_validate_scan_mask_onehot,
 };
 
diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
index c4f8c7409666..1d3be3a19e76 100644
--- a/include/linux/iio/trigger_consumer.h
+++ b/include/linux/iio/trigger_consumer.h
@@ -53,11 +53,4 @@ irqreturn_t iio_pollfunc_store_time(int irq, void *p);
 
 void iio_trigger_notify_done(struct iio_trigger *trig);
 
-/*
- * Two functions for common case where all that happens is a pollfunc
- * is attached and detached from a trigger
- */
-int iio_triggered_buffer_postenable(struct iio_dev *indio_dev);
-int iio_triggered_buffer_predisable(struct iio_dev *indio_dev);
-
 #endif
-- 
2.17.1
