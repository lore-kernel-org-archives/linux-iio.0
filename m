Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021117.outbound.protection.outlook.com [52.101.62.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED730371860;
	Mon, 22 Jun 2026 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114462; cv=fail; b=tp2KRAX/r/3e9MXwX1nwwgxIx6LBDKbj71NMZsezJVMJ4wQVnWPbMoxoPf18iFDp06oPp4EwXxNlkooi3eLPvNCTxgnCvkx3WpBTZl9GM2gMVO06F7XOVtZtAXXa+fC4766OGHt2H2BALp7XCCzj4Ims+ztkctS9OiXJfjM9DsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114462; c=relaxed/simple;
	bh=zgwg2AJEkWQtTpM9pezBIhlY6adMOZTm53TsH8TfmAg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U5uepKhUT2dAicY7p5FDWJzQbSzCJ+f5xZOHQaIGfZ2kbTr0DOFUpx0b+PyRTPEQ/n79Op/zjDJxZIwpiDboSQZNQ5MkffIty7sdxUoiSDL6KNeH0w/JwJpq/NRkhXDx+3oIOyD1s2vxdfbwFjPaHZQgpb/EkxSNRaVq6fODof4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=VBTBx7Wh; arc=fail smtp.client-ip=52.101.62.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="VBTBx7Wh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1ejsfiVco78ORsQ/xur9CD66JRGbMc0svz1ZpfglIlF41nSLkNS1JcJszzAvqh682xMCGJvO5GI9jozK+f3lNMtKqqM1VM9gDy0AUM+uG9L8JFdqXYB7PbidVPkWKf+EPrij7OlaBR1UsFX/wGAmtEZYwyaiK0e/A1bcpG9VLNwC3fR17fZ1bnpw/U/doAGke5Rz9cavs8cPQCF6igEOky6uMI6O0wvlQrknns4Pv/pNVECASCYFEVoLm9v2eUUFaZ2wBXHV2Ly3JUBGkKnojzKz1UFiR0POYIigoMej8e7nRGNumFOrz1VkkQp3Q/YgpphP+i9SsFCoB2caF/zog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N702aeBwDDytF1ECUGHxXJi3iz1NV7sVXVCPjS1b6Rs=;
 b=UV02GObU7fTnK9UKBTU1DsErOq5fMVC8nVHTJnir6kiKkyTKgF940YBbPHgBcg5NRYE5F8u3YjLiUFcWEsorcIw76tj/XmPBHhxm4wFU0d0/FSWmNomKXXzRrBJYv6gco/nSViY0o76tQzPCVt4AKAFOUaIXO2nKv7N4bEUgKzJR3TTG1Tf1U3m/N9xuUxWqykJLZ7V9hZYnicKP8IK7uHpV32UzVi6l0H08yCGeh4dYNrWJhXFp+g/NAvvz0u9hAR8aMXlQnTCDnaWIcJp8r3x9ykybaw6ZG7ADct7LRAwC871PYuIg0+T/PoxLHUhbCTAUor605zbqkhqLiJS5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=analog.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N702aeBwDDytF1ECUGHxXJi3iz1NV7sVXVCPjS1b6Rs=;
 b=VBTBx7WhEc11Uog1XfRrVz5BVbJbqTRCMKBZHAq4ufKks9QUaS63Jz0aRqsAHR/N/e7tkFJLQB4wF7WzoBrT+V3VG6P3lNc0aaS6dZCLj0hBpJPeJ5zdB1o2G+TG1pcHEFdyFmHaheKARWwV/yuZF9oW+cDmQi3c7ggiQPxt0MwtMZG0B6TW2nbPun6HWbnNuxjfY2qMVbsh8fPOOZ5KB7BcOpqUFTfcL4pSmuaKSd/6bJmDTuqwwM+cs/zJtl1WOEarmvO2BwMSlMsd7wSfZj/gfZX3ERjH36JckwrLPLxvqK4tdLo/8lmW5+cuvNnAVTQvEb8IwVT0dfiDt1oXtw==
Received: from CH5P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::16)
 by CO1PR18MB4697.namprd18.prod.outlook.com (2603:10b6:303:e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 22 Jun
 2026 07:47:33 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::77) by CH5P220CA0004.outlook.office365.com
 (2603:10b6:610:1ef::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 07:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Mon, 22 Jun 2026 07:47:33 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 6C7A04186B58;
	Mon, 22 Jun 2026 00:44:48 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Subject: [PATCH v3 0/2] iio: adc: Add Axiado SARADC driver
Date: Mon, 22 Jun 2026 00:47:26 -0700
Message-Id: <20260622-axiado-ax3000-ax3005-saradc-v3-0-e57c7c7ae675@axiado.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI/oOGoC/33NQQrCMBAF0KuUrI1Mkia2rryHuBgyqc3CRhIJl
 dK7m7aCuOnq84fPm4klF71L7FxNLLrskw9DKepQMdvjcHfcU+lMgjSgoeE4eqRQQgHAFponjEi
 WCy3QkSapCVkRntF1flz166303qdXiO/1WRbL9evKfTcLDlzVmkh3xkCDl219tOHBFjjLH2aE2
 MdkwVqhbEvuZE1t/7B5nj8Vzju/FAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782114452; l=3721;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=zgwg2AJEkWQtTpM9pezBIhlY6adMOZTm53TsH8TfmAg=;
 b=CoansZqYHwWkKgrlwW4eadMfDJ11y5V/XXI8Hg56h6jdcVf3Ew2mbu7SvydXF5bjRB2rhpynQ
 TcQbuiF7j/jAwwA+CT4ue4vUzHvxMIqJUFpu0Uf2aWSj2/4br1mkrZP
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|CO1PR18MB4697:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e553c1d-bd2d-4bc6-38ed-08ded0328527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|7416014|13003099007|18002099003|921020|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	eovUFtDETRzRMWjJbZrERqfixSuQkIGhnb9vBIeO6CWhhpcXmNMijIgmLEWo1efY/ovHv0SQEZQIHJzZCcQs7rCWrKmYTLMmnSUUBi3HH2Cgy60A3Ge/jqNHYFENakRNlCVtvmGPtaGEG5w+W1Yr1ds2iGoGd7fAAsSJ4kFD6VDnU0XkF+FrwFuP2eM2v1cFPStVvZiyJuK0C80/qHl3UlnmzN3k2h9ehb/8UDL+bfSuVduhbrw7IzQDyq54ioq0wRSs/7dwu/9DNVgWuEKVF89jriDbZ1bYWL/bzExntevHV6p0GPSIdcTQCICJK2IiV65wiIu7Pvcb1UYPmxllOISBMNFCNKUH1O0dgTK7d1LTH0xtUrsFqFp00GkFp2diMXKez6DxVDf+ksoNgibdaLpZwEv251bCK/18iycCLyuB9pNSaTTfWfXejHhK9bPOZAPvFukj1PA1ck3EX7j8AwEMndRew385AcuXyzy88dZ68uxUMFar5RJc5oZgKi+5ZzERQkCBUS6ArrIfARUmzxKe7TAivW3PUld2mW2WRg9pwqOvhI9tdnBh2GjCYQ1CAJN7wSu31SXIMVdGwRL84G+G3M8MehZ8CHTlwz+mh4G3+cLzo/v/0a2CFn4GwGxnIe6VIgGPiHJcPqLv4pPFlFibZ6psBK1ToOZnk+XLvem54oPuu63cCNGaSbKJJyx1vOjRn9hvHAu53rS1EOuzvA==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(7416014)(13003099007)(18002099003)(921020)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hna5o8/YzbEY+mWzY/AmAFTFVflf9CguKHCIanor93piZXtwGz38/FAK2UMmD+5XLaKcpY3PnjeUtql8tC9/QPcidFTeOxedq2Qt68pWc4YjKKUlHTxnB2K+vSyIPIjVdRQWpy7S/4UunzFkSV6RRizGAcRDALpZyvW7s/+4fYp2jvOFxNleGsXC+BNkBaHT+a4j08geKU9BaX/UOgTVXABwocqnJCkYY6Y44YabJPzTTKFbane07DkAGFdmUdjFmL7kXvSK4DWJKBJWzur7XDA10hNYdkp+QL6/tJXfCHIDacz6WXE0dHkw6Fjpws7UAvWBEqx4SLsOnR0lk9IStIcH5hnf0QJ8RIhCoWlmBGha9ledeLP5PWU1sW9XPZzeWt1Ew//61PzeGjUB7nTQazkn5ZHMKY2Fl+zAmfKywn3av+uweDELgaOUhvt3xBAh
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:47:33.1244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e553c1d-bd2d-4bc6-38ed-08ded0328527
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4697

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

 .../bindings/iio/adc/axiado,ax3000-saradc.yaml     |  63 ++++++
 MAINTAINERS                                        |   8 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/axiado_saradc.c                    | 245 +++++++++++++++++++++
 5 files changed, 327 insertions(+)
---
base-commit: 51f0c0b8545b23963afd5d43a8f56ee05bfa54da
change-id: 20260508-axiado-ax3000-ax3005-saradc-151aed5d25da

Best regards,
-- 
Petar Stepanovic <pstepanovic@axiado.com>

