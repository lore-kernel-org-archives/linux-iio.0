Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443F2874E3;
	Fri, 10 Apr 2026 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775784888; cv=none; b=g3IceG0HOwLmWhlrerV2GYs3MM+qxlHOzAOePi6ksSZ2rqWSapec4qefeHWo+Paq3lNThBiTaMNYxC9DgHmgaugsl52WmGXhrf+81Gj7kG4+yoGujDI3Cs2JPXSVxcjXqwBmPuxy+uc0T3eBYv2sHWoXUDwF2013vOb0hUt9Jlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775784888; c=relaxed/simple;
	bh=hOc4PwrsKQS5ARuCckj/J+nZNz8/bd7CDQocapXSOLA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=nF6bFlBE4NBR9uADWpdMGhE1q0reoVIScofhI5mxIz9QlEcylyar2MMmc43Mwvmk+nuUBnSwtXR4DUSwWRbKOejYpj/iicv+H46XNBuuhLuvcYr+o6oZt6EVqYf9ZtCKaBhw5aWFUq3CCsd6MpT+nms6v764bBEU5D6j8Efx0B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lGOw/swa; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lGOw/swa"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639LHXul3601143;
	Thu, 9 Apr 2026 21:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=5Zb/qiZEwXn7ef2HhjNh5xIsfOv
	1gW329iMzFYQk0zg=; b=lGOw/swaTVlc0zD6HZoY2OkLqvMIHCkp/EUdPa+VnAE
	BU0RsxkxsubIsxSkMFDbFcjpOWNKxIo6Vixp3YwMA7JrIK8shD4HRvuVjpgOA/sG
	8Op08VCxn+fililK6x/mIluzMJDx4YYA38jvy+3eMtC+EOCMUs3Y2WK+WC7htaGf
	PZ/F8jwd/0pPdQ9/s2WfDiQcZFyz2PoCC+ktepoc5T0ebhGlGhXc3l3ZGjidY87f
	Ayzd9fMUVk4aM4RM7y7REoiqP5ct87kakYSFJQ9xIe7sbJbetw3DxcKJ5BYJwPG2
	n7LhBw3gjTBLH3I06cRwl33//INwsVDcQwxEjyVSn0w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4deedp9we9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 21:34:18 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 63A1YHNQ063926
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Apr 2026 21:34:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 9 Apr
 2026 21:34:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 9 Apr 2026 21:34:17 -0400
Received: from ATORRENO-L02.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 63A1Y1Mu001222;
	Thu, 9 Apr 2026 21:34:04 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Subject: [PATCH v6 0/2] Add support for AD5706R DAC
Date: Fri, 10 Apr 2026 09:33:54 +0800
Message-ID: <20260410-dev_ad5706r-v6-0-f3fda5921fe4@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIJT2GkC/23PTWrDMBCG4asErauiGf2Nu+o9QimSR04ErV3kI
 lKC7145m8R1l5/geQddxZxKTrN4OVxFSTXPeRrbcE8H0Z/DeEoyc9sCFTqFqCSn+h7YeuWKRFA
 2ATN2IYomvkoa8uVWO761fc7z91R+bvEK6+v/nQpSSY9Wx8jeEHWvYQwf0+m5nz7FGqp4xxpgi
 7HhQbs2NEeGuMP6EdMW64YtK0+DgdQR7bC5Y6P+XDYNB08WyARiq3fYPmK/xXbFpvde++hC2v5
 5WZZfobEBVpsBAAA=
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
	<alexisczezar.torreno@analog.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775784842; l=4508;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=hOc4PwrsKQS5ARuCckj/J+nZNz8/bd7CDQocapXSOLA=;
 b=Wh1fkCNzIY8j53p9/ZdRPlChhzPmdYYPDpeUwMGIq6MRRdjnrrn8IkrWD0JPnYl8r82e7gMEO
 D3j2evkVbeqCA3E9HZoZRyaioXckF4GwbzM9QFSxd3hqsjf+dONuNij
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=O+8Jeh9W c=1 sm=1 tr=0 ts=69d8539a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=mW3XGZRhfHrgJpV7rlMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: A8I95ZsrwM87PJhejUs-CTuWbQ_0o5gx
X-Proofpoint-GUID: A8I95ZsrwM87PJhejUs-CTuWbQ_0o5gx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDAxMiBTYWx0ZWRfX6UadSdnEg9vH
 nHnRyJu0WpIGGEdM2PJcr8PGR8KXbY87Uxe19IWdUbo0/iuzeL4yYpDWtTz/Mhvw5P/J2x8jTZz
 BJ3mLA83tO3/stxCP42IKozYHccMflGeoK4KDXVB0yUB377dbsP405ZehqEmY+zJ0cgED8/Thx8
 QJH8S5cuHInyRx5UPvqrL0/b+VdNHAenwsuyFKWgGGdXjbqLSaqhh0YLg2SadoPQOWR5eI5Gna2
 TL9soUeYE2P6r8yyHpuzMNQHrpwajccj4kWChXU2NVct+tfD1o5XCv4CyKYmSGuBf7+TL6j38vP
 NcRMj46MvcSr0yNDRptqqPjXwihu6zLfPCb//cVR04Jwkn5fChaODdXFNtXk4Kq4dcG4RCq9tW8
 OG7Fen7DnbgbtNRTSWGCxbun35bRUvXhi221njr3jFI31Lx+2n5fBUIjfym7uy+Xh+hDm5ipDLK
 EnuJav54c1m+WMiti2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 impostorscore=0 phishscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100012

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
 drivers/iio/dac/ad5706r.c                          | 250 +++++++++++++++++++++
 5 files changed, 375 insertions(+)
---
base-commit: 3674f3ca92730d9a07b42b311f1337d83c4d5605
change-id: 20260220-dev_ad5706r-2105e1dd29ab

Best regards,
-- 
Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

