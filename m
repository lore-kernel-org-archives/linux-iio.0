Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6702729B77C;
	Mon, 16 Mar 2026 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661556; cv=none; b=ViAACXX0xTfsAXphFn5PwUF5oluoHjt5R5uGWap3MRVjlLFeJIADmNs8wJFgdUvQg3wVdRjoy28PiTX1X7V1mHiIRREpx7V/EZoAty6zSKc15dlNKu/IqN+8TE0GGp8yyuRTqv9P/kfmngFC108UwwXWcRkpF7fHIm7Dyap1WoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661556; c=relaxed/simple;
	bh=yFLfpY/onBD265XzptSlQbCt6yEQQN2n8yaCBgjYgio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhytY5VHdv/8feng+i6QeL+m03EaOubyRhtda+yksn75bHw8l4PUK2BY9LtYpRqNWCZwdqFO/ew3LcANqWZt+oOQpZU5JfG0GKxg/SO9w/GnTctPJCbpBrFLwofxdqceUewqVp+8MusaYk5gGo9vHHfR+igVnNiXfo3unZUBZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OsMg0xuK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OsMg0xuK"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G9bQfN3761351;
	Mon, 16 Mar 2026 07:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xkFFp
	hqVaWmc6QZMdMlVkNUfHORJfdnwhPsOnmrpRPI=; b=OsMg0xuKwkwLd3u6m5riY
	tWDsHpYOg7Dh41dD9XR1BwNpeABj9mnPvX7T9QxgQorLKUCgFt5KajZlOIekjdtw
	AzYSULHf/42ZAJjGfJLLiMXVsoAycZET1ZRpS+UDglx2jPQBEZRrVZrij17bERK8
	y4WVhl7mz0BhluSKlGFk1nN4YYoOj96d0kgeujcpfNdKMhCf+be2s4Dq4fYMxXiN
	l8/cX+pvUT4u/kR0/gF92YKNau8TNULcwxmVGi+nlGTVNApI22XdK2JosZBKU2JK
	LRDKML8zJdZjy0o6pRGFlP+hAeldh1q9nV/U5RF28RljrF9jfj1iqkpCiJ2qQBen
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cws0fkx0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 07:45:36 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62GBjZLX002701
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Mar 2026 07:45:35 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 16 Mar
 2026 07:45:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Mar 2026 07:45:34 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62GBjIwE022985;
	Mon, 16 Mar 2026 07:45:20 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <cosmin.tanislav@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 2/5] dt-bindings: iio: adc: ad4130: Add new supported parts
Date: Mon, 16 Mar 2026 08:45:16 -0300
Message-ID: <6cfa7455c70bc87034ee6050df8b17bede6ef833.1773311639.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1773311639.git.Jonathan.Santos@analog.com>
References: <cover.1773311639.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4OCBTYWx0ZWRfX2baKuMPi6UXe
 NaC/qys+wsafCkH09VyKZQQEJ5jY0AAaSto9RJVjB7BYV7h29R9M1Wwm5cccOFsl2E0Y2THS7qz
 0HplffMMZPW9DDzVERkoSRSwWP+fghqnC4RhaGChNXtM2GRmXTdbBZUofHX8MYWa6wgEMOI3vXQ
 p4gUiFuRCZlq3VkqM0pXkUkyNQQb0d8+IJgrfbLJEl8mWY2KCU0uqZoaotAa9yUYp58wL+tXSie
 h00+ZnyTVeMVr8UI+i/YDZGGGj+97kkJmvj/1Lfqtaad5T3ji3ojBpIBShGxuVT0u+Ttw3EXT1v
 zlAfzUltveOA2AzfLmMho4RjGM4FrthwMue6WSZm8ZcYJoLM/HvDu0jfv35o1iDDlcrN/yFc+CR
 xahepjRkDD2WeUuEzstqzjtgw8renrsEqZBsmMvYyJB7GKbEFDm2Lwkqpwfxj6kPHSG0MK07Uh5
 5D9BYyQafS/QylInVDw==
X-Proofpoint-ORIG-GUID: VaDNyKzRBHH4N2WYtL62uDbGAgaXyvsi
X-Proofpoint-GUID: VaDNyKzRBHH4N2WYtL62uDbGAgaXyvsi
X-Authority-Analysis: v=2.4 cv=BbjVE7t2 c=1 sm=1 tr=0 ts=69b7ed60 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=EUspDBNiAAAA:8
 a=asbD4md8-q6e6i43ReAA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160088

Extend driver support for AD4129-4/8, AD4130-4, and AD4131-4/8 ADC
variants.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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

