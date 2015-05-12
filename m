Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1bon0116.outbound.protection.outlook.com ([157.56.111.116]:45760
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932781AbbELPzz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 12 May 2015 11:55:55 -0400
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <jic23@kernel.org>
CC: <srinivas.pandruvada@linux.intel.com>, <linux-iio@vger.kernel.org>,
	"Fabio Estevam" <fabio.estevam@freescale.com>
Subject: [PATCH v2 2/6] iio: gyro: hid-sensor-gyro-3d: Fix memory leak in probe()
Date: Tue, 12 May 2015 12:40:37 -0300
Message-ID: <1431445241-17557-2-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1431445241-17557-1-git-send-email-fabio.estevam@freescale.com>
References: <1431445241-17557-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

'channels' is allocated via kmemdup and it is never freed in the
subsequent error paths.

Use 'indio_dev->channels' directly instead, so that we avoid such
memory leak problem.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Build-tested only.

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

