Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yh0-f53.google.com ([209.85.213.53]:34008 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbbEMSGp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2015 14:06:45 -0400
Received: by yhom41 with SMTP id m41so15231342yho.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2015 11:06:45 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v3 3/6] iio: light: hid-sensor-als.c: Fix memory leak in probe()
Date: Wed, 13 May 2015 15:06:11 -0300
Message-Id: <1431540374-3168-3-git-send-email-festevam@gmail.com>
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


 drivers/iio/light/hid-sensor-als.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 1609ecd..9d74364 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -263,7 +263,6 @@ static int hid_als_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct als_state *als_state;
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
-	struct iio_chan_spec *channels;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct als_state));
 	if (!indio_dev)
@@ -281,20 +280,21 @@ static int hid_als_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	channels = kmemdup(als_channels, sizeof(als_channels), GFP_KERNEL);
-	if (!channels) {
+	indio_dev->channels = kmemdup(als_channels,
+				      sizeof(als_channels), GFP_KERNEL);
+	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 
-	ret = als_parse_report(pdev, hsdev, channels,
-				HID_USAGE_SENSOR_ALS, als_state);
+	ret = als_parse_report(pdev, hsdev,
+			       (struct iio_chan_spec *)indio_dev->channels,
+			       HID_USAGE_SENSOR_ALS, als_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		goto error_free_dev_mem;
 	}
 
-	indio_dev->channels = channels;
 	indio_dev->num_channels =
 				ARRAY_SIZE(als_channels);
 	indio_dev->dev.parent = &pdev->dev;
-- 
1.9.1

