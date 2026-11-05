Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871371;
	b=qiwrmug6KGtgpeksC7KTR1z7W2J/6KUefqF6IglS+GaV6f4goR84au3xZ2OtdD8NTFMu
	 H/JA75v7Atx4qdQFMrciOd3kyMjl0uYq5s1k5CEVKjeU2mYA8ucCk2dMXW1KBZCwCfxjL
	 4PjGsqYmnEWtmyjC6zcR6u8TsKkAZLcRGDKchmQ1GpEP6CNdBW7TqRMAiXtCoKnKwF+3U
	 nVedWoSUor1PrNJGqfZAW/odhKfZ0dWf6r21G/TYpWPzFdaFpYJvbDgq7h0yNWCyeBLpT
	 o0iFXrnYpSZIOZrZFaGQPaJ980zvGm6f1LQ8a5B+I//Rj61fapl4cX3Ot7CSoaHiA/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871371;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rJK6CtJbKzVMfrWCj8pyht1oOJW7B7A9lxV1fhRcwnQ=;
	b=4k/kTLtfGoXUuEkIU0XnJ12m21DeVrwlFGKz3RfJgWM1g6+R8yg2PtTPQKjBARyxyj2r
	 CwupsNKXOshr5WR2+tZPIJS+o+xZgr7KadXeBVPvrP5zODdzlRxs5sv5tCb/hBF6Q0h6r
	 od9d+WVCsQW7lvhxPHDRn2ouoI4eCsBOnNnMIXXzDfzYAPIYThO4STJVRMWCaiXyE5kck
	 ujFznH1VKImEAALXvdLIKYtwgtYfWrSI94dAR+fR76tOWzb/nk5B55509o50DSmwRjExa
	 a9fq3kYbvOT2i16XKVUu1OKgxSskwSM2LVb0ZR0LLsOL/+itDiwxvgbwQ8H+YCfFAWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Oq0MNQt6;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=lZ7fyJuk;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD9606A326;
	Thu,  5 Nov 2026 09:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9FD9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Oq0MNQt6;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=lZ7fyJuk
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59LAPF1004480;
	Thu, 5 Nov 2026 04:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=rJK6CtJbKzVMfrWC
	j8pyht1oOJW7B7A9lxV1fhRcwnQ=; b=Oq0MNQt6lv8Sc+Aa1agL4SuRPVV/sljC
	U78RtlSM0aABUSlmEdhWwkpQMTOg2C3lbbHVX+BYR+XwoGczufuLkewPEJBdo5IR
	9S8R1IMuIM6fl0N41JmwVtCA0IxH+Yub73xWzt2B/m1HisO4vTl89MsdatxehFMf
	hKArRDravRIcmpaaxmsSXG2m3Y+BVH83gEvfGGxjGkHX/BHAtJets8CkJQsS2KQB
	c0bLPIcZAQdd1kE7iSex0CxpUyrbiktp3/rGWzmvjoOC66qN669nmeznnoYRGJ62
	TsXVjBib0j0JDpkuiATtSIhxIn0OxETSxQ36fM7OAxZMeP6VykmnCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=rJK6CtJbKzVMfrWCj8pyht1oOJW
	7B7A9lxV1fhRcwnQ=; b=lZ7fyJukpjdtbNqZzdtEtN3IH/KpQyeFF9fz2gTvOUU
	f4C65X5gQ3HwDXyDj32lpgzvbQOM/RjfbtmS4WAzeoUzOTnXeHBAmVKTO1VeuYcN
	lPGzSfatyzausikvjixES6BvNcC8rucYC9EfiLrmWDn2Yk/vvcxJxm6hBPTc6VDX
	3l9HTbOdIfoD7QlO+7b3LQgs1X9PvCZFMV/rrKuNbKLzV3/FRr8Ybx//W+lhnOJu
	MK0EaP0TWEIWOfQY6LSbOXro6q7Lo8/ZwbH+hdeM5C8+m0pO1cX6HENSMyxnI0Vq
	t7eR6TmU6Uxc2YeXYLyM9avKR3PFJBIxbAUDXNKEkdg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hre3mk4w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 04:36:07 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A59a6Bc010805
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Nov 2026 04:36:06 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Nov 2026 04:36:05 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Nov 2026 04:36:05 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Nov 2026 04:36:05 -0500
Received: from HYB-0FPP35J6CsI ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A59Zr2X024428;
	Thu, 5 Nov 2026 04:35:56 -0500
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: <jic23@kernel.org>
CC: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Dragos
 Bogdan" <dragos.bogdan@analog.com>,
        Ioan Daniel <pop.ioan-daniel@analog.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] iio: adc: ad7405: Add ADuM7801/7802/7811/7812 support
