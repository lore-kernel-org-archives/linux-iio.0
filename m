Return-Path: <SRS0=2qIu=DR=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>, Maciej Purski
	<m.purski@samsung.com>, <linux-kernel@vger.kernel.org>, "Andrew F . Davis"
	<afd@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH v2 4/7] iio: adc: ina2xx: Do not udelay for several seconds
Date: Thu, 21 Dec 2017 19:31:35 +0100
In-Reply-To: <20171221183138.361-1-stefan.bruens@rwth-aachen.de>
References: <20171221183138.361-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <3cf0575b-0b74-4c9e-b7be-a044b2245ff3@rwthex-w2-a.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

The conversion time can be up to 16 seconds (8 ms per channel, 2 channels,
1024 times averaging).

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---

Changes in v2: None

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
