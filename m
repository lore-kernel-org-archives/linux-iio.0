Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB5D3FF1B8;
	Mon, 27 Jul 2026 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155301; cv=none; b=E4sxQ6upnhU8HrYYNn/f70xOj+e7EdvFcZkRh54zD8sbY895oT8nNZI7vGhvfyRq2Lvl728ZWYcwCxli7AaIHJETrTlw6T/Gc5UzkqGqIRpLMq8yqbOoRqcC/70fcLAN0mhMJHacGbp2g66u/73Kde+yChW6bSk7YkDP4Ux+tDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155301; c=relaxed/simple;
	bh=Mbj4w0TDA4+w0y1P2uajyobwOmyRYUIqUhiltOTMV0Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UhjlpA/nHDEp8UJLPz44vpjKd0S0XgmzsH/txs0iIeJuBcQ3Nbm49d6Ih3kkvY1HMlkCc2a3IQ39NqGp7IHt+bBmzPT4uFJ6dG8mplgVBXgSX//XyflwmhfYH6RqjPlDNFi9nSrs883nZ1c8nAwQPkNFYAXnlsDqJyCrkRPKyMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OhY7Qm5m; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OhY7Qm5m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785155299; x=1816691299;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mbj4w0TDA4+w0y1P2uajyobwOmyRYUIqUhiltOTMV0Y=;
  b=OhY7Qm5mrkpr5xS0XclbrO2qQCSu6fDabtDUVGeJfaO+ChPOlUIiVois
   Q5ZCfGB3dKVjrM6PemdB/daIZUlvKx8rZNNfQsU0gsmn/IJyrUvW3ot1J
   UbM/BDpDDD//Zn7rX2eqaDea7zlapQBQhrx56xO6OvJBPyJMcDJL6DNzz
   BAXgHSpvFQpqY3NPmtAlQE4aoR3ovAXvVr3mh+yD5n10eCsXhSym1hZQN
   Uxf3KMFF+nz8JyWDaPsWPE3hIr0qVya6H81XmDz9afykRrLaM5cAEE/YQ
   oJxGEu/Fl0VJ6fG9fPFOYEwAmR/X67J98TG7PxX4U41f9Me/0BQilBlKN
   A==;
X-CSE-ConnectionGUID: YUCQaNk4QbSeoV2azYwxBw==
X-CSE-MsgGUID: lgSZ8HG2QXK0XyLxMkzKJg==
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="70709540"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2026 05:27:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 27 Jul 2026 05:26:48 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 27 Jul 2026 05:26:38 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
	<Jonathan.Santos@analog.com>, <jorge.marques@analog.com>,
	<joshua.crofts1@gmail.com>, <jishnu.prakash@oss.qualcomm.com>,
	<antoniu.miclaus@analog.com>, <varshini.rajendran@microchip.com>,
	<mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 00/16] Add thermal management support for sama7d65
Date: Mon, 27 Jul 2026 17:56:17 +0530
Message-ID: <20260727122633.117435-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Thermal management system of sama7d65 includes:

- Temperature sensor as a part of ADC channel
- Temperature calibration data retrieved from the OTP memory for
  improved accuracy of the readings
- DVFS implementation
- Thermal system with DVFS as cooling cell.

This patch series adds support for the following:

- Tag-based packet lookup for the NVMEM OTPC driver while preserving
  backward compatibility with existing ID-based access
- Temperature calibration layout handling in the ADC driver to support
  different SoC-specific calibration data formats
- ADC driver adaptation for sama7d65
- DT nodes for OTP, ADC, temperature sensor, and thermal zones for
  sama7d65

Changes in v4:
	- Reworked cleanup.h usage: define and assign __free() variables at point
	  of use after early returns, add DEFINE_FREE(nvmem_cell_put, ...) for
	  nvmem_cell cleanup
	- Split patch 3/13 into two: refactoring (layout struct) and tag validation
	- Used struct u32_fract for p1 scaling factors
	- Return -ENODEV instead of -EINVAL when layout is missing
	- New precursor patch to remove unnecessary casts in of_device_id
	- Removed trailing comma from single-line initializer array
	- Moved emulation mode validation into a separate patch
	- Added FourCC validation for packet tags; invalid tags fall back to ID-only
	  access
	- Mentioned FourCC in commit message and comments
	- Used intermediate variable for off % 4
	- Rename tmp → mr_val, val→ tag
	- Addressed style issues: Removed comment blocks, put functions in
	  one line
	- Remove blank line after compatible in regulator node
	- Reorder properties.

