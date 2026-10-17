Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40736D51B;
	Sat, 17 Oct 2026 02:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202465; cv=none; b=u7hzHWigXvzfuqXGSsS4B6IGkuaNplIdEGuJW892nlMFEYI0S1NqpXyIrFh+brsog34dceEDFIaoMI378bkHx9Guvk/typgu31x6lHQS3G7FNCg6PdGX5wAJFang+bvtptJJ0vFWuC3qxjKCMwFvezlgjiRSzUiy0I35HJzviXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202465; c=relaxed/simple;
	bh=/MoJA5Nqz1UbwXoeZ4z6ITAdGzNxLMWwTBdkSjUH1G4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qM4yUm2WTJ8hxmuY5EpY/LAAcFHYydxuVAZE8gsacYDrtCOEGveKwgu4LCti4XoLUDI/CAJKIAn9jrL86lkqWwLwCyvl3pXJ4pfdFZo5vzUjcUrKbJUontB11oRSzd/IvpAMPn39bi+MdtkJfjMlpUg6fz0sEbDw5hbWMwgfDIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=CTUaK9iS; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GqcxWvCt; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="CTUaK9iS";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GqcxWvCt"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNH2xX3829523;
	Fri, 16 Oct 2026 22:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=U5pqWpIGM8PcVGrLX2YSFIj26P5vNThwLIYt56TtNrs=; b=CTUaK9i
	SJdBBM3UhmX0YSHo4xmiaTbwI8eIPDMb/eg5eErsUdYuDP2ozK5tZaISlVOc5RxO
	Ghm7b7fuItIs061rXP8EtOOq0/zUlJV6QJ5j6BOBQVo3/uryRWMvS11id7Wu+25U
	1FPPdPQnPpP4gW3PzQuoHp9pdR0xKB0HvYSIYwqTOMpiu/LoY2OpWBlFDMR1Koj8
	juZ5+iYyBw+w49q5s19MuqiQwcy3Tf3OA0RR0EzP6TiFf1y/cRPGwR1x8t0bkPno
	aCqfvwR6cadgD/Do/8HPjHIQ1/EsUeNuGaLp3ZAF31Ln4cdxm48uAWpY4Zw2P3PY
	fmgknSQXMIE0LhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=U5pqW
	pIGM8PcVGrLX2YSFIj26P5vNThwLIYt56TtNrs=; b=GqcxWvCtMA7XCzL5pytbe
	rkVEvY6FqBg1s5kUqkiEk0Ou6aJM+tsJVpLWe4ntWa+Igq7zp5LdFa+hcHC8QTRa
	ObiRmG/ob1ifcR6zwT0IfIfHeMzwzxgv9RutbdE6aIt815ACzwcyAsbQSB6aTN0L
	L1C5pzHLJQ8+vAApZmiQ5gpU/oREtIRKG9KGa+d4EUKGe5wY7poIDNd/NgF2O+j0
	j5cZ6OFJYZGzvhvL80bb9UP4D6IuaPDY7pO9aaFDAXV0TnzPplOlhIH3r7HBluBZ
	K8kf6lwzTYQ93thTjQMpROlP+F4Ei6y9GQoB1Nvw5LQOvLUP8o256X4SNIIOheeR
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hbj174967-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 22:00:56 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69H20tZn062448
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 22:00:55 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 22:00:55 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 22:00:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 22:00:55 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H20fP0005194;
	Fri, 16 Oct 2026 22:00:44 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 14/15] iio: adc: ad4134: Support high-speed data capture
Date: Fri, 16 Oct 2026 23:00:34 -0300
Message-ID: <44d545559aaf7cf2605aa30b5e9c9e5aa4aca879.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX6JCGpsxwnWXL
 5Fquho4rsv6RO2ufGw8uuEXH8zYfEbUn/+oRqaWvEsOa6OoHv40CY0vNqq1JwOWzCtHyVQxWOWz
 2TtLTpYlCsleFgHs/vTOqnlIbOd0Kf5EspIck4gYXU5F4lPpD8yd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX8NX27XaG5mhS
 30bg/9xUKFjpgmY8L3p9i4XjSmfRJxunReLNBpkCZtGL79xQGuGm+wcjzRXSZB9i1dSycdMsXyG
 v6MiDjhXStDVAmMa9yMcdmEqg0GLLAdcUJrVCfVOV2JMolPp3eIp/3jn2WdN46DOBZlXYCZzwFG
 HEw0SV1vBtd9sJBWL+/FnMEKvBU7adMfBJ9emD18lBFrFeBdz+8phPGG8iadDfP78q/tq1LSEmi
 z1TPPGd/kL6cGisyjgFmtmXw4a7T8pwGpVSTpLBbdQiEtNmSvt7B0Isg0OLXpQ44/cQEaZBrpHK
 fYbYqxX/Ml0qMy/Lxx895NW8s2z06KaHEKjY/z1801Xw6dbjrhTKLAkuOZCwviJJWi1fY6psv3O
 8uFoO3kJmJi0DwMnRGwASO/NUyrZAfeQQAKb2kRXLcWJ4vpjtGyZRv1tk43l64l9KG0CX14z3Ev
 i8gLHl+comip5wnGIrA==
