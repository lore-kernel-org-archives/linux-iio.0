Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1C3264D9;
	Tue, 24 Mar 2026 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336475; cv=none; b=jtaen1dyZYgvlK1aF6X13MSwTFtN3/DhtWkQEsdtTxOpAx4kV6xGJ0eWJnISd0ypcLiqWHqb1SFsbprurCXiOPdDe/fc2tVDcJo5ZFoZoGzBwc/WKb/CGump0M47f3s4d8eDhFGGvp6W1EWzD6IuGg5siV7pktIzARXhWnWFe7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336475; c=relaxed/simple;
	bh=bs9igt7QnRCfi3tNaWUo+QmiS8fZ9TbwBeMVconoKwU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y2CfhPFqKUPXe70AD6JLgRoN1XcRkKUY6COD/4HXGmeKNm+7A0dvCmN4NqH4+gFkY17PjCOuDWNQQlY6QFE9JVLOJwn0ntvs+itsd0wB3xCZJcZKAa7jhImzREswTt8gxTHPnLI2qQnj5jLnf1UnCWxamvEsNctOk+BTE4h+tfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sRhzucIw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sRhzucIw"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O411pr2961633;
	Tue, 24 Mar 2026 03:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=+sl3PiRipwsGINx83TTd88wQxhb
	ZVt0kR+Q83e5WkSA=; b=sRhzucIw/vbzU2d9S/UhmR2zoQzpO16wwUcwMCRuVxM
	gkPhlJEYlVB3KKYDP+4/2rT8EzYcUeGDFDXSY41HCJoQVtl2VGvf7ktTVHBVVJxN
	fPAlXKpL7qqMj2soo98t33czYOqL/AtvPcPFMd0ftZrdz055wI9mp4Jxlzd1JSmG
	6BgLfAmpEI9FgBcoa43+o0dY1A1ocMnj5nAc3ra1vIlPJ8OF0dLyjs7D8Rhp1w0M
	2AHXcYZjMZZrMoNWJXpiD8IF7D4qC2HoFBqEGMZJzf0oWu7lpdRVx8awifRfy4A3
	gHUDq3MBKnEA/DTBc8bpwHeVYh2v+UZXBx7HK2mJODw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d1r822nea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 03:14:02 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62O7E1Zr020225
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Mar 2026 03:14:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 24 Mar
 2026 03:14:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 24 Mar 2026 03:14:01 -0400
Received: from CJONES7-T01.ad.analog.com (HYB-jCCu8MOWEgi.ad.analog.com [10.116.223.230] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62O7Dg0b003654;
	Tue, 24 Mar 2026 03:13:45 -0400
From: Carlos Jones Jr <carlosjr.jones@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Beguin
	<liambeguin@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Jorge Marques <jorge.marques@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] Add support for LTC2305
Date: Tue, 24 Mar 2026 15:13:27 +0800
Message-ID: <20260324071331.842-1-carlosjr.jones@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA1NyBTYWx0ZWRfX+YzO/GMqt2CP
 tMTTIK44NKtHB0RBULDx2Y8AAOwuyilWe6w7Es6z72a5AUro1i447qTBaGMNPAWcVDBYIsW7Rcm
 lqbXP89GrH3UfDvIsjaKQIx9o9jcIqZlRfhU57Jsuzvyk375G6CxRUyGgN7FkGyh2x3Yf07lsP6
 v5Q3qpLIoOzzGJf5v94M159au6M2cKVvpzEzr8gjUfPxkEFvBYL86h9B99fXX7B4sV5R45n0PxP
 8uRzhDoysIjLp2+Y8rAsoIU6LWkxVbdEZA93b6Hj/Zix4bo1v9ZSi8dyLKJw7A/RjdUz587x3TT
 69wdTl9OcDz0tWG3H6+aC5z6RVvdv8cFdd56FloXqJllSsdreD4i+no+W9KrzBjbWG6A54hdNOQ
 CLdyP+tJF3EJIobKe8KPmN2RpZGJrFDHzW6SNhelKMLrbphhh70oAYXiQKySeTdVxGfCepOP3xP
 1jJBAaScYx+SfYR6w/w==
X-Authority-Analysis: v=2.4 cv=edIwvrEH c=1 sm=1 tr=0 ts=69c239ba cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=bnWB3NjIizojX1aHmW8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -khZwBqQp4_JLI1EnviBjP1Q_hPuU7r0
X-Proofpoint-GUID: -khZwBqQp4_JLI1EnviBjP1Q_hPuU7r0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240057

The LTC2305 is a 2-channel, 12-bit, fast ADC with an I2C interface,
compatible with the LTC2309 (which has 8 channels).

This patch adds support for the LTC2305 by introducing a chip_info
structure to handle the different channel configurations between the two
variants. The LTC2305 exposes 2 single-ended channels and 2 differential
combinations.

Also updates the device tree bindings to include the lltc,ltc2305
compatible string and documents it in the Kconfig.
---
Changes in v2:
- Changed usleep_range() to fsleep()
- Added missing #include <linux/array_size.h> header
- Removed explicit .read_delay_us = 0 initialization (implicit zero)
- Added __counted_by_ptr() annotation to channels pointer
- Modified ltc2309 struct to store only read_delay_us value instead
  of full chip_info pointer, reducing memory overhead
- Alphabetically ordered device entries in ID tables (ltc2305
  before ltc2309)
- Reformatted Kconfig help text with explicit bulleted list of
  supported devices instead of vague "and similar" language
- Added device names to chip_info structure for proper sysfs
  identification
- Split changes into proper preparatory patches before adding
  new device support
- Link to v1: https://lore.kernel.org/all/20260320140819.191700-1-carlosjr.jones@analog.com/

Note:
The ltc2309_chip_info structure has a 4-byte hole due to alignment
requirements for the __counted_by_ptr() annotation. The count field
must precede the pointer field for the bounds checking to work correctly.
The total structure size remains 32 bytes either way due to required
padding, so the memory overhead is minimal (8 bytes total for both chip
variants).
---
Carlos Jones Jr (4):
  iio: adc: ltc2309: Introduce chip_info structure
  iio: adc: ltc2309: Use i2c_get_match_data() helper
  dt-bindings: iio: adc: ltc2497: Add LTC2305 compatible
  iio: adc: ltc2309: Add LTC2305 support

 .../bindings/iio/adc/lltc,ltc2497.yaml        |  9 ++-
 drivers/iio/adc/Kconfig                       |  8 ++-
 drivers/iio/adc/ltc2309.c                     | 59 ++++++++++++++++---
 3 files changed, 65 insertions(+), 11 deletions(-)

-- 
2.43.0

