Return-Path: <nizamhaider786@gmail.com>
From: Nizam Haider <nizamhaider786@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nizam Haider <nizamhaider786@gmail.com>,
	Nizam Haider <nijamh@cdac.in>
Subject: [PATCH] iio: adc: ad7793: removed unnecessary else.
Date: Mon,  9 Nov 2015 18:20:45 +0530
Message-Id: <1447073445-9231-1-git-send-email-nizamhaider786@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Else is not generally useful after a break or return.

Signed-off-by: Nizam Haider <nijamh@cdac.in>
---
 drivers/iio/adc/ad7793.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index eea0c79..3bc5655 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -478,10 +478,9 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
 				*val2 = st->
 					scale_avail[(st->conf >> 8) & 0x7][1];
 				return IIO_VAL_INT_PLUS_NANO;
-			} else {
-				/* 1170mV / 2^23 * 6 */
-				scale_uv = (1170ULL * 1000000000ULL * 6ULL);
 			}
+			/* 1170mV / 2^23 * 6 */
+			scale_uv = (1170ULL * 1000000000ULL * 6ULL);
 			break;
 		case IIO_TEMP:
 				/* 1170mV / 0.81 mV/C / 2^23 */
-- 
1.8.1.4
