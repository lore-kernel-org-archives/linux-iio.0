Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0221473C89;
	Wed, 22 Jul 2026 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706923; cv=none; b=Q06iz1t/e8iCN6nXuLFmEx+vq0VJhREMTP4cF8pI98vh1YI+bX6ytNZFnpFxLE3mr61QiOkKhxqn8cSIMULmCV9Ofy+xuar+/1qzbIXFd6iTNQqVV9OaTdjhmyQzWlihzrseC4RE7qbC639y9xPhyQYQionWNQBTsMDREtY0Ac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706923; c=relaxed/simple;
	bh=6SThVgX4cELtGIXzEvyiaRaJ46gF09srqrwoK/+Hm/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ky5zKQdaWQef+K9K7efWBMyQh0pcAkgUN0mq5YYoE0ePnjXK7E9S1JGnytyOHl2TCTBHNguUFpVUUZSUPOsdXqJg90rg+YH0nxbepaJNSqKu6QmJquod8H0JTBXH0HoBFer7tR3O4ENuI6xvP5dUbbn2oNs13loEwQZYcoksVyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=w46S2Bm6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="w46S2Bm6"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M54fNT2558577;
	Wed, 22 Jul 2026 03:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4uhnb
	pr8JkwMdvCWUGhF8kPV0gZ/mgVoTvaq/P2y/vI=; b=w46S2Bm6hfVu3XKWzUU9x
	iNaxEKwzIc8UE8ID48sEWDrwYBZX20W8j5RWFD3IimHm4YDpunRK4p7LQL1iMPAt
	2A55FiF7SYomt36FyUC0X1VVC2SEXszSL507ztpGOJKDeK0aS6tDKL5rGE6j4M9f
	aUh2g7jcWXuExc4H9YAjflMeXMtWenawjH8vQpV1+ERSI/nDzC06Xj/9NtWtSTCn
	vLS31sCamoy8IqmU+aJwhfm2wrQytoCDGtMt8bIYlbk1YhbF15Tbm15PWFWc0Zp2
	dlxRLeH+m7osuWfyGAanEI9o71QJ2dMRf96VLIUZL8KTfPuDVdHxcVHXcf1KIpsd
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fjnd9h125-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 03:55:02 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66M7t140060615
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Jul 2026 03:55:01 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 22 Jul 2026 03:55:01 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 22 Jul 2026 03:55:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 22 Jul 2026 03:55:01 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66M7sK4p006639;
	Wed, 22 Jul 2026 03:54:48 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 22 Jul 2026 09:54:16 +0200
Subject: [PATCH v7 4/7] dt-bindings: iio: adc: microchip,mcp3911: Add
 spi-device-addr
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260722-ad5529r-driver-v7-4-7781cd74ad75@analog.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
In-Reply-To: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown
	<broonie@kernel.org>,
        Marius Cristea <marius.cristea@microchip.com>,
        "Marcus
 Folkesson" <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784706860; l=1266;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=6SThVgX4cELtGIXzEvyiaRaJ46gF09srqrwoK/+Hm/Y=;
 b=v+akUXjl6JGUZMn/HW4cTvpEckDo7DQ2HVQvMKTxFJwA8/fKEsuW+mFdnJ+F1MFrasnSOGogt
 9qABqrJpVVGAusGnJwGKjbJN6NYYcSdWWdTB06+zvCHu7YQgWlk6BSV
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: -Hjt0u69kWQOI5oKkbR1rjyveaG4LJdd
X-Proofpoint-GUID: -Hjt0u69kWQOI5oKkbR1rjyveaG4LJdd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MiBTYWx0ZWRfXwQ2CJGFcqYe6
 GBbq7/aArt3fmFJnUVfp0qoJ4T+zPaPErRa4ba2jN6Ac2SsSsdfhomMz16c1lDo+a4eM5OlVPPp
 4+NGw/Dbn8eckOTAVk+MTjE90ptVu0cIOIK0s2dA/UfkQy59seAJSUjqGKLnAABdxBTPAQSQOWF
 8bHfXIdvvoSjOPQ2OWG2dc+w+jhid50Bj/S6Vmg4JLRA9K560TTHdYPTb+6LowiDBP+NfCgsPQM
 K33KbPgBu99lOMiHA3oD64bxDy7XFY/U5Ssc+C5q4TY9+Caslt4Um/txkRVtiD7fPZntigdWOQF
 yO/my7/eJQ3bptQQ9DP+4fHQkOZQjQlhfOxgZbY73NedmVQ55/xyMZ3slhqCNpoH6rjPBP5L5gj
 XSEiF7Rn4AfiLjkENCemHFm83Yj2R0E2uKxvMQAjW5pUBE+7jltWgmyd8+lqSwD0/DR1ue7+6FE
 WVo6DQANRDY7MqQ0jPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MiBTYWx0ZWRfXxWawdU8NshZD
 R7KQovrwdVloZ4Bta49YEtP990INcf1Pbaajphm49J24zbBgmgx13lg9Spevqx5SDRUKKwzu6C+
 ji4OUmHzJikzgtEpQDvBbIMjWLkq2AeIOuRHCqwrbzwKdkmHZRU+
X-Authority-Analysis: v=2.4 cv=BYHoFLt2 c=1 sm=1 tr=0 ts=6a607756 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=Hq6C2k6UPsVRSEkv5gcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220072

Add the generic spi-device-addr property to the binding and deprecate
the existing vendor specific microchip,device-addr property

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
index 3a69ec60edb9..36da2bee1db2 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -57,6 +57,13 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2, 3]
     default: 0
+    deprecated: true
+
+  spi-device-addr:
+    maxItems: 1
+    items:
+      enum: [0, 1, 2, 3]
+    default: [0]
 
   vref-supply:
     description: |
@@ -86,7 +93,7 @@ examples:
         interrupts = <15 2>;
         reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
         spi-max-frequency = <20000000>;
-        microchip,device-addr = <0>;
+        spi-device-addr = <0>;
         vref-supply = <&vref_reg>;
         clocks = <&xtal>;
       };

-- 
2.43.0

