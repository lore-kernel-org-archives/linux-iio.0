Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BB130EF7D;
	Mon, 23 Feb 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863787; cv=none; b=uUsN1DXiF+vZvL5kI3KoNaA028cRD0nA60J0NpbFLEaC325C7RG01Dior1QzbQhbtdEHH+YncIrB/Fzg+EJu3CfboGcbOHzn9SVGgtFGmiwF21Ho9FqoCZgbwke0+K1GupWOCKbcWyoyJGSzrMKF0ZdsoOS07FJxS9U2OXc/oVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863787; c=relaxed/simple;
	bh=tfP2e5G9zSNVZkfGmRSdQSwPqWBir2tIyV3g+1m/ezQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOO0uai2fPRmoZ+VwQC/BlDAVwXolELw021EB94qfsIEBRpLow9EiCV7RXVltfAOjcsi1D24lHahwRbS+kUFDU3Qpc7k8bMfaao51mwnMrJT+sUhwCoX7FvDl6mtbj7ra/6gAacW636RE7D64iXkYULD2AXgSRUEi0GAJhU42Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qdePCR/j; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qdePCR/j"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NFFhPw818304;
	Mon, 23 Feb 2026 11:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FybIp
	Ej7AnYANBiTo1TcqJCFAw9CIbcF75crBV6gyX4=; b=qdePCR/jv3RrUoGMWTiz1
	wWf2b1zXc8uhmAyFqonUMLrvtvVE5XBwfFu0CC8kzWfu3oMGkw/HM6ifTsMVl1OU
	5C1JOntp3GPatzBBYF0vyyTlOxmNJ9G56YR4120A3lX9x3BsIm1Da5DHI74K0AI0
	fXfkHTaNMEAYVhm8h5H55D6fsmg17z95C/xbewTLeWWUmJ3xqnn8GErwU8ucYKH6
	RkgK4x/mpWvELmCiYIEm7mzcGsh8UW+SzbPdYkkKTjQb/IjcHZ7qB2iQRA65NiiC
	yBRkboNHT7Z6LOe0W4BdejA+eGQ9avBOLgPCGzz8ceJpaQtdsaWK0TRfqRdPXNlA
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p03kkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:22:49 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NGMm48031813
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 11:22:48 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 23 Feb
 2026 11:22:48 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 11:22:48 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NGMJUf015342;
	Mon, 23 Feb 2026 11:22:41 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian
 Reichel <sebastian.reichel@collabora.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v4 4/5] dt-bindings: iio: adc: ad4080: add AD4880 support
Date: Mon, 23 Feb 2026 18:21:03 +0200
Message-ID: <20260223162110.156746-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223162110.156746-1-antoniu.miclaus@analog.com>
References: <20260223162110.156746-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: EIM6ug20fEsT-zXdi1TS1VwFWJcN_sZm
X-Proofpoint-GUID: EIM6ug20fEsT-zXdi1TS1VwFWJcN_sZm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE0MCBTYWx0ZWRfX88XNLOCu8nbo
 nQJJSLpH7/UdmmS38pwzaio/40SXlejAHvOt+Q+Ho/Q0shaUW8/UaN2QuRx2BeF/Xu9m/r3zi/3
 jgc8OysLLftEsgrVwsxfeycs8Q2sdUY2mvb/lFzLtaf5YBzm/KVGD59+GbkuQxxCnNLn+Bmj2FT
 II0QvmixFxJFAIxdcpjmnFxxDFNQU3cPZ7+EYP0F2Mnyo9EqumBeHLhhDbN4slM2tl2uszdVMzP
 opWREiRNJkNnuCvferJj8rpErDnF/wIvAkeG50elgW47W6DCTYV3tsP6wcaS7MxzKc4cDzdc+8H
 u0LEYRf1IFiYNmrPZZ8fTGCI279eJeXJgnVDVmDWYu+BbZZBBDRkgB6m80W3shMKfDQ4YKng7RB
 PMgrvq2NjBQ/cU7r0j0rbx6L4fRuo14VVaxC7VGkWU2cjWHjaXZO9+evrl1LP0njK7Y2zRAImN3
 knyKsrbdcT3k/N8UIUg==
X-Authority-Analysis: v=2.4 cv=Fq4IPmrq c=1 sm=1 tr=0 ts=699c7ed9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=eYjWAXzLS8b0uuH4XOwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230140

Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC
with integrated fully differential amplifiers (FDA).

The AD4880 has two independent ADC channels, each with its own SPI
configuration interface. This requires:
- Two entries in reg property for primary and secondary channel
  chip selects
- Two io-backends entries for the two data channels

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v4:
  - Drop redundant maxItems from io-backends since the items list
    already constrains the maximum count

 .../bindings/iio/adc/adi,ad4080.yaml          | 53 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index ccd6a0ac1539..0cf86c6f9925 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -18,7 +18,11 @@ description: |
   service a wide variety of precision, wide bandwidth data acquisition
   applications.
 
+  The AD4880 is a dual-channel variant with two independent ADC channels,
+  each with its own SPI configuration interface.
+
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad4080.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4880.pdf
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -31,9 +35,15 @@ properties:
       - adi,ad4084
       - adi,ad4086
       - adi,ad4087
+      - adi,ad4880
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+    description:
+      SPI chip select(s). For single-channel devices, one chip select.
+      For multi-channel devices like AD4880, two chip selects are required
+      as each channel has its own SPI configuration interface.
 
   spi-max-frequency:
     description: Configuration of the SPI bus.
@@ -57,7 +67,10 @@ properties:
   vrefin-supply: true
 
   io-backends:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Backend for channel A (primary)
+      - description: Backend for channel B (secondary)
 
   adi,lvds-cnv-enable:
     description: Enable the LVDS signal type on the CNV pin. Default is CMOS.
@@ -78,6 +91,25 @@ required:
   - vdd33-supply
   - vrefin-supply
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad4880
+    then:
+      properties:
+        reg:
+          minItems: 2
+        io-backends:
+          minItems: 2
+    else:
+      properties:
+        reg:
+          maxItems: 1
+        io-backends:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
@@ -98,4 +130,21 @@ examples:
           io-backends = <&iio_backend>;
         };
     };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+          compatible = "adi,ad4880";
+          reg = <0>, <1>;
+          spi-max-frequency = <10000000>;
+          vdd33-supply = <&vdd33>;
+          vddldo-supply = <&vddldo>;
+          vrefin-supply = <&vrefin>;
+          clocks = <&cnv>;
+          clock-names = "cnv";
+          io-backends = <&iio_backend_cha>, <&iio_backend_chb>;
+        };
+    };
 ...
-- 
2.43.0

