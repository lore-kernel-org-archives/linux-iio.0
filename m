Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53FD2BE639;
	Mon, 16 Mar 2026 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661542; cv=none; b=Ar2f9Cw14UtupkfFRKTt2uRroGrmEl8pPJmEIzSzi31GGRj6HoBUisTv+eEix2RQzeGay8KsoZcEqQeABylFl2ohfFUdIt3dvaXANttuqImmhkWBTtKd4+lUjQ9Waq540nh1tB1P8bSmzphXO/szPBMPuoXHLq5w+X8DLt2+1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661542; c=relaxed/simple;
	bh=9bndzt8niBIsdxLDsRTxDOxrzunEJdKxWZ1FJI7h73E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmEppcsTePmzETqY4X3+lIpN56VXWCsytDpagBbnLrTq/x9glsdR5/88y2ehbvkn7L/of6lB+4MwjEN5UkcU9Vi2KfC3GMslDWkSsc67IZQ3teeVgs5M2PUhao9xW2fVslX3bN6nv5oS1UMo7xNjqIc6D9C+uhvAeOf468TnGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=h+T2hzLS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="h+T2hzLS"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBBqWe2122210;
	Mon, 16 Mar 2026 07:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yK4nA
	hhBJQU72PLaCATjuIHXbwW6gmv1rzP8PrlH7/Y=; b=h+T2hzLSOJ/MTVfD2p277
	Ft8adA8zw1m9BewZ5csDjm61OgE416Y+60j+rRhmWT/vjcZswGPMxl8d2b0yptBX
	O9/yFXnrpm2gO+XaKyKO8Jeyst83zMbk+t7BJszo33/DEbUtI+PdzPqFJOzpdiiB
	eox0Zhcpt7f3bN2zgXJOFHoJUQT+frTKHW8OU98ws7+8BqPxurn7hB25Vrb1HtxS
	3gH86dfQrx69T5uuOU8mYUJUD+xiWHWldqC2X7Ft3vi/+ue0i5YJm+1qYWh5Trwc
	xEOPsuzGMmT950HfPyYCPMaNNllaT2mwbRXVSJtOwbUfb5blV5C37B+GB09YxI1L
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cw1h1f07n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 07:45:23 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62GBjM6w002663
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Mar 2026 07:45:22 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 16 Mar 2026 07:45:22 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 16 Mar 2026 07:45:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Mar 2026 07:45:22 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62GBj8Tb022982;
	Mon, 16 Mar 2026 07:45:11 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <cosmin.tanislav@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: iio: adc: ad4130: Document interrupts property
Date: Mon, 16 Mar 2026 08:45:06 -0300
Message-ID: <0db1d36106b052d8fbf5dbc8e936558fde87bdbb.1773311639.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1773311639.git.Jonathan.Santos@analog.com>
References: <cover.1773311639.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 57H7NwE_N-SNKMnRj5aGYP42GR6Ktfzf
X-Authority-Analysis: v=2.4 cv=FP8WBuos c=1 sm=1 tr=0 ts=69b7ed53 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=SOcA0PiadbpJRY9D2DkA:9
X-Proofpoint-GUID: 57H7NwE_N-SNKMnRj5aGYP42GR6Ktfzf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4OCBTYWx0ZWRfXx9pnbuKU0lhz
 HSzTeG+aXcVPsoWJ4yO0uci2rvugG3brT3zQve7+OBJbD0IDa/JcNJ2VOHG5EEoaDBvbhMl5oq1
 YWUfKgDDzySmBFHIGw+vZWfvjef2CSdoUf4V3ODJwwyp3J3Ui9gy6w6gWrJy66yxe2PenG0uXLd
 24UgUvSpvTX8TzA86cyJrzdLf+/2npCwffnlETHDuEHzzn5aBYvV4EcGA+dxh3UM9tcGG6zvPjp
 nxh4S0x9Xc9TWoJoDmdCVt2N3zsKJvdP/QwgdTXm5O7TpOGhOBd3W0mHqv2nvKySSkVFj21mUEr
 ws/mNxY+SjaoKMbtHFpt9QCBYFV/bwstb9Ynj8WNty8CUVNQzemeMXKAAgeui7BjseQiWf2uWpk
 Exks9G1/qWwJO3a8gJ6IxL0M0QP9EYTfUH6Hb5OOdefoBeBHq6oOLY6PgFv0vxtUs12bMmY/ocA
 YjR8czRvFJxuWiji75w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160088

the Data Ready/FIFO interrupt has a special behavior that inverts the
IRQ polarity when devices with FIFO support enter FIFO mode, while using
normal polarity for data ready.

Document the interrupts property to clarify this special behavior for
users.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v2:
* New patch.
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
index d00690a8d3fb..fcc00e5cfd54 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
@@ -32,6 +32,10 @@ properties:
 
   interrupts:
     maxItems: 1
+    description: |
+      Data Ready / FIFO interrupt. For devices with FIFO support, the
+      interrupt polarity specified here is inverted when the device enters
+      FIFO mode, and normal for data ready.
 
   interrupt-names:
     description: |
-- 
2.34.1

