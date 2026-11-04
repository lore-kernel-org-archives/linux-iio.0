Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798573;
	b=TRsZcEU2RAATh3jPM/raUTqtS8tHXkIDTMYs91hyB3ulpgVw8dgCY4dUDBBhKTqrn0je
	 iZrbmEZet4ymNT56Fkez8V6IUKm4rkUrtiZknkSmja9df7IDnZNEC7za5W5m3EHBhTt3x
	 zXUvs43YJE7v2kP3KkqhPtJKIZHkxyVMiOVgehFWb/tZJ5GRwHVGuGjx+aZId9zPwiYRH
	 FPfv6Oa3/SCkdufyhbIPtzRmBvQV86dty2VmGeXfOo3dCcuh2k854TwGHI09aqbhvyRpW
	 1SE7E5FqTo0cu1UjTDHGVculKFUq78U3x9TIm5xHjfVHrhnr+mlALVsbKmFrca8iflA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798573;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=d2qF/SgCn17HsOupmcPMq2+NSWrCDYpUSXv5L9upU/8=;
	b=XTIK4KRjCZmy718PH1D+7Tn2GpBl6XPLzF0Z9quh09h/D8HKF3z8z2gSGhUoguBS+QEF
	 iysIO/euV+jUJ2KW7sUDbWMAz4fGwuyBH/U1joNR11nPuKjEQfD+40cmViL/83ZC37vxt
	 A5NkyQzZoD+MxBE8fbiO2b1+EajtDIB1wYSPkYCLmu5++TO1YO2TQNyK8TuebPNaBH2g6
	 8qMWN+Tiony5jhxo/izzU8WHReddgUXubb8zsona6Uu2nANd/9X6ZVwkIsz48BYNO/O9n
	 +cVVvJsX+Zx4sRfkem6Ew8AEFaO824epOWaPASuuaelSD5dSAgkyvsBPOx0BPlwQstg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=oPCwaskz;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jcWxKIIK;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF05606A329;
	Wed,  4 Nov 2026 13:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBF05606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=oPCwaskz;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jcWxKIIK
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bc7r31243043;
	Wed, 4 Nov 2026 08:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=d2qF/SgCn17HsOupmcPMq2+NSWrCDYpUSXv5L9upU/8=; b=oPCwask
	zMrN318/7H+o1ty6ZSPu+1wyHfeMTgN8EBViltKj2YwzfOw3XGj5UL0+q+XXdkzW
	TBZRYWb/NoZ5bH/PZWh9NeQPmXLfqtTwNm5ELdZ++nAWOx15Op0lfaQ8jbni8OmV
	V5gash/NlrZyNuJNisBg96v1BpmdC0yzk3AWWonDY+pRtWgGg72XliqVjGW9PSLI
	Ow8g6DT+zJeKH8fD6Np1eTQUy5z3KboH4ufuQf35k341/1ztNoWroPKp7UW6XVgF
	EinrrA1CWppgcxk5N2Pc9sGXnVo1EJFGWRPLO9iR64ES/k68YJ3EHeRJu9s7/jEF
	fP4zMKQZGQ1+t8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=d2qF/
	SgCn17HsOupmcPMq2+NSWrCDYpUSXv5L9upU/8=; b=jcWxKIIKR6ib3qfx7c71U
	BqA8qyMcg1YQ4tjYQttAtUsJEkzFjNn7zf8d/T6XlOtNdVqn3PhBVHi/yZTgd+mJ
	VJgKA7PY7czSXNSyGE57dkZ0k0DmLI14KGZY7fRp+1iUk4mAYPluhVjnln9M/1SI
	SCsPH4MtADOX94qPr23mDAl/K6k26PPnOTLE5MWBNLROYzuZB4qmi7RNgCSRAv7Z
	cCDMQhz048wyKtEmNH6duzSF2i6DrA4te25uG2GFz3qdKtKyaV3/PKlG9EExUEgP
	Z3iwUTDmC30OP4tiovi4hjFsLqBIIavmpUGtkyYGPRpaIT2GGPVNQy1HzHrVIhmy
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hqnfhn4r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:22:48 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A4DMkwP028044
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Nov 2026 08:22:46 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 4 Nov
 2026 08:22:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 4 Nov 2026 08:22:26 -0500
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A4DLnap008011;
	Wed, 4 Nov 2026 08:22:17 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Trevor
 Gamblin <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolae-Daniel
 Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Subject: [PATCH v2 4/5] dt-bindings: iio: adc: adi,ad7625: add LTC2387 and ADAQ2387x
