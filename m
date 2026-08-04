Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533FE45FFD3;
	Tue,  4 Aug 2026 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850200; cv=none; b=qkKVeebDxuxYvtjOjfge/3DDdGe4K57Fq8VuaevPFNr7TE3FQHBEuvwjLk+MpKBPLAayhknJScYzyP2WSuUgmQ+4MKKqiogggdLeeG6H+IZak/gNJAZJuBFyiXwkPbO450u27LlgG05F3KAmNTCv2VN39SPlpPbg6I01RP5IoGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850200; c=relaxed/simple;
	bh=s4gj4uULZM4dmrLq0Q+BFyrBtz1BVx2bE29MH8NZTbI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ZA8ra6wfLX4YK8c1VYjqL3h+fYGVzjLeF7KE3ocv1Y4m9UIB2TQrSK/kV4TiEzYC8Mg/Xro/nAeyamrwmLiU9eg5lr78y4OK7gc4C0dNmRTmSdF7frWs8IgQ9HhWQYM07dhTa4dNfPeCbNiP7gLbtYByWVbS1rveVRlwPX6tzrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=R/4ovfxR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="R/4ovfxR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785850198; x=1817386198;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=s4gj4uULZM4dmrLq0Q+BFyrBtz1BVx2bE29MH8NZTbI=;
  b=R/4ovfxRONKPL0Av5RIMdZn5yIudHxsDcl9baFnSPk+pdXVLcpkG4axC
   Kuxks5vWz/cl7h1z/VdaU8JPyM2QGyMnMJqj43dG6DPb1WcZt8ENDbQZZ
   ctslLPvJXYbV6o79LyYRH5eGrcdYCM/wA05rAZgg4IfQyYNU6xnJ77MXH
   jfYuzbnv+VG3Zqif0coRHKA7eX4KeKH1vrdJjNkam8HK+GLKK47rzN2he
   dtme8vcGb1ts3kv0x7TT/Py3LH214VbGd0QGwRGQbIonaShdq1TnJJXrT
   5ePfjYi4Mv+n9SuTf5dXEVTzv9yIVQjbihDnHBJkSEw5Hd0Xki4mFinAc
   w==;
X-CSE-ConnectionGUID: PdyIKO/KRqmtC5pL79kSSQ==
X-CSE-MsgGUID: FLM0HkANSveIbciXI2iLmQ==
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="61938335"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2026 06:29:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 4 Aug 2026 06:29:56 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 4 Aug 2026 06:29:53 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH v3 0/3] Refactor Microchip MCP47FEB02 I2C driver in
 separate modules to add support for MCP48FEB02 SPI driver
Date: Tue, 4 Aug 2026 16:29:46 +0300
Message-ID: <20260804-mcp47feb02_refactor-v3-0-97f8b81f3628@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAErpcWoC/22NQQ6CMBBFr0JmbU2ZQkFX3sMQU8ZBZgElrSEa0
 rtbcevy/fn/zQaRg3CEc7FB4FWi+DmDORRAo5sfrOSeGVCj1RZrNdFSNQP3Gm+BB0dPH9Tg2gq
 1Y4MtQl4u+SKv3XrtMo8Sc+29P1nLb/rzNWj++tZSacVcn9ga22BPl0koeBplOZKfoEspfQDyn
 NgaugAAAA==
X-Change-ID: 20260625-mcp47feb02_refactor-fa8420ae3282
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785850193; l=2975;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=s4gj4uULZM4dmrLq0Q+BFyrBtz1BVx2bE29MH8NZTbI=;
 b=H7T/YaOMWpzQE9TwnIq5L7B/mHG922Vb2Lax73So9neaGAPoMPkLVJU8xuknZkvSvBVeYdGF0
 +J4pKxP2O2uACGi7hAg+OdLF+qh495I+I9h6EBrVb0EMVigu2afOU5j
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Refactor I2C driver implementation into separate modules in order to add
support for SPI MCP48FxBy1/2/4/8 DAC family on top of the I2C implementation.
The I2C and SPI devices have the same memory map and supported
functionalities.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
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
Ariana Lazar (3):
      iio: dac: mcp47feb02: refactor MCP47FEB02 I2C driver into two modules
      dt-bindings: iio: dac: add support for MCP48FEB02 SPI
      iio: dac: add support for Microchip MCP48FEB02

 .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 221 +++++++++++---
 MAINTAINERS                                        |   5 +-
 drivers/iio/dac/Kconfig                            |  33 +-
 drivers/iio/dac/Makefile                           |   4 +-
 .../iio/dac/{mcp47feb02.c => mcp47feb02-core.c}    | 336 ++-------------------
 drivers/iio/dac/mcp47feb02-i2c.c                   | 144 +++++++++
 drivers/iio/dac/mcp47feb02-spi.c                   | 145 +++++++++
 drivers/iio/dac/mcp47feb02.h                       |  48 +++
 8 files changed, 576 insertions(+), 360 deletions(-)
---
base-commit: 9c6acc6e6555d34198e45cb0d309569dfbadf929
change-id: 20260625-mcp47feb02_refactor-fa8420ae3282

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

