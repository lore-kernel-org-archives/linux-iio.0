Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478EA3932D6;
	Thu,  5 Mar 2026 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710787; cv=none; b=VdX26w/FU+jXbxFturiSkbQTT5h41SyAT4DBTgd662Pp5gEhGM7ofyLi0ThL171WlIiFZGi5fweQJLAwq8SMhMbuZWb+D9r7AIrZPc8x6xAk2F8CSrAltRGT2NjzquNQdhILOF5yWJjtrnvIfh8pLz4gHe24221STrtc63yycK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710787; c=relaxed/simple;
	bh=VQhOhUq4uUfeKYLpLxNvxiaOJ7BgW9eCm2eqwLFVn7I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9Ru9deCF5s6d2Vak+sN76huqVqMZyTaczID6VtPaus9prbIgI5JqjAOrBSMkIYPB77e+y4hlE4u2I8d0u3Hu/fVGYeDKdJOugrvOFNFVWtTIoHAtfS2DQsTZYkoKwTtR2FvCxqaP1s2swvL6LJ+hEbD09f+/utICfH4H+uKjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ICJ/SZYR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ICJ/SZYR"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625BBvc03363772;
	Thu, 5 Mar 2026 06:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=b/ZKo
	+2nRZQnpend6vHN97bFMttTJEHwsAA7HC+5D0o=; b=ICJ/SZYR7vuOO4p0JHG63
	5aJFhg6hhNst+xwbm7WZpnvkL0REmYptim4OqU7DgQBogMru0/ZSySk5YiX460ik
	6QhtqhOSGKbsDk9lslYTmLb4TS5cckVWdi4RPpUSHSAy/i/7BkFW7550q69oN30E
	ut2dAuR3CUVV6ciXAHMi5vCihYkWXnU9k+Eil3rbjUafX0ufW7Y3dWIlFfOEDttB
	wxfCg4OBVSIBkIhYEt4rr0cChlKXax0dBdwC+R6GaUqpHiO/2imvVI8twtFreUQe
	0BmpXirGNV1OP4iumj1cXJMc93kuSP9compQq8BDNLtrRlpQj/O7MuLUHS7/M3Rw
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cpdywwvrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 06:39:28 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 625BdRRO058608
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Mar 2026 06:39:27 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Mar 2026 06:39:27 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Mar 2026 06:39:27 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Mar 2026 06:39:27 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 625BcrWH005601;
	Thu, 5 Mar 2026 06:39:22 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/4] dt-bindings: iio: adc: ad4080: add AD4880 support
Date: Thu, 5 Mar 2026 13:37:29 +0200
Message-ID: <20260305113756.47243-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305113756.47243-1-antoniu.miclaus@analog.com>
References: <20260305113756.47243-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Mc9hep/f c=1 sm=1 tr=0 ts=69a96b70 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=eYjWAXzLS8b0uuH4XOwA:9
X-Proofpoint-ORIG-GUID: K83aQmHcDRnlqH94weDyYeMwj2jYPQ8z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA5NSBTYWx0ZWRfXzVUY89Qh72BK
 8JhYNXuqr/m61khz9Q0esAOyE+QDaPG0jwd2REW6JMoZdHLXPasRW27Ula48vNB8Y5FpBDGsDu3
 FtfjFWcsoFVi/e/+EvrP3ZOYrsETjSjCsdu3jkNTBboo8ledE58Mmhgf7cjKthOrOTqsBjN7b1k
 0O8J/+xAaUV7Y4ZGTD3cmhhRFpR1/sPpDJ1Q92XYWeDaYCI5UEl1Q6gALZQA3BgfgzJimqj/KWv
 EW8HJG20+8KpaEbcoy4UNX0v/wY+WbvbUXqA9E9Hxzd0OiYSmi2Sw89CSuAsUJ/6tP98YQ0o67J
 xekJ52nwpafApNuqQnOSiQfjVM6M0vrTF0con7HatFYTUdCwcztURivQJYZzSFmOFrKQui7EOcq
 HJqHsrqVR6zoVeN7g8boiLp5f9127nXb9hFwKeFnPVZNSWBskHM38Mr/xQTew4oup4b7DN5F7dM
 qK/3E1rYAwRjcAbCQsw==
X-Proofpoint-GUID: K83aQmHcDRnlqH94weDyYeMwj2jYPQ8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050095

Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC
with integrated fully differential amplifiers (FDA).

The AD4880 has two independent ADC channels, each with its own SPI
configuration interface. This requires:
- Two entries in reg property for primary and secondary channel
  chip selects
- Two io-backends entries for the two data channels

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v5:
  - No changes

 .../bindings/iio/adc/adi,ad4080.yaml          | 53 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index ccd6a0ac1539..0cf86c6f9925 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -18,7 +18,11 @@ description: |
   service a wide variety of precision, wide bandwidth data acquisition
   applications.
 
+  The AD4880 is a dual-channel variant with two independent ADC channels,
+  each with its own SPI configuration interface.
+
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad4080.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4880.pdf
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -31,9 +35,15 @@ properties:
       - adi,ad4084
       - adi,ad4086
       - adi,ad4087
+      - adi,ad4880
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+    description:
+      SPI chip select(s). For single-channel devices, one chip select.
+      For multi-channel devices like AD4880, two chip selects are required
+      as each channel has its own SPI configuration interface.
 
   spi-max-frequency:
     description: Configuration of the SPI bus.
@@ -57,7 +67,10 @@ properties:
   vrefin-supply: true
 
   io-backends:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Backend for channel A (primary)
+      - description: Backend for channel B (secondary)
 
   adi,lvds-cnv-enable:
     description: Enable the LVDS signal type on the CNV pin. Default is CMOS.
@@ -78,6 +91,25 @@ required:
   - vdd33-supply
   - vrefin-supply
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad4880
+    then:
+      properties:
+        reg:
+          minItems: 2
+        io-backends:
+          minItems: 2
+    else:
+      properties:
+        reg:
+          maxItems: 1
+        io-backends:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
@@ -98,4 +130,21 @@ examples:
           io-backends = <&iio_backend>;
         };
     };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+          compatible = "adi,ad4880";
+          reg = <0>, <1>;
+          spi-max-frequency = <10000000>;
+          vdd33-supply = <&vdd33>;
+          vddldo-supply = <&vddldo>;
+          vrefin-supply = <&vrefin>;
+          clocks = <&cnv>;
+          clock-names = "cnv";
+          io-backends = <&iio_backend_cha>, <&iio_backend_chb>;
+        };
+    };
 ...
-- 
2.43.0

