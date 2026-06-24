Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8CB3C98AF;
	Wed, 24 Jun 2026 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311971; cv=fail; b=B+3OzXtDjpYTL/n3fJs/PcOYyyKgAm1RXMqXHj1boKF7L0YAbTfTrfagjuRPuaButDdxi0TjBZYTbUHT1X1qb+dM01EGE7qvmRTarZbisyscgaCTDE/ptuSv2Ku1WGAAS4rDvfZrclVDRh1IfskzwhPCSWaGMvAgT10WzCMffGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311971; c=relaxed/simple;
	bh=mkiGl83ZOFmo9Unu14I/y90wPbJ3U8FvcOR3CfobyL0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HCRJ243xB+Sb6qt3LAKjAxXnjwNC+Ym1SiDuOzsU6UYTunmcASR4z9w5YZWw/Qkpy6dGQ2V5ZqvkCuk+R8rnGB4/4GsVUfT7eX4KMh+ql+NpEi042cp0XW/gR/DdoVWq0RaRQcRn0ydV81e9upTwybfiXHQE+tJzhDH43qv8IN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cnlR+nab; arc=fail smtp.client-ip=52.101.62.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cnlR+nab"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2O0s1Bb0zvwOCQhKBPW1XDuKVOQo/z2zv9eNhsGhim3ADIgZ3DzEVxZpxvI2mqK24vAuWslVsTFRgqDrTYiApeCUxEMFgPLc/c2nDZkm3QVhTCH2hZtRDsdew5WDhJ62R99UC/KYA8Xhq4mqJ65kmbcEmZ3JU1do7uWUxzM1NZ8gxcV30An+reSD1eaKsEcf5XwZvrq7+ATstxcGMW7ThU0ePG0ZsNyVH1RDBBlgR9x9HCbeaVEC0Q1aAkO0+UILFiFegXzRSJvcf6Z5oH8WW6wTVoK5cF4Pbd1eZ4PgQ+Mq63Baq6BL+dcmKGAKt/QUwBoIhDNTrjxabxnkPjIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz3457H9YI8hx+JpcjW+9ppXcjapYyM5UEecyRtZHnE=;
 b=frjGS45mz8szmmd6bhgQEF6XUqW47zv8nMfSOVEKuR/r/VtNAefFXrQZWPDrbnOOHDmKc6+wbBp5doG/tYd2jFtsWGAyX7bFS/JUmRf1IBrR+tqjayXHBqyAJpQ3b7OQBvftlfpRptG8AnFsSMo9Q3E4j+aVIUikW5bwnJbOHrv8Fe6nUIK/cW/COp/3+bKgvAr0WFrJbmIxJKHWyIOElei2PVS4v73YUSl1VXsXN3sdrV4HBTFs2JiRp5dgP0CmFoI5yrzYcGPWqFEla5LM9mNT8xvnMzSUpUplsomXZrdCeae/gYSKtnXxrZGttRKLrKcsVl/LM3BMlnGSA/63OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz3457H9YI8hx+JpcjW+9ppXcjapYyM5UEecyRtZHnE=;
 b=cnlR+nabyjYZw/2W4wEIugOaIMNsdY8R+3wUVwIzmxV+UlMzAox7fqX8lkzqajwtFWwYeEuP9drY7grOFujWbcR7okvQyChsHKn5qHE92rob5V6CwaNq8aM7B8B7XrM+c785dRZ7KoJRAgX5l01oGjGNRaqs1Yi/C2l8G8noeFo=
