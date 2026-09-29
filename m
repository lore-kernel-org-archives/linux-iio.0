Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F7E4F55B3;
	Tue, 29 Sep 2026 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721908; cv=none; b=QMxkJtHuqdLfbBtxCGTF8MnXrAhXYdDSr1S+e/Tcd0YLRRxHATa9YwhzQJOq0f4eciUrb9UzVzRs8pLrrM080oZ7f5MFFQrF+tlyiIFwO11Zvdapvd2oT8vSeHsfGSY7qA4oeshFEx925PZkr4aOt9O1i3iCUmDBtkC2bUOL4uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721908; c=relaxed/simple;
	bh=ur822IBeb6Pw3f8vIHage0lYP2hVMjNxAjmg1WuLwEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAoase29asiJYngcjNgKUf1jgDRtVa+76TejoprOSmFOLFiZFu9XpV/ioZBKDMjXcXcL79LuB4gHC9TpOfArB5TOrFMNgkrEPQYM3fVNm4SzJG2j4bSKrT6g3pea8DRtI8oVO6ucxPeFdRMlWgNOBJ2IzECIzfbdRow0S5P0Csk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=O1VjAzdB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="O1VjAzdB"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TMVIl73743910;
	Tue, 29 Sep 2026 18:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=vNkT7
	709/acPBKYmD14H2G8rhCKTdDxsRzyUnMyPitI=; b=O1VjAzdB+BmsGQBzNDKTL
	uR7opDGeOWWZEVXvDHvBs+4EiN9yblf3SMScE8SC/H94I5hNiavCPYYm7PF7d0K7
	MlwoDlKTi5hmGXWKF6YqyqnueGj95R2tLvE3z2tkhAxH8/e6JtBaEsaK49lmbS/U
	IkwJtMj783sBTY91MFPEXgoJjxLlC2TRCp7W+ohoLbnYwJsZZxpqrrrdCQSocqqd
	tVWEQDRkF25zutgGuMFlgd/p+RKJJg0a2DKqJn0jBcv9wG0IZtIdzByjZkWIjiUC
	9xXHzb/NU5maC3VktHsAdPNFo7oYSrU20VVUblU1yGd37p/SwynjDNFcC5zYmTwi
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h0jhs94fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 18:45:01 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68TMj0Np041554
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 18:45:00 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 29 Sep
 2026 18:45:00 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 29 Sep 2026 18:45:00 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68TMilTd008215;
	Tue, 29 Sep 2026 18:44:50 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 09/13] dt-bindings: iio: adc: adi,ad4134: Document external multiplexer usage
Date: Tue, 29 Sep 2026 19:44:42 -0300
Message-ID: <4c6b88d4332a3fd6d4c3f7a65478b24d2015226f.1790719425.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1790719424.git.marcelo.schmitt@analog.com>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=ZbeIpcVA c=1 sm=1 tr=0 ts=6abc3f6d cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=HMTmhCiqWBRzuReh3A0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uv0ttospuJPMdjk-Os0FUlBLUwtGHDHs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX5hdtPjijHSYL
 Iq+LD60E2Yc+xNStFKpLl0dutjWcmSz+Yy0IreTn18I2qPEsU8jtOkf6Fmf593Ii5wQz9z0OLf0
 wLXmSIt1GHcgFYwDGb05nxTJt520pac2RhbafGLejSK4dJkVJWyV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX2F6qmzaX6Le/
 PuZgbWtGYdx8+PiWV9cVCYyOLWF2GJnXJoPxd+skylGlXkPaqzBu3btjHJ1GP+aObSR2MtrhSE7
 KqO2aE+7LmIKHogWrjEvnhKsbG8MuJXEe936A/0zHaES+uuvhBfBnCAjkRYtTv+KiDTpQfYZRpq
 MTQtFH3FcjOMnGN/I3PZpwrCSL0dll6BuAjskK4DfOFPfS3uFyWp6Ufy24fz+ndFhGncbYxf3kl
 QQEhiWCfGc+P8HEGyqjksOOIu2Ej67eUq7L7j0IMtJQ+Xb+govtTKc9gH1df9qDUaVizBS+d0L/
 Z0FLBAbCGagZCmf+i3aQgbjO7IIWeHbx9U3lnloQC4HEyHrtOs8cZqHqm+VjVR1+f36bwJJ+Sn2
 uTbfmK7nczfilfXhFshfdA0NpZPc+LKuB67hAsPH42efrSJUYP8+GW4iyhgOKY211gkFi2HAIHU
 dlrEb29Xpu0KoSxAetw==
