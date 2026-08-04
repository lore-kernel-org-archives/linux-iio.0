Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD430F815;
	Tue,  4 Aug 2026 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843241; cv=none; b=Dxg1iVKcskx0aRSEjkXBdL/NgrXwAiymNSw7grEtYVavJdiB4IANTNr2HjRIzNF1OFIH33JsOaTrtywkNiV++KH737GINTArb3TuXpEV++EtZmDjsh6YxK+t24aZO3QV8IrKg9HSBwcOVBuA+45iBfDbMb+4+eoO3O9UJc6x6NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843241; c=relaxed/simple;
	bh=WhoNM5O54DFe0bcpJqMEJUCNtmQOlrahFXQNiszOq7k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NgYSvjNUgya6ZFLKWqDsJdIc55HYR/3xMuoBv3A6Kef+i/TeCZZx2pNrXTlfmAkweuJMEIeNuN3oeouhILSLszYJnhMmr0FBP9Ok0T1UG1hTprRxsBiEwpPviUAjZGFAi7oIzXtEV6xeqj3MrVMKb+yOxamRTKJPYH3pOSI13X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HNzZU534; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HNzZU534"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785843239; x=1817379239;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WhoNM5O54DFe0bcpJqMEJUCNtmQOlrahFXQNiszOq7k=;
  b=HNzZU5342JJMahqw+zk+G50zZuLtLTzKEI1CFkAzghjPhqmKpgAg0lP6
   ypX8xFjfl78CCF2S6zZksgE/C3qu7bEmmMDHFapKTusmX+ay2a2Zspt3y
   AtGX66jBk8QBdZtoo67TImbibvn7rsaUHJgeBgTOB5a8LvUMqpYYD1fvh
   UZFogAiAOXSzjz1+Ch8jjL9oFujN3eMZaaHU5Z+/jSq06JsXAjRTvFw8Q
   ZNhx+zRFWhbe+IARU8zUeXFTlBIsqJMbyFjANwf+8g59Ts4qowj7+LYwZ
   cW+LWjMrkDlI76cOnjq6vPEhFbd66y6S2yKiS5dpwde2g7llpcJ3Lu6Qa
   A==;
X-CSE-ConnectionGUID: 9OftkTBlS/C8UOwtVzj6mA==
X-CSE-MsgGUID: w1jY0Ep8Sqy8R7p66x0HmQ==
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="228765730"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:33:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Tue, 4 Aug 2026 04:33:51 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Aug 2026 04:33:41 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
	<joshua.crofts1@gmail.com>, <jorge.marques@analog.com>,
	<Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
	<antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
	<mazziesaccount@gmail.com>, <varshini.rajendran@microchip.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 00/17] Add thermal management support for sama7d65
Date: Tue, 4 Aug 2026 17:03:21 +0530
Message-ID: <20260804113338.261782-1-varshini.rajendran@microchip.com>
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

Changes in v5:
	- Placed the DEFINE_FREE helper in the header file and added it as a
	  new commit
	- Added IS_ERR_OR_NULL(_T) condition to the DEFINE_FREE of nvmem_cell_put
	- Reorder signing tags alphabetically in Patch 1
	- Kept the changes minimal by retaining ret variable
	- Collected the Rb tags

Link to v4: https://lore.kernel.org/lkml/20260727122633.117435-1-varshini.rajendran@microchip.com/

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

Varshini Rajendran (17):
  dt-bindings: iio: adc: at91-sama5d2: document sama7d65
  nvmem: add DEFINE_FREE for nvmem_cell_put cleanup
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
 drivers/iio/adc/at91-sama5d2_adc.c            | 124 +++++++++++-----
 drivers/nvmem/microchip-otpc.c                | 133 ++++++++++++++++--
 .../nvmem/microchip,sama7g5-otpc.h            |   4 +-
 include/linux/nvmem-consumer.h                |   4 +
 9 files changed, 404 insertions(+), 50 deletions(-)

-- 
2.34.1