Date: Wed, 4 Nov 2026 15:21:42 +0200
Message-ID: <20261104132143.215581-5-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104132143.215581-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261104132143.215581-1-Nicolae-daniel.Deaconescu@analog.com>
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
X-Authority-Analysis: v=2.4 cv=I6Pw19gg c=1 sm=1 tr=0 ts=6aeb31a8 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=5djnrFFni1Mv9bGOFNkA:9 a=sptkURWiP4Gy88Gu7hUp:22 a=BmoiQ_kLkyt6usnitrTQ:22
X-Proofpoint-GUID: Wn98Utiyw764IJlzQixe02gmAjKJJbD5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MyBTYWx0ZWRfX8nxQ7HXHXBsg
 P45OYFlmLnrNQ+S4lPxcD74BQ9Dck9EdUXnppkM3XKfMKh7IugZgNOm3qtzPNXtNLUkMKy8b0xg
 H2dq24ykvCERH9hk2XZ/hGwQCC4luIWKvL7/ZyaMjt4U+8U3+pP7mHYJlRXJDn+nPRiqR56oIT6
 UVYWOMrKyIIxr4XRkO+zchqb11JohRfAEmHQNZzU1LChO+BAFoSemUcEZfygklcQDDs+GZvfQTC
 BE+cRUjcMMa/MujqlvgjB7q18S6XVyqavBH4mX++B/96lltJ/GSshwFkak4JtIEfai9/HCURo5n
 IPoqx2fEXBgf7BFRNwYoYSavXZL23seiy0Yf5oH48TF7NiyTAWjc/rQDN7sma/tNiy2cnb8UKMV
 AHQCS9dVWX2/uU/HHLVc9Zl3fzFJu+1d2J9ujoMuOh81uctBM8edeCT+PAXP59sKxOyO/SHnx2D
 +ZVAXvHo7APtlFNLNiA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MyBTYWx0ZWRfX9t3tNs/muTMu
 +EjxnQaU+SplJMAQAUDqo1zYGShZE/hPqiniQHsyWbp9ELm0PCofT0x6nv64Ftgk0EtCvqszKUh
 AMukCY/Ya+F+tydgBtoOr3lq5k4t9RaxmoSosOUy6Y6RaXtqED1C
X-Proofpoint-ORIG-GUID: Wn98Utiyw764IJlzQixe02gmAjKJJbD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040053

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Add the LTC2387-16, LTC2387-18, ADAQ23875, ADAQ23876 and ADAQ23878 to the
binding. They are single channel differential ADCs like the AD762x and
AD796x and are read the same way: CNV and CLK are driven by two PWMs and
the LVDS data is captured by an AXI ADC. They differ in what is around the
converter:

- Their output is double data rate on one or two lanes, selected by the
  TWOLANES pin, described by adi,use-two-lanes.
- They have no EN pins, and no clocks property, because the PWM provider
  reports the clock its waveforms are derived from. The second PWM is named
  clk, as that is the pin it drives, where the AD762x and AD796x name it
  clk_gate.
- The supplies are VDD, VDDL and OVDD on the LTC2387, and VDD, VIO, VS+ and
  VS- on the ADAQ modules.
- The ADAQ modules have a fully differential amplifier in front of the ADC.
  Its gain is fixed on the ADAQ23875 and set by pin strapping on the
  ADAQ23876 and ADAQ23878, described by adi,gain-milli.

