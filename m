Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B20C1C84DE;
	Fri,  6 Feb 2026 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404441; cv=none; b=s9hERFLXjMDU9rOKC1cOrsNjzq8gjF6fo4cqYJlOYIxCPqv/USzeCHzfZki79QGTzD7ZVYDeDZgeYrGasFjsgruBs7qWPWmrzMRrz4OuACHUh5F2QX9xm9hqOHAjSowA9+PQlw846ZrWOHtS7hNsZqJC2LS1U2iP6mOOvMy/jZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404441; c=relaxed/simple;
	bh=9wCD96SHgLLD/YzrdOcB/tsNxEKvbBj0SpOvCUXpaVk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uyTBSmv5LaaYuYkseCqDiAtWnquI9HmeJEyOoRKs0zwQnCte22w4nFbRgwgr7ziEAhyZX8S7WGuELO5ez5dzadzcy/rXWAvJ8RtBN63EBf6MwlLwqbUoTf48TLl+rF9dUzKIXgw1wJEfQOmFGIHKvBwDiG1580n20TJWuMrpalw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=m5ca4Y1A; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="m5ca4Y1A"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616GLO6U1622541;
	Fri, 6 Feb 2026 14:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=dlvGWa/+xyUqnuYFBCfIbhe+pfK
	uD3eaO5yJaPfTuLI=; b=m5ca4Y1AL8FaJgeQflK1unO49GDuwckW5z8MCslBxpr
	jgS1Ca5kDBfXjQGI9MrsAtDb9h+QrbfO8bgZ53/7EFWsBnZqWesjZ0jDWiRDSiCG
	uhEjLDUvPFAI39AL1095ahyThFyXCh04lFYoGQQBSyl9CjaB0xdiNj/97/BCRQVy
	Tsvec3cO9WloYZjhLCfJc9A7nIFGhVDIPA8jUOr6TnZo6H1qknJALky1wcVyZsKl
	gXCE5tJoYOn/XhDVIFJR7x+DdoFtwUN+95XCoNkUhD09tFZSB2fxSnGnSNW3Nxim
	K0oXkJWc+/86/j8tujvcm3L/iv91aflbLS0LgXf/C9Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c5e32hr5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 14:00:20 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616J0Jvc012567
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 14:00:19 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 14:00:19 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 14:00:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 14:00:18 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616J03d9008149;
	Fri, 6 Feb 2026 14:00:05 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v8 0/8] Add SPI offload support to AD4030
Date: Fri, 6 Feb 2026 15:59:58 -0300
Message-ID: <cover.1770403407.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jKVNXRPE3EhseNjCiXtZ26M1s0-sHBN7
X-Proofpoint-ORIG-GUID: jKVNXRPE3EhseNjCiXtZ26M1s0-sHBN7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDE0MCBTYWx0ZWRfXyfOTOpUqJs0T
 QWlb/Iobe56hWKkfrPweZp5WXxMaOZg7wj8ISw+1JaZnFo7d7EA9xhu7ZAX79z0KEljesU7w53V
 RxsVi08Fewql+Q9e6XTASS1qVnz8jU7gdcfKwX0q5g2B8EQesAnY2j6w18naLimgmS4bMr6w6RQ
 4mDU/Rc7DZGpAwyFeT3DIFHY1LPudMjQ0enbFvSrgnPUgItjqMYDNoahW2nqeFVqWaAznR/wPGE
 mXX8TZBNFvUgXYt5IIX4zMgYxBbKUGDzpg82TO9LCgcM0Wigx+otSDpyQqI0lZMWm7oHvE4Gnax
 UdP76zGT48pAUrMT5KZS6wPDeK+B87Z5a+2zk6M14QDQPNNtlzyEBzc5qVSORrjnKznel0hwiLK
 wQDtnqnl4yjbrTWh+dhVgxGMRAR3DDtFUrtk8EZOJhOJq5zXzp8qBCikNYDZDpXW5JJfWb6473h
 Hr2IjyHxSP0g8Ls/SCA==
X-Authority-Analysis: v=2.4 cv=NPzYOk6g c=1 sm=1 tr=0 ts=69863a44 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=1HhA5s3FUf2A7XxGbvcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060140

This set adds high speed data capture with AD4030/AD4630 and similar ADCs. It
also adds support for ADAQ4216 and ADAQ4224.

Change log v7 -> v8
Rebased on top of spi-multi-lane change set [1].
Requires ("units: Add HZ_PER_GHZ") patch to build [2].
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-multi-lane
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/units.h?h=next-20260204&id=5083dba0fde5446c00ee1a82a3911c8f88a2c72e
[DT]
- Fixed issues reported by dt_binding_check.
[IIO]
- Added comment in the list of available average modes to prevent regrouping in the future.
- Minor tidy up for macro consistency and fewer blank lines.
- Reuse dev pointer in probe().
- Refactor to check -ENODEV only once.
- Grouped includes for features from IIO subsystem.
- Downgraded offload_period_ns type and use DIV_ROUND_UP() instead of DIV_ROUND_UP_ULL().
- Use HZ_PER_GHZ.

Link to v7: https://lore.kernel.org/linux-iio/cover.1770309522.git.marcelo.schmitt@analog.com/T/#mc0285fb4750e57582f96584dd98d90163521c7b8

Thanks,
Marcelo

Marcelo Schmitt (8):
  dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
  Docs: iio: ad4030: Add double PWM SPI offload doc
  dt-bindings: iio: adc: adi,ad4030: Add PWM
  iio: adc: ad4030: Use BIT macro to improve code readability
  iio: adc: ad4030: Add SPI offload support
  dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
  iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224
  iio: adc: ad4030: Support common-mode channels with SPI offloading

 .../bindings/iio/adc/adi,ad4030.yaml          |  64 ++
 Documentation/iio/ad4030.rst                  |  39 ++
 drivers/iio/adc/Kconfig                       |   5 +
 drivers/iio/adc/ad4030.c                      | 642 +++++++++++++++++-
 4 files changed, 727 insertions(+), 23 deletions(-)


base-commit: 0ec5ed7c95d1ba6a74491928ff38abb351dbed36
prerequisite-patch-id: f3b2f63f86731322c9b10e1bae0952a12219258a
-- 
2.39.2

