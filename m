Return-Path: <SRS0=HiVk=MG=googlemail.com=martin.blumenstingl@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] iio: adc: meson-saradc: use the address attribute from iio_chan_spec
Date: Tue, 25 Sep 2018 00:13:26 +0200
Message-Id: <20180924221326.2871-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20180924221326.2871-1-martin.blumenstingl@googlemail.com>
References: <20180924221326.2871-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Until now the "channel" number is identical to how the channel is
identified inside the (FIFO) registers. In our case we have eight
channels and the hardware also has eight inputs.

However, there are two special inputs:
- channel 6 can select between the SAR_ADC_CH6 pad and the chip's
  internal temperature sensor
- channel 7 can select between SAR_ADC_CH7 and VSS, VDD / 4, VDD / 2,
  VDD * 3 / 4 and VDD.

When programming the registers to read for example the temperature
sensor we have to select FIFO channel 6, set the correct bit which muxes
channel 6 to the temperature sensor and then start the ADC measurement
for channel 6 as usual.

When we add support for the temperature sensor the driver has to know
about that it has to use FIFO channel 6 to measure using the chip's
internal temperature sensor. However, in that case the iio_chan_spec
channel will not be 6 because this is already used for the SAR_ADC_CH6
pad input. Thus we use iio_chan_spec's address field to store the FIFO
channel number for each channel.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 809d1230be34..028ccd218f82 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -172,6 +172,7 @@
 	.type = IIO_VOLTAGE,						\
 	.indexed = 1,							\
 	.channel = _chan,						\
+	.address = _chan,						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 				BIT(IIO_CHAN_INFO_AVERAGE_RAW),		\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
@@ -323,10 +324,10 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 
 	regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
 	fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK, regval);
-	if (fifo_chan != chan->channel) {
+	if (fifo_chan != chan->address) {
 		dev_err(&indio_dev->dev,
-			"ADC FIFO entry belongs to channel %d instead of %d\n",
-			fifo_chan, chan->channel);
+			"ADC FIFO entry belongs to channel %d instead of %lu\n",
+			fifo_chan, chan->address);
 		return -EINVAL;
 	}
 
@@ -343,16 +344,16 @@ static void meson_sar_adc_set_averaging(struct iio_dev *indio_dev,
 					enum meson_sar_adc_num_samples samples)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
-	int val, channel = chan->channel;
+	int val, address = chan->address;
 
-	val = samples << MESON_SAR_ADC_AVG_CNTL_NUM_SAMPLES_SHIFT(channel);
+	val = samples << MESON_SAR_ADC_AVG_CNTL_NUM_SAMPLES_SHIFT(address);
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_AVG_CNTL,
-			   MESON_SAR_ADC_AVG_CNTL_NUM_SAMPLES_MASK(channel),
+			   MESON_SAR_ADC_AVG_CNTL_NUM_SAMPLES_MASK(address),
 			   val);
 
-	val = mode << MESON_SAR_ADC_AVG_CNTL_AVG_MODE_SHIFT(channel);
+	val = mode << MESON_SAR_ADC_AVG_CNTL_AVG_MODE_SHIFT(address);
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_AVG_CNTL,
-			   MESON_SAR_ADC_AVG_CNTL_AVG_MODE_MASK(channel), val);
+			   MESON_SAR_ADC_AVG_CNTL_AVG_MODE_MASK(address), val);
 }
 
 static void meson_sar_adc_enable_channel(struct iio_dev *indio_dev,
@@ -372,23 +373,23 @@ static void meson_sar_adc_enable_channel(struct iio_dev *indio_dev,
 
 	/* map channel index 0 to the channel which we want to read */
 	regval = FIELD_PREP(MESON_SAR_ADC_CHAN_LIST_ENTRY_MASK(0),
-			    chan->channel);
+			    chan->address);
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_CHAN_LIST,
 			   MESON_SAR_ADC_CHAN_LIST_ENTRY_MASK(0), regval);
 
 	regval = FIELD_PREP(MESON_SAR_ADC_DETECT_IDLE_SW_DETECT_MUX_MASK,
-			    chan->channel);
+			    chan->address);
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_DETECT_IDLE_SW,
 			   MESON_SAR_ADC_DETECT_IDLE_SW_DETECT_MUX_MASK,
 			   regval);
 
 	regval = FIELD_PREP(MESON_SAR_ADC_DETECT_IDLE_SW_IDLE_MUX_SEL_MASK,
-			    chan->channel);
+			    chan->address);
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_DETECT_IDLE_SW,
 			   MESON_SAR_ADC_DETECT_IDLE_SW_IDLE_MUX_SEL_MASK,
 			   regval);
 
-	if (chan->channel == 6)
+	if (chan->address == 6)
 		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
 				   MESON_SAR_ADC_DELTA_10_TEMP_SEL, 0);
 }
@@ -526,8 +527,8 @@ static int meson_sar_adc_get_sample(struct iio_dev *indio_dev,
 
 	if (ret) {
 		dev_warn(indio_dev->dev.parent,
-			 "failed to read sample for channel %d: %d\n",
-			 chan->channel, ret);
+			 "failed to read sample for channel %lu: %d\n",
+			 chan->address, ret);
 		return ret;
 	}
 
-- 
2.19.0
