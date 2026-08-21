Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64991385D7C;
	Fri, 21 Aug 2026 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787335702; cv=none; b=QIgEjkgsc9Xpu09P5HPqFmjfT3Re4nC/8AUaeUFmh2wg2INOTLcpjUYeMIe7LbO/WD3NiDWN/hzVP2SGqQBn2IXpdIqfSwR+FSUSJJs/4if1aYfhICu9LYRAcQyqKQMYw3aviAvEleWJBg0mPdVOJKQKK6WmUFGsyb3Zh4GGS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787335702; c=relaxed/simple;
	bh=JRjSw1kdqp2xwCqr/LtkoRliD0fWY/ue6H3WocayKTM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBW/ze6wyeZMXXuNlTpEfRYsdEdGHxD+KyT9llnDywY511/Q4zpJ8OqtP5YjOoE7eIEYnzD3SO3WrtSTK8rwcb2AF1y40WIsjwrFp9Is//IQG5H4dOBoJfzObxM55MW4DYNBW0G+o01aieZg6iCNoHQMViTs5M/zyiI0XRXYHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=beK6MxSw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="beK6MxSw"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LI4LnR3253769;
	Fri, 21 Aug 2026 14:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=bQOPf
	PBx3NOS2aZiLHAaDZR6MSk1q/uE00eNyXKtiio=; b=beK6MxSwES8jOSepTFWFE
	KHUeXuGid3xDqz7sn1ydPNos2CkNPTCTQMobB6uBWLSUml10UQ1p4LcphfxkXJt8
	827aO0InJJjTbaDfJMDsgZYwsgWnsMwJGECNlxDwy6Mg7b85htR/GeOTm1Nd7On6
	7bTPqiVsVFrr2VICEdJ0GPNVlE1gEP+v8+owziaD9hY48DzbIG60Y4PUp94H6pDF
	kXCQ739zdgsWi7XLI96VODDqbCfACnCRmTM3ps+lD9cuATBEoHbo1ha43uud3JA4
	IVh+0+nQCerww5RGXqTg3cGUX6BjejQcQiJDaXZmhxBltGPIteKv9/DbB4z3Cs9v
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g6rga8qsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:08:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67LI8HhX064943
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 14:08:17 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 14:08:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 14:08:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Aug 2026 14:08:17 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67LI80fM032181;
	Fri, 21 Aug 2026 14:08:10 -0400
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
Subject: [PATCH v3 2/4] dt-bindings: iio: accel: adi,adxl367: add interrupt-names
Date: Fri, 21 Aug 2026 21:07:51 +0300
Message-ID: <20260821180753.4633-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821180753.4633-1-antoniu.miclaus@analog.com>
References: <20260821180753.4633-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: uXxSJoW1mN_-qjEwUS6hqC4G-EAS0k2m
X-Proofpoint-GUID: uXxSJoW1mN_-qjEwUS6hqC4G-EAS0k2m
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE0MyBTYWx0ZWRfX0oOQwhjrpOV2
 OvKRcnDKBQNo/4KFBM4vZei2IQnVmPPew2ajLmo31q6FgpMWTMtqyQiUXhmcOSZLYNU8MhxNdiU
 eVPq+AF0naCSe2ZlnpFCofjGQ80CSI8tcJbXtMiN0cCniXK6hNfN
X-Authority-Analysis: v=2.4 cv=fcCdDUQF c=1 sm=1 tr=0 ts=6a889412 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=U76RtYCq33gtdKK1WSkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE0MyBTYWx0ZWRfX2logN3gij/TG
 sVLzv/dJfTRjHAAPkFTEwNUyaR6d6y/79DFQ/zoCp8LNskjt9PrfVSVfmjtNfPxFwaJeAExNfO+
 KhUzLLNN9aHi3sUn9FJ58ZXfX7IkNwSCFw/P1vr3cpTwY/AVu/4eV8y+zNWSzHvqKrLdsWzMwVJ
 H+55QChtIo8WrlpnHTQmGgv0rbmmA7kfmx8mPnmgqUUS/EYu17HTPF2Gr3eHu1sngCUkWIE7uw4
 Z5nd8VQCKWmvcF3SXhjkholUS4mAUbaXbP6UFYfi1pbvkJCvVEVvZflUTq1ycSuaDO6T07o2n4Y
 2N+EHqMyHpSZiNpD7DH8lTqdXE0b2x0p3rqgoF7aN9Hquyb2ZBziTQoI5/mU1jJoNRWxLYIn6uT
 XxvdKmzoxkYHsHRAGAnH1BTJBrrzaQIJMfXIgXIhaIgnWNAismAcnGH+ggis7lFJcqKmur0c+/o
 lnH7vPvczftrjNfbtGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210143

The ADXL367 has two independent interrupt output pins, INT1 and INT2,
either of which may be wired to the host. Allow the interrupt line that
is connected to be described by adding an optional interrupt-names
property accepting "INT1" and/or "INT2", and permit a second interrupt
entry. interrupt-names is kept optional so existing device trees that
only specify a bare interrupts property remain valid.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v3:
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

