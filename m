Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2E31AF2D;
	Tue, 31 Mar 2026 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920330; cv=none; b=i4TjH2Dz0mBta/h9eyLA7PTNC8i5ERlMguRS8LraV7DSobfW737PHlWcTGWweBzklGw6u+q4QSFfRE8IM7jZ71uCx9B4lalVdUHbxVl9ebzsz3CBddt+fgjdF3rcR5e1JvGL5h3jyscv3YT8LxPV9o8ET3S5JI9z1E3PDkWs0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920330; c=relaxed/simple;
	bh=pXrhe5ajjWq+uRfdIAQX481ZzDXZWP/RuGucxLkrWjY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JJpCD8ZloLgZ2jU6qwSEduozSCx0vRbGeDMTeERBNnNg/miEuFLcIHhJkx/cVf6pO/r9yAI+wexg/E3en/KCsGk+FVmrh9gckaNMWRdASxsIOwvR+8la2oUv1nL1HseBFS69on3fg74wO3EyUo+4IsOSbjwkbjwjdg+Gnv4cNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xBfTcdmL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xBfTcdmL"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V04L8E1140846;
	Mon, 30 Mar 2026 21:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=tn4gk6nvzIpItcVWmZg7FP3TvTJ
	ixOQZFbJ+W4Ugsmk=; b=xBfTcdmLRc6BjEursQNfIPm78YMPPTGz9HPihXyTjAF
	p4yts6aY6fapzd+ssaKX23C14Tq8zVZJ4Cw7oZZApNqs7ngZ1RUD6cwZW8ZOa6n7
	l1wK9+xvo8kNsFVNNJhmEefYUxpvQmHpnulVL5MZWIhWUDrbx/am96mfBpLT1+Zq
	PMWmP/Y0r1JoyhPEz9/VWHY0C9vYjwBwozsdgJtg9AnrL+VxuuxYv3kHtb5oH7PE
	wUo4G5r4ShfcvY8KFkOA9mZIMjU11t1mudJth2Bsdzk1TIyV0F9JbPq2HkJAP6nK
	ZolBa41AzRx9JwOJJamoioMyPJnm7Ge/d/0evV8oXGw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d6wab7ese-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 21:25:24 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62V1PNqP061152
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 21:25:23 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 30 Mar
 2026 21:25:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 21:25:23 -0400
Received: from CJONES7-T01.ad.analog.com (CJONES7-T01.ad.analog.com [10.116.223.230])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62V1P8RS006886;
	Mon, 30 Mar 2026 21:25:13 -0400
From: Carlos Jones Jr <carlosjr.jones@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Beguin <liambeguin@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] iio: adc: ltc2309: Add LTC2305 read delay and optimize chip_info
Date: Tue, 31 Mar 2026 09:24:55 +0800
Message-ID: <20260331012457.9324-1-carlosjr.jones@analog.com>
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
X-Proofpoint-ORIG-GUID: rxtCbZPjioYoo_NiHkDgR-c6SkkDXuKo
X-Authority-Analysis: v=2.4 cv=YJmSCBGx c=1 sm=1 tr=0 ts=69cb2284 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=gJ0TSQIuG7uaeSNGKR4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rxtCbZPjioYoo_NiHkDgR-c6SkkDXuKo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAxMSBTYWx0ZWRfXwU6ZJ8Rf5CUi
 jrN7ycZs4AyVi/y5boZhQqSU1wTtXKnRnoyl+K7l7/OeWBvVPYJDcD2QFelETspHjSZQInpuYuE
 ki9ETBANYNEoPS/w63YvxcKjdzIzF2ZKp6B2Y97BxfGHefxvVwj/WS9Rb73vfl81Adteh2s7FN1
 9xKK9w3no+iIMizDOzAiGwulCPrbOcOlzCFVa3XW3Jm2B2DRkxR7kT302itdMYvYlot+uI8IK6E
 WS+VLHIYIrpugX6yxMlMjJcRaYfZUZADbF5Mfh+nDb6U+T9ahAV2ff0EhWxy87c3LAloORelXha
 z1tTVQiD+zDPi60b6vONX0TE4tPMrqLdDhSVDh9c8JW8kkmol40Ixz5eB0tpL/tpzEAtYsK+uWU
 fPUYYFmK54nfPcBW6TvyCcvQDVkZkz6WkWmf3Fic24M3Gs0Vk8IoGHcpHkSgbuxumZQmJtNnMwf
 H2kXuZPO8VX1od3p+Ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310011

This series adds missing read delay support for the LTC2305 and optimizes
the chip_info structure for better memory safety and efficiency.

The LTC2305 requires a 1.6μs delay between I2C channel selection and
data read operations - a timing requirement identified by the hardware
designer that wasn't captured in the initial LTC2305 support
(commit 8625d418d24b ("iio: adc: ltc2309: add support for ltc2305")).

Additionally, the chip_info structure is enhanced with __counted_by_ptr()
annotation for improved bounds checking and reorganized to minimize
padding.

Changes in v2:
- Split into two logical patches as suggested by Andy Shevchenko:
  * Patch 1: Read delay functionality
  * Patch 2: Structure optimization
- No code changes from v1, only reorganization

Link to v1:
https://lore.kernel.org/linux-iio/20260327034159.15545-1-carlosjr.jones@analog.com/

Carlos Jones Jr (2):
  iio: adc: ltc2309: add read delay for ltc2305
  iio: adc: ltc2309: Optimize chip_info structure layout

 drivers/iio/adc/ltc2309.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

-- 
2.43.0

