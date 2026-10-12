Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097041DDFA;
	Mon, 12 Oct 2026 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803704; cv=none; b=oa3rN3M7LaZ0IEEzwRGKcXBzM+GRLTV2aALhHDAJeo3s9/4gWskeMXhu/Y0yBFYh5b0MO8Ngtg3TwcBIO7wksLOov6+2SJ9sZzE7GKXSPPLBHrO2IgT9Cw+AnBMEIabacdMbvFgptXXFPpSvgOTYA5Kc9ClnJGR69VDYKGmNkXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803704; c=relaxed/simple;
	bh=idFA8JVKBWB0uncZpM0EC6eIkqYm5V5XjbgXn68qeyA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnR86UAyE0eI04N//7kZ/hFTfyqN5+CpnJ/aZV3sDDFFpbnUtPmC162KnS5XAI5yX411p6o5vpWq3JFKm/oX2vIMDVlH4iK+xDiQ0J7+FJ/xTKvW+RcKsKbGRiR+3narD4xmi2ZO8JEzZ2ziDhdBgRop1rBW6rS/tIJy6B6yKfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=K4BrVbnW; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zjOmrOQx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="K4BrVbnW";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zjOmrOQx"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8Nt4p2416607;
	Mon, 12 Oct 2026 07:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3vFYv
	yncw23UlOfEVr2kvg7QoCZuk9RSzMQZbMyteV0=; b=K4BrVbnWjBrsGjSRT4Dss
	w11b6eIiucipb92Kp8+Vayw0/OyO1DlHR48QJMTwEr1nlu+SyuC9SeaaLZzr+jaF
	9gn34GfHiUeyj536S2HYiUmqkTINrjQSRBgNXXiacI6Lkqe+ARZ68FgkoWL5EhEr
	9iIssi7q1T7QvZ/M2YkLLjRuipaWKH6JYstAjA59090baidvhsqwzStaQmUCMkw7
	GRMp0cD9BbK1dx2kr8Iaghio/K1qgV3P3Uo7V171MG0hLNuV4BY9teHtDnloihjC
	0bhzPiN64I5UMNSmEXpTkQ/kxAapTVacAjCfvHY9iAlpdGTbmxFj/5swbmQZqKZj
	A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3vFYv
	yncw23UlOfEVr2kvg7QoCZuk9RSzMQZbMyteV0=; b=zjOmrOQxd/KWHckyBu5Hr
	HudQhZnfyzDSP1AdEQDaBX6SxQBq7ukaO0+X3Fp4Q9c4izS7sjaYgkPWqyph85uL
	7f0LsjU7zs6Bbc/YFQ6LGOalQgkvTedyycFOorRiWFYkrzaD6j+mvMvBaXamnEyL
	kHgbJn11SkzcGl4MWoqHyZH/V41Qs0loVjJZW5HCNH6807jOkYW7urq2HqZUNJT8
	IChDQKdIQo++BnnVjnRalEBkmWy/+2gI9KOxy3FDmognxldyMdWrDic3h/3KQ0M4
	hevtPKCP+QmfjmcbZqLz/qS7qLAMVtvpN+/OLEWAa7l0fqDUtScIv7NPEUEZmH4N
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h86peehnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 07:14:48 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69CBElvp036769
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Oct 2026 07:14:47 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 12 Oct
 2026 07:14:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 12 Oct 2026 07:14:47 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69CBE1X0024898;
	Mon, 12 Oct 2026 07:14:32 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah
 Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>,
        Janani Sunil
	<janani.sunil@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        Jishnu Prakash
	<jishnu.prakash@oss.qualcomm.com>,
        Jakub Szczudlo
	<jakubszczudlo40@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 2/4] dt-bindings: iio: adc: adi,ade9000: add adi,ade9039 compatible
