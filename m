Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50311 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab3KQOOL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Nov 2013 09:14:11 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 06/11] iio: ad_sigma_delta provide macro parameters for available info masks
Date: Sun, 17 Nov 2013 15:14:57 +0000
Message-Id: <1384701302-26564-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1384701302-26564-1-git-send-email-jic23@kernel.org>
References: <1384701302-26564-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

For now all are set to 0 to allow the drivers to undergo conversion
one at a time.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/ad7791.c               | 14 +++----
 drivers/iio/adc/ad7793.c               | 69 ++++++++++++++++++++++------------
 drivers/staging/iio/adc/ad7192.c       | 16 ++++----
 drivers/staging/iio/adc/ad7780.c       |  2 +-
 include/linux/iio/adc/ad_sigma_delta.h | 47 +++++++++++++++++------
 5 files changed, 97 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index c19f8fd1b4b7..a5abc1c2453e 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -68,23 +68,23 @@
 #define DECLARE_AD7787_CHANNELS(name, bits, storagebits) \
 const struct iio_chan_spec name[] = { \
 	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
-		(bits), (storagebits), 0), \
-	AD_SD_CHANNEL(1, 1, AD7791_CH_AIN2, (bits), (storagebits), 0), \
+		(bits), (storagebits), 0, 0, 0, 0), \
+	AD_SD_CHANNEL(1, 1, AD7791_CH_AIN2, (bits), (storagebits), 0, 0, 0, 0), \
 	AD_SD_SHORTED_CHANNEL(2, 0, AD7791_CH_AIN1N_AIN1N, \
-		(bits), (storagebits), 0), \
+		(bits), (storagebits), 0, 0, 0, 0), \
 	AD_SD_SUPPLY_CHANNEL(3, 2, AD7791_CH_AVDD_MONITOR,  \
-		(bits), (storagebits), 0), \
+		(bits), (storagebits), 0, 0, 0, 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(4), \
 }
 
 #define DECLARE_AD7791_CHANNELS(name, bits, storagebits) \
 const struct iio_chan_spec name[] = { \
 	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
-		(bits), (storagebits), 0), \
+		(bits), (storagebits), 0, 0, 0, 0), \
 	AD_SD_SHORTED_CHANNEL(1, 0, AD7791_CH_AIN1N_AIN1N, \
-		(bits), (storagebits), 0), \
+		(bits), (storagebits), 0, 0, 0, 0), \
 	AD_SD_SUPPLY_CHANNEL(2, 1, AD7791_CH_AVDD_MONITOR, \
-		(bits), (storagebits), 0), \
+		(bits), (storagebits), 0, 0, 0, 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(3), \
 }
 
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 4dddeabdfbb0..0af42b693eb4 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -586,45 +586,66 @@ static const struct iio_info ad7797_info = {
 
 #define DECLARE_AD7793_CHANNELS(_name, _b, _sb, _s) \
 const struct iio_chan_spec _name##_channels[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), (_s)), \
-	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), (_s)), \
-	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), (_s)), \
-	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), (_s)), \
-	AD_SD_TEMP_CHANNEL(4, AD7793_CH_TEMP, (_b), (_sb), (_s)), \
-	AD_SD_SUPPLY_CHANNEL(5, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), (_s)), \
+	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), (_s), \
+	0, 0, 0), \
+	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), (_s), \
+	0, 0, 0), \
+	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), (_s), \
+	0, 0, 0), \
+	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), (_s), \
+	0, 0, 0), \
+	AD_SD_TEMP_CHANNEL(4, AD7793_CH_TEMP, (_b), (_sb), (_s), 0, 0, 0), \
+	AD_SD_SUPPLY_CHANNEL(5, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), (_s), \
+	0, 0, 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(6), \
 }
 
 #define DECLARE_AD7795_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(3, 3, 3, AD7795_CH_AIN4P_AIN4M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(4, 4, 4, AD7795_CH_AIN5P_AIN5M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(5, 5, 5, AD7795_CH_AIN6P_AIN6M, (_b), (_sb), 0), \
