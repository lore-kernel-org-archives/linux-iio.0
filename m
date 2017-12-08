Return-Path: <SRS0=G+O7=DE=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>, Maciej Purski
	<m.purski@samsung.com>, <linux-kernel@vger.kernel.org>, "Andrew F . Davis"
	<afd@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, "Javier Martinez
 Canillas" <javier@osg.samsung.com>
Subject: [PATCH v1 5/7] iio: adc: ina2xx: Use a monotonic clock for delay calculation
Date: Fri, 8 Dec 2017 18:41:50 +0100
In-Reply-To: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de>
References: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <7330c7df-330f-449f-8706-a2407e92ebcf@rwthex-w2-a.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

The iio timestamp clock is user selectable and may be non-monotonic. Also,
only part of the acquisition time is measured, thus the delay was longer
than intended.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---

 drivers/iio/adc/ina2xx-adc.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 2621a34ee5c6..65bd9e69faf2 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -703,10 +703,10 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 	/* data buffer needs space for channel data and timestap */
 	unsigned short data[4 + sizeof(s64)/sizeof(short)];
 	int bit, ret, i = 0;
-	s64 time_a, time_b;
+	s64 time;
 	unsigned int alert;
 
-	time_a = iio_get_time_ns(indio_dev);
+	time = iio_get_time_ns(indio_dev);
 
 	/*
 	 * Because the timer thread and the chip conversion clock
@@ -752,11 +752,9 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 		data[i++] = val;
 	}
 
-	time_b = iio_get_time_ns(indio_dev);
+	iio_push_to_buffers_with_timestamp(indio_dev, data, time);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data, time_a);
-
-	return (unsigned long)(time_b - time_a) / 1000;
+	return 0;
 };
 
 static int ina2xx_capture_thread(void *data)
@@ -764,7 +762,9 @@ static int ina2xx_capture_thread(void *data)
 	struct iio_dev *indio_dev = data;
 	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
 	int sampling_us = SAMPLING_PERIOD(chip);
-	int buffer_us, delay_us;
+	int ret;
+	struct timespec64 next, now, delta;
+	s64 delay_us;
 
 	/*
 	 * Poll a bit faster than the chip internal Fs, in case
@@ -773,15 +773,22 @@ static int ina2xx_capture_thread(void *data)
 	if (!chip->allow_async_readout)
 		sampling_us -= 200;
 
+	ktime_get_ts64(&next);
+
 	do {
-		buffer_us = ina2xx_work_buffer(indio_dev);
-		if (buffer_us < 0)
-			return buffer_us;
+		ret = ina2xx_work_buffer(indio_dev);
+		if (ret < 0)
+			return ret;
 
-		if (sampling_us > buffer_us) {
-			delay_us = sampling_us - buffer_us;
-			usleep_range(delay_us, (delay_us * 3) >> 1);
-		}
+		ktime_get_ts64(&now);
+
+		do {
+			timespec64_add_ns(&next, 1000 * sampling_us);
+			delta = timespec64_sub(next, now);
+			delay_us = timespec64_to_ns(&delta) / 1000;
+		} while (delay_us <= 0);
+
+		usleep_range(delay_us, (delay_us * 3) >> 1);
 
 	} while (!kthread_should_stop());
 
-- 
2.15.1
