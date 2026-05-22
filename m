Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5603ED5C8;
	Fri, 22 May 2026 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450903; cv=none; b=HMIK/ivG4jPPcVBVV5GxpdhlDycGTabYXb1W8DmvKzQ2fGOssJF7SSEHT0zSAF1RvO2IHGQYIkXRA65wB1fdcsUSCPK0I0362cVfv0x5KlUi6/yTK9takc2BxPa6L5LNnZe9g1d0CsN1E2W1k43M735ZSO1w0prRIQaqyqihSLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450903; c=relaxed/simple;
	bh=RSnVb7yyYh/R1A+dTAHaxCZLBTh72z0ij2KCqAyRBi8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iw5OrFZHS5sk5brC9nrDN3pKFS44MFEjDnsiqyGx9EfJYJ5YYSSW6wXd3RxkPXNcaTItWkKqtemZsgE3y8joK4cVbcwiDnEnCO1hnetnR7F62g1cBxYTT5PMlilep8balPAGPC720hqv2dbEy2OzDjL3tP7UXpch0/RHNEzsMNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TOqI6oDe; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TOqI6oDe"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MA4VD81374765;
	Fri, 22 May 2026 07:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=azd2U
	eVloKVZ2hkkYZCmNGV8KA9CNXeFPJ6dlNBq3pM=; b=TOqI6oDevWkEe5S3K01X3
	mFWjhk7+rAZswQ/DTZ04RgHmjjb/cQ2Kuxcm2dp4B1G7HSEMNkp/RIi6/OyaW/li
	cDuRM3DI5ZQ9oECNtzBeX+OEC4JdPGfT167EAm5mEzbRYbXZ94pB0eyjlMmb3BEf
	H+sPfIQoP+qVXLTpbV5m/HW9LJPwyXjc1EojlmNKZWI5M87vAKpC7ljSBMmC5BaG
	2pPUFcE46wqF8Dn6J8VNyCmY+TTV+Jeg5MfxeG39j1frRw/PJAZCOLsh3hCDzfop
	X7BNnaHn+oZgTZlgTD29XDOJmm0X0mOWsj5la0BFxDkaKIV71e5gmg72vVYeUDCi
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ean2t89h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 07:54:59 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64MBswjd020259
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 May 2026 07:54:58 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 22 May
 2026 07:54:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 22 May 2026 07:54:58 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64MBsi60027511;
	Fri, 22 May 2026 07:54:51 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: adc: ad4080: add AD4884 support
Date: Fri, 22 May 2026 14:53:36 +0300
Message-ID: <20260522115337.18188-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522115337.18188-1-antoniu.miclaus@analog.com>
References: <20260522115337.18188-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=PqOjqQM3 c=1 sm=1 tr=0 ts=6a104413 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=w5vykfj34SSMQZsSxmwA:9
X-Proofpoint-GUID: qu9XNYjE7WUhEiycz6UXFf3vzi3bAHep
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExOSBTYWx0ZWRfXwSRejZRKJ3Lu
 Svwwq7XDJPVHvGecz9mlj2++0ytfmK9zIl0kznR/lwILzlXzbvTKNf3gjH/AzNnM3qWDWMTB04X
 vv9XhY0Et3SaPJvrwA9YRem+9rO8YjXNlSSyYbrku6LBr6JwY65EfY+c1PbMdlB9pQJVXvY35wV
 Csygg53epFBxKAVJUDHYrGhnuGEkxq7t50kS1an4QEDIvH4E0Z19d0DKFTDIWIORR+fZommO38U
 FVLlwX3vq9tbMBCArC8nRPmhHvlMkVNLxdHA1m+TTa+x8+IkWj3yEtQue2IReMKcRJzn1ZoRFtQ
 9L/mWDbAOt4Epo3tPSeYFcnmgzQz5ewwzklxcNvdrSZ83TJT/ioHDxmHWo+xrOZsZsuG245IMCp
 Xd0081nskpqOVXjctfTXNNbcoofF+7AtfI0fykFl+DHFHOdtKbRuEGoz4ixGkbXq6JDuS1P8exu
 3X1FdW1pINRbuJsxpfQ==
X-Proofpoint-ORIG-GUID: qu9XNYjE7WUhEiycz6UXFf3vzi3bAHep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220119

Add AD4884 compatible string to the AD4080 devicetree binding.

The AD4884 is a dual-channel, 16-bit, 40 MSPS SAR ADC, sharing the same
register map and interface as the AD4080 family. Like the AD4880, it
requires two SPI chip selects and two io-backends for its independent
ADC channels.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index 9c6a56c7c8ef..4a3f7d3e05c3 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -39,6 +39,7 @@ properties:
       - adi,ad4087
       - adi,ad4088
       - adi,ad4880
+      - adi,ad4884
 
   reg:
     minItems: 1
@@ -99,7 +100,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: adi,ad4880
+            enum:
+              - adi,ad4880
+              - adi,ad4884
     then:
       properties:
         reg:
-- 
2.43.0

