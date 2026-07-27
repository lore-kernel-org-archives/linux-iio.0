Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F39038657E;
	Mon, 27 Jul 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187847; cv=none; b=q8h2j7pb0qzKRdBjYsHmcHCU0RgZ6vrTdVZsIn2axUYss/eecjg4aI6e2KEXYaXcXe+k0CL0162C2Vh0DqaYsZOclKyYBANdaofxiefRGO0mZGlgAS4NWBAqywZ9s346ZKwipgRhbqYtdDfo9Lc9Fcw2+89OnFdMAigzd91Y5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187847; c=relaxed/simple;
	bh=9dzThW/bFUK9Xiw/J5HfnU82Da2SnA6OQGbPj9AY7GQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ekXa8YHLmtPXXpKEeB9PazHoQPLOZlPX/ftRjwt06SQHdXeW9Y0qtsAZ+Z7Cs4y1SiKm1CDb58WMi90FiwgJLR+exYyuz1WH8qmyoWzyun2IlD3Q4DO0SO2gX7cLoP9OohW7Xpi/mxGkZR6EXNZ0JVvZLQJTY/BlF9VlS1lmp6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VCxa2foX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VCxa2foX"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RIH8Sx1173023;
	Mon, 27 Jul 2026 17:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=vxFl+0Oqkzq5W0oKIKKNf53dKXm
	4gKX0KDFAj6vN4pA=; b=VCxa2foXW85tRoNwxkW+zLkYjd6hcDS/gE85TKBSAn2
	Gtn8jdJ8kOhxRiitwT3gYrSo4jKNlgO2mzTecVnTfMDmLf3ehOJ9M0fadJ12AxBM
	9kI2T8c8GVnUj4WUL9YERJFJLMNdFGUVEElvgfhcfBJby6dHyO1z+TgqOSkCSGe+
	PHz5KTnoZ3pHFMYvdaigXvy1C6xSM3TWzhR6YBCfNOweB6B06Q6v2JTUXnbDDj4K
	f1chhWN4vwynoCu6XOYgOVziH36rCfT+Eh3fzO1mYDEHHWqMhTuQwBhddvnzmLTV
	A1QrVtkV/pEXsYcJjBCN2Rz1Dnjlg4sASYu69/R2gBQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fnefgf0uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:30:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66RLUSq1003857
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jul 2026 17:30:28 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 27 Jul 2026 17:30:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 27 Jul 2026 17:30:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 27 Jul 2026 17:30:28 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66RLUHgT017443;
	Mon, 27 Jul 2026 17:30:19 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v9 0/6] iio: adc: Add support for LTC2378 and similar ADCs
Date: Mon, 27 Jul 2026 18:30:11 -0300
Message-ID: <cover.1785186980.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: RRM0kJKf3IPiN9zAuvaB0SALAS27wBXT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE5MyBTYWx0ZWRfXwDPZi3B4oZP1
 6cTkjz9DvNgTScfcxe3l95huHBd9jCFqf82l6t4UiU9kvwiKgv7uZ+ErorTIf9Q6HJ1wTm6YFYg
 a/+18DtTxXq3lbfpYrvpkGY6GYb1u/hFNNZ4XjkjsPzMEgs7uvXn
X-Proofpoint-ORIG-GUID: RRM0kJKf3IPiN9zAuvaB0SALAS27wBXT
X-Authority-Analysis: v=2.4 cv=Q8fiJY2a c=1 sm=1 tr=0 ts=6a67cdf5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=XqN69BuZ7wOcV2cAv7kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE5MyBTYWx0ZWRfX2IxEVXYXG9wi
 nLOt+UnTaagAIjT4tlNLRct9buiT1oi7lKUELiH6QEy2SXlZ486w3O9qQiBUDh1SbizjISVyqEj
 oqY6ij4lCcD2BhNXu44PbEp9x1QwQbk/TBNJvQjELXWXHdR/UXFit4uvESqvFFCF0TP2HrU9dhq
 cW1c5FoJULndmqxCE6TpcK7BtuwD1K10q69/BNZV59KVDqtDT3K+ozrQMZYZzVFx6lvlKOYea5H
 Y/hyJcUd/vzoV7rtoTyF0E9bLLfuRI9Dz9tBcuQcVDDIrAr7th+ZtT4h6bYXKuruAhsCHyPZEGN
 oVmPZmvWs/w/hSKnx+wa7mAM9u8aROrRqg6o+wAz0cz6+mAqgJwk1Tutu/r+/Cfwj23Uyq+lVeK
 ZKCBVSEpz0WclP566qq+TM4EZ+5cvq3WaER2ObfFmhP3h3aDnrIvsYlMNySgigj9N1sQvjAov1/
 X+nN5esiJHgnKbc/i+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270193

