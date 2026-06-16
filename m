Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF132D780E;
	Tue, 16 Jun 2026 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615781; cv=fail; b=CIVVBgRBgM5aQNALFjekIZVUjoXbfxU6YgQ3SIof8P51XaAoqnQwhysoikzVtXIPxjKmbS+UCwyT+zlEnDzBZtUfD6b1k5vOx5GS69DT75cjlH5GWZVgmP5aYIB5MzH6b/Pn8P/t7TXCMZhzGs1osswoWqUo0p7dxwGHcRZh7MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615781; c=relaxed/simple;
	bh=zRsZNZQCGieb+jODP5AFZylx9TOXY4GLVHqwKfi/kx4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jHnSoaJz/NzV0QMR6GXLFokp80u4alyS8BdQL5z7j+Pmnc9Kd1plP8UoBzMnwjFsCVjzcsHcLCQKJpxMic1B4XALcc21XJjwa3jHqaqyd4wMzeRJTfgZwsGAicDFbeGp8OEhKPf35seIly9/uWFcdGD1VuBgOvYpiJy6uK1ht1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w/lydmiV; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w/lydmiV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PO5t9lhZwEFDUKeNFmGR8D20CktgYh+swmoGJ+BRr4FQoiXO+ukdiJsMyNmUAgjiGocQs7+LFtTTKxRnX9bl/3Y6wP7CTHGZ5VHcXK2YGQ5uBFfBOe6yAL9Grmr03nChB9hJOKwbi3L1HuYwpZatWGsAlGNIIzRhAciMWCDeDflM89BHwRoxmpnNszgkBervEjDyVMngzevQ/Pb16XzpGTRB1KIeSLZgQ7Jvbv1hCp8AsFKCqaNz3U7XkpJGkgfbAApK6l5s7RjxbRDeZx4AMPiVJi5WO2SKDid+xQlKj52o5/R61eZheohOxVYSiOzoRmJMUzsqM2m5vakq3hrpGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YXuqvgXniMM/gf9uXzmP9Vbf7MgFbyXSkGaz4ZAqWw=;
 b=xUCuZYcQEnfuhuxFcZU6wy7jM4Ml6QidE9McfrtGoky0JSgSNg0Y3dsSCFWTXiCxPfZp5YH22bWIEprCbp3J+usPhndq690KEPQYZdKZrivWrtlpLvygdLCePRBWlYVNb4ymtjTt7paB5y8z0LmLDbiFzzjps6tUvj59J+mEHuh0AXz+Z2tawwuZwAld+ynKu8e7Dat1W6vQZ3CqRbDB0Yi9ETbJzxd4NV5S0CMOI/20NEueMDwpgYKcsfFRQ0A5t5+3ocIcFnIzjqLe/z42/ZRBIfpXZ3HPJluQtZ4DqWmWKT8Blag5xKdk3eLo4oui3rAxkB4bleGPYcH1AQGI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YXuqvgXniMM/gf9uXzmP9Vbf7MgFbyXSkGaz4ZAqWw=;
 b=w/lydmiVzcAVJCYnenv8FLRopygZ/R1QMkkhwl6Tq6JVqf+zZr/Ggajd6HDeROuoPdpn24GSSwTxpbFSkveAc0hEUyd0Qw0hi6+c5FleCQ64zMOD36A/lR5524S8UNxXXeoCstXtHcQpak3nPJwhXYcZAF0cocN70O31bhQlTk4=
Received: from SJ0PR05CA0073.namprd05.prod.outlook.com (2603:10b6:a03:332::18)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 13:16:14 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::a8) by SJ0PR05CA0073.outlook.office365.com
 (2603:10b6:a03:332::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 16 Jun 2026 13:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 13:16:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 08:16:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 08:16:13 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 08:16:11 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v8 0/5] iio: adc: add Versal SysMon driver
