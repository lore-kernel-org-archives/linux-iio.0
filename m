Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18C3ACA68;
	Fri, 29 May 2026 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064076; cv=none; b=AkCZjCJ8Wcq56RI8OmHf7KHfKyXZG974lKQPpN9sA+RFtDdyzMy6aZrU/iZR+KLcvq2obHjOH/1FSnHZexEdtazAJS/2yRoyDSeNFQi0aDjzsQBcK5M6WyJhBmFDrKtRtoQvEOnpvy21+7Omnt/EBlI9pGolRR+JCH4n1X2oI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064076; c=relaxed/simple;
	bh=4r/NCvqUy92r0Jbag11j7G7bEZ2kL14zOVqm+baV3cQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V/pRkEXaySXoE8s/dnPeO49CV01JemMXVYsMrjdpZaKPmu4ZF8WDrp3deou5Xq9uhPD6NWLlBrUUQeJCHgIVPf8XtO9AANJn+LRQoxG4mQM/8gJ+HlRwS0T1XpVhlRsqwvtC4LRF3EK7rPBqIY2Z2/lp5TfXyM3LesCrGxLNpiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0HFre1JN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0HFre1JN"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TA4Pok400344;
	Fri, 29 May 2026 10:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=w3RhsycqPFR9LA196+NaEfDIsUZ
	8mFCQ4AiWKzFkNCY=; b=0HFre1JNWMPJ+R+Eh5OHc5lbJpN/Hxh2Em7UVVKNALZ
	2PQnlDntZW79TJxcARsL/bR5EtdEgBJ5PEFiT/dtHwKqCbxK21DT+sai+TSRLEBr
	Qjng2C/ghYNJNlqSKLLOtr2+/RofNb7g7fNhNK66p04KJ9xQkXNrKgZcOa7AhWk9
	0r7skCwas039nCOVV+VSN+y7wq2dqlJTBAMa/kQIiCQVuaSLQwrxQPC6sG0ZiXI+
	cEOz/pPuVmtGKBEXP/EQODHBJpPhyEnc2KIEhvyqOWFI3O5xMEr9KV4ZIo6248xn
	x6FVlRJCrLqxTsxrnkLJhV4o21wy0HIEZG6LhbPWk6w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ee7x1yr69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:14:30 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64TEET3S012812
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 May 2026 10:14:29 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 29 May 2026 10:14:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 29 May 2026 10:14:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 29 May 2026 10:14:28 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64TEE8Ma020671;
	Fri, 29 May 2026 10:14:15 -0400
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
Subject: [PATCH v2 0/2] iio: adc: ad4080: add support for AD4884
Date: Fri, 29 May 2026 17:13:51 +0300
Message-ID: <20260529141353.8492-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0MiBTYWx0ZWRfXxdBkSgvua/dc
 UaI5UESZypBMpAL+8FvKulCFDT7TxfGDbCgu0pvWo345PEli+B9/uKVQOnzkJCpYMn9B3k2/sz/
 TOgeW6pJMkdejbCD2sIhC6/5y7SeMuDcTtb9fVIdqP8KkLEDKwajeH/xbl1aKd58VaIP3PlotNE
 PLzJQeGIFqWiqdih3Z+8dZ+bpigC/7LRu433s38Mwh3Vl717RARJbqzcIcfnFMRaQNFjTC0rnZJ
 9dQY1fA4KxkmdKsxRirVUGCBm1uC4UClw56mGIBs5gokLp8zk0xcXS2eU2mTmSbkYCT2A6tf5Lq
 N3p+Y1r6QSAhPbGr+4EVHu1B630XjA06v83fI6XqnIlXji3+Ktk/zu1e1/FSTc8NfikRgwfxirN
 BDRwyectM/hoyZrYnZMzyyIIzNDA8XhnVRnpUNGYNHppRAxI1O2EsHC6wxv0hIGPh9B8a72hQmU
 IImBo26c82KZRGCGc8g==
X-Authority-Analysis: v=2.4 cv=HMbz0Itv c=1 sm=1 tr=0 ts=6a199f46 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=mHfdNUOf9pWPJ8OnG94A:9
X-Proofpoint-GUID: qitavqlYJhJ0lvTFLvAfxgF6pdyGksUH
X-Proofpoint-ORIG-GUID: qitavqlYJhJ0lvTFLvAfxgF6pdyGksUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290142

Add support for the AD4884, a dual-channel, 16-bit, 40 MSPS SAR ADC,
to the ad4080 driver family.

Patch 1 adds the AD4884 compatible string to the devicetree binding.
Patch 2 adds the chip info and device ID to the driver.

Changes in v2:
- Add rationale for no fallback compatible in commit message.
- Collect Acked-by tag.

Antoniu Miclaus (2):
  dt-bindings: iio: adc: ad4080: add AD4884 support
  iio: adc: ad4080: add support for AD4884

 .../bindings/iio/adc/adi,ad4080.yaml           |  5 ++++-
 drivers/iio/adc/ad4080.c                       | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.43.0

