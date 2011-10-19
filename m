Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:55477
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751544Ab1JSPsM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2011 11:48:12 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	Michael Hennerich <michael.hennerich@analog.com>,
	<devel@driverdev.osuosl.org>, <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] staging:iio:dac:ad5791: Allow asymmetrical reference voltages
Date: Wed, 19 Oct 2011 17:47:50 +0200
Message-ID: <1319039272-19496-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1319039272-19496-1-git-send-email-lars@metafoo.de>
References: <1319039272-19496-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ad5791 currently assumes that the negative and positive supply have the
same absolute value, which is not necessarily true. This patch introduces a
offset attribute which will contain the negative supply voltage scaled
according to the iio spec. The raw attribute now accepts values in the range
of 0 to max instead of -max/2 to max/2.

While we are at it also fix the vref span calculation. Since both positive and
negative reference voltages are specificed as absolute values we need to add
them and not subtract them to get the reference voltage span.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/ad5791.c |   24 ++++++++++++++++--------
 drivers/staging/iio/dac/ad5791.h |    2 ++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index 9a76c43..c465fcf 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -77,7 +77,8 @@ static int ad5791_spi_read(struct spi_device *spi, u8 addr, u32 *val)
 	.indexed = 1,					\
 	.address = AD5791_ADDR_DAC0,			\
 	.channel = 0,					\
-	.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),	\
+	.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED) | \
+		(1 << IIO_CHAN_INFO_OFFSET_SHARED),	\
 	.scan_type = IIO_ST('u', bits, 24, shift)	\
 }
 
@@ -225,6 +226,7 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad5791_state *st = iio_priv(indio_dev);
+	u64 val64;
 	int ret;
 
 	switch (m) {
@@ -234,12 +236,16 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		*val &= AD5791_DAC_MASK;
 		*val >>= chan->scan_type.shift;
-		*val -= (1 << (chan->scan_type.realbits - 1));
 		return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
 		*val = 0;
 		*val2 = (st->vref_mv * 1000) >> chan->scan_type.realbits;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case (1 << IIO_CHAN_INFO_OFFSET_SHARED):
+		val64 = (((u64)st->vref_neg_mv) << chan->scan_type.realbits);
+		do_div(val64, st->vref_mv);
+		*val = -val64;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -257,7 +263,6 @@ static int ad5791_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case 0:
-		val += (1 << (chan->scan_type.realbits - 1));
 		val &= AD5791_RES_MASK(chan->scan_type.realbits);
 		val <<= chan->scan_type.shift;
 
@@ -309,12 +314,15 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 	st->pwr_down = true;
 	st->spi = spi;
 
-	if (!IS_ERR(st->reg_vss) && !IS_ERR(st->reg_vdd))
-		st->vref_mv = (pos_voltage_uv - neg_voltage_uv) / 1000;
-	else if (pdata)
-		st->vref_mv = pdata->vref_pos_mv - pdata->vref_neg_mv;
-	else
+	if (!IS_ERR(st->reg_vss) && !IS_ERR(st->reg_vdd)) {
+		st->vref_mv = (pos_voltage_uv + neg_voltage_uv) / 1000;
+		st->vref_neg_mv = neg_voltage_uv / 1000;
+	} else if (pdata) {
+		st->vref_mv = pdata->vref_pos_mv + pdata->vref_neg_mv;
+		st->vref_neg_mv = pdata->vref_neg_mv;
+	} else {
 		dev_warn(&spi->dev, "reference voltage unspecified\n");
+	}
 
 	ret = ad5791_spi_write(spi, AD5791_ADDR_SW_CTRL, AD5791_SWCTRL_RESET);
 	if (ret)
diff --git a/drivers/staging/iio/dac/ad5791.h b/drivers/staging/iio/dac/ad5791.h
index 2a50a11..fd7edbd 100644
--- a/drivers/staging/iio/dac/ad5791.h
+++ b/drivers/staging/iio/dac/ad5791.h
@@ -82,6 +82,7 @@ struct ad5791_chip_info {
  * @reg_vss:		negative supply regulator
  * @chip_info:		chip model specific constants
  * @vref_mv:		actual reference voltage used
+ * @vref_neg_mv:	voltage of the negative supply
  * @pwr_down_mode	current power down mode
  */
 
@@ -91,6 +92,7 @@ struct ad5791_state {
 	struct regulator		*reg_vss;
 	const struct ad5791_chip_info	*chip_info;
 	unsigned short			vref_mv;
+	unsigned int			vref_neg_mv;
 	unsigned			ctrl;
 	unsigned			pwr_down_mode;
 	bool				pwr_down;
-- 
1.7.6.3


