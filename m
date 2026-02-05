Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A98B436367;
	Thu,  5 Feb 2026 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310200; cv=none; b=oVprpx0uH+HNiG3jzgOM177OZWkZbMGEWguQP4cFKwke/lIvSKRp4LBCrnx0gTJlhtGvHuvV0NX5kRlvNxw3OmFqQn9PNOG6+Z9GC9Y7QfWghBJfkG02TPUB7imnvQdGiPwHIjtTbT2mWMaOLOfMfsoB8rc64WDuieTr4T+z2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310200; c=relaxed/simple;
	bh=6JY1hWiIyRtTtgtlpMcVcHNMD468KAGhdf4TxR8y6Rc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQY7c/9yVZolouCisdwVYqilE79ulDsSCUMPulAg/c5z06ImT3DB192Cp/GaaE7n+0r6AqQPrDU5Asg56fsqXIWou5/w1p0Jd1rn/LlRMM2KZ7BZNrUMnkGroVbPnYZ4oNV8OI0HLQ4I+CoO730ZC3Jg2XAyrWIhvzKrx3r5e2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WEUmgsqH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WEUmgsqH"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615AbPnu2446434;
	Thu, 5 Feb 2026 11:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0y3y6
	eFts47OTUNFONixEBorw01ZVvvr6fN9U5y+P98=; b=WEUmgsqHZkf2ouFSKwv9m
	wGhE+xwwbPYzilVUDyWpM1u1K3LiGwTAkMY3KO0Ogbj12ckwmSojDNjFQu8AbDEZ
	OIJAm0St2BUEwBDhNR1YLj2z0htMgxgDtqOFOMo85CisbrfI8u+JpW/PPl9DG5BB
	85e+1AzZTOYwkY8qnZrkcfs26cVU8RWIjaCQ1oTl6crl3Octi05KUPlt0COlggQN
	XlXFl/kpUY4Han8RG7PQJBC2yfLPO+T403agVHs+E2HXGnd9K7uPuwdnj33v+1x9
	8q4BuurN+MIQnE48zOPNFfExfPbxlN4eVkZANMLASFV+FFTfAlta9/SJZSj6DZ+z
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c3vxvg287-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 11:49:54 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 615GnrqS045362
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Feb 2026 11:49:53 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Feb 2026 11:49:53 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Feb 2026 11:49:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Feb 2026 11:49:53 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 615GnbHK000489;
	Thu, 5 Feb 2026 11:49:40 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 8/8] iio: adc: ad4030: Support common-mode channels with SPI offloading
Date: Thu, 5 Feb 2026 13:49:37 -0300
Message-ID: <027a198b8dea771601d7dcfa9827e7204e873741.1770309522.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1770309522.git.marcelo.schmitt@analog.com>
References: <cover.1770309522.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: g8bSlcw99eF1lbslK9MH6Z6kwTOE6Bzp
X-Proofpoint-ORIG-GUID: g8bSlcw99eF1lbslK9MH6Z6kwTOE6Bzp
X-Authority-Analysis: v=2.4 cv=OrdCCi/t c=1 sm=1 tr=0 ts=6984ca32 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=nLo5uX867Eh3Y58ELpAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNyBTYWx0ZWRfXz+pS+yHjiE5D
 WQUxrzIQZLr/JtvLjAUKbU4HVNvOk2MZ1i/oOypig4Z9vRLHYTLhm/LM7bxr0bDlAGRxk5XCglL
 bwWmexzqUjKC9fGSF3380OuS6sThYt4+6QymbhmeaRMn/RYj93iBLkoDV3+pYX0wGnkM2mX985i
 3qiNy2ndc658eV4eme2YJ0dI9i0qRgaJ/kBc6gh3CDkbv0qLGZdync6UoLTYcVMxGK9jr/7fZGh
 Son0Ytg9m0rTHzG8NANHgEgcMdfLL33D4werNAbpYzk7GULH9fqB0l/YVFL1I93CKedvzRzs0FU
 3IUW3cvT+ZK7fN/qT807Q99f2gC7eJXxY/ErR5X6R9PT1zqgfxN0h3OaNjIuUjbIgAuoJ42j/JI
 odUOxCw1e5CTTOp7K6IcwAchE7gsweSHn+DPJlDYHwIqD6vejTpIlY2sK6xelVOpDSNPwHDM/k6
 BFDalIUEYIfMoGNK7Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050127

