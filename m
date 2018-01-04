Return-Path: <SRS0=Sbe4=D7=google.com=gwendal@kernel.org>
Sender: Gwendal Grignou <gwendal@google.com>
From: Gwendal Grignou <gwendal@chromium.org>
To: enric.balletbo@collabora.com,
	jic23@kernel.org,
	groeck@chromium.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 1/3] iio: cros_ec: light code cleanup
Date: Thu,  4 Jan 2018 12:17:16 -0800
Message-Id: <20180104201718.221900-2-gwendal@chromium.org>
In-Reply-To: <20180104201718.221900-1-gwendal@chromium.org>
References: <20180104201718.221900-1-gwendal@chromium.org>
List-ID: <linux-iio@vger.kernel.org>

- use dev instead of &pdev->dev when defined
- remove syfs.h inclusion.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c      | 5 ++---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 7 +++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 7d30c59da3e2..2297c8ce7cb8 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -29,7 +29,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 
 #include "cros_ec_sensors_core.h"
 
@@ -201,7 +200,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -241,7 +240,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 			channel->type = IIO_MAGN;
 			break;
 		default:
-			dev_err(&pdev->dev, "Unknown motion sensor\n");
+			dev_err(dev, "Unknown motion sensor\n");
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 416cae5ebbd0..d50a32ba91fe 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -24,7 +24,6 @@
 #include <linux/mfd/cros_ec_commands.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/platform_device.h>
 
 #include "cros_ec_sensors_core.h"
@@ -41,13 +40,13 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
-	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
+	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
 	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
 
 	platform_set_drvdata(pdev, indio_dev);
 
 	state->ec = ec->ec_dev;
-	state->msg = devm_kzalloc(&pdev->dev,
+	state->msg = devm_kzalloc(dev,
 				max((u16)sizeof(struct ec_params_motion_sense),
 				state->ec->max_response), GFP_KERNEL);
 	if (!state->msg)
@@ -62,7 +61,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	state->msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
 	state->msg->outsize = sizeof(struct ec_params_motion_sense);
 
-	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->dev.parent = dev;
 	indio_dev->name = pdev->name;
 
 	if (physical_device) {
-- 
2.16.0.rc0.223.g4a4ac83678-goog