-	AD_SD_SHORTED_CHANNEL(6, 0, AD7795_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
-	AD_SD_TEMP_CHANNEL(7, AD7793_CH_TEMP, (_b), (_sb), 0), \
-	AD_SD_SUPPLY_CHANNEL(8, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
+	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0, \
+	0, 0, 0), \
+	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0, \
+	0, 0, 0), \
+	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0, \
+	0, 0, 0), \
+	AD_SD_DIFF_CHANNEL(3, 3, 3, AD7795_CH_AIN4P_AIN4M, (_b), (_sb), 0, \
+	0, 0, 0), \
+	AD_SD_DIFF_CHANNEL(4, 4, 4, AD7795_CH_AIN5P_AIN5M, (_b), (_sb), 0, \
+	0, 0, 0), \
+	AD_SD_DIFF_CHANNEL(5, 5, 5, AD7795_CH_AIN6P_AIN6M, (_b), (_sb), 0, \
+	0, 0, 0), \
+	AD_SD_SHORTED_CHANNEL(6, 0, AD7795_CH_AIN1M_AIN1M, (_b), (_sb), 0, \
+	0, 0, 0), \
+	AD_SD_TEMP_CHANNEL(7, AD7793_CH_TEMP, (_b), (_sb), 0, 0, 0, 0),	\
+	AD_SD_SUPPLY_CHANNEL(8, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0, \
+	0, 0, 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(9), \
 }
 
 #define DECLARE_AD7797_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
-	AD_SD_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
-	AD_SD_TEMP_CHANNEL(2, AD7793_CH_TEMP, (_b), (_sb), 0), \
-	AD_SD_SUPPLY_CHANNEL(3, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
+	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0, \
+	0, 0, 0), \
+	AD_SD_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0, \
+	0, 0, 0), \
+	AD_SD_TEMP_CHANNEL(2, AD7793_CH_TEMP, (_b), (_sb), 0, 0, 0, 0),	\
+	AD_SD_SUPPLY_CHANNEL(3, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0, \
+	0, 0, 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(4), \
 }
 
 #define DECLARE_AD7799_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0), \
-	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
-	AD_SD_SUPPLY_CHANNEL(4, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
+	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0, \
+	0, 0, 0), \
+	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0, \
+	0, 0, 0), \
+	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0, \
+	0, 0, 0), \
+	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0, \
+	0, 0, 0), \
+	AD_SD_SUPPLY_CHANNEL(4, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0, \
+	0, 0, 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(5), \
 }
 
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 83bb44b38152..75187fc8e4b4 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -595,14 +595,14 @@ static const struct iio_info ad7195_info = {
 };
 
 static const struct iio_chan_spec ad7192_channels[] = {
-	AD_SD_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M, 24, 32, 0),
-	AD_SD_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M, 24, 32, 0),
-	AD_SD_TEMP_CHANNEL(2, AD7192_CH_TEMP, 24, 32, 0),
-	AD_SD_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M, 24, 32, 0),
-	AD_SD_CHANNEL(4, 1, AD7192_CH_AIN1, 24, 32, 0),
-	AD_SD_CHANNEL(5, 2, AD7192_CH_AIN2, 24, 32, 0),
-	AD_SD_CHANNEL(6, 3, AD7192_CH_AIN3, 24, 32, 0),
-	AD_SD_CHANNEL(7, 4, AD7192_CH_AIN4, 24, 32, 0),
+	AD_SD_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M, 24, 32, 0, 0, 0, 0),
+	AD_SD_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M, 24, 32, 0, 0, 0, 0),
+	AD_SD_TEMP_CHANNEL(2, AD7192_CH_TEMP, 24, 32, 0, 0, 0, 0),
+	AD_SD_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M, 24, 32, 0, 0, 0, 0),
+	AD_SD_CHANNEL(4, 1, AD7192_CH_AIN1, 24, 32, 0, 0, 0, 0),
+	AD_SD_CHANNEL(5, 2, AD7192_CH_AIN2, 24, 32, 0, 0, 0, 0),
+	AD_SD_CHANNEL(6, 3, AD7192_CH_AIN3, 24, 32, 0, 0, 0, 0),
+	AD_SD_CHANNEL(7, 4, AD7192_CH_AIN4, 24, 32, 0, 0, 0, 0),
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 273add3ed63f..f4827dfaec65 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -131,7 +131,7 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
 };
 
 #define AD7780_CHANNEL(bits, wordsize) \
