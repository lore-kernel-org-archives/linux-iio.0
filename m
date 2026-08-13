Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DF442B3E;
	Thu, 13 Aug 2026 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608949; cv=none; b=Iu9zyGDw/hY+78T7ZR3N+GyCgns3UdLeXRG04x8zyhParF+OfNPNxwMlyw/bfeV0EAqhEtgFEHQq+1PJw6LsFxxbwI40xE817fNLUIbUCs3H8stH8sHAiM7oAA/d2cdWUCInYNkn5FfRoz/Dcfji7NmTjM4Ry29lX3u0/GZpPCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608949; c=relaxed/simple;
	bh=i23FNz7KjfT5ejx3CQ4GaR7sEYCMF/w0t/PHmyeTsH0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXoSKM3Uhn8cZjwec0fddgYIoF4z0bz6fRUCN8NbosnTETT+EFZ1B650P13UxSEBW2vpVia7Z31QUGZv49UcrIlc4Xb55p0+aO+Y8a3CUqqO9pLQ93jkiL/bCwx8XUsNRy7Bm9RRBpwRYKrlf6F3mPca8uL3Y84uUBcWmeISWgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=V0h/hyCP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="V0h/hyCP"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D7pCpA1789733;
	Thu, 13 Aug 2026 04:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tcP+h
	+jG5xoo+P4azpMCv6R5WEg/Xi7GsJUWloPp1Ic=; b=V0h/hyCPmMrfKOQfHWGct
	jIMvcIKXM/fJJPfMTr2/YuaPoiwdWamsPCZcgPF32hmnPbqcI74y0mAfmAMM+46/
	F8+7Ls5gulU/Y8tv3JVWpJEhMG1701vtt/TQtAWoj2bV/4zkaRm/xSJZrqYJ5iF3
	dO11dqi2ZW0xYEvkbgln9qXxoFeXOZ47gsCwHGWxLqyKYP4LhRSsDKvYbJ9fkaBC
	8ifYCuGvfBsgy7CJLkiqFTXKtSiCeK5Bi5X+N1WFrFTP/yIEZPERujwGdJTE9iZv
	R1kbJDOurkxEQlkyndIM+/w3mWfB9vaFWZpBQJkz4uaZPbMoQG5UoY4iK2loNqpx
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g19w9g5rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 04:15:26 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67D8FPUT000809
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 04:15:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 13 Aug
 2026 04:15:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 04:15:25 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.182])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67D8FAru008160;
	Thu, 13 Aug 2026 04:15:18 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: iio: accel: adi,adxl367: add interrupt-names
Date: Thu, 13 Aug 2026 11:14:51 +0300
Message-ID: <20260813081452.4289-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813081452.4289-1-antoniu.miclaus@analog.com>
References: <20260813081452.4289-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1NiBTYWx0ZWRfX3xwSP5+sFJLn
 /48Z1/8oFqut3eL192AQPrgBS++4+Qn93XuTkD1GQ9OWgkatyLojHflVr4L7gbIxlViIv1L6pZf
 v70FoOc+pMbicgL9jCggp4H33j6PURWvFoJBLaqS7xRF3cEFUJSkOn1xhk0wOmFfA/wr3/VUyr3
 LBpbf5e3dnXmSyiTtF0vt/bviHrrTpiLMFb3v9gRgULxRJmK1y987xA/l5v5KHzpy6O31jnvTw8
 bMKSLuDaCjC5LYUA/E49+f+2Np7d8E7338R/p350y0hpzmStIcJllO6O43kzEeCLDY3bVUiIPwR
 s4XrlIslaJrTp5Kp+2APe47EfIYgKFsFduUvRcBpvbbNq+/vnUcDQ4w+e9QVedI7krELWAA6kTd
 4z8HRE7W4MOlSisEwOGrXEv+Bla0QVo5eOQ8W8z65S05d/vu7R8XNYiICBVI/msn/DIxMP/UEfu
 lZIX1b5+ovElAJs7eWw==
X-Proofpoint-GUID: IDP4feB5rzfGsGMU-a1hhHc4oYNtSRod
X-Proofpoint-ORIG-GUID: IDP4feB5rzfGsGMU-a1hhHc4oYNtSRod
X-Authority-Analysis: v=2.4 cv=f/R4wuyM c=1 sm=1 tr=0 ts=6a7d7d1e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=U76RtYCq33gtdKK1WSkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1NiBTYWx0ZWRfX5P8Z0mPVD+OC
 yHA573cdhg31v5yJ9MMd1mLDhrywfNM08bFGW9b1Tu0czAyqnHF5TWdNVJN8MF0U2yiJRwiKGqN
 X77C1aFTTpmMYj9zl41qfGK79+QruS2CYII9Fpr+ZhlJn+HC78nK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130056

The ADXL367 has two independent interrupt output pins, INT1 and INT2,
either of which may be wired to the host. Allow the interrupt line that
is connected to be described by adding an optional interrupt-names
property accepting "INT1" and/or "INT2", and permit a second interrupt
entry. interrupt-names is kept optional so existing device trees that
only specify a bare interrupts property remain valid.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v2:
- No changes.

 .../devicetree/bindings/iio/accel/adi,adxl367.yaml    | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
index 29689bc38b90..115170eac058 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
@@ -33,7 +33,14 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - enum: [INT1, INT2]
+      - const: INT2
 
   vdd-supply: true
   vddio-supply: true
@@ -61,6 +68,7 @@ examples:
         reg = <0x53>;
         interrupt-parent = <&gpio>;
         interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "INT1";
       };
     };
   - |
@@ -76,5 +84,6 @@ examples:
         spi-max-frequency = <1000000>;
         interrupt-parent = <&gpio>;
         interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "INT1";
       };
     };
-- 
2.43.0

