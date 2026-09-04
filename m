Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17A3F5BD4;
	Fri,  4 Sep 2026 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510979; cv=none; b=UK5RzaSinE/OiuKXYFq2LL2vNys9MDMCKgLJkhiCoeXUUCMcKF76HhQ/nKhh1A9wfRaZNTpI81Znv4LuAYMdGG2tHAm4J4YlndUVvwZiuYpjvpdkkvV5aAXwjudbONF0MR8JIN2lYrKF5Mga1CFf45XxFiuxEqtoxITazVj3jtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510979; c=relaxed/simple;
	bh=TvPidjlBaIkYJsn84IgxPnTGakN0d+6vVn3HXZbCFIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gozulENR+j2kq1DRWPG2IVBR+lGTNusQKVazwY84JiADMllsSdeYiUVNN3orijr2lLX1ZEBRF6JIga9uku8msPAwOVuDFzosIbvyFkoXCcOA/ui6L4dT2IeUlPNM79eRGRuYNhL4gDnK745hcYfCI1WVuUt4PhI53UrmuP+x+vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=B9TH3Z5p; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="B9TH3Z5p"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68463h823811518;
	Fri, 4 Sep 2026 04:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Gy07X
	EuBY+cJCxSsMUxYGLoBwkoQyj0bvHApEBgrY38=; b=B9TH3Z5p1v3JF42NPqVFO
	+WvnMkmGTl9NSNSBLz9o/fwz35RgH3hBhmtMmA17VkfeMSw69T4dM7G3UIQt5n1D
	6cwWe52HUpekunuuPWTYn2uTeUC2LSQV5qGuyKhcGLiMyzvNjIyKyyfaD0uL5FeX
	5FX4AJ53frccVWCntWVScGs1oLfLsxEPPM+VQpGu3VFvoAR0DTrKNtHK68h2/zIb
	Pr/0gtlMNXMG/0g8ylE8r7Ttyf/zXe6J/pjphGnHv9CUexIO/TNCo0bulHTlzeN7
	SbAhnRAIF9WTIWlpGlL+LU8X0kVA5PKb59WMbX+q46VMoZKhP+whZjSerabR5ENk
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gffk4tva6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 04:36:11 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6848aAEM007238
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 04:36:10 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 04:36:10 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 04:36:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 04:36:10 -0400
Received: from 10.98.41.145 ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6848Zjj4026621;
	Fri, 4 Sep 2026 04:36:02 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Fri, 4 Sep 2026 16:35:25 +0800
Subject: [PATCH v5 2/4] dt-bindings: iio: dac: add adi,ad5710r.yaml
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260904-iio-ad5710r-upstream-v5-2-76f985b7d0ee@analog.com>
References: <20260904-iio-ad5710r-upstream-v5-0-76f985b7d0ee@analog.com>
In-Reply-To: <20260904-iio-ad5710r-upstream-v5-0-76f985b7d0ee@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788510945; l=5283;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=TvPidjlBaIkYJsn84IgxPnTGakN0d+6vVn3HXZbCFIw=;
 b=3odpBgg32R9le8Gw+7Z5NZvXqnVWI/cPh2Ev2AaswewoWsJUQuP7sw3Qhnlspk3L0pHq/Ca+l
 GIypXJh02NMDdcPxfYenpMsOgdSZM9RO7ZdO3h+slqn0cMfUut2I7F5
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA3OCBTYWx0ZWRfX1jXC7zH35F7u
 2En1NC7RW104SbkIS02u4x7caJBGWaMp2tSAuunzZyN4b08GuFhtso/9ulRO6GHA0FsYBB/Dpcp
 BOCVgwP0Ph76arAFXgc3pf+p13vj72St6rNBnmrY0EnSQ5Foe0AiIqUh0fAftFhgEoJVBzBSd8y
 EeLSzz2ud9TI39g88QVcgY7/N2+2F1FqL2kLB5ym2DXRJWHyUGaC2M2ftPBg5rzk+NWhW17S/Q3
 qgp1OjHFv6lz4xOvYUOAVsYexIcz0+R0oMmUfeKpQVgs+EwpOZNTUHFQ5CmgD+I3FxfBYfSMoB2
 T0/T/lnMR6QQEVsJSFCCZ592opK8HYE6euRSQAFmoVIbZIlMoFPArqcUNZRjjW7iOX8mbEZLQDs
 gn3MZf3FVO0sFJGJTRF6v2QKGeYwXbfRlRrLYQOsOXL+seDkgxXjDdu3NfPEaNknJt0dkA7JPUC
 kTc5uiOKW76xZlZnADA==
