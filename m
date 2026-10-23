Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795026;
	b=AKBd3Vsvku0U6NDqbsUyX/i5kkUO8Ty7n5hs+bud9ZJJVuzoHeU9HF6BxQBqwx1e2829
	 GBzjPXGphKWnNsgE/op86vajv7zsL/230WQZnjYqu08HoaJ8g+tlBO8vdLb5gAt+4COfq
	 DwPnTN9dgqSLGQ23n+GO0ant9OiCfq0rhdPZhHeIX4+/RhKq/gMWj9oZGaxXobOvFLYT7
	 rUXM/24EiVTLpLjGcRjEnIY84QB82LewdYlgoOxtJUT42GLUgdcSBp4aKOqZiBSUVUlV6
	 HBBkDyTK4p+vHQsioZsO+zU7wzV7wZ16Aa+6FlFbBnWdKuLLvvpGjmqF7OFIGXPCU/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795026;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0NpBF5jlXSadUrdGU8po/2HvHyd2DcN9ss7NxsUtJoU=;
	b=TLbl5e57EseD0bQ1YELtn4RDSNr+xQAv6jwdka2k0yrXpYFZNsDoPhmSLZzuhvJlW8Ce
	 bs2DJ3Cl4w5FBlwO7eIY5PiBp7giTL+vgPSA3Hon2yAv0VbJe2kviVdX9FeblTu5/VV9c
	 tK02hNX39/EPLdXb3IAcqpWPkglIpaRxyRL/0MW8c58A5z7J2sPOf+0YYxwUKXZ7Jt+/U
	 bIIi6wWvQisijuzzFlc3Tl1UQj72I4HMHbipCH/JuKb6cXU59u7Y5wsR/Ma5fvyN9QraE
	 JfBpB6Gp41myz7CpHZSrQLOWWtjJ5HXG2/71fX/MJPrlyVbCzSAX9QfR7ABitq6JiFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="TFErbH/5";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=MuAJSIlI;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F8F606A325;
	Fri, 23 Oct 2026 22:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0F8F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=TFErbH/5;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=MuAJSIlI
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLukqC1124440;
	Fri, 23 Oct 2026 18:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=0NpBF5jlXSadUrdGU8po/2HvHyd2DcN9ss7NxsUtJoU=; b=TFErbH/
	5qyWdhAZ6dbq/Ny90Mjgrdi9lR8aJ793TAy/K7iw0iKuMpJxI/hh1ZWHAGJ8KdbH
	sW5u9SLBbVfOEgfc3iZ8A1Dh2z4mY/Unb3rdSSv4GN+aqMrSbGNByVkoqxoHg5Nk
	fbchCudNFD4I2+3SBjcTmlpOW0T59Wc/phc6LDBL3btFNkoXukVlAICrC92b0xeS
	xXgvTFFdTjp1pJnJKq6/pxYRFnnndoQWznJiJDViJoRAiiI0xnCDylJz7PjXrCDC
	EjKoNOxeBN19/YCMS+D4niCXKGaPYAF4vwT3zATKJq0NHK/j81VJyUy/D0blXwkt
	GpuhiugB1cn630Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0NpBF
	5jlXSadUrdGU8po/2HvHyd2DcN9ss7NxsUtJoU=; b=MuAJSIlIOyjMFgJ7sQ2ii
	s35Ns4p0EQSFOvaa9FHjhFwrZtNPfeteSByh4tJtdB2hAEtGY50yjVA6E8/siDGm
	cg6lJPyAT6ce1/ReIAGhe1VVEtZb3nxNGmrHPzESB+wwzRiLPnssOf6tesBaPBmz
	GZfYu9+bc8u6GS4s9KXFSjgmXCOKSDXhMlE09QvciEe5YVdgVFUsFsTdnhYo8z8R
	ZQQrDJjDvpTutzxNb8ZLWDJT2wikW4OpfM1/y0eCaRYemrBYxvUS+ExfFh+3cLmd
	5RM6WBdSz8f58ZfvKhjpQHxqRFX7BuzWOxIURKZnA16xJ9Dxl+vX0May61A47gFM
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hgcnbs3c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:37:00 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69NMaxU1017703
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:36:59 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:36:59 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:36:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:36:59 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMajJV005902;
	Fri, 23 Oct 2026 18:36:48 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 12/16] dt-bindings: iio: adc: adi,ad4134: Document external multiplexer usage
