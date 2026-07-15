Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15A448D0C;
	Wed, 15 Jul 2026 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115725; cv=none; b=W5H6/XtZKC8IoqO0erezwwbiurgKm+d1/XgjWD6nwDBptGA+l07K+ZqKNud4E7jDGMkf7k97US3iDWNSL0Y0JD1zCg57OwB9UzHz3ED5XSE6Fy6Vqq6S+487TUXPf6pTnTxXMDVHwdR0S9FBzFm0lpSrWIXC+0sTyu+XFGAXnw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115725; c=relaxed/simple;
	bh=g6tSMXc87C+we0pe8dZPWouDPNd4olCD0jQjEU8Tlsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FzGllF+ITHD3fjm8+zHZyxmbMfvt+j/OBtx6ObBgPMXHwteihfsUPcLntmzWKCkeJ2IrAHIyEK76YM67oB4LpEnBAfxp5176oQCxg8q19Adh40dkUHnlQCy2NkxqAEp0PWJhGaE/aRhClqEupbnYkdzMb5LonV4+YIJtuW2CLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cSDfRY7e; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cSDfRY7e"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBZxXm536418;
	Wed, 15 Jul 2026 07:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7Y5zn
	ezsI3qhTRQrY0bv7fp81tiigWDCSf7BU71yTEE=; b=cSDfRY7elaa+PFUYY1KfE
	SR65Y10R7lNVSIG+ADpwTusYCcJ7F1FjmaCMM9u07ctgnSzSK6kaJcex+Qkq3lRb
	TeL0kQfE3+tZZWBXIMIqZWpHxA/hYt94QH64ZAEFaTh/veQvnzFt4o/yPjybAYq5
	o7ScoOVQUjKbATRLvp5E7wzLOzZ+m4RfEPLAoFjcIcOb7CcoOHG1mZc8/6xrnje2
	A7CSFXyAD3UbFTd19D+marsvEi88ULvzHWhKw55hSJbCz9+Lse6XFQK+YEt38rOG
	4eOiE7yI6WMas8vwaYiyvicH1MoIi4oSmDQB77IflYwptfehxBNfdgZ2z4qaeIT8
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fe88188f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 07:41:42 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66FBfe06004906
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Jul 2026 07:41:41 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 15 Jul 2026 07:41:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 15 Jul 2026 07:41:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 15 Jul 2026 07:41:40 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.54])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66FBfASs024964;
	Wed, 15 Jul 2026 07:41:31 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 15 Jul 2026 13:41:06 +0200
Subject: [PATCH v6 3/5] dt-bindings: iio: adc: microchip,mcp3911: Add
 spi-device-addr
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260715-ad5529r-driver-v6-3-cfdf8b9f5ee3@analog.com>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
In-Reply-To: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784115670; l=1246;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=g6tSMXc87C+we0pe8dZPWouDPNd4olCD0jQjEU8Tlsw=;
 b=rPp261PBgrzUJRflDiNds5MEIIYm5n5oK2QK/C8ACSN/XclCIna++KiC1X5Wu6fhw+m3Jp3DH
 mFfTojrIP5mBst8KNULKb9segimMxAX2NhWv8tvNVkTtEVkZxKFiUgo
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDExNCBTYWx0ZWRfX2PmPGTEy4t4n
 p6vI+5Tbla0Owthu2ugKmJtVtgTAWu0rpoS5Pv8sj1HIloYYjYV0R3P40NqFGjzTpXf2qLFWI//
 RZC7KPnfup9UtXAsYoujGKSj7KvBoSM1FtG/grCqlQyIMJjR5me+njQ2GjOXwItn/4KDW+sWsQd
 4Ece9koVZA4Qof5Y1a29+b8P67v3ivHsjduC7xeP6bSelwnBRvpwdeZdXWgK2XwBdVWrH0WfIrP
 XBaieSSKEO8g8dcQGBMjtfiinKwEX9jvtGYNH65yrHnOXy0wxcQMQzitgatHExjRwzExTLYQlli
 pIqXN5DJ/BtxIqjZbk6RWB0yO4cwXK5lpUb5q0M8tQQcgt2MQWMBrJWJ/4Pxcvjrl6alJv2/Jul
 /RZoS1dj2yZexErdsXHz26snl6/0Fgy0A7J2E+OQnJr/a42O3iqIEOCvP32IFWSID8UVcP3FIUv
 NEq14rYID42UKasI5MA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDExNCBTYWx0ZWRfXydEAzuRq2kjU
 rfsy9gjvu21UxqPOOKl2c+ChP8Ucbcm1aMolxJHYSTZWE62GJD/0dSghEeMYa/Hz87W9kJ/56ES
 VSd2R6azf9BzKGETNSW7vyWUzh9jGXaz9XsbsZWzVMFSNbFfDC4k
X-Authority-Analysis: v=2.4 cv=Qo1uG1yd c=1 sm=1 tr=0 ts=6a5771f6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=_zurbiuhYZgUpLYblJMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: j2hOZBUh_lA0mxZMIn7ePWxvjBMOnlaF
X-Proofpoint-ORIG-GUID: j2hOZBUh_lA0mxZMIn7ePWxvjBMOnlaF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150114

Add the generic spi-device-addr property to the binding and deprecate
the existing vendor specific microchip,device-addr property

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
index 3a69ec60edb9..4a60df06bd35 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -57,6 +57,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2, 3]
     default: 0
+    deprecated: true
+
+  spi-device-addr:
+    maxItems: 1
+    items:
+      enum: [0, 1, 2, 3]
 
   vref-supply:
     description: |
@@ -86,7 +92,7 @@ examples:
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

