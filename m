Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2133E368;
	Fri, 10 Apr 2026 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803744; cv=none; b=eLy3vPqnKwEn9Pve8Xt60yRoaMQrf0x3093mAQ6GIi6YdJPBafZH7oMCrIyubxjQU7EKcg9cNdU5VIBaLVVu0+ht3v80s3tdoWlacNTnN9HjiNtnAcdxVooklPivlho0+PwcpMaPdM7QFjDq/TJKzKEUpsrR0aYJkAziumWs+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803744; c=relaxed/simple;
	bh=Xq85+Mga7BpmjnuwBxpzsGLZr7D1SMBO7+wTLLEk6HU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=uTUIioBTuecA7ieon6Xn18VsxnYWYDGrdrMOfYu8pjaqulCcTqNOrN8iB5fMxrb8Gv6REVTHvUGqykqj6+DSgT++ZIa6GZcs3snp1ieyi2RDPD8Ff7O91d0h702TpElXA3h2hj6Fl0UiRyKKR0wiedFePfoMNgR7tPF2Z77KdH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lJaThq1L; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lJaThq1L"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A5Gvml166957;
	Fri, 10 Apr 2026 02:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=jpXuHIiKUEHf6PqYFzbpnWQ4bC6
	h7XXS6yroJiskFXs=; b=lJaThq1LHIM2svyqjFHBZfEkzfcOvEfJbrC9gbzHdHY
	nxEslX1NVeXF9zDimeUtDdMiU7uFFWYUXJq2sNVKwIYBfnpWEyM7rU6S1vOYOK+c
	61x9H6l0EP8SthVRNHhw+q6wnCPeTzmgXwH7UFlsvIB1PCA0a9Io0IAFyAipvYED
	ZpWOTCrV9VPftMjj4aAdn5ANGv5GuYB4qVrTn769qiz5VcNW9a+WtxcuL9BlyvF/
	exo+DPaQyH6n7QVz2ZgKpsr9ZuyFJIk4EiPklTKILZQfN50sYVXfeNS2j97b1iA1
	tg5+EWcOjBv/y9vQNxPluXL1/VDj1A0Mr9wYu/vdIOA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4de9a6ky9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 02:48:46 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 63A6mjsa034825
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 10 Apr 2026 02:48:45 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 10 Apr
 2026 02:48:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 10 Apr 2026 02:48:44 -0400
Received: from ATORRENO-L02.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 63A6mMJ6020190;
	Fri, 10 Apr 2026 02:48:25 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Subject: [PATCH v7 0/2] Add support for AD5706R DAC
Date: Fri, 10 Apr 2026 14:48:15 +0800
Message-ID: <20260410-dev_ad5706r-v7-0-af93a4caa186@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC+d2GkC/23QTWrEMAwF4KsMXtfF8p+cWfUepRQ7smcMbVKcY
 lqG3L1ONpNMunyC7wnpxqZYcpzY+XRjJdY85XFoAZ9OrL/64RJ5ppaZFNIKKQWnWN89GRS2cAn
 CRCCSnQ+sia8SU/5Z217fWr7m6Xssv2t5hWX6f08FLjhKo0Ig1M51L37wH+PluR8/2VJU5R0rg
 D2WDSdlW1AUCMIBqy12e6waNiTQJQ2xc+6A9R1r8bBZN+zRGXDaOzLqgM0W4x6bBeseUWGwPh5
 vthsMDw+z682JvOkkpKh3eJ7nP7VCnRDYAQAA
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
	<krzysztof.kozlowski@oss.qualcomm.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775803702; l=4698;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=Xq85+Mga7BpmjnuwBxpzsGLZr7D1SMBO7+wTLLEk6HU=;
 b=i2930KFYFBVV7rNFRw5Y/F0lcVQtvvycX+mVFJXZFFtNAhfYdcx2UigojHDbIaOYU5PV4AJL7
 vucAJEsja1YB58BE8Hpd6xWVji+lCRB4BvuU2IaAKf8REeR/dqr25Ui
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA2MSBTYWx0ZWRfX6Nz1WXa+tNn+
 vjuFsRVbu0JlBggXBsBPiWJ6hUMAskhz18w06WffCnAOr0wOfc1N1zjXm4rfkOQ9dIEGoCWMlEM
 BRN/AhpnoNuvePFk0sfPZm9Q0rpBzDfogB4ho3gB1EMihhvo4Tan96MJfE24wDJaDT/b72bXzj0
 OsY+uK5HKe/KmFx8Ls/oLRzIRz3EgK0gigqDK2k3G/CM983roBOz2rLBDwjTm8qsHvp4LA1tfn+
 i0SbByfO3ERqhAw8jcR9JJfChxTCAJKvhbT0rFMrs0w9T55/x9CEjSYcEsBGWhL4BmDB8R8w0AJ
 a+VM7N4Nd5gUfBJnREP7KNnXYSUdKfBf2hsDbAdyuEWXgQVssLw+z0rkjeBIGB6i+FhSzDATI2V
 Im9D/g2GkO2gAeepqpQAHDIAxNumQ0luUWakSNkAdW7J6yS049Jo0oQ5dNPiBJkeXysfyOaoSqW
 X4H7L8+skQx8c7jo8mA==
X-Proofpoint-GUID: 5CjUbGoATzkOW1w7pkf8eW6722EsgE6o
X-Authority-Analysis: v=2.4 cv=M9F97Sws c=1 sm=1 tr=0 ts=69d89d4e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=mW3XGZRhfHrgJpV7rlMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5CjUbGoATzkOW1w7pkf8eW6722EsgE6o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100061

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

