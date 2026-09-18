Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ECC4A3D33;
	Fri, 18 Sep 2026 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717020; cv=none; b=odvf2yrI4ghC1drVQUn51Sj8fb0mD0uBSN2ZRcnSd90hC498d0EOI0R1TOLEF8otk21KvOhGhLHp8/ncOptT8WOT7LwYn3G9k2aD3NNUeNMBgsEqVnLWueyaTHgBo805anTvlSV6vBqK9yfFlf8q5fsRtA2iOk3y+K5nWyy9I9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717020; c=relaxed/simple;
	bh=MpY3lUBzKaNOnaSHyA4bsUZWIqVKUTZbdVnjSTQMKAk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNgJDbMbu/qAG9RhFp2PqOvtxG2gZWyuZ/KvWIteQ3c02Qm7Ghi/2A1FkITocBcXU6DMhe8zmETS3bE7gd5oPn51mXkEirg7v51cDLGAxWCcj9KCwXfRwNA0k3dAXGl7dTISTlQNIc9XwIzp04xyYYBN43B8FtMBohkXffQ5jD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=I+EQCyXS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="I+EQCyXS"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5wZX23969914;
	Fri, 18 Sep 2026 03:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GoPv8
	P155wxUDcmexVb9CzwlQPvh4tikXZB/LojDcCY=; b=I+EQCyXSjEaxQyLNk+0id
	6sjJHXn7zMCQCCif8/itEaQaEdV6Y/vSUbFjYixj/Cr/VzWVGHDYVHyuWXeu/Jpo
	DERMYQp55CmFSI6DmYL9JKMaG0WcjPyH0PV7DmdCmGEp5FYpIJOHEG7QFNqH0TaG
	3LbOmR2sp4LjxGRCkr3O/rhPIZ9tpPQ4KpzbU7yMGsq95CptfWVgYnQNck99RzDQ
	/zYm6KqximuxhHb0D2qnEKNz4FQw4ZRr02w08q7fzcg4Ovc0IZ2PWanng6hWgMcW
	vVx9NBAu1a7lkC7Nl3ZMUewk1DLCKS/ISJZbicNlRKpCZAMeUmk+Ao2hKsIoO3e0
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4grk0xktfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 03:36:20 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68I7aIak011044
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Sep 2026 03:36:18 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 18 Sep 2026 03:36:19 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 18 Sep 2026 03:36:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 18 Sep 2026 03:36:18 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.219])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68I7ZjpV019677;
	Fri, 18 Sep 2026 03:36:12 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Shuah
 Khan" <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>, Salih Erim
	<salih.erim@amd.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        "Jakub Szczudlo" <jakubszczudlo40@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 3/6] dt-bindings: iio: adc: adi,ade9000: add adi,ade9430 compatible
Date: Fri, 18 Sep 2026 10:35:32 +0300
Message-ID: <20260918073537.1572-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918073537.1572-1-antoniu.miclaus@analog.com>
References: <20260918073537.1572-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ARBHifQJC88ihIGPDG2W3geeUaOxeK8e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfX07KfieoEneXH
 tZqkXEGYTSlK6XXL3zTNk4Scs2rnaGURRHKG/hTQmX60+AyDWC6asIl/6Z3q03ojlkO3gJgR5rM
 9eRnlUsMrNQ1P1I7avzUeuey92eaY3LGaRVFFPxvxyPUI6p3KEPkMw2AOHvizIQlKrCTkiyDGBz
 xT6gw9eY1FtIlhZehxd9DGPHI20E4OefO83sUoLV9cmZ/kUcIL+T+eNBrV51UYWa8lKOQ5C/sTE
 3xGaKQZfesXdxGUbA/j2LCkJemeTlePjUMStG3oE+5vmM3qA15LM2Ynnj58ome/wIED0172d3LL
 3C5ELk5Kg+sMoAKA5h+RO6MVFIF2pBH+T/pRx0JyWefmTD040+DfqYN9ei3wFSaY2LcCiMiwtO/
 MZWzd3T94bUGVsRW2lbPWXRSVsMLd4Orz1K52tp7I5X9NSX54bhSCd05inPMlvaLjOwmqKb8hKi
 Dk/c6TRWg/I3Wm16kqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfX51kUW7CoQ59m
 Gzyy1+ZbqQqdYqZLVVczzyY45f8QwRLVN+FEqZsP55aAcTe0uUwpgZJ7CQ83Q3VZUq6pa/gOoBq
 6jNrvBOz1LpOmfLrk6qLWbKEicA0em7fiEgWwmJwPvTXuvt0avG8
X-Proofpoint-ORIG-GUID: ARBHifQJC88ihIGPDG2W3geeUaOxeK8e
X-Authority-Analysis: v=2.4 cv=OtXaWC/t c=1 sm=1 tr=0 ts=6aace9f4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=tT9GeYvpIO8S9_p5PeQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180102

The ADE9430 is a polyphase energy metering device from the same family as
the ADE9000. It is register-compatible with the ADE9000 but does not
provide the on-chip dip/swell detection, and it has no on-chip digital
integrator (it relies on an external analog integrator for Rogowski coil
current sensors).

Add the new compatible. No spi-max-frequency constraint is needed as the
ADE9430 supports the same 20 MHz maximum SPI clock as the ADE9000.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
- no changes.

 .../bindings/iio/adc/adi,ade9000.yaml         | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
index 1e940e8c7297..ec68e6887142 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
@@ -5,23 +5,26 @@
 $id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices ADE9000/ADE9078 High Performance, Polyphase Energy Metering
+title: Analog Devices ADE9000/ADE9078/ADE9430 High Performance, Polyphase Energy Metering
 
 maintainers:
   - Antoniu Miclaus <antoniu.miclaus@analog.com>
 
 description: |
-  The ADE9000 and ADE9078 are highly accurate, fully integrated, multiphase
-  energy and power quality monitoring devices. Superior analog performance and a
-  digital signal processing (DSP) core enable accurate energy monitoring over a
-  wide dynamic range. An integrated high end reference ensures low drift over
-  temperature with a combined drift of less than ±25 ppm/°C maximum for the
-  entire channel including a programmable gain amplifier (PGA) and an
-  analog-to-digital converter (ADC). The ADE9078 does not provide the on-chip
-  dip/swell detection available on the ADE9000.
+  The ADE9000, ADE9078 and ADE9430 are highly accurate, fully integrated,
+  multiphase energy and power quality monitoring devices. Superior analog
+  performance and a digital signal processing (DSP) core enable accurate energy
+  monitoring over a wide dynamic range. An integrated high end reference ensures
+  low drift over temperature with a combined drift of less than ±25 ppm/°C
+  maximum for the entire channel including a programmable gain amplifier (PGA)
+  and an analog-to-digital converter (ADC). The ADE9078 and ADE9430 do not
+  provide the on-chip dip/swell detection available on the ADE9000, and the
+  ADE9430 has no on-chip digital integrator (it uses an external analog
+  integrator for Rogowski coils).
 
   https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9078.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9430.pdf
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -30,6 +33,7 @@ properties:
     enum:
       - adi,ade9000
       - adi,ade9078
+      - adi,ade9430
 
   reg:
     maxItems: 1
-- 
2.43.0