X-Authority-Analysis: v=2.4 cv=QI1YgALL c=1 sm=1 tr=0 ts=6a9a82fb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=UDoUUgFuJgqny170jhoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: xWBlLkJyfGVHyIBcPBnpkybubzQA1mpF
X-Proofpoint-ORIG-GUID: xWBlLkJyfGVHyIBcPBnpkybubzQA1mpF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA3OCBTYWx0ZWRfXw5r8IR3LESyU
 nr7Im9qBma4QnqtBM0BjIJd7Sep16FQLzu2pBSMCleu8abUlAn58IxVTNSR0uWAngDDGj1eC6je
 DBwhNPZSxu80GZXpLqpsuxTot2c5ytgbjUsvWLi3lczyiy9JBImo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040078

Add device tree bindings for the Analog Devices AD5710R/AD5711R
8-channel 12-/16-bit Configurable IDAC/VDAC.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 145 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 146 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
new file mode 100644
index 000000000000..cdcc3da4f4ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5710r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5710R/AD5711R 8-channel 12-/16-bit Configurable IDAC/VDAC
+
+maintainers:
+  - Kim Seer Paller <kimseer.paller@analog.com>
+
+description: |
+  The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
+  configurable current/voltage output digital-to-analog converters (DACs) with
+  an on-chip 2.5V, 3ppm/°C reference. Each channel can be independently
+  configured as a voltage output (0V to VREF or 0V to 2 x VREF) or a current
+  output (0mA to 50mA). These devices operate from a single 2.7V to 5.5V
+  supply and are guaranteed monotonic by design.
+
+  Datasheet can be found here:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5711r-ad5710r.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5710r
+      - adi,ad5711r
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  vdd-supply:
+    description: Power Supply Input.
+
+  iovdd-supply:
+    description: Digital Power Supply Input.
+
+  io-channels:
+    description:
+      ADC channel used to monitor internal die temperature, output voltages, and
+      current of a selected channel via the MUXOUT pin.
+    maxItems: 1
+
+  ref-supply:
+    description:
+      Reference Input/Output. The voltage at the REF pin sets the full-scale
+      range of all channels. If not provided the internal reference is used and
+      also provided on the VREF pin.
+
+  reset-gpios:
+    description:
+      Active low signal that is falling edge sensitive. When it is deasserted,
+      the digital core initialization is performed and all DAC registers except
+      the Interface Configuration A register are reset to their default values.
+    maxItems: 1
+
+  ldac-gpios:
+    description:
+      LDAC pin to be used as a hardware trigger to update the DAC channels. If
+      not present, the DAC channels are updated by Software LDAC.
+    maxItems: 1
+
+  adi,range-double:
+    description:
+      Configure the output range for all channels. If the property is present,
+      the output will range from 0V to 2 x Vref. If the property is not present,
+      the output will range from 0V to Vref.
+    type: boolean
+
+patternProperties:
+  "^channel@[0-7]$":
+    $ref: /schemas/iio/dac/dac.yaml#
+    type: object
+    description:
+      Represents the external channels which are connected to the DAC.
+
+    properties:
+      reg:
+        description: Channel number
+        minimum: 0
+        maximum: 7
+
+      adi,ch-func:
+        description:
+          Channel output type. The values are defined in
+          <dt-bindings/iio/addac/adi,ad74413r.h>. Use
+          CH_FUNC_VOLTAGE_OUTPUT (1) for voltage output or
+          CH_FUNC_CURRENT_OUTPUT (2) for current output.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [1, 2]
+
+    required:
+      - reg
+      - adi,ch-func
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - iovdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/iio/addac/adi,ad74413r.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@0 {
+            compatible = "adi,ad5710r";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            vdd-supply = <&vdd>;
+            iovdd-supply = <&iovdd>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                adi,ch-func = <CH_FUNC_VOLTAGE_OUTPUT>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                adi,ch-func = <CH_FUNC_CURRENT_OUTPUT>;
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 48dcb8b10743..edb5a5b871d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1468,6 +1468,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
 F:	drivers/iio/dac/ad3530r.c
 
 ANALOG DEVICES INC AD3552R DRIVER

-- 
2.34.1

