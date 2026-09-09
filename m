Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375C3A7F49;
	Wed,  9 Sep 2026 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788934795; cv=none; b=M3aHYTK2tX4TLHrriHVuL0LLXCK8yEkGjSaWtx779WNsPrm2xM8pAX294wwSu1KzYanOWVrMuwnXju4AX4vPJOmrR7VqiVK79Ht77IDX+Krqk4nk62hmQdciTQK6qt+8K9M/69OVyd0eme7fqB0xmIc+yBvAoeIrkmmoQp4Lmaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788934795; c=relaxed/simple;
	bh=vi3lPY3GfZLF/LWRiBX+7U5bwiGq5nXyAtEFv59PatA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oT2FbB63IB7Ag3xXy7oYfgkKr6k5ZnuFK2ZK8uZaCmkH0r0pFPjRCp4jyjzecXpWHF0L7h4fz5z2ibuIwhNmT1Tns9qVpWwjl32NF1msH6h5PQzNiT1OfWcJdB/ZGwqJEHUVZFZj9Inl0BCE54ZGaMRqUB7u5MUU+Z3/8+bciT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XdeXXEyw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XdeXXEyw"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6894kJxE4155563;
	Wed, 9 Sep 2026 02:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=q1lgN
	Pz9hxihL6gTpFmVTlsfsRVhGOjN76BYM8oF5tM=; b=XdeXXEywfW8mLJHrBzWt0
	it0RTtSsnmarD+h0U6/M9ydAxdpQqnvUgh9xr/dtsGT2ZB1HhMT6Cs1QPJy6n7SR
	xl3EjnYGXPuvU3bY2WQ4rku9H6/r+qUG/Tki1AiteY9PKzzYHINlci7Tvn93EgFx
	wY4UyPz+gjtUwDZaP25ilZaG5ZZEXxBt+ImcP6GfiBYXh00e2/4zAlFeJzZlrzYv
	Hrz8yrqsjx7N9sps04iNYcu0rvs3q1bo/AyyDnRnhH4jHAaRIr2td0N+iaS9LZVj
	1gYhQgDDUUTix969VRo7l5q/X0f6vFINKgWZBfSzGvqpJKC++C2wmjjmA4muxIhW
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gjvfb1drc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 02:19:34 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6896JXV7044539
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Sep 2026 02:19:33 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 9 Sep
 2026 02:19:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 9 Sep 2026 02:19:33 -0400
Received: from 10.98.41.145 ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6896JFq6015040;
	Wed, 9 Sep 2026 02:19:24 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Wed, 9 Sep 2026 14:19:09 +0800
Subject: [PATCH 1/2] dt-bindings: iio: dac: ad3530r: add AD3536R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260909-iio-ad3536r-upstream-v1-1-16ab930dcee3@analog.com>
References: <20260909-iio-ad3536r-upstream-v1-0-16ab930dcee3@analog.com>
In-Reply-To: <20260909-iio-ad3536r-upstream-v1-0-16ab930dcee3@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788934755; l=2271;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=vi3lPY3GfZLF/LWRiBX+7U5bwiGq5nXyAtEFv59PatA=;
 b=qqZ6NZicvWNeCN4DTiO3FP7d6Mz+QoAo8U9dowkgVupQpHxc922Bt8okARx+5vk2AJNYKpq90
 Ev9HtDd2ZokDs01jex5UNC0sLwI+1ru3KKddcNmhlTVpEtp493+WKoF
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: tYiY8Fa_wvPosV_Te_J8XBpF7Boj-tF5
X-Authority-Analysis: v=2.4 cv=Yvk/gYYX c=1 sm=1 tr=0 ts=6aa0fa76 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=uBxG8GyZfWQcEiJ1Gu0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA3MCBTYWx0ZWRfX3Tie9pzzL87a
 zAU27XJlsqhtwBY3ak83L8ojZl46e9/d7yZxjjP64pkeefCGa1wVWltmR3IYZK5xbiZX3okt/zM
 YhnaLwjQXHl99rQacZXUujW1+kpP4+XqdY4VG12biRyRwRxsQ8sO
X-Proofpoint-ORIG-GUID: tYiY8Fa_wvPosV_Te_J8XBpF7Boj-tF5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA3MCBTYWx0ZWRfX50bS/uVk/QWM
 eb2GqEioCx6k20PakhcbZ8B6yqbW+o+xAoqCiGnGn1NfgRYUiKLGUIljL25YqPv9Pq2AHYyAYiw
 A9//k0vpg4NZtV8EcXrYqKYjcUEk+BxKbwalnJxCqRs6Z/MJ/VDa0O6S/e+gDEku/QTwpvP5AUR
 FPgjlfRw54bYDex+fceArSpBdPMQJXwWyjUtrM02gu9PyFpznvO3Ba85UnT6ZrEfj54XCvGPsHJ
 jYE69LVTGlH7XrPquwmBPe5VTp14BuqBfr58qacv/A/A3CMb3dHcZUApBpSF8MIQPJlz5WOqc2K
 8pxq4MU1V4mhshcFD6SH7jZAZJ20EY3ArxDZitbymMoJVe2qpcB/Pv1v0x5/+jfdwavXi/2O9xI
 Gti6xkUiA+WFod8m/CUbN1sL5LGVQ/9I6bMPxwnTXT7m5lwUmdm6LwCL7BrGTVRIF5kQv6TIL6W
 nAfyETBSRa0ql3BLE4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090070

The AD3536R is the 12-bit variant of the 16-bit AD3532R. It is a
16-channel, buffered voltage output DAC that shares the same register map
as the AD3532R. Add its compatible string and mention it in the binding
description.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad3530r.yaml          | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
index 2fe098619772..bf0278335583 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
@@ -10,13 +10,13 @@ maintainers:
   - Kim Seer Paller <kimseer.paller@analog.com>
 
 description: |
-  The AD3530/AD3530R (8-channel), AD3531/AD3531R (4-channel), and AD3532/AD3532R
-  (16-channel) are low-power, 16-bit, buffered voltage output digital-to-analog
-  converters (DACs) with software-programmable gain controls, providing
-  full-scale output spans of 2.5V or 5V for reference voltages of 2.5V. These
-  devices operate from a single 2.7V to 5.5V supply and are guaranteed monotonic
-  by design. The "R" variants include a 2.5V, 5ppm/°C internal reference, which
-  is disabled by default.
+  The AD3530/AD3530R (8-channel), AD3531/AD3531R (4-channel), AD3532/AD3532R
+  (16-channel), 16-bit and AD3536R (16-channel), 12-bit are low-power, buffered
+  voltage output digital-to-analog converters (DACs) with software-programmable
+  gain controls, providing full-scale output spans of 2.5V or 5V for reference
+  voltages of 2.5V. These devices operate from a single 2.7V to 5.5V supply and
+  are guaranteed monotonic by design. The "R" variants include a 2.5V, 5ppm/°C
+  internal reference, which is disabled by default.
   Datasheet can be found here:
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad3530_ad530r.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad3531-ad3531r.pdf
@@ -31,6 +31,7 @@ properties:
       - adi,ad3531r
       - adi,ad3532
       - adi,ad3532r
+      - adi,ad3536r
 
   reg:
     maxItems: 1

-- 
2.34.1

