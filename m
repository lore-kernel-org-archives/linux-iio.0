Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:32837 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbcICCyY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2016 22:54:24 -0400
Date: Fri, 2 Sep 2016 19:54:21 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: afd@ti.com, mtitinger@baylibre.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ina2xx: remove unused debug field from chip global
 data
Message-ID: <20160903025410.GA19426@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

commit 1961bce76452 "iio: ina2xx: Remove trace_printk debug
statements" removed the code that used the chip->prev_ns field.
This patch cleans it up further by removing the unused field
and assignments.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/adc/ina2xx-adc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 955f3fd..59b7d76 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -114,7 +114,6 @@ struct ina2xx_chip_info {
 	struct mutex state_lock;
 	unsigned int shunt_resistor;
 	int avg;
-	s64 prev_ns; /* track buffer capture time, check for underruns */
 	int int_time_vbus; /* Bus voltage integration time uS */
 	int int_time_vshunt; /* Shunt voltage integration time uS */
 	bool allow_async_readout;
@@ -509,8 +508,6 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 	iio_push_to_buffers_with_timestamp(indio_dev,
 					   (unsigned int *)data, time_a);
 
-	chip->prev_ns = time_a;
-
 	return (unsigned long)(time_b - time_a) / 1000;
 };
 
@@ -554,8 +551,6 @@ static int ina2xx_buffer_enable(struct iio_dev *indio_dev)
 	dev_dbg(&indio_dev->dev, "Async readout mode: %d\n",
 		chip->allow_async_readout);
 
-	chip->prev_ns = iio_get_time_ns(indio_dev);
-
 	chip->task = kthread_run(ina2xx_capture_thread, (void *)indio_dev,
 				 "%s:%d-%uus", indio_dev->name, indio_dev->id,
 				 sampling_us);
-- 
2.1.4

