Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021083.outbound.protection.outlook.com [40.107.208.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0513A9D8A;
	Fri, 17 Jul 2026 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784267593; cv=fail; b=GWdOG4LoMf8qn+meAPtExKNj3UfAQ+oMfiUdCYWTjaQVoMOe6TePEi+ETeeNwWUieP586/mukppoe5YJw+GLxVq5ElWMl/jQF0/vJmy0q0d4iqvkeI9bQ3WQEbFiaOWipi6PqzQ3CyvGECW2syVCub/gXmtjyNrxARzfs4cPBRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784267593; c=relaxed/simple;
	bh=HfBJOW6IgNs7gipGHAjgNj9fjDhqHyw80PZlw3wc610=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oBV8GRwqQfcc+q/NajbGkpCDsJX62cY99ALkVgl1UHRFs1xQCBzLDUuQw0J+0hUKWPePzaQVgrv6QcvoeAya66FakJRfci9OISun1VzYyMpo5zBDiO55Btiq0wFcY27zBGlDu351Y3a+rXFynturwjllSDRHaqMFt3vNmDCybQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=GrJ1TEbq; arc=fail smtp.client-ip=40.107.208.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="GrJ1TEbq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoDTr2G4xfKBDXsabREa9WWCv2eSnb41LstKLAdgygGP0eMwqabnGjwXCiaPyqbAwJcCi7uqKTYDoshXZDQ7v1gCG38R5rR7OWGE41Z38PhjoLxtgpLBvagyxCjhPgk0OnxsRNOFtusMQGRmqU+avlRw0qc7bv1D9m5+TTgpXg72p0ZanNbrpQlpWYltEo0y5yEvqGLpnAT4ugiHlJbppZdNxWZ05/HnlLEw5mx+whZAdYdVt8U+73dxMlvPUUbjLOqqi0x6DpO7RJas0+TgpJVaaBa8MUXJrDZbdtnP9O+4insaHOkdrUFb4ACanGqpHx782gDK0mV+1xuQ7TZ68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAEkA9CX2WC6KWxeGmEVaQwPZJTs60T34n9qF4D/VJI=;
 b=nR5UHVzqY8Nc/gVyDNRicICfgwqDpwFSPbXHhoUcRTC/IBDqlBoW2dJwl/pLH/RDKl5ywkxRHniwpoXG84lY8Sz6532t60xruGdLVln3XXGA/lYMqCfVQVLdencYVT4pnnF7izjHwpp0J/N4ZMYBSojKQl39cfy7uJ82DnrQDnDTyCV2WU8ifQKbwIW9y4UsnmFCHU+izCZ7dqIPioRgCbaFT1eKeOEFHb80cyCXLoOwc7gy/hNi5HThl6QHWNyO3PAkhrFCAljPZA7RY6pHWzsbkhqupv3dKavEXrm7JFEu81IJPcx6V/8hDwcdkD0vXg86rBewqFqq+LlOGNPu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=analog.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAEkA9CX2WC6KWxeGmEVaQwPZJTs60T34n9qF4D/VJI=;
 b=GrJ1TEbqNv623AzLuVGaYbxdl7Ub0FIU0dxOUyVgbP6VBAYrmSxkZ/A+IGN9OJOPZcweYsTZ/wdn5Kqn2n0n5uS06utmOD98/H/CeNEnIzhx37cCynPKvmN03fAiz6XmqCwIy494cXRMeTSWbC1/gF04NW5lEg9HJ0UYxbqb+KFSkl1uOmPbub6gInhxaiBYJGhuu479WHtT3hfNhqhl8IEl+uQeimPAeHuW88aLPLDH0J5DEDLZs4MOvN5+/ovdgUfiHbDDtR91QRcj3OgN4MsW/uuOklhAExruu8e+NxSGoiJe3DHP3te7apT1umYQcdAmAF+UfvO11nlxYZZ+Xg==
Received: from BN9PR03CA0894.namprd03.prod.outlook.com (2603:10b6:408:13c::29)
 by SA6PR18MB6203.namprd18.prod.outlook.com (2603:10b6:806:415::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 05:53:07 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::90) by BN9PR03CA0894.outlook.office365.com
 (2603:10b6:408:13c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Fri,
 17 Jul 2026 05:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Fri, 17 Jul 2026 05:53:05 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 4D5934186B52;
	Thu, 16 Jul 2026 22:53:04 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Subject: [PATCH v4 0/2] iio: adc: Add Axiado SARADC driver
Date: Thu, 16 Jul 2026 22:53:00 -0700
Message-Id: <20260716-axiado-ax3000-ax3005-saradc-v4-0-810527a9d27f@axiado.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD3DWWoC/33NwQrCMAwG4FeRnq2k7dKpJ99DPIQm0x500spQZ
 O9utwkqwsjh5w/hy1NlSVGy2i6eKkkXc2wvpVTLhQonuhxFRy5dWbAeENaa7pG4LeEAYArUmRJ
 x0AYNCSNbZFJFuCZp4n3U94fSTzHf2vQYn3Vm2L5dO+92RoN2FTJj4z2saTddr0J7VgPc2Q/mj
 ZnHbME2xoUNSx18Ff4w94VZO4+5ggnWoQyJr/EH6/v+BcogJX5hAQAA
X-Change-ID: 20260508-axiado-ax3000-ax3005-saradc-151aed5d25da
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Petar Stepanovic <pstepanovic@axiado.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784267584; l=4388;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=HfBJOW6IgNs7gipGHAjgNj9fjDhqHyw80PZlw3wc610=;
 b=vERxrGztLouP1jbiLKFNq89JLnD4aHROSrGnABJIwBWWx0GMM8ny1thSeWAYkSVOHxo5i1Mop
 7nIVLU84oU3Dl6GLCGV7e+hsnvnSrKGS1V+YOR1VXSDOEhkwixKa8Hr
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|SA6PR18MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 064b38bd-3fe7-4f9a-b36e-08dee3c7abcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|7416014|376014|82310400026|10067099003|6133799003|56012099006|18002099003|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	+MnnWPaRsr8ugVuwGCvve5PbpNq2OPoR64fW3/jUJeY817iHs6UTpv8xuwpHhsMYrfaXiwrhesF/2jsVml1IA0jdJ53QAQFRIMMOmvoWrc6z8QuZMtOCTL3KMpf17cwr5pbqg6J7/rKN0MmGxQ2sxI+MLqt72yjYc+t2zBGx9Dlh6cICDS0VVZycNy+5AihtNTWcVpM4G64LUkxp8Zmp8u2kCG8iXm28C3/K60y8jKo3B0AW/fnFp/pp7WIDVPwWeND1OSzzcj3qLeqfMxJMcScuRzxxnY/bFXa1Ev0anjZH9zfjbn5UIJ8ftw0aBesal6qwX3HsaUiYBqO6HWItVBQO9BlTpxjEqaRUKnxHoKXvHB9/YyuZ/2ED6dpeRsdvEsaaTfEpaM96qnBZJlVzMDLBjYxdCmmqM5xOy/BrhDpFEe0Z0AaDF+yObD9/K7FHVMmUAVgKuZSLr86V5F1GW3GjLQMwV1Pbeo+RzG140g1X9s4so7St59u3wNh743FVrSYg26P7wUhcziDK1ddotcPySo89kpfGIpMo+0b7HWtoGlWOfM8wRGRLS37fQX5iJ9WKBcXkpxYzyitSmXrDKTIzr5IQlVt+pmEsJT1Geil6cxJpvYiK2C7OSeRMpINLi7KAkBGZ7Rbuk6oZB0VXgL1i2pqe63CfJOtBnLfGy3uwowo1QboDec98PliX0sYQ
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(7416014)(376014)(82310400026)(10067099003)(6133799003)(56012099006)(18002099003)(921020)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EqVALNmrA+/WYuyse2qG+aTuHBWTRDH1H52/1QsTWBD7KYkonTtStJNh9/ZA4+UO5EjPYKLlWSxRF5RO3VOto5ZmTDqLjR2yAa8B1E+kj2qeVQxHS8z9xLUehASg4rMF7Q/bHTbMylGqs9t9OwOJ07+yhKQ0ZMCJvglY/eaFcQidYeYPXhnORVmcp41nuBnjk1D6kHm++H/vSH3y3FjUkzo9XzmIH8ebIJkRxMfuxA/JY8JeLPxlBKPoaQnhma9XkBdsXxW6g/7YXJoRWemd8M/QlSaeuV/+bvuT2KXmMOL+L9WA20gdCCDpHIUrqOpo45b/JOnXlpANc0wgv1RRfsX+Vq+XPj1alKKTCJwGOAy88g7ebymsf29oKDrAJj8xv353vTVovl1p8uKizH9FhA/7pUqZQcBUcTR2oVN51q5qWpbcJgkmBUNKODtdCuLK
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:53:05.1644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 064b38bd-3fe7-4f9a-b36e-08dee3c7abcb
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6203

This series adds support for the SAR ADC controller found on Axiado
AX3000 and AX3005 SoCs.

A new driver is needed because this SAR ADC controller is a SoC-specific
hardware block used on Axiado SoCs. It has its own register layout,
channel enable handling, conversion control, and data readout sequence,
and it does not match any existing upstream IIO ADC driver.

AX3000 provides sixteen input channels, while AX3005 provides eight
input channels. The driver uses SoC match data to select the number of
available channels for each compatible.

The driver supports single-shot voltage reads through the IIO subsystem
and uses the reference voltage regulator for scale calculation.

The datasheet is not publicly available. Public high-level product
information is available at:

  https://axiado.com/products/#AX3080

The register definitions and programming sequence used by this driver
are based on Axiado internal SoC documentation.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
Changes in v4:
- Converted direct MMIO register access from readl()/writel() to the regmap API.
- Added REGMAP_MMIO as a Kconfig selection.
- Added error handling for regmap read and write operations.
- Ensured manual conversion is stopped even if reading the conversion result fails.
- Fixed the regulator error path to return the actual error code instead of the
  uninitialized reference voltage.
- Simplified the channel macro by generating datasheet_name from the
- channel index.
- Changed the channel array to use one channel entry per line.
- Link to v3: https://lore.kernel.org/r/20260622-axiado-ax3000-ax3005-saradc-v3-0-e57c7c7ae675@axiado.com

Changes in v3:
- Fixed vref regulator error handling.
- Added linux/units.h and used MICRO / MILLI in scale calculation.
- Reordered struct axiado_saradc members to improve the structure
  layout.
- Fixed indentation/alignment of multi-line FIELD_PREP(), GENMASK(), and
  writel() expressions.
- Removed the blank line before module_platform_driver().
- Link to v2: https://lore.kernel.org/r/20260611-axiado-ax3000-ax3005-saradc-v2-0-913c9de7c64c@axiado.com

Changes in v2:
- Fixed the devicetree example node name to use the generic ADC node name.
- Removed the explicit `depends on OF` from Kconfig.
- Cleaned up and reordered header includes.
- Added missing includes for `bits.h`, `clk.h`, `cleanup.h`, and `err.h`.
- Removed unused `linux/kernel.h` include.
- Renamed register offset macros to use the `_REG` suffix.
- Renamed register bitfield macros to include the register name prefix.
- Added separate macros for `GLOBAL_CTRL` and `MANUAL_CTRL` register
  fields and values.
- Replaced `iowrite32()` / `ioread32()` with `writel()` / `readl()`.
- Moved ADC conversion locking into `axiado_saradc_conversion()` using
  `guard(mutex)`.
- Replaced `usleep_range()` with `fsleep()`.
- Renamed `vref_uv` to `vref_uV`.
- Added SoC-specific device names in `axiado_saradc_soc_data`.
- Used the fixed SoC-specific name for `indio_dev->name`.
- Removed unused buffered scan configuration from IIO channels.
- Added a managed cleanup action to disable the SARADC hardware on driver
  unbind or probe failure.
- Switched to a local `struct device *dev` helper in probe.
- Used `devm_mutex_init()` for mutex initialization.
- Simplified error handling by using `dev_err_probe()`.
- Updated probe variable declarations to follow reverse Christmas tree
  order.
- Fixed the `of_device_id` terminator style.
- Replaced `KBUILD_MODNAME` with a fixed driver name string.
- Link to v1: https://lore.kernel.org/r/20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com

---
Petar Stepanovic (2):
      dt-bindings: iio: adc: add Axiado AX3000/AX3005 SARADC
      iio: adc: add Axiado SARADC driver

 .../bindings/iio/adc/axiado,ax3000-saradc.yaml     |  63 +++++
 MAINTAINERS                                        |   9 +
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/axiado_saradc.c                    | 286 +++++++++++++++++++++
 5 files changed, 370 insertions(+)
---
base-commit: 51f0c0b8545b23963afd5d43a8f56ee05bfa54da
change-id: 20260508-axiado-ax3000-ax3005-saradc-151aed5d25da

Best regards,
-- 
Petar Stepanovic <pstepanovic@axiado.com>

