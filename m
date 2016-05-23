Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [RFC 7/7] iio: Make trigger names unique
Date: Mon, 23 May 2016 21:40:02 +0300
Message-Id: <72a676266aee1d40f14e5cf3b62c7ada4eb0c614.1464027859.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1464027859.git.leonard.crestez@intel.com>
References: <cover.1464027859.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1464027859.git.leonard.crestez@intel.com>
References: <cover.1464027859.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This changes the format of trigger names for some drivers so that the
result always includes indio_dev->id and is thus unique.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/adc/max1027.c                          | 4 ++--
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 2 +-
 drivers/iio/light/gp2ap020a00f.c                   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 41d495c..4020257 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -447,8 +447,8 @@ static int max1027_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-trigger",
-							indio_dev->name);
+	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
+					  indio_dev->name, indio_dev->iod);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
 		dev_err(&indio_dev->dev, "Failed to allocate iio trigger\n");
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index da72279..9d3e9ab 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -24,7 +24,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 	unsigned long irq_trig;
 
-	sdata->trig = iio_trigger_alloc("%s-trigger", indio_dev->name);
+	sdata->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name, indio_dev->id);
 	if (sdata->trig == NULL) {
 		dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
 		return -ENOMEM;
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 6d41086..e2efaeb 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1553,8 +1553,8 @@ static int gp2ap020a00f_probe(struct i2c_client *client,
 		goto error_regulator_disable;
 
 	/* Allocate trigger */
-	data->trig = devm_iio_trigger_alloc(&client->dev, "%s-trigger",
-							indio_dev->name);
+	data->trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
+					    indio_dev->name, indio_dev->id);
 	if (data->trig == NULL) {
 		err = -ENOMEM;
 		dev_err(&indio_dev->dev, "Failed to allocate iio trigger.\n");
-- 
2.5.5
