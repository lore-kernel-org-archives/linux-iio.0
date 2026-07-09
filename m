Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948F283FD4;
	Thu,  9 Jul 2026 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630175; cv=none; b=E93J3xxXJdaLWTN7ZVc4VyrVBq0qk8ik0ov/5fDvFv/sh+OuPgKPKIKIG5PpMisSzgzfJ06sbK1PVNGaSmsWuPvvKIIxvaQEVMqwqFd8XX7JQKCseFh26ZRsoGGFvXLsaBEu3xFQR97uvNUa58QknHVS/MvYpH8ZZefJAR33rwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630175; c=relaxed/simple;
	bh=3xga7A3kXtcNqzDDYv/uIDEfi064QFEQN2be+835/9g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TeQncBFtKRjCz30r36o1I+ta38i8/Rnx6FXbyL09R5ZqczAi2JxDCS6XSXloW8rboBfSoNd53VLU+ijTFtymF2kSK9Olyk+MQ84flqgq2V10cu+V/LzGtJxvEqCT4pw1lSqHi4YarkWmcYY5rUD7IFNXZyo3Ch2nqs+FLfMfNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XaSTqKAT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XaSTqKAT"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669JEWaO1847790;
	Thu, 9 Jul 2026 16:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=h+dw3kCW/kleuhP7037TwZKiQBp
	A/08bWVZBjne8V2Q=; b=XaSTqKATpdNZoMx2Se/+LUzHj/63kdOTAsg57MEe/Pv
	45LviQ9MLtY3EQT/KalsxzBeSUPIb9du2lMuO0MCufWfO1GfRw/VkeBczEwzJzTn
	bdqNjm5aeJpHoLwzgp3ALQ50rFluMyvBk7v09aJTWgbOctyi1FG03t99RChQGmvm
	dEGwtIO90X4yzJyI8YyO3jPBfzK+BelSGDaRUk4aIpbG552AzGhgnGo49BfjsaIr
	IQslu++eplygeDdDqiggDD6HLuXeouHFx2vJPzHNpwJIqpXKtZfUhgbL+JF/Ezw3
	UQ8e1fKJh0W5e23qxvDYfaSg311pTCcbU8EBlWSHkiw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fa9qsagjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 16:49:22 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 669KnKp3046364
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Jul 2026 16:49:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 9 Jul
 2026 16:49:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 9 Jul 2026 16:49:19 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 669Kn7wn003656;
	Thu, 9 Jul 2026 16:49:10 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 0/4] iio: adc: Add support for LTC2378 and similar ADCs
Date: Thu, 9 Jul 2026 17:49:02 -0300
Message-ID: <cover.1783629101.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIwNiBTYWx0ZWRfX12iMe7JvJjLJ
 +dxkYmOGhOAEspzeza8WBw75uD+cCq6CKgoo6Kvhc6y4tjCDqMce4Tp3a7YxSq8POEjpGDmS5p7
 e2Lgq0L6uK93RjMrXqmp7ECH+Vbw/KluIyZpg2EYlB706tR6YAbb
X-Proofpoint-GUID: CDqef9lPiYbQcPAcIpfq8YOj9dGw2r_A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIwNiBTYWx0ZWRfXwNaKDcY79JnH
 4eSeAI8/GT5HINbERnzQ2/5eseU0chCSnFhbTriQ9AdRXFRAHLpdmtcIf/YteAIwn1JVqZwOgBj
 3MBJU+Irgk60YhfTpfmifWpwxAwuRc4YBPfD0VnphCaHLw2EnHeu/mBDPuVmqdajmFm6h0yMQNV
 0Gwi6fXBEelV04MX0PwDXK+dAfR79KNTnPB0ctFl6Jj3stGb7gVyJINa1/PmnyBQp2y2HUgVtdD
 /kc/xmB7eDBByDLHnpk8INXrib+xL2Ha+UXbtSkJY9D6HUJRJ0xrEOgYCWFUY+uKxXwAKT/FztF
 04kvjuAISQOdAE2ONJ1wR/UZpfg+/pnv2sCpRPQj3j49OKvIBXWRNkg9BrUsSoxdmkcA10DR1XE
 nZn4wNkGyTZ9FHNhbzSptEzDIDJYKDUyvE9bTd6sLzC0LAbB5J9D8VhtfYtCYe1f6slFkLmXFf8
 6HNksh+BvxbeZI+8adg==
X-Authority-Analysis: v=2.4 cv=fu7sol4f c=1 sm=1 tr=0 ts=6a500952 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=XqN69BuZ7wOcV2cAv7kA:9
X-Proofpoint-ORIG-GUID: CDqef9lPiYbQcPAcIpfq8YOj9dGw2r_A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090206

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
  v5: https://lore.kernel.org/linux-iio/cover.1783028033.git.marcelo.schmitt@analog.com/
  v4: https://lore.kernel.org/linux-iio/cover.1782397418.git.marcelo.schmitt@analog.com/
  v3: https://lore.kernel.org/linux-iio/cover.1781661028.git.marcelo.schmitt@analog.com/
  v2: https://lore.kernel.org/linux-iio/cover.1779976379.git.marcelo.schmitt@analog.com/
  v1: https://lore.kernel.org/linux-iio/cover.1779117444.git.marcelo.schmitt1@gmail.com/

Change log v5 -> v6:
[DT]
- Dropped single compatible strings for parts that have a fall back so dt-schema
  can enforces the fallback compliance.
[IIO]
- Added a comment to clarify IIO buffer storagebits and endianness for the
  offload use case.
- Added comment to clarify CPU endianness is used when device native BE is not.
- Protected single sample read procedure with a mutex.
- Dropped mod_devicetable.h, include device-id/spi.h device-id/of.h instead.
- Used iwyu to add missing #includes and dropped superfluous ones.
- Used pahole to minimize memory holes in LTC2378 data structures.

With best regards,
Marcelo


Marcelo Schmitt (4):
  dt-bindings: iio: adc: Add ltc2378
  iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
  iio: adc: ltc2378: Enable high-speed data capture
  iio: adc: ltc2378: Enable triggered buffer data capture

 .../bindings/iio/adc/adi,ltc2378.yaml         | 170 ++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  19 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ltc2378.c                     | 821 ++++++++++++++++++
 5 files changed, 1019 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
 create mode 100644 drivers/iio/adc/ltc2378.c


base-commit: 093239070573637ad2b4cb56abc9c4c7ee109294
-- 
2.53.0