Date: Thu, 5 Nov 2026 11:35:29 +0200
Message-ID: <20261105093531.7562-1-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzNyBTYWx0ZWRfX/NDhykDVJlbz
 IcobNH0+3N92uBUd5eVMDzBFJqMjFeRoK4k5i6oYEEsNcxXpiZu6XebrzKCJQQFN5N+bHDR2Dae
 Plr4h0ibMm1Dk5bYcLx3GxO7UVeiSQTLF1RqDpACbxC0cfWu0MhLZPIaXwL/iF7mwHy44Njf9oz
 xd/bocmcqATx1AB2elAD+1ddv5r1v/xeuA+16oXXawUoYHfjpI10YQCLvA8ezLdbpc9XjTrOjpm
 ccFIgqtVyAC1qb8l+dKSiK5RzoeGGUoHo3rJ0Qe43tIuxjD2+NCUt2tnGODNYbbSQJKd0RR5TBU
 H54wULKzKJbVcPtt8UPno7NqyvFgN6KjiEbFCm9I9hmoVS0EL/1xGSbyjIdacelPVpvJ+sUdWjT
 vFV/qDzcusimqFXvGIwzNsRWLuUmqTAjHUQoYzRo+qWn5MFlD0mpRkyQu4sGlKsVuBcT7zm0pgn
 pL5Dmb6KbzantweNg3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzNyBTYWx0ZWRfXxPN6+UXcM5zt
 0epw3aJU+zab2vxwnY8DibZF0ZOREqTMWaT+L4ZK+Qp6M/SR4J7hg9U+Gar7MTZ4C+fbYsT2Egv
 KhmwZJ49t7XLmbridUAd5La6c9GYdwosdjV2mfPEAtqRJe/Hq2aE
X-Proofpoint-ORIG-GUID: 6daB9YaL0QUhHLtZxwGDdC_xezm1TKJQ
X-Authority-Analysis: v=2.4 cv=BvgIUoX5 c=1 sm=1 tr=0 ts=6aec4e07 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=MlxgLFpft0MLDe3TEZUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6daB9YaL0QUhHLtZxwGDdC_xezm1TKJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050037

This series adds support for the ADuM7801, ADuM7802, ADuM7811 and
ADuM7812 isolated second-order sigma-delta modulators to the ad7405
driver.

The parts are compatible with the existing ADuM7701/7702 handling and
differ in input full scale and maximum master clock frequency:
  - ADuM7801/7811: +/-320 mV full scale
  - ADuM7802/7812: +/-64 mV full scale
  - ADuM7801/7802: master clock up to 25 MHz
  - ADuM7811/7812: master clock up to 50 MHz

Pop Ioan Daniel (2):
  dt-bindings: iio: adc: ad7405: Add ADuM7801/7802/7811/7812 support
  iio: adc: ad7405: Add support for ADuM7801/7802/7811/7812

 .../bindings/iio/adc/adi,ad7405.yaml          | 25 +++++++++++++++----
 drivers/iio/adc/Kconfig                       | 14 ++++++++---
 drivers/iio/adc/ad7405.c                      | 24 ++++++++++++++++++
 3 files changed, 55 insertions(+), 8 deletions(-)


base-commit: 20ce8ef9c9e04cd6c5ae0422e251a9b5936c6b7c
-- 
2.34.1

