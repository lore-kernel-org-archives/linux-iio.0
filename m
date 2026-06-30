Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22903A5E96;
	Tue, 30 Jun 2026 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812205; cv=none; b=D9vsBDVYqENaF1imuAgwDoT/ncJAHq5zf3kOtS1No7Qn/vuyqaF3yVYPt+E3GGyB0TfcJm1lBDXs5hiQChu+jKFM/KxUh8iKv25+nFbPyOA9SvkhDIHNc+Z7HGpKVvOmOEignwUxW4R2dTRlft4ObFxALWvrymGHL+keyfyRlH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812205; c=relaxed/simple;
	bh=FZE4CPg/qJMGupldZG/zeGreh5nkdeglG68xe9wJgYM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YkcNLRMfQSskttkLhC/Rd73ItlL5R2KNES6LxdDIHNa07i/+HWyTcYpZuFflMg49JzWp1RjMYIzXC+F++R5Bj4pA60NMGCQUIlmhTAtQI5YD75AFuyJwoT3uDeWyenYPe3l/VQa5YOEM6VHKhP8JMP3gxHZT57sYFBIocyECC1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=V6xedLTO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="V6xedLTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782812204; x=1814348204;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FZE4CPg/qJMGupldZG/zeGreh5nkdeglG68xe9wJgYM=;
  b=V6xedLTO1A96ubO8xyiZo4YAVXl4lCi5qdBUS36znYMsGkXYEBTHM5go
   6LVH7L+fj8pa8I8fX7UHqhzBv9V1QiaCbIQg/kAZlkyYz4A+GORvWHhUs
   cuf1z94axC0reHi+MQaATpLDHJ5komyQNKvW8kHO/Zf3kRlzC5aNGgVpJ
   +bQ26Z+TTP65oe3ZGOvdRPtv2IeNYa86NJfYwbtBHJK4SuWsFAtesL3Ti
   oZiXbwezpk7NKoJkD9H9x0JMn9IDL5GvxkcCfcodItP1DDPxOlQOOF2EI
   VTgB1eKNNU3XDk76cHXiKtQXDWDeRQnn1F1AEHYtNRS+8JjpS+5lR3OJu
   A==;
X-CSE-ConnectionGUID: 0YiqncY4TzChnLACOe4sug==
X-CSE-MsgGUID: CGyrKFI/SUybos5pn+9KNw==
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="60234245"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 02:36:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Tue, 30 Jun 2026 02:36:42 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 30 Jun 2026 02:36:34 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <jorge.marques@analog.com>,
	<mazziesaccount@gmail.com>, <Jonathan.Santos@analog.com>,
	<jishnu.prakash@oss.qualcomm.com>, <antoniu.miclaus@analog.com>,
	<duje@dujemihanovic.xyz>, <varshini.rajendran@microchip.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/13] Add thermal management support for sama7d65
Date: Tue, 30 Jun 2026 15:05:50 +0530
Message-ID: <20260630093603.38663-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The thermal management system of sama7d65 includes:

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

Varshini Rajendran (13):
  dt-bindings: iio: adc: at91-sama5d2: document sama7d65
  iio: adc: at91-sama5d2_adc: use cleanup.h for NVMEM buffer
  iio: adc: at91-sama5d2_adc: rework temp calibration layout handling
  iio: adc: at91-sama5d2_adc: adapt the driver for sama7d65
  dt-bindings: nvmem: microchip,sama7g5-otpc: add sama7d65 and dt node
    example
  nvmem: microchip-otpc: add tag-based packet lookup
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
 arch/arm/boot/dts/microchip/sama7d65.dtsi     | 132 ++++++++++++++++
 drivers/iio/adc/Kconfig                       |   2 +-
 drivers/iio/adc/at91-sama5d2_adc.c            | 119 +++++++++++----
 drivers/nvmem/microchip-otpc.c                | 143 ++++++++++++++++--
 .../nvmem/microchip,sama7g5-otpc.h            |   4 +-
 8 files changed, 413 insertions(+), 43 deletions(-)

-- 
2.34.1

