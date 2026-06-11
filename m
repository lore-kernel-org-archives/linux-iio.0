Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB803939AF;
	Thu, 11 Jun 2026 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781216870; cv=fail; b=r8C3/s+lVP9bnWq7HiXqiWD1TgsVu+cUP1zlWsq7zgS1FwbDIrFsbUPj8imTDp6E1FtAw+jEPbXg4nAl4dw/4ODspIWnGi79EJW/T/e7IJRu5WwaXfjloGOH3NfcWsgnIvZFYKeyLlYJWblnNsDwdSIKkUzlNInkTzqbbQjZf14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781216870; c=relaxed/simple;
	bh=rHg6HWGK5/7cOLyauvNA041RLpq/gzHjdkwMfTSIp1I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HpQ0Q5iccSiFmzA1qtNHvLxPNqFt4rQ5OSSWVKDoTSpQU1otTWvYQhe1ILTFGFVE4ZSGakyengVnVH4PtOtnhwoSD9ybSrqYF7s/PTzd6n2GvniKGRD5RZrtkMjJ3/X5tnNwm0IpP4fnN2XoGLPuqA/d6kmgispl6cRBZmDK7GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AxtElcEX; arc=fail smtp.client-ip=52.101.52.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AxtElcEX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXxHfRxdlhHYziHb2EC2s7Vz/PzMh78gQz3VsnFwcppZa60qtSUXuL6MKy39/83RDDalG8iG7M0VyyIlan9eWAHg8f8dFBZxuRFfaeD3dhFk7TVVJgH56U2gkKYpp2RiSZjKpShfx7pd2pczk3P8IJujm4lrbWt1+Ty7dNtXZSWyogfuZksRfLzr68hLu8ypZi0hdCt5aoaoQBYAilkaAKVHFxckcJQmFtBnTJnARGjOoXSABfoN3MngRPFnfABOjpfvkjoBQnCQ+XCtgEmjMO+yRcEKlWtVoUdLFUiJtRluiVWSS5ad4P8XMVD30ZDAtYwZU+BoqofRkylUxJDtgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCfwWomFRuNWhnRMrbjBLONEp1cxBgGekOtccXwJcQc=;
 b=YFcsskaNGVGfEErdnurxtEK/zsni7G7ZuZhYuBBJMhsb+2HLcUYxmk4YTHSYTb38/cdsuJbqt5PYSI8hr0by0BNHXa7l3iUoLJMtB3XWoapKgqr999dgnhdiIGJXIwnQkNNoOMsY3AIcN7JhcS6K3GOUG2YgED97RJ5KvL04Sgw5g6bCtniT5fKsejEA4vA9d1z0SEmB5gkre/sZm3whoXzwXLF5GduezIFw3ZIZD8sFxKJ9GxLNHh1XEZPwxw29eJQCFYPHsiSkGYAwm47GgN7dau+1SvLMyOoTNNC5C6U+mJybolG3Tyh2ZXUt853Yn3PiEMKG27DhO15lFKTdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCfwWomFRuNWhnRMrbjBLONEp1cxBgGekOtccXwJcQc=;
 b=AxtElcEX3wnIjTaVxaXPMATC1OLNivvB6r5QFqwEZCz/1Cx/D9I0nQ8lD5u+r8BlDAoyQIgvJfF1nn6/VHu0M2O3A5T/IkWtG3QapYMk/628Ypetu/fzduIw77yPDGqHWMBhlCtFJNu8H+LKjHPR8/ojEwY4PXWwiYL3bbxJhuc=
Received: from MN0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:52f::7)
 by SAWPR12MB999166.namprd12.prod.outlook.com (2603:10b6:806:4e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 22:27:41 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::a) by MN0PR03CA0010.outlook.office365.com
 (2603:10b6:208:52f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 22:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 22:27:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 17:27:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 17:27:40 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 17:27:39 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v6 0/5] iio: adc: add AMD/Xilinx Versal SysMon driver
