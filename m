Return-Path: <SRS0=Wj4l=DY=gmail.com=jihuun.k@kernel.org>
Date: Wed, 27 Dec 2017 18:47:18 -0800
From: Ji-Hun Kim <jihuun.k@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: iio: remove unnecessary parentheses
Message-ID: <20171228024714.GA3110@MacBook-Air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Clean up checkpatch warning:
CHECK: Unnecessary parentheses around 'st->devid != ID_AD7195'

Signed-off-by: Ji-Hun Kim <jihuun.k@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index cadfb96..f015955 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -271,7 +271,7 @@ static int ad7192_setup(struct ad7192_state *st,
 	if (pdata->sinc3_en)
 		st->mode |= AD7192_MODE_SINC3;
 
-	if (pdata->refin2_en && (st->devid != ID_AD7195))
+	if (pdata->refin2_en && st->devid != ID_AD7195)
 		st->conf |= AD7192_CONF_REFSEL;
 
 	if (pdata->chop_en) {
-- 
2.10.1 (Apple Git-78)
