Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547839;
	b=t9T6h9CfDvpRa20crk/Jxr4Y4KX0plY3UzRWLpxz2ig7r9DsqHxY3HzCrimpJTTtDMQ0
	 jXUHjEYcKgYE52MF518M2ORF1Wk8rOx3ptrChdVbFFcvDR/qPUluaVWZTjHtLMnfhAdUI
	 Y8i6KdzakSzVvdp3aoe+ZoJGvcX0smxlL8lLnyjENIuMhbnKHAtnkyjk2HejRj8IGXAzE
	 PYy14R5+OR9T7DBvAZSUsLiVzODhuFOsTEWCrBU40+nyjwhcK6Zq4AiHtDy7ppWt3IIlE
	 3qtCYyp13BasiTIFJajiUI12RmNMxKeel6JNwSV7EW9mbDQpghGbu8SdUyLNUlVZ0Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547839;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+SXp4rMkRm/ao9jW+gzAHPRwNJmLKn8f7JvKix6gt/0=;
	b=v8s7+opFfn4Kpiep7ZPjQgRtBowjROw7G3yQ8lxqoqywfmcKLqMJAPFgj1fchNqxSgGg
	 eUUNHrtoS7eXUZ4GSynXIOv4doUTdOT349q4XSAu8Fw3tS9GRzNyI+sOCnAG3Npn0xciq
	 bp0ZBx93LMePiUmQAz8QKxYvyGXpvL9R42Ljv2Lb7au5pOcMkHcANOY6BtV8URs26jnNl
	 seK9UORXXYTaC8jVgkI1XmZmLhxMlGgHF+4myIELku9JRtWsvlj6KYTJYMGJJ2xdBPtg1
	 gh24BN2Rd5qBIe9vtufhZI5Jew2ev3+RLWxXBPCRmXEatrYGAhgknqJ6j0DRfgcD6qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="V/8Z0Txx";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Zhg6sAvo;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F8606A31B;
	Wed, 21 Oct 2026 01:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A28F8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=V/8Z0Txx;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Zhg6sAvo
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L0T7mn2057953;
	Tue, 20 Oct 2026 21:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=+SXp4rMkRm/ao9jW+gzAHPRwNJmLKn8f7JvKix6gt/0=; b=V/8Z0Tx
	xoBwz6qrbxVXMlB9sIYpnAtp+DfotsFj8tEOae4iJu/Q2SaF4OP7NDyMGoEE1M3t
	iHIbMhauanATdA1ORwl75rFEHV/M67xQoEr4+sb797re0gGRKP7cmfn1LVZ2dsmC
	tFMhN7Cc7iSuIUQ2EUTlBT0VSotSpzTng1C/4gJ3bDp5PuGzk+ptCkbCqPwHkYtn
	TN2fHC8ERDmmvlHLaRotbGQNClh1H/5JpjtGV8hv18kudczG5mmbw1BH09YUx2s7
	dEUx6JoiZ8G1hkCAQ7KDBuEj7WOkwzWL1Cq8fNTK4RY7JMZtoMLKKcygoO0+OB+8
	G+41ZHylzagVwWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+SXp4
	rMkRm/ao9jW+gzAHPRwNJmLKn8f7JvKix6gt/0=; b=Zhg6sAvodbzi/u0oZL63n
	uH2beCrQ1btWMhYHP4Agbd/0RtCEBl55IQO//iTnn5VLdYV99gdEDdom7i12PRVn
	hkRtpYjmkl6I8pFLqPFaaI4Sl/Ohb5rr6SdbFDj52cxOU4YAQtRHTkVugIW12+Wx
	jYVPxOSWGnTBP4pOgWG9unB4/PJH4a3JvLxSAXhNneil++9f74NPlc86RXutocQS
	qFaRlaI0sicDigl4/UMNpzrBTGTyVUkzOHaEeioFRBP6+wOvdpjfnGPQeJ5JNTcs
	BzaT/Pbj/az8E1szDBJ7bpFZZvKUBU06197bduo/lWiUxNwp/CV79KINJGKZ3vL2
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hedgy21bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:57:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69L1vEYd062299
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Oct 2026 21:57:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 20 Oct
 2026 21:57:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 20 Oct 2026 21:57:14 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69L1v1lI029049;
	Tue, 20 Oct 2026 21:57:04 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 2/9] dt-bindings: iio: adc: ad7768-1: Document multidevice support
