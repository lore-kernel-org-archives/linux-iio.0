Return-Path: <SRS0=6Xdg=H6=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	drew.paterson@ams.com
Subject: [PATCH v3 3/9] staging: iio: tsl2x7x: turn chip off if IIO device registration fails
Date: Thu, 10 May 2018 20:12:17 -0400
Message-Id: <20180511001223.12378-4-masneyb@onstation.org>
In-Reply-To: <20180511001223.12378-1-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

This patch turns the chip off if IIO device registration fails so that
the error handling mirrors the device remove to make review easier in
preparation for moving this driver out of staging.

This patch also adds a missing error check in the call to
tsl2x7x_chip_on() in tsl2x7x_probe().

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index c1e726fc87b7..f5ca5ada0358 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1657,10 +1657,13 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 	}
 
 	tsl2x7x_defaults(chip);
-	tsl2x7x_chip_on(indio_dev);
+	ret = tsl2x7x_chip_on(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
+		tsl2x7x_chip_off(indio_dev);
 		dev_err(&clientp->dev,
 			"%s: iio registration failed\n", __func__);
 		return ret;
-- 
2.14.3
