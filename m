Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47EE3F8EA1;
	Mon, 29 Jun 2026 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725742; cv=none; b=jaYEPzdjjVMIwmibpOGiFI42wVN/JPvpmn8KfdYEE2vnOm3s+IibhibrDNhToGpNN64wBFEltQ+0buGs+q8DCtuUxpBH7MnQAOMVh+ID/4IIoe6z+7PfUERrktXHk29C8lITLZaDowsa5LOnzKEfUlCP0wBBhsxMqgFj1Z98DeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725742; c=relaxed/simple;
	bh=ZJT8k8sTYcw12a8/QGx6AqB3YyQW9OhZG3vVqXikb8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y5xl1eg+CudJ1DDuS6oAIzAcrV37TVcD0s3Hd2Ebg1EuHqkZ0dHQbITmrdTc+DGgOcPIU0Shhs6fGwyyWq2M7Tqfc1liMIONs6HuP5c/wmSs6/udji3dMxRybEqKx83ynHyLzE37oNPlvoQWIZBo9Njo4DR/yuSrssHpxIGYCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=f9Gj/2oF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="f9Gj/2oF"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6kGpY1423997;
	Mon, 29 Jun 2026 04:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=B0XBj
	J0GAG4gXYj0uw3iuMc3fhaduq4KOMj1gpOf6s8=; b=f9Gj/2oFMM8F0G6DWQ0u1
	PSCCXWqc8AIifRlSSEsauZgLbC+1+Lfd+vF8QGT+6cdYpzpy0KJKCX3lddlAfjbU
	U/hTHB4ICLt3A+LO/YnNr/qT5cODGr+i/62pPsjJCxRRx9XTVOKsO1Dx7tUrpa/Z
	hojeKtRV1bLipoD7Bqa93jXK+cM/t7yj8qqfX8uNFNVvL60ldrq1XzkHUS43t7Br
	S4rNNO9x2NO6jX5KBB7ooXubc1y2HqhzRkwWbU9P1GJqAcLAgU2xIgt7gbDHDJVA
	ZF4+L48BHtGyMBFhkGhpzE+WX88fFkQT8etYs/3zSszlE5UQyc9kAJQVpeCG0MJ0
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f3gypsagb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 04:31:45 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65T8Vi5E022792
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jun 2026 04:31:44 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 29 Jun 2026 04:31:44 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 29 Jun 2026 04:31:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 29 Jun 2026 04:31:44 -0400
Received: from 10.32.22.147 ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65T8VJkh012929;
	Mon, 29 Jun 2026 04:31:38 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 29 Jun 2026 16:31:06 +0800
Subject: [PATCH v3 3/4] dt-bindings: iio: dac: add support for
 AD3532R/AD3532
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260629-iio-ad3532r-support-v3-3-f6e4f4abebbe@analog.com>
References: <20260629-iio-ad3532r-support-v3-0-f6e4f4abebbe@analog.com>
In-Reply-To: <20260629-iio-ad3532r-support-v3-0-f6e4f4abebbe@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782721879; l=2293;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=ZJT8k8sTYcw12a8/QGx6AqB3YyQW9OhZG3vVqXikb8w=;
 b=SsSi98BLw57OzXvfAQDjZU8z0cXvOfWth40jmlJSxt6gbl+rLS1b62C1p007WYQ5oTwKotnFr
 CJEXS+0KvUoCw1Kyg7KjJMEEzkgBa6EW3KIKl7QQpN9bakDM7JbjQG+
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2NyBTYWx0ZWRfX2+er8mYrLqGC
 9aakmHUc5IOui02o6JXeHYe6B23AQHk6yREE24bSiA3P3Vse4F7SBB+B/MGodrSCv5+03CAiJNO
 F9j7IAyxz8fWd4F+rvwTbGr0x6Lld6yOEaJQHS+PRLO5XqJD/3l1955aRWsA+nqOt/02KH6IL0H
 +nfG3bY0hKR5fI/GGzH/Pzd36IFzIKLV8RWkAjuWCy+MlfmxVYkobHtylUhdHLPJ7JviGsRDy2P
 Wzi8ew8KgWB5zTFReOExTIzUx5y7eejMFBNI3HZ5RniaX36hrGwXFMvH+TFJgUDrNNY1kuvs/6w
 Ce6t8324ltvneBHyFHm4Kf0Unj+58T+C1WDNshKKpG/Ts4mziDFoIOv3+66sZAwRSgMQVPrqA8W
 WPRb8jhKpQr9/wVINJW7fhUVU4Yfl3dXore206to3t+1V5HSWCqP6EUgAa0rsX4bhdktFaIDBkb
 D+mLpRFT74j+FBtkWGQ==
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a422d71 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=XYAwZIGsAAAA:8 a=C9Di-RxILHxrQtiLBzUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: H-HG1KJhbN9iOIFpyPElFBjBIRw1e58_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2NyBTYWx0ZWRfX0p2qEf78ECAa
 MM+r8phcOTWxJtEPXp3sk1e7ErcNxO9nxVX+jkOG4j8+l2dq+WkHpWH5P0bayQjV6gKhK7zRZpT
 wObvKnw/8zyUb5E9ON3ImQHYiNx7NAoWerY97z9Hu2juQgNIL0YJ
X-Proofpoint-GUID: H-HG1KJhbN9iOIFpyPElFBjBIRw1e58_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290067

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

