Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981148;
	b=vjmyRXKzCkJKyjkIfHfRNt89v6yfi/wLqPPGLzrF90ylge/3ELbjdKFTKLboE/VF36/q
	 pufYOaNsA1476Cs1lu+wxSxjbJkeoGGe4fbn7E1caBzZ8JFVnvtvjgCwgCYnltg82oYHA
	 +P64czWLa0NAuFd3e+A14FCrlE7G61CY/8fT2y8g6iWyEB/gZi5wQVYEsSmkDEvEJ8mcD
	 a2MbCEVZ6d2OsMPU77e5XAlJGRCRaTvyeewBmm2ZaOJx6rygo/2ZfIJflux2s5WP3nV6A
	 lsAZSGDQ3++/0XEPMGbzzANbwIkPQlH+vysWkkpjbi78tVV7mUuSf6UFCPn7kB/51Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981148;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bsft8c6MBUJgIgF+Q+LW1GOGVnCr+nu47uNT4A2ixmg=;
	b=j+CWwtdwi6/sy+vfslJlAgBXDI+M+UifCjQOLJiN3CJ31sFCPCDCybatS8MUgC0Qc4Nz
	 pK3EngsdAjogl36Jg2/Lk1C7jzy+zP5Wj5eS9AF25pzFp85rvrGk19R3wZ5cAKlLuk7TD
	 KQNaVSXkqn/uiYdje3d1svqp+JFPlo7W1aOeHRonkm3jSFYsSRO1RrHyoX7KHDYsOugf+
	 OCwlJOLRyj1p3I7KYIRrzEdgShXUhAUm0CuobOrrPYUbZ3MWEHhInWbP8fTzwdNWBiYqC
	 DGA/6g/VGVxsOkDFpTuJXNn2ZyYAxIJrNl914CBaQGVeL69rqIuS73TkL8B+AqoRvHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=tpsZ+nPw;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=aHMUPqPl;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF4606A326;
	Fri,  6 Nov 2026 16:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69AF4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=tpsZ+nPw;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=aHMUPqPl
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F49tZ833049;
	Fri, 6 Nov 2026 11:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=bsft8c6MBUJgIgF+
	Q+LW1GOGVnCr+nu47uNT4A2ixmg=; b=tpsZ+nPwZn759FPLwFl4swqeipiJu+nH
	ZeR4IwaEL0bGSF0G2zq8nF6JR0cpoSF3Vd7Fl5dYAEYMfzsTjW2uBjW+bCHQLkSd
	eTPmvPMexWyFOYYVRufIQIZRMuqawr10guVcYetkhA8xP4Z1/leOrzsSxyLKY0+F
	2mxHN7SL4ogu3hDCbOHy/xG6RQlgMbj0AMPupSSbSPLHkZ+yF8HdpYdQJbVOf0V8
	5CbI3DUmLpVddmNMgzAx8+OmfD98wY1jU2sMrpT7su4MNrvsGr1TFhCQkD5BEEvQ
	sgCzucjhqG7LL3AbeZ4qb+mWl41lOWeUtQMXfGzyaprxonnQcTYFVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=bsft8c6MBUJgIgF+Q+LW1GOGVnC
	r+nu47uNT4A2ixmg=; b=aHMUPqPlkxZFuPHbeZc9TrIX5YkdjQX/9yXXGhox3vB
	kcXily9ApCOlj+ZZzLA54y0AyYYG6ZZm3wV4XIZvaToMT5TByQb1nROgTeq46yos
	+2dH582rT2Vc/0lZuZe9OZYsRDauTcx8CZ6WN0sgoa4KItGX20HViUOHNB8xhIww
	xKc1SdKdChJTmpprKxFS3Yj3a+gdjSqLESqmzn0s98XHXnDA67NLCb6R0g01zgoE
	yCh6QxxVRP3zlGG2P81LlST11xQoGiZj7Hd231u2WWNVx071xt1+fHAz8Z02llmb
	078qZmOLhN7h+5OfYkH0L7x9xQBlnJBqT+4br4NtXKg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3q052aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:05:43 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A6G5f2E052459
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Nov 2026 11:05:41 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Nov
 2026 11:05:41 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Nov 2026 11:05:41 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A6G5TDH016340;
	Fri, 6 Nov 2026 11:05:31 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Trevor
 Gamblin <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolae-Daniel
 Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Subject: [PATCH v3 0/7] iio: adc: ad7625: add LTC2387 and ADAQ2387x support
