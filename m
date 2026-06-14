Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013048.outbound.protection.outlook.com [40.93.196.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A2337DE83;
	Sun, 14 Jun 2026 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480254; cv=fail; b=sL5UjLnOvbd3DyAbaN1BF9SdSZ66AIIrVOVazDGZCpBEtzWeD5Bl5DhRVJpqadF+t3uMy/2Dftdr1TkrgXtmspWe4FdzJvut0JlWXCoEMgpmKEvYQWzrXCJ4a/Zn0IYGnsl3JMJXSs+HyiiNA1mwhEJizQJsnhfGXBS06D9Er9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480254; c=relaxed/simple;
	bh=ODkoXDnhzhKeb5p+bi0/9gc1uCclpCQCKrjyBHlLNM0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RbR4O6XzvWIvDBeFEoPLfZ90ZmHnGrEhor/TNujyO3528ZcFwA+W4YgLhvKyKdx6oDjuDEKhCidAN2JiPYYSR1ojGqHcvDCt5ekORnMKGNRt5ijXkYo9Xuy7fHEdxYBuRZeX0kDTt4VCyYpXprmdK0G0/YTeqc49vBVaiU1a7Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i1X25VF5; arc=fail smtp.client-ip=40.93.196.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i1X25VF5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prBXfUqSCL2dJW89uqpXVscg7cyyRIqGcOsQQOlami6nKhjgKV8NaO4WzlKbiYN/lDeK2481B0tOJP/l/duzDX2TZeGwiIs1T6yLeSLOdx5PV7COTqHT7Rk/GvTlyVHuLErLpQqk5jawxCTzIpx5Fk8y6gMBB9nFmR0Car6a2WUxTmJ1psVwXCpvJs/H8rtzE4UkJOiKhytXszjYOrKaYRMUZ/3nEQCyd0jhaQ1+BbhOeK0KtD0Rm5mTAfgH2u+FwUtvVc39femEzjdFBtm2kOy/jx4LrKBJiiTboFboOBwFsDPQrtVqGGFnKTNWmJdC6t0/WHw1jUxHcG3X1z1GIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIqczxuNlZqMhTo+WH8qlKtNnpM6VyrQ5BYroqfrkuo=;
 b=QGeG0u32w36OEmliJlXtztkcH/D3w5qfJkpMo6ZysyL+1ZfQnflBztom8wLrMVv8CC4Fzbi3S44mV/TBdMDU85lhAptnyLuH2KS0MyD1PUW2pPPeqOT0sTY90f1LGtJO5euFuAiFbIc/EpyHMn7lcK/5Jx1kX7znOhRTAZWu0NSYYRGNFk/1OVdvh3zNDSJCWDmMOsG51iU5p5SqNsHEcJXKz9HT3W/N6wg/1EKtn7esn9R000zJDWmMPN+131ehL0xLoz1kr/96P7KdeEO/KlSxOYxBA6dXd5jenqJAWmEFlKBfpiLf8bSiOtRv9F9tdUp685pLX62ec0YmaZSfIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIqczxuNlZqMhTo+WH8qlKtNnpM6VyrQ5BYroqfrkuo=;
 b=i1X25VF5FFzjG3WE4tacBvoqwc5rkLnvuwIrk7XqrmMe694/xNXiIC40XomvP9lWYYzbeHep62cEV12vf5JA9A/86u6tCCQyVu/KNqq3C4IbghnBXk6Ch9EA8RDRVNeSfq7APwF89CFJgsQSsLpZlFifASZvxGxfUGBSvxcL1U8=
Received: from IA4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::17)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 23:37:26 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::84) by IA4P221CA0007.outlook.office365.com
 (2603:10b6:208:559::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Sun,
 14 Jun 2026 23:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 23:37:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 18:37:25 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sun, 14 Jun 2026 18:37:24 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v7 0/5] iio: adc: add AMD/Xilinx Versal SysMon driver
