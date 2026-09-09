Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D12E2C11CF;
	Wed,  9 Sep 2026 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942498; cv=none; b=DJgrduTDDm4dJ/AD3qdFkJNtW2s2cceeGkYlxMAnfFN3k0I3ZPlDudE+7PMtkktJcEWLV175sAcgXBIKK0NOaFiOx9pxOA61VUSoPtrUA499BvxenOiSbuUKUOF1GekvNZHU/mJvrvw2C9W3arlPcx8v1D0Svp4sSjFz5GfJ/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942498; c=relaxed/simple;
	bh=LRvi7azBQMQBjBllrLw/bRFfjiLUp+7QIMnRNUbkBfQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MlJcLxRoKVp3URq5IHwgOct3lvptQvxWSO072/zmOdPF5HpOn1aQVM7EbRFQqReW+c2urz5+aNDZRoHUX21WwDACjrKERDjeiXWnGg5iDalbgb/c0IqC0b6wB4/Kljg6txzy90qX64mbymDllgoqOZyDXGLhXtyPxHVhlwAxIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sYN4tp0o; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sYN4tp0o"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6893v01T4155414;
	Wed, 9 Sep 2026 04:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=HvRx6UEs2ZSLusUmV/gVreAmt+h
	0516s47tiYDL31I4=; b=sYN4tp0oXTHz/pVr2v0cftfLA0DHFSxWUWzitCbxoSs
	jieSg/d81R0Nnc8dMxPju2FeulcoX0RYfSUX89rd3IAS9U/t45kUzKnRvQgn0TL9
	9pzLwTkVtoKs4hT7iQEV2Cy1zQVpfHtmRxCAgQZh0fPg9HVHxZVU4+tseWO4eAO3
	TQnEAzdRGkxjArBiZ1dNd+6qyfl2Hx8x6Vyps55/XiPn79cces5mxPz+gSNu+jS0
	uCwjoicOd5QYNixerC+sCFYQMPIaGCxMGaQ+DplRXpWO7R4e5+U810XXPK9W7VqU
	l2gMZ+Ix2fXGRTLVgTrGtA36KCys68bzxMe1dR7TFYQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gjvfb1w5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 04:28:11 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6898SA4j001411
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Sep 2026 04:28:10 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 9 Sep 2026 04:28:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 9 Sep 2026 04:28:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 9 Sep 2026 04:28:10 -0400
Received: from HYB-li3PrmDPxTz.ad.analog.com (HYB-li3PrmDPxTz.ad.analog.com [10.48.65.171])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6898RxF5032752;
	Wed, 9 Sep 2026 04:28:01 -0400
From: Andrei Stancovici <andrei.stancovici@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Andrei Stancovici <andrei.stancovici@analog.com>
Subject: [PATCH v4 0/3] iio: adc: add LTC2499 features support
Date: Wed, 9 Sep 2026 11:27:49 +0300
Message-ID: <20260909082755.366269-1-andrei.stancovici@analog.com>
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
X-Proofpoint-GUID: 3h6MXQKw4OrETqWEhQWtCCl_f2T3JFKN
X-Authority-Analysis: v=2.4 cv=Yvk/gYYX c=1 sm=1 tr=0 ts=6aa1189b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=ZCGEuXmVW1eJA1p7E5EA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA5MiBTYWx0ZWRfX2MEtUEOsOwif
 fvAwwODdahen6hWOk9uOrElGtwn4hfDgPx2w0a340qRs+zfVE4pMAA0C4mhdiF7RrNgNbqGKoTY
 6u4tkRBgNFdRGzuM5EYvQ0oGt8/kk1wcVGX2+PPOnCfEcjbI3oPM
X-Proofpoint-ORIG-GUID: 3h6MXQKw4OrETqWEhQWtCCl_f2T3JFKN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA5MiBTYWx0ZWRfX3RA3g85sG/PL
 8iWXHj9KoyNvFJAGELE3cGiails8dreM0WUsKB4DR3Oqgsvv3iVE4DOJI2ZtrBrWlr5bVQTtw5T
 K29RaweamORVdqjf+YpID0qhMQDN7b5asVJPrRmxO6szW0w6HoHavFJVxigtUj8WuI6nmiPHC5N
 tPGUhtDxsKX3u2N9m+14DlTgGXgErp3sV+TIQcaeEWbR9h3siVlEmh93UDs+Tf0zYVRZnDLyCtq
 950AcB/7aSkTN+nh9G18befM+pn3xuJItoxJO/uX0+LVOjCA3V7ddbbjz/EL1sWLsousuqYHvaD
 U0cRN31iR2QFInawZjFrf2AfxPFORHKDuS3Je7KmfOeCiYlYuOExjr6nMzKM5i65Ycp6fA1as3R
 YZoP8z8yte9LVgQZG/XfICu2hzaLK6Rfwe9suW7ah9aE5NXfRsDBXn5X9JdGj39AFuC6hQU7Le1
 PM4ivAcRioD/OeB08QQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090092

This series adds LTC2499 support on top of the existing LTC2497
driver.

It includes:
- a small binding title correction for LTC2499,
- the LTC2499 internal temperature channel,
- the LTC2499 2x conversion speed mode exposed via
  sampling_frequency.

Validation performed on Raspberry Pi 4 with a DC1012A-A board:
- temperature raw/scale/offset read correctly,
- voltage channels remain sane after temperature reads,
- sampling_frequency 1x/2x switching works,
- pyadi-iio LTC2499 validation passed,
- hardware-in-the-loop M2K validation passed.

Changes in v4:
- The channel table is no longer copied and patched at runtime: two
  static const tables, one selected in probe.
- struct ltc2497_chip_info has its booleans last.
- Commit messages and code comments cut back.
- Naming settled on speed_2x / has_speed_mode.

Per-patch changelogs are under the --- of each patch.

v3: https://lore.kernel.org/r/20260902064415.132588-1-andrei.stancovici@analog.com

Andrei Stancovici (3):
  dt-bindings: iio: adc: lltc,ltc2497: add LTC2499 to title
  iio: adc: ltc2497: add LTC2499 internal temperature channel
  iio: adc: ltc2497: add 2x conversion speed mode

 .../bindings/iio/adc/lltc,ltc2497.yaml        |   2 +-
 drivers/iio/adc/ltc2497-core.c                | 298 +++++++++++++++---
 drivers/iio/adc/ltc2497.c                     |  42 +++
 drivers/iio/adc/ltc2497.h                     |  31 +-
 4 files changed, 320 insertions(+), 53 deletions(-)


base-commit: 36c12dbda81c284d72f3c64689461647497b643b
-- 
2.43.0

