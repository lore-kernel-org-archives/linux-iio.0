Return-Path: <SRS0=iwlF=HK=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 06/13] staging: iio: tsl2x7x: simplify tsl2x7x_write_interrupt_config return
Date: Fri, 20 Apr 2018 20:41:46 -0400
Message-Id: <20180421004153.19073-7-masneyb@onstation.org>
In-Reply-To: <20180421004153.19073-1-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

tsl2x7x_write_interrupt_config() has an unnecessary return value check
at the end of the function. This patch changes the function to just
return the value from the call to tsl2x7x_invoke_change().

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 8d8af0cf9768..d202bc7e1f4f 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -982,18 +982,13 @@ static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
 					  int val)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int ret;
 
 	if (chan->type == IIO_INTENSITY)
 		chip->settings.als_interrupt_en = val ? true : false;
 	else
 		chip->settings.prox_interrupt_en = val ? true : false;
 
-	ret = tsl2x7x_invoke_change(indio_dev);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return tsl2x7x_invoke_change(indio_dev);
 }
 
 static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
-- 
2.14.3
