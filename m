Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:50414 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbeAaV0f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 31 Jan 2018 16:26:35 -0500
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] hid-sensor-accel-3d: Delete an error message for a failed
 memory allocation in hid_accel_3d_probe()
Message-ID: <0406765c-bdd1-1a82-cf66-1c248063ae4f@users.sourceforge.net>
Date: Wed, 31 Jan 2018 22:26:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 31 Jan 2018 22:20:56 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index c066a3bdbff7..3d0acde40285 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -383,11 +383,9 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 	indio_dev->channels = kmemdup(channel_spec, channel_size, GFP_KERNEL);
-
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
+
 	ret = accel_3d_parse_report(pdev, hsdev,
 				(struct iio_chan_spec *)indio_dev->channels,
 				hsdev->usage, accel_state);
-- 
2.16.1

