Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022110.outbound.protection.outlook.com [52.101.43.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A47415F17;
	Mon, 10 Aug 2026 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373392; cv=fail; b=UDh8UUVFAjcREb60MZ/oQUKBdOwPYpiJngnVhW8oTbvJLFNT8GJwPC6mO+iz3YaWtbtp4LjVYgltNf5crlz0yMXd+ulyNGnterdHQIKZqKb62/R1himqiabKq1w37TGw7u+da3I3z5MA+z6fMOxZHOhXbV9i3dyh6hwS0kOz2kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373392; c=relaxed/simple;
	bh=ICEZBY2F5WupUD0XR4kwf3+DE4bOxC+0v/cJWLbm8Zk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uIjjvcAQafgfYjqG6D7ZNea6TokyLCCCaTMt/4ftQCph+jWIj+nP67N4nh3d/mEdpZERs0Mq+fu+3Jlt7HASl0w4K5J6Use823RniVOJdedR0Za1etemB322ldFbFRWrSAQr6KUc8Avax8jqZt9C7S+DZgFuQX5imku3wHPU2F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=TuN8FqF4; arc=fail smtp.client-ip=52.101.43.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="TuN8FqF4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqJEfKFLCCauxssqM9t36ywgVhoU1em0BAPf7UyLpxU8xypo3yiniJK4wToXWknS6ZjABcjIKACHv5jUc+CnDz4dEx2dZM0b2gIRsQ5g6Vr5BGZpaDMdppA931PWul7HaYHYqD29CT8aqeEpzaIh+jjjquIrfqfQ7N0skBZaIAIme3N0haKo9j/AkI4xDXnSdH0st6ciYaHn49aylXubRM+DQNAF0SL1ypbzVl5NO21PeWdlu4fSO9fjCXY9jdeOI5jVu+FbG4deyOSEO/ReU6nHzHD3T8wVvVPgK8I1H5CpbpJSzJcTrDaYhTBy4zIJA3uPIZCQ+KLLV535w3OTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra+x8g2XAWLyJWRe5zrrmXKRJmSC3nXxb+mYin0CMKk=;
 b=kUrdN4LN59IUhwa+Ys/RZZDyliBWuFFwxd9gvoss1rgXu4+CgZmbfAIt3z4fuu1dh/7pkFgT4zPqCoZhfNiQU89ZfZjH2LEQuAeVrtee7epYQsMdojI/ftEIx0Qwbc3JAjKQulEaep8siLvmEq3hO9sKCUzmQPglETDly/gepdZgencAxHAaEydYCxsQU+xF6/GIIMyQpYErWbUNVBHQaJ+o1ff5+DavNaxZXGzPmQ2P/AlYiaJ/25VbMmOqJw+erDX9NJTI3Cd80P7DvKi859lsikQ9jA6Jspg+d6zcN5P6ZsC++zCtqVEJ9fpHV7wqko9orOUxXP1fYEmVsJPTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=analog.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra+x8g2XAWLyJWRe5zrrmXKRJmSC3nXxb+mYin0CMKk=;
 b=TuN8FqF47AgGNEbU2wgBw3QaHxOahNwgh+7I1dwQFuLk15UgbYGBi9TMXmNpnnu4aVvCNP+U3/FmwllNYtYjT6cSVRaK6l6LHh53cBEUDMoSmHwcyvXPYt51xA2ix1T1+NnccwE2uEGnb0LoLaGNla6EEJS8DGdgmmQwTaENbsBgmYzxzNgrURlC0uU3ble/PVjvmo4wlxhqx4lPyhPAq1+OJNdbTp72YzOnGKdIfwjbDad+9xfLWaoU5iSTzLt5UcGaIse+TEYLC/gNeblF0TvUy9U4wKAAgbtjFxcRwVSsHfu5vQynnq/UMHkjf8fUrP5v7IRWn2ZeMPMbNS80lg==
Received: from BN9PR03CA0383.namprd03.prod.outlook.com (2603:10b6:408:f7::28)
 by PH0PR18MB4543.namprd18.prod.outlook.com (2603:10b6:510:ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 14:49:45 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::a7) by BN9PR03CA0383.outlook.office365.com
 (2603:10b6:408:f7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 14:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Mon, 10 Aug 2026 14:49:45 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 7148B4186B53;
	Mon, 10 Aug 2026 07:49:44 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Subject: [PATCH v5 0/2] iio: adc: Add Axiado SARADC driver
Date: Mon, 10 Aug 2026 07:49:34 -0700
Message-Id: <20260810-axiado-ax3000-ax3005-saradc-v5-0-bb0df3ecedaa@axiado.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP7keWoC/33QwWrDMAwG4FcpPtfFkiM76WnvMXYQlrP6sKbYI
 3SUvPvUdtCVQtBB/EJ8Al1My7XkZvabi6l5Lq1MRw203Zh04ONntkU0G3QYHLne8rmwTNq8c+7
 eyDauLMkCAWchQRI2KpxqHsv5pr9/aD6U9j3Vn9uxGa7TPxfX3Rmss74jERpDcD2/3bd3afoyV
 3jGBxYA1jFUbACfBskxhS69YP4fhriOecUyxaTFOUR6wboHFiGsY51iPeg7Ig+CcXzClmX5Bfc
 n62WuAQAA
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786373384; l=5896;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=ICEZBY2F5WupUD0XR4kwf3+DE4bOxC+0v/cJWLbm8Zk=;
 b=nKKgg1H0o6TUCL2xQrPZt+eQnlxs1pt7OswiH0DjLC9wFqDOPP1Dwfm2D5Pzwuz5Rtm8z0GE9
 4asLySxoCy8Bj8CF3mcz6qPq1npUGOV4a+xdxZLS1ccLyI5tjxyQqWU
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|PH0PR18MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: af77d620-b7b8-4036-9c05-08def6ee9e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|23010399003|18002099003|56012099006|3023799007|13003099007|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	YqglGWTlJ1NM+sYOGKhZxiI7TqYdKRFlUgjrRClKeLj5R9RyPovAqmDCFuEi8f5WRv2tYtUMrVn17SOv3gOOzjcVdYMlWXszmlB9pmizCvd8tbytDpT6bKf6yGgddBbW7GOxJoPAxmC+tVbJN4wpHLkZLz91a+c5z/nP0Q1na7YcwgoJQyCjUMprkrRlOfjtnEvXpyxoP88hA82mZMLUFdnZgtVe90sV2y34M+Lth6UsTjS1qG+KP9xZB0sPOp/FP+y5Y8C1UW0wTQ25Ogiut+zyoB+5/lwAIel1QR2s7YMZ30CgBHs2Ix6I9vZbZd5Ei07B2EazIC0AqaSN+ZoPuwlUiUgxRhXf0MYX9Nu6i+C1rKlrr9w7P7tEFzDYxZ0S/ldP6RVwhmkrFNoOXhe7ybO7AcVyY34mFQIAIMfvudY5BF5fpbB7sKXoBsn0tDMlABzNl+0796O3JUD6NmzVMTv9lsSb5x8ZR/QKtBiCr6J8JPs5O6DQdAz0iT1IBO6uREFSKQgB2Gaglj+vVafOoR14J/BqD8XTQubUZs8lZ1zOUHlIlMnZWe3dPj2aqT9exJWGgdp+LU9jVndljeQhR0zYqeEvu/xBmsV2WN4EK5KMRzY8ntxBLL0YX4imjFBr1moo+MTm6czUxU0bEvfx/rsEJG9H45tunHDs6Gxi+WUwOrEwwNqeFN8T+nt9QBLGvCUQuFTsgH1DdrTo4zEBIg==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(23010399003)(18002099003)(56012099006)(3023799007)(13003099007)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NeLAYL5z3OlQ7ijen58M+PuphGYh9Egi/C7zTlz8uUTwQa7nWVQDRJ7yt9fuJUZK2OMuJ9Bij1ZsDgZCtzxVYW6UyGUSkmK31Gi0HBPJaS40RyivFKYN6lfa4MLEdF03gTC2DYXHimNRN4cQpBi6TcKU8FemG/M8JAj2efZ1EER5hV4nWUj91DJLuyd2B7+h8Cn7vCmsXpCM8NNbMtyaykWp7+1pCFb5HgnFtpFPx6TQgNdf0ygiyZkMu1H9iNJf1IqUC324RMNt54vsy7063ClGHmyI9J8yQ8cxMqzK0p9jwNQQC5VzSUEob1VHRf7fOc3mp4mHOWYTHG+YU7P7Gyk/e+ewq6EEAHDxcQC+oRRe48LKlE6+iSbP/Hly5dkxuMGSJQgL6+VED8pyhmmKG8jURayOXC60Ch1oDtKBgJMC3Jut3vfJ8ECsfd/9iYh/
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 14:49:45.1793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af77d620-b7b8-4036-9c05-08def6ee9e69
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4543

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
Changes in v5:
- Added explicit little-endian regmap value formatting.
- Reworked register field definitions to use FIELD_PREP() at the point
  where register values are constructed.
- Removed the MANUAL_CTRL helper macro and build the channel selection
  value directly with FIELD_PREP().
- Made stopping a manual conversion best-effort so a failure there does
  not override the conversion result.
- Removed the redundant power-down write before enabling the ADC.
- Keep only the cached clock rate in the driver data and use the clock
  pointer locally during probe.
- Pass the regmap directly to the managed disable action.
- Updated header includes following IWYU recommendations and dropped the
  explicit mod_devicetable.h include.
- Applied minor coding-style and module metadata cleanups.
- Link to v4: https://lore.kernel.org/r/20260716-axiado-ax3000-ax3005-saradc-v4-0-810527a9d27f@axiado.com

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

To: Petar Stepanovic <pstepanovic@axiado.com>
To: Akhila Kavi <akavi@axiado.com>
To: Prasad Bolisetty <pbolisetty@axiado.com>
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Harshit Shah <hshah@axiado.com>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

---
Petar Stepanovic (2):
      dt-bindings: iio: adc: add Axiado AX3000/AX3005 SARADC
      iio: adc: add Axiado SARADC driver

 .../bindings/iio/adc/axiado,ax3000-saradc.yaml     |  63 +++++
 MAINTAINERS                                        |   9 +
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/axiado_saradc.c                    | 278 +++++++++++++++++++++
 5 files changed, 362 insertions(+)
---
base-commit: 51f0c0b8545b23963afd5d43a8f56ee05bfa54da
change-id: 20260508-axiado-ax3000-ax3005-saradc-151aed5d25da

Best regards,
--  
Petar Stepanovic <pstepanovic@axiado.com>

