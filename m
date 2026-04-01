Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23003E6390;
	Wed,  1 Apr 2026 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038861; cv=none; b=RXA18ZwLMdf/23dLKcFlod/sZSoYFBjmlLRknDNbPZz0iyVlGFVVfvJhNjTQNXP3LyG2cbOuPnmJneWl+gM2jSirl04HS49irtiVaz69j64Uy6skBr0KZkKoL0wJJ3LTOSrw557Tn5jaU9B8lrPnERLTSaa4mcFNARHl6dg8tGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038861; c=relaxed/simple;
	bh=rL2BBdeGhEFPwW5y9Fql3xtCPb3d+vujyjq7lCm1vq8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=qxXRXIGrjKVwESwlaV5ovP9qD75yVJygnZLR6cWMlrkwzVddPwh4DtgOtp4XhUj2Zu4dN1KxxAtttA03gn+py3GLih1iULV3lq1kzHBymeopnTqB93iUGvmyCbFVI95sAVMhCSvMaJZssZQQ/bPx7XXVFFjaKzVq3SQQ4AIyiik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0I0s4lja; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0I0s4lja"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6316Isqq2798184;
	Wed, 1 Apr 2026 06:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=53EzZg4wk5NuIttbMpmNwscI2nO
	mDgEqUlZU+C3KfOY=; b=0I0s4ljaKpOPNkB/+HsaUajCl9qTaCI2tgBaZFBP1Vn
	fhxNIzMnDtIN3SjO3soq3w21LXz6rdFL3v9aT782iZLDjfi2aVhKpS4Qe4Dszmix
	tfa6VLnS7tULaRAySl21VWkLXh6NcifCGEgwbyICPjLUpTZjWE/F/+MxnAazqf8/
	UzSxD8vtc6nG1ycfUKwCJq3igz7SfxLdqxZywb9vNhB7VFn8Fbzp7MUzBt0IbidJ
	Hst9vDLWl+rNXTHBmjXSSrE2uekQwfnH8o2rKfWJ2aBR3inq5W99XgkyWD1LSWYc
	DCrkupYNl0SuQyS/OqdH0UOJw7Zkp6kPH4l8Sai6ktA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d7y9vhta1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 06:20:30 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 631AKTEQ058784
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 Apr 2026 06:20:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 1 Apr
 2026 06:20:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 1 Apr 2026 06:20:29 -0400
Received: from ATORRENO-L02.ad.analog.com ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 631AKFrc007322;
	Wed, 1 Apr 2026 06:20:18 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Subject: [PATCH v4 0/2] Add support for AD5706R DAC
Date: Wed, 1 Apr 2026 18:20:02 +0800
Message-ID: <20260401-dev_ad5706r-v4-0-a785184a8d53@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFLxzGkC/23M0Q6CIBiG4VtxHEeDH1HsqPtorYE/KltJg8Zqz
 nsPPSlXh++3Pd9Eog3ORnIoJhJsctH5MUe5K0g76LG31GFuAgwqBsAo2nTRKGtWBQqcScsRodG
 GZHEPtnPP9e10zj24+PDhtZ4nvqz/fxKnjNYghTFYl0o1Rz3qq+/3rb+R5SjBBwvOtxgy7kSVQ
 6BBbn6w+MZqi0XGElmtupLbRqkNnuf5DWHUOLkhAQAA
X-Change-ID: 20260220-dev_ad5706r-2105e1dd29ab
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexis Czezar Torreno
	<alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775038815; l=3755;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=rL2BBdeGhEFPwW5y9Fql3xtCPb3d+vujyjq7lCm1vq8=;
 b=NQz7nPJ3VO7d1FJW6/2nNhDAgRGvMmPztO6Y5HQ9RjE8uIBfs9Z1a0MttS/0ABRRbO3P4x0dN
 SXLHqS30S4qBX2TmsLZTjaHiBgQEGQGBDSM2LNO6TDWVhUfEVdCoNwX
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: iDFppdwaMvmDHTS132TFoD2RUuNX7jsT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA5NCBTYWx0ZWRfX8hVYgxabZkIb
 lw6FDmvX+VjwGT9SaIkbt9BiRcKLLBCgHAUoQCziXFRWvwi9gKmX9Sad8Xun2deJoM9l/63lehl
 CRo6d8FqML5cyFWjNvxY9TkWUr3QK9k5HhVVTvQvUCpKwDwex+BF+uGyhglzt7OYSXMJlp9wsI6
 lYzwdeiuS16F/z/kA/+2zWE7W9C4jtThL+YakGR8uBxCaYUSzBZsxqgTYNPoNgfJAFiZmwn9R28
 wUIrNiXo9sEWRf6SIy2G74a4YQOROfjn47t9etDfTKAldZgdUqDXJmQ3kxOxcKu9L24L6PDy24r
 1JCHJEQrzMPU5Hs7/Gox4SdGtGKJqt+4DSzmzP+t1fRA8oEa3WyBYh5FGR5/irEVrM1Bihx+24U
 /WWmEcRH0isdMumlSixKjOe1Y2I807y5WtWoe2XqZb35pSW+pWdshPFaDVR8EOLT7m8JpYQgibQ
 zQsRMUhfi0DkZv81nfg==