X-Proofpoint-ORIG-GUID: uv0ttospuJPMdjk-Os0FUlBLUwtGHDHs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290090

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

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3:
- Included the example right away with the doc update that documents it.
- Dropped mux provider from offload example.

Currently, SPI offloading is only supported in 4 wire mode. So, offloading
wouldn't be usable if added before the 4-wire patch.


Detailed reasoning for the external multiplexer usage.

Before coming to the current solution, the following configuration was tried.

  +-----------------------+                           +-----------------+
  |       AD4134          |                           | SPI Controller  |
  |                       |                           |                 |
  | SPI interface         |                           |                 |
  | for register     SCLK |<--------------------------| SCLK            |
  | access             CS |<--------------------------| CS              |
  |                   SDI |<--------------------------| SDO             |
  |                   SDO |---+                       |                 |
  |                       |   |                       |                 |
  | Data interface  DOUT0 |---+---------------------->| SDI0            |
  | for ADC data    DOUT1 |-------------------------->| SDI1            |
  | read back       DOUT2 |-------------------------->| SDI2            |
  |                 DOUT3 |-------------------------->| SDI3            |
  |                 DCLK  |<--------------------------| DCLK
  |                 ODR   |<------------------+    +->| Offload Trigger |
  +-----------------------+                   |    |  +-----------------+
                                              |    +--| PWM1            |
                                              +-------| PWM0            |
                                              +-------| GPIO            |
                                                      +-----------------+

Though, because DOUT0 never goes high-Z, the DOUT0 pin keeps driving the data
line, causing register reads to fail.

Alternatively, we could have something like

  +-----------------------+                           +-----------------+
  |       AD4134          |                           | SPI Controller  |
  |                       |                           |                 |
  | SPI interface         |                           |                 |
  | for register     SCLK |<--------------------------| SCLK            |
  | access             CS |<--------------------------| CS              |
  |                   SDI |<--------------------------| SDO             |
  |                   SDO |-------------------------->| SDI0            |
  |                       |                           |                 |
  | Data interface  DOUT0 |-------------------------->| SDI1            |
  | for ADC data    DOUT1 |-------------------------->| SDI2            |
  | read back       DOUT2 |-------------------------->| SDI3            |
  |                 DOUT3 |-------------------------->| SDI4            |
  |                 DCLK  |<--------------------------| DCLK
  |                 ODR   |<------------------+    +->| Offload Trigger |
  +-----------------------+                   |    |  +-----------------+
                                              |    +--| PWM1            |
                                              +-------| PWM0            |
                                              +-------| GPIO            |
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
                                     |      +-------| GPIO0           |
                                     +--------------| GPIO1           |
                                                    +-----------------+

By being able to mux between AD4134 SDO and AD4134 DOUT0, the peripheral can be
connected to a single bus such that controllers able to read from multiple lines
will be able to gather ADC sample data from all SDI lines (SPI_MULTI_LANE_MODE_STRIPE).
With that, AD4134 maximum data throughput can be supported with what is already
available from the SPI core. See additional details on the AD4134 IIO
documentation (patch 13).

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
                                              +-------| GPIO            |
                                                      +-----------------+

That may be a fallback option if what's currently being proposed fails to comply
to Linux code standards.


 .../bindings/iio/adc/adi,ad4134.yaml          | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
index 0b2a2cbfadae..27de44719903 100644
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
@@ -225,4 +239,37 @@ examples:
 
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

