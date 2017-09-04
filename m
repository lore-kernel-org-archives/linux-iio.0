Return-Path: <SRS0=DCin=AF=analog.com=Dragos.Bogdan@kernel.org>
From: Dragos Bogdan <dragos.bogdan@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH] iio:ad7793: Fix the serial interface reset
Date: Mon, 4 Sep 2017 18:00:48 +0300
Message-ID: <20170904150048.12420-1-dragos.bogdan@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The serial interface can be reset by writing 32 consecutive 1s to the device.
The value of 'ret' is overwritten when ad7793_check_platform_data() is called,
so it should be initialized to -1 only before doing the spi_write().

Fixes: commit 2edb769d246e ("iio:ad7793: Add support for the ad7798 and ad7799")

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
---
 drivers/iio/adc/ad7793.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index e6706a09e100..8680abf72dd2 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -257,7 +257,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 	unsigned int vref_mv)
 {
 	struct ad7793_state *st = iio_priv(indio_dev);
-	int i, ret = -1;
+	int i, ret;
 	unsigned long long scale_uv;
 	u32 id;
 
@@ -266,6 +266,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 		return ret;
 
 	/* reset the serial interface */
+	ret = -1;
 	ret = spi_write(st->sd.spi, (u8 *)&ret, sizeof(ret));
 	if (ret < 0)
 		goto out;
-- 
2.11.0
