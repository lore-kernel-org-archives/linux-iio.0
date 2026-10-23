Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795081;
	b=GUm5AoO1Xe+8ERSgaspvvfRGH2FsLDoZUtZHkN48bT/OzWWgGgFCKzhFfID4NnCZAFRc
	 DLcc46QypnKa40c+o+FkxZF03xMweDJqj4Ec+5UGorMflSDNRlDGvAlnxBfvIoQ8+wk9B
	 Ed/wcMXA/fpQOiKNyMgOe9+omfL96jI1RLl80anAgvO3GRVEn122mRbqIl3e5k56sU7Ar
	 KH4yg69gWjwB221zzYaZg4AKT6WPvsy7hryTFVV7a9UDpfmqNvBYyec36/E++B8G5ePJX
	 9Nf6EZnVkiu2lay4XqxwjVsjEV3Z8vR/ADi3H6UujRoZAdmBvH4jmDWPgfJJ1ND91VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795081;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pMiXsllyxh/uIFgxMvB/xBO8mgqLCH0v4AF6VY3BKds=;
	b=x+y42VojzDmp+LN/98pi1wRcKDK3X4y2lt43l++JMcYS53YOi40km+AeEBrzESHIn0X7
	 LihKufVJndanXY4AbVoA0cf/8uTEzsofCf1SFm+QYlM7n1NCd+S4xhePa4x5n9P1W5OZU
	 7L5OqfzDKVpPQCF9sKqEfwRLWpsqlj4xAtxKmlDLpjc7f/14XlBhOmG6C7wfD8u2hHemH
	 12LtSZ76zI8zTraQo45SQzLranJr+jS0aiQt2X4hmtagng6WJMSBf6LPSdl8jDE09xGYV
	 67UiBSpz/LxxGxPeW8KMt54xwiHjdoXf7EMW4o5Tpf/9Nn4u/FD1nTAfz6WXxW0Ifqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=jarLKwlk;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=BbqDz2J+;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4385606A31D;
	Fri, 23 Oct 2026 22:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4385606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=jarLKwlk;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=BbqDz2J+
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLw69a1783276;
	Fri, 23 Oct 2026 18:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=pMiXsllyxh/uIFgxMvB/xBO8mgqLCH0v4AF6VY3BKds=; b=jarLKwl
	k/nmSbMHnquYVMdawpvsehnzrTtevJnZiBBG3K9QrI+2y07g4kZ8fmre+7U0+Q6k
	dkpshk3Bv2qOPMHPmrV0Wou5M3aOE+ANY0Xlvq40lNOOBuYv7hXHue5vpvyxmsnF
	uYjboKUvVcUXb1maAlvxo+H1ryBVHt69aruwC1rdEImFtdGbkSKoFC86Et+xZHqm
	3YPBkCJG7hP54KPIYnLaIRDNuHIORZ9mXciftqhNyaExa0Ro64p9UKHIpXRQwJif
	XcJOOI/wHOzHHcJS2zklFQ+7+5tgEXeT6v8iKX6mSUbIfHFbxEGpe8cs0ue5T0sA
	Ar7wJl9WvElynHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pMiXs
	llyxh/uIFgxMvB/xBO8mgqLCH0v4AF6VY3BKds=; b=BbqDz2J+O+u+T02+0SQOm
	UXzAeq/wvcKD8cGu2U0zzNPiSDxTmDge3+HmPyfQqHq4Y41DxOyfUpQD+MM2WI90
	90NBXEVwI09gFv6/eo5ZTKxUPtzi9bAkeZ3Q7fw8IUlxR8MCWgYpKnqiCvr/j+fx
	fnISEvZ4a5gi3aJ/DFTDnKStk5tuWeQRDa+y54qA4Gsr9Bt2wgkdwmRMJ+DZ51fZ
	ITEhQJtYylXUm5JAEQvD9zNBl+vGcROIhnci5eQW2h8MavULC5F1ZbcQqSnt5ZpW
	JJVOworf06O/cH2EuG+ZFEiqwxGrGsx2eVcXKbkgxahX2KOPx/AT5OZMnwZzQtIP
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hg2mvmcpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:37:55 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69NMbs93017736
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:37:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 23 Oct
 2026 18:37:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:37:54 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMbeHe005924;
	Fri, 23 Oct 2026 18:37:42 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 15/16] iio: adc: ad4134: Support high-speed data capture
Date: Fri, 23 Oct 2026 19:37:34 -0300
Message-ID: <129d38f50d44c804d657d067a9c77691ec4b9d74.1792792325.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792792325.git.marcelo.schmitt@analog.com>
References: <cover.1792792325.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: vyE9wYB136gmkw7Lkfeo5cEHT3hwhvfS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfX8TfrlzGfURHP
 X6XvZhAjLZab1e95YAvLvIDuXjgLbNnF1vzmKoeSmBZyjThqAnpAvc60DmR+twQce11Rct5AW2F
 A3QrnyA/zOT6CN//1jYRGj9DVBRkncW53IZHRvDuMvh3pwkiPIYa
