Return-Path: <SRS0=WXyL=E2=users.sourceforge.net=elfring@kernel.org>
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Jiri Kosina <jikos@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] hid-sensor-gyro-3d: Delete an error message for a failed
 memory allocation in hid_gyro_3d_probe()
Message-ID: <e3308896-dd91-1af0-912f-32cc0794361e@users.sourceforge.net>
Date: Wed, 31 Jan 2018 21:43:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 31 Jan 2018 21:36:53 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index f59995a90387..93465816c5c7 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -317,10 +317,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 
 	indio_dev->channels = kmemdup(gyro_3d_channels,
 				      sizeof(gyro_3d_channels), GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
 
 	ret = gyro_3d_parse_report(pdev, hsdev,
 				   (struct iio_chan_spec *)indio_dev->channels,
-- 
2.16.1