Date: Fri, 6 Nov 2026 18:05:12 +0200
Message-ID: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: BLTkAjnZ_aIR0FMPuZA3cVcwdgXv8fO_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MyBTYWx0ZWRfX62beONXvXUhF
 VoiQLY4u9bX00RdvDGFkMiEkAGdhTeiryhieU2hTcx/AR+d733JaJBLrsyepLHal0hBpcucMgRw
 NsmT/NCDScYZxnZ1bpfX0iBm09O5alzBix8h5NNtDiNG5Nm97971
X-Authority-Analysis: v=2.4 cv=Lt8HWXdc c=1 sm=1 tr=0 ts=6aedfad7 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=isKMCpysE3OmxhO6Nl8A:9
X-Proofpoint-GUID: BLTkAjnZ_aIR0FMPuZA3cVcwdgXv8fO_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MyBTYWx0ZWRfX53RphTPDk5eu
 vKAqxA4Ub2zFm9gKgCcM23pVLcPTG29RKktNKsdvXpaqAZmldFFDwwyd6Sc4Q9T2fC2vPmRCnDN
 RfPsuYHz01KRK9iGdz+VmM4FDNeM3229iM6BRbrV3Ytt/HG7w/0YcqBwYv6jUXSpmevJAHQHm8s
 Wp3DffQdTlInwN4vJ86WZKT1tIuJM7p5epnkBomOg5h6pPHwotU4QbzfUTyEP8oK3riXnQ66bRE
 JSbSX2k8dNbLwztfRvZ4N0shYOGTVwflXY4Y8vYjQayiW/xj/G8m1Bjfkkm8wFu+BbuFJTgQ0jz
 6qF4dR088eCzQZQ7EzP8qY0HI8yIQWCFztivtQjKPiJjJzJrn9Oe4ZB2t4rN+YSCdqK4W++wYLY
 VvEJHHR4wlAQAfdoUVkmBeW3g2Nh7yy3NM7uKjTSj8Exuo+gN2bI/oN3zJ9gBRwOXvhtAVMlwxi
 4XQ7YwOE13CDRUTec9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060063

Hi all,

This adds the LTC2387-16, LTC2387-18, ADAQ23875, ADAQ23876 and ADAQ23878
to the ad7625 driver. v1 added them as a separate ltc2387 driver. After
receiving feedback, v2 refactored the driver into the existing ad7625 and
modified the pwm backend for clear layering. This version gives the parts
a binding of their own.

The parts are single channel differential 16 and 18 bit SAR ADCs, up to
15 MSPS. Like the AD762x and AD796x they are read with two PWMs (CNV and
CLK) and an IIO backend that captures the LVDS data. The differences are
handled as chip data and a few quirks:

- Output is double data rate on one or two lanes (TWOLANES pin), so the
  CLK burst is resolution / 4 or resolution / 2 pulses long.
- The burst has to start at least t_FIRSTCLK after CNV and end at most
  t_LASTCLK after the next CNV, so at high rates it runs into the next
  conversion period. The sampling period is raised until it fits. With two
  lanes 15 MSPS is reachable, with one lane the limit is about 10.9 MSPS
  (16 bit) and 10 MSPS (18 bit) at a 120 MHz PWM clock.
- No EN pins. The second PWM is named "clk" for these parts and keeps
  the name "clk_gate" for the existing parts, as renaming it would change
  their binding.
