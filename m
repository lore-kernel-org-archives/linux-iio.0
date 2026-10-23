Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794934;
	b=YA2boZ6aJnKuA4RGoXPp/G3UMEXudy1c10O1qoQHTxuomGluTxBirg22bOpnel56qm3I
	 w9VTrQqngg55RXWiPpBtw7O3Ty0NpWXhV77O2B5pqWR48WUB0Gi7lOrcGRH7sr6oEICm1
	 rAIl9tMlNzlmtWPvvJA4HcRKKW9/zpb9yUSc9vkoDXmIT5eSKlTsOMJ6Fyde8HN08cA4T
	 O/pcTgcEaku6RjoesPYJ6IsPpRKvozjc5jIN1Ki3CPHGhFHZFtIUeuCSbZ5dyUqaLorBA
	 sloIjnooOQiIMMQHDb5POQFkQLecM9Wesle4QmMw/7UAF/ZBC474QLHL+ud4lujrbAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794934;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=TN9gTEsjxfOR0heNE17g6VomTOgL4yDpNq6PlzdRuBg=;
	b=Zj2dNxDD/BaxSRy7KRsESyDm2WJ0vbsJ2gJCGgcgPLQZBacABk1Le12qrcC1dA5IQhYS
	 kroj36gje8aKK/TVEl6DcDeV58QWxgubVFvZ74ETk/A/VjoqLIYS5oPe+Tfd8HCKJfmN9
	 8Rd43l6Cggbae17B1FG7jiaKaC7W+fOzkZ2MYKjiCmvCw18oIOE4Saoq+jXrzb/xB+dR+
	 9A/U7Di5JNS8jlM2D6X2stI05NLGFk2VsItml0pAvwhVY0Nj9e4ZphlBm2AD4MIC7nXVr
	 RsW4qv9RkbUprRRnH2Go+F3glSOq43wQGSVahBmQv9jAR8oYlE/aB9Kf8K/a7GL7o9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=d6leKVOK;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="is1b/n/b";
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACBB606A31A;
	Fri, 23 Oct 2026 22:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ACBB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=d6leKVOK;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=is1b/n/b
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLwQB23008989;
	Fri, 23 Oct 2026 18:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=TN9gTEsjxfOR0heNE17g6VomTOgL4yDpNq6PlzdRuBg=; b=d6leKVO
	Kn75CfrSOuypKarcvpNWBRlVjmAQaugG2yuqvCqx9jvWKXs3iMi81pf72L7j8fF1
	l7kDY30pRt+X1Lr56+Js0SEh3xSKyq3+WxRl5SU0lLxrKgILEbhetnZAmm1ABRkB
	f6lQLjJ6eBBbKkVMXFzPW5Xt3985LmysGSiuUFp2idJeaAZh2eyeaYzuhJgRnfS+
	fEMpx5ziU/zhI/DayrsSB6zr80n6QXAJAtvc1sgXvHI18GNWP5+onFS0z2AnvT/Q
	jsYtlisS4DWJCQzVXJwMbNJjLw4hKfnpvdyW6Yjs8g25lpXjWV16aSVUSnb8wEsI
	m6usaz9PNp/TZuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TN9gT
	EsjxfOR0heNE17g6VomTOgL4yDpNq6PlzdRuBg=; b=is1b/n/b3+4studUP3Sw8
	iiiHNguC9zqQc1Do9LhdicoZ959801zDptAtlCZz0UDtU5S41dGW5xfHCjZIFqZs
	5uPtaH2pmIFQupdCW27DP4X1FEmiHFuoZhEHpmlthJKR6IjFpRhHYlZN33MBpRHm
	riB7wMQ2fSBUT3lnlMOXLY/L1tt1i3dvWxQrdoqV6NngzwUBqQ/9eOM9ZHyg1duq
	lwqDYuGlgC4h1Vi7UdaD4pr5jiu8ucfPrwcbcRkq+7KTT34Trws19lHVhmqwZ66K
	XftHclupJdGVANX017c9Mr2vSiLQKEa3/c3QCLI4kORPFDKU+VzVBWyCFt7tmSpU
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hg3574bpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:35:29 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69NMZS6Z017596
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:35:28 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:35:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:35:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:35:27 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMZEjV005873;
	Fri, 23 Oct 2026 18:35:16 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 07/16] iio: adc: ad4134: Run shorter transfers when CRC is disabled
