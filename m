Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2D3BFAD4;
	Thu, 16 Jul 2026 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236189; cv=none; b=C9TPwxkwItxz85wbh9oHC/fBRh695R7RkUf9S/2phQIXEo/I+mAYae4lZYgPPB4tZj5BuVr/JPjFAGp3xubeIJReWdBbjOqftNuZxZcKc96cFQf9xzkJpmzf4SYw8CpozUzNZCFOMXumRyLAIUgkOEIiHI0qtV6K/nZBVJIGLVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236189; c=relaxed/simple;
	bh=wt0F7+LO0hUZa55379fK7yjrK46WwbkTONV8HiSWAgw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yqdc06/wOPMzrHsIbb7fjc6hvonSEVa+d0eBj49SkF/URt/t3eD/7+5tO8kD7+TP2Xr4icIY1ERlMqIvOqt3XOjiI+K0OAbMA7Hkcpwl3KsIsLlZqnTYFC3tpAcevEzb3U3kMUEGqxwpzW7pCpMohXDKiaaD+EvDYaTcL9hU+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=h28+V0Dd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="h28+V0Dd"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GJr0js116766;
	Thu, 16 Jul 2026 17:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=6BB0/TohsLs52wfUjQM0ZYlgO9x
	DJvp21pINIIMMPLE=; b=h28+V0DdeBwfPdB+WgIoBFhMOQPYz4QbgcTbHPTMNkb
	t6ML7I93sTlsQxpxLa1WhVaxVHVD9bWDGTawQC1YGullqt0F3qGEevazm64FVpc1
	RUVQISSQFLidJZjkeYWwdwG465ZJMYQHfkitU4GyK7XMqBh6kIQhEtva9VpiJwDg
	x9BVIvoKAbms6I4Q6d2fKYLl5ByLT5vq8gVl6zLDnVDjEcYE50as8FR3i0MYAWhD
	IJLSvrX+acoYdel0KLCwF8mQrp550kEfkLHoVv8frz8/EIK7QqN9xjbt4yOW39/j
	+aYKdZQdBLi38ehANRaQ1xfDa8GSlombzdFdny4f0zQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ff005snrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 17:09:09 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66GL98Jo004235
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 17:09:08 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 16 Jul
 2026 17:09:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 16 Jul 2026 17:09:08 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66GL8utm004867;
	Thu, 16 Jul 2026 17:08:59 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 0/4] iio: adc: Add support for LTC2378 and similar ADCs
Date: Thu, 16 Jul 2026 18:08:49 -0300
Message-ID: <cover.1784235595.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: _JFdUPv6Qh_NCtnkuv3XlnOmmcDeaoMx
X-Proofpoint-GUID: _JFdUPv6Qh_NCtnkuv3XlnOmmcDeaoMx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIxNSBTYWx0ZWRfXxmc0MvlYYUt2
 IOGPp54mK4alyAyfwDFlUZV0XN7+TiYevr/Q3YmxFfEp5MSHrDURFOyOvwSW149GTqNqxer0ks4
 ADs3Q24tuYeQeJBHcSjf0ynvRAVM/YDu/uMuDbd9CoY57XNjLmgR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxNSBTYWx0ZWRfX4F631w1BcaKy
 Eql0VLKnOO3BMBxE9RcknTVNCGC8LJXwINZZCxz6hTnAE7j1S/60QuYuvSQ6OnkAcXD9Za+2wzF
 8cFDFg84AYTYct5j8eKi29qrSTSPktqpilQUn4x+JKgxBTAZZKcJPj/nZFDY6FZQhpyfM+r4hxL
 5PhrxUElkE8o7iA7KJCHeNkhmumJnZ2zY3rJPECep7aKxlhaG2NU5bpPBJJ9xeLl5RgGArwWPBQ
 9Vx5HkFKDV+2xhi1qLY4y5y45YmLL8Q07Uymersuv9B3vupU/eykL1yI+zEP3HfpwMtScYlpW/W
 WHD7c5DjhwF76RsF6KiEMwVVWmwXytsqjUVS0QX5Zffex6as+M2C3oyJb/7mIbyo8EOywFhMddX
 rxcgZjI/v0dz6J/2vyuFjoAQ9CrNSsQb4uhkzCUV5aoT8wzwa9lsGl8t/bVKdeyztkdle8Wpxrc
 QKiO0GZx7Xh5WBqajGQ==
X-Authority-Analysis: v=2.4 cv=ceziaHDM c=1 sm=1 tr=0 ts=6a594875 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=XqN69BuZ7wOcV2cAv7kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160215

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
  v6: https://lore.kernel.org/linux-iio/cover.1783629101.git.marcelo.schmitt@analog.com/
  v5: https://lore.kernel.org/linux-iio/cover.1783028033.git.marcelo.schmitt@analog.com/
  v4: https://lore.kernel.org/linux-iio/cover.1782397418.git.marcelo.schmitt@analog.com/
  v3: https://lore.kernel.org/linux-iio/cover.1781661028.git.marcelo.schmitt@analog.com/
  v2: https://lore.kernel.org/linux-iio/cover.1779976379.git.marcelo.schmitt@analog.com/
  v1: https://lore.kernel.org/linux-iio/cover.1779117444.git.marcelo.schmitt1@gmail.com/

Change log v6 -> v7:
[DT]
No changes in device tree doc.
[IIO]
- Extended single-read critical section scope (holding mutex lock longer).
- Added comment about conversion wait time.
- Now keeping validated offload configurations if conversion rate update fails.
- Imported SPI_OFFLOAD name space.
- Replaced DIV_ROUND_UP() by div_u64() to mitigate config check fail due to
  different integer rounding.
- When applicable, return early from regulator setup.
- Separate macros for offload and non-offload channels.
- Moved ltc2378_prepare_offload_message() downwards in source code.
- Wrapped transfer buffer declaration comment closer to 80 characters.
- Picked up review tags.

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
 drivers/iio/adc/ltc2378.c                     | 842 ++++++++++++++++++
 5 files changed, 1040 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
 create mode 100644 drivers/iio/adc/ltc2378.c


base-commit: aa58ecc73466d0cb8c418de98e2225490bf600e3
-- 
2.53.0

