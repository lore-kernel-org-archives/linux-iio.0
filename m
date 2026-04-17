Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1D539FCA9;
	Fri, 17 Apr 2026 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414496; cv=none; b=cS2j9J1m1PCj8w5zsjexh565VGNPRCbj0PTZe3+c5P6HVXAqXrETHSILizf78NU8tUg6reYpOMfX+2wUuYVkN/U2P1v9UjsjLjgeDlb92E5HNdFl0RSvRd2VjBl/n6tHFpJqisB9NXa66qb3mNAJj9Lle2FB8kL726pyYqSGSqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414496; c=relaxed/simple;
	bh=Mav47hscuufzCCAvdd+4tuR8jA9lkL1R1ktHsXl3du0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=gB7GgeMbnWgxYZeleElR5Src3v7x3j7fl9mv+a9wlcPkX/Rq8TvIQjCI5Gayf1QIQ9+Dkjqyk/6ZHWwO6HY+v/g3Qc6MK0Xu3+ObWNJe0ReItwG8nd70NYyu8SVtY8Q7ry0G/g1xg9rL32J7mVYDDkV70ILPnZ+K67wvcxCaVy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=d6k7G3es; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="d6k7G3es"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H7fWgL203566;
	Fri, 17 Apr 2026 04:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=QVRTBpqcBBBGO6vHom71ogGCpho
	fx5FtwxWBaXV8C48=; b=d6k7G3eszKGQlTdpk7cIgHqtS7S7L2U/74FEv0CHld1
	wqpP4WgXSHasXAVIG11cOftk+r9M2avwQ2vFCFCbsRzT7m4f7Or0eDt0fwkwTknc
	U2kc83IYpvTr8acTC1e/Qis3wyBkv3itdVr/2HosyINf4J9PDr32Q4fYEwfnOAEN
	2zYBfkZGFIE43Hy/eQKkhzvQEe1IdUR3u0dvJ2pr92Xxt/phKDrIfKjq1qrCpILm
	aE4aryjmAu2azcpCItFeDcROmVGgtYRPmqg7jmlK8fQG8ki5dNOKAXUhlemMmqcW
	xlBS/lkex8lXPrtt3vzlyhPlJiFLp9RzSNNYGe3Doaw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4djv9acyr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 04:27:54 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 63H8Rr8P010657
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Apr 2026 04:27:53 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 17 Apr 2026 04:27:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 17 Apr 2026 04:27:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 17 Apr 2026 04:27:53 -0400
Received: from ATORRENO-L02.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 63H8Rbia029844;
	Fri, 17 Apr 2026 04:27:40 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Subject: [PATCH v8 0/2] Add support for AD5706R DAC
Date: Fri, 17 Apr 2026 16:27:14 +0800
Message-ID: <20260417-dev_ad5706r-v8-0-ef87dff62b57@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOLu4WkC/33Q3UrEMBAF4FdZcm0lk9+pV76HiEw6yW5AW0mlK
 Evf3bQ3227FyxP4zmFyFWMsOY7i6XQVJU55zENfAz6cRHeh/hybzDULJZWTSsmG4/RGbL10pVE
 gbQRm1VIQVXyWmPL32vbyWvMlj19D+VnLJ1he/+6ZoJGNV1aHwN4gts/U0/twfuyGD7EUTeqGN
 cAeq4qTdjVoDgzhgPUW4x7rii1Lj8lAbBEP2NywkXfLpmLyaAENIVt9wHaL/R7bBZvOe+2Do3i
 82W0w3H2YW29OTLZVkKI5YP8P9styanVdJwJ0OzzP8y+7XNQ1FQIAAA==
