Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com
CC: linux-iio@vger.kernel.org, drivers@analog.com, jic23@cam.ac.uk,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/3] IIO: DAC: AD5446: Add missing ID table entries
Date: Thu, 10 Mar 2011 13:26:46 +0100
Message-ID: <1299760008-25899-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/ad5446.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index dcec297..4f1d881 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -295,8 +295,10 @@ static int ad5446_remove(struct spi_device *spi)
 static const struct spi_device_id ad5446_id[] = {
 	{"ad5444", ID_AD5444},
 	{"ad5446", ID_AD5446},
-	{"ad5542a", ID_AD5542A},
 	{"ad5512a", ID_AD5512A},
+	{"ad5542a", ID_AD5542A},
+	{"ad5543", ID_AD5543},
+	{"ad5553", ID_AD5553},
 	{"ad5620-2500", ID_AD5620_2500}, /* AD5620/40/60: */
 	{"ad5620-1250", ID_AD5620_1250}, /* part numbers may look differently */
 	{"ad5640-2500", ID_AD5640_2500},
--
1.6.0.2
