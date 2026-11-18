Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007080;
	b=NO1QYDrm0LCYjoxw5gjFE/co7BFAavVetdsWh9Zo4o9EHFZOQJfn6FShiOInVUT+zrn7
	 RPm+EP/dGuu+OWlSTraToq/i8/0iKyTzaNjLShWMntZTqNcSuSgbJ6uWW4Ng9Di+aPMKx
	 DV8S8p2bZwrejaYfD1TG++FySZY76zgtau4m4On76KwTt0a9VTRcOPCM12QZiXz2cYkNF
	 0ikfYE8vhWeX1i8Cm2KdCQlfjjGVho546P0I2jnXqiSI6Gpkg1S97xZH5VhgAWC2Sipzp
	 lCr9RIBgkYZThxJ67XdnVanHlAYcRuDnM8UeTG85OQzEWA4mBIywgmtrJvgOrE9XK5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007080;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=WytguwQL+YIZp33ClOQsQPT4s6Puy7J/8wHyNMt3jP8=;
	b=PjAQCDF7Yek2W7o1s+qWWxtI0EUanHypi7eYh4jCO5PL1w7OdVwiNSHCryceyeVuRQXI
	 r08wsGV1dFTYMP6ceuaU45HWFRbIExDNoFgbgfTnOsBv2h9+myOqMBD9tce97npvvfn4y
	 Dxt3ghhnOIGGCEtJLMccYAURLS8lr0XmK157W+3MeQB8KauiVnCnPUo/A7fm4wilKDBs/
	 8ArTat7+xwSaTfzDUx43uydNVUD0ADZ2VkZYA3NtDUfsARd9FVFneDU2bWEpnkVpipGkc
	 zUfkvUvMnlzbSeZ+HRnpCLuHqidnmMU9R7ztpm4RQc7LF6YPCBhq9RHfISfP03z239g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=swXkZMnf;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=mPUdxPif;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E7606A320;
	Wed, 18 Nov 2026 13:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C0E7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=swXkZMnf;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=mPUdxPif
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIBK8tJ220404;
	Wed, 18 Nov 2026 08:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=WytguwQL+YIZp33ClOQsQPT4s6Puy7J/8wHyNMt3jP8=; b=swXkZMn
	fYBhv7aN/cKTGT6PacmyUjhTVhPkmpRaFYiz/of/sQ7cO7Okq0P9VJSJp8c2v/cI
	WA/6lriFDFubVWewEmtPhZbObAgStUnbKF+h5DVy6JkCG7mVLR3GrkRLb0j1fKQ4
	Z6T++G5OcT1M3PASLFWJ8KExvNxmK+Fkw9MAttABN0srQ2pGshgGjRYUDAE6rwXL
	dqKW6F7pVwVsMk0/dtw4Xui3s/Ut82l4CloqzDiFteIP0t4n/07AgBuDgGDRdzE8
	Gfq2P2WdS4OB9JrMPJZb1lco92Hppegnputxot1uIFVXP0P0L/oqKYKqhA+/OZ+l
	pkab8R4L+sUUnVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Wytgu
	wQL+YIZp33ClOQsQPT4s6Puy7J/8wHyNMt3jP8=; b=mPUdxPifYJgq+zsKiAtAh
	kUDR9BA/GgaEX7nbjNHbGD31cLahP7hyxBZFxk9fWdfwm6g9xW75vwj3hgdPNlL9
	heVJt9j/1hfsEprSXHSZBZKn9DWtiPcKgS2cpNupJrwx0oOfwujizxb9SU5JtZHn
	eHwwCC+jlvCexXJhET6zHwzi3sNfNpujnfOf+6/wo2j91vwoWus1BNgPO4NDL5YG
	uG1MXJQ8eO4QuBVnHGhWhFGb0Mvg6rYW0UJ2odkEPr3KZJJLtW+GcLNaBSdJjZ0L
	Wz8QZuk/g5UcDrV1dNBVwrezEa2c48e9XEyuwqKCn7XQu0boR/TvqOp4RaH3oxP7
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j173f1mqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 08:04:33 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6AID4Wu5057530
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Nov 2026 08:04:32 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 08:04:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 18 Nov 2026 08:04:32 -0500
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AID4I5c022837;
	Wed, 18 Nov 2026 08:04:21 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 4/5] dt-bindings: iio: adc: Add ADA4355