Date: Fri, 23 Oct 2026 19:36:40 -0300
Message-ID: <c374e74a66a2ce78fef02cfa2b270c4c5d310b3a.1792792325.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792792325.git.marcelo.schmitt@analog.com>
References: <cover.1792792325.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfX0F2i/0zqY+2O
 J9zutIaF6/uVOrL3yX7eN3B+IjRlf+nA8hhmg0aJsByBxK5S2wzAn8bd+0NEs5HRGwwx1xuYDxd
 OdKQXAo0iaI3lpnCVsQNNz6Ry57uOA7EemW98nLWjZ4I50j4SwM5+sIqWnupE0KBOLIRdiC3kMy
 MQqYhwi0t5c19WCLQiiKlsS8/zHGheCYYD0goSIBAJZEsDRBrcS0SkqAyE/f5GZXi0NMnIwPnru
 uaN56Oh3ML2CCeUmpiUQoAtj9qZQlP3QWrylmEcuK/TyYQ93dz65sBgA8RbhL2JWsC2U5MVSBNs
 rn7Pj8tsnPUr0732hYvXWYeuhGlxp2jx+Ore5tpMHQu01NFljlfcJ1by6LO4S/Trvzkf7+sVtW9
 86WDJAorroL6521EvCAu0IptPgDYyLuKDc5Sc8zQvlV9pzA/ct+1588sgfZbGt1r672One0Z86q
 89h7HSt/fD2yh996/cQ==
X-Proofpoint-GUID: 67RebiDDB-YBqthNwrKYmNA1URUed9Ve
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfX6rik37MFljOb
 jlmm6OegyrPtsbJ0l90bNSB6S5DQLEJnZRbCTX0gpZIpm/gTdfmgEBh1EWkLLqUs+7lidB1gM7I
 sZXpNZ8tqeICKLk8eXMhhIH+xls67PX9c9aX+HsyrI0afHqlskg0
X-Proofpoint-ORIG-GUID: 67RebiDDB-YBqthNwrKYmNA1URUed9Ve
X-Authority-Analysis: v=2.4 cv=N9e8hG9B c=1 sm=1 tr=0 ts=6adbe18c cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=YjmlrVWy-zMJPE8JoxkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230089

The AD4134 design has two data interfaces. One interface allows register
access for device configuration while the other (separate interface)
provides ADC sample data. One way of handling both peripheral interfaces is
to merge them into a single SPI interface by switching between register
access and sample access according to device user requests. Though, such
solution requires extra hardware, external to the ADC chip. The access mode
switch can be done with an external multiplexer selecting either AD4134 SDO
or AD4134 DOUT0 to connect to the controller. The external multiplexer
becomes part of hardware requested for AD4134 device operation and thus
must be provided for operating the peripheral in such merged interface
schema. Still, there are alternative ways of handling the two AD4134 data
interfaces so the multiplexer is not always required.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No change in v6.

Detailed reasoning for the external multiplexer usage.

Before coming to the current solution, the following configuration was tried.

  +-----------------------+                           +-----------------+
  |       AD4134          |                           | SPI Controller  |
  |                       |                           |                 |
  | SPI interface    SCLK |<--------------------------| SCLK            |
  | for register       CS |<--------------------------| CS              |
  | access            SDI |<--------------------------| SDO             |
  |                   SDO |---+                       |                 |
  |                       |   |                       |                 |
  | Data interface  DOUT0 |---+---------------------->| SDI0            |
  | for ADC sample  DOUT1 |-------------------------->| SDI1            |
  | data read       DOUT2 |-------------------------->| SDI2            |
  |                 DOUT3 |-------------------------->| SDI3            |
  |                 DCLK  |<--------------------------| DCLK
  |                 ODR   |<------------------+    +->| Offload Trigger |
  +-----------------------+                   |    |  +-----------------+
                                              |    +--| PWM1            |
                                              +-------| PWM0            |
                                                      +-----------------+

Though, because DOUT0 never goes high-Z, the DOUT0 pin keeps driving the data
line, causing register reads to fail.

Alternatively, we could have something like

  +-----------------------+                           +-----------------+
  |       AD4134          |                           | SPI Controller  |
  |                       |                           |                 |
  | SPI interface    SCLK |<--------------------------| SCLK            |
  | for register       CS |<--------------------------| CS              |
  | access            SDI |<--------------------------| SDO             |
  |                   SDO |-------------------------->| SDI0            |
  |                       |                           |                 |
  | Data interface  DOUT0 |-------------------------->| SDI1            |
  | for ADC sample  DOUT1 |-------------------------->| SDI2            |
  | data read       DOUT2 |-------------------------->| SDI3            |
  |                 DOUT3 |-------------------------->| SDI4            |
  |                 DCLK  |<--------------------------| DCLK
  |                 ODR   |<------------------+    +->| Offload Trigger |
  +-----------------------+                   |    |  +-----------------+
                                              |    +--| PWM1            |
                                              +-------| PWM0            |
                                                      +-----------------+

