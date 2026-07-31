Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFFC3D6CC1;
	Fri, 31 Jul 2026 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486653; cv=none; b=I9MkMv9aGUrAD6bKuI+sLmxOaZg+SVuRqe7QQ+I2TFfS97jcVIJ91E3CcwH+AWTEI4hlNsWWpuGok1iGoSZQ8PToGq5Amqpq2lAfQ4FtXQ4co/mtWRw0Gx7HoHWsB1wO3ernIeXi1pcWQCgxOj52O3Qp+EEELfDdvrcaFADhneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486653; c=relaxed/simple;
	bh=W5Z8av5sCnv2yz5kgM2/4a0qp9r6/NLPnwJl75cKxi0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEMkiup7iFufCfkA4gYU4LkLrxziYmY5K5gAinPMoF0GuaYR/0IU47rxmK0UTAxcaYRCebW5Hcd0m7edSpvJc2Tfeeu1LGoBlr+KrjMEwaqMiLmKDzu6qZR8xIIELQg1lMCQqzbu4P9rWrsImTwnNi0sYq2DhstXQ05wXEgLqKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ndNTVDxN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ndNTVDxN"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V7wn493068291;
	Fri, 31 Jul 2026 04:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yPZ3z
	rgj6+4iyZXG/R2leQ7sIsZNXpfKMiX7xRQxvwg=; b=ndNTVDxNx83sYUr+c3b89
	XkfBMPDow8WSUJsxjthRhYuBoonppX8lUAO4gsqzxL8/Oqd5n9Hzp052TVWf52cS
	GLCtnK7LV8hphw+WsXMcjaZndMJrxMyztmyFs2QDiBnE+mv7BEOguj9DyIdEefR9
	nn6+0VDi1k65cjHGymiZqWY6up9dWVizYdo3Hq4UY/encuVNXzlToQSHlcKaS76V
	VSsDSD89+kULMCLFdTIPsb8CpR4qec7XEwO+X0u1c6I+tqaKbFzXaVZh+yBK829d
	N810GrzWQBaMZ4FoezwIYrUIfrtW1GKBMg3xCYrrPlvKtlxCDNoWX7hpXzvSD4Y2
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fqj4f9hug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 04:30:36 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66V8UZNe039903
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Jul 2026 04:30:35 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 31 Jul
 2026 04:30:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 31 Jul 2026 04:30:35 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66V8UDN8026738;
	Fri, 31 Jul 2026 04:30:30 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah
 Khan <skhan@linuxfoundation.org>,
        Radu Sabau <radu.sabau@analog.com>,
        Marcelo
 Schmitt <marcelo.schmitt@analog.com>,
        Jorge Marques
	<jorge.marques@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 2/4] dt-bindings: iio: adc: adi,ade9000: add adi,ade9078 compatible
Date: Fri, 31 Jul 2026 11:29:48 +0300
Message-ID: <20260731082951.1228-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731082951.1228-1-antoniu.miclaus@analog.com>
References: <20260731082951.1228-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: L7BSXLcF1x8U0XhgD-3ixYI0Ue0g00kj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2MCBTYWx0ZWRfX8jxxt0G009y4
 vVSirLY63fqkJpPTO8fqmc1UrC0Li6sgg1N/PlJiTBqk7qYd4pLx3AqnsDLh1Z4SfozwqpM37fU
 f1VLeueXSaKxkLSCsoyHd2D0F+87dj7ELWo2o4B3BUTBbDsg0KxRbiZs8BurF2jaSjxjf5CwGQw
 7CweQ1jO52O/Dh/eiZzCMkSD69y63aNqmr3htS3fHxRgcXBBXd2xbufIGwr5YMMLaG6L57S/X+7
 iOneb7JyDzv0a/tSK2U3W9S6tRq2uKYlB5ZxnDJakLsUvsyNuoVN0M7NyejdUQZ5tmV4xXgMO7y
 Sli5fvzozFIR0AD3nIDLWGPDWcMiNBK0zJcK7RUKx3oODzXrwC99LFr5z8BeZu5e9nYuQMYqCNE
 AgD07bvv9bsWhCP4BViHDiIOXqpS/qZAxYzkPdFpmo64zHU26bHrdtV4Hi9bzH2PBoi79XOAmBh
 hEn9eaVv4qtjRgghgHw==
X-Authority-Analysis: v=2.4 cv=EMk2FVZC c=1 sm=1 tr=0 ts=6a6c5d2d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=0G5oFKN4N_cOIownKFoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: L7BSXLcF1x8U0XhgD-3ixYI0Ue0g00kj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2MCBTYWx0ZWRfX8ocT+ojA++Fz
 Hi5mARkDvO8+fM/DPjbmSAPAgLf4F63OglDuDD8pPjdZskXLuT2n9k8631jyHKMkcN6MCrKBhH5
 8TN81vxSDzmG1n3154LoiLTNKLVHj1oZz0+ia9ddOpgN+WlOp7sC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310060

The ADE9078 is a polyphase energy metering device from the same family as
the ADE9000. It is register-compatible with the ADE9000 but does not
provide the on-chip dip/swell detection and is limited to a 10 MHz SPI
clock.

Add the new compatible along with a conditional constraint lowering the
maximum spi-max-frequency for the ADE9078.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v2.
 .../bindings/iio/adc/adi,ade9000.yaml         | 30 ++++++++++++++-----
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
index f22eba0250ee..1e940e8c7297 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
@@ -5,21 +5,23 @@
 $id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices ADE9000 High Performance, Polyphase Energy Metering
+title: Analog Devices ADE9000/ADE9078 High Performance, Polyphase Energy Metering
 
 maintainers:
   - Antoniu Miclaus <antoniu.miclaus@analog.com>
 
 description: |
-  The ADE9000 is a highly accurate, fully integrated, multiphase energy and power
-  quality monitoring device. Superior analog performance and a digital signal
-  processing (DSP) core enable accurate energy monitoring over a wide dynamic
-  range. An integrated high end reference ensures low drift over temperature
-  with a combined drift of less than ±25 ppm/°C maximum for the entire channel
-  including a programmable gain amplifier (PGA) and an analog-to-digital
-  converter (ADC).
+  The ADE9000 and ADE9078 are highly accurate, fully integrated, multiphase
+  energy and power quality monitoring devices. Superior analog performance and a
+  digital signal processing (DSP) core enable accurate energy monitoring over a
+  wide dynamic range. An integrated high end reference ensures low drift over
+  temperature with a combined drift of less than ±25 ppm/°C maximum for the
+  entire channel including a programmable gain amplifier (PGA) and an
+  analog-to-digital converter (ADC). The ADE9078 does not provide the on-chip
+  dip/swell detection available on the ADE9000.
 
   https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9078.pdf
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -27,6 +29,7 @@ properties:
   compatible:
     enum:
       - adi,ade9000
+      - adi,ade9078
 
   reg:
     maxItems: 1
@@ -67,6 +70,17 @@ required:
   - reg
   - vdd-supply
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ade9078
+    then:
+      properties:
+        spi-max-frequency:
+          maximum: 10000000
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0

