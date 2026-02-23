Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E432939F;
	Mon, 23 Feb 2026 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866570; cv=none; b=VD0prWCquaCBDoAL+1bpJPSHl541BlH+VQiZdw8L7ZdjhmGaceIKmdQLeN+5gX2yUYx3Hcdzh0XZaHKxqlX2j+1KRdaGWnYFj8ujWTLjNfST61fhi5EvkCjjs39utTSaCUzr3tVo6nNgBM+2t9LMBvybMiQwlCur0Jh/FaBPxe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866570; c=relaxed/simple;
	bh=45LEM47uhhpwNJ8pBj8luNIcApHIa68GG2HYJFgMJsc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pn1pHi3XaCQKphfa7XZC9XGHfEMhQHgXxP3WxCxerIP2K/l50zlZ7rK32euR7bPdQamLdU7525fLs//UmYMfEPm/RMvuSbb9NkCsiu5XxpX+Pw3ZjQs9PoqBMx/ZDywcBuwdFzEWlzhyjoeg/yajaTJal4+rrghJqdxuPfLsJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aBGsyHFQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aBGsyHFQ"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NDe9AP1742941;
	Mon, 23 Feb 2026 12:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=BSJ4KY6w529CCltmJzuSwV8FGW0
	/H8fOc7EhU9qXYMo=; b=aBGsyHFQ9H2bunFDZyAl3wRh0vP8xRIGWnuH/cdVZ4e
	y5SKlY2xzIFXOr1r+DNot7l8t6ZlP6xK/VI+hQKYIvk/yErVNMaRwmIsemT+58a6
	Ofmnsz+U8QQK+mMacNciMACRzJgkxC8LZGItFTsxcQnNuCCKDPy7VslH1pS6ps1K
	yerF+X4fiA3/gvCvz2XA1Pyq8RsxlUpUjEmCz27elCiZdoxwudgF3dIQdWTVhx1M
	baijPugNXQO611islPKdtnCzqp+bbyEF4uBZUe4OK5QciaBIvERy0d+MvzDx8zaP
	YKQ1mJMmoaxA6J1KJBObcTowkhxFj4t9YVqaoQbkaLQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p4kux9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 12:09:11 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NH9A3r036341
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 12:09:10 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 23 Feb
 2026 12:09:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 12:09:10 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NH8sE8017789;
	Mon, 23 Feb 2026 12:08:57 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v10 0/6] Add SPI offload support to AD4030
Date: Mon, 23 Feb 2026 14:08:50 -0300
Message-ID: <cover.1771865684.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE0NiBTYWx0ZWRfX9BrZqDlLrWo8
 veEPRL6xMstM/AXJ1/lowYRHk967CzeLLUkFompKBcdMVkI2QhexUgkBIFGcih+SXtqdbvVMwuj
 XM6eLv64IFMQGOV5t6KT3ohKhvt74TeoWtsqyoQaDc9kYTrkBLT+WSKkFacGYolWutJKMxHxHj1
 9+iF9XXtVuLC1yGg1t7tPYPG7KTq/fu2K0I6X0qv6kqC6Eacr0FROVCJrDFGuRN5cw5YmN53MCN
 h+XVprnaGugBIq4TLROb+ZIbJnnx8wua3YxVft3Pz0ZR991WA+zL4H0Ue23ME5Uo3wySAlg6fTS
 yrQIdxJ3dzcQX9NbDLFgmqhKqNT8qF2fur09FC+dKYbNIuD1/4xcOqOGcQICEWGFPtbjo/XEOGV
 U1t9Dst3SpsTgn020Y7gDwF9G5JOalm/VzWdmIqZJpO6kcFrhbBROvSGbei9heQHG5lu/H3fXLT
 znml3Oha3fIDs5oLKeg==
X-Proofpoint-ORIG-GUID: NnCBX_SR8AVEQyM6Uah17uuE_D9V1rII
X-Authority-Analysis: v=2.4 cv=LfgxKzfi c=1 sm=1 tr=0 ts=699c89b7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=DtX16q9jjA3GmR8T9d8A:9
X-Proofpoint-GUID: NnCBX_SR8AVEQyM6Uah17uuE_D9V1rII
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230146

Hello,

This is v10 of high speed data capture support for AD4030/AD4630 and similar ADCs.
It also adds support for ADAQ4216 and ADAQ4224.

Rebased on top of IIO testing.

Looks like a devm_pwm_get_disabled() interface might not get accepted so I
didn't change the handling of PWM initialization on v10.

Change log v9 -> v10
[DT]
- No changes.
[IIO]
- Explained the need of PWM in commint message.
- Fixed off-by-one bug.
- Use in-loop counter declaration.
- Correctly prepared patches, dropping unsupported bindings for input gain control.
- Skipped the patches applied from previous version.
- Initialize iio_scan_type struct fields on same order they are on structure definition.

Link to v9: https://lore.kernel.org/linux-iio/cover.1771253601.git.marcelo.schmitt@analog.com/

Thanks,
Marcelo

Marcelo Schmitt (6):
  Docs: iio: ad4030: Add double PWM SPI offload doc
  dt-bindings: iio: adc: adi,ad4030: Add PWM
  iio: adc: ad4030: Add SPI offload support
  dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
  iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224
  iio: adc: ad4030: Support common-mode channels with SPI offloading

 .../bindings/iio/adc/adi,ad4030.yaml          |  62 ++
 Documentation/iio/ad4030.rst                  |  39 ++
 drivers/iio/adc/Kconfig                       |   5 +
 drivers/iio/adc/ad4030.c                      | 641 +++++++++++++++++-
 4 files changed, 726 insertions(+), 21 deletions(-)


base-commit: 0be8a2716187607daaa8ba80687a926438d88432
-- 
2.39.2

