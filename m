Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58388 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbcJCT1N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2016 15:27:13 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 10/18] staging:iio:accel:sca3000 add readback of the 3db low pass filter frequency
Date: Mon,  3 Oct 2016 20:26:54 +0100
Message-Id: <20161003192702.24361-11-jic23@kernel.org>
In-Reply-To: <20161003192702.24361-1-jic23@kernel.org>
References: <20161003192702.24361-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driving towards getting rid of the non standard mode control interface.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000.c | 48 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
index cd08330e79b8..24685a2f224e 100644
--- a/drivers/staging/iio/accel/sca3000.c
+++ b/drivers/staging/iio/accel/sca3000.c
@@ -190,10 +190,13 @@ struct sca3000_chip_info {
 	unsigned int		scale;
 	bool			temp_output;
 	int			measurement_mode_freq;
+	int			measurement_mode_3db_freq;
 	int			option_mode_1;
 	int			option_mode_1_freq;
+	int			option_mode_1_3db_freq;
 	int			option_mode_2;
 	int			option_mode_2_freq;
+	int			option_mode_2_3db_freq;
 	int			mot_det_mult_xz[6];
 	int			mot_det_mult_y[7];
 };
@@ -218,36 +221,46 @@ static const struct sca3000_chip_info sca3000_spi_chip_info_tbl[] = {
 		.scale = 7357,
 		.temp_output = true,
 		.measurement_mode_freq = 250,
+		.measurement_mode_3db_freq = 45,
 		.option_mode_1 = SCA3000_OP_MODE_BYPASS,
 		.option_mode_1_freq = 250,
+		.option_mode_1_3db_freq = 70,
 		.mot_det_mult_xz = {50, 100, 200, 350, 650, 1300},
 		.mot_det_mult_y = {50, 100, 150, 250, 450, 850, 1750},
 	},
 	[e02] = {
 		.scale = 9810,
 		.measurement_mode_freq = 125,
+		.measurement_mode_3db_freq = 40,
 		.option_mode_1 = SCA3000_OP_MODE_NARROW,
 		.option_mode_1_freq = 63,
+		.option_mode_1_3db_freq = 11,
 		.mot_det_mult_xz = {100, 150, 300, 550, 1050, 2050},
 		.mot_det_mult_y = {50, 100, 200, 350, 700, 1350, 2700},
 	},
 	[e04] = {
 		.scale = 19620,
 		.measurement_mode_freq = 100,
+		.measurement_mode_3db_freq = 38,
 		.option_mode_1 = SCA3000_OP_MODE_NARROW,
 		.option_mode_1_freq = 50,
+		.option_mode_1_3db_freq = 9,
 		.option_mode_2 = SCA3000_OP_MODE_WIDE,
 		.option_mode_2_freq = 400,
+		.option_mode_2_3db_freq = 70,
 		.mot_det_mult_xz = {200, 300, 600, 1100, 2100, 4100},
 		.mot_det_mult_y = {100, 200, 400, 7000, 1400, 2700, 54000},
 	},
 	[e05] = {
 		.scale = 61313,
 		.measurement_mode_freq = 200,
+		.measurement_mode_3db_freq = 60,
 		.option_mode_1 = SCA3000_OP_MODE_NARROW,
 		.option_mode_1_freq = 50,
+		.option_mode_1_3db_freq = 9,
 		.option_mode_2 = SCA3000_OP_MODE_WIDE,
 		.option_mode_2_freq = 400,
+		.option_mode_2_3db_freq = 75,
 		.mot_det_mult_xz = {600, 900, 1700, 3200, 6100, 11900},
 		.mot_det_mult_y = {300, 600, 1200, 2000, 4100, 7800, 15600},
 	},
@@ -577,7 +590,8 @@ static const struct iio_event_spec sca3000_event = {
 		.modified = 1,					\
 		.channel2 = mod,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |\
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),\
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
 		.address = index,				\
 		.scan_index = index,				\
@@ -737,6 +751,33 @@ static int write_raw_samp_freq(struct sca3000_state *st, int val)
 				     ctrlval);
 }
 
+static int sca3000_read_3db_freq(struct sca3000_state *st, int *val)
+{
+	int ret;
+
+	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	if (ret)
+		return ret;
+
+	/* mask bottom 2 bits - only ones that are relevant */
+	st->rx[0] &= SCA3000_REG_MODE_MODE_MASK;
+	switch (st->rx[0]) {
+	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
+		*val = st->info->measurement_mode_3db_freq;
+		return IIO_VAL_INT;
+	case SCA3000_REG_MODE_MEAS_MODE_MOT_DET:
+		return -EBUSY;
+	case SCA3000_REG_MODE_MEAS_MODE_OP_1:
+		*val = st->info->option_mode_1_3db_freq;
+		return IIO_VAL_INT;
+	case SCA3000_REG_MODE_MEAS_MODE_OP_2:
+		*val = st->info->option_mode_2_3db_freq;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int sca3000_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val,
@@ -794,6 +835,11 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 		ret = read_raw_samp_freq(st, val);
 		mutex_unlock(&st->lock);
 		return ret ? ret : IIO_VAL_INT;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		mutex_lock(&st->lock);
+		ret = sca3000_read_3db_freq(st, val);
+		mutex_unlock(&st->lock);
+		return ret;
 	default:
 		return -EINVAL;
 	}
-- 
2.10.0