Date: Thu, 11 Jun 2026 23:27:33 +0100
Message-ID: <20260611222738.2035062-1-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SAWPR12MB999166:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dab1b2e-23f4-4bab-bc10-08dec808a6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|13003099007|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	u8giAhc8cWLZ6JZEUHSdUd2AfWv8isba7EhrzQ5azLwVtRVtJKFbrloLozQFp35pzXNs4jpHAo/7V3hDuFg4GXlj9CYErF7xCvwAfVNhmQatzL+kwwrND/RGVTVc+gXC+tYk5KY2aF7Z06dRMWPyHrPjINSSejMlGSm98drPaVuFGsjHKAcN6wFEZCFFeF//1EVgFl2p5Nbh6nELGsCF0MBsptVWPEQbtRbQqrFudnU4gVLeGRAbr0LQKzOB+us++FkEIsV0IgZg0Li7vmabAdW91LkvEk3Y28YHGVkqQBgVaq8r29XQjYjMoKkB0oi3iDsJvfRGTZrksFlSU40od73kdMatSQBO/N4yrU2+7aFLgoB3K/s57/LWd/npE6S6dCD5GgTBg9XwApgQ625Lh8Vz0cK+XRjjPmSGwyRlNZa3h5y/QsM1coCN+Lubdwkk+fEQoctQ4+9rdbScn3rweDkTMWS0vHCg6xgh7JHEtQirdy1YmZZb6EA0BZylssfGNW9UTLfzeBbF3MhBb7gFi6kpOrfkurRty/gvVM6GRhXY5ZDk7WT6mFnCFaHZdD/UXLpyFWVdxloc0EwJShne/3Qytfj3CCJxw5+MyxDhmK4L3tIdAxRm8z0TYkMkkklzQqunIW/BNNNzLb/bD/azgEjXNgjmgUleSy9FdqhXGiqMN5AubM+SKMGZfqBAOTDn19+Oy6J3Zcdq6Rm5rP14ngv4b1OUmfxF0m3mnj0IKV0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(13003099007)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q5f13mIJtKsIpTdItBHbz5QAKxCfRJZGOpBK8ZE5YBP0e2yk8GDp7gU4yg88rpKFmjvUbRhHgTNDhbS2CiMTZFYINhCRjOstIzMu9WHd5ii4v1zzQ2N1VUbvDiP5vddxDCuv0o5djLoNvgMn+sH1pAY1Ah8055bT1tNk7bXlicwAS2L5GDtcqn2YrkTWuP2o3ZphbGNkEIzXDtRxHr/nmzDSdwlUFGJvVX+lZZ1bWoVQQV8wNBAWQVKbgosKCgD/X2l975qJfU4zhm1kOkaTtzBkgxxaIcbglaVbSauZ2dMbdzxNv8zlY+5ddjVC+KqCxCirtaIlmVAY/NHv/eW4VMaDNi9FTm9CW24duInV7LUMiA93ZFFbcz6u0OFfufwALDpJeKFR9MCtoaE5aYsprWXPiOrorYBAdRuyKLB+qDNkyNZokyeaLDahCIWXpNOt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 22:27:41.4590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dab1b2e-23f4-4bab-bc10-08dec808a6af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999166

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
  v5: https://lore.kernel.org/all/20260608183801.1257051-1-salih.erim@amd.com/
  v4: https://lore.kernel.org/all/20260606051707.535281-1-salih.erim@amd.com/
  v3: https://lore.kernel.org/all/20260527114211.174288-1-salih.erim@amd.com/
  v2: https://lore.kernel.org/all/20260502111951.538488-1-salih.erim@amd.com/
  v1: https://lore.kernel.org/all/cover.1757061697.git.michal.simek@amd.com/

Changes in v6:
  - Address all Andy v5 review items: switch(chan->type) in event
    functions, reversed xmas tree ordering, macro brace placement,
    scoped_guard in unmask worker, combined regmap error checks,
    join single-line constructs, IWYU header fixes (Andy)
  - Fix fwnode_irq_get() to propagate only -EPROBE_DEFER; treating
    all negatives as fatal broke probe on I2C nodes without
    interrupts property

Changes in v5:
  - Core: add err.h include (IWYU) (Andy)
  - Core: drop (int) cast on MILLI in scale assignment (Andy)
  - Core: sign_extend32() instead of (s16) cast (Andy)
  - Core: remove unneeded parentheses in voltage address
    calculation (Andy)
  - Core: drop NULL checks before fwnode_get_child_node_count
    (NULL-aware) (Andy)
  - Core: nested size_add() for overflow-safe allocation (Andy)
  - Core: if (ret) instead of if (ret < 0) for fwnode property
    reads (Andy)
  - Core: remove outer parentheses in satellite address
    calculation (Andy)
  - Core: loop index declared in for() scope (Andy)
  - MMIO: add err.h, types.h includes (IWYU) (Andy)
  - Header: remove unused types.h include and struct iio_dev
    forward declaration at P2 stage (Andy)
  - I2C: add err.h, mod_devicetable.h includes (IWYU) (Andy)
  - Events: clamp() instead of clamp_t() (Andy)
  - Events: regmap_assign_bits() instead of separate set/clear (Andy)
  - Events: remove unneeded parentheses (2 places) (Andy)
  - Events: for_each_set_bit on single line (Andy)
  - Events: regmap_clear_bits() instead of regmap_update_bits() (Andy)
  - Events: simplify unmask XOR to ~status & masked_temp (Andy)
  - Events: add comment explaining unmask &= ~temp_mask logic (Andy)
  - Events: split container_of across two lines (Andy)
  - Events: move ISR write after !isr check (Andy)
  - Events: unsigned int for init_hysteresis address param (Andy)
  - Events: add comment explaining error check policy in
    worker/IRQ (Andy)
  - Events: nested size_add() for overflow-safe allocation (Andy)
  - Events: propagate negative from fwnode_irq_get() for
    EPROBE_DEFER (Andy)
  - Events: pass irq instead of has_irq to sysmon_parse_fw (Andy)
  - Oversampling: remove unneeded parentheses (Andy)
  - Oversampling: use struct regmap *map local variable (Andy)
  - Oversampling: switch instead of redundant if/if on
    channel_type (Andy)
  - Oversampling: add CONFIG register readback fence after
    oversampling update to prevent NoC bus hang from posted
    writes (found during hardware stress testing)

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
satellites). I2C compile-tested.

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
 drivers/iio/adc/versal-sysmon-core.c          | 1106 +++++++++++++++++
 drivers/iio/adc/versal-sysmon-i2c.c           |  128 ++
 drivers/iio/adc/versal-sysmon.c               |   93 ++
 drivers/iio/adc/versal-sysmon.h               |  128 ++
 8 files changed, 1652 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h

-- 
2.48.1
