Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795816448;
	b=eQg/KLrzDH6JHeHylndr4qRANgkWulA6TuEObdgrI78mQjrsBmiqpGJEhw46on0U5jnP
	 LwVfx/OJqUQcV/30NJ+7ps4Ip2GxWCtWm8ShbR7DBgAWpfOYKm2cPrJd4seU5zI0Larsm
	 xdP3pEBRLaqk5WSSkAp0OplyY6T6E96ox19CSd+nJD7K3ngWl1dng0TQoClgHJa0Eqiee
	 wCMtIo4r7ra2YomKpJVRb6OV9jSb3J4hHavOdxsv8SUYrQ/tzKeCdSohQwIhibUJvDPBH
	 Ti0L9a5rBCMocGxDyDrWJa8/egz/24HetM8kLp4kEb3wb4wGxS0tz9fGQfJQ8LZWXsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795816448;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xIqzwLkZU5EfKZKIc/2sUVTI5u1Cb3o64Zs4iayr998=;
	b=bv2yHn1ghn7S3zvsswGBFNlkwDg6pL97eSHuiYZ5NvPnHP4Pn9Ro+O0Kx6WGmVdDHkaN
	 zfAZ/eHPgZpoSMnkCjn0j/IqsMIh8ne7XP/jQ5gn9txmMlQHJ8dM5pfvN4/z1oZayMKrU
	 ZOLVHAJX35ZHrGLQLA1BeFaEa/WQVMJFp7JUs8h2KwaOGWL8d7LzhGDkFUcWKpgtQ41+A
	 tlAXtw91MWgobUTju69dx2BKUhh3hD/K4fDSXTzU4xbmgOzQ+uwRVTStXTW2hjDH1L4O2
	 egHpMpaP3AO7OuziFXuADajm6Nle7aBTu8fdE3uoCCeZR4+nyVLyDwPppwdtCpf2Dog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=jhU0cfVz;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=TyPX+DM7;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486E2606A324;
	Fri, 27 Nov 2026 21:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 486E2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=jhU0cfVz;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=TyPX+DM7
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARJCVOK323145;
	Fri, 27 Nov 2026 16:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=xIqzwLkZU5EfKZKIc/2sUVTI5u1Cb3o64Zs4iayr998=; b=jhU0cfV
	zwQqocnaBo6+uNNiXLZtmUXPkIDKudq74B3SUslpabbiYv1EwSs19YgD5dYmTgHn
	Ao9HiQ+4qndUDAtfXRkEbtcvPl7pFEPHUT6vn/fNoDgTwu9aifL5aXMbtCCm/LTo
	40Cl6u+PAO/P1eFH9B37ol5E8jdqNZaJMmlCtttm1nISv2Ypz6mBGPUbsbvqFfbM
	DfFL3LgMOHhVt3R4ka6AWXIUCeAaueYeAF7rCTUtQEayyPKeFn20R9mI/H0rs7/K
	hq/3AgL6VeBhwgiWQWLQlFUec+tuUJo7iSxNjRpS56W3hOFtSvtFMPyQHdEq8N1O
	tQuOaUAc9yABAbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xIqzw
	LkZU5EfKZKIc/2sUVTI5u1Cb3o64Zs4iayr998=; b=TyPX+DM7GRJinwylQV0Rp
	P7IizmcnbVh3S9uV1RfiitS4EIKnIVkGegT9o5fe/n7fVk4zS1sbFlh4RW6g+12F
	tpKWoYZ9RgoNLO+zet3u0zRZXz2nRdAZlBvNYCXGzNlxbt17w21wnCrgRG81cHQX
	csXKRF9WrGrtXpM7P1acLfWYQwFoOC09dbXlHshQWz6o7zd84iD6GLctFtwN4I45
	jdwv/mbBZx4owPWJOBYYlh81ZTxW/UUSYnRXKRObeuPa4rbghKPUsFGaMpnFK+Le
	5VWJeFdXN8AdBLq6MslvCZ1xjoEPaa/LvvyfwhjEKh6UZvfzkojqKXb5EqwuzGQ8
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j5uq96bmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 16:53:49 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6ARLrmNu014124
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Nov 2026 16:53:48 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 27 Nov 2026 16:53:20 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 27 Nov 2026 16:53:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 27 Nov 2026 16:53:19 -0500
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6ARLr5bX018647;
	Fri, 27 Nov 2026 16:53:07 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 4/5] dt-bindings: iio: adc: Add ADA4355
Date: Fri, 27 Nov 2026 18:52:57 -0300
Message-ID: <8813d3f0e71d8917d13db74e4432002bb57548af.1795816065.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795816065.git.marcelo.schmitt@analog.com>
References: <cover.1795816065.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: oLWM22q15wpWwXTSnUWyGQPNyni82xq4
X-Proofpoint-GUID: oLWM22q15wpWwXTSnUWyGQPNyni82xq4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4NyBTYWx0ZWRfX3BAsmc7Q6+s5
 g9WPoStlPTkpVrwbNh7H8LVQ7Q7Ok+OY+r+Eg+Bmg7HIHIMBFWSCmqzrefCvF69Sgt7a0yQcdYK
 qXbixNdEx/enho0AS9Ilizfz5c6PxDsaZUkL6iiQM0uKEtsJ4YoF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4NyBTYWx0ZWRfX9Dgtqd8Bn1T9
 4IYfKhu85gN6xMGENq8aa8YCTuba74c4XXvL1Yy+8AGekISM2GOtXd+YGBLpS3ow0KR5Ia2/CGZ
 kxOyeIxb760E7kxJQFBvB3d2Qp8rF05o/lMRdDFtkQmydySp5vDG7WyvbPl/XziHqdIaVavirpn
 4TVMKx4vfDnC9uCVGF2kL2t4CchuMuEGbJYoF3TfoLTWwKxAi1s52/bt9VfOnEOQLtmKA9ngM5C
 OxgOl41jPSzAiXKDTXaZgM0OGToUM/juWAU/0u/bhElBZCi2st5kPxeWeTWF3wRVOxjFA5V4DC1
 x2NVu/FXE7pm5mMGoNr19aRfotf12uBVau28DwIE+vMLL8+d+v/mhbOtq+24j2LNC1PGbclLtdr
 dyRv8TJaDDjJ5gce4Z/e15Jp3e91QcWWZbAh43kosmZ9i7mT+YkAJWkEDIZPFHR6nsg+aIa+M8y
 W90DKGIHqS+mUIx4BIA==
X-Authority-Analysis: v=2.4 cv=OozaWC/t c=1 sm=1 tr=0 ts=6b09fbed cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8
 a=VwQbUJbxAAAA:8 a=Lu3cxi_TnMBPUMAntdMA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19
 a=sptkURWiP4Gy88Gu7hUp:22 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270087

The ADA4355 is an integrated analog front-end and 14-bit analog-to-digital
converter with a serial LVDS data interface.

Document how to describe ADA4355 devices in device tree.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
ADA4356 has a different set of selectable input configurations that leads to a
different scaling factor to get to milliampere units. A system with ADA4356
matching/fallingback to a device driver only supporting ADA4355 would get the
wrong _scale from the IIO device driver. Users would not be able to accurately
read data in milliampere units. ADA4355 cannot fallback to ADA4356 for the same
reason.

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
index e8d3e5a0665b..131ff62949e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1796,6 +1796,13 @@ W:	https://ez.analog.com/linux-software-drivers
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
2.53.0