Received: from DS7PR03CA0338.namprd03.prod.outlook.com (2603:10b6:8:55::31) by
 MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.19; Wed, 24 Jun 2026 14:39:24 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::a7) by DS7PR03CA0338.outlook.office365.com
 (2603:10b6:8:55::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 14:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 14:39:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 09:38:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 07:37:30 -0700
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 24 Jun 2026 09:37:29 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <sai.krishna.potthuri@amd.com>, <linux@roeck-us.net>,
	<erimsalih@gmail.com>, <git@amd.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Salih Erim
	<salih.erim@amd.com>
Subject: [PATCH v12 0/5] iio: adc: add Versal SysMon driver
Date: Wed, 24 Jun 2026 15:37:17 +0100
Message-ID: <20260624143722.4047649-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b39799-a93d-4495-3373-08ded1fe61d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|11063799006|56012099006|6133799003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	LYO1LaxWOJ1dYBJZviTP3VPeBk9BuEWZv8cbRcPpi9r2GjM5CMq3UC9L1NQoytfuTbdEkhWfMiDU6yLYFa/Ec+apLv913mvdkOUdW2jgqHBipy9iLZXXFg2Xe9XP3Zv72c9cAK3lTlXceyBVSDhuhewRTS2B+zEZjRZW1VbODZd1YEktkfk0a9KK6fy6dMROz9p5F5d3Ck4ZbhaMhZI8HZbAptfBY13oosgO8zXlUbVuQtpvdSP4O0PQuyujPr3nnoq+fdIevdVEiMilwmf/Xe1zt0X5nI2WXqPPVjTUKN25m81WTmDUZgEQ96hHZALdnmyLj0sQx9dxHLfDwjzwHoR7CmBNzW3I/C9YSS3qM+NH2ogQ751xC0bllO2XL8s7pae1UPYr9Q2Zgv6/TjgROoUfWSuBH5AbJI5AWwTlPDqQhCLUTFUQkwH3mDUqiOkNQx9RX66wQvvGm6v1WngU9irOxJEfra8A8Fb1WD+9Jsh54QlDGp7ScERiCEorpy5YP5GtsTuVpbZ75w9gMrprY8K3aMNgxv+5i4E7g5Idf7D6WGdBLh7Wmgt0eHLiO3wjOY9GyNQzHJrllT3V5+hlQaMZ+kesOFdVzAGujGPSk8dBPYoiCVe5O1QDD6cg4r3vGzT//AhuQq8xgJg/EJhs6bDg4ZI77rbJHWOifE+USdVL01cM32AwcLOAidGZkLfMdYbTJ8+1dp2AJu5AqIRYcA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(6133799003)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I8mAIbQVsDD+joz+G2iAngBo6IQsw0n0Gd3XOw6Zgnzr7xhR1s1fKMKTpRS8rC07/l9I/2j/S+63m72LFzPDBnsNylcLZsyWzd/X+sjF3Fxisnoi0UF1JJFZ9PGUjO1kKTzaMa8W8tA1ozGxaw70OJgnUoYJGbpcbCjyoeqGFqHck+aUfojZPJ/I2uHqArmTUE/evgo7PpmlyA46x1e0x97wzzXiemS96ldRWvmDWgTAl4kM638QL+zBY5GWVb0znsAPA8JguAUoL4uzOMiOUruPmgIcsP64drsAsB+6QEeRKEq3W4sey1KhGrIaBow7zOkbCjkzsa8EVv1HkZWr1F02owmAllDPta2aVjApyIeGFk6Y6sQyzlp40xiy61YlIWiiZ2Nd6uR2XyvpkA5VbudgV5d9xxV2ewJaeIzyl0bLYFE8qR2Ej853xYWvlUNY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:39:22.5957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b39799-a93d-4495-3373-08ded1fe61d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348

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

Note: Sai Krishna Potthuri is added as co-maintainer and will be
actively taking over the upstream maintenance of this driver going
forward. Please direct any future review feedback to him.

Previous submissions:
  v11: https://lore.kernel.org/all/20260623014036.3865402-1-salih.erim@amd.com/
  v10: https://lore.kernel.org/all/20260618101414.3462934-1-salih.erim@amd.com/
  v9: https://lore.kernel.org/all/20260617180147.3370346-1-salih.erim@amd.com/
  v8: https://lore.kernel.org/all/20260616131559.3029543-1-salih.erim@amd.com/
  v7: https://lore.kernel.org/all/20260614233722.2603459-1-salih.erim@amd.com/
  v6: https://lore.kernel.org/all/20260611222738.2035062-1-salih.erim@amd.com/
  v5: https://lore.kernel.org/all/20260608183801.1257051-1-salih.erim@amd.com/
  v4: https://lore.kernel.org/all/20260606051707.535281-1-salih.erim@amd.com/
  v3: https://lore.kernel.org/all/20260527114211.174288-1-salih.erim@amd.com/
  v2: https://lore.kernel.org/all/20260502111951.538488-1-salih.erim@amd.com/
  v1: https://lore.kernel.org/all/cover.1757061697.git.michal.simek@amd.com/

Changes in v12:
  - Add Sai Krishna Potthuri as co-maintainer in MAINTAINERS

Changes in v11:
  - Add input validation for threshold event writes and clamp
    computed lower threshold to Q8.7 range (Jonathan, Sashiko)
  - Add oversampling info_mask to static temp channels (Jonathan)

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
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   33 +
 drivers/iio/adc/Makefile                      |    3 +
 drivers/iio/adc/versal-sysmon-core.c          | 1052 +++++++++++++++++
 drivers/iio/adc/versal-sysmon-i2c.c           |  134 +++
 drivers/iio/adc/versal-sysmon.c               |   92 ++
 drivers/iio/adc/versal-sysmon.h               |  120 ++
 8 files changed, 1596 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h

-- 
2.48.1

