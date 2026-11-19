Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087512;
	b=VMOBWl6oomJ06gGW7bgA+bys+yz4pJlRW3CRZ8UeZidXzco1A/Ipb87uzlGEdGTv/9i+
	 A1aU0FmRnbNyBM7qCsjpezrFyVWqLCMHjjMMEvfudMR+fbINE1dBR9/8fRvOBsIRT/i0Y
	 ZH62W7+yARyO+NlzM40NT3fhYTLFPeWbG3EUmLFYxYbz0FrKm8x3UaXMypdgW+HZ+jeof
	 6J6IdRjc0mE97GWgoabZyPPB2fVWT5DaSOmOvt4x2wh8n5et4CdTROudhv+vY0bYbtOxX
	 GvqJcNveQgERQ/0SdTuvhNgaHbn9EPi2mHeK/XiA1AvbkhrA3NV7uesCIgh/XoLFvQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087512;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-ADIRuleOP-NewSCL:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=IH7dEyikTYGBZ82ylt2RMX5/YZDxUmxmuWxIMAkwb4U=;
	b=u+jLoUIeDGQ1rT4qt7thjF/y0bkFQltZxd3rONTYk80WVbrHV10UpPJv1eEhZwZGUcAp
	 cB61nbNCQ34SXXzriwik/SWnX4wt+7JrfKEDUiuC4IZocj9T/18zzN0NOc+GKQZujF9Fd
	 Y0qmrlFHUvLOuDtTl/N/BdojA1QHIo1xbF4glz4kDADcQHLrOMy73nQOxWq3ji2gUMtfu
	 an3xQy4ByMk0fcuvF5BiOMww2UqDjvNqsZ4am6N8LMT4/ajzCwW368CdFshKgL0LCDoBz
	 4PiYA3OZWzNVjZX+yAzrQKoaOKGNDRUFk2kZ5VtinQt9NtvL8GEaqgsNM75iMIP+CeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OkY6WWGS;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=QQwo+Xoy;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82DC606A339;
	Thu, 19 Nov 2026 11:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D82DC606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OkY6WWGS;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=QQwo+Xoy
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJB03Ca1582858;
	Thu, 19 Nov 2026 06:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=IH7dEyikTYGBZ82y
	lt2RMX5/YZDxUmxmuWxIMAkwb4U=; b=OkY6WWGSwFjbJbGO6JMy8JRmCGPRqlbi
	yBO7DEIUTqhAvvXt6FeMDAWYLWOzNmIneQwAnM9e0XPrCuIRXty4AfX3n4HaSvBi
	zqEfm5howVAF5tocXJtvJgTQ5P+j5KOTU+jnlrS7CkDRwhRKYLlfI7rQrc72Dr/M
	OTDTmx7/GDtyteXnDQfuDwiGBF2K/r1jFbTVRHZ6BXq829+t4KpDue2AmY3kUB1C
	p9BVFKSYYU6b8VKvhtNHw/S7E+W1fp1YXt1ivownvzg62P572Cpg8pRd3nAidzt2
	tzhzmEf+dZ88nq1TO3h6NvBHL7/XvuIsXPuNGMvv/iOqqdVd39wMKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=IH7dEyikTYGBZ82ylt2RMX5/YZD
	xUmxmuWxIMAkwb4U=; b=QQwo+XoyiZGdPWbDjqpQmFYr5frDpfjLhVnd9Djh6Wo
	EftC7bCeo1o+vAVWJrBFmd+U+GHv0EO1c9jU/aDe+7ujdtIIZYCjWKoid/iBfGxB
	tHdtHRjnMFfnz+4FHiwp0uOJdgZQFWb4ZXkBFWgPzIHrHit7X9NrPdMgMQkjbDcu
	BV7K4iBHgSGSeVknuqCORcZwLlhUaPzm5ECW8vWsRkKcQejdsqnUzWK1gEek0dtk
	x/h+WqO/5/icguVt+QVAB/8xGXmZFerquo5FMF7dyukNoQXureWlJrm+Gd1MThpO
	RbVIM2EGUynsHfxJdbqSws0D7G/9LlH1amSXUnCusMQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j138j1m48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:25:07 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6AJBP6s4011107
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Nov 2026 06:25:06 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 06:25:06 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 06:25:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Thu, 19 Nov 2026 06:25:06 -0500
Received: from arch ([10.135.2.95])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AJBOocH010881;
	Thu, 19 Nov 2026 06:24:53 -0500
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
        "Trevor
 Gamblin" <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Nicolae-Daniel
 Deaconescu" <Nicolae-daniel.Deaconescu@analog.com>
