Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D32F329C56;
	Mon, 23 Feb 2026 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866666; cv=none; b=DzwLzGllBr1CfbTJR1Z9LhyzvL121qwciPw0rJPjPZ3mSsmym4MB70Kqm2B++Ok5jrAhb2JNip/dXthJL1Zh1sOE0CatnO+EvlVuJ4il6YhdChf/IYXjxGtEuG5SC5RnTGyfBfPCJc3jRXbPlCLo8lRMHsWFmXA4FfTtONpUClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866666; c=relaxed/simple;
	bh=WAvrRHooFSLuY3TO15yL6bmDKWsdM083rhULXZa3Fk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5LUTv1SfO4CuSEa4eU0b0YaPDOVzo3qa0jqEP39gB7Wsb4X9/znphvD8iJyLsdXlpRYWS5q1Wynze0Vl+czJ5FdpNjVJr6z9NlLuJ2OUus9U3WfWd6dauET6bJuoc2g9kc42tQDmTiihkvjQAKigQX0smk3nXlAu59PXJg0aok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=htE/esls; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="htE/esls"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NCWnkU818778;
	Mon, 23 Feb 2026 12:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FP6Hq
	YdlSC+FXD1qpOpZMNngWpDJ8fdQvzLghAuAalg=; b=htE/eslsZgknqbG2yzR/N
	jf2WNMwgVSTPQcPZPxFdazo7w+Zwbn8vhVgjgm+U5qH4Lr0o/gHqcXXsY4zBSzUY
	U3tQbB2gn15fo9R8JtLika/M8yWc/cj5vf7EwpuFyG5ccS3t9MB3BY/MrlWhl3As
	BJitpMudYzhh+vChENX4zpE8aRjOWQ1lmx+9tidIFtizeX+RQjKkzfNRsxyedRmO
	+OV/XBxBDAcFwwS5Db1B1j3C0DzDLbNvFcGzS537HE1AzcqnHWC0CUYX2yKdkrbL
	NUf6eQv7G6+Cg7Iek+IjgNLQ8cEyI2uiPzHFbin7huFashzdG018e+f7pM7cm1sk
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p03rpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 12:10:59 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NHAwP8036503
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 12:10:58 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 12:10:58 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 12:10:58 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 12:10:58 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NHAcVJ017873;
	Mon, 23 Feb 2026 12:10:41 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        David Lechner
	<dlechner@baylible.com>
Subject: [PATCH v10 6/6] iio: adc: ad4030: Support common-mode channels with SPI offloading
Date: Mon, 23 Feb 2026 14:10:38 -0300
Message-ID: <4aeb678a873c9f3936efc0f17cd24a4f014217c2.1771865684.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1771865684.git.marcelo.schmitt@analog.com>
References: <cover.1771865684.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: hq4OM_FMena-WnrxLtwwaRFzFrHeDGQW
X-Proofpoint-GUID: hq4OM_FMena-WnrxLtwwaRFzFrHeDGQW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE0NiBTYWx0ZWRfX7uZT3Hqz/U2U
 p1LJhcQVomk+1MQa5QnbQPBlIvEhOP8j47l6rN0B59Qje9oRRTzS2UANQqE9eUVIPfxG9RxX91y
 v8YonlmP+WHkdn5SUpa9Vn65S5kRZCYFbrXYHkzgDnYOrbo/BMixV5K0WEyMdix0tonryn2YUV1
 qNFSkkTT1cIyaTdAZxuC0/gRaYkXr2I28hNavwG2wRkAVfedLG6mLuA4dZ+sjo7B5AzdbvmoJjz
 vA7qmCcG/EV2bv77KAXIff650JnNfze0RAW5i7JhxlQ1S+f8qVkS90NQj4cEVaBT4fV8MoucYpr
 57X8XvMuhwRVZMFQR4gvpp5+qMVB8YB3IbM40nLfQFQWzSo5BXHVUZBAMJS7cDHTqPIDouZjfQw
 4QwSI6T+q2qIw8WquAI3o5K2i5w7FSLpumrmrw+ZVY7/6tNrguwUg6UTESIh6KKsur5r+qq2mTh
 UzAwkP9RrVfuC5iZjiA==
X-Authority-Analysis: v=2.4 cv=Fq4IPmrq c=1 sm=1 tr=0 ts=699c8a23 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=rdXqIxahAAAA:8 a=gAnH3GRIAAAA:8
 a=nLo5uX867Eh3Y58ELpAA:9 a=qWU3L9Jmq6PeI4v8DYd9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230146

AD4030 and similar devices can read common-mode voltage together with
ADC sample data. When enabled, common-mode voltage data is provided in a
separate IIO channel since it measures something other than the primary
ADC input signal and requires separate scaling to convert to voltage
units. The initial SPI offload support patch for AD4030 only provided
differential channels. Now, extend the AD4030 driver to also provide
common-mode IIO channels when setup with SPI offloading capability.

