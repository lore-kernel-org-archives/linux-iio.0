Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2199543B6F3;
	Wed,  9 Sep 2026 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942499; cv=none; b=MQB1k0yZ4WBMn2ookFfJpu7ODEkqeUb449df4mSiHK9yhOHVqrhGnGAS+Rbbnn5/uU4T2Dh8VQgAq8bcy6eMCkbCXjtOTvrzCZYeIN7ks2pZneYvoikpksZW84d6lqohcTDPAg99jH2JK6Sf6FO3DgvwZMgxmXU3QpGI6wiJbw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942499; c=relaxed/simple;
	bh=mChYRR+anAJlV/XXuQipsoPloSLDBwv8qUBlE0Gi/Nk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdMOgJwrIht6nFxlMDO5Nhi7QDOmCk7CnfNwqQWfg0dXkRzw1BaVWeR42Rt+IYViTwUkYsBEpMB7el5fjNRN2wDO0Pm0F3AO5VGSm2i4vquzKcj2A023zt/P2g7+QOBE/RjMJH1W9NE/DLSdW/Jx8xRJadZSJ2zsU8GwiLGkPKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Y6DtSupA; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Y6DtSupA"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6894kJSn4155563;
	Wed, 9 Sep 2026 04:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QMMK2
	AvZDwPGu0wApDLh+EKw5oHyxtkZRvufSirdjQ0=; b=Y6DtSupAGe3sOYA4V6XLh
	rkIeL3KoUfb0dyvTApsnidRNdrd3i94RsYW6nBr0+adJdvauWSmO9V3vqYdmOvh7
	fq1y2H0idGsj94QlpZDeB0L1Qcb5WlpY0d58i521/OwnNaM1fcFo2HEi12ArsAal
	jNWPHcXiqUVnuhnH3u78XG9ryArTR5IISW4qOeggGuGMesKy6RPK+dJa99cy+k20
	0b0/Imgzxgd+AeneGqywryRkwpCzVytU/x1HVreJmEgEzSsf1na9VMUWRDs6nX1S
	xUKonec5vUFFsdLUFKzyjr2g0lnbOebFKnKLe9SyhjeQtvfPlPd21MyB2O65nakD
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gjvfb1w5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 04:28:13 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6898SCEb001421
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Sep 2026 04:28:12 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 9 Sep
 2026 04:28:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 9 Sep 2026 04:28:12 -0400
Received: from HYB-li3PrmDPxTz.ad.analog.com (HYB-li3PrmDPxTz.ad.analog.com [10.48.65.171])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6898RxF6032752;
	Wed, 9 Sep 2026 04:28:08 -0400
From: Andrei Stancovici <andrei.stancovici@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Andrei Stancovici <andrei.stancovici@analog.com>
Subject: [PATCH v4 1/3] dt-bindings: iio: adc: lltc,ltc2497: add LTC2499 to title
Date: Wed, 9 Sep 2026 11:27:50 +0300
Message-ID: <20260909082755.366269-2-andrei.stancovici@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909082755.366269-1-andrei.stancovici@analog.com>
References: <20260909082755.366269-1-andrei.stancovici@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 380qMVIWpooTzPMUWWv2MgMzkVPyORo5
X-Authority-Analysis: v=2.4 cv=Yvk/gYYX c=1 sm=1 tr=0 ts=6aa1189d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=EP9JJrKyo648RTWUWkgA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA5MiBTYWx0ZWRfX1LqCGTg7ELvb
 am5vZvd0vX6nNl48NkPwHw5wm6LLqADCJSMblGI2DMZ2bAlMrQalbJjb2a/6mBKNSMwKGIlGJIG
 BziIg7Nk6ZN0AYSNo/WxXzIld64z39w+EQOx2EEwXOmujW+1qJ/S
X-Proofpoint-ORIG-GUID: 380qMVIWpooTzPMUWWv2MgMzkVPyORo5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA5MiBTYWx0ZWRfXxwdq+r+XPM2q
 4tj1IObwnlnN/NbQ26r8gEC7iqhUR7dFUHosn7qPVTINr069SaeKV1PT9djkcWalRnb/4i66YMB
 p42EIWNKV+NymCGw+NhcwPiugh/LpwN5nxftVo5Yw4eRhqyvo0oxTWF07pZBLF3Ih47h2fnPzrl
 52wEsm1mtRU3+P4AGW4qxghTvrziah25GSvjlCXTDJ8hEphoNs4NpKKM/E3b1r9G/0ZJWg4WRZY
 Xu2UPNDq8C7VGm7/YuXrNWJ+K2cntNci91t2MOJB+GuqA/x2xqeZFi6I2k+YPTAoUz00izBhnNW
 D4ju9DEhULFxfbUCY6sVC18J9guoGXG5iwdl4t3AdM3ylYaH4CGzu4k5fj1788GEla0DKsVmVzo
 KeD+oZ3fYgsNgzaHk+BVw/2cRRW+3Suyu3H2/NMqQwNh7VdvHpIFO60ZFCO/Yh4cnq8FEo7CuNX
 dF6Dran9a5AbkOM7TVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090092

The LTC2499 is already listed in the compatible enum and covered by the
description, but was missing from the binding title. Add it so the title
matches the set of devices the schema documents. No schema or property
change is needed.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
Changes in v4:
- No change.

 Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
index c884b6e03767..8aa1ba0a8728 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/adc/lltc,ltc2497.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Linear Technology / Analog Devices LTC2497 and LTC2309 ADC
+title: Linear Technology / Analog Devices LTC2497, LTC2499 and LTC2309 ADC
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
-- 
2.43.0

