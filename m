Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555B235B63B;
	Wed, 18 Mar 2026 05:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773811412; cv=none; b=tEpaU9DXohEO4EAqXNW4bJLxJxEYoLZiO9+ZGmo3t/V1D3609JQwa0GsxLpma5/fHZfMp3/OIe4DwWQzxAY1AF6CBNWuru1fauJt+1AxFE4sNkBEVW/Uw5SxE7D5hdtIreT1AVpDetKWKYg/7n53woc6hkfwCMgzoiPebUPW2CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773811412; c=relaxed/simple;
	bh=+jBXypiU/a53dKVbLjeznarTSFNCVhzImIpEvGH4bLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=P4tE+DlfxPqTwxoauLHW4g1kunjgTHhWs58KX9QFLesU5iUKNS8uexoXM+/f2IWvAlK1H3cAZLTeWWmg4FKs7LAElIVndmaNEzz9rdl/NsgWrup/ZsPD0pYz87B5eQ0ffhkp9ZlDDHxQd2NNVfw41U7H+voVnv2ZjtVpsmh2ESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=IetZUMSi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="IetZUMSi"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I1UPC74041203;
	Wed, 18 Mar 2026 01:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SPcCh
	+8j0dCS8Ihln4iWhFlQ2VFcgNq2ErXN0WSNz7Q=; b=IetZUMSiOkha0SPprKJtq
	au4e/vESgaKRJGDZffZG00plz3RdAKuZvVSJEZj3kxwOjNVv2DOPF9jrI+XzSsmU
	PQaG1iX/GalpC+miIKAbuSEFb5ChTOCFvGMsQJf/NmNMJQ8R7E1DwtkWBoGa0CGJ
	bZhaVUxSalSHAaL0u63d1tzOxP7RBk/PtBjnyw9JCREWpjtpUgf3/EFefXDPvRqI
	rwxfparv4hXZL9OgKPszAr7pQ6MMBPBEqm8E83oEc6Z59ZDP9xjsneynI64CWdod
	oSF57SAPeUMqdcBCGTbFyfAWzoDOvAcQgge7Rk3Iann0A1zIgbgjrEpHNfWEiYOZ
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cyjesrxft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 01:23:08 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62I5N7x3064818
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Mar 2026 01:23:07 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 18 Mar 2026 01:23:07 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 18 Mar 2026 01:23:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 18 Mar 2026 01:23:07 -0400
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.118.4.23])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62I5Mpcf023858;
	Wed, 18 Mar 2026 01:23:01 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Wed, 18 Mar 2026 13:13:35 +0800
Subject: [PATCH v3 1/2] dt-bindings: iio: dac: Add ADI AD5706R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260318-dev_ad5706r-v3-1-5d078f41e988@analog.com>
References: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
In-Reply-To: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexis Czezar Torreno
	<alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773811371; l=2818;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=+jBXypiU/a53dKVbLjeznarTSFNCVhzImIpEvGH4bLg=;
 b=Ys8xNmzf9x1//iudxR3OdF+uTNdollJwykzmVn/8/4NBBtKXbcN6Hj2EMvOM5IDAYR4yKq9Xv
 QuphprXCG4gAV1NRScxqwcZR4bLcPtDLCIze31+T25XRIsF4NDKiUhQ
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=SpWdKfO0 c=1 sm=1 tr=0 ts=69ba36bd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=bhoRHIqEy7lu2wi8MIUA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: pQI7mlqPk94Ut-ZGjLqlsiolJYyyiUAA
X-Proofpoint-ORIG-GUID: pQI7mlqPk94Ut-ZGjLqlsiolJYyyiUAA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA0MyBTYWx0ZWRfXxMtnXPFPWOxO
 WUtvxUi9clipZ5KmLxXkCMVa9ky+Q+DbWJe1L43xuUH6JvrnSzzz7CD0rByYKETPAJ+NSjD2qnr
 yngAdvDHlpopzr2/7LP36AG7dHy/zqg3cia7JcoT/flxPrmls0s4xS9vBO3JteYIwp5zz0Cxyjh
 2/YD91x5Pc4O+QvrTsbcMN+/yUcBxA6tSHNvltb6Q6WWk0dLTCFertBPjD+EWGK5uOiV1M//nrN
 qOi+QvkmPYVF+lZP4+yVb3IP78x0DgDyryg2v8+OgyXTHh7DTpTs104P55anmiAvePuPbJ61J5a
 DhV6lI6FN3LPLkh3MEbva6zXotDWjooEi6D5t0GSm/exWfRllBMvoLvXsVGLBM7QG1/ShHY/SzD
 4ju7mNoBMqqRJaPBpifB5ZxHnfhKXyoXr/GVQ1bVz11qFOgNfUHODkFIrRwbs4AWk4mWk4nNZ6p
 ukNQkM44yutYQgOR6Mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180043

Add device tree binding documentation for the Analog Devices
AD5706R 4-channel 16-bit current output digital-to-analog converter.

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

---
Changes since v1:
  - Removed clocks, clock-names, pwms, pwm-names, gpio properties
  - Simplified example to use plain SPI bus
---
---
 .../devicetree/bindings/iio/dac/adi,ad5706r.yaml   | 56 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 +++
 2 files changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..8e99c78e87a47c561d7785243b9e9b0adc09f2f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5706r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5706R 4-Channel Current Output DAC
+
+maintainers:
+  - Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
+
+description: |
+  The AD5706R is a 16-bit, 4-channel current output digital-to-analog
+  converter with SPI interface.
+
+  Datasheet:
+    https://www.analog.com/en/products/ad5706r.html
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5706r
+
+  reg:
+    maxItems: 1
+
+  avdd-supply:
+    description: Analog power supply
+
+  spi-max-frequency:
+    maximum: 50000000
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad5706r";
+            reg = <0>;
+            avdd-supply = <&dac_avdd>;
+            spi-max-frequency = <50000000>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 1251965d70bdfa990c66966cd77f7ab52ae3385f..17a3d2d45fccb9cd3c93fd35666fb85d17d53cde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1496,6 +1496,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
 F:	drivers/iio/adc/ad4851.c
 
+ANALOG DEVICES INC AD5706R DRIVER
+M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
+
 ANALOG DEVICES INC AD7091R DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.34.1