-	AD_SD_CHANNEL(1, 0, 0, bits, 32, wordsize - bits)
+	AD_SD_CHANNEL(1, 0, 0, bits, 32, wordsize - bits, 0, 0, 0)
 
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7170] = {
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index e7fdec4db9da..c19f4711a1e0 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -124,7 +124,9 @@ void ad_sd_cleanup_buffer_and_trigger(struct iio_dev *indio_dev);
 int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
 
 #define __AD_SD_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
-	_storagebits, _shift, _extend_name, _type) \
+	_storagebits, _shift, _extend_name, _type, \
+	_im_shared_by_all, \
+	_im_shared_all_av, _im_shared_type_av) \
 	{ \
 		.type = (_type), \
 		.differential = (_channel2 == -1 ? 0 : 1), \
@@ -136,6 +138,9 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
 			BIT(IIO_CHAN_INFO_OFFSET), \
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_all = _im_shared_by_all, \
+		.info_mask_shared_by_all_available = _im_shared_all_av, \
+		.info_mask_shared_by_type_available = _im_shared_type_av, \
 		.scan_index = (_si), \
 		.scan_type = { \
 			.sign = 'u', \
@@ -147,27 +152,47 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
 	}
 
 #define AD_SD_DIFF_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
-	_storagebits, _shift) \
+	_storagebits, _shift, \
+	_shared_by_all, \
+	_shared_by_all_available, _shared_by_type_available)	\
 	__AD_SD_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
-		_storagebits, _shift, NULL, IIO_VOLTAGE)
+		_storagebits, _shift, NULL, IIO_VOLTAGE, \
+		_shared_by_all, \
+		_shared_by_all_available, _shared_by_type_available)
 
 #define AD_SD_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
-	_storagebits, _shift) \
+	_storagebits, _shift, \
+	_shared_by_all, \
+	_shared_by_all_available, _shared_by_type_available) \
 	__AD_SD_CHANNEL(_si, _channel, _channel, _address, _bits, \
-		_storagebits, _shift, "shorted", IIO_VOLTAGE)
+		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
+		_shared_by_all, \
+		_shared_by_all_available, _shared_by_type_available)
 
 #define AD_SD_CHANNEL(_si, _channel, _address, _bits, \
-	_storagebits, _shift) \
+	_storagebits, _shift, \
+	_shared_by_all, \
+	_shared_by_all_available, _shared_by_type_available) \
 	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
-		_storagebits, _shift, NULL, IIO_VOLTAGE)
+		_storagebits, _shift, NULL, IIO_VOLTAGE, \
+		_shared_by_all, \
+		_shared_by_all_available, _shared_by_type_available)
 
-#define AD_SD_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
+#define AD_SD_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift, \
+	_shared_by_all, \
+	_shared_by_all_available, _shared_by_type_available) \
 	__AD_SD_CHANNEL(_si, 0, -1, _address, _bits, \
-		_storagebits, _shift, NULL, IIO_TEMP)
+		_storagebits, _shift, NULL, IIO_TEMP, \
+		_shared_by_all, \
+		_shared_by_all_available, _shared_by_type_available)
 
 #define AD_SD_SUPPLY_CHANNEL(_si, _channel, _address, _bits, _storagebits, \
-	_shift) \
+	_shift, \
+	_shared_by_all, \
+	_shared_by_all_available, _shared_by_type_available) \
 	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
-		_storagebits, _shift, "supply", IIO_VOLTAGE)
+		_storagebits, _shift, "supply", IIO_VOLTAGE, \
+		_shared_by_all, \
+		_shared_by_all_available, _shared_by_type_available)
 
 #endif
-- 
1.8.4.2