Date: Mon, 12 Oct 2026 14:13:38 +0300
Message-ID: <20261012111342.48040-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012111342.48040-1-antoniu.miclaus@analog.com>
References: <20261012111342.48040-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Q8uUl2xEqVd0SJljGRS3fQurK8E_VNoa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfXzSKHFIknNsSJ
 loIh1lVmbfNUJXNOiA1RgBUbyjFe7v0wE14C4k/g0uegDbKgs0M5Ct3xWCzRbBgu4U6RI43SpEy
 6y5GcZNF5GqpLYR9s9i6cNE/18bjXosdZeRUfjt4kgCYmWo4Kyk1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfXwDrex3T+1teO
 4nXHIfN3QxtnLPhpZVTvpsz2T/WycNIlUHUBDrmLjJK5SZaQX7vfM2wH8Eo19asFb+xevxNCSV7
 3JL3Qc1NIIkLSlMoean0WcVvXkIo4vsOr2luxPAB2AOpZ0ZsugzY7WHDAH5hOdsMjymSdFsNlKB
 k5XmybgQxWsD7HMTxl3p0I+5X1xOoKvh0SMm5jkLs5ePu6nXkqKpgWZjF0/YN2Q/0IDZ25b+q28
 9f5KkctawLxhv+M6gazH1XQeP1m5bRMNGluHqdqLK1K9Px4y4usAfXa6N8unbwAcBns95k8O4nc
 4xOn3yAcMaZWQGg1NaMT2aOOIJqv6+wG69QH9vbyfz2UhkdOy9NwB6WlmdNIR9fRKVTREcqBbrP
 nSLju3ugn7GEYCJiMzoYmY1bPpO/hLuw6iJmIhpPbQW69VwQjAebS5gMxkQL+W6EPLDTAHv3vnD
 WXI1ZVF5y0sg8DFeJCA==
X-Authority-Analysis: v=2.4 cv=QfPzLcbv c=1 sm=1 tr=0 ts=6accc128 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=TF6gXxuSPZkvrYk5CCYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: Q8uUl2xEqVd0SJljGRS3fQurK8E_VNoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120044

The ADE9039 is a polyphase energy metering device from the same family as
the ADE9000. It is register compatible with the ADE9000 for everything the
driver uses, provides the same on-chip dip/swell detection, and shares the
full-scale codes of the ADE9078.

It computes only fundamental reactive power and has no total reactive power
register, which is noted in the description. Like the ADE9078 it supports a
maximum serial clock frequency of 10 MHz rather than 20 MHz, so extend the
existing spi-max-frequency constraint to cover it.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../bindings/iio/adc/adi,ade9000.yaml         | 29 +++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
index bcc166aad713..70106dd052ce 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
@@ -5,26 +5,28 @@
 $id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices ADE9000/ADE9078/ADE9430 High Performance, Polyphase Energy Metering
+title: Analog Devices ADE9000/ADE9078/ADE9430/ADE9039 High Performance, Polyphase Energy Metering
 
 maintainers:
   - Antoniu Miclaus <antoniu.miclaus@analog.com>
 
 description: |
-  The ADE9000, ADE9078 and ADE9430 are highly accurate, fully integrated,
-  multiphase energy and power quality monitoring devices. Superior analog
-  performance and a digital signal processing (DSP) core enable accurate energy
-  monitoring over a wide dynamic range. An integrated high end reference ensures
-  low drift over temperature with a combined drift of less than ±25 ppm/°C
-  maximum for the entire channel including a programmable gain amplifier (PGA)
-  and an analog-to-digital converter (ADC). The ADE9078 and ADE9430 do not
-  provide the on-chip dip/swell detection available on the ADE9000, and the
-  ADE9430 has no on-chip digital integrator (it uses an external analog
-  integrator for Rogowski coils).
+  The ADE9000, ADE9078, ADE9430 and ADE9039 are highly accurate, fully
+  integrated, multiphase energy and power quality monitoring devices. Superior
+  analog performance and a digital signal processing (DSP) core enable accurate
+  energy monitoring over a wide dynamic range. An integrated high end reference
+  ensures low drift over temperature with a combined drift of less than
+  ±25 ppm/°C maximum for the entire channel including a programmable gain
+  amplifier (PGA) and an analog-to-digital converter (ADC). The ADE9078 and
+  ADE9430 do not provide the on-chip dip/swell detection available on the
+  ADE9000 and the ADE9039, and the ADE9430 has no on-chip digital integrator
+  (it uses an external analog integrator for Rogowski coils). The ADE9039 only
+  computes fundamental reactive power and has no total reactive power register.
 
   https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9078.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9430.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9039.pdf
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -32,6 +34,7 @@ properties:
   compatible:
     enum:
       - adi,ade9000
+      - adi,ade9039
       - adi,ade9078
       - adi,ade9430
 
@@ -79,7 +82,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: adi,ade9078
+            enum:
+              - adi,ade9039
+              - adi,ade9078
     then:
       properties:
         spi-max-frequency:
-- 
2.43.0