Link to v3: https://lore.kernel.org/lkml/20260630093603.38663-1-varshini.rajendran@microchip.com/

Changes in v3:
    - Updated the commit message with reasoning for a new compatible
      without a fallback (sama7d65-adc)
    - Split patch 2/12 into two patches: a patch with cleanup.h changes only
      and the rework patch
    - Added comment explaining the TAG ACST
    - Fixed the holes identified in the at91_adc_platform struct by
      pahole tool
    - Dropped labels in the dt document example
    - Added temp variable in mchp_otpc_resolve_packet() to avoid % and /
      operations in the same instruction (avoiding compiler optimization)
    - Added the SoC details in the ADC driver Kconfig help section
    - Maintained reverse xmas ordering in declarations
    - Fixed node ordering (alphabetically) in the board dts file

Link to v2: https://lore.kernel.org/lkml/20260623105944.128840-1-varshini.rajendran@microchip.com/

Changes in v2:
    - Preserved backward compatibility with ID-based packet lookup to
      avoid breaking existing users
    - Removed sama7g5 DTS changes (not needed with backward compatible
      driver - will be sent later to update to the new access method)
    - Preserved the packet data structure returned not to break the
      consumers
    - Reworked ADC driver to use a calibration layout structure instead of
      hardcoded indexes, for scalability
    - Fixed kernel-doc Return section
    - Removed stray blank line in mchp_otpc_read()
    - Removed unnecessary UL suffix in writel_relaxed()
    - Dropped unused packet types
    - Fixed stray spaces before exclamation marks in error messages
    - Added ASCII representation to TAG macro definition
    - Removed odd MAX enum with trailing comma and refactored
    - Moved DTS patches to the end of series
    - Used cleanup.h helpers for NVMEM data buffer handling in ADC driver
    - Combined multiple v1 patches into logical units
    - Used correct subject prefixes for dt-bindings patches
    - Used fixed-layout NVMEM syntax for sama7d65 DTS and binding
      instead of deprecated syntax
    - Added cpu-supply linkage for proper DVFS voltage scaling
    - Updated stale stride=4 comment in dt-bindings header

Link to v1: https://lore.kernel.org/linux-arm-kernel/20250804100219.63325-1-varshini.rajendran@microchip.com/



Varshini Rajendran (16):
  dt-bindings: iio: adc: at91-sama5d2: document sama7d65
  iio: adc: at91-sama5d2_adc: use cleanup.h for NVMEM buffer
  iio: adc: at91-sama5d2_adc: rework temp calibration layout handling
  iio: adc: at91-sama5d2_adc: add condition to validate calibration data
  iio: adc: at91-sama5d2_adc: remove unnecessary casts in of_device_id
  iio: adc: at91-sama5d2_adc: adapt the driver for sama7d65
  dt-bindings: nvmem: microchip,sama7g5-otpc: add sama7d65 and dt node
    example
  nvmem: microchip-otpc: nvmem: microchip-otpc: add tag-based packet
    lookup
  nvmem: microchip-otpc: nvmem: add emulation mode and OTP access
    validation
  ARM: dts: microchip: sama7d65: add cpu opps
  ARM: dts: microchip: sama7d65: Add ADC node
  ARM: dts: microchip: sama7d65_curiosity: Enable ADC, DVFS
  ARM: dts: microchip: sama7d65: add otpc node
  ARM: dts: microchip: sama7d65: add cells for temperature calibration
  ARM: dts: microchip: sama7d65: add temperature sensor
  ARM: dts: microchip: sama7d65: add thermal zones node

 .../bindings/iio/adc/atmel,sama5d2-adc.yaml   |   1 +
 .../nvmem/microchip,sama7g5-otpc.yaml         |  28 +++-
 .../dts/microchip/at91-sama7d65_curiosity.dts |  27 ++++
 arch/arm/boot/dts/microchip/sama7d65.dtsi     | 131 +++++++++++++++++
 drivers/iio/adc/Kconfig                       |   2 +-
 drivers/iio/adc/at91-sama5d2_adc.c            | 132 ++++++++++++-----
 drivers/nvmem/microchip-otpc.c                | 133 ++++++++++++++++--
 .../nvmem/microchip,sama7g5-otpc.h            |   4 +-
 8 files changed, 404 insertions(+), 54 deletions(-)

-- 
2.34.1

