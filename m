Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA4118A6D4;
	Sat,  6 Jun 2026 05:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780723055; cv=fail; b=qVKqdmepndxgzBwTYmkUK6mx4XIopKNmu5U42Gdwxco01uIaVUltwZcBEA83bCSVY07lqXQXU8MqmEtFFmaEKtaSig9pTtuqyNPmNgNoyzbbtCZP4i+m5ZApHrkI4Ga4hWNmDNt01FshPEiCfNRriIGogwujvdlDGzP3X4WZIxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780723055; c=relaxed/simple;
	bh=za7AS6Lqw+Ltaq3B4JDLL5a1TBl+Nn1iEf2lt3uIH7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KHBG71ZhtUQabaFYLcxvbj1xxjyten3ZI0jRwXMZo3apn2QE445e+4ARy97YnmaI2UMwEmxqlnktxrxxymp+gocQUqc9/FMAWDrtRYBnG/WAXNUuonFdyzHHOEjJkwqCd6mxj16iqaslrm4BoB+F2rHCDyEZpQnIXBzcvFcsZQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ohll0HEd; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ohll0HEd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2yfiw9fMm12uYXWZEoS8R3/q2qo4X4mu/5VE2pgonuRdjHnrmAkIbo2y9w1dfr9hep1KdQ4CcUC9A2RlQ+nLYz20aCg7n7EthtDYhDG3kaaQ9EdmBp3eOPOIR7OcNCtnUmDzDD+qsfBpHtMoQTvgd+t+37qJ2cDUWgB7+Leqswy5aLoT4jWBldkeKbd09S3HEledXwTE/OlrqBeOgAusCcr2UcKcD1DqqcI77qp/2HvtbuEk2LDlqOKppRn9sBWxNWBG0kwC5GnLTPPs6cm1lnwFTjB6ZtGjFjfM7y1bXoqieDIvIIOTkTL2vGDStjyWe7stiux7MObkRSh36lHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44W2ru1BfcEqZeiSYna6D/4z1jXSsBmr8qcKEMZEnFw=;
 b=gGpBVF5VWyuGtmrOoQoE1+qiZJkfiP/ETz3vOQTMy8XgC2K6n37F2a9BYVBTCCTX/EQzv+LxI2pNhvO8mVPzyJd8Z8oKOBiy2tBtq6yYk4xiu3SUJI5L1E3CZmXEgxZ3HlIOcuZO7rnLWrSG1G6+SHJjp9jiSde5O0QO0PW2UbcRR33eoF0f4Cd+YX/ArOplOnkH0SBE6ASeLon5JsQQX2EX9Ct8d1SytjJzTubNhWSCC6N1oQfM2hFVS95jiBdveeP5FVpgZZBjb6iYYrmsoZMlEDrjYgf0YHHtYvNJSyPz7tLwJddHaroE0aQ+Q8w3pxx0o7PXNEfogaxQQ/cykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44W2ru1BfcEqZeiSYna6D/4z1jXSsBmr8qcKEMZEnFw=;
 b=Ohll0HEdL5l8YJqMBBtGz7axRmpSs4XrtLY72FYPRc0bfUyu8U4IYGiaprat9K0pBQX1xWnYfHWUnTW4/H/84WlKyeCui0igjynCXXa5bxmkN54SVE04W+vPBfg7JGnRxSmVy0qtQ3K/cByyDx/EbAaQZWjxWgY0S845yiVA8GE=
Received: from BY1P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::8)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Sat, 6 Jun 2026
 05:17:26 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::9d) by BY1P220CA0012.outlook.office365.com
 (2603:10b6:a03:59d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.11 via Frontend Transport; Sat, 6
 Jun 2026 05:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 6 Jun 2026 05:17:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:17:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 22:17:25 -0700
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 6 Jun 2026 00:17:24 -0500
From: Salih Erim <salih.erim@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Conall O'Griofa
	<conall.ogriofa@amd.com>, Michal Simek <michal.simek@amd.com>, Guenter Roeck
	<linux@roeck-us.net>, Salih Erim <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v4 0/5] iio: adc: add AMD/Xilinx Versal SysMon driver
