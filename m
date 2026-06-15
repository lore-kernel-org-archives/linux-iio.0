Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A263B0AD1;
	Mon, 15 Jun 2026 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504481; cv=none; b=g5Vy7h8VR/AIVjm774m8fZkzSKLxcW1Lwuo33stW8wsxoaBa64zAoNwF3v4od/R7PvQdUCTVHK49RhWJ72zRHKcihsMOhYeQVMu7/Mc1Q2smh7F28DvPGzfKB8yOWZVMrrbFRlblVADOU/dXcM6bbZ+17YRcpNa4Af9YvBDKbJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504481; c=relaxed/simple;
	bh=ZJT8k8sTYcw12a8/QGx6AqB3YyQW9OhZG3vVqXikb8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JgDAh1WknM5eqOdSzMV6K+AO/UhReE4zBv6iFSwgP3nBOXVPd5Ws82jpHhFYEsWxU3cqCxxAi4dMXkX8I3DJPl3BTCjVN1VN0C7ojLbIKbssiOA2meKWnWVKt/9HY8sKfwkM/SOgQqIZhz6ENl4eWum4ajsqTVhO44jjaZp638o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KJCZiSWD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KJCZiSWD"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6J8mq498541;
	Mon, 15 Jun 2026 02:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=B0XBj
	J0GAG4gXYj0uw3iuMc3fhaduq4KOMj1gpOf6s8=; b=KJCZiSWDq7322aC1v2CST
	VsTZBGL5RLUc5IpkCNenFvulNVhjgv7c9AwtcH6ERqNcjtmUNWrn1OFvry0w3Keg
	zVKfo5oaRb92oWQfbJ2ZXSGrmIYiYljqwOK9eWN9z+sStX+Wtwuqt3fck57n379e
	msnNTMNEIQgNFS0Ii69z7fAp0DTdSDPdFDJanip8gWIKbctUymAkR2tMuEkc38re
	dPGYa9VFKIZloM6d5w/wN7xxUEGsKhNJ8bSsLer9iMKrXctUOQs8dBl6ZKmtjjIL
	DFOvzlLvbqoUz161aK+NqvvYcg4UA1G49QJHknUg0dRuRRdiYHM8cA9VflZfjbeN
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4es11xwm1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 02:21:16 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65F6LFfr020931
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jun 2026 02:21:15 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 15 Jun
 2026 02:21:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 15 Jun 2026 02:21:15 -0400
Received: from 10.32.22.147 ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65F6Kk5T014857;
	Mon, 15 Jun 2026 02:21:07 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 15 Jun 2026 14:20:17 +0800
Subject: [PATCH v2 3/4] dt-bindings: iio: dac: add support for
 AD3532R/AD3532
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260615-iio-ad3532r-support-v2-3-84a0af8b83fa@analog.com>
References: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
In-Reply-To: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781504447; l=2293;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=ZJT8k8sTYcw12a8/QGx6AqB3YyQW9OhZG3vVqXikb8w=;
 b=HkgpRKmnDSFLzlYk/m7rt9Q+5f8uTj1sOLmlxEhTVqTV+HfiJoYKZT3gpm/Lif3JSXkSp7Xh8
 hEHGsXjHS0IC3h1SnD2Ae79npTHSYBXrlxiSvX+MFmj2OHOEO5Y1jLK
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 8LqRgyDEfYyCE1a2YwkU8qmLlzdFWo4L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA2NCBTYWx0ZWRfX2/t5pUHoXuBo
 gMqZtXp8kAI481gwYNGswrK+kbH8sdkW2tknWnqZ/nYEuhFsk6inh9vsUjOtpz17XmS02RO8+Kf
 U1zFuGJr7e1y6V5QPUWMcexNtYR/jraiBnkCNJoePnydo7YAbGZY3EeeEcm7u8MwtDzXudW3DCZ
 fDZuwxWz7fcD9de8SCXfhYbxfamdhwZvMaZhToJG2wy660ZkpmyKCmLwjjerVfiOA5Nj6Era7GG
 /X7qLwwvuCHe/oWBTIijjbiG1TO+s9CNmpyj8hU9i6ivtfMIJb7CS1ihd143QLvQd4Da85LxvLo
 1LnQCE29r4Zc4lG7yZdoska4PNV4S85AaZLRmoG4s20Aid3VFFsH1JgfPrGGBQ2w4GcnbdiuLRV
 3HSR/kbTVYAexmlZWFqpjuzJN5U3vAAuW4OcTdaWJ0jlCW+9YjHcF6z/2h2qMN7JtG5NgSZ20hq
 TTKqHdqPi/eYyMa9zHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA2NCBTYWx0ZWRfXxw8o0CFEyRWU
 0zOSio61CM49KuWEvxoE4pSEUt4VYiu3LLUQIDPohoKk3wWAErKSE1sfmIQ+wayK4yKSyPCPDJ8
 K8xfYpRWzkrWDI/O5Qe5jiBcLkBcSDFT4hcH2EAjoYhUsgHMdpgj
X-Proofpoint-GUID: 8LqRgyDEfYyCE1a2YwkU8qmLlzdFWo4L
X-Authority-Analysis: v=2.4 cv=WuAb99fv c=1 sm=1 tr=0 ts=6a2f99dd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=XYAwZIGsAAAA:8 a=C9Di-RxILHxrQtiLBzUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150064

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

