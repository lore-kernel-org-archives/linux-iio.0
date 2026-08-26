Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533533F58D4;
	Wed, 26 Aug 2026 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743077; cv=none; b=s8s+CgQqEY+vIwL3uLzfB/jr3nb2QxM1LiTOfXGJwjC7tt/7Sl8JWE5Oe0U65QOvTAzwqAzgKkCzch9BUztGpkQXnDwy54aOlhaIn2eiVozQd1QovxeD7LARN69IxbFUDRV/3L3RqG8DnxVo1HHJ4i/2WOc4gY7Sd9sfGWz1T6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743077; c=relaxed/simple;
	bh=gX+GsIsDj4f5PUWb2tOeyf3YqtyokhTxrVgjk0DUNwU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nQPvp5TDl8xcuiS35of2BABHfvzmQW3DmGCU5hk9J+QWjtb/SgHUBW3qmX2I4bvMVTHb444gUeYQ0cHjXWTRL87mxCaCj5+dR6+ktryM4Pw1IeogecUxy3XSP8bv9o2jx4Vs+GAq1QP+fIarhZngX4WWfNGo8UMM2Qd0TCPdtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cSb2zfKy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cSb2zfKy"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QAHhvl143923;
	Wed, 26 Aug 2026 07:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=9dpCzHhB0S4Ang5QqnlW4crPmzb
	0XnWOgoZYXnFUBv8=; b=cSb2zfKy+0GPKcx7iN74Rizzrmd5QKbDO1yFzoFhuSH
	mSM82pTBKAIWkekYrAZit5HRxcQl5rsl9bqBSTgJpvaE4QSK/VL/4+ELUEywS91P
	yFlh3zJIAnY7kYdLAXg0P/8kSREZjeTJSQV2NLoltwzuE0EcZ9u4vXizSD6nmFHP
	sj+6RDJZTfkTSqFUYwBLixqKXf7SnO3oQY4A1t5AN/ObT96novE6bl2qD07HK8wk
	oj8BKetyYW+2ljr3PdtLM11V94HkDKs9mBqK0h4xDzCYp72nPCA/+XfEfyHnThmD
	oqulcKE+GIiNFHcvZUgNMx3a3UaJ13CLbLHjr2xtlHg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g969b6qva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 07:17:34 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67QBHXUX004803
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Aug 2026 07:17:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 26 Aug
 2026 07:17:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 26 Aug 2026 07:17:32 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.100])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67QBHMe1007255;
	Wed, 26 Aug 2026 07:17:24 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: ad4080: allow debugfs register access to both channels
Date: Wed, 26 Aug 2026 14:16:13 +0300
Message-ID: <20260826111613.14218-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: UoYeSMcQsD8EZ1DrsNNQZs6lKU7vX1W0
X-Authority-Analysis: v=2.4 cv=D4h37PRj c=1 sm=1 tr=0 ts=6a8ecb4e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=p6zGWUHtMlR7zjXSirgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA5NCBTYWx0ZWRfX+ntIwrU1h7V7
 gx/CuOMtxJ6YgzJsiPnnC38UEEfOLb1ixsXzK6XbEFRk5VLMTWgW8bDYyJKvG6b78Ylf7ZFM0z0
 QkCkaiO2o3iCYD+0W7XgpMotCluDlim0v4wXqdn0uSMFP9UwJWwF
X-Proofpoint-ORIG-GUID: UoYeSMcQsD8EZ1DrsNNQZs6lKU7vX1W0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA5NCBTYWx0ZWRfX/1HmVHqaQUfx
 e1ljtcpQW5+DbcoxWE3ujmakGsHUYZb4NsnINvIpm6GePnRjCogqpESVJObnGkDhZJ157H0ElIr
 desLPdlqMzWyg7rZ0ldV4xniSfxaaQeX9D/VTCBIiCDPCtzbMPk79J/PktEAfYcWw+GBEkgPgx/
 2guplY0VrJz/7JYSFIFASGMbLlpIPHzZ9+GyarCrXISF2UDd1pvjTNjpMRAO0VabiR6AZYAzR6L
 +8YyDlE4mFcHqsZFhQF/bddPUZlr8otQNxv2dkaMyBNhLqALu5iCSm/j2cUte0wEpW+l6JBeQzC
 f9r/yWgFGkcDCu2EACL51qzl9FV5XmsyNZDVLc4RcqVAGcuI13oXes+ycjiitLMt5U54QqB+ogr
 HJCh8VEps7K5yGX7EEbsPX6AmZ7+WaRFahrCrPImUPlo9sG5MByIr8KkhIU9DDOsdsJdBJGXI7B
 HT7FrYB/2loWVoxtBiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260094

The dual-channel parts (AD4880/AD4883/AD4884) are built from two
independent ADC dies, each with its own SPI chip select and register
map. They are presented as a single IIO device because the FPGA
interleaves both dies into one DMA stream, so only one direct_reg_access
debugfs file is created and it can only reach channel A's regmap. Channel
B's registers are therefore inaccessible, which blocks bring-up and
debugging of the second die.

Select the target die through the debugfs register address: the low 8
bits are the register offset and the upper bits are the channel index
(0x0nn selects channel A, 0x1nn channel B). A read returns the real
register value of the selected die and each die is addressed
independently; single-channel parts only accept channel 0.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 04cd6628ebff..994625a7cf8b 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -145,6 +145,10 @@
 #define AD4080_MAX_SAMP_FREQ					40000000
 #define AD4080_MIN_SAMP_FREQ					1250000
 
+/* debugfs direct_reg_access channel windowing: 0x0RR = ch0, 0x1RR = ch1 */
+#define AD4080_DEBUGFS_REG_CH_MSK				GENMASK(15, 8)
+#define AD4080_DEBUGFS_REG_OFFSET_MSK				GENMASK(7, 0)
+
 enum ad4080_filter_type {
 	FILTER_NONE,
 	SINC_1,
@@ -210,11 +214,16 @@ static int ad4080_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval)
 {
 	struct ad4080_state *st = iio_priv(indio_dev);
+	unsigned int ch = FIELD_GET(AD4080_DEBUGFS_REG_CH_MSK, reg);
+	unsigned int offset = FIELD_GET(AD4080_DEBUGFS_REG_OFFSET_MSK, reg);
+
+	if (ch >= st->info->num_channels)
+		return -EINVAL;
 
 	if (readval)
-		return regmap_read(st->regmap[0], reg, readval);
+		return regmap_read(st->regmap[ch], offset, readval);
 
-	return regmap_write(st->regmap[0], reg, writeval);
+	return regmap_write(st->regmap[ch], offset, writeval);
 }
 
 static int ad4080_get_scale(struct ad4080_state *st, int *val, int *val2)
-- 
2.43.0