Reviewed-by: David Lechner <dlechner@baylible.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v9 -> v10
- No changes.

 drivers/iio/adc/ad4030.c | 49 ++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 47f733aceb03..8414ab73345e 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -193,7 +193,7 @@ struct ad4030_state {
 	unsigned int avg_log2;
 	enum ad4030_out_mode mode;
 	/* Offload sampling */
-	struct spi_transfer offload_xfer;
+	struct spi_transfer offload_xfer[2];
 	struct spi_message offload_msg;
 	struct spi_offload *offload;
 	struct spi_offload_trigger *offload_trigger;
@@ -238,7 +238,7 @@ struct ad4030_state {
  * - _idx - _ch * 2 + _ch gives the channel number for this specific common-mode
  *   channel
  */
-#define AD4030_CHAN_CMO(_idx, _ch)  {					\
+#define __AD4030_CHAN_CMO(_idx, _ch, _offload)  {			\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 		BIT(IIO_CHAN_INFO_SCALE),				\
 	.type = IIO_VOLTAGE,						\
@@ -248,12 +248,18 @@ struct ad4030_state {
 	.scan_index = (_idx),						\
 	.scan_type = {							\
 		.sign = 'u',						\
-		.storagebits = 8,					\
+		.storagebits = (_offload ? 32 : 8),			\
 		.realbits = 8,						\
-		.endianness = IIO_BE,					\
+		.endianness = (_offload ? IIO_CPU : IIO_BE),		\
 	},								\
 }
 
+#define AD4030_CHAN_CMO(_idx, _ch)					\
+	__AD4030_CHAN_CMO(_idx, _ch, 0)
+
+#define AD4030_OFFLOAD_CHAN_CMO(_idx, _ch)				\
+	__AD4030_CHAN_CMO(_idx, _ch, 1)
+
 /*
  * For a chip with 2 hardware channel this will be used to create 2 differential
  * channels:
@@ -1187,6 +1193,7 @@ static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
 static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
 {
 	struct ad4030_state *st = iio_priv(indio_dev);
+	bool common_mode;
 	u8 offload_bpw;
 
 	if (st->mode == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF)
@@ -1194,10 +1201,22 @@ static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
 	else
 		offload_bpw = st->chip->precision_bits;
 
-	st->offload_xfer.bits_per_word = offload_bpw;
-	st->offload_xfer.len = spi_bpw_to_bytes(offload_bpw);
-	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
-	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+	st->offload_xfer[0].bits_per_word = offload_bpw;
+	st->offload_xfer[0].len = spi_bpw_to_bytes(offload_bpw);
+	st->offload_xfer[0].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+
+	common_mode = st->mode == AD4030_OUT_DATA_MD_24_DIFF_8_COM ||
+		      st->mode == AD4030_OUT_DATA_MD_16_DIFF_8_COM;
+
+	if (common_mode) {
+		offload_bpw = 8;
+		st->offload_xfer[1].bits_per_word = offload_bpw;
+		st->offload_xfer[1].len = spi_bpw_to_bytes(offload_bpw);
+		st->offload_xfer[1].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	}
+
+	spi_message_init_with_transfers(&st->offload_msg, st->offload_xfer,
+					common_mode ? 2 : 1);
 }
 
 static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
@@ -1262,6 +1281,7 @@ static int ad4030_offload_buffer_predisable(struct iio_dev *indio_dev)
 static const struct iio_buffer_setup_ops ad4030_offload_buffer_setup_ops = {
 	.postenable = &ad4030_offload_buffer_postenable,
 	.predisable = &ad4030_offload_buffer_predisable,
+	.validate_scan_mask = ad4030_validate_scan_mask,
 };
 
 static int ad4030_regulators_get(struct ad4030_state *st)
@@ -1512,7 +1532,7 @@ static int ad4030_probe(struct spi_device *spi)
 		 * Offloaded SPI transfers can't support software timestamp so
 		 * no additional timestamp channel is added.
 		 */
-		indio_dev->num_channels = st->chip->num_voltage_inputs;
+		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs;
 		indio_dev->channels = st->chip->offload_channels;
 		ret = ad4030_spi_offload_setup(indio_dev, st);
 		if (ret)
@@ -1632,6 +1652,7 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
 	},
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(1, 0),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4030_24_GRADE,
 	.precision_bits = 24,
@@ -1653,6 +1674,8 @@ static const struct ad4030_chip_info ad4630_16_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_16_GRADE,
 	.precision_bits = 16,
@@ -1674,6 +1697,8 @@ static const struct ad4030_chip_info ad4630_24_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_24_GRADE,
 	.precision_bits = 24,
@@ -1695,6 +1720,8 @@ static const struct ad4030_chip_info ad4632_16_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_16_GRADE,
 	.precision_bits = 16,
@@ -1716,6 +1743,8 @@ static const struct ad4030_chip_info ad4632_24_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_24_GRADE,
 	.precision_bits = 24,
@@ -1734,6 +1763,7 @@ static const struct ad4030_chip_info adaq4216_chip_info = {
 	},
 	.offload_channels = {
 		ADAQ4216_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(1, 0),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_ADAQ4216_GRADE,
 	.precision_bits = 16,
@@ -1753,6 +1783,7 @@ static const struct ad4030_chip_info adaq4224_chip_info = {
 	},
 	.offload_channels = {
 		ADAQ4216_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(1, 0),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_ADAQ4224_GRADE,
 	.precision_bits = 24,
-- 
2.39.2

