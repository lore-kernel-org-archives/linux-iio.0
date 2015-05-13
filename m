Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33385 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387AbbEMSGn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2015 14:06:43 -0400
Received: by ykeo186 with SMTP id o186so16826729yke.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2015 11:06:42 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v3 2/6] iio: gyro: hid-sensor-gyro-3d: Fix memory leak in probe()
Date: Wed, 13 May 2015 15:06:10 -0300
Message-Id: <1431540374-3168-2-git-send-email-festevam@gmail.com>
In-Reply-To: <1431540374-3168-1-git-send-email-festevam@gmail.com>
References: <1431540374-3168-1-git-send-email-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

'channels' is allocated via kmemdup and it is never freed in the
subsequent error paths.

Use 'indio_dev->channels' directly instead, so that we avoid such
memory leak problem.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Build-tested only.

Changes since v2:
- None
Changes since v1:
- Make clear in the commit log that the proble only occurs in the error
paths

 drivers/iio/gyro/hid-sensor-gyro-3d.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index b5883b6..7b60b58 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -298,7 +298,6 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct gyro_3d_state *gyro_state;
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
-	struct iio_chan_spec *channels;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*gyro_state));
 	if (!indio_dev)
@@ -317,21 +316,21 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	channels = kmemdup(gyro_3d_channels, sizeof(gyro_3d_channels),
-			   GFP_KERNEL);
-	if (!channels) {
+	indio_dev->channels = kmemdup(gyro_3d_channels,
+				      sizeof(gyro_3d_channels), GFP_KERNEL);
+	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 
-	ret = gyro_3d_parse_report(pdev, hsdev, channels,
-					HID_USAGE_SENSOR_GYRO_3D, gyro_state);
+	ret = gyro_3d_parse_report(pdev, hsdev,
+				   (struct iio_chan_spec *)indio_dev->channels,
+				   HID_USAGE_SENSOR_GYRO_3D, gyro_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		goto error_free_dev_mem;
 	}
 
-	indio_dev->channels = channels;
 	indio_dev->num_channels = ARRAY_SIZE(gyro_3d_channels);
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &gyro_3d_info;
-- 
1.9.1