- The ADAQ modules have a fully differential amplifier in front of the
  ADC, so the scale is divided by its gain. The gain is fixed on the
  ADAQ23875 and pin strapped on the ADAQ23876 and ADAQ23878, so it is
  given in the devicetree (adi,gain-milli).

Patches 1 and 2 add what the driver needs from the PWM. The timing of the
burst has to be placed in whole steps of the PWM, and a rounding function
that rounds down can't tell the consumer how big a step is. It was pointed
out in review that reading the rate from a clock breaks if the PWM provider
has a mandatory divider. So the provider now reports the clock rate and the
number of clock cycles per step.

Patch 3 fixes problems of the existing sampling frequency code that the new
parts would also run into, patch 4 uses the standard unit names, and patch 5
only moves code, so that patch 7 adds the new parts without
touching more of the old code than it has to.

Changes since v2:
- Split the binding into adi,ltc2387.yaml and left adi,ad7625.yaml as it
  was.
- Moved the EN pin setup into a helper in a patch of its own.
- Made the Kconfig prompt, the comment at the top of the driver and
  MODULE_DESCRIPTION() generic, and sorted the part lists by part number.
- Used HZ_PER_MHZ for the maximum rate, and a default gain of
  1 * MILLI instead of a gain without a unit.
- Simplified the gain, reference supply and lane count handling, did not nest
  the rounding checks and replaced min_t() with min().
- Put Context before Returns in the kernel-doc of the new PWM function,
  dropped a redundant check and named the rate clk_rate_Hz.
- Used the standard unit names and macros (vref_mV, HZ_PER_MHZ) for the
  existing code in a patch of its own.
- Included property.h and types.h, and ordered the declarations of the
  new code in reverse christmas tree order.

Changes in v2 (since v1, separate ltc2387 driver):
- Joined to ad7625 (binding, driver, Kconfig and documentation).
- Dropped the clocks property of the ADC, added the PWM waveform step API.
- Compatibles use the adi, prefix and the datasheet part numbers.
- Dropped the x4 parts.
- Fixed The missing return of dev_err_probe() for the initial sampling
 frequency.
- Added the maintainers of the new parts to the AD7625 entry.

AI disclosure: parts of the commit text and the code were checked with an
AI coding assistant (Claude): the first version of the merge into ad7625,
the PWM step API, the timing arithmetic and the test scripts. I reviewed
every change, built it and ran tests on the ADAQ23875 + ZedBoard.

Link to v1: https://lore.kernel.org/all/20261027134409.76824-1-Nicolae-daniel.Deaconescu@analog.com/
Link to v2: https://lore.kernel.org/all/20261104132143.215581-1-Nicolae-daniel.Deaconescu@analog.com/

Nicolae-Daniel Deaconescu (5):
  pwm: core: add pwm_get_waveform_step_might_sleep()
  pwm: axi-pwmgen: report the waveform step
  iio: adc: ad7625: fix sampling frequency handling
  iio: adc: ad7625: use standard unit names
  iio: adc: ad7625: move initial mode setup

Sergiu Cuciurean (2):
  dt-bindings: iio: adc: add adi,ltc2387
  iio: adc: ad7625: add LTC2387 and ADAQ2387x support

 .../bindings/iio/adc/adi,ltc2387.yaml         | 169 +++++++
 Documentation/iio/ad7625.rst                  |  34 +-
 MAINTAINERS                                   |   3 +
 drivers/iio/adc/Kconfig                       |   7 +-
 drivers/iio/adc/ad7625.c                      | 470 ++++++++++++++++--
 drivers/pwm/core.c                            |  65 +++
 drivers/pwm/pwm-axi-pwmgen.c                  |  13 +
 include/linux/pwm.h                           |  34 ++
 8 files changed, 739 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2387.yaml


base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
-- 
2.56.0

