Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29893D75DE;
	Mon, 31 Aug 2026 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165139; cv=none; b=ScIrQrKYhzWglgvzhq0REAYDA9PZLuaDx39pFGJMpBh/f0LHRI9Q/EtThImQWQbLCDXAbKNuhLE/eZVXf2H4Ik5KGIJYqOgTI/7PtLf4yo1Q+COC5Tbtib4KyvctNKtfQjr1FGbRithYfC0Yph5sUktmaaLUeHOdIgGiTURn5No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165139; c=relaxed/simple;
	bh=8chXnPTh+YYN3UnADczBjsuEGQesOWKAnbBAlyZdv3A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTQG2X/qblInT1iBw8yETSjVXX0Of6Oqf+lcBNFTsCG0/G2anMrZ4jn2kLMMBdleRi4tVnEEGndjQeLEXKkYUtl+L3LN79+bF69AtNEv3bsrWwiDCP849YKDsKCmrRGsSZHNjwbBgpWv0ioJEG4LCgHuf+UV71shmvucKGGJ5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AaBdilT5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AaBdilT5"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82Vqe627921;
	Mon, 31 Aug 2026 04:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=UO72W
	HAYcAB60qLu7mcZziCXvA31dDax0umZEkb8WiU=; b=AaBdilT5dd8xQrv0J8J28
	+Jsi8tfk8q16suSGxmhtojL+uL9z+ehf5evzt4s0yaLm72X95NGwfaijpaExNeLq
	A2UoPi+pvDnuFVx7VggZZWriTPdKOL1w0Y+gyyqKXY3xmoygWWbzK7c3WsL+0hhS
	ZqaADGmNEhrQtwXNvrAFFe77NFmUulMLDS9qkmOlWxjqagg1IKuAcepie3Q+IUYu
	mJuDR/QlFmOrQGdXf9le6HAmBfat6BrWJ+WGI+/DKwNvGQ81djSp1BOjJz1dQIBn
	EsysyZBSnqFwLqF82u+c25rP44Fhkqzxjl9pZnur13vgSrNn+++57SavhnTWGBPL
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbvb2pky3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 04:31:50 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67V8VnI6012506
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 04:31:49 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 31 Aug 2026 04:31:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 31 Aug 2026 04:31:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 31 Aug 2026 04:31:49 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.222])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67V8VVah006721;
	Mon, 31 Aug 2026 04:31:43 -0400
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
Subject: [PATCH v4 2/4] dt-bindings: iio: accel: adi,adxl367: add interrupt-names
Date: Mon, 31 Aug 2026 11:31:20 +0300
Message-ID: <20260831083122.3486-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831083122.3486-1-antoniu.miclaus@analog.com>
References: <20260831083122.3486-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MiBTYWx0ZWRfX7ryaDjOtsh+w
 wun+FSaa2GIOigZScvsW76q1jfdk6ajqFcqoK9qOz0TnmSVfc2gG+joQ1Dk7La8N7tcdw4MHcfY
 xz4C9Xx+1qZGbI7eZ8bAU2LMrab5FjbIX7ZtjLKfOgYF6DBoGQCu
X-Authority-Analysis: v=2.4 cv=QopuG1yd c=1 sm=1 tr=0 ts=6a953bf7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=U76RtYCq33gtdKK1WSkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MiBTYWx0ZWRfXzJ17+HZdMPO8
 vAW6P3rc/63lgab/r1cJr+AvOxNuFxFOf4L/bRNDBRpsqkbD7s6PlvGI8gGnE+aBc1Tyl67Y1/X
 9fwas9A83zZf7nj42l8K0Q0lQI/DY4It7OVDE8dCX41Hd6z3b4+twevxem7fPcR6H6LmDjRgBvF
 OXAEwGLAWgUTELy2g487K52Ey1KkE45i1w32LTABpIJTVsVNid3y9/T6Qj4QUSFo4SAkD5nGnvy
 NgJtGqYR4A64KPWo1KY0Bjqya/9/zgjuW+CfDM3ywlRbT5Ga+btdtqlr+7xkWxuT/WG/BWuTrp/
 paF3THeWbW5ElBPcOgxjGC4kyZX5iPiCsNv49WvqB/R9LXXnRkbdJP74r8rUmeSfqHDhm53W9vi
 n4IdUro717Fgaoi8LzsseibEmuV1zX71w+RLMLYlapyXa66ZMTKl2HQt+hxk1Xx4DaeSzCjVOiY
 l9fN7HOusRVqSMA9PBA==
X-Proofpoint-GUID: -ifo6E11ZO_V6yzwXG0wBndTJNt4SIGh
X-Proofpoint-ORIG-GUID: -ifo6E11ZO_V6yzwXG0wBndTJNt4SIGh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310072

The ADXL367 has two independent interrupt output pins, INT1 and INT2,
either of which may be wired to the host. Allow the interrupt line that
is connected to be described by adding an optional interrupt-names
property accepting "INT1" and/or "INT2", and permit a second interrupt
entry. interrupt-names is kept optional so existing device trees that
only specify a bare interrupts property remain valid.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v4:
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

