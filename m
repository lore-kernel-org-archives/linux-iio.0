Return-Path: <ksenija.stanojevic@gmail.com>
From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH] Staging: iio: Fix sparse endian warning
Date: Wed, 23 Mar 2016 12:06:34 +0100
Message-Id: <1458731194-11597-1-git-send-email-ksenija.stanojevic@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Fix following sparse warning:
warning: cast to restricted __be16

Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
---
 drivers/staging/iio/adc/ad7606_spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index d873a51..825da07 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -21,7 +21,8 @@ static int ad7606_spi_read_block(struct device *dev,
 {
 	struct spi_device *spi = to_spi_device(dev);
 	int i, ret;
-	unsigned short *data = buf;
+	unsigned short *data;
+	__be16 *bdata = buf;
 
 	ret = spi_read(spi, buf, count * 2);
 	if (ret < 0) {
@@ -30,7 +31,7 @@ static int ad7606_spi_read_block(struct device *dev,
 	}
 
 	for (i = 0; i < count; i++)
-		data[i] = be16_to_cpu(data[i]);
+		data[i] = be16_to_cpu(bdata[i]);
 
 	return 0;
 }
-- 
1.9.1
