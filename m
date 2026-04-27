Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920C36C9D5;
	Mon, 27 Apr 2026 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777271054; cv=none; b=eEKB26JRpvSA1OOdSuh5+77/1Iw5AA8a3JUK3uWqWXn0/CxsrtCwseq0z4vY5XNehRA+H3qBrLfB7/7mgS0mMhm+iYsCZBpxvbQJtdRYzPDSgkgr8+KXTGIVIg4KeQKv9bskaSUeIwNm/XbzoWUAo6vN3hq5Js0Az4VfjJwtTU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777271054; c=relaxed/simple;
	bh=17CFkMwFXfA31KBtYCE5b7wCuOhrne/jlcZ2aYj2iF4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=XN0f5wR4b2jyGW0yaOrZrs6ZH086ZGC8u61WriR4WRMDv6IiB3m239BHgdoResabIHqEbt475ssiZUHPjtTBUWYLVHiGNQ7y/gukgsLBTEw2rmQ7OhHwKSxr6ES1hCzQCQy20ChmePFn54DKcEOaAABA25OqoXcP6AAfQGqXrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VicvbeAK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VicvbeAK"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R40omY670516;
	Mon, 27 Apr 2026 02:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=DK/CyQalK7IKwOP91hsHREj5eVW
	O8LnoHE/sK5d62fw=; b=VicvbeAKbczyGQBUCu38US8KNJd3iratDEMeDBy6ZVF
	T76FHOZY+xPprTFcxoLVb4VLK0MQxn51o+OWPL3BcBXoHuCnDMNLX9m8tEjzd7kI
	2LzZ+nx13C3XRBK7ZQ2phivGCqlJHqaheIqBgGQsLkU3J7YbgNpsnJ11HpSS6hLp
	bLZ4XVQIDDzxfolCG5mUHJf/8FQ8uVSguku66eK7xUjwtZA/1Y34tECQwgez8uHS
	cb3wpIkK/abUsBBdLgM2hO3Xh6HST/BgwDAsZXT8yBJvwdMHM5cRPnXtMk+1mQHp
	H4yMgMsIuYll+neqrnzxqpWqzSrPO6RSt/JqDxQrrzw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dsbxcuccs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 02:23:42 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 63R6Nft2018250
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Apr 2026 02:23:41 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 27 Apr 2026 02:23:41 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 27 Apr 2026 02:23:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 27 Apr 2026 02:23:41 -0400
Received: from ATORRENO-L02.ad.analog.com ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 63R6NNiQ013659;
	Mon, 27 Apr 2026 02:23:26 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Subject: [PATCH v9 0/2] Add support for AD5706R DAC
Date: Mon, 27 Apr 2026 14:23:15 +0800
Message-ID: <20260427-dev_ad5706r-v9-0-a8e4cae499d7@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANMA72kC/33Q3UrEMBAF4FdZcm0lk7+ZeuV7iEjSSXYD2korR
 Vn67qa92XYjXp7AdyYzVzHFMcdJPJ2uYoxznvLQl9A+nER38f05NplLFkoqJ5WSDcf5zbNF6cZ
 GgbQRmFXrgyjic4wpf29tL68lX/L0NYw/W/kM6+vfPTM0skFldQiMhqh99r1/H86P3fAh1qJZ3
 bAGOGJVcNKuBM2BIVRY7zEdsS7YskRKBmJLVGFzw0beTTYFeyQLZDyx1RW2e4xHbFdsOkSNwfl
 Y7+x2GO4O5radE3vbKkjRVBj/wbhOTq0u070HchWmPb77NhUcEyGn5FSweMDLsvwCB2RjflICA
 AA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777271003; l=4539;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=17CFkMwFXfA31KBtYCE5b7wCuOhrne/jlcZ2aYj2iF4=;
 b=9qwp1/+pad1gnvjc8MgdsXWyC/ckFGybjn372317tZcvb0YsAF8gwqg4ONy2LmBVd2LInJieN
 TXbaimyIEQuAcGTDRw0mcHgTfkllvdGoy6o1bmqV/AVBqdp7kbCSPYo
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2NiBTYWx0ZWRfXwh8RXhkBGO+S
 LkV1ocxqGfJrV5yOYcLwbhS2YwFeO4i/dKYsR5KgYe3//Gy6TpRafRV8LoPK1aAtQkZQuN59DB4
 Kgg7iva1Pq26hJai4IOplNYDoVeKaGejsm48cZe92Wx/kLtslORw3614DyqPF0JruBOIXwvb7bi
 6I10tTE0z886I0WOxpRYTuhTvAHK4dwMWv2WUnVrOgD6XXOXxS2VLUgLbR8G8z95bCndWtqDK5p
 ZwwQGG1c/ubmhtAtPI7q6urdZm0BOQiyl3q2R6yZc0HDRNbF93U5C2pfRTYmOEKM1CAIxxfODvn
 qe98c9MNPgFXC2ptYB08/JNLc6zUPt0PZj6FCsChZiQZIx9ytFzuSmX/72NLIAzMPjawazQGeUU
 8IQimfB1DByidrGXugk7I/De9BwAPo8bPn2aYOPIzrnfr47V8Ps+p/GBfOgRalf2+Gt/q9ORxl3
 1x13PtXQXAR0KAqdVOg==
X-Proofpoint-GUID: WXfnyAGF5Zenb5JOw6CKm4vYvrvzVUwJ
X-Authority-Analysis: v=2.4 cv=SbjHsPRu c=1 sm=1 tr=0 ts=69ef00ee cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=mW3XGZRhfHrgJpV7rlMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WXfnyAGF5Zenb5JOw6CKm4vYvrvzVUwJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270066

This series adds support for the Analog Devices AD5706R, a 4-channel
16-bit current output digital-to-analog converter with SPI interface.

This initial driver provides basic DAC functionality through standard
IIO interfaces.

Datasheet: https://www.analog.com/en/products/ad5706r.html

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
Changes in v9:
- Kconfig: changed REGMAP_SPI to REGMAP
- updated cover letter and driver commit message
- Link to v8: https://lore.kernel.org/r/20260417-dev_ad5706r-v8-0-ef87dff62b57@analog.com

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