The properties and supplies of the two groups of parts are made exclusive.
The gain is described in the devicetree as the pin strapping can't be read
from the part. There is no fallback compatible, as a driver for one of the
existing parts would read these wrongly: their output is double data rate
and has other timing limits.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 .../bindings/iio/adc/adi,ad7625.yaml          | 193 +++++++++++++++++-
 1 file changed, 184 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
index 8848562af28f..dbdded88236c 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/adc/adi,ad7625.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices Fast PulSAR Analog to Digital Converters
+title: Analog Devices Fast PulSAR, LTC2387 and ADAQ2387x Analog to Digital Converters
 
 maintainers:
   - Michael Hennerich <Michael.Hennerich@analog.com>
@@ -17,6 +17,11 @@ description: |
   * https://www.analog.com/en/products/ad7626.html
   * https://www.analog.com/en/products/ad7960.html
   * https://www.analog.com/en/products/ad7961.html
+  * https://www.analog.com/en/products/ltc2387-16.html
+  * https://www.analog.com/en/products/ltc2387-18.html
+  * https://www.analog.com/en/products/adaq23875.html
+  * https://www.analog.com/en/products/adaq23876.html
+  * https://www.analog.com/en/products/adaq23878.html
 
 properties:
   compatible:
@@ -25,14 +30,37 @@ properties:
       - adi,ad7626
       - adi,ad7960
       - adi,ad7961
+      - adi,adaq23875
+      - adi,adaq23876
+      - adi,adaq23878
+      - adi,ltc2387-16
+      - adi,ltc2387-18
 
   vdd1-supply: true
   vdd2-supply: true
   vio-supply: true
 
+  vdd-supply:
+    description: 5V analog power supply (VDD), LTC2387 and ADAQ parts only.
+
+  vddl-supply:
+    description: 2.5V analog power supply (VDDL), LTC2387 parts only.
+
+  ovdd-supply:
+    description: 2.5V output power supply (OVDD), LTC2387 parts only.
+
+  vs-p-supply:
+    description: Amplifier positive supply (VS+), ADAQ parts only.
+
+  vs-n-supply:
+    description:
+      Amplifier negative supply (VS-), ADAQ parts only. Leave it out if VS-
+      is tied to ground.
+
   ref-supply:
     description:
-      Voltage regulator for the external reference voltage (REF).
+      Voltage regulator for the external reference voltage (REF, or REFBUF
+      on the LTC2387 and ADAQ2387x).
 
   refin-supply:
     description:
@@ -40,18 +68,23 @@ properties:
 
   clocks:
     description:
-      The clock connected to the CLK pins, gated by the clk_gate PWM.
+      The clock connected to the CLK pins, gated by the clk_gate PWM. Not
+      described for the LTC2387 and ADAQ parts.
     maxItems: 1
 
   pwms:
     items:
       - description: PWM connected to the CNV input on the ADC.
-      - description: PWM that gates the clock connected to the ADC's CLK input.
+      - description:
+          PWM that gates the clock connected to the ADC's CLK input, so that
+          it sees the burst of pulses for each conversion. It is named
+          clk_gate for the AD762x and AD796x, and clk for the LTC2387 and
+          ADAQ2387x.
 
   pwm-names:
     items:
       - const: cnv
-      - const: clk_gate
+      - enum: [clk_gate, clk]
 
   io-backends:
     description:
@@ -91,6 +124,23 @@ properties:
       Indicates if EN3 is hard-wired to the high state. If neither this
       nor en3-gpios are present, then EN3 is hard-wired low.
 
+  adi,use-two-lanes:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Describes whether the TWOLANES pin of an LTC2387 or ADAQ part is set
+      high, selecting two-lane LVDS output, or low, selecting one-lane
+      output (the default).
+
+  adi,gain-milli:
+    description:
+      Gain of the fully-differential amplifier that the ADAQ modules
+      integrate ahead of the LTC2387 die, expressed as gain * 1000. It is
+      fixed on the ADAQ23875 and set by pin strapping on the ADAQ23876 and
+      ADAQ23878, so it must match the board. Not allowed on the ADAQ23875,
+      whose gain is fixed at 2.
+    $ref: /schemas/types.yaml#/definitions/uint16
+    enum: [370, 730, 870, 1380, 2250]
+
   en0-gpios:
     description:
       Configurable EN0 pin.