X-Authority-Analysis: v=2.4 cv=Wd6Z+EhX c=1 sm=1 tr=0 ts=6ad2d6d8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=3dB5uatT78WUhGqxeF4A:9
X-Proofpoint-ORIG-GUID: hJcOZfkh8Cp2_apMS3k1ameh4P6BuJ_P
X-Proofpoint-GUID: hJcOZfkh8Cp2_apMS3k1ameh4P6BuJ_P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170007

Make use of SPI transfer offloading to speed up data capture, enabling data
acquisition at faster sample rates (up to 1.496 MSPS).

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/Kconfig  |   5 +
 drivers/iio/adc/ad4134.c | 391 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 383 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 10f3c804df9a..f2bbaef88a5a 100644
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
index 6b05e40f7aeb..21e8039b3411 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -12,6 +12,7 @@
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/gpio/consumer.h>
@@ -19,9 +20,12 @@
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
@@ -29,11 +33,16 @@
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
@@ -64,6 +73,7 @@
 #define AD4134_DIG_IF_CFG_REG			0x12
 #define AD4134_DIF_IF_CFG_FORMAT_MASK		GENMASK(1, 0)
 #define AD4134_DATA_FORMAT_SINGLE_CH_MODE	0x0
+#define AD4134_DATA_FORMAT_QUAD_CH_PARALLEL	0x2
 
 #define AD4134_PW_DOWN_CTRL_REG			0x13
 #define AD4134_DEVICE_STATUS_REG		0x15
@@ -116,6 +126,10 @@ static const char * const ad4134_filt_names[] = {
 	[AD4134_SINC3_REJ60] = "sinc3+rej60",
 };
 
+static const int ad4134_max_samp_freq_range_Hz[3] = {
+	AD4134_MIN_ODR_FREQ_HZ, 1, AD4134_MAX_ODR_FREQ_HZ,
+};
+
 struct ad4134_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
