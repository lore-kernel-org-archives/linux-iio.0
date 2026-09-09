Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA5576ED2;
	Wed,  9 Sep 2026 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963535; cv=none; b=JE0R9RWqjdoxl/Z+rXtUrekvfUWWIc/sUwrYiGxXcq7fOo8xeoiAbIew4WzuJIyffss3cl+bThv+/3dOgoIhVnNqLSTHswkFRi4jpyCx3M+neJ1Byd7oVLTNWnUP3inULR1IcmDnIGjIATJPKFqWOm9TpsH5vTabzSQZjPw5Bdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963535; c=relaxed/simple;
	bh=IeeSxQ/A4SLYJ/HCLP9thrYiw1w+yAcpgeqwFebHxFk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=cthVZNEniUd7Fd1RpvRv769P0LK9NQXs4TrwEq4YQYzThCB67oEkSU2etb39vm1JOlXnEf82DL/THpb83THo6jmTOl3CFTyXYitWVTrwwqfTmJ3ELIlfvyGG4qrYJTx0aGkAogc2lwjxXd7lGdXi6vcHt2YXwmU3kHZDkI7d/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S3T+hFaK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S3T+hFaK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788963538; x=1820499538;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=IeeSxQ/A4SLYJ/HCLP9thrYiw1w+yAcpgeqwFebHxFk=;
  b=S3T+hFaKRMc+Av++LDz4nGDGJybEc7jL2T/OF9J+oy5p3oYmmGrAzary
   q/0vKkiheHFw/4cCJ/fZGsezP+vwjywaMLfeC8AGoHl8vgHkRHrpC5Arl
   y40tmr30g/zc6A5OGUgAJNv+dIXsu5NrU+pn8OihwXncnxSDC2+hO0V+c
   OZHcAef9jS1ZxZpo6ROqOHR8LTfwUIw2QBJe35PMotrKiLuGaS1uDDnD5
   ajBgnEcqonTfg8SEgpJRLX4sB6UWgt47e8XaNCgS539q3dibycEv7mrXb
   E1wARxNS8VaoooA2ynsRBxWxmvSw/18QN5tb27IzKemDgIaZ9KkQfl8J2
   A==;
X-CSE-ConnectionGUID: JXRD1WX3RSG/o2jJdKt1NA==
X-CSE-MsgGUID: V6P63FxjQHyhvHGfREwP7g==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="63362233"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:18:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 9 Sep 2026 07:18:52 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 9 Sep 2026 07:18:50 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH v5 00/10] Refactor Microchip MCP47FEB02 I2C driver in
 separate modules to add support for MCP48FEB02 SPI driver
Date: Wed, 9 Sep 2026 17:18:43 +0300
Message-ID: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMNqoWoC/23NTQ7CIBAF4Ks0rMXQgVLqynsYY4AOlkV/Qg3RN
 L27tC40huWbefPNQmYMHmdyKhYSMPrZj0MK1aEgttPDHalvUybAQDIJFe3tJGqHhsEtoNP2MQb
 qtBLANHJQQNLllDb+uauXa8qdn1PttT+J5Tb9eDXwrBdLyihi1aDksgZjz723YbSdn4527MlmR
 v51FBN5hyenqZ0yqnRcgso54scpm7wjkmPQgNbcuJY1/866rm85RAYPSgEAAA==
X-Change-ID: 20260625-mcp47feb02_refactor-fa8420ae3282
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788963530; l=4351;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=IeeSxQ/A4SLYJ/HCLP9thrYiw1w+yAcpgeqwFebHxFk=;
 b=nuYIJQnO4emICZh+rPjH0O2OHg7gdjPwQY+FTrhwGaZv+K5+rDXUmtKDKi9ojvA0WNWD5dcwx
 xzme1YVma3TAypafMiNvt6NTbzNIkKf5/5pBcogVw3AKIVl6HfFLjW8
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Refactor I2C driver implementation into separate modules in order to add
support for SPI MCP48FxBy1/2/4/8 DAC family on top of the I2C implementation.
The I2C and SPI devices have the same memory map and supported
functionalities.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
Changes in v5:
- improve commit messages by justifying the changes made
- increase polling time for EEPROM writes
- delete unnecessary comments and extra blank line from header file
- Link to v4: https://lore.kernel.org/r/20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com

