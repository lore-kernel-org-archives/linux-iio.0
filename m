Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50118 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbcBLSei (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 12 Feb 2016 13:34:38 -0500
From: "Andrew F. Davis" <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Marc Titinger <mtitinger@baylibre.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 2/2] iio: ina2xx: Remove trace_printk debug statments
Date: Fri, 12 Feb 2016 12:34:23 -0600
Message-ID: <1455302063-8414-2-git-send-email-afd@ti.com>
In-Reply-To: <1455302063-8414-1-git-send-email-afd@ti.com>
References: <1455302063-8414-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These are generally for devlopment use only, remove these
from performance-critical code, convert to dev_dbg elswhere.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/iio/adc/ina2xx-adc.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 61e8ae9..ba11b2e 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -440,7 +440,6 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
 	unsigned short data[8];
 	int bit, ret, i = 0;
-	unsigned long buffer_us, elapsed_us;
 	s64 time_a, time_b;
 	unsigned int alert;
 
@@ -464,8 +463,6 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 				return ret;
 
 			alert &= INA266_CVRF;
-			trace_printk("Conversion ready: %d\n", !!alert);
-
 		} while (!alert);
 
 	/*
@@ -490,14 +487,9 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 	iio_push_to_buffers_with_timestamp(indio_dev,
 					   (unsigned int *)data, time_a);
 
-	buffer_us = (unsigned long)(time_b - time_a) / 1000;
-	elapsed_us = (unsigned long)(time_a - chip->prev_ns) / 1000;
-
-	trace_printk("uS: elapsed: %lu, buf: %lu\n", elapsed_us, buffer_us);
-
 	chip->prev_ns = time_a;
 
-	return buffer_us;
+	return (unsigned long)(time_b - time_a) / 1000;
 };
 
 static int ina2xx_capture_thread(void *data)
@@ -532,12 +524,13 @@ static int ina2xx_buffer_enable(struct iio_dev *indio_dev)
 	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
 	unsigned int sampling_us = SAMPLING_PERIOD(chip);
 
-	trace_printk("Enabling buffer w/ scan_mask %02x, freq = %d, avg =%u\n",
-		     (unsigned int)(*indio_dev->active_scan_mask),
-		     1000000/sampling_us, chip->avg);
+	dev_dbg(&indio_dev->dev, "Enabling buffer w/ scan_mask %02x, freq = %d, avg =%u\n",
+		(unsigned int)(*indio_dev->active_scan_mask),
+		1000000 / sampling_us, chip->avg);
 
-	trace_printk("Expected work period: %u us\n", sampling_us);
-	trace_printk("Async readout mode: %d\n", chip->allow_async_readout);
+	dev_dbg(&indio_dev->dev, "Expected work period: %u us\n", sampling_us);
+	dev_dbg(&indio_dev->dev, "Async readout mode: %d\n",
+		chip->allow_async_readout);
 
 	chip->prev_ns = iio_get_time_ns();
 
-- 
2.7.1

