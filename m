Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E553939BA;
	Mon, 20 Apr 2026 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679990; cv=none; b=MowBdEQgkJ+/lPENH2GoINTWQ/qdzaSDEcZ/mc2bxXgROR7XQ104SWLNKUwpJUzVYwzrZgp5aTHrcUEUO/Mk2EJjJbzJ0E8CWQwVaLa84F9FXgxQtVYUPkdTZNGdnxN+yIWibSVAswrlZapiGN2C3Ig/1L2HAZLgqHr2Nca6BMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679990; c=relaxed/simple;
	bh=jZ+kLuPLs960w8moOPtuIkrATw8/VTmjhMz9XzlcFVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkNqDO1+mpvZn7iuKg5ZvFn0a092KBQ4AjjkJO2pTf4/YSRlJnH8k6GiYSW0PcYdHZQUYRIerOFOxBZtgRxs196CzPR0kJjgkxpYy3VvkofJz7wTIrVma381X6nGKjPd7T8taSN3ZtR3sbe0L7cp9Jh+IHS+ktNwpOZry57BBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KnoQ3MDr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KnoQ3MDr"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KA2Vfp985454;
	Mon, 20 Apr 2026 06:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/gPeK
	A8g2CV5MCapvqegK+XV7F/MehIcuBjTeT6NxXc=; b=KnoQ3MDrMcwwBSVJU9DgZ
	+Gv3GTgPHD/4WTtDnlTZCZuTndxMBsmD/P3NHittCaRll6sIDus0KoB/grEtLJzv
	ZgaEzrgmGL8g5cPII+1GOFJcdw0JDjRWN2mxFnTbTzg+xfeqRcMYRBlXgZU6cJFn
	GMxclijsTI2R6tuVgi3E08BQdB5wPDZm6WYq+z2HrWds7wNK/5/1R6QnuChKCasd
	wz0/dX8c5mGuRAL8FNzMi6SZ5zkth6SpJhhBjobL6w8PwtH6gXU1n0mLlleOxiq0
	Fc7CBtuloKj1NobuEjz5gEsZtMw9c9JPp7SJ82mEwQ+JoeSx68TdyVephqoB8+jo
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dm3t1dq1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 06:12:50 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 63KACnMI007711
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Apr 2026 06:12:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 20 Apr
 2026 06:12:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Apr 2026 06:12:49 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 63KACUKP006189;
	Mon, 20 Apr 2026 06:12:43 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
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
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 2/3] dt-bindings: iio: adc: ad4080: add AD4880 support
Date: Mon, 20 Apr 2026 13:12:24 +0300
Message-ID: <20260420101225.4173-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420101225.4173-1-antoniu.miclaus@analog.com>
References: <20260420101225.4173-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=NKjlPU6g c=1 sm=1 tr=0 ts=69e5fc23 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8 a=IpJZQVW2AAAA:8
 a=eYjWAXzLS8b0uuH4XOwA:9 a=E8ToXWR_bxluHZ7gmE-Z:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA5OSBTYWx0ZWRfX5tvvfek9zV8I
 4QxfHmyhbP1p9ou0BULexNwsj7qOqkujh25QKVWWLfU0CQyprJbHFanqZ0sxVX2cYsudahZXGcG
 nY/OuQYtSXMG7RP1eaEbwF7h9gYGI7ZCu+ZVRAImJNt8PX8ZUyi75XXfww3bw7gVjgG/fbLSSCd
 SC5rdFVOlzxRXMV0AmmkJeZl3Kl0luFT7yVaaO9y4HaXGvO9cHiiGPIK8Oe1atmPojOCWm0qLQJ
 ScywnICLmduzNqooqREuvpoHnfBaMu7++nQe9HYxEW7vntogWPnMiy8+XPEvDmMO8kdpG4YixIn
 CyqiJ4fodBU0JOtX+PnmaZcscexOyar4ZzVv0EBEaoFxhZ1MySxLwCgyXSA28+/Upfmk/08+ioz
 Oq7ooyetx8oSJWh+xb8A7GWZF7lQcnQrGwpM0mv8sbOEm2aMkIVvyfFBiyb0LAIaQwhoy5Sh8xy
 PRt/ga2wsbJwdQWO5qA==
X-Proofpoint-ORIG-GUID: D6l9K0FsUkmkMWs4OYVa7SOB70ilcqhP
X-Proofpoint-GUID: D6l9K0FsUkmkMWs4OYVa7SOB70ilcqhP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200099

Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC
with integrated fully differential amplifiers (FDA).

The AD4880 has two independent ADC channels, each with its own SPI
configuration interface. This requires:
- Two entries in reg property for primary and secondary channel
  chip selects
- Two io-backends entries for the two data channels

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v9:
  - Add Conor's ack

 .../bindings/iio/adc/adi,ad4080.yaml          | 53 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index 79df2696ef24..9c6a56c7c8ef 100644
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
 
@@ -34,9 +38,15 @@ properties:
       - adi,ad4086
       - adi,ad4087
       - adi,ad4088
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
@@ -60,7 +70,10 @@ properties:
   vrefin-supply: true
 
   io-backends:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Backend for channel A (primary)
+      - description: Backend for channel B (secondary)
 
   adi,lvds-cnv-enable:
     description: Enable the LVDS signal type on the CNV pin. Default is CMOS.
@@ -81,6 +94,25 @@ required:
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
@@ -101,4 +133,21 @@ examples:
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

