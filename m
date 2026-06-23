Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7406C3D1ABD;
	Tue, 23 Jun 2026 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212403; cv=none; b=JEoyaWf+Y5s1k9Nawl+PGWKzyZjuFPcZZKH/PVURPYMp206hYZJUVg8Tmshl81QmpCM+RXPu8jIlEKZUSlQsFhH2eTQpUmddDNJfDTntFRWx/Gq/cpl+rDqUr1M/5dFVH/z58wrjoTltkZGxj+MlNNSlP3T07Q+ZL6Q7LH9SS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212403; c=relaxed/simple;
	bh=yHO/2t0Hb5A0w4vjeAuH+yDbJ1lP178mmCNx5z6M//k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lSDa2yn3Cqcn0P8BEpHZxwNs7QAbt4P12Aj4sW25w4UJAz1tkb3ALHLckqgo+8FmIAIFkN7Zd+d0vSKufZG148IrGhsoVXSlLEwoGUntCmKCp+JyHyPsGxeMGMlxIgNTjHlRnb1ou3zwNI4mCV//Cxi86PJWEEguMLS/tlsJMO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mCz6XYSQ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mCz6XYSQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782212402; x=1813748402;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yHO/2t0Hb5A0w4vjeAuH+yDbJ1lP178mmCNx5z6M//k=;
  b=mCz6XYSQB6qwVTm5zRj6e+rpspOwDbGqD32lUZKTnO5POsZqEY84+xze
   JHQTgbkqWUNhAb3EqADTAWXVXUGwBAFmBtR3TtGPC+X/ilmJQDoqbxRbK
   cSlSvMocUG3VM3jVm8cXVqjzsb7t15iJLtTXOukLrbTlxM/Drg2MBgU3Q
   sJ0wUbKwsv7oAR4jVnD3FyxlKlbbRIXyjeqk66d1/CS4XJIqzUJyAuMQI
   Rga36bRJ4MkpYsJxp9doPvDaowQqzpUGt5lIi9vPaaNWcaoGS3FuDyKI8
   swVEGQH2SbmYe5lDo1x2QUE7vEsdaCBOivZUybSomYtzdWzniPZJl4AeE
   g==;
X-CSE-ConnectionGUID: Y3LtMIYZREylgqcL4yz3eg==
X-CSE-MsgGUID: vSMo/dVLT82Qe5W0Vpni4w==
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="59540448"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2026 03:59:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 23 Jun 2026 03:59:55 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 23 Jun 2026 03:59:49 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v2 00/12] Add thermal management support for sama7d65
Date: Tue, 23 Jun 2026 16:29:32 +0530
Message-ID: <20260623105944.128840-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Apologies for the significant delay in following up this series.
Thank you for your patience and the earlier reviews.
This v2 reworks the series based on the feedback received on v1.

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


Varshini Rajendran (12):
  dt-bindings: iio: adc: at91-sama5d2: document sama7d65
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
 drivers/iio/adc/at91-sama5d2_adc.c            | 116 ++++++++++----
 drivers/nvmem/microchip-otpc.c                | 142 ++++++++++++++++--
 .../nvmem/microchip,sama7g5-otpc.h            |   4 +-
 7 files changed, 409 insertions(+), 41 deletions(-)

-- 
2.34.1