The downside of the above is the peripheral would need fine-grained config of
controller SDI lines to only read SDI0 for register access, and only read SDI1,
SDI2, SDI3, SDI4 for ADC sample data (currently available
SPI_MULTI_LANE_MODE_STRIPE reads from all SDI lines).

The currently proposed solution looks like the following

  +-----------------------+                         +-----------------+
  |         AD4134        |                         | SPI Controller  |
  |                       |                         |                 |
  | SPI interface    SCLK |<------------------------| SCLK            |
  | for register       CS |<------------------------| CS              |
  | access            SDI |<------------------------| SDO             |
  |                   SDO |------->|¯¯¯¯\           |                 |
  |                       |        |MUX  >--------->| SDI0            |
  | Data interface  DOUT0 |------->|____/           |                 |
  | for ADC sample        |          ^              |                 |
  | data read       DOUT1 |------------------------>| SDI1            |
  |                 DOUT2 |------------------------>| SDI2            |
  |                 DOUT3 |------------------------>| SDI3            |
  |                  DCLK |<------------------------| DCLK            |
  |                   ODR |<----------------+    +->| Offload Trigger |
  +-----------------------+          |      |    |  +-----------------+
                                     |      |    +--| PWM1            |
                                     |      +-------| PWM0            |
                                     +--------------| GPIO            |
                                                    +-----------------+

By being able to mux between AD4134 SDO and AD4134 DOUT0, the peripheral can be
connected to a single bus such that controllers able to read from multiple lines
will be able to gather ADC sample data from all SDI lines (SPI_MULTI_LANE_MODE_STRIPE).
With that, AD4134 maximum data throughput can be supported with what is already
available from the SPI core. See additional details on the AD4134 IIO
documentation (patch 15).

Yet another possibility would be to have the peripheral sitting in two buses.

  +-----------------------+                           +-----------------+
  |       AD4134          |                           | SPI Controller A|
  |                       |                           |                 |
  | SPI interface    SCLK |<--------------------------| SCLK            |
  | for register       CS |<--------------------------| CS              |
  | access            SDI |<--------------------------| SDO             |
  |                   SDO |-------------------------->| SDI             |
  |                       |                           +-----------------+
  |                       |                           | SPI Controller B|
  |                       |                           |                 |
  | Data interface  DOUT0 |-------------------------->| SDI0            |
  | for ADC sample  DOUT1 |-------------------------->| SDI1            |
  | data read       DOUT2 |-------------------------->| SDI2            |
  |                 DOUT3 |-------------------------->| SDI3            |
  |                 DCLK  |<--------------------------| DCLK            |
  |                 ODR   |<------------------+    +->| Offload Trigger |
  +-----------------------+                   |    |  +-----------------+
                                              |    +--| PWM1            |
                                              +-------| PWM0            |
                                                      +-----------------+

That may be a fallback option if what's currently being proposed fails to comply
to Linux code standards.

 .../bindings/iio/adc/adi,ad4134.yaml          | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
index 970e7adb2405..c70b9113cd67 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
@@ -104,6 +104,20 @@ properties:
       GPIO connected to ODR pin. Used to sample ADC data in minimum I/O mode.
     maxItems: 1
 
+  mux-states:
+    description:
+      mux controller node to route SDO and DOUT0 signals from peripheral to
+      controller.
+    maxItems: 2
+
+  mux-state-names:
+    description:
+      mux state names for routing SDO and DOUT0 signals from peripheral to
+      controller.
+    items:
+      - const: data_read
+      - const: reg_access
+
   adi,asrc-mode:
     $ref: /schemas/types.yaml#/definitions/string
     description:
@@ -231,4 +245,37 @@ examples:
 
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4134";
+            reg = <0>;
+
+            spi-max-frequency = <1000000>;
+
+            reset-gpios = <&gpio0 86 GPIO_ACTIVE_LOW>;
+            powerdown-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;
+
+            clocks = <&sys_clk>;
+            clock-names = "clkin";
+
+            avdd5-supply = <&avdd5>;
+            dvdd5-supply = <&dvdd5>;
+            iovdd-supply = <&iovdd>;
+            refin-supply = <&refin>;
+            avdd1v8-supply = <&avdd1v8>;
+            dvdd1v8-supply = <&dvdd1v8>;
+            clkvdd-supply = <&clkvdd>;
+
+            mux-states = <&ad4134_sdo_dout0_mux 0>, <&ad4134_sdo_dout0_mux 1>;
+            mux-state-names = "data_read", "reg_access";
+
+            adi,spi-mode = "4-wire";
+        };
+    };
 ...
-- 
2.53.0