X-Change-ID: 20260220-dev_ad5706r-2105e1dd29ab
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
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
	<alexisczezar.torreno@analog.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776414457; l=5065;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=Mav47hscuufzCCAvdd+4tuR8jA9lkL1R1ktHsXl3du0=;
 b=UTLrl1D4P6pyyHW0k7Z40SFVy5dsbrVwWzsbaNhCa6ccdOzsor+QeoQ0t5ckXsK+VkjRPAXJB
 EbDZnCyfymdARj4DFb0K0CvdKmVhD5BvuJx7XwKYsFPU4zA6LlefFk1
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: tFQTWRQVnJxsDlCzzrZ30F0lGWSR0VDe
X-Authority-Analysis: v=2.4 cv=KIZqylFo c=1 sm=1 tr=0 ts=69e1ef0a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=mW3XGZRhfHrgJpV7rlMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA4NCBTYWx0ZWRfX2EVz6Qrvazk+
 KziN4ZzE3N7nEP7BBIXAcVBCmwmHZ+go06R/kKWW6H98teObKjR81XWAtlhoMP4m/93eJHrRLKu
 oGnQt7jYrGvB8Cw3diZrfXYEdPEYzLso+v6gAGje5M8gmy72fthIM9XPjlwc7W7a3X+87snyx3C
 /JEdcD+jJRsoUCcjLQrxjpnZdYgR89HmqgWpYs8UiybhvevOUAX56cLpG7hiRhVevpqkoQxEjC9
 7Fx0+VydhMwoyCATcD2VZ3ysIIppT/ybTfjLRBiFzRMGB4UR0qGPZQZ4zqyl9YVQrwgUayos0/p
 VhfzUOu0IpUb4631wadXH3uR9x2m2/BE/7z21oJDHchcKN+qZkvVLrFGr3JSS/5102CzmFC5UD0
 a+BrJB6Qeyeol1CgBkw1DGemFXqqjwy8VLtQ3681QF1g/ueF1tIqrrXm0pgw2Wkry0kIDpTzkPo
 kz/jXWHwsuvcABXmVuw==
X-Proofpoint-ORIG-GUID: tFQTWRQVnJxsDlCzzrZ30F0lGWSR0VDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170084

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
Changes in v8:
- driver:
  - changed DAC_CODE from BIT(16) to GENMASK(15,0)
  - removed defines for single/multi byte, replaced with number
  - adjusted regmap_write to use if/else similar to read()
  - reverted in_range back to open code equivalent, removed minmax.h
- Link to v7: https://lore.kernel.org/r/20260410-dev_ad5706r-v7-0-af93a4caa186@analog.com

Changes in v7:
- driver:
  - Moved/added size validation before data access in write()/read()
- Link to v6: https://lore.kernel.org/r/20260410-dev_ad5706r-v6-0-f3fda5921fe4@analog.com

Changes in v6:
- driver:
  - Added size validation in regmap_write()
  - Used &st->tx_buf[0] consistently in _be32/be16 calls
  - Added missing indent in AD5706R_CHAN
- Link to v5: https://lore.kernel.org/r/20260407-dev_ad5706r-v5-0-a4c7737b6ae9@analog.com

Changes in v5:
- dt-bindings:
  - Changed out-en-gpios to enable-gpios
- driver:
  - Kconfig: Added select REGMAP_SPI
  - Headers: Removed device.h, errno.h, string.h; added dev_printk.h
  - Use IIO_DMA_MINALIGN instead of ARCH_DMA_MINALIGN
  - Replaced memcpy/memset with put_unaligned_be* for consistency
  - Added struct device *dev shorthand in probe()
  - other minor style edits
- Link to v4: https://lore.kernel.org/r/20260401-dev_ad5706r-v4-0-a785184a8d53@analog.com

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
 drivers/iio/dac/Kconfig                            |  11 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5706r.c                          | 253 +++++++++++++++++++++
 5 files changed, 378 insertions(+)
---
base-commit: 3674f3ca92730d9a07b42b311f1337d83c4d5605
change-id: 20260220-dev_ad5706r-2105e1dd29ab

Best regards,
-- 
Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

