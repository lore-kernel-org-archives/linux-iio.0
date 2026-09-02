Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9BE4AC154;
	Wed,  2 Sep 2026 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369933; cv=none; b=l0pNS+t5YgeeyEs16kJDNhYpQRJiAKVby2NCJMXiw9TRHqARVz3wr54STR4JQNTdlhKBRcOr2tonrQLdJDAfaaV32tEY3fWkblFVlqtQmADZW00b00NJH50Thq3aSv0VFiR4WpbpHmm5rdlFyiMAjF2EnezkGqhYihnHXsXm5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369933; c=relaxed/simple;
	bh=ftcvdcGIpHmrPeOhjdQZDbW7WIujqaom3DF6SHNgkSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sT/sKx+sVbBzxQi5jZHG7wAzT/crl9gq4Xtl+zX/h6oLm3nX+ft+ZmVlgKCH+7ihphLHyr3hJ8QwsoZhDI6SeIEktoIrDN6pDIPA+O/Ujb/FMPykkpkw/Gct0Eg6u+TGk+5e7JwqUp0o5wKw0aFJf4jG/l0NITEmdg69lH82Gaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YYNhjebw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YYNhjebw"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HDjei2570405;
	Wed, 2 Sep 2026 13:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Upr6f
	jifMTzOpalhEL4nj0W7kYn4j0hLoEMrxTp9tng=; b=YYNhjebwoM4uSLmLlcpHS
	d8T9u6bBNQ2NLjmwMhjtg3HzTEGvwh29FAOTQa+tc0Pl+TpKR/W8YxOH+tlw1MmE
	LWPdW9TgOhNFUIPqJGTaOD4HCWnN6OaTR2P7v7jJXfow0/5BaSqoZDKjeJAJXeqc
	wBxQ3SxBhSkyOmEJz+3sNukDb7Xgw+ZI3M8ZaHyg63UQjwykB3m5KiK9DEDd9fWd
	4c+4u+hd7u8hpyHr+YL/X9fPgF859jdGEgAUoFD0ngzO3KS05cRY6jXcV55NnR4Q
	coRxElquAstUmyr3mMbOe92rqnYUwdQ7z7o3GcQnNx7q3SiMvPIXRsJq4iq0aYli
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ge3v1n83u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 13:25:25 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 682HPOdZ041518
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 13:25:24 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 2 Sep 2026 13:25:24 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 2 Sep 2026 13:25:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 13:25:23 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 682HPAg1004304;
	Wed, 2 Sep 2026 13:25:12 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 11/13] dt-bindings: iio: adc: adi,ad4134: Add high data throughput example
Date: Wed, 2 Sep 2026 14:25:04 -0300
Message-ID: <4044581dcec9854acedb2110acdbc84f6b1713e3.1788368334.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1788368334.git.marcelo.schmitt@analog.com>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bql8wkai c=1 sm=1 tr=0 ts=6a985c05 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=k7sVqk9PHWlvH-81wWMA:9
X-Proofpoint-GUID: Wp4Pxvs6RXDGX30aclxoLXFs_dzyhhLd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX+vicMxfCMBIx
 5sndIrDUrtVa/6yOWkxEh2nitETVHPh593en8L+lm3H+M8VsHRINu6Nf3YTzUzCNHvS2DWzZA+K
 NkwrnsgPNt9aPemi+s990Oa9nm+/fmIOpjqpptBbZ4ym+I6iq0YS
X-Proofpoint-ORIG-GUID: Wp4Pxvs6RXDGX30aclxoLXFs_dzyhhLd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX+7qztk9ZfW4E
 CGszwnOWGtYL5gf1l64ZqIyK7kqgAx8d+MyekRmoeJhQ2K/mV6g4PWcOARUdAHM6y1gNQmA9qHf
 xoE4Risk3Zl5DywEaGsp1WhvLUdBzrRe08KIkLCZfT6FY0UfWDMkFPRfPW6cQ1+TL39kx+b1jii
 Lo6Zmx78wwEkiJ0uKP/WtWgysyGoD4GNTVa3IS8mQiHoz7Ek/Qi7prrA16aXYkABKk2GpznZQdA
 ph2LG1pyHsqVjtJvebL+koqaF1Sf6r1BO5CQSqCJb5n2paF/BxgcdnUC6ci5aS2DzNEDo7XWFvL
 eCaM6EV8MBGs5nkWAFZGVptpKG+39HNO1AsJUTfVv2NaVGKRe4Jx/zHjANO5YJ07qysIkK5ahiD
 3kdd7BGxfV0e7YkItQYt3K94maMmvsMB8mcSOREKQxKluMUGQw37zaQFSWklHFDKXxNasWM3D3G
 V7ZCYabdp9iMc1i51pA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020153

Add device tree example for AD4134 operation in 4-wire SPI mode with 4
lines to transfer data samples to the host controller.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
The reason for the input multiplexer is enable both register access and
multi-lane read. Before coming to the current solution, we tried the following
configuration.

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
line, causing register read to fail (always get 0xFF). Another solution would be
to connect SDO to SDI0 and DOUT pins to SDI1, SDI2, SDI3, SDI4. That would then
require a special multi-lane mode.

Please, see patch 13 for a better view of how the proposed setup works.

 .../bindings/iio/adc/adi,ad4134.yaml          | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
index 34043f89730b..6f0b4346426a 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
@@ -214,4 +214,46 @@ examples:
 
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    ad4134_sdo_dout0_mux: mux-controller {
+        compatible = "gpio-mux";
+        #mux-state-cells = <1>;
+        mux-gpios = <&gpio0 100 GPIO_ACTIVE_HIGH>;
+    };
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
+            spi-rx-bus-width = <1>, <1>, <1>, <1>; /* 4 lanes of 1 bit each */
+
+            pwms = <&ad4134_odr_generator 1 1000000 0>;
+            reset-gpios = <&gpio0 86 GPIO_ACTIVE_LOW>;
+            odr-gpios = <&gpio0 87 GPIO_ACTIVE_HIGH>;
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

