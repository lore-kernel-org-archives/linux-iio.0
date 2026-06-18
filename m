Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB53E715C;
	Thu, 18 Jun 2026 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777677; cv=fail; b=CQuKJm/bI4cqai25qKGwb8oBPtvot+Bf81alPNBRDOAZ4sUKUG+GgkLWlGwnsTN3TCpERZjpZ6tw/bbSO8T9gVrcrq5TFbubHSHtzQyyopEvyKNtk6KBF4UbxqSTFDvZsVIHD2qtQ9ZHd3Z7uxg6oGfUqA4VWRZ/oTZDtYJ0CxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777677; c=relaxed/simple;
	bh=8LAn6sxhMB3oLFSvwPwEkLiiv+ynzGcAEzq8DseUjK0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FvkvCChHhtyxtH3m8n4cpII65rQbCy+/PhW0Z3W46tlS/DE0naegJ/l87TACdTZ3yFPEFEa2/c2+kPtxAs2bbK6lx1Bt9nR7fzC+pb2uW6ulBgiSxwoCdZSSGEHhShStle0thERPyRvwv1jVkqSLX/galK3zJODlpXcXDQIlYbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SW73N6yt; arc=fail smtp.client-ip=52.101.53.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SW73N6yt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSuudcuUyBWUzpWFjPMxKeK2PnmwE8UKvs9ravpP03EMEa9VojnrHReU6PYDi9L7riwJnUdOW4RpHbOij0j3ARk/7wgZtTqB2L1pdhXfFiK2DApPktlEfd6/L2Pin8eEVeDMhDaLLq3QjzrhpIRJYrULn/i1j5Su3GDfZzuxQ7HLIKTnE9FMXA+oyQc5kapbpKbkdTScPZ6nICSd86LKF8Oub1QreirnJioCj6aSQacSMb1/9tS4IJCDRwACbnhdq1Bn+IspK660A+EURr3S7Q13IXSYBj8Rd4q89VNlN5Ny2qZFb1rdyQRR+DnnMuYQJO89GHMY5k7LVAA7RJU+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCheKVLtuCsN8ZbKqpScbkM5KlHGhtkxpyQCN7kwOhU=;
 b=e/5pTipcNwI4Zyl4vTtaLT/nxhXPjKiEb0Q2ulGTWTx+yscSSijYb8xMEK63G6DZh4RZOgW1g09AnL0hhM9wxMvNulXwWgaFjPQ4n+Zvf6lMEE36FRY4cOe798w8b2WWZ0HfyICz8fCB5I00ITrTI0kkWoVcpqwaqDb1QUt0RZNUTanxXOPXDi7+Ba3KibHtb0a5jWhNItJj/pr+ZsiMgzc6hdt4g4I1Tc3aOzatFbAmtnXm78J9HlfjPsFPgkm8amOfDK+yFbC4hMEy9EnYSZNmHr9IppAmTNYdpsaEp3plx+kvy9UxuUVYLwwkfsMW9HhjXrl/I3oDPwrA053t0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCheKVLtuCsN8ZbKqpScbkM5KlHGhtkxpyQCN7kwOhU=;
 b=SW73N6ytHH7gfajLZJOMYdvakylkY5v8ah+gNzSLQK8db4KwTmSvXMfLVJb3KboRjysan/0K02ls6f7OB9oKs9jen+bxH2L87/v2o9gLFGYeCRJTlwhSdmVEUxNlfs/rADkJmbqsbyPW2Su4hHHbbQ3PLwEdcE1L51JUd/E20ME=
Received: from SJ0PR03CA0227.namprd03.prod.outlook.com (2603:10b6:a03:39f::22)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 10:14:25 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::97) by SJ0PR03CA0227.outlook.office365.com
 (2603:10b6:a03:39f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 10:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 10:14:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 05:14:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 05:14:23 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 18 Jun 2026 05:14:22 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v10 0/5] iio: adc: add Versal SysMon driver