Date: Mon, 15 Jun 2026 00:37:17 +0100
Message-ID: <20260614233722.2603459-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 78654d30-6480-4042-a382-08deca6de425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|82310400026|36860700016|13003099007|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	TZnJf/wrZsCuxHStEPFAVug45liKxJHgblfrU6qecKyCn9oiJQX6XBXUvuVT1xPWA0jMYL5n27u7b0dMUyUPi1TAo9KA575UiSaqFM7NPtS0yEc6Cff7KeI232Pjc9UgXtinig6xFQqVBJ64rfzVDph2eQ6vTh/snqrjxqyt/9LH2jxG3oEzUoXujghwwdblrMpZ2jN/SKj0v3/5p1qUxecy/8pEQTNvkHXDhmIncbGmZpfaOw/BcA8AB4cgYtZsV1Lu+hJ3DagkdRRUY15MHbMid2BZqRZid7JVMSZu/fnQetpTayV8gsH7QU7G+8lI1hvBATYCeMW35aVr0yjhTlBehA5KbW4OFQH5zKQ8SqpesbokmyXbw8fhSbhVGDKFWp+Qqt6CP+JziHK7xlWvWsGnVN9BX/4V+oAO8fujSngeTYrL7Rd7LUQR3W4bQN8/xswG29+S87Gi50rlwkKpmMKmcUwWRDWI7cUfcTZC5xQqR5Ia5nH/hkVVqubidoqQ9yt/t3cDTxJhcAybPUabQB0Fw9ZUnDasVETLJDPPbWNie49CLsq1KoZ7clc9WF+U/6IIDVIyJbmXo5r9TmPe/kylKknlV9+Ldfcl2qFSXweS/lKucS99R4SdfqAZc4IefyekT8uiyo87XJxwmOz98H9N86beYigUC9w7KD3QgSF7H2pNhIdUUCDDga9vxSHPrNnT5nidz/1fHdnEkUhhjyLAAQElx/DhUwEEAMacHv0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(82310400026)(36860700016)(13003099007)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rBnwJe4wJXg8JM+RRfEasq/WgA7S4HPSDoR04iTpNU7q8mLciP3s5gw533LtMKyFUuweNKpIyqXrY0UA0hjjh2WZSYNCQiF+Eq36B33VRUEfNKkFLzFUWovZooxuEXwRF1U2W2pUmlvbCifD2I+b3dtMIYGaCljYKOCjR7qO9uIVZuGv9YlcnWlCUKpvsetmZAdsBMgzxvBtcoi62rcI3hV7n7jIfFLgN8Y1ZqTTJ5/yQ9Jyl48KXfNw0zmVqgDeto6vQxK3lfoso2tcceXyhR7Yj9Q4fTaUZlFjWdFemQtQ0Xeblt1Gbc+PElK1sZGuCSqm/r0YMpBjq0y06/RZO7CVf9I3Dk7+y4WjlZgjScmXdt/fUXIsvrGe/887oTEtLBrDwJbSDVl9FLGikB5I+xc4WdcjJZd/supu0FwENaZKfUah6S2Vq0LoXffOEo9U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 23:37:26.0663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78654d30-6480-4042-a382-08deca6de425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317

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
  v6: https://lore.kernel.org/all/20260611222738.2035062-1-salih.erim@amd.com/
  v5: https://lore.kernel.org/all/20260608183801.1257051-1-salih.erim@amd.com/
  v4: https://lore.kernel.org/all/20260606051707.535281-1-salih.erim@amd.com/
  v3: https://lore.kernel.org/all/20260527114211.174288-1-salih.erim@amd.com/
  v2: https://lore.kernel.org/all/20260502111951.538488-1-salih.erim@amd.com/
  v1: https://lore.kernel.org/all/cover.1757061697.git.michal.simek@amd.com/

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
 drivers/iio/adc/versal-sysmon-core.c          | 1041 +++++++++++++++++
 drivers/iio/adc/versal-sysmon-i2c.c           |  128 ++
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

