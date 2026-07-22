Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9F47604D;
	Wed, 22 Jul 2026 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706913; cv=none; b=qxbwhXk3ZIpdLoRNt4I079OcsukcfWL/VIZ/TmOiroDXQUn0btOx2akH6mzELablrUTGgbeyuPOmcguit8T+oh3UB0c+nMp6YEPFdH4/MX126D78gQqz7cq3dicOwKRSPPJbMXj6f6AQiL6LKBumtpn75OC6M/nG9+KEXqPnrCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706913; c=relaxed/simple;
	bh=01OwEU7iwh9LmrTcefYLO8Fgd2mi3ddsAkqa/8h6yXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BUmXXz4QbgIctyh0asWBn0Orf8+AggY3zzP6iKTtf3rhDuqiXJvhzX8+18S5urcuK0kjpp/F9cXJLBZmcKos6kDn2WV7F3VKC4l/+au4A/xwNBydbRlmimi1JxAJkCV3obhY4hV4DWjyj3SiRAy1mYtOK1hlCdsaI7VwHcko2Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cIXzB+Lb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cIXzB+Lb"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M54nGi2558624;
	Wed, 22 Jul 2026 03:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lFk6e
	fd68CS71oU5nCcZyYWFou3T3/WGMnl3Y/Ihi9k=; b=cIXzB+Lbyp9RrFGVrp+no
	Q+BJm/wRc/PO4gkIboSTHW6YO9arEkr7NxmxqloIne2KXn4/tvDNDwlBIuaWNQ5F
	mzE2LmMIHMn7K+yf5+sqXR9gQNudvbHdb05eU+18QpEQ0CH/H6Q8p1OdEoCwuVVs
	PbDseX3BU29ocJk4FHrmowoByyvI8p3fcpg3coEntuSvKHW0Wfejj7RhXwoEFCrP
	/pV6WvJasL/ojd0exnF3Sy5r3G0bWsZZLokKRqyLzEz5oUCBDgEPjgzwEKVsXILi
	jUF2SdAeUYMoI6T0MVRvq/C7xv+3uns77P9+MbHyXS1T1OB2bVU6xOhwsuDu5ye8
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fjnd9h11r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 03:54:52 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66M7spaJ060603
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Jul 2026 03:54:51 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 22 Jul 2026 03:54:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 22 Jul 2026 03:54:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 22 Jul 2026 03:54:51 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66M7sK4n006639;
	Wed, 22 Jul 2026 03:54:41 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 22 Jul 2026 09:54:14 +0200
Subject: [PATCH v7 2/7] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784706860; l=1717;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=01OwEU7iwh9LmrTcefYLO8Fgd2mi3ddsAkqa/8h6yXk=;
 b=glCZ9pBHhs4yOtsZYeKItkGr3ganFgrtAiOMDnPtNb7u7RFVV73udyzJzhI2Nd6vNyvx5kGCW
 XkDCEgiXc3/B0imE1Oi/Dh5XQ6Nl0EES6PDC4qeeDC6SX1lXkpOqaXG
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: dcYVGKS4TuuymdTLFWdfvRSqBMDdx2_M
X-Proofpoint-GUID: dcYVGKS4TuuymdTLFWdfvRSqBMDdx2_M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MiBTYWx0ZWRfX/OPfSnIx0tQs
 DABFej3Rb6Wug3eHr1YEziojbTYAUi/qlc1vjyLzRUyCA1kvClN5DkQNMNetc1Uaal8unQxBQwG
 vQy714sAs8nnHMdLvrigS1JBW8QGDWGT+T0Xnscb4tBarKJx6jIrReHLoQA+MB0Uro1NPQPuC0e
 GwU0CTCzYniukMybwPfNaqCmXli+FFsLiNMDf1D93J7W/yz6zS3mCYK2nsVo59cpTnxdJQ0BjXO
 4AIF32RwNZ9L+wF0W131ONw76MGiDl9dRk4AXDK+jZpIGatQIUWgi91lyQhDYqExqxIrkketulk
 2jSWxCMcoU7WNCvAG1EFnPVRQh5Sfo/YkjH2h03uLwEcSingydenELSoOi2u9vg0I2PiJ3eD6g6
 sDu2aLohWCbQbb/wj3V0/Uy2PvVzctMRrb6BAHcp4MrWWrJ4B54tv+woRQi+so3piByIDkisyru
 7ognhQ9dVqZ0o94tIXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MiBTYWx0ZWRfX40oeSpNOUVmO
 401TWvn9lIURhSn4wWiHNiaIbLithABc/flJemGid6WBZgYUsseDnG9+zLHS5NdeRZVPQ2urIX+
 G1tYybwqC+v3UgRXaMU6RxEOw6vJu4lgk3FHC4z4fMnmkH/MayVb
X-Authority-Analysis: v=2.4 cv=BYHoFLt2 c=1 sm=1 tr=0 ts=6a60774c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=x4a6AN7Hyicx1yu3BJYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220072

Add the generic spi-device-addr property to the binding and deprecate
the existing vendor specific microchip,hw-device-address property.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 .../devicetree/bindings/iio/adc/microchip,mcp3564.yaml         | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
index 675319276197..de1ea289e7f5 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
@@ -80,6 +80,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 3
+    deprecated: true
     description:
       The address is set on a per-device basis by fuses in the factory,
       configured on request. If not requested, the fuses are set for 0x1.
@@ -91,6 +92,12 @@ properties:
       clocking of the device address (BITS[7:6] - top two bits of COMMAND BYTE
       which is first one on the wire).
 
+  spi-device-addr:
+    maxItems: 1
+    items:
+      enum: [0, 1, 2, 3]
+    default: [1]
+
   "#io-channel-cells":
     const: 1
 
@@ -123,7 +130,6 @@ dependencies:
 required:
   - compatible
   - reg
-  - microchip,hw-device-address
   - spi-max-frequency
 
 allOf:
@@ -159,7 +165,7 @@ examples:
             spi-cpha;
             spi-cpol;
             spi-max-frequency = <10000000>;
-            microchip,hw-device-address = <1>;
+            spi-device-addr = <1>;
 
             #address-cells = <1>;
             #size-cells = <0>;

-- 
2.43.0