Date: Thu, 18 Jun 2026 11:14:09 +0100
Message-ID: <20260618101414.3462934-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b6a25a-feba-438f-bab4-08decd225f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700016|23010399003|13003099007|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	iPQo3RxgrUTi4kZ9mC01gfLEERDYxLDfYbpI7Z4KWXZYrikj4P1NKfeNWJWe8wfDS4FJy0EiJbuzKSEhXjsHYRfvUB5beaDdwuxZE8pdPdvtusAbnOhvIqD4qZUTLkn+7chJhTNGojjkeHaO/+TnhaQj/3RnnsFyAXQVZhjORrlqCFe6mpYEa9Bkmb7wQgqef521v6ugAVZQTUxycvSQ47SL83Oj/fGTKJ6sSaZYtWPFfd2AeezwmLpOu8FIbpRI7gJqzpPFkYIPwNEjm138cguZ87IdEJ+c6psiMnk1ykzbc6DzGGcBfDmcdszX+M36I/C1dLTSiScJYQl4e7pv6UwtaXMH7TfUF5znj2xJFnl0Goxd8JB2HlNMHaJ5HEXGJRE92PWfolM0VRwichn5cr0ry16sRFymOyCgCmQYlqiaBnKmohZTh8ToRdpFkXfdkX6SKOzMouFM3nkGTgVdcYHeNhUGLfDMXtAfzAxnjXVmKUgerx87bPNaKg4xwmIIfaKxLtcCqKjVoFYH+BfmBTlPBku9wh/SMuYyijNOjYnwjZc4imQnV7zQgwTOf5v1NEa+xOQTnStYqyMoz0EoIVE/YdUJcYjCSLhFeH3Pi5sTif29XoeGhDc8jXcjbSkFc+X5+buSIg6limeOFKYVMOGLpTOxoZXANzibbSzFxpVsbJhi71KJ8bf2+9cgJolyuQ/8P4V1Rl/IxzQMYMRnQpHGi+mQqpREjAWuMOZSWag=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700016)(23010399003)(13003099007)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GKvZC84XltZYmh+wPXmFUen/fiffMf4GT4bofH7jmcBfceugHuJwudFfHOWbMMZKCj2iklNWQ71aiK4/SrQDz0SGKOtPHB7WNkLnQc10vcqfaAqu7zaLnNwg5smGFpCAwSbSuVReWqi/b7ZcU/7I+IKdhqU9wlXlRvkncPOKswiEMFRHufdjJiD+wuNWXMEJBA7EvllEvq8g5QQkB7sDw4Qw1G+uiFMPJJKN5Wx+VnqM/jDoz84Uo/7w27snsTGuZ7BaOMSsQP7nH82rLfhGxy7C7MzC2ESZuvp46WqWR3go+lOFU2HH00nHtFk4PnQ689tb+htCrmos5uCVP7u+3BdcjqvGBgnhItMXbiU1lsEJ6CtGrkOGnBinoo8gInI/Al5UCBUB8n41RJiIpvbZo45dDQEjFZHowI99xvDRyy/MrytmOf8EhegqPVMT+GmC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:14:24.5267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b6a25a-feba-438f-bab4-08decd225f6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394

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
  v9: https://lore.kernel.org/all/20260617180147.3370346-1-salih.erim@amd.com/
  v8: https://lore.kernel.org/all/20260616131559.3029543-1-salih.erim@amd.com/
  v7: https://lore.kernel.org/all/20260614233722.2603459-1-salih.erim@amd.com/
  v6: https://lore.kernel.org/all/20260611222738.2035062-1-salih.erim@amd.com/
  v5: https://lore.kernel.org/all/20260608183801.1257051-1-salih.erim@amd.com/
  v4: https://lore.kernel.org/all/20260606051707.535281-1-salih.erim@amd.com/
  v3: https://lore.kernel.org/all/20260527114211.174288-1-salih.erim@amd.com/
  v2: https://lore.kernel.org/all/20260502111951.538488-1-salih.erim@amd.com/
  v1: https://lore.kernel.org/all/cover.1757061697.git.michal.simek@amd.com/

Changes in v10:
  - Address Andy v9 nit-picks: limits.h for IWYU, variable
    declaration grouping in P2 (Andy)

Changes in v9:
  - Address Andy v8 review items: symbol namespace, function
    signature joins, minmax.h, variable naming consistency,
    num_static move to P2 (Andy)

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
 drivers/iio/adc/versal-sysmon-core.c          | 1035 +++++++++++++++++
 drivers/iio/adc/versal-sysmon-i2c.c           |  134 +++
 drivers/iio/adc/versal-sysmon.c               |   92 ++
 drivers/iio/adc/versal-sysmon.h               |  120 ++
 8 files changed, 1578 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h

-- 
2.48.1

