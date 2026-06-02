Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF453C8723;
	Tue,  2 Jun 2026 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389663; cv=none; b=E6sTZ4I4T2PVCtGGM9KiK9Iq4Ng/fLYS3V+5UL2D8zsODoDPCpgLYi2Ic5CqA2g9INusqUzalNcziEKVphhHhtVSLP8TkB9aWiWx2wWCxAWdmNZBiumvOuwswjDQ5Mm/QTjZRKtrpr/n5TwDDGpSeaWMI/SKjQzdhwyYM8PR/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389663; c=relaxed/simple;
	bh=BjdKqZ3DRhy/CiQsvCUy5gzvxHLayuC3PmRrDTz98Ko=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KHgNZWUT8e0PESuRywiDVcDD56JwUnVtvVYV6+Q3EWWeiGG0siZVl+rNBGcsNidVqVUXxZb1lbV92psOwOr0KxaQrXigYdCpaA1aAxtEjDa1EXGIqmi0aGzHV8frUW1Q9gQWxDhSnFmY6Qap2J9KpyYN+QbQzqxpSOgexY5cBAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cVKatmlB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cVKatmlB"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6527EWnT2682722;
	Tue, 2 Jun 2026 04:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=aJWrgfCtsWWVZ9NcdlbSQ3W8nEq
	36fzSrAIezYGtJzI=; b=cVKatmlBQUp61JKrg/Blk6AwAl62mb0vxolfJL5QIav
	/C5TWpXNN6JyBEf2gn1T29ZV1/zKys5S11nicvtP2fxFAIk3tC1CSId3wcLChPAO
	NxfTlzb+AnyLoPMvWgxixyNogCOxbQUVkSelX15rsBFYiKoj5GqCwOihKHSyjsRP
	/sn9sfebSVM8KQ1C4dyBj7aozsn19e5+R5+Qrk1D8PfaGrPeIsgKYa8nV18hfqnt
	uY/PLpb0xAhDNJj4jOdqMqeZADcqmq3RaYL1MwY+0BpiA18Fhif8K+1mZVrl+Qqe
	ZbVIAkWxXBic6DIX82ekcUzkIV0ZCwinvFMNrDXOgcg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ehtkyg9t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 04:40:58 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6528evV3058443
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jun 2026 04:40:57 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 2 Jun 2026 04:40:57 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 2 Jun 2026 04:40:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 2 Jun 2026 04:40:57 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6528ek72024354;
	Tue, 2 Jun 2026 04:40:48 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: ad4080: fix AD4880 chip ID
Date: Tue, 2 Jun 2026 11:40:19 +0300
Message-ID: <20260602084019.2564-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4MCBTYWx0ZWRfX63vfDaVpMIk6
 75VMGrbYv9YGR11nAd7ID9zKetVpDDniPSP6oSs3o/ysLvllYAHFznASvx/+oOS34hR2EjQiKDK
 nHg16/xfKhjap8IfPJrjcDWhQ8sIh6ZiVfMIm1qKx64GJBrkTd6kONReX0AWqTHdamPQ278Xwmt
 A5iurn4MoECJlrihIGTXlRG42z9rlN39IlDqbRC6oxyZrP6wHjB56SasUvsva5P1O5VHsqTStU4
 fiyaNsCR5BptQOENRGEAqMOe4yCfpzOCWPX5gaGo6I2B2/ejeFe5ciXuCHL/5kBPA3VGrjR8I2v
 q4Pv2NcsEesAbopPCd4KdEK0tJLRT3aZiuhMEWBj2Kc7dXJBU9Wwbwrr/8BM57netXvVJjE0pNn
 ws1RDGnCTYp27jNL2sbDtb8hUIfsKgEynTN3kqGvHJwFsmbHG48jOuiEvTi1Vzyv7PFjTruu1Qp
 JnbKOa793rX6us52W4A==
X-Proofpoint-GUID: is6oG5Rp-5Qt7ZqJxC_F8TK9CeYLd94W
X-Proofpoint-ORIG-GUID: is6oG5Rp-5Qt7ZqJxC_F8TK9CeYLd94W
X-Authority-Analysis: v=2.4 cv=J7yaKgnS c=1 sm=1 tr=0 ts=6a1e971a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=4TIp3I1At_sE4LCMeBQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020080

The AD4880 chip ID was incorrectly set to 0x0750. According to the
datasheet, the product ID registers read 0x00 (PRODUCT_ID_H) and 0x59
(PRODUCT_ID_L), giving a combined chip ID of 0x0059. Fix the value to
match the actual hardware.

Fixes: 35fc53e802bf ("iio: adc: ad4080: add support for AD4880 dual-channel ADC")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 764d49eca9e0..8d2953341b15 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -135,7 +135,7 @@
 #define AD4086_CHIP_ID						0x0056
 #define AD4087_CHIP_ID						0x0057
 #define AD4088_CHIP_ID						0x0058
-#define AD4880_CHIP_ID						0x0750
+#define AD4880_CHIP_ID						0x0059
 #define AD4884_CHIP_ID						0x005C
 
 #define AD4080_MAX_CHANNELS					2
-- 
2.43.0

