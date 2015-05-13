Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50]:34028 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109AbbEMSGs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2015 14:06:48 -0400
Received: by yhom41 with SMTP id m41so15231743yho.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2015 11:06:47 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v3 4/6] iio: orientation: hid-sensor-incl-3d: Fix memory leak in probe()
Date: Wed, 13 May 2015 15:06:12 -0300
Message-Id: <1431540374-3168-4-git-send-email-festevam@gmail.com>
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

 drivers/iio/orientation/hid-sensor-incl-3d.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 5930fa3..2eb49a8 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -315,7 +315,6 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct incl_3d_state *incl_state;
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
-	struct iio_chan_spec *channels;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct incl_3d_state));
@@ -336,21 +335,22 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	channels = kmemdup(incl_3d_channels, sizeof(incl_3d_channels),
-			   GFP_KERNEL);
-	if (!channels) {
+	indio_dev->channels = kmemdup(incl_3d_channels,
+				      sizeof(incl_3d_channels), GFP_KERNEL);
+	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 
-	ret = incl_3d_parse_report(pdev, hsdev, channels,
-				HID_USAGE_SENSOR_INCLINOMETER_3D, incl_state);
+	ret = incl_3d_parse_report(pdev, hsdev,
+				   (struct iio_chan_spec *)indio_dev->channels,
+				   HID_USAGE_SENSOR_INCLINOMETER_3D,
+				   incl_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		goto error_free_dev_mem;
 	}
 
-	indio_dev->channels = channels;
 	indio_dev->num_channels = ARRAY_SIZE(incl_3d_channels);
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &incl_3d_info;
-- 
1.9.1

