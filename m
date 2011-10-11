Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:adc:max1363 incorrect allocation of available_scanmasks
Date: Tue, 11 Oct 2011 12:47:20 +0100
Message-Id: <1318333640-18037-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Longs are not known for being 8 bits.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 12db93e..eb699ad 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -1271,7 +1271,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	st->client = client;
 
 	indio_dev->available_scan_masks
-		= kzalloc(BITS_TO_LONGS(MAX1363_MAX_CHANNELS)*
+		= kzalloc(BITS_TO_LONGS(MAX1363_MAX_CHANNELS)*sizeof(long)*
 			  (st->chip_info->num_modes + 1), GFP_KERNEL);
 	if (!indio_dev->available_scan_masks) {
 		ret = -ENOMEM;
-- 
1.7.3.4
