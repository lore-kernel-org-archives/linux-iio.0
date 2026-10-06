Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236611FA272;
	Tue,  6 Oct 2026 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310741; cv=none; b=jeTNJ8Ri3qgmYR4hIr1Rfpff3TjWMJqXQsONDqO2c+OfUN7qZzGX2k5OSzpynmF3DBf/mgH8trJYw1qXsPR7Pzi1oZGuBHvvc/0/OpwGDpbhlK5oz4vmCLMvgYYrhWNAbHrdB/tDVrei2Wr9rleZMHZblGGoqDJkcrHszdTPUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310741; c=relaxed/simple;
	bh=Pazddukc8RYdmjC8s1fVqb6d91FgwYDl4TjZbc+N6IQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3CJYftFGg2fA1CeF1x3HUtt99d5p55xj6tqHq9TpqJBqCYObfzQgi9V0q3o5baFV7mZ4oTQJnellECda80ZcLiXMTpAembuDGjxO500AJbe6DyEZ4NzsUU3K0ynpKuJ8Vrx7xs1It71QvvIONfj6ZsSBuctB1fbJpKU995AHcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=DuumCuk6; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1vzT8A9t; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="DuumCuk6";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1vzT8A9t"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696Hi4VW3252027;
	Tue, 6 Oct 2026 14:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=a0wEnW1kEAgA3rbcNcaF1FxuM5rUCIgmrxf5tfBPh9w=; b=DuumCuk
	6JEkY0NXvlJb+sfyS6jOJyTj77liRo/6Rwsv/XdmUkcpv55YtmpIGBjjxMjbN5Ft
	9jywmgj4Mr9pvBXfekW5Jru6ZpWz2gOKDC3/Ea5YVjftajyXknhlewL98sguIfeW
	Z+PuhmjC9meDLFcXEurIHxf42qUOGxkR0x17dtn2GskDwTEIqwdU72nDewHkTHOH
	Qa2KwjIzEN2Lcn0nRXoV7uZwDP6HAR4URJ6QcNaf37ou1uAzB8PAspUMhRy1N4XC
	/saX8hXnbD0+eXvKQ7RkDGl6qoPIRD7QyUX5xM+xfGmq+99fHEb1LvdldSxkovRh
	ioFTxugTYWxAKdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=a0wEn
	W1kEAgA3rbcNcaF1FxuM5rUCIgmrxf5tfBPh9w=; b=1vzT8A9tNZrb4yrIGgTRy
	sPbK48U9qCZtu0em8HH3EqUY08gweOkVn4GkNpHp+ve63Tt695LKpTeCwPquzPsE
	CpuYFEuPsHPrNolUisvE++GgjtLCXX6qcpC11RG7nPrpqyJYT8EzHUfJ1RgUvC3U
	pAc3uG3qeQLGKLBjMbmdcQALYTUfBq0gttqq0lVIvk8nIxSS0Fxc7mFOsXM9/NxJ
	WJWbcdYwF650IXfbNcuEm2LmNFP8xnlAqW0NSL7WQ/QfhutwyCCEkXkknIqTkJtU
	dL5h0kZLoDaKQB4EMg7KjnFh0B1fH1SteKY8BboxpIoCB+KaVY7OoHePUTHapctk
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h4y34jhwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:18:55 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 696IIrDj021730
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 14:18:53 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 6 Oct
 2026 14:18:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 6 Oct 2026 14:18:53 -0400
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 696IIeQS001028;
	Tue, 6 Oct 2026 14:18:42 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 09/13] dt-bindings: iio: adc: adi,ad4134: Document external multiplexer usage
Date: Tue, 6 Oct 2026 15:18:35 -0300
Message-ID: <14fe942a44bb0dd67eb9e25e533572e5cbe32b87.1791309733.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Ow83qf8pk_IiH9WvEqczEphtqPl3At7Y
X-Proofpoint-GUID: Ow83qf8pk_IiH9WvEqczEphtqPl3At7Y
X-Authority-Analysis: v=2.4 cv=QYnzLcbv c=1 sm=1 tr=0 ts=6ac53b8f cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=YjmlrVWy-zMJPE8JoxkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfXwwnOAwTpFseR
 8iOqLsJY1kYYx2ESkVTGipFs0Qs2VehxbFpMKJP7Y79dj+djy1rhjBR2kc28XbQ8GLeiNfFoMp9
 L7gQhDmP1Amk8WGawiexMV/9+zmbdgEKsLmPwUHUgaoK9/DZLzUO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX9IhgIXMj/qB6
 EXHbJPjNH7sDX4Nms/mZZsO90gZ01uixBZKHYSpWDnaT1hM7vFIhChocYNoGqvXZmGyCDt0PyI1
 vX9Ah0E1iPNpL1u12lGqVPrPhDDrhvxlSpsjNVc1029ctIX4C9weHly9zpk6629BdOwdb8UZ+Bs
 uE+Dve0WNeaQuqTndzej9cwUPHG/QgMEQbPH6wiJmPvNcXfmjzJHRbPB0teKJBb1FYte5t13bp4
 S++QNvlNUf/f8O3ormcqZUlfNT8r7XWi1UkCOlLIdmCASTkKlPn6WB+r7R5af9pl2nHqmuipKw8
 7R0gi5cFY1QN2ivRlbkh3+OE3x4jzOo3nvRzBFLigvK7Crb2q5G8fwNHDjEfMYrFVQp/Ib22xnf
 xV8TAozzC7WC+zifZujbPH4KXLd6qVQmHd9sm+hZoe/v9ONrkZsgV3WN/15jT1Rk7UUBk9rn0Nw
 73MTQkbWJTyGTPgt2YQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060072

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
No changes in v4.

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

