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
Subject: [PATCH v2] staging: iio: adc: fix comment block coding style issue
Date: Sun,  4 Oct 2015 16:30:45 +0000
Message-Id: <1443976245-869-1-git-send-email-hugo.camboulive@gmail.com>
In-Reply-To: <56111433.4090904@metafoo.de>
References: <56111433.4090904@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

This patch to ad7746.c makes the comment blocks end with a */
on a separate line, and start with a /* on an empty line.

Signed-off-by: Hugo Camboulive <hugo.camboulive@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 10fa372..e8eab25 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -528,10 +528,11 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 			goto out;
 		}
 
-		/* CAPDAC Scale = 21pF_typ / 127
+		/*
+		 * CAPDAC Scale = 21pF_typ / 127
 		 * CIN Scale = 8.192pF / 2^24
 		 * Offset Scale = CAPDAC Scale / CIN Scale = 338646
-		 * */
+		 */
 
 		val /= 338646;
 
@@ -600,7 +601,8 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 		switch (chan->type) {
 		case IIO_TEMP:
-		/* temperature in milli degrees Celsius
+		/*
+		 * temperature in milli degrees Celsius
 		 * T = ((*val / 2048) - 4096) * 1000
 		 */
 			*val = (*val * 125) / 256;
-- 
2.6.0
