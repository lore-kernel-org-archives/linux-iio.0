Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023106.outbound.protection.outlook.com [40.93.196.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27301380FC4;
	Fri, 28 Aug 2026 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787920143; cv=fail; b=cja5Devkg41dcFu6hmzPwWafMDNQ0O+Jx7dhfOzURKuj5/2T02QnT/q1qIgtIsapvzPCM+1BH8vmliZrf9mqvgziJr14P/QleWR56F3FBuo9r1yypcusokaEhemnuPr8VYVp3t9RuhG5EZ+bNNu6QQmxjZrylLpaZd0L5Py//L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787920143; c=relaxed/simple;
	bh=7k/kXdf0sOg6PToW61Y9uD2xG6ogB8k1mrNN4RoiE4U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vd+mztFZRcCjd9v3WpdXWKJKjxF7LTkTMrS+xUN0KmhmM9pQChGklU5IyCM6+XnvpiIgclO2LhnmLoz4kBU7/HQ79rxKMENPX8u+Ipn6d7r1raMVhQaD0XZOf0vdgpXb6nDW6733loE6CN+PDDN/3Vi/1Uhc8HgQTZ1dR3j4j7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=FswGwfM5; arc=fail smtp.client-ip=40.93.196.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="FswGwfM5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sy/8Za+DIOtrVlg6d2/C7xmNE7DCFtyiL9mgAtU+xZiHvpvoF6mjaZ2MDKB1FXNcL97whmarQzTVO4tL6ra5M9D07mx89fkGrUgHr+qTRm+o6Gm6JbuwST13gL2HqPa8+fAuPLQQ5oOHimXOqgbe2h14uWxNQFCftYZWw+Kl5QRzfFFX8s/66u3J+7hJTdmxhcBvhzVVJrf5EY6Su1FVBmzvSka0qZCntyX9Dljx1GxHyq2thR2c/rB1/aJMy0APItsCiNXofqdZshzf4SPB+NB70/n0AM+9AqpQieIsUcfcmDofeW6YpwJMVI1GgNoo5e3f7SxmQ4o5R+qpRv5TQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KD3L4UW+vQCbqaTkJOAa6KbQ0vT3HPh4xdWrPnnGy4w=;
 b=gXt5AtTX/iUgdMA6Gmzod4LDMhrKqTuMkMQof/Z4KBru/vlDm58UBJRTJAJ5fVaXlBVcs4oCxg/1AmVRhY4fEJwUeYi1xhhjKQv5rMAa/7v7Ml9iMCKKC+PEIMNwlEkzIQHQ6wq5GQmscuwtcvHDIeRO5DoPvl9XyWbOLx/vZgRIav1ZahIpy2ZH/ZwDYOI2khEMtFcekFcIBP6bziwvbJHImZur0dgzL86QgyR/5Ld02EVciikAO05mAr3gk0AUCa0oe1YCAmcSd71ZfYoXHMH6Ad+OWCXjJQmkXJAHOs8/PKfycI6PnkUzEMzWdOx/X2/tCNutTxphWVlvvMJSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=analog.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KD3L4UW+vQCbqaTkJOAa6KbQ0vT3HPh4xdWrPnnGy4w=;
 b=FswGwfM5t35M9kWv7GOmlKK0j3OsMDldeN6H/lflo11OHY5vlLryV77mt8sHvk4ViqIIT03QmqXqkJk+JgUCDaTM3lLlYYgy+8hd+QCRAsJ4/nNnLQThmOkU6P6cocrWiVSKkGWugKGBg38cDEkPZAjD/RrlAli3rGEjTY+fo0AT5EIdwBofCebdwZecW90rAN0Z/FPPGilhwCXHfxWFLfOD2fxbMl9kvqlH46qo0roflKiLpNm8BpZRuq/5wKoz2gLDcqfZtM4hZ3RzGKNfC6HwKfe7ufkDfaKKwrzJBLKMuYSdWQDk+5XDSnHF1Cnvzqn+difkb58WqNkdRmX2EA==
Received: from CH2PR12CA0017.namprd12.prod.outlook.com (2603:10b6:610:57::27)
 by CO6PR18MB3985.namprd18.prod.outlook.com (2603:10b6:5:350::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 12:28:43 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::8) by CH2PR12CA0017.outlook.office365.com
 (2603:10b6:610:57::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 12:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 28 Aug 2026 12:28:41 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 9DB064186B51;
	Fri, 28 Aug 2026 05:28:40 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Subject: [PATCH v6 0/2] iio: adc: Add Axiado SARADC driver
Date: Fri, 28 Aug 2026 05:28:27 -0700
Message-Id: <20260828-axiado-ax3000-ax3005-saradc-v6-0-4cea467e4167@axiado.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOt+kWoC/33QzWrDMAwH8FcpPs/DH5Gd7LT3GD2olrL6sKbYI
 7SUvPvUdpCNgNFB/IX4CXRTlUvmqt52N1V4zjVPJwnhZafSEU+frDNJVs64YMD0Gi8ZaZLmjTH
 PBrpiQUragkUmIAeESoRz4TFfHvrHXvIx1++pXB/HZnuf/rqu7c5WG+07IIIxBNPj+3P7NU1f6
 g7PbsWCtW3MCTZYnwbimEKXNpj/gznXxrxgDDFJIYcIG6xbsWhDG+sE6628I+JALo4bDFZM9to
 YCHY4GBo9Jyb8/7NlWX4A2PecuvsBAAA=
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
 openbmc@lists.ozlabs.org, Petar Stepanovic <pstepanovic@axiado.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787920120; l=6170;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=7k/kXdf0sOg6PToW61Y9uD2xG6ogB8k1mrNN4RoiE4U=;
 b=IKz14gNKUlPVVMDe5ETYCxBZ6aiRWiA+EDs7dTkzgbhOPTqqfJ8hXRcdWF7g5kqZBplpQ5+9H
 I8KIBKN0vZlCH8SzqdpN81g+NYqXY1krC2flwKEP/lyINcPmg44Kapv
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|CO6PR18MB3985:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4786d2-0553-44bd-0043-08df04ffe505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|18002099003|56012099006|13003099007|3023799007|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	9TaC+s8fUQLCtRWuseHvVnlSYSAVJ4D/N4qTlR2mIhpoJMxN2Gzlwp/dykpvBVl+BGScDZSoNZaXPGkQtRgenxRx+YahxvrZ5C6pXvU0hd7LN/V75OLk4eiGEqCagh3YLAnzeYJKUsWmGCZDhbw1XvzE5fKLq0jKhQfeKx1NZB/KJeHV+XzQoaJcVHz35+1oO5aJuwP3x9PkXwzNXUf9IO2trYpaIJVgAF0SGrduoAGRDGw4d99X+SAKHkf9V1GmiQVn1nZAJKrLFtp3q0MEJJVrvLj+USLB1JbdAzK95CbptHUNh4Mm6LI24+KhZyG2bcmNd6kd5Z1mnjdMEYaItA+Vbmoh6KwDlZGSS60iSTcpzmNKGll01pIjDohi68vS76XtyIxD6Wv+AA6Yn4j31bQjhQ/w54xrYCSj4jPJaJV3xt8TUlUgg3oE0Fj+DR95aN9i1NVPa8vIsi8VV2yBGsPtCBpKZ+TRK47qTMp8fzxUXG+KLz6wFA6FT0047tAYmrO0MVcrPPy7EqH83LHr97A5DWAcJ5bnDh1wiYWVgnem5v8/evNzAjIZLwN1QLf/ukWNCSwhG2ZPHhaI44iwP6Cvu0W5EcOlaX8vdpEHYRuSZYI+v+t0ahqr8dFUus1v/hSatQjexxJChVqWOb1kjmXP+d2X+U+5bcHAHsH3RYjSubIQY0mqYTPZTKOSNNTTye2D0eNjGNIRqjgzeJU5IA==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(56012099006)(13003099007)(3023799007)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c60lyA56pVNAWWffp8doPWvaRC8WcK8eNllPxK0dUhdNUn7wgGJO9rqR2Ej++ZUluhgKC9mvXkbkENdjbGKr40J6e1hdc40NsBPq+H7egZ/MEh11Dhfjct8r6lMOz62EoQoVaABcXCT2Lu8L0YU3DQM1PyPIGNfGnj8qYTT5Ps2qoFsd09rEwTuuuh6lK4ragj1rkUZy/oNzBz7KoFLdi82E0V30EcLboV4uBY2/B4d0QIZqiIQid8kgajLg5jCicZrkuPmSr3xIsH5uH6eUIWtMmgGFJB9RufhaoVbyiLOnWzRRK+CYXOenoDsTGskTAx07256fqeAYxQp+Ido9ZO/GG/aE8DJkVYS3PRYIGFu0Z3/h/axLvKEE/WX32jVuplsmOJZFsX7AkOic+TCoJBJfow0falnyniQiGqKjIAe8bc4vb0AFfMciV0WxgaxL
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 12:28:41.2157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4786d2-0553-44bd-0043-08df04ffe505
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3985

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
Changes in v6:
- Added periods to complete-sentence comments.
- Reformatted the conversion-time calculation.
- Return -ENODATA when SoC match data is unavailable
- Link to v5: https://patch.msgid.link/20260810-axiado-ax3000-ax3005-saradc-v5-0-bb0df3ecedaa@axiado.com

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
 drivers/iio/adc/axiado_saradc.c                    | 277 +++++++++++++++++++++
 5 files changed, 361 insertions(+)
---
base-commit: 51f0c0b8545b23963afd5d43a8f56ee05bfa54da
change-id: 20260508-axiado-ax3000-ax3005-saradc-151aed5d25da

Best regards,
--  
Petar Stepanovic <pstepanovic@axiado.com>

