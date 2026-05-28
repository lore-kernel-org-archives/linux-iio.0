Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1092BEC45;
	Thu, 28 May 2026 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980609; cv=none; b=BTj2tlQ6bhSziHD8agDE0F3iOpOkC07jPyxmrXkaALwLbt6PlhUEzohMLxdQdW/H/valDiKr8PGQm26qvUM1WviBDmYQyb3paRH/OjU3cBb/VOxNhJPduSjmgi9tKzgWOJHPVSCkdvMrAo4nC/Acnoxe197R/JHtjhC3l0u5zjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980609; c=relaxed/simple;
	bh=EKH5tRliOIUnhNHTa3wjt4zmAUPWdfPXtt6vsBMWZqs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X68JBS2dMfSQy0Mvcmw0x30Cth6cl7mx1brAg+YN0yq0bF5Yg/bhNdxDe2TGUPmPxr03sSemLVDHZqBH/siMHKe73TJGhP27DOIAgApSVEW/vlUmONtHan1Uv+aSCwwn1WufHCzLkJ388SvhNWFNjh8hV7TzO0iPEDGkAkupzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=G1KAUwJp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="G1KAUwJp"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SF2FZa2442503;
	Thu, 28 May 2026 11:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=/WsUyHVxwJI+qNaYsdCBDJ45zuU
	5xQSvkmFVF5cEyNU=; b=G1KAUwJpq4xTlimHhnC4E1YuTviN57sftCoGgYmsZTd
	N3p/3eFW2l2bEv1LoIdnhpSrAnuLPDUMsFLboSm212TI+LT/qNUTdaaQ3RoGdODA
	I7yTNTKBu1vJgyfi/WNDBrl5VQgPQ7+Wdug7s0MNnbbi31dnm99CzfKYM0XqLwIK
	dVTSFqeX5fEsXTlfXWs4dGnHYmenWrZbx353l0cuuiifIcAvyKxai2gJpuvw+64R
	wwUKbV97wGZzj1o2z5gnkD4W+ZcCbUsuFm1W+oZSP4IWZRu8D2fmvfUOhbaKVJ/t
	obSIuQKddPrFe79Moyz9t0G/q6peG4F4HExJJ+8WBdQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ee7x3398s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:03:11 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64SF3AHG008659
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 May 2026 11:03:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 28 May
 2026 11:03:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 28 May 2026 11:03:09 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64SF2wJN021380;
	Thu, 28 May 2026 11:03:01 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <pop.ioan-daniel@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 0/4] iio: adc: Add support for LTC2378 and similar ADCs
Date: Thu, 28 May 2026 12:02:53 -0300
Message-ID: <cover.1779976379.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: Qa0gNm1Os8o-tkl-HEVspyCm4MOtr5SN
X-Authority-Analysis: v=2.4 cv=KIlqylFo c=1 sm=1 tr=0 ts=6a18592f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=6ZiBocp07lY1XB3jTSgA:9
X-Proofpoint-ORIG-GUID: Qa0gNm1Os8o-tkl-HEVspyCm4MOtr5SN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1MiBTYWx0ZWRfX/9PddXCepJCa
 36Vghb+2dltTn7EmJhRpBS+g3/7Do2gVcyvLtbw6FK6ihJENAR1xKEnl7bcb/MJ7KH0MAT38djf
 h1dx5ExxR19gmkuHls1SfC1+SCXTHc7Q/c+x0v8UBLmqImYdnUvUMxiEpGKplZr4egg+zPA4yPv
 40tDedQh1OHSAPzfS9jhr6L/7LGortkV5JRIbVJ0q/BJtsNnu+wWu0kJpfydwpc2bnM2ClrxSE8
 6qLUmj+aMFu+IueCSauH/QohIpm752yufHNj7dTmHZqF036LnBgA6PsUPl9w39/4dq4S3pdwbNI
 wky89++MnkPLYo2/K67CFuRusPchRcUsMKN7mBwtb5Nj9gWVdCjnFJWdKvI8Qst2AKVyLb/ZG9d
 DD+MAhqH5Am/nvgrJNWeolO1cXmRMK581XQNwHG4A7cItf6qjhSNOyvX+in9w6ZxCCeEBriPxaW
 4FAZglDgELepxaCiIAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280152

This patch series adds support for LTC2378 and similar low noise, low power,
high speed, successive approximation register (SAR) ADCs. These ADCs are similar
among each other, varying mainly on the amount of precision bits, maximum sample
rate, and input configuration (either fully differential or pseudo-differential).

The initial support patch enables single-shot sample read with a GPIO connected
to the CNV pin.

The second support patch enables high-speed data captures with SPI offloading.
The setup is similar to AD4030, with a specialized PWM generator being used both
for SPI offload triggering and conversion start signaling.

The last support patch enables running buffered data captures without SPI offloading.

Some structures and variables are introduced earlier to reduce diff in latter patches.

The initial version of the LTC2378 driver was developed by Ioan-Daniel. Though,
despite of the many changes I made to the code, I've kept him as module author
to provide credit for his work.

Link to v1: https://lore.kernel.org/linux-iio/cover.1779117444.git.marcelo.schmitt1@gmail.com/

Change log v1 -> v2:
[DT]
- Use unevaluatedProperties:false with spi-peripheral-props.yaml reference/include.
- Use unique compatibles (no fallbacks).
[IIO]
- Added missing includes for LTC2378 driver.
- Added waiting time required before reading back LTC2378 conversion data.
- Fixed voltage regulator read error path.
- Properly right-aligned sample data.
- Set loop count to prevent CPU stall when calculating PWM parameters.
- Hardcode set specific offload supported amount of data element bits.
- Fixed devm_spi_offload_get() error path.
- Dropped device ID table and simplified chip specific information keeping.
- Using named device_id data initializers.
- Use bool for output code type distinction.
- Initialize init scan_type according to buffer selection.
- Added scope for IIO_DEV_ACQUIRE_DIRECT_MODE usage.
- Offload attributes now are channel based instead of device based.
- Use IIO_CHAN_SOFT_TIMESTAMP directly on right hand of assignment.
- Wrapped comments close to 80 columns.
- Organized includes.


Marcelo Schmitt (4):
  dt-bindings: iio: adc: Add ltc2378
  iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
  iio: adc: ltc2378: Enable high-speed data capture
  iio: adc: ltc2378: Enable triggered buffer data capture

 .../bindings/iio/adc/adi,ltc2378.yaml         | 118 +++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  22 +
 drivers/iio/adc/Makefile                      |   2 +
 drivers/iio/adc/ltc2378-offload-buffer.c      | 296 ++++++++++++
 drivers/iio/adc/ltc2378.c                     | 454 ++++++++++++++++++
 drivers/iio/adc/ltc2378.h                     | 113 +++++
 7 files changed, 1013 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
 create mode 100644 drivers/iio/adc/ltc2378-offload-buffer.c
 create mode 100644 drivers/iio/adc/ltc2378.c
 create mode 100644 drivers/iio/adc/ltc2378.h


base-commit: 6f15decff24dac42895c0f01f0c2143f9b8961a6
-- 
2.53.0

