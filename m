Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADC645519B;
	Wed,  5 Aug 2026 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931226; cv=none; b=c49d/JzN2wnuJ0patEX//Et95jT7rLnle83i7Zpq/CkOYTagRgmUy4kRByEQq2NEu7dOSeFUJoyGrvx8T0Pgu6PoH8LZjDQZeyMWSpd+0nS/noaIDl6ubNSCRMwGxYy79RKAJHF60KaZXJNn32hNBy+a7oe4DhiO+SEuMcuRto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931226; c=relaxed/simple;
	bh=GNtng8bIUm5Q0qN4UN3DqBbJPjm7S65TfkpaHJk08tI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGNZBjhYDvCL5W5SDqjMSV5UQRBIAazsslbyjjIpi7AiqN9emRach9BtED0bu9wQKeoqC1leYLJt6dptbFBWUMrQly6WRvgvjjJVPfTY5vsBPNzyiYy8s6LOV0OlcyCyz9DJV+oZbzSEQTH1WUULN/Aa8rP5PCZWyQtnOGEFL8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=l/BBoPN9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="l/BBoPN9"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675AG4Rc440628;
	Wed, 5 Aug 2026 08:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=i+3+Z
	r4+y2+7Pwr36QkN6x23c2z/uG2BAeFBM8n3tGc=; b=l/BBoPN9q7mOrfOsubMdd
	JGpc6R29k2tN6l2Ygq323L5pQ+y/8lyny3ue54axI2D1Va67kZg48rBoMuqVMfDb
	sh0GN+sFs+C0uYCNqyschKlkrU1x+DOjIC3yol3VeanY96GcnFyWgQy9Ic3g1eLb
	fPXPNy5GM0ESMGUcqRjsJU8lh+MCym/YalYDU7f0T91mIcd0OGW+PUNt5eFdSqFT
	eDcawiDmVTNHXL3Y+YUxtlChdDGp5qcVHPYZCbjLmUWRPFOW1WIKmn9KCPoMDz6k
	V3F6elNr798zKAUQkr1ohEQYUEiHHiHkX6V1l5gzG62b3zmr/W3mj6M/1Y3hijGZ
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fv397ga4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 08:00:21 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 675C0J4E016163
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Aug 2026 08:00:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 5 Aug
 2026 08:00:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 5 Aug 2026 08:00:19 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 675C049m000726;
	Wed, 5 Aug 2026 08:00:12 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav
	<cosmin.tanislav@analog.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/2] dt-bindings: iio: accel: adi,adxl367: add interrupt-names
Date: Wed, 5 Aug 2026 14:59:51 +0300
Message-ID: <20260805115952.33894-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805115952.33894-1-antoniu.miclaus@analog.com>
References: <20260805115952.33894-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: o_uVh1qMNVhR1M4HcPZ9lDUre49DETZ3
X-Proofpoint-ORIG-GUID: o_uVh1qMNVhR1M4HcPZ9lDUre49DETZ3
X-Authority-Analysis: v=2.4 cv=Qv5uG1yd c=1 sm=1 tr=0 ts=6a7325d5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=U76RtYCq33gtdKK1WSkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5NSBTYWx0ZWRfX+zUvVGx6QHmU
 Ad54fPOvWFGTASd1BbnoUhHg3VGmbUnLP1Bl88vkYH2EwIiv8bhyMloTuMNVzuQj3sEmlcyy8eU
 zCx5YWgJkODu1BEF/G4Z0ydoUZh0OcwSYLqMLCQvKNCEER+Cw657
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5NSBTYWx0ZWRfX6aQXVS2cDrfF
 ToSNaAEjksIsLmmH2IBiDBn24lufvLhRAaJjHSyC+2UqEUENLGr7DUZFJYkNeqwnwvfIN6HvRFV
 GGySymBQFayMjSmHOwoGP9a26vqKh9OpOyOw8KqbOK1Rr0whaN9JZt+5JYYDGPiHpn/+CYWgBd+
 sNDFC4uNTTYTt3Dp2cJplry2WDpZN4oal5MEq6JbUDQyg4Exs8J50Z/ZrlE1gK2UoSWALi6u50z
 HCFos8rjWLLag6X+GLX96DpMZkZdjcOFawR+Y0Mc8i9iETNJ+W8uzCDmE817kCvqv7BWAI61YN6
 P4AINse/qJMJ3Donavd5zBGN7a5luD7yfJRn9o3wGPRMm/RzuvDrqSOHicRNWzgjtVME8YMTbSH
 Dlz4pHJ37anOiFwN5ZJa0tHoaunbu+GXpAJZakzE8TBf5Zt32xFRhfY+LD8nnqIycFSi1GxzwS/
 FbqNA+yz85SN60KMFmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050095

The ADXL367 has two independent interrupt output pins, INT1 and INT2,
either of which may be wired to the host. Allow the interrupt line that
is connected to be described by adding an optional interrupt-names
property accepting "INT1" and/or "INT2", and permit a second interrupt
entry. interrupt-names is kept optional so existing device trees that
only specify a bare interrupts property remain valid.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../devicetree/bindings/iio/accel/adi,adxl367.yaml    | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
index f10d98d34cb8..c8df234e493f 100644
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

