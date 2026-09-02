Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31F04AC150;
	Wed,  2 Sep 2026 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369955; cv=none; b=i9v4HsI6d3SYTk8uNle+rMvQ+WIh3GgMGasa0B2GjixehqcPmdK8ZWgs/qLSwBlepLK24XHlxOHsYN0GsFevVvskrh9R3/TCFaGrh7jWBxUtr6cryC4kMzXvQgaZfmfl3mN97zrGmVVIer++XDotAehTp70/QWSKr5Vo+41jZyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369955; c=relaxed/simple;
	bh=jozzNF03B+JZua/IqhLK6XIZ7F0ggpW6bwBtahFecx8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqMKjqBUMFTjqpbvUIDYliyjPTVpOeb/UOm0F38ANJvK7DYnLmReTTY9YnUB8tVaNRD2Ckdt/Z4i1FXIYxZzfe4iu7pcwfdfyKR6hm8TBh6w+5b2ZcjEyHK74faU/4YGnTaEztr9vXgR33TDtnjr1UTccFFKnOx9nP/VGcm1rh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=neWPGPDK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="neWPGPDK"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HPkTp2593420;
	Wed, 2 Sep 2026 13:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NUywo
	3VwaKGDsXplOFf7MA9G6NGe6+Xkh7PHcszOqlc=; b=neWPGPDKyQAdmonrKHqTl
	TRRPaWd4uuh23NEjhw8vplDVuzN0E2xUtV9EtZIgKXlitc4mPQgMbcZcQAXZFjcV
	GUXwXWM5AW0D0ELFtQDV/AsacmXFinhwumX6lG+mQktoqK5sF2iSNH5akFWfTZTe
	2eW6vuU5NlDOiKzCs2jQ8SD1q0Tq6C7ecshdQMWSuPwZc8IGT1h69KS06LupKxq4
	WQVK1gczApZSNrF5pYalV5MS/Sx1JikV9UvG4zyyoHy4PXFImHmEKxumo6KeYADV
	5Si1sgf6v7R1Nu3Gcp52k7p7+usghNLpFefbh0rXNWozJE2ke+HzQRgobapV3ZR5
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ge3v1n85n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 13:25:47 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 682HPk7w041562
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 13:25:46 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 2 Sep
 2026 13:25:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 13:25:46 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 682HPWvU004311;
	Wed, 2 Sep 2026 13:25:34 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 12/13] iio: adc: ad4134: Support high-speed data capture
Date: Wed, 2 Sep 2026 14:25:26 -0300
Message-ID: <53d79eed25795db5076d7c591f6dd8cf4feedfec.1788368334.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1788368334.git.marcelo.schmitt@analog.com>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bql8wkai c=1 sm=1 tr=0 ts=6a985c1b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=bjICBdQAHhZL0iPSZZAA:9
X-Proofpoint-GUID: 1Wuv6UpzqKtrQm4OWzWH2E83B-AWrS-i
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX2eO2VAhqRe21
 4K6bd1CJyUwdWDuqC2D55uO+OCUlXEGwnuQ9b1ruWLmnpR6gRGxdGU/h2phwi6zgXra6j4SF0dP
 lT+CNYEnH65Wtwz5Uj56uGWAdhqlK+sh+rwc+58SPpPKtV57lWvh
X-Proofpoint-ORIG-GUID: 1Wuv6UpzqKtrQm4OWzWH2E83B-AWrS-i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX5xvqwIlrAph8
 LLyzzrezKyM79DD1tabWW1q24L6AKDoRAfgoWjboGX02jt3yzaMAW7sBlQHi/rsTB5AsBXqOMP0
 0twEoLWm5BWQQTmwIjetCyZZik7plsB3FNJgo/iQI3GpYMcYzmHYdkvFRXtj4trux9vxHIpG9yR
 gw/u5b6P8aKnHrfxk/jxvaGYetv0w/bAa3z21b7GFUVBgQwiWTYmXPesWCRCRN54PF7ihrtZF/2
 673BcKYjzi9CQ6jzEEmT6POlp1RXyUWxlKiDj+SVhB7yfNpneymi77Kj7ZG4uuDHTi9XPLi8NgY
 Ei0C3UorWW6Aup1MESKOYg3V9GCP+diYte3p3Kjcmp5BxsLrFI8z9krPGb5ukHTNRZg1VjMbKEO
 Q2NtDmVT49x/cUo0D1IRtbvjv2fq6qn96Cj5scxFTru9jSbe4JlNwgwiejc31dbEMdg/tuVkhIv
 23n4k28xythOCyBrXUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020153