Changes in v4:
- remove unused headers
- add missing header types.h in protocol files
- create 6 precursor commits before the refactor patch for handling:
    - comment typo
    - renaming command mask define
    - for an invalid label use a debug message instead of probe error
    - correct return value in store_eeprom_store() for false state case
    - correct channel gain formula
    - read DAC value register to initialize channel data struct field at
      probe 
- Link to v3: https://lore.kernel.org/r/20260804-mcp47feb02_refactor-v3-0-97f8b81f3628@microchip.com

Changes in v3:
- renumbering the patch version to include the first patch submision
- fix review comments device tree binding:
   - change 'additionalProperties' to unevaluatedProperties
   - add else branch with spi-max-frequency in the condition which checks
     if a device has SPI interface
   - correct SPI address example
   - add clock polarity and clock phase properties for SPI devices
   - enumerate I2C devices in lexicographic order from the description section
   - specify supported SPI modes using dependencies
- fix review comments driver:
   - remove unneccesarry libraries and add the missing ones
   - correct comment typo
   - return -ENODEV using dev_err_probe() in protocol probe functions
   - use named initializers
   - move defines for registers and enums from the header to the core file
   - add dev_set_drvdata() in probe()
   - move mutex aquiring from mcp47feb02_write_to_eeprom() to
     store_eeprom_store()
   - write correct value into Vref register in resume()
- Link to v2: https://lore.kernel.org/r/20260723-mcp47feb02_refactor-v1-0-ee59e63672bc@microchip.com

v2:
- include in the same patch series the refactoring of the driver and the
  support for SPI devices, but in different patches
- remove changes regarding review comments received not related to the
  code refactoring
- first version of the combined refactoring I2C and adding support for SPI
  driver
- Link to v1: https://lore.kernel.org/all/20260403-mcp47feb02-fix2-v1-1-da60c773550e@microchip.com

v1:
- first version which did not separate the refactoring and adding support for
  SPI devices (into different patches from the same series)

---
Ariana Lazar (10):
      iio: dac: mcp47feb02: initialize dac_data field in channel data struct at probe
      iio: dac: mcp47feb02: Fix gain field initialization for active channels
      iio: dac: mcp47feb02: Return len when disabling EEPROM store
      iio: dac: mcp47feb02: Increase EEPROM Programming Write Cycle Time
      iio: dac: mcp47feb02: Avoid unjustified probe failure on missing label
      iio: dac: mcp47feb02: correct typo from a comment
      iio: dac: mcp47feb02: rename command mask define
      iio: dac: mcp47feb02: refactor MCP47FEB02 I2C driver into two modules
      dt-bindings: iio: dac: add support for MCP48FEB02 SPI
      iio: dac: add support for Microchip MCP48FEB02

 .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 221 ++++++++++---
 MAINTAINERS                                        |   2 +-
 drivers/iio/dac/Kconfig                            |  33 +-
 drivers/iio/dac/Makefile                           |   4 +-
 .../iio/dac/{mcp47feb02.c => mcp47feb02-core.c}    | 355 +++------------------
 drivers/iio/dac/mcp47feb02-i2c.c                   | 145 +++++++++
 drivers/iio/dac/mcp47feb02-spi.c                   | 145 +++++++++
 drivers/iio/dac/mcp47feb02.h                       |  43 +++
 8 files changed, 580 insertions(+), 368 deletions(-)
---
base-commit: 9c6acc6e6555d34198e45cb0d309569dfbadf929
change-id: 20260625-mcp47feb02_refactor-fa8420ae3282

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