Date: Tue, 16 Jun 2026 14:15:54 +0100
Message-ID: <20260616131559.3029543-1-salih.erim@amd.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a4f14e-a0ec-4ae2-f4d8-08decba97128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|7416014|376014|11063799006|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1KoJ5NBQrusnjwE6FzmY7q498oBiUy8/o6l9c5Qimqe88EwkmE1UbDlq4H83/lK9aHadtzC9RxcOTF+QiLzDq8pEEj4OAMS8xfDzuhuqXeoJR1MxqnKK++vjD8PMVYG1dIZGDUyKO/1T0KLp+JbmMeQUlhLqFw9KuT0miQBG0TiQmqNXKTNjNLFtJFWjJefNnyU2DxmJtd19TJih3im5MOlcXkD9uHCKrrGW/kYO1RKZKpz7VqsjU6QddYbX/MydAfQ6wCzIAmt7a3fgVD0qd4CdTO0nxvHgq9Y3jgc3ElI8PGF1n2GxQJUFCYoG0H9iP2jT+ub/kYUrS7JmADu8VJ0ZaFdGS/jNE6ImTOTsn6hPgfG7RrLI3cN/ZqNVjLPU0l5u8LpA6XE03Dop2Mn25kTSsfWb4S5K6bfUt/qal3z1xNnvsde5deKec3JRUR7GkRKB49sDMYePtdlqLDO6WIEBKMd6zTYaNrQmpLQc1WUj8Eav1wj2t+zMYKOtmZ/mQnIhXUP6AYuAxneq1X0sZOeuYXKjRAUfiXKfYBSOO2LM5KcSdhOZwvlMf2xKs69u3dqHWKDz+BIk1VahixYsOZkDGev6/NmoCN/66jBAQWeysvE9LmY2geJAMcl1zmRPlZBbkoM/wPNc9o6l9WlhJ3kApAxmC3VHpSKHzP+P61OpnTsYBjWzL6nEJUayUYMrMbcstwUk91HICSBWQCFOoGm7BkK1a6SQcrlVXp0sNNc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(7416014)(376014)(11063799006)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NeN0MANQXJg65szXgxAdmDAscFDafEfardQAcouKSnPbfJdUckVMcZbDPKmtQrnRqPenxKJII2n6H34qfHVpu/qsxIs0pqs7YFrjX2rcwdfd1vm8S+S0tm4AKX1TteOCaT/fcVoUaI7NQI6yNEWjwAPBX8P+KFTmHicvbd786RT4DktzQImnuv4gmUbrHnh8aCLDNEBn33dbFpDY6yRt3DUzuQyZt4YdN8oMmXKAbcWTIdEl5rk3sgBtWE7yhPkiXZZZGIQi9hxSePVG26x6+CVbvWRMRTNm1guh6eO8eOF3KjLfytrTXE0h6yWKM7UMdbbO82NKTDS+OvW5ntvUQPXOz/4xjxDX4epKkPKseZDHH87Z/wmVLyTD0bEtPgGst3Rzxv6L60kLGnvDP5UDoQL6G8kjHmw7DlJ3nosr+cignli5o0G8Qc05/ZM1hTLw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 13:16:14.0524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a4f14e-a0ec-4ae2-f4d8-08decba97128
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424

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
  v7: https://lore.kernel.org/all/20260614233722.2603459-1-salih.erim@amd.com/
  v6: https://lore.kernel.org/all/20260611222738.2035062-1-salih.erim@amd.com/
  v5: https://lore.kernel.org/all/20260608183801.1257051-1-salih.erim@amd.com/
  v4: https://lore.kernel.org/all/20260606051707.535281-1-salih.erim@amd.com/
  v3: https://lore.kernel.org/all/20260527114211.174288-1-salih.erim@amd.com/
  v2: https://lore.kernel.org/all/20260502111951.538488-1-salih.erim@amd.com/
  v1: https://lore.kernel.org/all/cover.1757061697.git.michal.simek@amd.com/

Changes in v8:
  - Address Andy v7 review items: MILLIDEGREE_PER_DEGREE, overflow.h,
    devm_versal_sysmon_core_probe rename, volatile register comment,
    regmap_test_bits, unsigned int for osr_write, ~0 instead of
    ~0U (Andy)
  - Fix devm teardown race in interrupt cleanup (Sashiko)

Changes in v7:
  - Move TEMP event onto channel 0; drop OT as separate IIO
    channel; use single temp_channels array with runtime event
    attachment (Jonathan)
  - Return administrative state from temp_mask in read_event_config
    instead of transient hardware IMR (Jonathan, Sashiko)
  - Add devm cleanup to mask HW interrupts on driver unbind (Sashiko)
  - Add documentation comment for static aggregate temp channels
    (Jonathan)
  - Split sysmon_osr_write into per-type helpers (Jonathan)

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
 drivers/iio/adc/versal-sysmon-core.c          | 1036 +++++++++++++++++
 drivers/iio/adc/versal-sysmon-i2c.c           |  133 +++
 drivers/iio/adc/versal-sysmon.c               |   93 ++
 drivers/iio/adc/versal-sysmon.h               |  120 ++
 8 files changed, 1579 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h

-- 
2.48.1