AD4030 and similar devices can read common-mode voltage together with
ADC sample data. When enabled, common-mode voltage data is provided in a
separate IIO channel since it measures something other than the primary
ADC input signal and requires separate scaling to convert to voltage
units. The initial SPI offload support patch for AD4030 only provided
differential channels. Now, extend the AD4030 driver to also provide
common-mode IIO channels when setup with SPI offloading capability.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v6 -> v7
- No changes.

 drivers/iio/adc/ad4030.c | 49 ++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 4f521fe787d9..b2b3cd8ff38a 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -192,7 +192,7 @@ struct ad4030_state {
 	unsigned int avg_log2;
 	enum ad4030_out_mode mode;
 	/* Offload sampling */
-	struct spi_transfer offload_xfer;
+	struct spi_transfer offload_xfer[2];
 	struct spi_message offload_msg;
 	struct spi_offload *offload;
 	struct spi_offload_trigger *offload_trigger;
@@ -237,7 +237,7 @@ struct ad4030_state {
  * - _idx - _ch * 2 + _ch gives the channel number for this specific common-mode
  *   channel
  */
-#define AD4030_CHAN_CMO(_idx, _ch)  {					\
+#define __AD4030_CHAN_CMO(_idx, _ch, _offload)  {			\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 		BIT(IIO_CHAN_INFO_SCALE),				\
 	.type = IIO_VOLTAGE,						\
@@ -247,12 +247,18 @@ struct ad4030_state {
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
@@ -1180,6 +1186,7 @@ static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
 static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
 {
 	struct ad4030_state *st = iio_priv(indio_dev);
+	bool common_mode;
 	u8 offload_bpw;
 
 	if (st->mode == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF)
@@ -1187,10 +1194,22 @@ static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
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
@@ -1255,6 +1274,7 @@ static int ad4030_offload_buffer_predisable(struct iio_dev *indio_dev)
 static const struct iio_buffer_setup_ops ad4030_offload_buffer_setup_ops = {
 	.postenable = &ad4030_offload_buffer_postenable,
 	.predisable = &ad4030_offload_buffer_predisable,
+	.validate_scan_mask = ad4030_validate_scan_mask,
 };
 
 static int ad4030_regulators_get(struct ad4030_state *st)
@@ -1506,7 +1526,7 @@ static int ad4030_probe(struct spi_device *spi)
 		 * Offloaded SPI transfers can't support software timestamp so
 		 * no additional timestamp channel is added.
 		 */
-		indio_dev->num_channels = st->chip->num_voltage_inputs;
+		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs;
 		indio_dev->channels = st->chip->offload_channels;
 		ret = ad4030_spi_offload_setup(indio_dev, st);
 		if (ret)
@@ -1627,6 +1647,7 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
 	},
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(1, 0),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4030_24_GRADE,
 	.precision_bits = 24,
@@ -1648,6 +1669,8 @@ static const struct ad4030_chip_info ad4630_16_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_16_GRADE,
 	.precision_bits = 16,
@@ -1669,6 +1692,8 @@ static const struct ad4030_chip_info ad4630_24_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_24_GRADE,
 	.precision_bits = 24,
@@ -1690,6 +1715,8 @@ static const struct ad4030_chip_info ad4632_16_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_16_GRADE,
 	.precision_bits = 16,
@@ -1711,6 +1738,8 @@ static const struct ad4030_chip_info ad4632_24_chip_info = {
 	.offload_channels = {
 		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
 		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(2, 0),
+		AD4030_OFFLOAD_CHAN_CMO(3, 1),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_24_GRADE,
 	.precision_bits = 24,
@@ -1729,6 +1758,7 @@ static const struct ad4030_chip_info adaq4216_chip_info = {
 	},
 	.offload_channels = {
 		ADAQ4216_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(1, 0),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_ADAQ4216_GRADE,
 	.precision_bits = 16,
@@ -1748,6 +1778,7 @@ static const struct ad4030_chip_info adaq4224_chip_info = {
 	},
 	.offload_channels = {
 		ADAQ4216_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_CMO(1, 0),
 	},
 	.grade = AD4030_REG_CHIP_GRADE_ADAQ4224_GRADE,
 	.precision_bits = 24,
-- 
2.39.2

