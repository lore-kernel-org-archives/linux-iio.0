Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3073E2BDC2C;
	Sat, 21 Mar 2026 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774087381; cv=none; b=R+3bKASdlDrk1AoJIWBLoUwr4c5GNFJU1lzGeXHuR++ITRBlx93KQKA8jeI34lTDcqEPWa7LOkdi9/HYMvkAFJjBWMytqIpN8v5S962WArB9d8fTJou3PmOpRdBTCMqBS8shEq/EgWKZQ8/DcRPSlFAQnncuN4glvYLSbY/KtXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774087381; c=relaxed/simple;
	bh=48AAVh3fXtXHqHzf6Bepsb36Z6ig2o01Qxs/8eBnyJY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rt3Y4wYcyw1FNw+pwpIWdqn/Ki/LeTCzFXBkr+Rjwz6LB9b++4BDHIFiqQJsEIn4Yze41QArRvJ7pmCZNfN/1nrkNa54z01fAcbJ8GY3gZ7H0vDP59pbsDoC6CIR9ogqYRI8etCH3z9y2QQ4tDujOZ7WCP30uKP52H7LZE0C+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MYxBoKfE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MYxBoKfE"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L5PisN662680;
	Sat, 21 Mar 2026 06:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=O/uTf
	EN1/wbUUo9eInvSgqDScfaoSOhnFZLi52jKLWY=; b=MYxBoKfEka5RpzSPTAkDO
	MrZNhtFvXET2j1iR/A0wwe9QTZei+T1AZl0iyrkNCeay2XwnHifDKFSbgGxDxWSA
	Xx3aqSsIdv2vp1zYsbR+F7xYRhW2GlC1gPSW0tde2tuR2yCJUCnS6KJaqiDMCbT9
	ukxoNCsDkIkLUMQ7Lu48LexjLobS6x2YEwr5gvAJ7p9YsFSkrw8AdbvQn16xYQb+
	zENYepfeofKXUCqAVg2DbOYpTiP9RjAZooIp45VmPIfYe4b9CE+BCz2gp9hhtz3N
	IP3P9bka7N6C2iJ+KAPCyJc8egTdTzEQEUwK9mtTGfeNdphtAPnMXQFRwwI576zp
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d1n61rj66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 06:02:37 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62LA2afJ041128
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 21 Mar 2026 06:02:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Sat, 21 Mar
 2026 06:02:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 21 Mar 2026 06:02:36 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.226.156])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62LA29Ut016218;
	Sat, 21 Mar 2026 06:02:27 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 3/4] dt-bindings: iio: adc: ad4080: add AD4880 support
Date: Sat, 21 Mar 2026 12:01:53 +0200
Message-ID: <20260321100154.1258-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321100154.1258-1-antoniu.miclaus@analog.com>
References: <20260321100154.1258-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4MSBTYWx0ZWRfX1WNxCQXUmAfr
 tRtCg0RJC64xB3czjJZcc1IvduoLaIV8osinImBlrQb9dZs7VzEAhbrJpmeX1xXIl4eld8xqJ6u
 ofOpq8/fjYbKow9oW7uFBpyt/pB7Qwy02hESiDo46LOGC2cabuENe0xH1bUEd9QdFlJ91b22vT7
 vXQsgLnNoYz+ShIZoqODdN+ZgnxtRKusxzks17+TbwAeYt73o+rJvESteh8taJPF7lCZATOoiZI
 35QgOMUT2nMQHVedRK0xVNqJuys/BY3l/h9o/DBmvD7P8P8XWeONlNbl8jLUMErSMA8ZFZq9Ijm
 bMi9JiBrgl++rdhFCd2wtmWP1jAKwNMt+fSp9L0Qa+7FaV7QE1YE+pMhrWtlTN6feEtfAGdP7HC
 p14l/6A0RJXIxE6H3pwj3fq42B/rUkXMtklrBGKFNjmjSrtO+8axlFsenpup2SCpDSn0gYY5aKY
 c0EQ+Ww+51Ue1SWMfHg==
X-Proofpoint-ORIG-GUID: jGtRJ68m7FrjfIDuOVq-xCzzY26wufT_
X-Proofpoint-GUID: jGtRJ68m7FrjfIDuOVq-xCzzY26wufT_
X-Authority-Analysis: v=2.4 cv=D59K6/Rj c=1 sm=1 tr=0 ts=69be6cbd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=eYjWAXzLS8b0uuH4XOwA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603210081

Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC
with integrated fully differential amplifiers (FDA).

The AD4880 has two independent ADC channels, each with its own SPI
configuration interface. This requires:
- Two entries in reg property for primary and secondary channel
  chip selects
- Two io-backends entries for the two data channels

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v7:
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