Make use of SPI transfer offloading to speed up data capture, enabling data
acquisition at faster sample rates (up to 1.496 MSPS).

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/Kconfig  |   5 +
 drivers/iio/adc/ad4134.c | 379 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 375 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ef77ee60df4e..369cc0659073 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -123,9 +123,14 @@ config AD4130
 config AD4134
 	tristate "Analog Devices AD4134 ADC Driver"
 	depends on SPI
+	depends on PWM
 	select REGMAP_SPI
+	select SPI_OFFLOAD
+	select SPI_OFFLOAD_TRIGGER_PWM
 	select CRC8
 	select IIO_BUFFER
+	select IIO_BUFFER_DMA
+	select IIO_BUFFER_DMAENGINE
 	select IIO_TRIGGERED_BUFFER
 	select MULTIPLEXER
 	help
diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 8453b44ef368..cf84d2b24417 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -13,6 +13,7 @@
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/gpio/consumer.h>
@@ -20,9 +21,12 @@
 #include <linux/mutex.h>
 #include <linux/mux/consumer.h>
 #include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/types.h>
 #include <linux/spi/spi.h>
 #include <linux/time64.h>
 #include <linux/types.h>
@@ -30,11 +34,16 @@
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dma.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
 #define AD4134_RESET_TIME_US			(10 * USEC_PER_SEC)
+#define AD4134_DCLK_RISING_OFFSET_NS		8
+#define AD4134_MIN_ODR_FREQ_HZ			10
+#define AD4134_MAX_ODR_FREQ_HZ			(1496 * HZ_PER_KHZ)
 
 #define AD4134_REG_READ_MASK			BIT(7)
 #define AD4134_SPI_MAX_XFER_LEN			3
@@ -65,6 +74,7 @@
 #define AD4134_DIG_IF_CFG_REG			0x12
 #define AD4134_DIF_IF_CFG_FORMAT_MASK		GENMASK(1, 0)
 #define AD4134_DATA_FORMAT_SINGLE_CH_MODE	0x0
+#define AD4134_DATA_FORMAT_QUAD_CH_PARALLEL	0x2
 
 #define AD4134_PW_DOWN_CTRL_REG			0x13
 #define AD4134_DEVICE_STATUS_REG		0x15
@@ -117,6 +127,10 @@ static const char * const ad4134_filt_names[] = {
 	[AD4134_SINC3_REJ60] = "sinc3+rej60",
 };
 
+static const int ad4134_max_samp_freq_range_Hz[3] = {
+	AD4134_MIN_ODR_FREQ_HZ, 1, AD4134_MAX_ODR_FREQ_HZ,
+};
+
 static int ad4134_get_filter_type(struct iio_dev *indio_dev,
 				  struct iio_chan_spec const *chan);
 
@@ -163,6 +177,39 @@ static const struct iio_chan_spec ad4134_chan_set[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
+/*
+ * Hardcoded 32-bit storagebits and CPU endianness because the currently
+ * available HDL only supports that configuration.
+ */
+#define AD4134_OFFLOAD_CHANNEL(_index) {					\
+	.type = IIO_VOLTAGE,							\
+	.indexed = 1,								\
+	.channel = (_index),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |			\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.ext_info = ad4134_filter_type_ext_info,				\
+	.scan_index = (_index),							\
+	.scan_type = {								\
+		.format = IIO_SCAN_FORMAT_SIGNED_INT,				\
+		.realbits = AD4134_CHAN_PRECISION_BITS,				\
+		.storagebits = 32,						\
+		.endianness = IIO_CPU,						\
+	},									\
+}
+
+/*
+ * It's not possible for software to record when offloaded SPI transfers run so
+ * no additional timestamp channel is added.
+ */
+static const struct iio_chan_spec ad4134_offload_chan_set[] = {
+	AD4134_OFFLOAD_CHANNEL(0),
+	AD4134_OFFLOAD_CHANNEL(1),
+	AD4134_OFFLOAD_CHANNEL(2),
+	AD4134_OFFLOAD_CHANNEL(3),
+};
+
 struct ad4134_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
