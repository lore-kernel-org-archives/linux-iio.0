Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548EE33BBBD;
	Wed,  2 Sep 2026 06:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331477; cv=none; b=T/cDN7QPrZb4+oUkFQiP4yHzZGzkjcA6RGtXQ2WgZ8wJzOtrPxn+UlO+N/Ut5A1+H8dKiU6SSqhvV4r0djel+5KV9TcG6N/DnFKXP2Qjm+ZutP6ij8ZgQcOLVRNi2VD3F/3SH+4qnH8CqZjqiki3S9APTc8AfVQGt2BXBnP1fiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331477; c=relaxed/simple;
	bh=cXolkngAlWA1H5nPJEKaMNEiVtfZgdQLV/1KaTMlrAU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tiIisljz5T+WKwjmkmpFh4+u9MueGI1vnU619nz93GLwRaEDrtOXiWxGyLThIouBymBM+XAYC4O4mXS73pfU0+av89rI9MpQ7cwtUnogpYwxEvhfpGGRD8jmsZG37zSiQK97kOPYeUCKSSwioT+M3VpVR8snwwduFgEIrEtE8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HImL+tM7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HImL+tM7"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826Vk7T2268882;
	Wed, 2 Sep 2026 02:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=sYcpR6R0R4hCFT4gFFgAc7OTQbc
	DMbyd/9wtJ3iBmP8=; b=HImL+tM7t44ygXD1fOiYy794UxvRDYhCh1nqxDj51Q3
	4kVArKfguZFFUgefMjKv6C+TFhYy6yd4t11kakD9C77oml5ldB9XntixMUtZmSf1
	Zgih3cHumHACy1RN5tNLdEUxasx7l3nMIsENjHHRfmDpTl3zZSIQJIjEIPUDuGeQ
	UBx/17XdzIIjNyoPLWZmot0ZihMROfyS9dEwwv+cSThfukpXCFSP2aQRQjKO1j/a
	6Xnu/pEbWn0GflEqEYVXOReHxBLApxeR2uqOYybIC7aYZ1vysgCXjDxzrGbQ2ByX
	zAOp4SfOnatGZuyorXEiew3a8RcU3/B7l9aM/ZFeq/A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ge0yqkpbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 02:44:31 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6826iUYC061173
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 02:44:30 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 2 Sep
 2026 02:44:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 02:44:30 -0400
Received: from HYB-li3PrmDPxTz.ad.analog.com (HYB-li3PrmDPxTz.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6826iJ60018111;
	Wed, 2 Sep 2026 02:44:21 -0400
From: Andrei Stancovici <andrei.stancovici@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Andrei Stancovici <andrei.stancovici@analog.com>
Subject: [PATCH v3 0/3] iio: adc: add LTC2499 features support
Date: Wed, 2 Sep 2026 09:44:09 +0300
Message-ID: <20260902064415.132588-1-andrei.stancovici@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: uaOKYRChA6M4Pd7dt7Ft7wyCujvPjkAc
X-Authority-Analysis: v=2.4 cv=S93pBosP c=1 sm=1 tr=0 ts=6a97c5cf cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=lkSsTaoaHbc0cFvKRegA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA1OSBTYWx0ZWRfX0RRygDPxYeHd
 tOSvl2ar2nwPnCs4OT7QyEh3BjDhoXYPOzEhjrbtkbRyGmw4JRKqPELN+vfy77caO666TQb+J0L
 ZHQBRNR5+6NNcDT0YCw19nXe4OmatD0Vm04BtG7rij4i9Of1/cYlfIX5TlGiWJCee7fzBUzvx+X
 BP3RBPOvSYOm0JalW3YERAAHkdrv0FMPsYN21jpyR/SaT5S3M7fa2s05G6Nb/4Ur7QgDGmb72jQ
 VNtVFobp8x0YRRJzcMx0IoKHAcUHR76DbNfKcinAk39XTUEUVKEPHYLtzbiNMe5/JqcrvCggkEU
 MJClT0uFJtys/YI5CWNvRl8/guHcUz0R5wjQVksEbUKXFSuvGqrQjfiuLAX9kRfixqBoSfqodm0
 ZsuIzuScyZXjHMiazQgIv8n/u8ziSxDkDigBeGnL9oCo2dHrbsifnwHRIxSdEOn4VCgy7ozcD80
 oEyZOtSyyy5WU+UL8FA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA1OSBTYWx0ZWRfX/8TG/ludmLDz
 EcxE3sSwK7PwOmgnolZeNjDFaq6dKKwEiuU0EQiBq3coqWNSdozgAWuAZxxUQ9PlR8WnSicCZcm
 fPJLAGB/uympuIipUB9izTfpqSDvbHgePmPQebhPOmwlvMdWwIN4
X-Proofpoint-ORIG-GUID: uaOKYRChA6M4Pd7dt7Ft7wyCujvPjkAc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020059

This series adds LTC2499 support on top of the existing LTC2497 driver.

It includes:
- a small binding title correction for LTC2499,
- the LTC2499 internal temperature channel,
- the LTC2499 2x conversion speed mode exposed via sampling_frequency.

Validation performed on Raspberry Pi 4 with a DC1012A-A board:
- temperature raw/scale/offset read correctly,
- voltage channels remain sane after temperature reads,
- sampling_frequency 1x/2x switching works,
- pyadi-iio LTC2499 validation passed,
- hardware-in-the-loop M2K validation passed.

Changes in v2:
- guard against regulator_get_voltage() returning 0 in the temperature offset path,
- replace LTC2499 two-byte stack command buffers with a DMA-safe buffer,
- use ABSOLUTE_ZERO_MILLICELSIUS and standard SI unit multipliers,
- make channel-count handling explicit,
- clean up includes and iterator usage,
- update conversion-state handling for interrupted waits,
- clarify conversion-time rounding and LTC2499 configuration behavior.

Changes in v3:
- revert the LTC2499 two-byte command path to a local stack buffer and remove the incorrect DMA-safe rationale
- use a standard zero-value comparison in the temperature offset path
- simplify the temperature offset derivation comments
- simplify the temperature offset computation
- adjust ltc2497_chip_info field placement based on pahole analysis
- apply review-driven comment and formatting cleanups

Andrei Stancovici (3):
  dt-bindings: iio: adc: lltc,ltc2497: add LTC2499 to title
  iio: adc: ltc2497: add LTC2499 internal temperature channel
  iio: adc: ltc2497: add 2x conversion speed mode

 .../bindings/iio/adc/lltc,ltc2497.yaml        |   2 +-
 drivers/iio/adc/ltc2497-core.c                | 235 +++++++++++++++++-
 drivers/iio/adc/ltc2497.c                     |  39 +++
 drivers/iio/adc/ltc2497.h                     |  46 +++-
 4 files changed, 309 insertions(+), 13 deletions(-)

-- 
2.43.0

