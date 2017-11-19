Return-Path: <SRS0=S6BN=CR=gmail.com=paolocretaro@kernel.org>
From: Paolo Cretaro <paolocretaro@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	gwendal@chromium.org,
	enric.balletbo@collabora.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paolo Cretaro <paolocretaro@gmail.com>
Subject: [PATCH] iio: cros_ec: Remove unused variables
Date: Sun, 19 Nov 2017 01:57:45 +0100
Message-Id: <20171119005745.12192-1-paolocretaro@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Fix gcc warnings about variable 'ec_device' being set but not used
in these files:
common/cros_ec_sensors/cros_ec_sensors.c:194:25
light/cros_ec_light_prox.c:184:25

Signed-off-by: Paolo Cretaro <paolocretaro@gmail.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 2 --
 drivers/iio/light/cros_ec_light_prox.c               | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index ed8063f2da99..7d30c59da3e2 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -191,7 +191,6 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
-	struct cros_ec_device *ec_device;
 	struct iio_dev *indio_dev;
 	struct cros_ec_sensors_state *state;
 	struct iio_chan_spec *channel;
@@ -201,7 +200,6 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "No CROS EC device found.\n");
 		return -EINVAL;
 	}
-	ec_device = ec_dev->ec_dev;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*state));
 	if (!indio_dev)
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index b2a46b390d5c..acfad4aeb27a 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -181,7 +181,6 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
-	struct cros_ec_device *ec_device;
 	struct iio_dev *indio_dev;
 	struct cros_ec_light_prox_state *state;
 	struct iio_chan_spec *channel;
@@ -191,7 +190,6 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 		dev_warn(dev, "No CROS EC device found.\n");
 		return -EINVAL;
 	}
-	ec_device = ec_dev->ec_dev;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
 	if (!indio_dev)
-- 
2.15.0
