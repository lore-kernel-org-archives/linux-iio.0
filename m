Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437240B6F4;
	Mon,  7 Sep 2026 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776336; cv=none; b=GmpFlw3rqja7V2N/cu2cN5pCWu0YQ6iR1j772x6YJjBH6APIe0QhK6WxMNEbvpdSfw+ciSF542nIVqPw5hIpI2DPLDxHE3uJJY2ZFYIFZKYeDaYtvqvL2c7tYgg+KLPCDLYaDeCO4Y3ve77HTkUBT3aJhaHR62ZPCBoAvaTedXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776336; c=relaxed/simple;
	bh=JAmfGYfnjhgXKx1bUAHG2lH9Gn4iPQnfrFBIhblsCOg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aW3u2D8X01YrJSmT+xUACUBhG8xC2Cp4V2hXQ/nn+q3M+lD9VWS/TODJh9Sfg0W9q2s7xDcXCvEKqMrfojNO5uClJZHYs0pPgPkcxolemgS64Txys+ocZm6aCfcCtuAwxtG3DjSgF3F5PU64sNFlFXYnYfNPBq1jYBf135JiJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eTIUfDve; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eTIUfDve"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6879YUmP2726524;
	Mon, 7 Sep 2026 06:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PcLIl
	504y0IUtrhz7ug4nvh0+gtGbDVMaODkxUjnFoQ=; b=eTIUfDveRuC6ttGKwSYRx
	tMbASjHFzHSdWkrTHzpMri71DK0DE2Q2nuyoxwvL00q80VwBY1O/6BsYKDyKTXuj
	Y3wwBRaFP0o0MrEd2EqcBgcTjRVmS2YFkab8FjMgf4Tx6X5HxTLwVB65Ip4IUqCc
	3FAbBqDVd8pZUqNZ6QRI8fhnnnGHFdQ1fHHa1CgU/jyIYXfi/CANe6IbPOsaAtFI
	apgraeHPlOedsiP+kJ9OJGtOp7FesC3e6U3t9g44Z96kdZsuke452lzryxCMgQzh
	1Ofj1Q20g7AqTO3DI3pYDedQQEqgP5icJt2TUD//e/t6uz4V7/tqutYb6OI5synw
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gh1dbvunj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 06:18:31 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 687AITiZ010533
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Sep 2026 06:18:29 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 7 Sep
 2026 06:18:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 7 Sep 2026 06:18:29 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.185])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 687AI3De007412;
	Mon, 7 Sep 2026 06:18:24 -0400
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
        Radu Sabau <radu.sabau@analog.com>, Salih Erim
	<salih.erim@amd.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jakub
 Szczudlo <jakubszczudlo40@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 2/4] dt-bindings: iio: adc: adi,ade9000: add adi,ade9430 compatible
Date: Mon, 7 Sep 2026 13:16:19 +0300
Message-ID: <20260907101623.8730-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907101623.8730-1-antoniu.miclaus@analog.com>
References: <20260907101623.8730-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=XOsAjwhE c=1 sm=1 tr=0 ts=6a9e8f77 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=tT9GeYvpIO8S9_p5PeQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExMiBTYWx0ZWRfXygt6+f4oq5EP
 35ULtjrs2NPnGJcuMRHfjO7I6gYQsCjRY1bjIVjLaDow9yritn5eAYaVYdnkp4jLtk4jE83cd/s
 hUmo2wsRFuX7z3x70Gga3fFbk495egl4OFxxy27MtZZ6z2FqX7nB
X-Proofpoint-ORIG-GUID: d6oID1hpdAAahRz1A6pLlLrVMQ0z1fk4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExMiBTYWx0ZWRfX4LFZga9btXpv
 JFdl5GGvT5RnvbGUEqhonN0U7BuXVBNGbL25vCK9PPaZmUaTUwfnV5Aq1AytOoy8/i4Pg8mRrrn
 rUKqKXdrtTzUDg4neL0F/HB6QcnDPuSDq0gTvc4S1kqIpwbddBlGGjmwfXq78FHx+qwMG9J1Chm
 MdwnWRy8gNCZJcbwQ5Tvd5qm8vkjqT3+Q/fDSur3LG9pju15fHJgXGmpUUTNKPowcBH52fSVmL4
 oPCWilZV5ujg68Az2ZrTlEA+EFmHnHxL5pcHvWHkqhogs7liPpe+ibXF+3pyDOlnf3eKMcaiK5M
 /q4stvbQhCGGYYIeq/r9OpfEjWvmd1rpeKICzqDrWBkoThTt8uD0LvGZX393iCWa/GG77xv14c5
 br08gk0E47QhIZ4EH1YpdjWlWTl8gRRw8O0wos1o0Qy2KbkflFTaUfxSSNRsTvRR2F7A+p1eeyi
 XwFYJOa9fbbDppveFAg==
X-Proofpoint-GUID: d6oID1hpdAAahRz1A6pLlLrVMQ0z1fk4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070112

The ADE9430 is a polyphase energy metering device from the same family as
the ADE9000. It is register-compatible with the ADE9000 but does not
provide the on-chip dip/swell detection, and it has no on-chip digital
integrator (it relies on an external analog integrator for Rogowski coil
current sensors).

Add the new compatible. No spi-max-frequency constraint is needed as the
ADE9430 supports the same 20 MHz maximum SPI clock as the ADE9000.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
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

