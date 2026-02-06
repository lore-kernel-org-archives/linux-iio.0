Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4B0346E4F;
	Fri,  6 Feb 2026 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404547; cv=none; b=StUU4SHS7TodU2xQspCXfJgFQ1H5ssyR01l26TBmOYB1S/xsyAVANSLsRNgeuAlOLiyMqELEZpAiSktEuSmQrgRhFHow803DhC3Ylj0D/b2NwK2bXb+3/7s6AjKsMGTcvUgpyvB0uOSs4SV1VRzbOoxBs7Wi3r2dpv853WJ4Cp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404547; c=relaxed/simple;
	bh=BmK4m5noK/7P1wHQI3ng4vADWwcW+ROJUWsbUVckmqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRnafeECYkIANRTGOhFifawnp3D4tdeBq7mOlP/iXjRIxtGIQJx3DOy83feLa95oYZDjHFz5lSX62FDMHyrQHogDIHDXj/r/MRBOz3Zl/kaVejWyluknMzRnzU1lJ8Toe15+hHSbAnaY62GlkMYQxBs+r8ELZboQS6OO9PFDXxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yKy5ShUI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yKy5ShUI"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616GLPbO1622554;
	Fri, 6 Feb 2026 14:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8wXes
	xOkEWwDd8oNdhUhd3QCfJS6RispYE6MIsEEOm4=; b=yKy5ShUIMJo0GqLDPUo4s
	lGwhmWcDlEupc2+hPd/pg4am09YYZWW4BzBeKV2FQKEJODfIgs66WziZ9SpTj9Kl
	/2ekmi78d/f9HIsu3tkbglbpFLbMa7uNgvKv8HrgtsvwzY3lWe0f283oNRDgw5vS
	ONvAb0MVFg2ynszWXgbrSzSK+kRNB6AfK1hyZljDRMMe2sywcz4IudjlXdgWRVvM
	l2kYf6OcnJtGshekbJk3tRi+Ei9a5dmLx9uWWM9Np5ey9Ycpc+yf2nj0Uoav5Lgz
	Fq0mN40gIPE375/j3H20Q34B5e50ZmaHDOVjxFtEEpIFxZ/Al8na0bttKQKmHH5Z
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c5e32hrd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 14:02:15 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616J2Eqp012879
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 14:02:14 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Feb
 2026 14:02:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 14:02:14 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616J1uot009033;
	Fri, 6 Feb 2026 14:01:59 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v8 6/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
Date: Fri, 6 Feb 2026 16:01:56 -0300
Message-ID: <61719f774d7a372819642670591c03dfcd0dc107.1770403407.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1770403407.git.marcelo.schmitt@analog.com>
References: <cover.1770403407.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: lEaZImLUhZXSRvv8O7rFVXVRES1faO6s
X-Proofpoint-ORIG-GUID: lEaZImLUhZXSRvv8O7rFVXVRES1faO6s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDE0MCBTYWx0ZWRfX76WRVOEvjq3h
 MLWRnbL3onoNpuXMgHfVBokgIG8LbkqPMEa/4CH9sRWPxd1quJyzavHaignnNNsowlJEUDqkFSx
 l/kOtVzbi4fXfX3BMw8Arp4pV8NbZnQ07GQ7W/JzpOWav5LEiLhO4sFkKL5fuI8Ik1X97C3Hg3f
 MeJ+PI585NzNzrq2ZlxWM9qDDx2nEfLi83Zbt7GOJuhHaGH8JIbjMG8vyn54mBNzVPlx6fBeskq
 3HzfJBH6i9+QQRXOYe5gEDD1nI6kZQX8SblEOiyneLbT1NedOWrrMJikYt6iiYoQaliiB1ode/i
 28eLspZRWFD/tnF5lq80rpFDtRnc8VjLNnpaseZiM84JCohl5+e6tomWplsrjgGc31ryGV6PaHm
 XUYVzz3yOtIUKDQWwvRAtTuo+ek2P5+GfbM6NEugrpEUxGLjWR3FZgk4drTjMrTNb7jEarPH1pZ
 JvkdelJJlOXj3AgvZcg==
X-Authority-Analysis: v=2.4 cv=NPzYOk6g c=1 sm=1 tr=0 ts=69863ab7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8
 a=0GKIfBuVSP7uAb9je7gA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060140

ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
PGA (programmable gain amplifier) that scales the input signal prior to it
reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
and A1) that set one of four possible signal gain configurations.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v7 -> v8
- Fixed issues reported by dt_binding_check.

 .../bindings/iio/adc/adi,ad4030.yaml          | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index a135c66142df..08b1f9d75f89 100644
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
@@ -62,6 +66,14 @@ properties:
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
@@ -72,6 +84,13 @@ properties:
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
@@ -113,6 +132,22 @@ allOf:
       properties:
         spi-rx-bus-width:
           maxItems: 1
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
 
 examples:
   - |
@@ -154,3 +189,26 @@ examples:
             reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
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
-- 
2.39.2

