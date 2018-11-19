Return-Path: <MAILER-DAEMON>
From: Martin Kelly <martin@martingkelly.com>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Martin Kelly <martin@martingkelly.com>
Subject: [PATCH 2/2] iio: bmi160: use all devm functions in probe
Date: Sun, 18 Nov 2018 16:53:47 -0800
Message-Id: <20181119005347.747-2-martin@martingkelly.com>
In-Reply-To: <20181119005347.747-1-martin@martingkelly.com>
References: <20181119005347.747-1-martin@martingkelly.com>
List-ID: <linux-iio@vger.kernel.org>

From: Martin Kelly <martin@martingkelly.com>

Currently, we're using the devm version of some but not all functions.
Switch to the devm version of iio_triggered_buffer_setup and
iio_device_register to simplify the code a bit and decrease the chance of
bugs.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 4d9d59d9e3a9..5e4efaed5e88 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -577,18 +577,16 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmi160_info;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 bmi160_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      bmi160_trigger_handler, NULL);
 	if (ret < 0)
 		goto uninit;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret < 0)
-		goto buffer_cleanup;
+		goto uninit;
 
 	return 0;
-buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
 uninit:
 	bmi160_chip_uninit(data);
 	return ret;
@@ -600,8 +598,6 @@ void bmi160_core_remove(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmi160_data *data = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
 	bmi160_chip_uninit(data);
 }
 EXPORT_SYMBOL_GPL(bmi160_core_remove);
-- 
2.11.0