@@ -129,6 +143,14 @@ struct ad4134_state {
 	struct mux_state *mux_st[2]; /* For external multiplexer control */
 	enum ad4134_spi_mode spi_mode;
 	int refin_mv;
+	struct spi_message msg;
+	struct spi_transfer xfers;
+	struct spi_offload_trigger_config offload_trigger_config;
+	struct spi_offload_trigger *offload_trigger;
+	struct spi_offload *offload;
+	struct pwm_waveform odr_wf;
+	struct pwm_device *odr_pwm;
+	unsigned int odr_hz;
 	bool crc_en;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -213,6 +235,38 @@ static const struct iio_chan_spec ad4134_chan_set[] = {
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
 static const struct regmap_range ad4134_regmap_rd_range[] = {
 	regmap_reg_range(AD4134_IFACE_CONFIG_A_REG, AD4134_SILICON_REV_REG),
 	regmap_reg_range(AD4134_SCRATCH_PAD_REG, AD4134_PW_DOWN_CTRL_REG),
@@ -461,6 +515,92 @@ static const struct regmap_config ad4134_regmap_config = {
 	.max_register = AD4134_CH_VREG(AD4134_NUM_CHANNELS - 1),
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
+	u64 target_ns;
+	int ret;
+
+	if (!in_range(freq_Hz, AD4134_MIN_ODR_FREQ_HZ,
+		      AD4134_MAX_ODR_FREQ_HZ - AD4134_MIN_ODR_FREQ_HZ + 1))
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
+	target_ns = 0;
+	count = 100;
+	do {
+		target_ns += 10; /* Increment by PWM duty cycle period */
+		odr_wf.duty_length_ns = target_ns;
+		ret = pwm_round_waveform_might_sleep(st->odr_pwm, &odr_wf);
+		if (ret)
+			return ret;
+	} while (--count && odr_wf.duty_length_ns < odr_high_time_ns);
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
+	} while (--count && config.periodic.offset_ns < odr_high_time_ns +
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
 	IIO_DECLARE_BUFFER_WITH_TS(u32, channels, AD4134_NUM_CHANNELS) = { };
@@ -520,6 +660,9 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW: {
+		if (!IS_ERR_OR_NULL(st->offload))
+			return -EPROTONOSUPPORT;
+
 		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 		if (IIO_DEV_ACQUIRE_FAILED(claim))
 			return -EBUSY;
@@ -550,6 +693,44 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 		*val2 = AD4134_CHAN_PRECISION_BITS - 1;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->odr_hz;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
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
+	guard(mutex)(&st->sync_lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4134_update_conversion_rate(st, val);
 	default:
 		return -EINVAL;
 	}
@@ -602,6 +783,166 @@ static const struct iio_info ad4134_info = {
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
+	unsigned int base_len = spi_bpw_to_bytes(AD4134_CHAN_PRECISION_BITS);
+
+	st->xfers.cs_off = 1;
+	st->xfers.bits_per_word = AD4134_CHAN_PRECISION_BITS;
+	st->xfers.len = base_len * AD4134_NUM_CHANNELS;
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
+	int ret, access_ret;
+
+	ret = ad4134_claim_sample_access(st);
+	if (ret)
+		return ret;
+
+	ad4134_prepare_offload_msg(indio_dev);
+	st->msg.offload = st->offload;
+	ret = spi_optimize_message(st->spi, &st->msg);
+	if (ret)
+		goto out_offload_release;
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
+out_offload_release:
+	access_ret = ad4134_release_sample_access(st);
+	if (access_ret)
+		dev_err(&st->spi->dev, "reg input select error: %d\n", access_ret);
+
+	return ret;
+}
+
+static int ad4134_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4134_state *st = iio_priv(indio_dev);
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+	spi_unoptimize_message(&st->msg);
+
+	return ad4134_release_sample_access(st);
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
+	BIT(3) | BIT(2) | BIT(1) | BIT(0),
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
+}
+
 static const char * const ad4143_required_regulators[] = {
 	"avdd5", "dvdd5", "iovdd",
 };
@@ -676,6 +1017,9 @@ static int ad4134_clock_select(struct ad4134_state *st)
 		dev_warn(dev, "invalid external clock frequency %lu\n",
 			 st->sys_clk_hz);
 
+	if (!st->sys_clk_hz)
+		return dev_err_probe(dev, -EINVAL, "0 Hz external clock\n");
+
 	return 0;
 }
 
@@ -695,10 +1039,7 @@ static int ad4134_probe(struct spi_device *spi)
 	st->spi = spi;
 
 	indio_dev->name = "ad4134";
-	indio_dev->channels = ad4134_chan_set;
-	indio_dev->num_channels = ARRAY_SIZE(ad4134_chan_set);
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = &ad4134_info;
 
 	ret = ad4134_regulator_setup(st);
 	if (ret)
@@ -776,17 +1117,40 @@ static int ad4134_probe(struct spi_device *spi)
 		indio_dev->setup_ops = &ad4134_buffer_setup_ops;
 	}
 
-	st->odr_gpio = devm_gpiod_get(dev, "odr", GPIOD_OUT_LOW);
-	if (IS_ERR(st->odr_gpio))
-		return dev_err_probe(dev, PTR_ERR(st->odr_gpio),
-				     "failed to get ODR GPIO\n");
+	st->offload = devm_spi_offload_get(dev, spi, &ad4134_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	/* Fall back to low speed usage when no SPI offload is available. */
+	if (ret == -ENODEV) {
+		st->odr_gpio = devm_gpiod_get(dev, "odr", GPIOD_OUT_LOW);
+		if (IS_ERR(st->odr_gpio))
+			return dev_err_probe(dev, PTR_ERR(st->odr_gpio),
+					     "failed to get ODR GPIO\n");
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      ad4134_trigger_handler,
-					      NULL);
-	if (ret)
-		return ret;
+		indio_dev->info = &ad4134_info;
+		indio_dev->channels = ad4134_chan_set;
+		indio_dev->num_channels = ARRAY_SIZE(ad4134_chan_set);
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      iio_pollfunc_store_time,
+						      ad4134_trigger_handler,
+						      st->spi_mode != AD4134_SPI_MODE_NO_CS ?
+						      &ad4134_buffer_setup_ops : NULL);
+		if (ret)
+			return ret;
+	} else if (ret) {
+		return dev_err_probe(dev, ret, "failed to get offload\n");
+	} else {
+		if (st->spi_mode == AD4134_SPI_MODE_NO_CS)
+			return dev_err_probe(dev, -EPROTONOSUPPORT,
+					     "Unsupported min I/O + offload config\n");
+
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
@@ -832,3 +1196,4 @@ module_spi_driver(ad4134_driver);
 MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD4134 SPI driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
-- 
2.53.0

