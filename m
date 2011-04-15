Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO-onwards: ADC: AD7476: Fix ringbuffer registration
Date: Fri, 15 Apr 2011 11:27:56 +0200
Message-ID: <1302859676-24706-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7476_core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 5867b92..a3cd4cd 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -209,7 +209,9 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_device;
 
-	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
+	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+			(struct iio_chan_spec *) st->chip_info->channel,
+			ARRAY_SIZE(st->chip_info->channel));
 	if (ret)
 		goto error_cleanup_ring;
 	return 0;
-- 
1.6.0.2
