Return-Path: <SRS0=6JOx=D4=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>, Maciej Purski
	<m.purski@samsung.com>, <linux-kernel@vger.kernel.org>, "Andrew F . Davis"
	<afd@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH v4 5/7] iio: adc: ina2xx: Use a monotonic clock for delay calculation
Date: Mon, 1 Jan 2018 02:24:42 +0100
In-Reply-To: <20171229174806.5a615b63@archlinux>
References: <20171229174806.5a615b63@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <3dfac802-d735-421b-9676-085e6def4cad@rwthex-w2-a.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

The iio timestamp clock is user selectable and may be non-monotonic. Also,
only part of the acquisition time is measured, thus the delay was longer
than intended.

Use a monotonic timestamp to track the time for the next poll iteration.
The timestamp is advanced by the sampling interval each iteration. In case
the conversion overrruns the register readout (i.e. fast sampling combined
with a slow bus), one or multiple samples will be dropped.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>

---

Changes in v4:
- Typo, div_s64, not s64_div

Changes in v3:
- use s64_div for 64 bit integer division to fix compiles on 32 bit archs

Changes in v2:
- add a comment mentioning skipping samples on overrun

 drivers/iio/adc/ina2xx-adc.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 2621a34ee5c6..b55b8bd1427b 100644
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
@@ -773,15 +773,28 @@ static int ina2xx_capture_thread(void *data)
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
+		/*
+		 * Advance the timestamp for the next poll by one sampling
+		 * interval, and sleep for the remainder (next - now)
+		 * In case "next" has already passed, the interval is added
+		 * multiple times, i.e. samples are dropped.
+		 */
+		do {
+			timespec64_add_ns(&next, 1000 * sampling_us);
+			delta = timespec64_sub(next, now);
+			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
+		} while (delay_us <= 0);
+
+		usleep_range(delay_us, (delay_us * 3) >> 1);
 
 	} while (!kthread_should_stop());
 
-- 
2.15.1
