Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D23390C93;
	Fri, 13 Mar 2026 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403187; cv=none; b=amZWKjbGhWq3tsx/OHc/VTBdZvHxP1EsC14uW6loojyWRc5D7GB62Nf1XUdGNRW1wamqdcPZ+XMTeY3g11sQNyZAE15ciayLnAGRLRkGeZ5pvGfGJPlKNbFv0k2bkKI5M4A5kgOY2KSZFB4140Df9lyz7uoPmUeC+PN3r+I37Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403187; c=relaxed/simple;
	bh=+95XMX6FQGZ4vil215A6tgtXiUep/iDn/ujR9mysiH0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgNqo5LQGV/RtOBbqVRbkh48DEoRdRcMnXtDm2hyyiGkES90QxX1WddyuQMW3NPTC3F9EKMHQnGT1c9Vof3foVg2YoCvN8PYloUK8ptzMugtwOHUgSGuB3NqkmOBQPjBz77c6qC+Go1xPyVBEnPOcEEfabY+QGtk4rRMVVH3wcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=epIEd7j5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="epIEd7j5"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5NFRu030689;
	Fri, 13 Mar 2026 07:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZorGh
	SgGrU9c13a+T3TTOyrKYVTDOEfGFcCRIgc7S0E=; b=epIEd7j5Rgtl5INtutVZK
	bPqNSKvfh/qMqhybvf1Yje6SXPm/FQ9CJ5t4tlvPaUEti98pd1MAf0JJSNJgkdLV
	x+DppvZd+QPcW5XaW+7M7IJh9EAy/Z5G489sikGOvdclXUwPd+YwkYhfxlq55tYk
	o5f6eCQHy4pxuDwo/AaF/T1Gmrb/CVfw1VpIiUhtStgnG1qXBdsyblRN6WJEbnuY
	stNLIWuT9k4OE3NYcZS62bfawvb6vERmxm0jz8N/8g8JS5IXsMY+QLGWWbaoAlZU
	1FC3KehZtcI29RiFqAEzCimu27cXrd2IihU+dUm64PY98B0Rd4dwacfEXMFoZ8UL
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh766yq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:59:29 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62DBxSYC017677
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 07:59:28 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Mar 2026 07:59:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Mar 2026 07:59:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Mar 2026 07:59:27 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62DBx4aC024568;
	Fri, 13 Mar 2026 07:59:21 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/4] dt-bindings: iio: adc: ad4080: add AD4880 support
Date: Fri, 13 Mar 2026 13:58:52 +0200
Message-ID: <20260313115856.87763-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313115856.87763-1-antoniu.miclaus@analog.com>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Enu_lFGKeNGluaiWhEG_3s_dj0iQvxLu
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69b3fc21 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8
 a=eYjWAXzLS8b0uuH4XOwA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: Enu_lFGKeNGluaiWhEG_3s_dj0iQvxLu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NSBTYWx0ZWRfX6WoVWXxTbSCh
 t/iPW2Lb53ZRpmH3ZNyU5LT+TDvpAu3+EzHIPlU3BcDWjt5vuwdeO+dMub2mYCVJDP9NKLLlveU
 DmoYON2gVOpWH/k8Y3pI+usfgTnnYpJ1G2tYzBS9Sf0GBEbFVtFOD9Ypyf3/XQpQf0NBsy8PAC3
 /8HFuhmIyHFG2Kfl0BkFwWc2X14a4d59yQ6N+Kz6e+GXRlt5oFh9VteVZH5WGUdjTkRadnG6Mzy
 wm+G7lfRFc/58+h6OTLcDz+6tPactQO1WeHqZFFqiQAoWzO1JERc94U6lefgguuiXh6Nxbhqxqg
 +vgBcRqPPI4Un3Vt2oOgi2BlHRqo0UVCriRlFttdl9sRxSZCKFOBpAdjXZz5xBry7uTQFUDqvRI
 EamIW/afF98gKSyYWDcT6j9paN+hfTn5r8A+Tadtp5D0HUbaiFD22SV3vcWOaVx10AOIHvpp/dM
 TQ8O6hBeBk6rCU+SgRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130095

Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC
with integrated fully differential amplifiers (FDA).

The AD4880 has two independent ADC channels, each with its own SPI
configuration interface. This requires:
- Two entries in reg property for primary and secondary channel
  chip selects
- Two io-backends entries for the two data channels

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v6:
  - No changes

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