@@ -172,6 +219,14 @@ struct ad4134_state {
 	bool crc_en;
 	enum ad4134_spi_mode spi_mode;
 	struct mux_state *mux_st[2];
+	struct spi_transfer xfers;
+	struct spi_message msg;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	struct spi_offload_trigger_config offload_trigger_config;
+	struct pwm_device *odr_pwm;
+	struct pwm_waveform odr_wf;
+	unsigned int odr_hz;
 	/*
 	 * Synchronize access to members the of driver state, and ensure
 	 * atomicity of consecutive register access operations.
@@ -454,6 +509,90 @@ static const struct regmap_config ad4134_regmap_config = {
 	.max_register = AD4134_CH_VREG(ARRAY_SIZE(ad4134_chan_set)),
 };
 
+static int ad4134_update_conversion_rate(struct ad4134_state *st,
+					 unsigned int freq_Hz)
+{
+	struct spi_offload_trigger_config config = st->offload_trigger_config;
+	struct pwm_waveform odr_wf = { };
+	u64 offload_period_ns;
+	u64 offload_offset_ns;
+	u64 odr_high_time_ns;
+	unsigned int count;
+	u64 target = 10;
+	int ret;
+
+	if (!in_range(freq_Hz, AD4134_MIN_ODR_FREQ_HZ, AD4134_MAX_ODR_FREQ_HZ))
+		return -ERANGE;
+
+	odr_wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq_Hz);
+	/*
+	 * Set the PWM duty cycle to keep ODR high for at least minimum required
+	 * time. If the rounded PWM's value is less than the minimum required,
+	 * increase the target value by 10 and attempt to round the waveform
+	 * again, until the minimum (or try count limit) is reached.
+	 */
+	odr_high_time_ns = div64_ul(6ULL * NSEC_PER_SEC, st->sys_clk_hz);
+	count = 100;
+	do {
+		odr_wf.duty_length_ns = target;
+		ret = pwm_round_waveform_might_sleep(st->odr_pwm, &odr_wf);
+		if (ret)
+			return ret;
+		target += 10; /* Increment by PWM duty cycle period */
+	} while (count-- && odr_wf.duty_length_ns < odr_high_time_ns);
+
+	/* Check the minimum ODR high time is met */
+	if (odr_wf.duty_length_ns < odr_high_time_ns)
+		return -EDOM;
+
+	if (odr_wf.period_length_ns < 2 * odr_high_time_ns)
+		return -EDOM;
+
+	/*
+	 * Configure SPI offload PWM trigger.
+	 * For gated DCLK, the minimum required time between ODR rising edge
+	 * and DCLK rising edge is the sum of ODR high time and ODR falling
+	 * edge to DCLK rising edge time. Delay the offload trigger for at least
+	 * that amount of time so the ADC sample data will be available when the
+	 * SPI transfer begin.
+	 *
+	 * Use the same period as ODR PWM to avoid timing issues.
+	 * Convert back from period to frequency for the SPI offload API.
+	 */
+	offload_period_ns = odr_wf.period_length_ns;
+	config.periodic.frequency_hz = DIV_ROUND_UP_ULL(HZ_PER_GHZ, offload_period_ns);
+	offload_offset_ns = odr_high_time_ns + AD4134_DCLK_RISING_OFFSET_NS;
+	count = 100;
+	do {
+		config.periodic.offset_ns = offload_offset_ns;
+		ret = spi_offload_trigger_validate(st->offload_trigger, &config);
+		if (ret)
+			return ret;
+
+		offload_offset_ns += 10;
+	} while (count-- && config.periodic.offset_ns < odr_high_time_ns +
+							AD4134_DCLK_RISING_OFFSET_NS);
+
+	/* Check the minimum ODR to DCLK delay is met */
+	if (config.periodic.offset_ns < odr_high_time_ns + AD4134_DCLK_RISING_OFFSET_NS)
+		return -EDOM;
+
+	/* Check the PWM periods remain the same */
+	offload_period_ns = DIV_ROUND_UP_ULL(HZ_PER_GHZ, config.periodic.frequency_hz);
+	if (odr_wf.period_length_ns != offload_period_ns)
+		return -EDOM;
+
+	ret = pwm_set_waveform_might_sleep(st->odr_pwm, &odr_wf, false);
+	if (ret)
+		return ret;
+
+	st->offload_trigger_config = config;
+	st->odr_wf = odr_wf;
+	st->odr_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC, odr_wf.period_length_ns);
+
+	return 0;
+}
+
 static irqreturn_t ad4134_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -537,6 +676,42 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 		*val2 = AD4134_CHAN_PRECISION_BITS - 1;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->odr_hz;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+static int ad4134_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (int *)ad4134_max_samp_freq_range_Hz;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4134_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct ad4134_state *st = iio_priv(indio_dev);
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	guard(mutex)(&st->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4134_update_conversion_rate(st, val);
 	default:
 		return -EINVAL;
 	}
