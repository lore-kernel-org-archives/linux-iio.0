Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC13388860;
	Sat, 17 Oct 2026 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202406; cv=none; b=D5RUWDOpvLH5VwUXw4ayNzN3ekYrei2wz+PSxIZu+KUJ/rEnkx0P/ZBs2X3I4bTekGEFyj2lDz8eNAqK64uP4hpuV6QKaZdZ1wuBclh8k1jzVabK9yDnueN+U99mS/U1ISdOy3x6xBLrK4VgBc8X+KWFZpyZAy7HoZrps3ueuL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202406; c=relaxed/simple;
	bh=+2uk+4FzgdSHxnj97tr6Ts02zjf7oGXGwkLS+GcEQT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUPhSwOhHsmq/DIK3jgaCfVKck8+7f863D4PHyjhwgUq805p5EHIzwErs1V66pdMpD9nPf6O1rrwpLsYENsFqP+b0Ns64bvLocklrEW1zahHB5Rj5nSJmM4hzASXsVmnCtDlbYXiL9J2uhqfrVXXNx1Y06vnh383MtXAZQMOo6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=flqTaKvV; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XC9Ya4Mu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="flqTaKvV";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XC9Ya4Mu"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNHR3Z2680404;
	Fri, 16 Oct 2026 21:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=/oSENRYU/f1gFdSoue38GYwJjN2xx8Q9K9/rYelvQ5A=; b=flqTaKv
	VPFDMD7+QB1KqOSQCNJuN0oPbjkbgGnlbvY2dH4B7jM5XgTIo85HSq0j8K50XMCa
	V8olbhlmthMtK8S4eOXaSPX+vB+7If0ZdMcQf0pj89FgSGfbe36OVUwN/IG5+82K
	wmD3saSGlLdSA2215lbuuI/zrxYRFSHU8Isrm1uEtTdg4P3K2Ja0A0BkR8UbAA44
	A1F6Iv0CU55fwBKISOWlHST/uC9sGNXzeZYr0Jze5h8Z8n4OVtCyH5N7ZI6ryDDt
	7key3Jb8g0Guj0JO11w/LARPXa+e5p9xstCfoV9tRA0bcNE2pztdgWS2HcbiVdsw
	Q7fcpk1CShyViYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/oSEN
	RYU/f1gFdSoue38GYwJjN2xx8Q9K9/rYelvQ5A=; b=XC9Ya4Mu7ouYF06H2xKun
	pRrl4ov/VEy65LIKEmQ8hOtMOmEIwMeL9JvZ35a60IHDQGqc0p/2G/fNokzcodJt
	/c+mkCDrNIHUV5KGBGIS+SSdhGEtzSCdGFHRwfqBQ5akc6D4cUqz8VNcpXeCItEe
	Br+nrOUJp0xnZMLnFvbTjKY1kJn5KFSEBTXIMnwTPg5UUZKlgLJ72Er1D+/p8MTx
	raLHgAZBfSAiheWD0/zOFmYFJXixfw18jwxaf8/RADa+Wj/TEfqo4ReXaost52dn
	Ogk39QNtbBdfs87VuPm9CP1V+3lAjROIGjErKazKkLK+yzis9B94v9aAJfThniqo
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hbmr4uam8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:59:59 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69H1xw05062054
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 21:59:58 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 21:59:58 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 21:59:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 21:59:57 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H1xii8004357;
	Fri, 16 Oct 2026 21:59:47 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 11/15] dt-bindings: iio: adc: adi,ad4134: Document external multiplexer usage
Date: Fri, 16 Oct 2026 22:59:37 -0300
Message-ID: <a56b7a7cb11cab2ef857a82058a0197bd1d84966.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX7eWenZJ1TJyq
 eje3MPeev96UWUco51Dbp7a940xHwveSYG+u/IUUolNh9knHqv6uxDpqCWBULow1Uz6YLO4kbei
 dV82dHsVfaoP51QrSsfqekK/TK5rJsTVQAeYs+93C/neXj9FKH58vcdZPFks79oOcpYmt4LXww4
 ZH1J/BqfdfIycaajl4Ts4xjmBvQxx0odzgCF3AVSGkhZ8bpjegX1B1sK8nchseqbcvXvz/XYQ86
 t1+AdROVpcr2PBA/GMA/IQnID8NVxTM3k4q7g5XBhO2x8IZGscZn4eV4CxcYMM4jeFpDjU8UlT8
 kO+fcsLk2PN01sdwu5H+z+8M+NVisp58pq8GBR129VOPe/DDnDJsZSQ4ACdb+HxPlDv2hM1y/Be
 k6M03/w+IyW2wCvVqB7ebMegUPH5/tF2TBGVVAVlpFwGhpGahjrwSXnpTz7JbXdGEE6fQRlgoq4
 3TH30n6LZb2R7s0IrVQ==
X-Authority-Analysis: v=2.4 cv=TqtzFzXh c=1 sm=1 tr=0 ts=6ad2d69f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=YjmlrVWy-zMJPE8JoxkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ysIJw1TPCOfxw6Eczi1KV86R42HwyMyE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfXye965isWGo6o
 DeWgRsxGeCiD7Lh95UHLr5FvP01J0LyiMpoPtEAOVaAfBZsc0R1NbZnPjBsXxu/E3UfycnjSzCA
 8GFxTFjSNn6D3uPPoxeiRpWYanMmtA3ZK3hWDkMF5IWEDZ4v4RBs
X-Proofpoint-GUID: ysIJw1TPCOfxw6Eczi1KV86R42HwyMyE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170007

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
No changes in v5.

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

