Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1231327A;
	Fri, 20 Mar 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015762; cv=none; b=Vgwehvag+nRlUtfvMKGp0/YajGxCg8Tikj/FBgnZgvgWIS3e+rXWYrWYhdNdC8ysnir6MLQy5GwpWksMdL2Uhw/+kY91CubuTO8GprO/YC+dI89EK/Li/AP+is5uWeauHtB1wM+/8myn4TRa7eRZPJ+mBLsxfVYmZt7dj8QdOK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015762; c=relaxed/simple;
	bh=exl5CoshFuYp5IHYNswbkmiiarT2hONEf0lIyLtcSYc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AspIpRvkSJbArl/EgNzK2GuxO6+ArJCowOy9lULh7NICmgQMIoOd6/bC5fiZ/hbN2eSQ87qL1Z/8UTzpGjj5ch7FUeMwgHgAVFLqJUC9FzpzcSmvoERHa200a1bnsRgHICfiWd9Mj/WiVr4CkJ8FxfsK9dNCPYxCImnHwPyQhYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vU36Wj79; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vU36Wj79"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K7nNGa4040894;
	Fri, 20 Mar 2026 10:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=x8pMKx/ibAHlc092QlyIJ06JAEh
	x1/RO2CNJ067Iu5E=; b=vU36Wj79a7BWlr2GxGyX2gUR7M3w0j75AmC1zocDSWr
	fWmVQ9cL2gbw1uoM+dzJRi7xVU3aGqjM/Xygx0acxNmc9a9rW+bEvn19hM3PJ24d
	3xg+GZFnAXP8Qw8lB9MbKx6vaosk4C5Xfmx63iQvIkHgvES9k6TvPEahUJ3kbVIi
	lJetjMIDJRZFLtV83p9SsJ96AZVBf3REMsI87aV9lQpFKYistSIB2+gr43KZy9fV
	2YExyGklQ7McADJ/jgzLd2yohyiieDhjmeV4XcMWDAl1qX1wzstTxuwfuJdgJQZd
	CtdaD3hgS05agQ2rw3s0oPybc7vo5VgqO6ptonLm1XQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cyjet4rnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 10:08:50 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62KE8niJ055448
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Mar 2026 10:08:49 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 20 Mar 2026 10:08:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 20 Mar 2026 10:08:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Mar 2026 10:08:49 -0400
Received: from CJONES7-T01.ad.analog.com (CJONES7-T01.ad.analog.com [10.116.223.230])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62KE8V9J014859;
	Fri, 20 Mar 2026 10:08:33 -0400
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
        "Andy Shevchenko" <andy@kernel.org>,
        Tobias Sperling
	<tobias.sperling@softing.com>,
        Jorge Marques <jorge.marques@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add support for LTC2305
Date: Fri, 20 Mar 2026 22:08:16 +0800
Message-ID: <20260320140819.191700-1-carlosjr.jones@analog.com>
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
X-Authority-Analysis: v=2.4 cv=SpWdKfO0 c=1 sm=1 tr=0 ts=69bd54f2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=NTfBsKdksxzgad0j2OgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QtT8RzuoUUOgvW-CzahsaJtVnn77AHmK
X-Proofpoint-ORIG-GUID: QtT8RzuoUUOgvW-CzahsaJtVnn77AHmK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDExMiBTYWx0ZWRfXw5dSOGXLMCOw
 y2aMJLvx3cXLlvXEyE5MtYl/6SitIR6TusmyezkbiZKqd4TFAecnLToKcw0vo8aqa+kOJAsdhnj
 TCikTiGvaPNqgTnWg6XwCnbaJZkxCg3fNfDBIqzGtqahofwB0onvyw2NAKbThFeEWNdL5YTKuha
 Flv6dXzBpi2/RYBXK4hJlt9G//9Gm9THsS4FSu7ygZ6bBRCd/dcHFZ+dJZg+GSb92i6MqzHtQoI
 Yh+YToEKnUoTCgzAnHGlCAJUKPEcaPxRQTo3cxHLZlsUw5ujbnk6wGRHvfxTDIAwRvUo3FU48uH
 pNaMpA5fr3t9v7R6cXtNDOAnDPvMa057PvsFnox27RshpjnK2kOk0l/4grpvHbJmDWgRAqCst3H
 rYy+Zw99WbkLvjD10OgA4Bd4T25VPB/r99vF0b8P0xrYkr/QCJ0WYqZfhv0CBwN/fKHtzHlMt9q
 rz/soGJpISNqy5tMiiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200112

The LTC2305 is a 2-channel, 12-bit, fast ADC with an I2C interface,
compatible with the LTC2309 (which has 8 channels).

This patch adds support for the LTC2305 by introducing a chip_info
structure to handle the different channel configurations between the two
variants. The LTC2305 exposes 2 single-ended channels and 2 differential
combinations.

Also updates the device tree bindings to include the lltc,ltc2305
compatible string and documents it in the Kconfig.

Carlos Jones Jr (3):
  iio: adc: ltc2309: introduce chip_info structure
  dt-bindings: iio: adc: lltc,ltc2497: add LTC2305 support
  iio: adc: ltc2309: add support for LTC2305

 .../bindings/iio/adc/lltc,ltc2497.yaml        |  9 +++-
 drivers/iio/adc/Kconfig                       |  6 +--
 drivers/iio/adc/ltc2309.c                     | 45 ++++++++++++++++---
 3 files changed, 51 insertions(+), 9 deletions(-)


base-commit: ff0843ceb1fb11a6b73e0e77b932ef7967aecd4b
-- 
2.43.0