@@ -588,6 +763,176 @@ static const struct iio_info ad4134_info = {
 	.debugfs_reg_access = ad4134_debugfs_reg_access,
 };
 
+static const struct iio_info ad4134_offload_info = {
+	.read_raw = ad4134_read_raw,
+	.read_avail = ad4134_read_avail,
+	.write_raw = ad4134_write_raw,
+	.debugfs_reg_access = ad4134_debugfs_reg_access,
+};
+
+static void ad4134_prepare_offload_msg(struct iio_dev *indio_dev)
+{
+	struct ad4134_state *st = iio_priv(indio_dev);
+	unsigned int base_len = roundup_pow_of_two(BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS));
+	unsigned int bpw = AD4134_CHAN_PRECISION_BITS;
+
+	st->xfers.cs_off = 1;
+	st->xfers.bits_per_word = bpw;
+	st->xfers.len = base_len * st->spi->num_rx_lanes;
+	if (st->spi->num_rx_lanes > 1)
+		st->xfers.multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
+
+	st->xfers.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+
+	spi_message_init_with_transfers(&st->msg, &st->xfers, 1);
+}
+
+static int ad4134_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4134_state *st = iio_priv(indio_dev);
+	int ret, ret2;
+
+	if (st->spi_mode == AD4134_SPI_MODE_4_WIRE) {
+		ret = ad4134_set_sample_access(st);
+		if (ret)
+			return ret;
+	}
+
+	ad4134_prepare_offload_msg(indio_dev);
+	st->msg.offload = st->offload;
+	ret = spi_optimize_message(st->spi, &st->msg);
+	if (ret)
+		goto out_set_register_input;
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &st->offload_trigger_config);
+	if (ret)
+		goto out_unoptimize;
+
+	return 0;
+
+out_unoptimize:
+	spi_unoptimize_message(&st->msg);
+
+out_set_register_input:
+	ret2 = ad4134_set_register_access(st);
+	if (ret2)
+		dev_err(&st->spi->dev, "reg input select error: %d\n", ret2);
+
+	return ret;
+}
+
+static int ad4134_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4134_state *st = iio_priv(indio_dev);
+	int ret = 0;
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+
+	if (st->spi_mode == AD4134_SPI_MODE_4_WIRE)
+		ret = ad4134_set_register_access(st);
+
+	spi_unoptimize_message(&st->msg);
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ad4134_offload_buffer_setup_ops = {
+	.postenable = &ad4134_offload_buffer_postenable,
+	.predisable = &ad4134_offload_buffer_predisable,
+};
+
+static int ad4134_pwm_get(struct ad4134_state *st)
+{
+	struct device *dev = &st->spi->dev;
+
+	st->odr_pwm = devm_pwm_get(dev, NULL);
+	if (IS_ERR(st->odr_pwm))
+		return dev_err_probe(dev, PTR_ERR(st->odr_pwm),
+				     "failed to get ODR PWM\n");
+
+	return 0;
+}
+
+static const struct spi_offload_config ad4134_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
+static int ad4134_offload_buffer_setup(struct iio_dev *indio_dev, struct spi_device *spi)
+{
+	struct ad4134_state *st = iio_priv(indio_dev);
+	struct device *dev = &spi->dev;
+	struct dma_chan *rx_dma;
+
+	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
+							   SPI_OFFLOAD_TRIGGER_PERIODIC);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	st->offload_trigger_config.type = SPI_OFFLOAD_TRIGGER_PERIODIC;
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma),
+				     "failed to get offload RX DMA\n");
+
+	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
+							   IIO_BUFFER_DIRECTION_IN);
+}
+
+/* The chip converts and outputs all 4 channels on each sample request */
+static const unsigned long ad4134_scan_masks[] = {
+	GENMASK(3, 0),
+	0
+};
+
+static int ad4134_offload_setup(struct iio_dev *indio_dev, struct ad4134_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	int ret;
+
+	ret = ad4134_pwm_get(st);
+	if (ret)
+		return ret;
+
+	ret = ad4134_offload_buffer_setup(indio_dev, st->spi);
+	if (ret)
+		return ret;
+
+	/*
+	 * Start with a sampling rate slower than 374 kSPS because that is the
+	 * maximum rate supported with wideband filter (default on power up).
+	 */
+	st->odr_hz = 250 * HZ_PER_KHZ;
+	ret = ad4134_update_conversion_rate(st, st->odr_hz);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set sampling freq\n");
+
+	indio_dev->setup_ops = &ad4134_offload_buffer_setup_ops;
+	indio_dev->available_scan_masks = ad4134_scan_masks;
+
+	switch (st->spi->num_rx_lanes) {
+	case 1:
+		return regmap_update_bits(st->regmap, AD4134_DIG_IF_CFG_REG,
+					  AD4134_DIF_IF_CFG_FORMAT_MASK,
+					  FIELD_PREP(AD4134_DIF_IF_CFG_FORMAT_MASK,
+						     AD4134_DATA_FORMAT_SINGLE_CH_MODE));
+	case 4:
+		return regmap_update_bits(st->regmap, AD4134_DIG_IF_CFG_REG,
+					  AD4134_DIF_IF_CFG_FORMAT_MASK,
+					  FIELD_PREP(AD4134_DIF_IF_CFG_FORMAT_MASK,
+						     AD4134_DATA_FORMAT_QUAD_CH_PARALLEL));
+	default:
+		return dev_err_probe(dev, -EINVAL,
+			"unsupported number of spi-rx-bus-width elements: %d\n",
+			st->spi->num_rx_lanes);
+	}
+
+	return 0;
+}
+
 static const char * const ad4143_required_regulators[] = {
 	"avdd5", "dvdd5", "iovdd",
 };
