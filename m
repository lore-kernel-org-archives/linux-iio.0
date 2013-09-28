Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 13/25] iio:mcp4725: Report scale as fractional value
Date: Sat, 28 Sep 2013 11:31:45 +0200
Message-Id: <1380360717-26103-13-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-1-git-send-email-lars@metafoo.de>
References: <1380360717-26103-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Move the complexity of calculating the fixed point scale to the core.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/dac/mcp4725.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 6711a33..f0456f0 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -239,17 +239,15 @@ static int mcp4725_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct mcp4725_data *data = iio_priv(indio_dev);
-	unsigned long scale_uv;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		*val = data->dac_value;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		scale_uv = (data->vref_mv * 1000) >> 12;
-		*val =  scale_uv / 1000000;
-		*val2 = scale_uv % 1000000;
-		return IIO_VAL_INT_PLUS_MICRO;
+		*val = data->vref_mv;
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	}
 	return -EINVAL;
 }
-- 
1.8.0