Subject: [PATCH v4 0/6] iio: adc: ad7625: add LTC2387 and ADAQ2387x support
Date: Thu, 19 Nov 2026 13:24:14 +0200
Message-ID: <20261119112437.197306-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.1
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
X-Proofpoint-GUID: kyhB3RAbTJF4okJp8Hej9P-7R9W9E9yl
X-Proofpoint-ORIG-GUID: kyhB3RAbTJF4okJp8Hej9P-7R9W9E9yl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX2l4Wb8AgQrmG
 0RwV7cZcWXqVrGhj3Pc/wQHyZpQiGj4iYi0e7c/lXTX5Hs8dCfWxvoZlPOcKqkfINC60PQN5TE5
 +W3sz8/OMgyC4p6oXjPYzN0uAdenyYsPRDnqAoPrZ1ynb09AS/g2uXVOvM+sAiD9AMKtn92gkia
 f/jQzk4I2HhWY8UUVMqdDk8dtU9nnfQttC7ipqG8WPqmjZ9ps23UJuO6HjoFkPjEvmyRAOcK9XD
 yRfFgkVTuWQD1Mv9tnZJSZGdu8QfFE/RBWSJySjsDE4zUtmFG2cdOe92IK9Io3R6aX6iAlMnSsF
 uL2SfBzobglVdtwMTmis7IiMaVwzm9l7jMenO+MnmV3KONgGiHssfCx768VPx6Dx/+AihLFRvgA
 qihjjqPH3yDfWR1sVt3lSzrLS9XJR6fxwE78mnl6Qgl7ljya0t+IwHnk5m4eFFvN3Yu7FoBADag
 qXTr4SAYw2JciRPdD3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX2b2nncf26Xm2
 eAviShnD247Bwe2HQQAJx++coUlnqeC3vfSCO+m6TYGL29aSyuo3HRz0cp76WxvxSQrMTJ1V5Zq
 U3Lqn7DuwdIx+0kl3eggT1dRtdxGOf4q/pq2egsFR5HPAg3G8Qg2
X-Authority-Analysis: v=2.4 cv=PdVqFShd c=1 sm=1 tr=0 ts=6afedc94 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=qcDcBul_syQFKgxyGr4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190045

Hi all,

This adds the LTC2387-16, LTC2387-18, ADAQ23875, ADAQ23876 and ADAQ23878
to the ad7625 driver. They are single channel differential 16 and 18 bit
SAR ADCs, up to 15 MSPS, read like the AD762x and AD796x with two PWMs
(CNV and CLK) and an IIO backend that captures the LVDS data. They differ in
four ways: double data rate on one or two lanes, a CLK burst that overlaps
the next conversion at high rates, so the sampling period is raised until it
fits, no EN pins, and on the ADAQ modules an amplifier whose gain divides
the scale.

Patches 1 and 2 let the PWM provider report its clock rate and the clock
cycles per step, so the driver can place the burst in whole steps. Patch 3
fixes sampling frequency problems that the new parts would also hit, and
patch 4 moves code so that patch 6 touches less of the old code. The binding
is a file of its own, as few properties are shared with adi,ad7625.yaml.

Changes in v4:
- Dropped the patch that renamed existing variables and macros to the
  standard unit names.
- Patch 4: pick the bandwidth mode first and check the result of setting it
  once.
- Patch 5: added the Acked-by.
- Patch 6: added chip info members for the gain, EN pins, second PWM name and
  supplies, report the sampling frequency rounded up so that writing it back
  keeps the rate, drop the 0 V reference check, name the AD7625 and similar
  parts in Kconfig, the top comment, MODULE_DESCRIPTION() and the documentation,
  shorten the commit message, and fix comments.

Changes in v3:
- Split the binding into adi,ltc2387.yaml and left adi,ad7625.yaml as it was.
- Moved the EN pin setup into a helper in a patch of its own.
- Made the Kconfig prompt, top comment and MODULE_DESCRIPTION() generic and
  sorted the part lists by part number.
- Used HZ_PER_MHZ for the maximum rate and a default gain of 1 * MILLI.
- Simplified the gain, reference supply and lane count handling.
- PWM step API: put Context before Returns in the kernel-doc and dropped a
  redundant check.

Changes in v2:
- Joined the driver to ad7625 (binding, driver, Kconfig and documentation).
- Dropped the clocks property of the ADC and added the PWM waveform step API.
- Compatibles use the adi, prefix and the datasheet part numbers.
- Dropped the x4 parts.
- Fixed the missing return of dev_err_probe() for the initial sampling
  frequency.
- Added the maintainers of the new parts to the AD7625 entry.

Tested on an ADAQ23875 with a ZedBoard. The other new parts and the existing
parts were not tested on hardware.

AI disclosure: parts of the commit text and the code were checked with an AI
coding assistant (Claude): the first version of the merge into ad7625, the PWM
step API, the timing arithmetic and the test scripts. I reviewed every change,
built it and ran tests on the ADAQ23875 + ZedBoard.

Link to v3: https://lore.kernel.org/all/20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com/
Link to v2: https://lore.kernel.org/all/20261104132143.215581-1-Nicolae-daniel.Deaconescu@analog.com/
Link to v1: https://lore.kernel.org/all/20261027134409.76824-1-Nicolae-daniel.Deaconescu@analog.com/

Nicolae-Daniel Deaconescu (4):
  pwm: core: add pwm_get_waveform_step_might_sleep()
  pwm: axi-pwmgen: report the waveform step
  iio: adc: ad7625: fix sampling frequency handling
  iio: adc: ad7625: move initial mode setup

Sergiu Cuciurean (2):
  dt-bindings: iio: adc: add adi,ltc2387
  iio: adc: ad7625: add LTC2387 and ADAQ2387x support

 .../bindings/iio/adc/adi,ltc2387.yaml         | 169 +++++++
 Documentation/iio/ad7625.rst                  |  34 +-
 MAINTAINERS                                   |   3 +
 drivers/iio/adc/Kconfig                       |   7 +-
 drivers/iio/adc/ad7625.c                      | 473 ++++++++++++++++--
 drivers/pwm/core.c                            |  69 +++
 drivers/pwm/pwm-axi-pwmgen.c                  |  13 +
 include/linux/pwm.h                           |  34 ++
 8 files changed, 765 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2387.yaml


base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
-- 
2.56.0