X-Authority-Analysis: v=2.4 cv=YJoKWhGx c=1 sm=1 tr=0 ts=6adbe1c3 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=3dB5uatT78WUhGqxeF4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfX3nePsOtSPwce
 FJhChcPkL9ULi1JLbal6CdkE5Fd4UToq7/wEdQcvKVkjb1dCaYIPm+SlBxfx+TPJgXB3iEGhXvv
 0CEXOonty08ORdltOibJKF18hKoEKizNveVS9wzEVO+cEbnTr9RmnxZbP0M5A7bFypgmUwKkXJV
 e2JJ3nVikDMcxGoAECy6FAi3xWqeSF/hY6K9NeZTNeHMkVMFHqonR9NX0MJt7PZ+Xervf/AnO+M
 SsbmN2dPMYi0iJOpp0dBYE+bSf5cTEEfu+g95QS4QmDBqYoLZTszzD5EfdY7PWo4XGPnB3VrgFG
 CRiFjFxjh0uM7XL6rrjoaqoqmUxNpJ2vfgNkp+90MKQo7T0OnxhMpsAM6J+FUSHnYiIxAPUYSB6
 lGb1GfUBjH81hTJVrkus/LoaASdRAiQr50ovju28d2Z14IsXwk8BVfwylgKd96xUh3RTvCtioYf
 vzKmX7UhvSNyQWkReOw==
X-Proofpoint-GUID: vyE9wYB136gmkw7Lkfeo5cEHT3hwhvfS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230089

Make use of SPI transfer offloading to speed up data capture, enabling data
acquisition at faster sample rates (up to 1.496 MSPS). In this operation
mode, a PWM connected to ADC ODR pin and single-shot reads can't be
supported due to that.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v5 -> v6:
- Check the ODR to SCLK offset aginst the maximum ODR high time.
- Removed defensive offload support check on read_raw().
- Added comment explaining why single-shot reads are not supported in offload mode.
- No error out when pwm_round_waveform_might_sleep() return > 0.
- Adjusted intial ODR PWM target duty cycle to odr_high_time_ns.

 drivers/iio/adc/Kconfig  |   5 +
 drivers/iio/adc/ad4134.c | 390 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 382 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 70552e13d3a9..b2e90a2d9e43 100644
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
index 4efb63c45aa2..bc6407ae25e0 100644
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
 
 #define AD4134_RESET_TIME_US			10
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
@@ -215,6 +237,38 @@ static const struct iio_chan_spec ad4134_chan_set[] = {
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
@@ -462,6 +516,94 @@ static const struct regmap_config ad4134_regmap_config = {
 	.max_register = AD4134_CH_VREG(AD4134_NUM_CHANNELS - 1),
 };
 
+static int ad4134_update_conversion_rate(struct ad4134_state *st,
+					 unsigned int freq_Hz)
+{
+	struct spi_offload_trigger_config config = st->offload_trigger_config;
+	struct pwm_waveform odr_wf = { };
+	u64 max_odr_high_time_ns;
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
+	target_ns = odr_high_time_ns;
+	count = 100;
+	do {
+		odr_wf.duty_length_ns = target_ns;
+		ret = pwm_round_waveform_might_sleep(st->odr_pwm, &odr_wf);
+		if (ret < 0)
+			return ret;
+		target_ns += 10; /* Increment by PWM duty cycle period */
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
+	max_odr_high_time_ns = max_t(u64, odr_high_time_ns, odr_wf.duty_length_ns);
+	if (config.periodic.offset_ns < max_odr_high_time_ns + AD4134_DCLK_RISING_OFFSET_NS)
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
@@ -551,6 +693,44 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
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
@@ -603,6 +783,166 @@ static const struct iio_info ad4134_info = {
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
@@ -677,6 +1017,9 @@ static int ad4134_clock_select(struct ad4134_state *st)
 		dev_warn(dev, "invalid external clock frequency %lu\n",
 			 st->sys_clk_hz);
 
+	if (!st->sys_clk_hz)
+		return dev_err_probe(dev, -EINVAL, "0 Hz external clock\n");
+
 	return 0;
 }
 
@@ -697,10 +1040,7 @@ static int ad4134_probe(struct spi_device *spi)
 	st->spi = spi;
 
 	indio_dev->name = "ad4134";
-	indio_dev->channels = ad4134_chan_set;
-	indio_dev->num_channels = ARRAY_SIZE(ad4134_chan_set);
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = &ad4134_info;
 
 	ret = ad4134_regulator_setup(st);
 	if (ret)
@@ -781,17 +1121,40 @@ static int ad4134_probe(struct spi_device *spi)
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
@@ -837,3 +1200,4 @@ module_spi_driver(ad4134_driver);
 MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD4134 SPI driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
-- 
2.53.0