This patch series adds support for LTC2378 and similar low noise, low power,
high speed, successive approximation register (SAR) ADCs. These ADCs are similar
among each other, varying mainly on the amount of precision bits, maximum sample
rate, and input configuration (either fully differential or pseudo-differential).

Patch 1 adds device tree documentation for LTC2378.

Patch 2 enables single-shot sample read with a GPIO connected to the LTC2378 CNV pin.

Patch 3 enables high-speed data captures with SPI offloading.
The setup is similar to AD4030, with a specialized PWM generator being used both
for SPI offload triggering and conversion start signaling.

Patch 4 enables running buffered data captures without SPI offloading.

Patch 5 adds support for LTC2338-18.

Patch 6 recommends using voltageY-voltageZ ABI for differential parts.

Even though these parts are somewhat similar to AD4000, the wiring configuration
for LTC parts is different as well as the available HDL for high speed sample
rate mode. Because of that, I propose creating a new device driver for
supporting LTC2378-like devices.

Specifications can be found at:
https://www.analog.com/media/en/technical-documentation/data-sheets/233818fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236416fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236418f.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236716fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236718f.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236816f.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236818f.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236918fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237016fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237616fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237618fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237620fb.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237716fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237718fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237720fb.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237816fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237818fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237820fb.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237918fb.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/238016fb.pdf

Previous submissions:
  v8: https://lore.kernel.org/linux-iio/cover.1784835663.git.marcelo.schmitt@analog.com/
  v7: https://lore.kernel.org/linux-iio/cover.1784235595.git.marcelo.schmitt@analog.com/
  v6: https://lore.kernel.org/linux-iio/cover.1783629101.git.marcelo.schmitt@analog.com/
  v5: https://lore.kernel.org/linux-iio/cover.1783028033.git.marcelo.schmitt@analog.com/
  v4: https://lore.kernel.org/linux-iio/cover.1782397418.git.marcelo.schmitt@analog.com/
  v3: https://lore.kernel.org/linux-iio/cover.1781661028.git.marcelo.schmitt@analog.com/
  v2: https://lore.kernel.org/linux-iio/cover.1779976379.git.marcelo.schmitt@analog.com/
  v1: https://lore.kernel.org/linux-iio/cover.1779117444.git.marcelo.schmitt1@gmail.com/

Change log v8 -> v9:
[DT]
No changes in device tree doc.
[IIO]
- Took LTC2338-18 input attenuation effect into account for _scale calculation.
- Split LTC2338-18 into a separate new patch.

With best regards,
Marcelo


Marcelo Schmitt (6):
  dt-bindings: iio: adc: Add ltc2378
  iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
  iio: adc: ltc2378: Enable high-speed data capture
  iio: adc: ltc2378: Enable triggered buffer data capture
  iio: adc: ltc2378: Add support for LTC2338-18
  iio: ABI: Encourage differential voltage ABI usage

 Documentation/ABI/testing/sysfs-bus-iio       |   9 +-
 .../bindings/iio/adc/adi,ltc2378.yaml         | 170 ++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  19 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ltc2378.c                     | 856 ++++++++++++++++++
 6 files changed, 1059 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
 create mode 100644 drivers/iio/adc/ltc2378.c


base-commit: aa58ecc73466d0cb8c418de98e2225490bf600e3
-- 
2.53.0