X-Proofpoint-GUID: iDFppdwaMvmDHTS132TFoD2RUuNX7jsT
X-Authority-Analysis: v=2.4 cv=N88k1m9B c=1 sm=1 tr=0 ts=69ccf16e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=XJZcrK31PTXhNydwGfQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010094

This series adds support for the Analog Devices AD5706R, a 4-channel
16-bit current output digital-to-analog converter with SPI interface.

The AD5706R features:
  - 4 independent current output DAC channels
  - Configurable output ranges (50mA, 150mA, 200mA, 300mA)
  - Hardware and software LDAC trigger with configurable edge selection
  - Toggle and dither modes per channel
  - Internal or external voltage reference selection
  - PWM-controlled LDAC
  - Dynamic change SPI speed

The driver exposes standard IIO raw/scale/offset channel attributes for
DAC output control, sampling frequency for PWM-based LDAC timing, and
extended attributes for device configuration including output range
selection, trigger mode, and multiplexer output.

This driver is developed and tested on the Cora Z7S platform using
the AXI SPI Engine and AXI CLKGEN IP cores. The 'clocks' property
enables dynamic SPI clock rate management via the CLKGEN.

Datasheet: https://www.analog.com/en/products/ad5706r.html

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
Changes in v4:
- dt-bindings:
  - Reverted pwm and gpio entries.
  - Added missing power supply properties
  - Clocks not added back as they were driver specific, not device
    properties
- driver:
  - Added missing includes
  - Converted to use regmap with custom SPI bus implementation.
    spi_write_then_read not applied as suggested, prevents future
    need to change SPI speed
  - removed driver speciifc mutex/guards in favor of regmap internal
    locking
  - Minor style cleanups
- Link to v3: https://lore.kernel.org/r/20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com

Changes in v3:
- Added MAINTAINERS entry, files added on each patch
- dt-bindings:
  - Added allOf and ref to spi-peripheral-props.yaml
  - Changed additionalProperties to unevaluatedProperties
  - Added avdd-supply property and added it to required
- driver:
  - Removed redundant includes, added respective includes of APIs used
  - Simplified bit manipulation in SPI read/write, used feedback from v2
  - Fixed inconsistent trailing commas in device ID tables
  - Removed zero initialization in spi_device_id
- Link to v2: https://lore.kernel.org/r/20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com

Changes in v2:
- Stripped driver down to basic DAC functionality (read/write raw,
  read-only scale) as suggested.
- Removed PWM (LDAC), GPIO (reset/shutdown), clock generator,
  SPI engine frequency switching, debugfs streaming, and all
  custom ext_info sysfs attributes
- Removed regmap, IIO_BUFFER, and iio/sysfs.h dependencies
- Simplified SPI read/write to use standard spi_sync_transfer
  without clock mode logic
- Scale reports default 50mA range as read-only using
  IIO_VAL_FRACTIONAL_LOG2; writable range selection deferred
  to future follow-up series
- Simplified DT binding to only require compatible, reg, and
  spi-max-frequency
- Link to v1: https://lore.kernel.org/r/20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com

---
Alexis Czezar Torreno (2):
      dt-bindings: iio: dac: Add ADI AD5706R
      iio: dac: ad5706r: Add support for AD5706R DAC

 .../devicetree/bindings/iio/dac/adi,ad5706r.yaml   | 105 +++++++++
 MAINTAINERS                                        |   8 +
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5706r.c                          | 244 +++++++++++++++++++++
 5 files changed, 368 insertions(+)
---
base-commit: 3674f3ca92730d9a07b42b311f1337d83c4d5605
change-id: 20260220-dev_ad5706r-2105e1dd29ab

Best regards,
-- 
Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

