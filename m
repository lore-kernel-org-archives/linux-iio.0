Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1CD301493;
	Wed,  1 Apr 2026 11:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044714; cv=none; b=Ap/RTi3f+zthzr8knXY0i8VmjK8slUZeNZhvIqxL2tUhlJKPkmuZrue+QAY4+Uuxz7E9bJ8aSqR3l6dZ1jeh7E1v5D0jEnVLnmIzBh/34aDrGFSWGcKIOjwGZ89l3k8w76+vwVaSx7hsV6KJRbF/U63aEpriCL7lmwLroPNc2v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044714; c=relaxed/simple;
	bh=uL0BnRn8mw2pYnDGEWc/DvtehmfvXCHZQx1yuse5GpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rh03KbSlJ9z/eOWaAIqfBAnXbpRslxIDU83JkpRq8zbcZEhmeb4m5Ev6f3+k6bDadKEaw5xPqgJMgaZ05/534ZapgGZrs+zz7Ub1NYfA9HCcaHAXTLOSl1JNnjagfOAa/n2FNdC3L+pjdTxZaBMwPtg2ARwTFacuWVFoYW5PEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FVKOW0Wq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FVKOW0Wq"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6319RibJ2772118;
	Wed, 1 Apr 2026 07:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=60Pft
	nCrk6Luw4qU9Myy0wC2CBVmMnTRMVWYO1Iavbs=; b=FVKOW0WqlKX4RAqB6nRRz
	JWCVm+Bz9cbeGADUzQhix+UCgwI/0E6PJKLFgRly4VGST5zXbypd8dCF2+LpKpqM
	zMFKb1RkVjVxjjWrqfhlgxAcbDm0EDEYIg1bFstH+Z5whAFgkKZCkVMYiUPntpQf
	Q3xbF6Ng0IDwCFobOq31WBRzutKC5gKx08j2WvIVguPJ21yZaw74ecmUAEMKp8th
	QMWt9MWzFU28HMo5GHpmKSeOPgDcWHEhCd4kJj8oMZca4v6CNtkmJB83iwIWigjC
	zEdnkhbEPrBOZxjZu59dolhAONITGZSaVY8vpNaSS/56Mp5IYtK0B7nAq2fArBv9
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d90rjggm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 07:58:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 631BwHqQ005168
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 Apr 2026 07:58:17 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 1 Apr
 2026 07:58:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 1 Apr 2026 07:58:16 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 631Bw32Q011467;
	Wed, 1 Apr 2026 07:58:05 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/5] dt-bindings: iio: adc: ad4130: Document interrupts property
Date: Wed, 1 Apr 2026 08:58:02 -0300
Message-ID: <6083ae055df31c78dac2100b4f35874e6d655d0e.1774996100.git.Jonathan.Santos@analog.com>
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
X-Authority-Analysis: v=2.4 cv=SuadKfO0 c=1 sm=1 tr=0 ts=69cd085a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=EUspDBNiAAAA:8 a=gAnH3GRIAAAA:8
 a=SOcA0PiadbpJRY9D2DkA:9
X-Proofpoint-GUID: Q34-w7UdE7pNA2DsaZakDd9jh8mpDtH2
X-Proofpoint-ORIG-GUID: Q34-w7UdE7pNA2DsaZakDd9jh8mpDtH2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDExMCBTYWx0ZWRfX9lToUvquVUop
 PcAr82aWh19SvPIdqMLeDG14AEpZApKAzmLBnRLlgX3YwDM2macrQ1G7/hzZs3u91okuHz92D8b
 RfOZ5h/lnbcqIuY0UVJA4mCAthxWq6ZIGg4WL5ULLjyYBgFWGnRPEX5CGY9g40tGS078IvZnF/b
 z95n8qvSotj9yS5aEQdMuFwA1rnL1Sm43ow0hIlwVvukNWsWetdT3TVIHgwCsV6zovpzkc/ZVwP
 b7lbb/BzpAvylQVlkTeLkSCTFwTn52tixfWBVlUoP37Gpj+AoswAblx6MreA0uyo/B+ubL20340
 M3wj7w+6Od0ykIH231D5Vo+1b4Fd5dIUuLig79AC0I8BdfbMZ1SuNgTbZcbH7i8CdSLsCTB+fiS
 7qzbg8RQ3Qes9FQVkhh2Ta/24ouvmjPqztADMjSiaJNRQSRAp+w+gdT/HUGRbfLcqOyqWcHQ2Sv
 ZFko0JM+C+NArk1KMFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010110

The Data Ready/FIFO interrupt has a special behavior that inverts the
IRQ polarity when devices with FIFO support enter FIFO mode, while using
normal polarity for data ready.

Document the interrupts property to clarify this special behavior for
users.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v3:
* None.

Changes in v2:
* New patch.
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
index d00690a8d3fb..fcc00e5cfd54 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
@@ -32,6 +32,10 @@ properties:
 
   interrupts:
     maxItems: 1
+    description: |
+      Data Ready / FIFO interrupt. For devices with FIFO support, the
+      interrupt polarity specified here is inverted when the device enters
+      FIFO mode, and normal for data ready.
 
   interrupt-names:
     description: |
-- 
2.34.1

