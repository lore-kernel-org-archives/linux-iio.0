Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798534;
	b=ospOLwAelfbooqMxg5aYwschULrykCMNJTOqZKkbel0So0716Es3FxcY9jRGB5g6Vgnt
	 KXkzj7oWA8ALf3vMO/CfWDkTvsNvek4HydN/WmlftaTTJlJinzythFR2Xd9WDp8JwRYYM
	 Ucpe86vljylY5EypTq1J41oXzNtKwoELSfQZiO73KxCxA6ctjvWc2SkN9jl0jmscwG/ID
	 7LZXje3TA79SBz2iE/CP0xiOi9CaCkb00lr4gh6p+udBcfCHghUsMO31LYDQbRmexpwKt
	 eAR8711jonatIL2l4VCM2Sl1kPatW5pIK8cAlw6yp9ExFe390jz6y3DAEBlDO/gekkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798534;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-ADIRuleOP-NewSCL:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ZSnMlVdo+fDOwZWDnMzKFtRjw1qYZbIIDQ1iNEEW1Fw=;
	b=ZJ/Xfpro6cPJxx4mj6Sx2Thvx+0MEu63nDf7fVfhk4IrfVKmqlvK16cYMHZXwgQltHEV
	 ThhghWFtxSIuacE1tvr8+AhsZgsbfhKCLF5P1+w3z76L7GZgJdHTVzEqcNwWI9k/Q/D2C
	 8HZuqcuqIi5Q2Au8FaNxX/vkxgwa0G5aZRj5Q+TtdrUEn0xBdvUeJrp3uN1l0KUr+BWmO
	 TqQYiOCalT4l5YUuaI6Bi0+6emKekNiiR8W/3bd1ZOY46seczid0HQpd5QsH2fjNbJ8li
	 x8ebqqgRzOjgBQSSuGvYVZ6/cDW9MlhJ9uG6oBazXIYxMegN7ETYRztH2lizFV3Xp4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ai1ohK5M;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jn289os9;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B941606A31B;
	Wed,  4 Nov 2026 13:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B941606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ai1ohK5M;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jn289os9
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BcGAa1243214;
	Wed, 4 Nov 2026 08:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=ZSnMlVdo+fDOwZWD
	nMzKFtRjw1qYZbIIDQ1iNEEW1Fw=; b=ai1ohK5M3eSwvQPGm+AawvK373D1K5Bi
	6TOdl6zKIOTtceuXS3bnnpLj3lOTQNOLUYJ4v2kSlFiNZtRWWgOzQfVyYCJjUCFV
	VUkZNCJHuIBQz48dNNW+q9m4YHApTtfwLg/dqtU5xNX+Yj3fSi9a7atJEujHjZ/g
	NLY+eXUEmPtHjEJBwuTwyv8Kcx0Kq10O4C5+ciyel9p2sRAAwQxzDadM2Zt0pUGn
	DSjsHLIDiDycy5zvWggYaOrVGe0x8SwRwXKH/ZByjxKd/asrOocyL3zlG5pADqQq
	EMfFVyxBZKjyUvnh0Fz79hFCcqJIVkToOKlQQtzAlC/hc4BHTVuWww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ZSnMlVdo+fDOwZWDnMzKFtRjw1q
	YZbIIDQ1iNEEW1Fw=; b=jn289os9caAifXYrxoxMVsxj1oek+tRoueou8xiu8E/
	vdXeNUJou7kjyDJp+6c/QQlfP55kMiMEr6ifVBFtJUzM9FTkfqdH02hBR2r+Johx
	mBVZT+gLhquO7yOPqS5qiios8XfsjOsCRkVbVhhXISBulu/6tIbalQ1toOp0PglW
	ChC2c3LPTLp0yKrb8Z6DSEZVLQSoNCKixB03FlROSpPfOqEmuTWg2+gyX+onKHap
	Ymzdf5y3svAnLosrFjVBplKAuyY32PXl3GIMM/to9CKbsrYTAHPj6ztiwPLjUNEg
	qlPebgNwG9NwX37pAAdrG8stwAhWmbIOSp/ST7XBUBA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hqnfhn4hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:22:08 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A4DM7Fr028013
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Nov 2026 08:22:07 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 4 Nov
 2026 08:22:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 4 Nov 2026 08:22:07 -0500
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A4DLnal008011;
	Wed, 4 Nov 2026 08:21:52 -0500
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
Subject: [PATCH v2 0/5] iio: adc: ad7625: add LTC2387 and ADAQ2387x support
Date: Wed, 4 Nov 2026 15:21:38 +0200
Message-ID: <20261104132143.215581-1-Nicolae-daniel.Deaconescu@analog.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=I6Pw19gg c=1 sm=1 tr=0 ts=6aeb3180 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=uswTXiEBe0Z7XUS-pM0A:9
X-Proofpoint-GUID: eyFXndJRqEKYsB45abcWxyB0Ap-IDb5D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MyBTYWx0ZWRfX+mnsrokxwq48
 9sl7wMHqpKMUiy2FLe2JWfUjGtT6jHBUhvlZWr3Ufk7vAQH2IpwO9HIv17RcFFrOaTu/Gg2Dm3h
 G67jqSjA5eWz3l9nQHq8dMTWMb7SpxS4MaGZt6dsxat8+WoVm/6JnsDv3jnLwY83unDP0LJ+uCS
 7bXp1DKkJGVgJ8O8tL5xj5GeiBS6Z3pbLJApIovp5dCR6knml86xxFK61906x/XJTbNeEFHkQZp
 YZQKWJj52EFnsLOLztHUt5tsT1W1ldul6O7SM0qpG2C3zG1cSXgnmkXnqg+B9zvyR0tjQWjumrZ
 b8gqY4+oTBznB/fupZetQoWJ7abA/jdgNz3xX7J38pYzhHGqYL6HNyDccmATteiixHtbRf5u3s4
 a3q+lFQQVON5Bw7xc+4IJknyhuAal2Ue7G1JIUxgo61yuc4SeTrpirorvFkFoXvL+aqRvVVTxxK
 o9/DtxVaqAcmnhLq8dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MyBTYWx0ZWRfX5Xdn39cBVjUE
 uS1Qbirh8tXj6V9Ffmyo3jQ9vypzmgctv6PGaIzQSkY83eUAzfAtLc76lH2Xh+11vyVotaKQuke
 42o3rmE1YZsLol00PQNAhpSYqR3W+Xe/dvksobpIK/U6XfzdixcO