Date: Sat, 6 Jun 2026 06:17:02 +0100
Message-ID: <20260606051707.535281-1-salih.erim@amd.com>
X-Mailer: git-send-email 2.37.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: e0be89c8-70b5-4d38-dd5a-08dec38ae61d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|13003099007|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	JUoIIDS/rhIOl4Ii9Ehgoiw3Ns2SLTaI9k1zX+rDiPt4aFdgKee0N/IEL4/xrs5RmeNSlbuk6tZJKtJ4G1GX5ve9cS5YgmXQIJUNrZXKryP2cH22qznHIcoIO/dVtfR11xrqCVPwueUnKAsbHzg8V8Sbe8BMmicnWAEAU8k/hOvV4Lebe8lgvgvohcZHisK1MIXXnK5jgYSr+UPUjjAQkgpWVL46OXXwwyVwK/XFawNBP06iLlHUcreDnvHBz+70Z174Dl+mQg2bkjXLDq6y0n/xhAWYyRisXKH5YyQhDEDWV7NGxP0X7Eucq1CH/oQooLPiN7K/Qr+5wSdBqymBSBd9PR8M2LZZCZjYSO9b43GvoezmnjZtZ3RwNcZU/nbM5MsQwdX0/oI3cOh/QoxzW5SrPnCaUHUxs4lfOlyyRR5dtD9QaHYQ83i63RycXUI5xifBmzb6WCDmEMbPY0xAAZg9Ix0bmNxwABHDVC/cdh8Atl6TEAgGpJrkPYD1IR7Bt/J+Do25nxlHcx/ykNDNPtFUtSocCFu/vR/hzODOHrnkq0Q4SOo5BR47nRYgaWY4ggnPAz8luksK3XeIzcuC4o4aOiibc5BXMQPlDBXipK06De+DNwYOVulC9sbR58rKf76CE7MhrLDrkxlEkuLSKejwEpMrYqC9ScJP8j2Hu3bsDGQ7I99n/OneLbcMILnFE4LfTkJmIOFAN7Uf6F9PpX1JqeMdRJesXsheTZw8/gE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(13003099007)(6133799003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A4r5OxMQgDzu0BFv7b7sGldEZQWq7NTrVEkzjZQkmslcIrxu3pmG+GgwNKwVIQk+q4zTP5eUCmjCa2bUEyQU6ChabjJjLCqY1bYvFaIuTKqtzGo6KWU4MzAbRgVuqQWTcCK6dpebqoy42Nj+X3/gum2DUlvwATQRAFBff9X8ZM3CJXzSLZFCV9cvtlDEcm7H077zuP13D6j+bEmtj6S0340Rghg2sPjUw6NpqQM1zAu6J/MKZSDdA/itMyFH27R3JWCqC5yNXdXZhWx4I3/BHCfuINaU+JRjFtOZR85gjtPnqBjh46Z+wwUcTJIy+eeW39xnYnmAdIr5IVwmB8qesI/s79K1H4V4gby/1WOgNYaUtlqZoo1RhKCW40UgtASgkC9TJTsndV/g2oGNR/C9RnbNn7nI35UM7fS70LSm0Br8wTsGMjkhvxemplsczyP3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 05:17:26.6053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0be89c8-70b5-4d38-dd5a-08dec38ae61d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868

This series adds a new IIO driver for the AMD/Xilinx Versal System
Monitor (SysMon), providing on-chip voltage and temperature monitoring.

The Versal SysMon measures up to 160 supply voltages and reads up to
64 temperature satellites distributed across the SoC. The hardware
also provides aggregated device temperature registers: the current
max and min across all active satellites, and peak/trough values
recorded since last hardware reset. The device can be accessed via
memory-mapped I/O or via an I2C interface.

The driver is split into a bus-agnostic core module using the regmap
API, an MMIO platform driver, and an I2C driver. This allows the
same IIO logic to be shared across different bus transports.

Previous submissions:
  v3: https://lore.kernel.org/all/20260527114211.174288-1-salih.erim@amd.com/
  v2: https://lore.kernel.org/all/20260502111951.538488-1-salih.erim@amd.com/
  v1: https://lore.kernel.org/all/cover.1757061697.git.michal.simek@amd.com/

Changes in v4:
  - Core: temperature channels use RAW + SCALE (IIO_VAL_FRACTIONAL,
    1000/128) instead of PROCESSED; voltage channels use PROCESSED
    only, drop RAW; drop scan_type from all channel macros (Jonathan)
  - Core: move __free(fwnode_handle) declarations down to just
    above use; devm_regmap_init() on one line; lock comment
    describes RMW sequences and cached state (Jonathan)
  - Events: merge event channels into static temp array -- two
    arrays (with/without events) selected by has_irq; event-only
    channels have no info_mask (Jonathan)
  - Events: blank lines, fit under 80 chars, default returns error,
    return early in each case, guard(spinlock) in IRQ handler
    (Jonathan)
  - Events: take irq_lock in write_event_config for temp_mask
    updates (Sashiko)
  - I2C: replace enum with defines, use unaligned accessors for
    data and register offset packing, named initializer in
    i2c_device_id (Jonathan)
  - I2C: drop bitfield.h, add unaligned.h
  - Oversampling: return directly, remove else after early returns,
    rename mask defines, blank lines (Jonathan)
  - Oversampling: move oversampling read inside guard(mutex) scope
  - Fix v2 lore link in cover letter

Changes in v3:
  - DT binding: single compatible, voltage-channels rename, single
    quotes, drop label/bipolar/xlnx,aie-temp (Krzysztof)
  - Core: IWYU throughout, __free(fwnode_handle), sign_extend32(),
    size_add(), dev_err_probe(), s16 param, remove (int) casts,
    drop SYSMON_MILLI in favor of (int)MILLI, rename _ext to _name
    in SYSMON_CHAN_TEMP macro (Andy, Jonathan)
  - Core: fwnode_irq_get() moved to core_probe, remove sysmon->dev/
    indio_dev/irq from struct, describe protected data in lock
    comment, add RAW+PROCESSED comment (Jonathan)
  - I2C: IWYU, remove wrapper struct, explicit enum values, sizeof()
    for buffers, = { } initializers, adapt to core_probe interface
    change (Andy, Krzysztof)
  - Events: IWYU, FIELD_GET/FIELD_PREP, regmap_set/clear_bits,
    clamp_t, !!, IRQ_RETVAL(), devm_delayed_work_autocancel,
    loop var scope, error checks, remove redundant else, logical
    param splits, spinlock safety comment (Andy)
  - Events: hysteresis rework -- store as millicelsius, hardcode
    ALARM_CONFIG to hysteresis mode, compute lower threshold from
    (upper - hysteresis), remove falling threshold for temperature,
    single event spec per channel with IIO_EV_DIR_RISING, push
    IIO_EV_DIR_RISING for temp and IIO_EV_DIR_EITHER for voltage
    (Jonathan)

Tested on VCK190 (single SLR, MMIO path, 7 supplies, 10 temperature
satellites) and VPK180 (System Controller, I2C path, 7 supplies).

A follow-up series will add thermal zone integration, secure firmware
access, and I2C remote monitoring.

Salih Erim (5):
  dt-bindings: iio: adc: add xlnx,versal-sysmon binding
  iio: adc: add Versal SysMon driver
  iio: adc: versal-sysmon: add I2C driver
  iio: adc: versal-sysmon: add threshold event support
  iio: adc: versal-sysmon: add oversampling support

 .../bindings/iio/adc/xlnx,versal-sysmon.yaml  |  154 +++
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   33 +
 drivers/iio/adc/Makefile                      |    3 +
 drivers/iio/adc/versal-sysmon-core.c          | 1079 +++++++++++++++++
 drivers/iio/adc/versal-sysmon-i2c.c           |  125 ++
 drivers/iio/adc/versal-sysmon.c               |   91 ++
 drivers/iio/adc/versal-sysmon.h               |  130 ++
 8 files changed, 1622 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h

-- 
2.48.1

