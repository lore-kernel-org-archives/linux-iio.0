Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F732301493;
	Wed,  1 Apr 2026 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044725; cv=none; b=bXCId0Ha4qNROAlBqkLFFurP29pMOVgilfMqm8XK1blgGv/AxGtlM0a7Hz1Mi7GxcoN57rUhJOJOrT6tqII/OuSHR9/73PoRHq1nkvOQPOLonKybLvXHIevDj1g7EmeXEV3PWtsvCPYbGydOk2TBJb3+1IEjZhvsz6x2XjFpSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044725; c=relaxed/simple;
	bh=A2NIc9DWD3chq238o8jN1bK804S6xeTRnFuLgnF1O3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJXUo5/OWaFr7WsASrFokNsWc4AzsgGOsM0Xn7UHZVxAnDQRog2pEaS0+layr5wtyCV2IJngXokNC6uH18j64TZLM7duqzph5izf1fjGD5QlQd2sFG/1qqzFT6Hnpfuj3skLw5773Zo7lxr6GPy+uETiZ0qdfc0Vr37991IHiFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=j0gqHuH9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="j0gqHuH9"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6319RkF02772144;
	Wed, 1 Apr 2026 07:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yKVGI
	tDw7DMgcaSIrizdQG0uanIJcvBKNDTKyvdAfcM=; b=j0gqHuH9byEtOT1ta6eTk
	f/1yCsOsZBQzm4FW/Ijv10kdFDXsX0euABvB10IGJbNIxEyyIpDtgbdwJIvJDLqu
	PGZO8czZyv/m5K5nSe3TybNbzviGybAWBTYtvSjBKqrJdmamG3u9l+b9M86FlNVp
	8anolrzXc/eWL8V0MO/G3lU8MQ7ZqHRLwBnnxEYTXbNFmpdfhZUM++4XJWVj/VO2
	lXFBwEqz97o2dYPAoD2roEVBP5WRXsGsGcM+E2jiKeoYE/zKIZkPtKMQpA4+29bH
	yqeiFVQ5p3Xko0U+gExG9IdOLaCX6XAx/6KC4J6N8HfSGkmb/AszOXgkajRERbDt
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d90rjggmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 07:58:29 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 631BwSax005216
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 Apr 2026 07:58:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 1 Apr
 2026 07:58:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 1 Apr 2026 07:58:28 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 631BwD7F011475;
	Wed, 1 Apr 2026 07:58:15 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 2/5] dt-bindings: iio: adc: ad4130: Add new supported parts
Date: Wed, 1 Apr 2026 08:58:12 -0300
Message-ID: <7bf387e8ad20e2f2bb14534fb03608bbadfa47d2.1774996100.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774996100.git.Jonathan.Santos@analog.com>
References: <cover.1774996100.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=SuadKfO0 c=1 sm=1 tr=0 ts=69cd0865 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=EUspDBNiAAAA:8
 a=asbD4md8-q6e6i43ReAA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: HSYMfBc0y8OzwR_xy7rLYlO3we-nEKKk
X-Proofpoint-ORIG-GUID: HSYMfBc0y8OzwR_xy7rLYlO3we-nEKKk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDExMCBTYWx0ZWRfX8fbCXAJI5RI1
 g2pECkS1p/U0d4eTdvcVXzrnBnHegZCpyJNMxta82BuytVH+0b5vZBH+krNwxlMnIwb66Mzyvsz
 La0anxpveNgKCAT8sPZG1vztDR43ka8ECf6JDFmvWIJCIz6tDa6VTlCJNRVLkKDwkpbADKpeQKV
 RCoxhuG5tsRVpHUQMsPZlULRPUXCeaaMQdgA0LsQaQeeOJFili7GRxX29jr4h57ypP+/tUQYN6V
 LbY6LEv3XWw+kiVpY8p3TI1JcmFWmQYHnsuo+5LHcCgs4bCxZqCSDDiEm51DygisSq9xcxG74ey
 MI3zaWIqxAMupjAdDx4hPiVfxXoqT375WzE79jZHViMoWO4v8vyhqrNQ7HEXL71xwmGIo2ln78t
 S+OPuDePvmr4UnTdSW7hFsQS1TOfGb9Hj6yvbkcrPAIBOSZehFfRTmaEUiWwvS8Xiq4uzTwF7pX
 5YjFXHkAJyQbMfnwGKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010110

Extend driver support for AD4129-4/8, AD4130-4, and AD4131-4/8 ADC
variants.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v3:
* None.

Changes in v2:
* None.
---
 .../devicetree/bindings/iio/adc/adi,ad4130.yaml   | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
index fcc00e5cfd54..f4cad68fa04d 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
@@ -5,19 +5,30 @@
 $id: http://devicetree.org/schemas/iio/adc/adi,ad4130.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices AD4130 ADC device driver
+title: Analog Devices AD4130 family ADC device driver
 
 maintainers:
   - Cosmin Tanislav <cosmin.tanislav@analog.com>
 
 description: |
-  Bindings for the Analog Devices AD4130 ADC. Datasheet can be found here:
+  Bindings for the Analog Devices AD4130 family ADCs.
+  Datasheets can be found here:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4129-4.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4129-8.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4130-4.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD4130-8.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4131-4.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4131-8.pdf
 
 properties:
   compatible:
     enum:
+      - adi,ad4129-4
+      - adi,ad4129-8
+      - adi,ad4130-4
       - adi,ad4130
+      - adi,ad4131-4
+      - adi,ad4131-8
 
   reg:
     maxItems: 1
-- 
2.34.1