@@ -109,10 +159,6 @@ properties:
 
 required:
   - compatible
-  - vdd1-supply
-  - vdd2-supply
-  - vio-supply
-  - clocks
   - pwms
   - pwm-names
   - io-backends
@@ -157,6 +203,111 @@ allOf:
         - required: [ref-supply]
         - required: [refin-supply]
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7625
+              - adi,ad7626
+              - adi,ad7960
+              - adi,ad7961
+    then:
+      properties:
+        pwm-names:
+          items:
+            - const: cnv
+            - const: clk_gate
+        vdd-supply: false
+        vddl-supply: false
+        ovdd-supply: false
+        vs-p-supply: false
+        vs-n-supply: false
+        adi,use-two-lanes: false
+        adi,gain-milli: false
+      required:
+        - vdd1-supply
+        - vdd2-supply
+        - vio-supply
+        - clocks
+    else:
+      # The LTC2387 and ADAQ parts have no EN pins and no clock to describe.
+      properties:
+        pwm-names:
+          items:
+            - const: cnv
+            - const: clk
+        vdd1-supply: false
+        vdd2-supply: false
+        clocks: false
+        # REFIN is the bandgap output and the input of the reference buffer.
+        # An external reference goes to REFBUF, through ref-supply.
+        refin-supply: false
+        en0-gpios: false
+        en1-gpios: false
+        en2-gpios: false
+        en3-gpios: false
+        adi,en0-always-on: false
+        adi,en1-always-on: false
+        adi,en2-always-on: false
+        adi,en3-always-on: false
+        adi,no-dco: false
+      required:
+        - vdd-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ltc2387-16
+              - adi,ltc2387-18
+    then:
+      properties:
+        vio-supply: false
+        vs-p-supply: false
+        vs-n-supply: false
+        adi,gain-milli: false
+      required:
+        - vddl-supply
+        - ovdd-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adaq23875
+              - adi,adaq23876
+              - adi,adaq23878
+    then:
+      properties:
+        vddl-supply: false
+        ovdd-supply: false
+      required:
+        - vio-supply
+        - vs-p-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,adaq23875
+    then:
+      properties:
+        adi,gain-milli: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adaq23876
+              - adi,adaq23878
+    then:
+      required:
+        - adi,gain-milli
+
 additionalProperties: false
 
 examples:
@@ -174,3 +325,27 @@ examples:
         en0-gpios = <&gpio0 86 GPIO_ACTIVE_HIGH>;
         en1-gpios = <&gpio0 87 GPIO_ACTIVE_HIGH>;
     };
+  - |
+    adc {
+        compatible = "adi,ltc2387-16";
+        io-backends = <&axi_adc>;
+        ovdd-supply = <&supply_2_5V>;
+        pwms = <&axi_pwm_gen 0 0 0>, <&axi_pwm_gen 1 0 0>;
+        pwm-names = "cnv", "clk";
+        ref-supply = <&supply_4_096V>;
+        vdd-supply = <&supply_5V>;
+        vddl-supply = <&supply_2_5V>;
+    };
+  - |
+    adc {
+        compatible = "adi,adaq23878";
+        io-backends = <&axi_adc>;
+        pwms = <&axi_pwm_gen 0 0 0>, <&axi_pwm_gen 1 0 0>;
+        pwm-names = "cnv", "clk";
+        vdd-supply = <&supply_5V>;
+        vio-supply = <&supply_2_5V>;
+        vs-n-supply = <&supply_0V>;
+        vs-p-supply = <&supply_5V>;
+        adi,gain-milli = /bits/ 16 <870>;
+        adi,use-two-lanes;
+    };
-- 
2.34.1

