Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-cys01nam02on0083.outbound.protection.outlook.com ([104.47.37.83]:49046
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388593AbeHGRJf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 Aug 2018 13:09:35 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <broonie@kernel.org>
CC: Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/6] iio:adxl372: Add sampling frequency support
Date: Tue, 7 Aug 2018 17:52:19 +0300
Message-ID: <1533653540-24796-6-git-send-email-stefan.popa@analog.com>
In-Reply-To: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
References: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the option for the user to select the sampling frequency.
Also, the user can read the available frequencies and read the currently
set frequency via the read_raw function. The frequency can be set via the
write_raw function.

When the frequency is set, the bandwidth is also checked and ensured
that it is constrained to at most half of the sampling frequency. Also, the
activity and inactivity timers have to be updated because they depend on
the selected ODR.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 74 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index dfdceeb..76c4a1d 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -223,7 +223,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -311,6 +312,19 @@ static int adxl372_set_odr(struct adxl372_state *st,
 	return ret;
 }
 
+static int adxl372_find_closest_match(const int *array,
+				      unsigned int size, int val)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (val <= array[i])
+			return i;
+	}
+
+	return size - 1;
+}
+
 static int adxl372_set_bandwidth(struct adxl372_state *st,
 				 enum adxl372_bandwidth bw)
 {
@@ -631,6 +645,51 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		*val2 = ADXL372_USCALE;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = adxl372_samp_freq_tbl[st->odr];
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int adxl372_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long info)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int odr_index, ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		odr_index = adxl372_find_closest_match(adxl372_samp_freq_tbl,
+					ARRAY_SIZE(adxl372_samp_freq_tbl),
+					val);
+		ret = adxl372_set_odr(st, odr_index);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The timer period depends on the ODR selected.
+		 * At 3200 Hz and below, it is 6.6 ms; at 6400 Hz, it is 3.3 ms
+		 */
+		ret = adxl372_set_activity_time_ms(st, st->act_time_ms);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The timer period depends on the ODR selected.
+		 * At 3200 Hz and below, it is 26 ms; at 6400 Hz, it is 13 ms
+		 */
+		ret = adxl372_set_inactivity_time_ms(st, st->inact_time_ms);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The maximum bandwidth is constrained to at most half of
+		 * the ODR to ensure that the Nyquist criteria is not violated
+		 */
+		if (st->bw > odr_index)
+			ret = adxl372_set_bandwidth(st, odr_index);
+
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -763,8 +822,21 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
 	.set_trigger_state = adxl372_dready_trig_set_state,
 };
 
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
+
+static struct attribute *adxl372_attributes[] = {
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group adxl372_attrs_group = {
+	.attrs = adxl372_attributes,
+};
+
 static const struct iio_info adxl372_info = {
+	.attrs = &adxl372_attrs_group,
 	.read_raw = adxl372_read_raw,
+	.write_raw = adxl372_write_raw,
 	.debugfs_reg_access = &adxl372_reg_access,
 	.hwfifo_set_watermark = adxl372_set_watermark,
 };
-- 
2.7.4

