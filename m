Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35169 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932186AbbEMSGx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2015 14:06:53 -0400
Received: by ykec202 with SMTP id c202so16808375yke.2
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2015 11:06:52 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v3 6/6] iio: pressure: hid-sensor-press: Fix memory leak in probe()
Date: Wed, 13 May 2015 15:06:14 -0300
Message-Id: <1431540374-3168-6-git-send-email-festevam@gmail.com>
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
- Properly align "press_parse_report(" in multiple lines
Changes since v1:
- Make clear in the commit log that the proble only occurs in the error
paths
 drivers/iio/pressure/hid-sensor-press.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 7bb8d4c..5a10dbc 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -262,7 +262,6 @@ static int hid_press_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct press_state *press_state;
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
-	struct iio_chan_spec *channels;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 				sizeof(struct press_state));
@@ -282,20 +281,21 @@ static int hid_press_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	channels = kmemdup(press_channels, sizeof(press_channels), GFP_KERNEL);
-	if (!channels) {
+	indio_dev->channels = kmemdup(press_channels, sizeof(press_channels),
+				      GFP_KERNEL);
+	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 
-	ret = press_parse_report(pdev, hsdev, channels,
-				HID_USAGE_SENSOR_PRESSURE, press_state);
+	ret = press_parse_report(pdev, hsdev,
+				 (struct iio_chan_spec *)indio_dev->channels,
+				 HID_USAGE_SENSOR_PRESSURE, press_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		goto error_free_dev_mem;
 	}
 
-	indio_dev->channels = channels;
 	indio_dev->num_channels =
 				ARRAY_SIZE(press_channels);
 	indio_dev->dev.parent = &pdev->dev;
-- 
1.9.1