Date: Wed, 18 Nov 2026 10:04:13 -0300
Message-ID: <c7be62089d2b54dbf7fb57cdea189bdb1cade7c5.1795003864.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1795003864.git.marcelo.schmitt@analog.com>
References: <cover.1795003864.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: HnaCNQeyIZxLc1TzCy56TVEKjKNyiidf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfX1h8Y5Bg87s/4
 Nns0WpQolsEt7Z7JRg/KgMo5jI+u4XXvGPUBjQ5BJI9s6iucLoiMga7n5mtKmgK7CUERYUunxG8
 QFnGZ/j1LO4IoPmtawGuNRnqnaArWqHMM44+JB8NEFsw3V4LN1Sm
X-Proofpoint-GUID: HnaCNQeyIZxLc1TzCy56TVEKjKNyiidf
X-Authority-Analysis: v=2.4 cv=aKVlOr9m c=1 sm=1 tr=0 ts=6afda261 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8
 a=VwQbUJbxAAAA:8 a=Lu3cxi_TnMBPUMAntdMA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19
 a=sptkURWiP4Gy88Gu7hUp:22 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfXy42WpRE8r+ow
 hmVIHECY1J5LkfBOjuYxNzXV2fRHsPXRAEOcMbDW5C0rhGZrcmrP1RGLVUqwLnD1kGK+JDEEAfP
 TuL31h86yTdgwnz8lS3JzSJ25fnCQWTLo/QunAvtuDphNzjwWrS3A0UeyM5eZyxWt4+ZpL/hOYk
 Un90jabk+g+GxUh5S3GIHbuW8UmB2wsbKLMmM7Jywv55HhalcOkW+WKm/ps+WgyzR0S/+EGZfcP
 Uxw01SQrAeJ7FU3sBwbeGa8o0v6Aqd9qG0cdPGp10S7wr/z1KTkNScYwFcinDJ1t8XSwKeAN7LE
 xfxvDxts7eyR7789OCyOEa5Xq2iNVS8mdG0qfn6ojjKxJPCWrhnzFRUYMFgR9R8GaDTne5uZlSl
 UcA+zgyn5JNbZEz6VtyVO3eM+/OPH1dMZpCPwYwmEXlvQ7DMG/8tJOzUrRPmBaFA86R+KDskPci
 PQNYqnOLQFq3fIRRXkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180052

The ADA4355 is an integrated analog front-end and 14-bit analog-to-digital
converter with a serial LVDS data interface.

Document how to describe ADA4355 devices in device tree.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 .../bindings/iio/adc/adi,ada4355.yaml         | 104 ++++++++++++++++++
 MAINTAINERS                                   |   7 ++
 2 files changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml
new file mode 100644
index 000000000000..d169619fef25
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ada4355.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices Transimpedance Current to Bits Receiver
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+
+description: |
+  ADA4355 programmable transimpedance, current to bits receiver and similar data
+  converters.
+  Specifications can be found at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ada4355.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ada4356.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ada4355
+      - adi,ada4356
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 50000000
+
+  spi-3wire: true
+
+  spi-cpha: true
+
+  vcc-supply:
+    description: 3.3V power supply.
+
+  vea-supply:
+    description: 1.8V analog power supply to ADC.
+
+  ved-supply:
+    description: 1.8V digital power supply to ADC.
+
+  clocks:
+    maxItems: 1
+
+  adi,vld-en-gpios:
+    description: GPIO connected to the VLDEN pin for VLD output enable.
+
+  adi,gsel-gpios:
+    description:
+      GPIOs connected to the GSEL0 and GSEL1 pins, in that order, for
+      transimpedance gain selection.
+    minItems: 2
+    maxItems: 2
+
+  adi,lfp-gpios:
+    description:
+      GPIO connected to FSEL for internal low pass filter bandwidth selection.
+
+  io-backends:
+    description:
+      The AXI ADC IP block connected to the D+/- and DCO+/- lines of the
+      ADC. An example backend can be found at
+      http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+  - spi-3wire
+  - spi-cpha
+  - clocks
+  - adi,vld-en-gpios
+  - adi,gsel-gpios
+  - adi,lfp-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ada4355";
+            reg = <0>;
+            spi-max-frequency = <100000>;
+            spi-3wire;
+            spi-cpha;
+            vcc-supply = <&supply_3_3V>;
+            clocks = <&ref_clk>;
+            adi,vld-en-gpios = <&gpio0 89 GPIO_ACTIVE_HIGH>;
+            adi,gsel-gpios = <&gpio0 86 GPIO_ACTIVE_HIGH>,
+                             <&gpio0 87 GPIO_ACTIVE_HIGH>;
+            adi,lfp-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH>;
+            io-backends = <&axi_adc>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 02015eaec312..692f1e6d56ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1794,6 +1794,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
 F:	drivers/iio/amplifiers/ada4250.c
 
+ANALOG DEVICES INC ADA4355 DRIVER
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml
+
 ANALOG DEVICES INC ADE9000 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.39.2

