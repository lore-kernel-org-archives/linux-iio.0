Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ACC53979A;
	Tue, 22 Sep 2026 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075430; cv=none; b=EdRLO95ByIVP1vrrKfGU0UaKoDoZtnuHvmuYY3KUgwM8yVG428CXYjkg6M3xd7PGZeTG8zPdaweQyENDVdFUp3frrb3+y3w1btoTCTOwMJhQ7NgXvClXj1okJP3yb5i07wX1zo7V0uDwl8tzgbeeN1y0nMPNfqDIyW4C3h4E3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075430; c=relaxed/simple;
	bh=tKwy/w1wSHCkUKhG/vyDpp6TFzg99sN7f7TUb2pKqxg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nk0gyYcVkpywe8OQui1yBbHjuMTxVrsMtAXxB7YIUfOef1nbE4nckUwmXr9SRS0SsPzOR8JokYvkbYQYqcLngr8f0OMorosMTg9R7Tg48iuRI5j188OYU3b/3QwZIMS3yN0P4gLBmxJ7Ua9jM5rINXpm8ZhPH03qpcCHrYBd6r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qEVEyL2d; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qEVEyL2d"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MAYibd2384549;
	Tue, 22 Sep 2026 07:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=/NHHPJrBD3Sn/i5twpdWO2+G06n
	bedjKsQ4hvZly5TQ=; b=qEVEyL2d87OTcbYqyQThnexvzl8tS6ttRwL5tHB6wLR
	K6dxRVWB/XupicJo4kldW7ivaDgYSyck8yRtgguMEF9yi3eiZBN/0UELE+C/JQQe
	9o/51Mn0BEvtVOe+gFJYzImfPgPfQdI4xADcmM+ShFnF3UQhcQHTLJ4saw1Hc0FC
	r3NbVRowAxzSKFaucjhcthmR04WVGCXm0/Dbl3+VmzXOepLFV6LZAJlDTuUc4/J+
	SgTxQz37Y2EMePiyhhlBPRQyQ3evvzADywrRuwWkFSfgptsPywWhsDtWyvEVpBBx
	F6lmKq9aNsRpPYz+wEH0BFbhGkxEUlhZyCjOtR88TJg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gsm83ed2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 07:10:14 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68MBADqT059668
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Sep 2026 07:10:13 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 22 Sep 2026 07:10:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 22 Sep 2026 07:10:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 22 Sep 2026 07:10:12 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.202])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68MBA27H022762;
	Tue, 22 Sep 2026 07:10:05 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: ad4080: enable address ascension for chip identification
Date: Tue, 22 Sep 2026 14:09:58 +0300
Message-ID: <20260922110958.1329-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE2MSBTYWx0ZWRfX2JXj49gsb0ah
 B6OQyNmDyibuYm0DoALcG9FoMkQj17rEwc8F5c6wLT1ziIEz/6+lcgA5JtfHAQL5iZTAykz9BCe
 Xba3skPyomfyPk1qXugWQIV+pxoFEKXuVyxN+SbPXL76ZCVxMOrY
X-Proofpoint-GUID: SwSnn60E0kIhKKulhTH6-hEan7u6ervy
X-Authority-Analysis: v=2.4 cv=e66T2qp/ c=1 sm=1 tr=0 ts=6ab26216 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=QwXq9NN0wpR9igFFdQoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE2MSBTYWx0ZWRfX4Cg0V+4AtrqB
 Cshf9Z2+Ns7CYuJImKjcfnUHyF5qpiEdfL/vxoAuItZ7cTWhz8exSq7SvIUc9upfMxkhQR6tsty
 Q/sxmK5og0ZbsqKu4dZqsIsX3F9dqnhfrAubNxKONzyu8DLAnXU738j/MkygR4QeI8PAX8s5+D8
 S+G+j9RHpNxL4CI+IkO0O4okJt5+A5oelsgKtih0AGXs8qvSIheItODufU/Zxq+5/OXb+9mEl3Q
 pwr73YJJNC538DF8zHx7mQM0APxhbkET4hmiCAALnWHrbc+EX5ZtbiQj5nBQ+1IPUf9pxqa9/lr
 32BhZQNULBUIqKSJ4b+Bfbi1bS54Vemzy4wnyRMvAfZj1b/xWTM9m/h4pigqiGE0W9nWKOJxX+b
 wjRNNwxdWOk79SHYKdWH2aAcs+Xj44C50mevEDHJeP9e2CitUZwiJBoJNZ3p6AOgXUWl8lY+Kal
 crBuGV6QFAOBGOO0BpQ==
X-Proofpoint-ORIG-GUID: SwSnn60E0kIhKKulhTH6-hEan7u6ervy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220161

The two byte bulk read at AD4080_REG_PRODUCT_ID_L expects PRODUCT_ID_L
followed by PRODUCT_ID_H. After a software reset the AD408x defaults to
descending address mode, so the second byte comes from CHIP_TYPE (0x03)
instead. CHIP_TYPE reads 0x07 on all AD408x parts, so an AD4080 reports
0x0750 rather than 0x0050 and every part logs "Unrecognized CHIP_ID".

Set ADDR_ASC along with SDO_ENABLE before the read. This is the only
multi byte transfer in the driver, so no other access is affected.

Fixes: b66cddc8be72 ("iio: adc: ad4080: fix chip identification")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 4843ecdd91a8..4ed82aa42400 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -710,7 +710,8 @@ static int ad4080_setup_channel(struct ad4080_state *st, unsigned int ch)
 		return ret;
 
 	ret = regmap_write(st->regmap[ch], AD4080_REG_INTERFACE_CONFIG_A,
-			   AD4080_INTERFACE_CONFIG_A_SDO_ENABLE);
+			   AD4080_INTERFACE_CONFIG_A_SDO_ENABLE |
+			   AD4080_INTERFACE_CONFIG_A_ADDR_ASC);
 	if (ret)
 		return ret;
 

base-commit: dceba8e581e3e8f475da0efbd7a73f3d9524ddd2
-- 
2.43.0

