Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C22B3F1ADF;
	Mon, 20 Jul 2026 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545728; cv=none; b=tRK9x3hupaIbJldLouDy245Dcipm4l0rYJsNd1FJPH1TyYuVR7n07UkaS6vmPLrSrgsx4HwdnoeScqThZZPVsiNsu0VVTdPbG1uutTiIY7s48LcDsF55JK7asyaLOIlfQaJ1QsacgNE6Wn0KvjRGekn9qdtkxmVliBoclQzLSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545728; c=relaxed/simple;
	bh=v1sCRWM9xMdaxe4qPggvFj4kJMWlYs0TapUVjV+VZFU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sb4c9t3sqDUFYYhb9vibmf1LFCKBWZGCA/q4aQSKCqlYY58qtILmkbi1a/UGWn1K0die9uKGj9V0xkO8KehTPUJDFHI6oBA5AyJexlfbFys51gbjiPMzikf/7uQNe9lmgnCUZJ1/bGX/jBe5CmcuRZ1X3iuHBZ0YjPfrcBNXkDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=q6Im3MaD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="q6Im3MaD"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KB0TAW1666664;
	Mon, 20 Jul 2026 07:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QvoP+
	d++6POfSEeQbspRUUqnawBPutV4uvkkFraJnCk=; b=q6Im3MaDC/HCn/Vg/uHsB
	NF25++jY6QlmteZt0j12Lvu+tPNH3/NbGO6BgBrKYWuKgpML1oPIpT1VS+j2svFy
	9yMAPVwVPMuMFDojKva3WVdkeKaQb8gCBoEKK5iD4TckH04IkaU3tP/aw0Ef1VYb
	PTTfc/DLxux3cUU+HeFz0oB2Qt8V96XUFB4DIRpaXGa7iFHv2PO0KolGycA0vfX/
	/Tx7PRRQpKDxb07ZKHxKGOchvfgZZxf8rklWYhezNG6Tr/sMKjjX8qMk1nJ+M1lh
	DxRqFcvtoypfTmP60wkzePBPjXfcWNyrEAy2o2YjKz8RvBwp+xGQOUkXNd6Pq5fX
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fg6d1e9b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 07:08:40 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66KB8dXA062900
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Jul 2026 07:08:39 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 20 Jul
 2026 07:08:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Jul 2026 07:08:39 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.186])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66KB8HRJ024360;
	Mon, 20 Jul 2026 07:08:32 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah
 Khan <skhan@linuxfoundation.org>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Radu Sabau <radu.sabau@analog.com>,
        Jorge
 Marques <jorge.marques@analog.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Jonathan Santos <Jonathan.Santos@analog.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 2/4] dt-bindings: iio: adc: adi,ade9000: add adi,ade9078 compatible
Date: Mon, 20 Jul 2026 14:07:45 +0300
Message-ID: <20260720110754.7674-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720110754.7674-1-antoniu.miclaus@analog.com>
References: <20260720110754.7674-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=ds/rzVg4 c=1 sm=1 tr=0 ts=6a5e01b8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=0G5oFKN4N_cOIownKFoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyNCBTYWx0ZWRfX/6C+xId1XTo0
 nBaz6AvDMBdjukgKBiHYpfYHOUDnaBLm+UgSDABLMVe1dt2eGP4QVY6pDOTH3Iqyk1rkHfzSrCn
 R4PdA11hrVOwZOsXJ323HMuFNJzGTo2z23HqrLRcOorrDVtDIz7G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyNCBTYWx0ZWRfXxaQf0Edx3IHQ
 4Pq4FibbRom/tifDyjEF5SDvci58rddNip8x4m/a+ptw+Pk8Cotiefmn4yW+La5a/fKdJ4O0yMy
 xu56u0v8VPiqVVZ0EZ8ubiaLVHFwwaV3PldtFl34+td2V7Ga7Oo8W281UGrTyFAhblLP1uP/JiJ
 CKN6DGtQIdeHxk1tkfIX9Mz0Jdjkloj1kJn868keUNwwuN6FXWotaRvRTHi6av8MygeI/yIstYY
 h5QKiaN60Ha1bm+2q+ezcw2Nesqh9adToESbD37HUE91IiLLTKVvj+8bjUasKuluNiQAFbh9Uir
 dwwjXVzM9uRtCKZyVqVDIvnqHKDmNDAhAwepcfADvmK4FsMKPZ/XvavpyWiOsRuK3l9acW1g9yh
 CYU9+bM6IbSFqACqIYfRnEi43v0w8W6ZZda+yXNLdECXiweBs6/tkwfoVOqnHhakxvYFp3NpPZZ
 vSKhHNplRBTEh3tPKMQ==
X-Proofpoint-GUID: 5cQMAQByALub4IkH53X0b7W80dk0UdxQ
X-Proofpoint-ORIG-GUID: 5cQMAQByALub4IkH53X0b7W80dk0UdxQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200124

The ADE9078 is a polyphase energy metering device from the same family as
the ADE9000. It is register-compatible with the ADE9000 but does not
provide the on-chip dip/swell detection and is limited to a 10 MHz SPI
clock.

Add the new compatible along with a conditional constraint lowering the
maximum spi-max-frequency for the ADE9078.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../bindings/iio/adc/adi,ade9000.yaml         | 30 ++++++++++++++-----
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
index f22eba0250ee..1e940e8c7297 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
@@ -5,21 +5,23 @@
 $id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices ADE9000 High Performance, Polyphase Energy Metering
+title: Analog Devices ADE9000/ADE9078 High Performance, Polyphase Energy Metering
 
 maintainers:
   - Antoniu Miclaus <antoniu.miclaus@analog.com>
 
 description: |
-  The ADE9000 is a highly accurate, fully integrated, multiphase energy and power
-  quality monitoring device. Superior analog performance and a digital signal
-  processing (DSP) core enable accurate energy monitoring over a wide dynamic
-  range. An integrated high end reference ensures low drift over temperature
-  with a combined drift of less than ±25 ppm/°C maximum for the entire channel
-  including a programmable gain amplifier (PGA) and an analog-to-digital
-  converter (ADC).
+  The ADE9000 and ADE9078 are highly accurate, fully integrated, multiphase
+  energy and power quality monitoring devices. Superior analog performance and a
+  digital signal processing (DSP) core enable accurate energy monitoring over a
+  wide dynamic range. An integrated high end reference ensures low drift over
+  temperature with a combined drift of less than ±25 ppm/°C maximum for the
+  entire channel including a programmable gain amplifier (PGA) and an
+  analog-to-digital converter (ADC). The ADE9078 does not provide the on-chip
+  dip/swell detection available on the ADE9000.
 
   https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9078.pdf
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -27,6 +29,7 @@ properties:
   compatible:
     enum:
       - adi,ade9000
+      - adi,ade9078
 
   reg:
     maxItems: 1
@@ -67,6 +70,17 @@ required:
   - reg
   - vdd-supply
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ade9078
+    then:
+      properties:
+        spi-max-frequency:
+          maximum: 10000000
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0

