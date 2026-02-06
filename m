Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434A30B52E;
	Fri,  6 Feb 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770394085; cv=none; b=Tg276KvVqrcWDpRUaGo2YSdWUvYMUBfU+G4PaK0vXjQtb+S/30Z9Js76Fw2qer19/4F4nlO290PB6YDhGhcR+tpK5lmhig8qgb0UR6KvxcNHTpYm+fE9YSsO/p+VlycLYy6k200pD21158KO9/5vAsdloVpBdYnuvQZsbj3pnh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770394085; c=relaxed/simple;
	bh=YEKxHtEP1kS3eg3xHPo8FCioLbnANi4HQA5PAqhiUS0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjJZXzrwVp4JYqoR8RoK5QSaJFpQuQwQNrD6Gr314hPTjP+b7vk/jIESYDott+pCY3KiMQUMYSk5iUDy6o1hPAq6kpVbJ8DCDvwhGnXDSMB4PI6M2EZzhnASPMYHCyn6KJt9iIjbWCVkUr8+OlF3zDsh3gMW4zV+fyaVlz9z7XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MXnmQhMi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MXnmQhMi"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6169sNQ6897382;
	Fri, 6 Feb 2026 11:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4O9cc
	LHwpwxRMocBE3L5W8Ebd6hFMX23Ud8XJUuC0SM=; b=MXnmQhMibnJAolOUR7kub
	X8hO7aKkw5/Y9DTjJCrsXu7wnpGp9ZbzjybdBiIsCfm7IQJGfbkrx+glWziP412E
	bTCGmSV0I9LmNd+tlWGlRv0ctg+v+c2JF4VpAh5nqOK/NMHbCR084336oL5ajSBT
	ew9LDVxM3G+G5mvb0KfzOP2qdzTfVMavcvCKRrtvPgxeUc5RSXGXQJLFQlK1FPsq
	LYZHgCAC35vzu95azDH1holy8fRTk4/IDxlyODBhl1i8Cj744sDUlU8O2jyTwCUl
	kGnv7T7H+3Z+LyngVn4NJpG1An50GbtRO5GVcAwe3XVpq9iDOrCVxZp6qn0zQG0N
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c5e32h4yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 11:07:47 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616G7k6H057150
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 11:07:46 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 11:07:46 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 11:07:46 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 11:07:46 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616G7MAn000370;
	Fri, 6 Feb 2026 11:07:40 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Mark Brown <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v2 3/4] dt-bindings: iio: adc: ad4080: add AD4880 support
Date: Fri, 6 Feb 2026 18:07:15 +0200
Message-ID: <290f35bcbd2f1ee68333ff65f89b54ec7fbb9c53.1770393792.git.antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770393792.git.antoniu.miclaus@analog.com>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 2Bxct58a9d_N3GsV5wxljvUO8_6-8cIm
X-Proofpoint-ORIG-GUID: 2Bxct58a9d_N3GsV5wxljvUO8_6-8cIm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDExNyBTYWx0ZWRfX7S6m+cq9VKnG
 obFWXfW9/fOCog7+WKX/YxTFdp6MR2RPSbzSFPz+kq/JW/+NqOzdUVYFx8jtWtGJCSWTcd1SyCd
 E4ZDiNK8nw/YOy2ibMOPU8ejv5UDKzO/s0r9pXja2YcJS1/Hoj9z4xIuyyaCkn6DcVH4qxjU2sV
 D4q3i8wNTxWsUc1gOXtQ+WsesXNaS8Fy7ZI8W7i33iYswPOgK09s3EQ5wsWkSqe4ToBnVGEXTkt
 7M13rne6Foghy9BVChTNZAHOmclxO+wIotQEk286GbamPnrRmcbnJTwlM7yUi7uqk3yotUx4rh2
 QspZbDEgYZuiMy4Z6y6Ed/Ba8aj5nz5olB4YRrRq4Kg9lImoVUUVCTBVnFMjxpk/YHtnC+QQnlu
 BFFzgg3vydiu0uEfoj72i8OvIYG6VJ0C9dG7L/TLwKb8cVF27as1A8kaMpiUFT8yeGgR+9SJB35
 9yjeifGRyMO8PGs7bfw==
X-Authority-Analysis: v=2.4 cv=NPzYOk6g c=1 sm=1 tr=0 ts=698611d3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=VPyHybxGR0euwXT8RmoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060117

Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC
with integrated fully differential amplifiers (FDA).

The AD4880 has two independent ADC channels, each with its own SPI
configuration interface. This requires:
- Two entries in reg property for primary and secondary channel chip selects
- Two io-backends entries for the two data channels

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
  - Replace custom adi,aux-spi-cs property with standard reg property
    containing two entries for multi-channel devices
  - Add conditional schema validation for reg and io-backends based on
    compatible string
  - Update example to use reg = <0 1> instead of adi,aux-spi-cs
  - Add AD4880 datasheet link

 .../bindings/iio/adc/adi,ad4080.yaml          | 51 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index ccd6a0ac1539..7108a91bb0bf 100644
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
@@ -57,7 +67,8 @@ properties:
   vrefin-supply: true
 
   io-backends:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   adi,lvds-cnv-enable:
     description: Enable the LVDS signal type on the CNV pin. Default is CMOS.
@@ -78,6 +89,25 @@ required:
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
@@ -98,4 +128,21 @@ examples:
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
+          reg = <0 1>;
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