@@ -681,10 +1026,7 @@ static int ad4134_probe(struct spi_device *spi)
 	st->spi = spi;
 
 	indio_dev->name = "ad4134";
-	indio_dev->channels = ad4134_chan_set;
-	indio_dev->num_channels = ARRAY_SIZE(ad4134_chan_set);
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = &ad4134_info;
 
 	ret = ad4134_regulator_setup(st);
 	if (ret)
@@ -747,12 +1089,30 @@ static int ad4134_probe(struct spi_device *spi)
 		indio_dev->setup_ops = &ad4134_buffer_setup_ops;
 	}
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      ad4134_trigger_handler,
-					      NULL);
-	if (ret)
-		return ret;
+	st->offload = devm_spi_offload_get(dev, spi, &ad4134_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	/* Fall back to low speed usage when no SPI offload is available. */
+	if (ret == -ENODEV) {
+		indio_dev->info = &ad4134_info;
+		indio_dev->channels = ad4134_chan_set;
+		indio_dev->num_channels = ARRAY_SIZE(ad4134_chan_set);
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      iio_pollfunc_store_time,
+						      ad4134_trigger_handler,
+						      NULL);
+		if (ret)
+			return ret;
+	} else if (ret) {
+		return dev_err_probe(dev, ret, "failed to get offload\n");
+	} else {
+		indio_dev->info = &ad4134_offload_info;
+		indio_dev->channels = ad4134_offload_chan_set;
+		indio_dev->num_channels = ARRAY_SIZE(ad4134_offload_chan_set);
+		ret = ad4134_offload_setup(indio_dev, st);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to setup SPI offload\n");
+	}
 
 	/* Bump precision to 24-bit */
 	ret = regmap_update_bits(st->regmap, AD4134_DATA_PACKET_CONFIG_REG,
@@ -798,3 +1158,4 @@ module_spi_driver(ad4134_driver);
 MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD4134 SPI driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
-- 
2.53.0