Date: Tue, 20 Oct 2026 22:56:56 -0300
Message-ID: <6e2176d5547c59c39bb692e9768d7ac079b40f71.1792435248.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
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
X-Authority-Analysis: v=2.4 cv=EvBHPicA c=1 sm=1 tr=0 ts=6ad81bfb cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=YWYImKSwOyK80boFDhAA:9
X-Proofpoint-GUID: gXGNFyvljawo2hYd4AtcV0GJAzP_efhm
X-Proofpoint-ORIG-GUID: gXGNFyvljawo2hYd4AtcV0GJAzP_efhm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfX0imRV0FWQqxO
 RdKG7o5qdOihax6m3z2gxsCRyfNgV5Qv4K+0P+KsG9opWnjLZ4ikYi6tEKIanRLbvkhd0ORQT5Z
 +XtUKz6TxBpZ38JVnIPP9di8d6c9BBBM+SpXEeZgJ6vdfYPkApZTajVZQo6Mx4i0h1p5wbRD78T
 OWdBK/uLmt9xlSViRCEWn7nYZoYw6jTHuQ6HDmcKDw5l6NGvKR/Wx0GwrEl5krnmPM3mjj6k0O5
 8zSLEz56Rqa8PAB3Xyr0jofwBuhOluECR4671pWP1/rkIqLNsPyvwFDpSu2ZWrNs6imfwozLvuc
 YdLkxxXi6JFzz/axTQ8IFvgaCUXQyGNnCXtpwsWlJrcadFfHFy2t0OXmC80ZskfE6rXxjqE3WU3
 qLvVPDDssB++AR8mTpWt6tOcp3zGf8jD1IQtzNuFNMH60kJrlXB7FNUGphxZAd4XQajNJYbdVqC
 +5EUBp3NbD5itLAsjcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfX8UqZ4HDqvrYK
 pA6i4EzZCoV7NlvqlSzH7WPNhc3dZTiBcX0puJgowDy7OSJcHtOJPI7ryRuxkDhEwbp6IEYnJMy
 hPNjxaTfo7/v5bAHlco4yD/cKnbMojm7OeB+wM5TURU854WEWu9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210007

The AD7768-1 family supports aggregating up to four devices on a single
SPI controller, with each device occupying a dedicated CS line and a
single data lane.

Extend the `reg` property to accept up to 4 entries (one per device).

Add `spi-rx-bus-width` property to declare the per-device lane count.
Since each lane is bound to one CS, the number of entries must match
`reg`. Make it required when `reg` has more than one entry, along with
`spi-cs-composite` property.

Add an example for a four ADAQ7768-1 aggregation, with shared DRDY and
SYNC_IN pin.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v4:
* Include spi-cs-composite property to the bindings. The reason for going
  this route is stated in the cover letter.
* We decided to keep the spi-rx-bus-width property because assuming 1-lane
  per CS would break controllers that don't support multiple lanes.

Changes in v3:
* New patch.
---
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 80 ++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index 7b72d14e104c..64c1cbeaa576 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -26,7 +26,10 @@ properties:
       - adi,adaq7769-1
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
+    description:
+      Chip select number. For multi-device setups, one entry per device.
 
   clocks:
     maxItems: 1
@@ -109,6 +112,12 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  spi-rx-bus-width:
+    description:
+      Bus width per CS. For multi-device setups (multiple reg entries), one
+      entry per device must be provided. Required when reg has more than
+      one entry.
+
   spi-cpol: true
 
   spi-cpha: true
@@ -203,6 +212,16 @@ allOf:
       properties:
         pga-gpios: false
 
+  # Required properties for multi-device setups
+  - if:
+      properties:
+        reg:
+          minItems: 2
+    then:
+      required:
+        - spi-rx-bus-width
+        - spi-cs-composite
+
 unevaluatedProperties: false
 
 examples:
@@ -244,4 +263,63 @@ examples:
             };
         };
     };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/iio/adc/adi,ad7768-1.h>
+    /*
+     * Four ADAQ7768-1 devices aggregated on a single SPI controller.
+     * Each device occupies one CS and one data lane; DRDY and SYNC_IN
+     * pins are wired together across all four devices.
+     */
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,adaq7768-1";
+            reg = <0>, <1>, <2>, <3>;
+            spi-rx-bus-width = <1>, <1>, <1>, <1>;
+            spi-cs-composite;
+            spi-max-frequency = <2000000>;
+            spi-cpol;
+            spi-cpha;
+            vref-supply = <&adc_vref>;
+            pga-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>,
+                        <&gpio 11 GPIO_ACTIVE_HIGH>,
+                        <&gpio 12 GPIO_ACTIVE_HIGH>;
+            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+            interrupt-parent = <&gpio>;
+            #trigger-source-cells = <1>;
+            adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
+            reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+            clocks = <&ad7768_mclk>;
+            clock-names = "mclk";
+            gpio-controller;
+            #gpio-cells = <2>;
+            #io-channel-cells = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                label = "channel_0";
+            };
+
+            channel@1 {
+                reg = <1>;
+                label = "channel_1";
+            };
+
+            channel@2 {
+                reg = <2>;
+                label = "channel_2";
+            };
+
+            channel@3 {
+                reg = <3>;
+                label = "channel_3";
+            };
+        };
+    };
 ...
-- 
2.34.1

