Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36456 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbcKZDiB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Nov 2016 22:38:01 -0500
From: Aniroop Mathur <a.mathur@samsung.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: s.samuel@samsung.com, r.mahale@samsung.com,
        aniroop.mathur@gmail.com, Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] IIO: Change msleep to usleep_range for small msecs
Date: Sat, 26 Nov 2016 09:17:26 +0530
Message-Id: <1480132046-5406-1-git-send-email-a.mathur@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

msleep(1~20) may not do what the caller intends, and will often sleep longer.
(~20 ms actual sleep for any value given in the 1~20ms range)
This is not the desired behaviour for many cases like device resume time,
device suspend time, device enable time, data reading time, etc.
Thus, change msleep to usleep_range for precise wakeups.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/iio/adc/exynos_adc.c             |  2 +-
 drivers/iio/pressure/bmp280-core.c       | 14 +++++++-------
 drivers/staging/iio/meter/ade7753.c      |  2 +-
 drivers/staging/iio/meter/ade7753.h      |  2 +-
 drivers/staging/iio/meter/ade7754.c      |  2 +-
 drivers/staging/iio/meter/ade7754.h      |  2 +-
 drivers/staging/iio/meter/ade7758.h      |  2 +-
 drivers/staging/iio/meter/ade7758_core.c |  2 +-
 drivers/staging/iio/meter/ade7759.c      |  2 +-
 drivers/staging/iio/meter/ade7759.h      |  2 +-
 drivers/staging/iio/meter/ade7854.c      |  2 +-
 drivers/staging/iio/meter/ade7854.h      |  2 +-
 12 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index c15756d..ad1775b 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -632,7 +632,7 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
 		input_report_key(info->input, BTN_TOUCH, 1);
 		input_sync(info->input);
 
-		msleep(1);
+		usleep_range(1000, 1100);
 	};
 
 	writel(0, ADC_V1_CLRINTPNDNUP(info->regs));
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index e5a533c..4d18826 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -65,7 +65,7 @@ struct bmp280_data {
 	struct bmp180_calib calib;
 	struct regulator *vddd;
 	struct regulator *vdda;
-	unsigned int start_up_time; /* in milliseconds */
+	unsigned int start_up_time; /* in microseconds */
 
 	/* log of base 2 of oversampling rate */
 	u8 oversampling_press;
@@ -935,14 +935,14 @@ int bmp280_common_probe(struct device *dev,
 		data->chip_info = &bmp180_chip_info;
 		data->oversampling_press = ilog2(8);
 		data->oversampling_temp = ilog2(1);
-		data->start_up_time = 10;
+		data->start_up_time = 10000;
 		break;
 	case BMP280_CHIP_ID:
 		indio_dev->num_channels = 2;
 		data->chip_info = &bmp280_chip_info;
 		data->oversampling_press = ilog2(16);
 		data->oversampling_temp = ilog2(2);
-		data->start_up_time = 2;
+		data->start_up_time = 2000;
 		break;
 	case BME280_CHIP_ID:
 		indio_dev->num_channels = 3;
@@ -950,7 +950,7 @@ int bmp280_common_probe(struct device *dev,
 		data->oversampling_press = ilog2(16);
 		data->oversampling_humid = ilog2(16);
 		data->oversampling_temp = ilog2(2);
-		data->start_up_time = 2;
+		data->start_up_time = 2000;
 		break;
 	default:
 		return -EINVAL;
@@ -979,7 +979,7 @@ int bmp280_common_probe(struct device *dev,
 		goto out_disable_vddd;
 	}
 	/* Wait to make sure we started up properly */
-	mdelay(data->start_up_time);
+	usleep_range(data->start_up_time, data->start_up_time + 100);
 
 	/* Bring chip out of reset if there is an assigned GPIO line */
 	gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
@@ -1038,7 +1038,7 @@ int bmp280_common_probe(struct device *dev,
 	 * Set autosuspend to two orders of magnitude larger than the
 	 * start-up time.
 	 */
-	pm_runtime_set_autosuspend_delay(dev, data->start_up_time *100);
+	pm_runtime_set_autosuspend_delay(dev, data->start_up_time / 10);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_put(dev);
 
@@ -1101,7 +1101,7 @@ static int bmp280_runtime_resume(struct device *dev)
 	ret = regulator_enable(data->vdda);
 	if (ret)
 		return ret;
-	msleep(data->start_up_time);
+	usleep_range(data->start_up_time, data->start_up_time + 100);
 	return data->chip_info->chip_config(data);
 }
 #endif /* CONFIG_PM */
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 4b5f05f..671dc99 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -377,7 +377,7 @@ static int ade7753_initial_setup(struct iio_dev *indio_dev)
 	}
 
 	ade7753_reset(dev);
-	msleep(ADE7753_STARTUP_DELAY);
+	usleep_range(ADE7753_STARTUP_DELAY, ADE7753_STARTUP_DELAY + 100);
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/meter/ade7753.h b/drivers/staging/iio/meter/ade7753.h
index a9d93cc..bfe7491 100644
--- a/drivers/staging/iio/meter/ade7753.h
+++ b/drivers/staging/iio/meter/ade7753.h
@@ -49,7 +49,7 @@
 
 #define ADE7753_MAX_TX    4
 #define ADE7753_MAX_RX    4
-#define ADE7753_STARTUP_DELAY 1
+#define ADE7753_STARTUP_DELAY 1000
 
 #define ADE7753_SPI_SLOW	(u32)(300 * 1000)
 #define ADE7753_SPI_BURST	(u32)(1000 * 1000)
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index c46bef6..49eb10b 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -396,7 +396,7 @@ static int ade7754_initial_setup(struct iio_dev *indio_dev)
 	}
 
 	ade7754_reset(dev);
-	msleep(ADE7754_STARTUP_DELAY);
+	usleep_range(ADE7754_STARTUP_DELAY, ADE7754_STARTUP_DELAY + 100);
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/meter/ade7754.h b/drivers/staging/iio/meter/ade7754.h
index e42ffc3..28f71c2 100644
--- a/drivers/staging/iio/meter/ade7754.h
+++ b/drivers/staging/iio/meter/ade7754.h
@@ -67,7 +67,7 @@
 
 #define ADE7754_MAX_TX    4
 #define ADE7754_MAX_RX    4
-#define ADE7754_STARTUP_DELAY 1
+#define ADE7754_STARTUP_DELAY 1000
 
 #define ADE7754_SPI_SLOW	(u32)(300 * 1000)
 #define ADE7754_SPI_BURST	(u32)(1000 * 1000)
diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
index 1d04ec9..6ae78d8 100644
--- a/drivers/staging/iio/meter/ade7758.h
+++ b/drivers/staging/iio/meter/ade7758.h
@@ -89,7 +89,7 @@
 
 #define ADE7758_MAX_TX    8
 #define ADE7758_MAX_RX    4
-#define ADE7758_STARTUP_DELAY 1
+#define ADE7758_STARTUP_DELAY 1000
 
 #define AD7758_NUM_WAVSEL	5
 #define AD7758_NUM_PHSEL	3
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index ebb8a19..3767246 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -459,7 +459,7 @@ static int ade7758_initial_setup(struct iio_dev *indio_dev)
 	}
 
 	ade7758_reset(dev);
