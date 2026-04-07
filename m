Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DD5372EC3;
	Tue,  7 Apr 2026 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775533229; cv=none; b=AylOEkFwWrOvWDkxXdxS9F3SpFOT36avmlRSLcRRgLjhMsJMGErPIS6n7m1mvThU3hkLJy03Sd2ytkEsgsQkiUWLDprnt2x78Z17RsXU33jlor/+cfqJIZdjJ9y/oftC9Q5cOmPJtzd3Sqx9DSxv2ZbefZ/RHJQfsg9E5IUsy0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775533229; c=relaxed/simple;
	bh=25/HGg5paECWzu1TKe8NdLevv4JpfFzCUt02sDlK51c=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=if1d8Fk7FgMb0oTZPa9oab0qrwS61OvRCnmOocAPJHPwjLGX4p9J4yciG0tS4DLapBN/ys2iO09yQlA/BYfnJbj9hDwb6Gekw6lObmGjwrt5Adbo6leVCN9BYFxftxifIXC8vi4lbG6s6yL95JPMRMbyzLwoBN3TG5fJWndm/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GSt9dGfa; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GSt9dGfa"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LT9g74007668;
	Mon, 6 Apr 2026 23:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=D+REGdZqlU+9ZZ5jL4r433F/55J
	b1tdQD9N9T2I5s5E=; b=GSt9dGfa6QqWjNoBQPXijEJUuHXIvpGQLo/PqfFyM+X
	KKpr7vCwYXCPd2QpSul/0V9qzz00IkPk0eR/kHaRm8R8xamkr9qtXFuFGHi9PTLp
	mBk0DDaDvDI/XoTJQNAA5etgwGp3ll6MVe8bYRu/A5Sc1J5yyS5xOgjs8rk4smk8
	huOJG8T+D0EZsVkn3nJmOVw6IoFKPm1aehgCzK2NZZEn6zxKHKe0n2ebPZs6U8IR
	kNsT6pmW178tDs+3ik5QZknn/eqkrTwap+dEDV1XPkwu+DhZUGsbrAQgLNlWwRQw
	eiEdKtfZo67Avv7tw3sjjCtNP7NF/gw4P98sNP8lENw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dcmsn90m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 23:40:10 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6373e9NV018033
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 6 Apr 2026 23:40:09 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 6 Apr 2026 23:40:09 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 6 Apr 2026 23:40:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 6 Apr 2026 23:40:09 -0400
Received: from ATORRENO-L02.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6373dsE3012886;
	Mon, 6 Apr 2026 23:39:57 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Subject: [PATCH v5 0/2] Add support for AD5706R DAC
Date: Tue, 7 Apr 2026 11:39:43 +0800
Message-ID: <20260407-dev_ad5706r-v5-0-a4c7737b6ae9@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH981GkC/23NQW7CMBCF4asgr2vkGdvxhBX3qFBlZxyw1CbIq
 SwqlLtj2EBIl/9I35urmGJOcRK7zVXkWNKUxqGG/diI7uSHY5SJawtU2ChEJTmWL8/WqSZLBGU
 jMGPrg6jinGOfLo+1z0PtU5p+x/z3GC9wv/6/U0Aq6dDqENgZonbvB/89Hrfd+CPuQwWfWAMsM
 Vbc66aG5sAQVli/YlpiXbFl5ag3EFuiFTZPbNTbZ1Oxd2SBjCe2eoHneb4Bej7THF4BAAA=
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
	<alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775533194; l=4243;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=25/HGg5paECWzu1TKe8NdLevv4JpfFzCUt02sDlK51c=;
 b=E/s63L+9UPIrtz12MiqvdQrWHHLJqy1Vm6WS0FYedPluLxA76bHSD3Nv6PJx4PoWisTzE2oUc
 gbmFebRScclBo8iB6I3LOzsBiyTdNCI7onSxKOjkwUnWpBum9hQzODW
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAzMSBTYWx0ZWRfX0cepsaI5gnUB
 U27EJCPTPR/Q7+buX1n0TiuG1e9d0jIAnvhBTP+pkdbRkUNqOxdlq2FexBH2rbfM5MJZjUkdvY3
 ztZ5IRtRxSLlVo6ZCIiWudP3O1wgEfL6rKWcP71MFIl70ghCGUVD3mnEBQY2EQhuCja0DsCOvDR
 eUPmELfefVL4m/EvA+Nmb6ZLr3HgtaoG9n9tauHF2Cn+MwDWaCP+yA5RCAMIKhyno012JT4dzWV
 GKx27JHyDIeue7SEdGDfU5VwRwCsHgRrwi2oYzGMi+4NRyjWk8oKS5ixKG0Zp4t5Cs2CAP6Wwzl
 QYRKydu4mlYmUg0AI6JWf1i/9BV/0JlQgwPKSxm7d/Rks4Pb/yfwihNIQvcjKXJBDLpYWOEnI6L
 CAGjgutlKrhK2FJT03Y4+CC/FbhYp8f+xfFflq7tOjqvg5dRYGoHg4sPFGuZQLLQEX6ILQwP2Lh
 H2KqD9e4ro1u2qKA2BA==
X-Proofpoint-GUID: zHofiqdeNOTXNJQKLA2z_66P2SvCIvNK
X-Authority-Analysis: v=2.4 cv=D6Z37PRj c=1 sm=1 tr=0 ts=69d47c9a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=0-cXXb6a0YcU21gm4QIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zHofiqdeNOTXNJQKLA2z_66P2SvCIvNK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070031

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
 drivers/iio/dac/ad5706r.c                          | 247 +++++++++++++++++++++
 5 files changed, 372 insertions(+)
---
base-commit: 3674f3ca92730d9a07b42b311f1337d83c4d5605
change-id: 20260220-dev_ad5706r-2105e1dd29ab

Best regards,
-- 
Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

