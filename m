Return-Path: <SRS0=dj3F=OA=gmail.com=giuliano.belinassi@kernel.org>
From: Giuliano Belinassi <giuliano.belinassi@gmail.com>
Date: Wed, 21 Nov 2018 16:04:43 -0200
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	alexandru.Ardelean@analog.com, stefan.popa@analog.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: ad7780: Add gain & filter gpio support
Message-ID: <20181121180443.tjgcpu2webrq53rh@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Previously, the AD7780 driver only supported gpio for the 'powerdown'
pin. This commit adds suppport for the 'gain' and 'filter' pin.

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
 drivers/staging/iio/adc/ad7780.c       | 61 ++++++++++++++++++++++++--
 include/linux/iio/adc/ad_sigma_delta.h |  5 +++
 2 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index c4a85789c2db..69794f06dbcd 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -39,6 +39,9 @@
 #define AD7170_PATTERN		(AD7780_PAT0 | AD7170_PAT2)
 #define AD7170_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
 
+#define AD7780_GAIN_GPIO	0
+#define AD7780_FILTER_GPIO	1
+
 struct ad7780_chip_info {
 	struct iio_chan_spec	channel;
 	unsigned int		pattern_mask;
@@ -50,6 +53,8 @@ struct ad7780_state {
 	const struct ad7780_chip_info	*chip_info;
 	struct regulator		*reg;
 	struct gpio_desc		*powerdown_gpio;
+	struct gpio_desc		*gain_gpio;
+	struct gpio_desc		*filter_gpio;
 	unsigned int	gain;
 
 	struct ad_sigma_delta sd;
@@ -115,18 +120,51 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ad7780_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long m)
+{
+	struct ad7780_state *st = iio_priv(indio_dev);
+
+	if (m != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	if (st->chip_info->is_ad778x) {
+		switch(val) {
+		case AD7780_GAIN_GPIO:
+			gpiod_set_value(st->gain_gpio, val2);
+		break;
+		case AD7780_FILTER_GPIO:
+			gpiod_set_value(st->filter_gpio, val2);
+		break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
 				     unsigned int raw_sample)
 {
 	struct ad7780_state *st = ad_sigma_delta_to_ad7780(sigma_delta);
 	const struct ad7780_chip_info *chip_info = st->chip_info;
+	int val;
 
 	if ((raw_sample & AD7780_ERR) ||
 	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
 		return -EIO;
 
 	if (chip_info->is_ad778x) {
-		if (raw_sample & AD7780_GAIN)
+		val = raw_sample & AD7780_GAIN;
+
+		if (val != gpiod_get_value(st->gain_gpio))
+			return -EIO;
+
+		if (val)
 			st->gain = 1;
 		else
 			st->gain = 128;
@@ -141,18 +179,20 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
 	.has_registers = false,
 };
 
-#define AD7780_CHANNEL(bits, wordsize) \
+#define AD7170_CHANNEL(bits, wordsize) \
 	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
+#define AD7780_CHANNEL(bits, wordsize) \
+	AD_SD_CHANNEL_GAIN_FILTER(1, 0, 0, bits, 32, wordsize - bits)
 
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7170] = {
-		.channel = AD7780_CHANNEL(12, 24),
+		.channel = AD7170_CHANNEL(12, 24),
 		.pattern = AD7170_PATTERN,
 		.pattern_mask = AD7170_PATTERN_MASK,
 		.is_ad778x = false,
 	},
 	[ID_AD7171] = {
-		.channel = AD7780_CHANNEL(16, 24),
+		.channel = AD7170_CHANNEL(16, 24),
 		.pattern = AD7170_PATTERN,
 		.pattern_mask = AD7170_PATTERN_MASK,
 		.is_ad778x = false,
@@ -173,6 +213,7 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 
 static const struct iio_info ad7780_info = {
 	.read_raw = ad7780_read_raw,
+	.write_raw = ad7780_write_raw,
 };
 
 static int ad7780_probe(struct spi_device *spi)
@@ -222,6 +263,18 @@ static int ad7780_probe(struct spi_device *spi)
 		goto error_disable_reg;
 	}
 
+	if (st->chip_info->is_ad778x) {
+		st->gain_gpio = devm_gpiod_get_optional(&spi->dev,
+							"gain",
+							GPIOD_OUT_HIGH);
+		if (IS_ERR(st->gain_gpio)) {
+			ret = PTR_ERR(st->gain_gpio);
+			dev_err(&spi->dev, "Failed to request gain GPIO: %d\n",
+				ret);
+			goto error_disable_reg;
+		}
+	}
+
 	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
 	if (ret)
 		goto error_disable_reg;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 730ead1a46df..6cadab6fd5fd 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -173,6 +173,11 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
 	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
 		_storagebits, _shift, NULL, IIO_VOLTAGE, 0)
 
+#define AD_SD_CHANNEL_GAIN_FILTER(_si, _channel, _address, _bits, \
+	_storagebits, _shift) \
+	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
+		_storagebits, _shift, NULL, IIO_VOLTAGE, BIT(IIO_CHAN_INFO_RAW))
+
 #define AD_SD_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
 	__AD_SD_CHANNEL(_si, 0, -1, _address, _bits, \
 		_storagebits, _shift, NULL, IIO_TEMP, \
-- 
2.19.1
