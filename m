Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/22] staging:iio:ad7192: Mark channels as unsigned
Date: Fri, 10 Aug 2012 18:36:24 +0200
Message-Id: <1344616596-8026-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1344616596-8026-1-git-send-email-lars@metafoo.de>
References: <1344616596-8026-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The values reported by the AD7793 are unsigned.
	In uniploar mode:
			0x000000 is zeroscale
			0xffffff is fullscale
	In bipolar mode:
			0x000000 is negative fullscale
			0x800000 is zeroscale
			0xffffff is positive fullscale

In bipolar mode there is a binary offset, but the values are still unsigned.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7192.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 5565268..b103f58 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -945,7 +945,7 @@ static const struct iio_info ad7195_info = {
 	  IIO_CHAN_INFO_SCALE_SHARED_BIT,				\
 	  .address = _address,						\
 	  .scan_index = _si,						\
-	  .scan_type =  IIO_ST('s', 24, 32, 0)}
+	  .scan_type =  IIO_ST('u', 24, 32, 0)}
 
 #define AD7192_CHAN(_chan, _address, _si)				\
 	{ .type = IIO_VOLTAGE,						\
@@ -955,7 +955,7 @@ static const struct iio_info ad7195_info = {
 	  IIO_CHAN_INFO_SCALE_SHARED_BIT,				\
 	  .address = _address,						\
 	  .scan_index = _si,						\
-	  .scan_type =  IIO_ST('s', 24, 32, 0)}
+	  .scan_type =  IIO_ST('u', 24, 32, 0)}
 
 #define AD7192_CHAN_TEMP(_chan, _address, _si)				\
 	{ .type = IIO_TEMP,						\
@@ -965,7 +965,7 @@ static const struct iio_info ad7195_info = {
 	  IIO_CHAN_INFO_SCALE_SEPARATE_BIT,				\
 	  .address = _address,						\
 	  .scan_index = _si,						\
-	  .scan_type =  IIO_ST('s', 24, 32, 0)}
+	  .scan_type =  IIO_ST('u', 24, 32, 0)}
 
 static const struct iio_chan_spec ad7192_channels[] = {
 	AD7192_CHAN_DIFF(1, 2, NULL, AD7192_CH_AIN1P_AIN2M, 0),
-- 
1.7.10.4