X-Proofpoint-ORIG-GUID: eyFXndJRqEKYsB45abcWxyB0Ap-IDb5D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040053

Hi all,

This adds the LTC2387-16, LTC2387-18, ADAQ23875, ADAQ23876 and ADAQ23878
to the ad7625 driver and binding. v1 added them as a separate ltc2387
driver. After receiving feedback, this version refactors the driver
into the existing ad7625 and modifies the pwm backend for clear
layering.

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
- No EN pins. The second PWM is named "clk" for these parts, as Conor
  asked, and keeps the name "clk_gate" for the existing parts, as renaming
  it would change their binding.
- The ADAQ modules have a fully differential amplifier in front of the
  ADC, so the scale is divided by its gain. The gain is fixed on the
  ADAQ23875 and pin strapped on the ADAQ23876 and ADAQ23878, so it is
  given in the devicetree (adi,gain-milli).

Patches 1 and 2 add what the driver needs from the PWM. The timing of the
burst has to be placed in whole steps of the PWM, and a rounding function
that rounds down can't tell the consumer how big a step is. Conor pointed
out that reading the rate from a clock breaks if the PWM provider has
a mandatory divider. So the provider now reports the clock rate and the
number of clock cycles per step.

Changes since v1 (separate ltc2387 driver):
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

Nicolae-Daniel Deaconescu (3):
  pwm: core: add pwm_get_waveform_step_might_sleep()
  pwm: axi-pwmgen: report the waveform step
  iio: adc: ad7625: fix sampling frequency handling

Sergiu Cuciurean (2):
  dt-bindings: iio: adc: adi,ad7625: add LTC2387 and ADAQ2387x
  iio: adc: ad7625: add LTC2387 and ADAQ2387x support

 .../bindings/iio/adc/adi,ad7625.yaml          | 193 ++++++++-
 Documentation/iio/ad7625.rst                  |  34 +-
 MAINTAINERS                                   |   2 +
 drivers/iio/adc/Kconfig                       |   7 +-
 drivers/iio/adc/ad7625.c                      | 402 ++++++++++++++++--
 drivers/pwm/core.c                            |  63 +++
 drivers/pwm/pwm-axi-pwmgen.c                  |  13 +
 include/linux/pwm.h                           |  32 ++
 8 files changed, 703 insertions(+), 43 deletions(-)


base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
-- 
2.34.1

