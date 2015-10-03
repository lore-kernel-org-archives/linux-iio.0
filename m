Return-Path: <hugo.camboulive@gmail.com>
From: Hugo Camboulive <hugo.camboulive@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Hugo Camboulive <hugo.camboulive@gmail.com>
Subject: [PATCH] staging: iio: adc: fix comment block coding style issue
Date: Sat,  3 Oct 2015 18:32:48 +0000
Message-Id: <1443897168-5591-1-git-send-email-hugo.camboulive@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch to ad7746.c makes the comment block end with a */
on a separate line.

Signed-off-by: Hugo Camboulive <hugo.camboulive@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 10fa372..8445ddd 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -531,7 +531,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 		/* CAPDAC Scale = 21pF_typ / 127
 		 * CIN Scale = 8.192pF / 2^24
 		 * Offset Scale = CAPDAC Scale / CIN Scale = 338646
-		 * */
+		 */
 
 		val /= 338646;
 
-- 
2.6.0
