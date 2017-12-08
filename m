Return-Path: <SRS0=G+O7=DE=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>, Maciej Purski
	<m.purski@samsung.com>, <linux-kernel@vger.kernel.org>, "Andrew F . Davis"
	<afd@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, "Javier Martinez
 Canillas" <javier@osg.samsung.com>
Subject: [PATCH v1 4/7] iio: adc: ina2xx: Do not udelay for several seconds
Date: Fri, 8 Dec 2017 18:41:49 +0100
In-Reply-To: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de>
References: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <44807977-8b46-4678-b8e5-440ff8208062@rwthex-w2-a.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

The conversion time can be up to 16 seconds (8 ms per channel, 2 channels,
1024 times averaging).

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---

 drivers/iio/adc/ina2xx-adc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index b027d485398b..2621a34ee5c6 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -764,7 +764,7 @@ static int ina2xx_capture_thread(void *data)
 	struct iio_dev *indio_dev = data;
 	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
 	int sampling_us = SAMPLING_PERIOD(chip);
-	int buffer_us;
+	int buffer_us, delay_us;
 
 	/*
 	 * Poll a bit faster than the chip internal Fs, in case
@@ -778,8 +778,10 @@ static int ina2xx_capture_thread(void *data)
 		if (buffer_us < 0)
 			return buffer_us;
 
-		if (sampling_us > buffer_us)
-			udelay(sampling_us - buffer_us);
+		if (sampling_us > buffer_us) {
+			delay_us = sampling_us - buffer_us;
+			usleep_range(delay_us, (delay_us * 3) >> 1);
+		}
 
 	} while (!kthread_should_stop());
 
-- 
2.15.1
