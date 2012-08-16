Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Milo Kim <Milo.Kim@ti.com>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [RFC 3/4] iio:ad5064: Report scale as fractional value
Date: Thu, 16 Aug 2012 11:18:44 +0200
Message-Id: <1345108725-22120-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1345108725-22120-1-git-send-email-lars@metafoo.de>
References: <1345108725-22120-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Report the scale as a fractional value. This avoids having to do the conversion
from fractional to fixed point manually in the driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5064.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index eb281a2..a163e86 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -240,10 +240,9 @@ static int ad5064_read_raw(struct iio_dev *indio_dev,
 		if (scale_uv < 0)
 			return scale_uv;
 
-		scale_uv = (scale_uv * 100) >> chan->scan_type.realbits;
-		*val =  scale_uv / 100000;
-		*val2 = (scale_uv % 100000) * 10;
-		return IIO_VAL_INT_PLUS_MICRO;
+		*val = scale_uv;
+		*val2 = ((1 << chan->scan_type.realbits) - 1) * 1000;
+		return IIO_VAL_FRACTIONAL;
 	default:
 		break;
 	}
-- 
1.7.10.4