Date: Fri, 23 Oct 2026 19:35:09 -0300
Message-ID: <af78e90546e780aa9323c70753bbd062acb6cb49.1792792325.git.marcelo.schmitt@analog.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: RtycPRNQ0JgQi4mEmZz22g1CGPH4zsyy
X-Proofpoint-GUID: RtycPRNQ0JgQi4mEmZz22g1CGPH4zsyy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfX0JjhOXpkgvBD
 eXGkH2lHduiSPoo5ZW2AVAMN+5jxigdP3DUlwezBKc11xul9PJI56WSPjgylHcN4Bobklu1OgPK
 AZJKTgGmcu3wdghOvY6v/7bjZUhij1x2cmdrfmqiDEAQHP1C0UEBJcZCsmeWEhSb2H5y0Ol2Gny
 nWi1IKnGrEmqlTPWF4mCTRNTsoc0ExnuNLWtf6I0DkdnvlMqNpvihdTdKop4QOemCamNf9l7gdN
 I9yhO8cAmNoKP7jEMJmmAuR99nDgCW5+lOY1axJikLlKcqfF10QMkptdqk7T8wwyKlQcT+fyOaJ
 1L7VskNSrYsPxhvzXaTxfJYL3gEvbiE3j9ayXFenkKZdBw9IJLxDHkQADhOnbPFnTIBrhCyFx/p
 hSQe5lWmf1TRH3T16hJ5JRkwhqJpOjZjfo5C+G51xlpbvKIAv238pWWroZjzpVuZqm2XOoQvGkX
 AzaY3R3LCdrK7AGpG6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfX5BSEm46BOLdr
 i81CZmIdztywanrWBkihxFGZimmzuEC0TPubngk3BUtqZ5v0DcmWNn63R5HfBzFL2J4WFwtr7jI
 V692txucbt6HXaM+pQ/2QS5hXzSu72K9RYv983skqEatWapsRJGz
X-Authority-Analysis: v=2.4 cv=V5PoQuni c=1 sm=1 tr=0 ts=6adbe131 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=oleLBB3xA4KM-oybjuwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230088

When AD4134 has its SPI CRC feature enabled, one extra byte (the CRC code)
is sent through SPI for both ends to verify the integrity of data
transfers. Though, when CRC is not enabled, SPI transfers can be shorter.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No change in v6.

 drivers/iio/adc/ad4134.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 71f626bbe9be..bbfa0b168ce5 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -106,6 +106,7 @@ struct ad4134_state {
 	 */
 	struct mutex sync_lock;
 	int refin_mv;
+	bool crc_en;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -159,7 +160,7 @@ static int ad4134_reg_write(void *context, unsigned int reg, unsigned int val)
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx_buf,
 		.rx_buf = st->rx_buf,
-		.len = AD4134_SPI_MAX_XFER_LEN,
+		.len = st->crc_en ? AD4134_SPI_MAX_XFER_LEN : 2,
 	};
 	int ret;
 
@@ -169,7 +170,7 @@ static int ad4134_reg_write(void *context, unsigned int reg, unsigned int val)
 	if (ret)
 		return ret;
 
-	if (st->rx_buf[2] != st->tx_buf[2])
+	if (st->crc_en && st->rx_buf[2] != st->tx_buf[2])
 		dev_dbg(&st->spi->dev, "reg write CRC check failed\n");
 
 	return 0;
@@ -217,7 +218,7 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx_buf,
 		.rx_buf = st->rx_buf,
-		.len = AD4134_SPI_MAX_XFER_LEN,
+		.len = st->crc_en ? AD4134_SPI_MAX_XFER_LEN : 2,
 	};
 	unsigned int inst;
 	int ret;
@@ -232,7 +233,7 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
 	*val = st->rx_buf[1];
 
 	/* Check CRC */
-	if (st->rx_buf[2] != st->tx_buf[2])
+	if (st->crc_en && st->rx_buf[2] != st->tx_buf[2])
 		dev_dbg(&st->spi->dev, "reg read CRC check failed\n");
 
 	return 0;
@@ -319,6 +320,7 @@ static int ad4134_min_io_mode_setup(struct ad4134_state *st)
 	struct device *dev = &st->spi->dev;
 	int ret;
 
+	st->crc_en = true; /* In minimum I/O mode CRC cannot be disabled */
 	st->odr_gpio = devm_gpiod_get(dev, "odr", GPIOD_OUT_LOW);
 	if (IS_ERR(st->odr_gpio))
 		return dev_err_probe(dev, PTR_ERR(st->odr_gpio),
-- 
2.53.0

