Return-Path: <festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/2] iio: light: hid-sensor-prox: Fit assignment in one line
Date: Fri,  8 May 2015 15:54:00 -0300
Message-Id: <1431111241-7472-1-git-send-email-festevam@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

There is no need to do the assignment to indio_dev->num_channels in two
lines code.

Put it in one line.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/iio/light/hid-sensor-prox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 124a8f8..4ed42df 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -286,8 +286,7 @@ static int hid_prox_probe(struct platform_device *pdev)
 		goto error_free_dev_mem;
 	}
 
-	indio_dev->num_channels =
-				ARRAY_SIZE(prox_channels);
+	indio_dev->num_channels = ARRAY_SIZE(prox_channels);
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &prox_info;
 	indio_dev->name = name;
-- 
1.9.1
