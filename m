Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB1E3B1ED1;
	Fri,  3 Jul 2026 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073459; cv=none; b=MVM0m5OueNk1h3Pz5U1YT2UNgWWTFTVKUHuSV7CoQCTE4cJf8Bup98eWyF2nVxfknvNdi14n1M47A22ZBEHYwKsxf5la3p2tRTVcm5GaYBR32vD4bg9lvVfKcS1bz+LxLxH9a0EiL1Hvj+L3Fz9FL2uo6OMNFlKwEdOPBhQF9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073459; c=relaxed/simple;
	bh=ZJT8k8sTYcw12a8/QGx6AqB3YyQW9OhZG3vVqXikb8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=R5uXfvqOT2y+ppiIN+PcwBjV9AZfx4nlAZc5IutyS2fNXGDUq31qU/iGqStIInHqMmoLxDZHzAq/NXqtynalUyBVdRU4xGr0OR73tV2C0q6uv+ErLaoT8CEY+K8crkqGF09xfiv04V9AUMc9UYOiQNeBnUXP8pOB9r/sIzBHqO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=x0E6AWpN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="x0E6AWpN"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635vrGT370725;
	Fri, 3 Jul 2026 06:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=B0XBj
	J0GAG4gXYj0uw3iuMc3fhaduq4KOMj1gpOf6s8=; b=x0E6AWpNqv72Uy+A+lLGH
	vRlrbCPzrcPE/3E9d7jwyYiPNZBj4uNq2DfQ+ZaK5m9iaq/LOHSqi3v0ndoO68WB
	0oYLIoaF/wuYsb6iZPTgzwGwccovWe99K1GmYjQTKz3TLHEQ9JtjBopppJqSGGWk
	p+fB7bARdhtIYYx1bDIikFhUrwj816X3LbQximJP0eqxmYssvN32u75tDFh6+qBm
	ZpriyTi3R3kCxiZLQ5YLZ7zAjSlfbCjeOQHzB6xahhq85DMrNcCgTawfEaOiBGly
	hajVrsCP7osYsNeFhaIy8QUn5LEwT7cmnsUXjGnEBkhW+aCJj5TYlDUmNug+GYVR
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f648x9qh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:10:47 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 663AAkDH011015
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 06:10:46 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 3 Jul 2026 06:10:46 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 3 Jul 2026 06:10:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 3 Jul 2026 06:10:46 -0400
Received: from analog.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 663AAOlG024695;
	Fri, 3 Jul 2026 06:10:38 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Fri, 3 Jul 2026 18:10:07 +0800
Subject: [PATCH v4 2/6] dt-bindings: iio: dac: add support for
 AD3532R/AD3532
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260703-iio-ad3532r-support-v4-2-69d9a336f4e8@analog.com>
References: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
In-Reply-To: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783073424; l=2293;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=ZJT8k8sTYcw12a8/QGx6AqB3YyQW9OhZG3vVqXikb8w=;
 b=IaHRgMY9rUM/C/FmqkXFd+FM5x0Y/lwT5g5bFe6VaITwAX22Vo9TpMViB8FXtEsowuA/Ediiw
 aXlv5E7QYzHD00SHlFIyxz4OsEqGmqZ6Db9zMH4Ceu5r9SKD+fMnObt
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: GRTwQm6gXYzriJsINyEio0oSb19zqOKq
X-Proofpoint-GUID: GRTwQm6gXYzriJsINyEio0oSb19zqOKq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfXxQ1wYqPaWBxF
 XBfbkgOF7XGleL2guDObuxHhI/SgE6GiX8xjpJJJVDqVwDrPep72KvN9Xivdy7UBp+5JaUxxSTf
 xpMarX9elhE+4kaAFevSy8b3ksHRBNJNGJ/rxQjGF/v/I37odDQQRx+Mb3bK/rNZ5IwbecwTfsj
 MrSwLewFjx7GBt/TqhA3lCm8ZFKNGx9reOYEDpLK+gJmCBNqQ2bROymAP8rYpb1yXaya2/ZG9uo
 Y2ChF4UQF5zz3Otef7b7Od23p3tvo+TEmEZRZI7fOk+f3KnMCTJY2HjzSRZeGqc4kMvaLvZafLU
 zWc9BqsqODl6bWau/mHXtl/FwpL4Vbkz3T6kx/QgZj9ukCGDLWVMthGD+05AOD9Tx55k4X8tieB
 uZ7v+uNEoon3wmHicmsIiJ7NgAybwGDRHys/AZfekYXxsCkoUjyqwr1Dd/PKDYwy53xAdi2c7Vz
 IoqXg/z9jinqq6a5YyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfX3B+iL6ieNbYh
 O/kaG8VxQ1wZFgOZVNI4oz8H4CXfIK1n1OHs5+zhZY8BIrAtllDGfieqH8YQUZsmogcfcz1pEzQ
 6k6vhEdaPpucegD/JESb/NOTh42qXEeiMNRFsAD0QHgdjPerhujm
X-Authority-Analysis: v=2.4 cv=Au3eGu9P c=1 sm=1 tr=0 ts=6a478aa8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=XYAwZIGsAAAA:8 a=C9Di-RxILHxrQtiLBzUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030098

The AD3532R/AD3532 is a 16-channel version of the AD3530R/AD3530.
This adds compatible strings for the AD3532R/AD3532.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad3530r.yaml         | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
index a355d52a9d64..2fe098619772 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
@@ -10,15 +10,17 @@ maintainers:
   - Kim Seer Paller <kimseer.paller@analog.com>
 
 description: |
-  The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are low-power,
-  16-bit, buffered voltage output digital-to-analog converters (DACs) with
-  software-programmable gain controls, providing full-scale output spans of 2.5V
-  or 5V for reference voltages of 2.5V. These devices operate from a single 2.7V
-  to 5.5V supply and are guaranteed monotonic by design. The "R" variants
-  include a 2.5V, 5ppm/°C internal reference, which is disabled by default.
+  The AD3530/AD3530R (8-channel), AD3531/AD3531R (4-channel), and AD3532/AD3532R
+  (16-channel) are low-power, 16-bit, buffered voltage output digital-to-analog
+  converters (DACs) with software-programmable gain controls, providing
+  full-scale output spans of 2.5V or 5V for reference voltages of 2.5V. These
+  devices operate from a single 2.7V to 5.5V supply and are guaranteed monotonic
+  by design. The "R" variants include a 2.5V, 5ppm/°C internal reference, which
+  is disabled by default.
   Datasheet can be found here:
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad3530_ad530r.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad3531-ad3531r.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad3532r.pdf
 
 properties:
   compatible:
@@ -27,6 +29,8 @@ properties:
       - adi,ad3530r
       - adi,ad3531
       - adi,ad3531r
+      - adi,ad3532
+      - adi,ad3532r
 
   reg:
     maxItems: 1

-- 
2.34.1

