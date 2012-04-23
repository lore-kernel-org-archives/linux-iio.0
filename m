Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/8] staging:iio:dac:ad5446: Remove duplicated chip_info entries
Date: Mon, 23 Apr 2012 19:51:33 +0200
Message-Id: <1335203497-11041-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1335203497-11041-1-git-send-email-lars@metafoo.de>
References: <1335203497-11041-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

There are three identical chip_info entries. Remove two of them and use the id
of the remaining entry for all three device table entries.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5446.c |   12 ++----------
 drivers/staging/iio/dac/ad5446.h |    2 --
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 9d9a452..693485a 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -176,14 +176,6 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 		.channel = AD5446_CHANNEL(16, 16, 0),
 		.store_sample = ad5542_store_sample,
 	},
-	[ID_AD5542A] = {
-		.channel = AD5446_CHANNEL(16, 16, 0),
-		.store_sample = ad5542_store_sample,
-	},
-	[ID_AD5543] = {
-		.channel = AD5446_CHANNEL(16, 16, 0),
-		.store_sample = ad5542_store_sample,
-	},
 	[ID_AD5512A] = {
 		.channel = AD5446_CHANNEL(12, 16, 4),
 		.store_sample = ad5542_store_sample,
@@ -400,8 +392,8 @@ static const struct spi_device_id ad5446_id[] = {
 	{"ad5446", ID_AD5446},
 	{"ad5512a", ID_AD5512A},
 	{"ad5541a", ID_AD5541A},
-	{"ad5542a", ID_AD5542A},
-	{"ad5543", ID_AD5543},
+	{"ad5542a", ID_AD5541A}, /* ad5541a and ad5542a are compatible */
+	{"ad5543", ID_AD5541A}, /* ad5541a and ad5543 are compatible */
 	{"ad5553", ID_AD5553},
 	{"ad5601", ID_AD5601},
 	{"ad5611", ID_AD5611},
diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
index 72ad07f..264df1e 100644
--- a/drivers/staging/iio/dac/ad5446.h
+++ b/drivers/staging/iio/dac/ad5446.h
@@ -83,8 +83,6 @@ enum ad5446_supported_device_ids {
 	ID_AD5444,
 	ID_AD5446,
 	ID_AD5541A,
-	ID_AD5542A,
-	ID_AD5543,
 	ID_AD5512A,
 	ID_AD5553,
 	ID_AD5601,
-- 
1.7.9.5
