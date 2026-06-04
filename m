Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F03DEFEA;
	Thu,  4 Jun 2026 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557269; cv=none; b=N9wEGPWZzCpj1Ad5NYX9e7ACK9fAXIXhb8FzWXPxV2SLfDi9cE3P6zOd7Wz2sRFuUTMCJGTrJAF7LwrXJE0rZfRGLPaSJNHsdkCVVNhhlovBbQadK5gwClaIBNFQDKU2Yu3qwSjue2uHFQ+pcPTfdyEVDu3QKvof5pTsxkJ10uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557269; c=relaxed/simple;
	bh=Eb1iukFKuV0ltKJJQaX4vYYVOHVvxbWSxmk3UqVl5fU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=R1nO0xJ3o8xoY9BNdZEd2X+zgfsKsVnaIFzvrZIqOJT2TZA1OEBiWBgXDX0sGHfkZRtzfTW5sHLnZWJfgecI5S7LHm88vMrZNFY3n+1+UKT4NOiCeOSTvhyMfrKkv3v/YrLQKYbn3SbDdPSIpgFOVHoRgQx0kgfKbvCZyTKMZu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=C+nFNtri; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="C+nFNtri"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65424RCG1176811;
	Thu, 4 Jun 2026 03:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=UFDny
	68HMnCvo+AZDAXemp69rG07/RWHwTa6JoqY3Z0=; b=C+nFNtrif0bwYvZ56IFO9
	lhQudO0IOTy3tfsr7FHfMKXYE8PtC2z2C4WNgJgpadNoJ7VMRwmOZGg3Pf2X+FRz
	KVr/d1ssn81LfA8rOoQUZNN1aXUJkg6IvMB/PQPGVzYn15ffRZuvmTrnQRduz68W
	ubYhzbkpxMkzMGCoJXF/rzJsBdEzIbYUooGUokc8krBmihmIq4iirs5OrJqrDPwc
	GOS/XTVT3tc6cqspu41BC9wjEgZUCdsPthtbjK4rnOMlMMJvpr8izjsvRSxmti+3
	oHP3bAN4j1AIWRnFfgyygRVJC7XdYIUkuQWSBA8B6Gq4ZldA/SpgQALMOSIsjRo4
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ej7emxmvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 03:14:25 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6547EOWK042117
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 03:14:24 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 4 Jun 2026 03:14:24 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 4 Jun 2026 03:14:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 4 Jun 2026 03:14:24 -0400
Received: from analog.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6547Dv9N020350;
	Thu, 4 Jun 2026 03:14:14 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Thu, 4 Jun 2026 15:13:44 +0800
Subject: [PATCH 2/3] dt-bindings: iio: dac: add support for AD3532R/AD3532
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260604-iio-ad3532r-support-v1-2-c3552f9031de@analog.com>
References: <20260604-iio-ad3532r-support-v1-0-c3552f9031de@analog.com>
In-Reply-To: <20260604-iio-ad3532r-support-v1-0-c3552f9031de@analog.com>
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
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780557237; l=2240;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=Eb1iukFKuV0ltKJJQaX4vYYVOHVvxbWSxmk3UqVl5fU=;
 b=cY8+QGXWEOzfxUsT+0ucMVhqtC14IwcEDXx/Ct+oqm2sVP6ckWkpgRhx9iKpg2rI9fQTK+dF7
 l22CJdImTC4BTFpLCozVd0hDodL5HcaPvb1t+vjzOBBm1x3DAJup3a+
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: xIEfY7OoJytp23qfcMxUjOoQaCvmhGwU
X-Authority-Analysis: v=2.4 cv=LsaiDHdc c=1 sm=1 tr=0 ts=6a2125d1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=C9Di-RxILHxrQtiLBzUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xIEfY7OoJytp23qfcMxUjOoQaCvmhGwU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA2OSBTYWx0ZWRfXxpyKACkSjPyV
 q2Wfddq8+8vjSoDehUFA2eAb69vCTsmfg/djn735DAQQi6prvqY82vkpz6BCoumUQDP07rluFT3
 kM31ZyONAaOii08/t43d6WgVzQtAew9wO3qoxsXYBwnauFwBzsQH5UvY5CUOjc4E26aJ0Po4IyH
 N+bZFaxeXlqUuslbvsQURwzeT7yVZrZ1jshnr0mhRyqeFHNhXRKZBuKyr+X+VsGimoWBrFNTVVg
 ypoBck+tW8vAGs1qualnzbIXfW3Yndt7FnEeCyoiLCUsYk7M0H6O7Qom+qxL7TkMw5M3hdXgpEN
 AF0MpsaQ83SZ6EKil1bVAqpdJ1A78ctfYkywUXMBJPEs112PLFvwzYIMOp9atYhRR1/qUgD0cHo
 RoZxJTg8ng1A7R+sGsYzQFBnJOtyuH0DfiK2e5t9nF5NDo4snYNO0ZiY32Wv3gupC1LuXzk+/5+
 VY8Lr9w33+oJyoOlluQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040069

The AD3532R/AD3532 is a 16-channel version of the AD3530R/AD3530.
This adds compatible strings for the AD3532R/AD3532.

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

