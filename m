Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE172E8B97;
	Thu,  5 Feb 2026 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310158; cv=none; b=o3q+YvdS7CEol7pHNSNOmCYZrV/VxtJvnilGH1OKAcXTLLH/Mzt8iSKPeuTcpXotmzgADFnaAaITA03K+g5rJauaph8P9mSrY348Md1xKdUNtQpUFp2jLrw053UxYG4r2pgyXBVzP3rA5pNDXkzpog1TeBy8bTQnyO3wwCCDPuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310158; c=relaxed/simple;
	bh=JKbY4Ot8EwdmxnXGQ1OMsim4olPBW19f3asZVi7jBcQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVd15MT1Nhxm4s2+4Xa+qymzvrGSIX/D+TOvKonh22i/WPekex/E5yDB0hB4dDIHZ5JJVqMQh64gMBgrW0XSwiBJ4K9n2HWx8DMbc3XPJvnkFsT5mywlBq5SBGd9SHKZHJUVnl8UJ3eLxnoVf5tYMTIGPQlOTb79Bos97ke2eo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ddol/KmS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ddol/KmS"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615AbOLg1300793;
	Thu, 5 Feb 2026 11:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CwpX+
	bmkqq7gY2+EH+WWvGDmKCPAqh1CBN56R9gJsQw=; b=ddol/KmS+FB4YZbkpXpe9
	BproJI5uxl5xQaBN4ydtcSAZjynNptt6ZeimhnKaKMgzefVIC90P9it53ht102ig
	zl5yJw++JR2EmLaG9CP09BNvCxEmwggi+EKN511XFiBjA75gxCg6Qijh6W7UTCaC
	xcYWlbYXvWxqTwaJDGbQSRKDSMJZ/bSfNpVbxfmGT5EHjTnpT3UkiadbG3waQrwH
	K4laGgwiTi05ckuwa0ax77iSmOlsFyIOGo9OI/FugSjlaGSKacbCDuoCMewbSyb9
	HTfdXDXnYkc2XbaCxoADRSzU1o3c2IyjLD686Wrm4Sg6mgUCUnmsneXXZ2dhm3SJ
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c3vyp7yqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 11:49:13 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 615GnC15045303
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Feb 2026 11:49:12 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 5 Feb
 2026 11:49:12 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Feb 2026 11:49:12 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 615GmujL000475;
	Thu, 5 Feb 2026 11:48:58 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v7 6/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
Date: Thu, 5 Feb 2026 13:48:55 -0300
Message-ID: <4b879f53450e87739afc0dbd832dab5a3f83efb1.1770309522.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1770309522.git.marcelo.schmitt@analog.com>
References: <cover.1770309522.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: XYl6-tyI8XX8bd1GxuNmBjeEp13_lmgn
X-Authority-Analysis: v=2.4 cv=RujI7SmK c=1 sm=1 tr=0 ts=6984ca09 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8
 a=0GKIfBuVSP7uAb9je7gA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNyBTYWx0ZWRfX5U52/mIlvy+T
 BcX26LTvMV7+X3Btq4HyOiS4Liq00XPh0EObU4us5Lpdk5Lyi5dnJMRwVUTlkiL5oit7D/9zv9X
 cNoWOavBUDZuFzTqd0kfwpn7FjcwvGODiDDfZR6mk/NCXgOPFfPuREX5AOCJMDTYAhMusHyY7fz
 fsFZe9/ltqS77u+3Cikn0eZTIZY2DjPWSHCL9RxANfJh/cZl7c/LWGW5gYRYzPKNnYvaPti0viN
 3H5M/gu4ai77yRbZ6A1MjDYJYyy7/xanNXWr29amUX5ciUckqXzTj9iBjek+C2fAzXysD8BTjBQ
 6+dKD4Tp1u+C2ve3GEm92IZWNXi9rhHoJmUuIX4l5Zm5NZSvLWRj6oz12nWpqaw4wyITD2sQvPn
 mPEROADN57SNDtX3sadM9+QWMPtBr0IS7FqKCkBBv2uUP4vfiC2sSYHoMo3UC1HbaxbbXYoh6Bd
 yPfTsvb/p7goquztK9Q==
X-Proofpoint-GUID: XYl6-tyI8XX8bd1GxuNmBjeEp13_lmgn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050127

ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
PGA (programmable gain amplifier) that scales the input signal prior to it
reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
and A1) that set one of four possible signal gain configurations.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v6 -> v7
- No changes.

 .../bindings/iio/adc/adi,ad4030.yaml          | 70 +++++++++++++++++--
 1 file changed, 65 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 564b6f67a96e..3890cd4ba93e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -19,6 +19,8 @@ description: |
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4030-24-4032-24.pdf
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4216.pdf
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4224.pdf
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -31,6 +33,8 @@ properties:
       - adi,ad4630-24
       - adi,ad4632-16
       - adi,ad4632-24
+      - adi,adaq4216
+      - adi,adaq4224
 
   reg:
     maxItems: 1
@@ -54,6 +58,14 @@ properties:
     description:
       Internal buffered Reference. Used when ref-supply is not connected.
 
+  vddh-supply:
+    description:
+      PGIA Positive Power Supply.
+
+  vdd-fda-supply:
+    description:
+      FDA Positive Power Supply.
+
   cnv-gpios:
     description:
       The Convert Input (CNV). It initiates the sampling conversions.
@@ -64,6 +76,13 @@ properties:
       The Reset Input (/RST). Used for asynchronous device reset.
     maxItems: 1
 
+  pga-gpios:
+    description:
+      A0 and A1 pins for gain selection. For devices that have PGA configuration
+      input pins, pga-gpios should be defined.
+    minItems: 2
+    maxItems: 2
+
   pwms:
     description: PWM signal connected to the CNV pin.
     maxItems: 1
@@ -86,11 +105,29 @@ required:
   - vio-supply
   - cnv-gpios
 
-oneOf:
-  - required:
-      - ref-supply
-  - required:
-      - refin-supply
+allOf:
+  - oneOf:
+      - required:
+          - ref-supply
+      - required:
+          - refin-supply
+  # ADAQ devices require a gain property to indicate how hardware PGA is set
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: ^adi,adaq
+    then:
+      required:
+        - vddh-supply
+        - vdd-fda-supply
+        - pga-gpios
+      properties:
+        ref-supply: false
+    else:
+      properties:
+        pga-gpios: false
+
 
 unevaluatedProperties: false
 
@@ -114,3 +151,26 @@ examples:
             reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,adaq4216";
+            reg = <0>;
+            spi-max-frequency = <80000000>;
+            vdd-5v-supply = <&supply_5V>;
+            vdd-1v8-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            refin-supply = <&refin_sup>;
+            vddh-supply = <&vddh>;
+            vdd-fda-supply = <&vdd_fda>;
+            cnv-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+            pga-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>,
+                        <&gpio0 3 GPIO_ACTIVE_HIGH>;
+        };
+    };
+...
-- 
2.39.2

