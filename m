Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AE53CAE93;
	Tue, 15 Sep 2026 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483610; cv=none; b=m0hoXYc9v6v+vzWS8bXa9V5Q1223+ng03KRC7td9pCy+TatkpygzgoVtPjSWqvz1rtd/cRinWogsXAoWao+sY4Q4A/BZWCZSrOAsSk+50vOuPiC1Uvg61466s7VLbxrdcKE4tEGVasUXI/T7mWJhPMTI3gktnLMizw1ns+7eoBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483610; c=relaxed/simple;
	bh=Ma8wukv4nXecZ4lhDNqATmDTX3tfyfXtbjb/k3cF+Sw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mWoPJOeYO/a4qr7AmDi5vhqWcdYdXS7MyHiBfTSkkui9mKjLFb2gIfQEF7/A624dyB5MKi1EwJyR5uec+RhcM5PMO0tSeph0mZ6e0QfjlC9nrBzSaKW2LMIPy3KNILmNoca3qDK7jLf2HXflWCfy/PTqO+9JebJIolgJV1uLM2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Dwz/Q1Nj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Dwz/Q1Nj"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FCxWVF4162318;
	Tue, 15 Sep 2026 10:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=HMiI82AyKBQaEuzTkLK+h/DM8KH
	KJxY1XnqxxVd8OVY=; b=Dwz/Q1Nja8Y2YTEqEm8hXQwCmpQKTPUh+FInQgWHmBp
	8O17hprVkd+jvjoiRhKE4oa8GMFsX6YYWqGXvwRY9UgN0e6KwG5wQjhv8o6jwDej
	ajTEJ2uGRep9KgGSCgcYSVpsJcgYRuwiPKsm9UXVbvuvUS7rxvb11hF/EWKHa0Gm
	qHi4AZHGwzzEvcUcXAtoXG5JaGqpbD+GlL9brZ2rSt6mc8tmrNzGATwxwj/FEKhx
	UbAHiCweHFRun9twRA6ZaAa5TGZFG8MfJ3F86ml9Y7Kc5IdOmgwnSV/yey+iXQxm
	jUoOBpHQHvTiQ7sU4+3hIbGRfjLufpbm1eXoM4CMO3A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gq4v9h6yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 10:46:39 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FEkcuR028826
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 10:46:38 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 10:46:38 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 10:46:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 10:46:37 -0400
Received: from HYB-li3PrmDPxTz.ad.analog.com (HYB-li3PrmDPxTz.ad.analog.com [10.48.65.197])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FEkRad019074;
	Tue, 15 Sep 2026 10:46:29 -0400
From: Andrei Stancovici <andrei.stancovici@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Andrei Stancovici <andrei.stancovici@analog.com>
Subject: [PATCH v5] dt-bindings: iio: adc: lltc,ltc2497: generalise the title
Date: Tue, 15 Sep 2026 17:46:24 +0300
Message-ID: <20260915144624.44841-1-andrei.stancovici@analog.com>
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
X-Authority-Analysis: v=2.4 cv=JekpPkKV c=1 sm=1 tr=0 ts=6aa95a4f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=gEfo2CItAAAA:8
 a=69L4K10tceRheaywoE8A:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIxNCBTYWx0ZWRfX1saEVMofCZ6d
 fTwDg7Du//NvSNp5jOaDckCbhISe+fwQe1JwGQdIY1J+l1MNAx4WG8PAPiTy/sL3gfbyrYYmMV2
 ERqGr9zVFP3v1e2GXmUwrCGTK7sybghAfj6m12YgHOrh1/g8b3RVlapIIOydLHlZa+zfIdK66ib
 hVuwAt609lrf81xuTneybfqIbe3NVlvB4qOjEnVTquEtHwsBNJugG/1nMJ1J6u05HJPtWPqSjyr
 /8nknqFBM9psbMXbGRKERz7JFArgvgpkkO5lrIdTHBBY3LDEJJJLgUWnPdRFP7ppI3ZGf4b4Mfj
 /Kd4Ry4myJN7PgthMdqyMaExgltMjG7zWxJ+I4/Fsa/VbCwFfgA4bWUtBSa9TX/X5sD+/YkgB7F
 9LdQ2w7pwPHBLU8bEs5WANdnQo7HTvZNvZlFLk+75acOeq+UsMzech3wj2Qjul37XEiNXPyKEPd
 e2X6Yf4e0JPSZm/U5XQ==
X-Proofpoint-GUID: hsH4ClW3ye6ieD06SkCmYdAYsBFtYzX5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIxNCBTYWx0ZWRfX3MhofiueBRzn
 ESyiGcEZl8V+Vym2lgdmvTarlKq6RztIyf325z6x/rfjwFY5ndO3SAWyd0MBowBaK2NhMMYwX9G
 Vcd1lm1JwPhWkSypl7nfO/7HVY4rph/Cmqnrb3OGre7/A9WTHhsi
X-Proofpoint-ORIG-GUID: hsH4ClW3ye6ieD06SkCmYdAYsBFtYzX5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150214

The title names two of the four parts the schema documents: the LTC2305
and the LTC2499 are in the compatible enum and in the description, but
not in the title. Rather than extend the list each time a part is added,
say "LTC2497 and similar ADCs", as bindings covering a large number of
parts tend to end up doing. The full list stays in the description.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
Changes in v5:
- Only this patch is resent. Patches 2 and 3 of the v4 series ("add
  LTC2499 internal temperature channel" and "add 2x conversion speed
  mode") are already on the testing branch of iio.git, so v5 is a
  single-patch round.
- The title is now generalised instead of enumerating one more part.
  v4 added the LTC2499 to it; Sashiko then pointed out that the LTC2305
  is also supported and also missing, and Jonathan suggested stopping
  the enumeration and using "LTC2497 and similar" as bindings with many
  supported parts tend to do. The full list is already in the
  description and is left alone.
- Documentation only; no driver change, so no hardware run for this
  patch. The DC1012A-A validation previously reported covers the applied
  patches 2 and 3.

v4: https://lore.kernel.org/r/20260909082755.366269-1-andrei.stancovici@analog.com

 Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
index c884b6e03767..67445ad2bb3b 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/adc/lltc,ltc2497.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Linear Technology / Analog Devices LTC2497 and LTC2309 ADC
+title: Linear Technology / Analog Devices LTC2497 and similar ADCs
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>

base-commit: 36c12dbda81c284d72f3c64689461647497b643b
-- 
2.43.0

