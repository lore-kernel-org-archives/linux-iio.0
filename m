Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22A2D7DE9;
	Wed, 19 Aug 2026 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143280; cv=none; b=jq5vCgrUA01W3aDrR1mnKsMpInxXvd+SiGb91mOgXfcnCk4w8mlH7f+1vYiKGy6Ii0C9dMhjOQoJ9/jjkJg9NFU1yctLA9SuoN/CSpuEQC25/6nmWB4CIvp5h090qrTwvN9q8kD9dp3lOBtR5R7RD0/LEwCmJByQ3rsZYuHfsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143280; c=relaxed/simple;
	bh=uelLXWxc5qfCzrF4vdIOYmh2PfFcuyjKbyphe9ex7yw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Hn9oykLkpn3vnCcRPb4C2MyP4SZc+5ApiObImn8uwAbdH0e2MBfOxjirYVQDZ7wniIuPUSl4E5c5hW/ub+2874QCGB2vi76tjuQ7tYNZHIA63cRZz2snLfVK1SO7mdKj7u72N2a4xVjqh2F6wuFNR3ui3TYdXsCpMm93w5zSL6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zeewO6qj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zeewO6qj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787143278; x=1818679278;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=uelLXWxc5qfCzrF4vdIOYmh2PfFcuyjKbyphe9ex7yw=;
  b=zeewO6qjIuh1l6rxeIf60ndNV7jKDZgIR7INsj8S98R9ye5Bab2EOPug
   vA805kaYBe4G+8/Rw2qkf5+wG/S10yHNCxmpUTV2WkDzHF22QyBgjQU0f
   YzSy20ihfwTaV+oyZYvxZkefibEJuLJ+z5EZCP2uAOSLLKmXva8Izx82k
   qWbPSIh1xnUqmAEwpRCnmBdcUxitK0oIMGE1Wi2iaHGYU405Qg878LNYw
   ERLfkEFtKx7jEioz0KUzCpfxv7UGaX7UTb5nXPxmLXwu7g7Jp/OCQG+do
   HmUfoKymbfvGObg52Zci9BdZKH0p4zuYJrLmj4wSRV0BDDtdqK2FdZz+V
   A==;
X-CSE-ConnectionGUID: Rpl1R+AoR/WsVpaitTVQqg==
X-CSE-MsgGUID: 8ALx93kIQq+Cr+p9Za8p7A==
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="61462181"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 05:41:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 19 Aug 2026 05:41:12 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 19 Aug 2026 05:41:09 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH v4 0/9] Refactor Microchip MCP47FEB02 I2C driver in
 separate modules to add support for MCP48FEB02 SPI driver
Date: Wed, 19 Aug 2026 15:41:04 +0300
Message-ID: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGGkhWoC/23NQQ7CIBAF0Ks0rMXQgQJ15T2MMRQHy6KlAUM0T
 e8urQsT0+Wf+fNmJgmjx0RO1UwiZp98GEsQh4rY3owPpP5eMgEGkklo6GAnoRx2DG4RnbHPEKk
 zWgAzyEEDKZdT2fjXpl6uJfc+ldp7e5Lrdfr1FPBdL9eUUcSmRcmlgs6eB29jsL2fjjYMZDUz/
 zmaiX2HF6dVTne6dlyC/neWZfkAST/iRwIBAAA=
X-Change-ID: 20260625-mcp47feb02_refactor-fa8420ae3282
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787143269; l=3956;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=uelLXWxc5qfCzrF4vdIOYmh2PfFcuyjKbyphe9ex7yw=;
 b=HZaj5WRrz4mq+FiXejWA4m/GCUEBdsbSEzsjXkmz+B0WmmZyQPDVr6vtN7Yv/5rUbmtYqIspj
 ioNoTrDdQgyAPRJ7sSCd7cdGmvzLhASjb5vKDR2dO91sAufkrMncxRx
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Refactor I2C driver implementation into separate modules in order to add
support for SPI MCP48FxBy1/2/4/8 DAC family on top of the I2C implementation.
The I2C and SPI devices have the same memory map and supported
functionalities.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
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
Ariana Lazar (9):
      iio: dac: mcp47feb02: initialize dac_data field in channel data struct at probe
      iio: dac: mcp47feb02: correct gain bitshift at probe
      iio: dac: mcp47feb02: correct false state case in store_eeprom_store
      iio: dac: mcp47feb02: use dev_dbg for invalid label
      iio: dac: mcp47feb02: correct typo from a comment
      iio: dac: mcp47feb02: rename command mask define
      iio: dac: mcp47feb02: refactor MCP47FEB02 I2C driver into two modules
      dt-bindings: iio: dac: add support for MCP48FEB02 SPI
      iio: dac: add support for Microchip MCP48FEB02

 .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 221 ++++++++++---
 MAINTAINERS                                        |   5 +-
 drivers/iio/dac/Kconfig                            |  33 +-
 drivers/iio/dac/Makefile                           |   4 +-
 .../iio/dac/{mcp47feb02.c => mcp47feb02-core.c}    | 352 +++------------------
 drivers/iio/dac/mcp47feb02-i2c.c                   | 145 +++++++++
 drivers/iio/dac/mcp47feb02-spi.c                   | 145 +++++++++
 drivers/iio/dac/mcp47feb02.h                       |  46 +++
 8 files changed, 585 insertions(+), 366 deletions(-)
---
base-commit: 9c6acc6e6555d34198e45cb0d309569dfbadf929
change-id: 20260625-mcp47feb02_refactor-fa8420ae3282

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