-	msleep(ADE7758_STARTUP_DELAY);
+	usleep_range(ADE7758_STARTUP_DELAY, ADE7758_STARTUP_DELAY + 100);
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 80144d4..944ee34 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -338,7 +338,7 @@ static int ade7759_initial_setup(struct iio_dev *indio_dev)
 	}
 
 	ade7759_reset(dev);
-	msleep(ADE7759_STARTUP_DELAY);
+	usleep_range(ADE7759_STARTUP_DELAY, ADE7759_STARTUP_DELAY + 100);
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/meter/ade7759.h b/drivers/staging/iio/meter/ade7759.h
index f9ff1f8..f0716d2 100644
--- a/drivers/staging/iio/meter/ade7759.h
+++ b/drivers/staging/iio/meter/ade7759.h
@@ -30,7 +30,7 @@
 
 #define ADE7759_MAX_TX    6
 #define ADE7759_MAX_RX    6
-#define ADE7759_STARTUP_DELAY 1
+#define ADE7759_STARTUP_DELAY 1000
 
 #define ADE7759_SPI_SLOW	(u32)(300 * 1000)
 #define ADE7759_SPI_BURST	(u32)(1000 * 1000)
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 75e8685..58a05ec 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -444,7 +444,7 @@ static int ade7854_initial_setup(struct iio_dev *indio_dev)
 	}
 
 	ade7854_reset(dev);
-	msleep(ADE7854_STARTUP_DELAY);
+	usleep_range(ADE7854_STARTUP_DELAY, ADE7854_STARTUP_DELAY + 100);
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index 52f4195..dbd97de 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -136,7 +136,7 @@
 
 #define ADE7854_MAX_TX    7
 #define ADE7854_MAX_RX    7
-#define ADE7854_STARTUP_DELAY 1
+#define ADE7854_STARTUP_DELAY 1000
 
 #define ADE7854_SPI_SLOW	(u32)(300 * 1000)
 #define ADE7854_SPI_BURST	(u32)(1000 * 1000)
-- 
2.6.2

