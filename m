Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06563FB079;
	Wed, 27 May 2026 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882152; cv=fail; b=AkwohDjDRblZjo+gCx9SHcVuOUesfQ22FiPjQdsTsFHIJMlydDP0U4W2AA0FG93vL4hdB1EpFWkl0bvaXtB9IFtiYls8rrknF6EA1XZv02lH3aF4bbRYe0hPxeh1Od5dbsIExYSUoqxYbzzFkYV1BMNV1kEhWdAchJIMdFOIDiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882152; c=relaxed/simple;
	bh=zokZxK4RnyisDk+b74C8XkiDhLj53ZJf36lsaXFNxM0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hbgky+MQ2T7oVSb8idWsawmhic6YrnJOvddB8ngR8hbYueVtvz2SwrzBBfdXoTxRsExhWeDfCCz+Kp7Ja4ovcoIQlMJi1RQwnmWvIYHi3QHYfrF9Jn2009lh2428Bisj9LZc+1u67UDW1lUfEtE8lCFCclHPpny5M+1/XAIs7Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pf9/1xhl; arc=fail smtp.client-ip=52.101.56.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pf9/1xhl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rx+mAJtBxV6Gia3qpvvQavkxbBnjDgGo6vtCOYIfdqJqOKxywcNrlbV2oWi6RFoEOWtjhUFY8rhZzdlGlhTl1emRPXxJQWohv7M6nkSjLXBcuvnsmAX5vcam3O5JzSGQPbtl04ZeCclDFnjMoXh+BRhQAmOUMCG+7BgGMDvNP5Aav0jJKo47bXdXNijZV036mRnTOS05q3VNfT1iarwJhEYIQ6uEnTy0eDCGE3Qg5mWA6dp/P02Q9Y6VXzzLZ1iBwcmlGDHeVC9JBtSq88egOu50U50igsFC71td2wgwO9GWA5a4K16TnUjJ/hMTBhv1opPZnikKbjIn4eix+MpxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXmXiGzf3l2EjM0+TkGuHN0boObteez9O6sldl8uTAI=;
 b=KAlVJBPfRHgGQa5xCBnjcKQyK6FD6pO0UH0oUra3cW6wTS5egHTHKBJJKa69NABnaTr8npWoGzQz6864cKa4H+Jb63C+onKSe1PcK+S0TtLkAVjSUpBr/rq8qlJ3febq4jX8r+Vyk7qS11mbRl3L9n7iQGDhK5RCxS2pvB/4DPmPABMCs5P8ASSrGkwIMC+dGu5704KtePINcOsvobvOQVJCKtH5t437caBmlpygZBTJTZzxoGINd/hzR3lu+JHdIjphQepp/4QPBxq/aAAkPPXcNuxl1ELVFbegOSL0FOO5E81oUYA5e4WAlBtT7vlhxRo+6gOJ9Nz77i85xPxv3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXmXiGzf3l2EjM0+TkGuHN0boObteez9O6sldl8uTAI=;
 b=Pf9/1xhlml6EkJE7FLG6P5kuB8y+/oJ/YlkNHHuHsWmcHID3PlNepagb99ItfW8L6QCXIdn6SoYCA9cCibe1bOgLPHRj3u2kVA0uhdescAZtZFzc0Lclts4kspwumy1mVhby6FZgG2Xbgs2skMsoo+FwRnbB3qaPiNujLFMdY84=
Received: from BY3PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:39a::20)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 11:42:22 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::31) by BY3PR03CA0015.outlook.office365.com
 (2603:10b6:a03:39a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 11:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 11:42:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 06:42:19 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 27 May 2026 06:42:17 -0500
From: Salih Erim <salih.erim@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Conall O'Griofa
	<conall.ogriofa@amd.com>, Michal Simek <michal.simek@amd.com>, Guenter Roeck
	<linux@roeck-us.net>, Salih Erim <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v3 0/5] iio: adc: add AMD/Xilinx Versal SysMon driver
Date: Wed, 27 May 2026 12:42:06 +0100
Message-ID: <20260527114211.174288-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: c7bebe3f-a87a-42ba-060b-08debbe502ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|11063799006|56012099006|6133799003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	/IAkOQOunrso0tcm4AOUvuv/AAokJ8pAV9vNvH2Z74iDZgS6q+h7TcbjGZsMUG68GeLrh0bkWZahGB0+baEX2Fuz5DDBFJ/j9hxAeWu4N1q/irkWbkf3PIHydzr/IGdWOiDgf3qdQ9B0UmYIjNB4tfFZ8vfd15F48xi34xnCDApydmyIiEuSNrvR+qGubESTkplpVuSepCWpDGFxP5QpqLHcUfIPnhGGj/iZkL2nH3rxIHbh9XpW+h0BIB6FN6eeLn+xh13DvRMHW2i/h2pqhKMc+dUp7Uxwwkc6Ja0Y3wxvludhj/o1h4RqkZL40V+oY8/hvGXiTb/EmmAphqgqdpDhmVbJVVRqlAoas7I52z7SQV1lSEkb7vLB7gB1tZCvmFlvwlRzIVuNMdc1FeDO/c9q3m3FkrtN3+HzqdsELzrA0yvT2WdCqVjsETOt1Jao63VFULbIb4k5AGgKI0YFd+LN4CdXothZfDOynOyDqhp32w3UJCP1t4BF2ZRXsAL10horqCSTqnDoJl1keUu+0lZA3Q5W5fTZRV6HpM+k2/wX3Ev6aOVcqy5FTDrThgX/oetIwG/fp8eQLIb4vZhpP0qFfyoOoTRP3KarwNKFKm+gKJfr8RUBZjc/qAZduItaicwCCXfzxJx4bFNPVs2+lHunajKMUOKcm9XOVGZVDkQ0FXNKbdNkkPVjMN3/bAIl
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R5akZwreWvllcO2JhQgoVTxjIHOleotTYcrsPHoOmVhwzytKsuasMO1yCQHU7KrgaeM5Krx2wzUMSDpYML2e/3DaF5yrGZ3p50Fma3oj6BNzy3kKpORS/p3aImp13l8EUCbRy5QN/OX0vvO0SfZ1nhVmEMZXva1vW7LKGjqeJvefV7z8kVSK/PoT0DfW8JJ4aInEytYzMgEiL4Hw5kAv89f83khoX10fVcSSNVqxANWIelXYr925oQF1UQu+kUibNa+g7C794rkdwpy3i7kPATvEX8tl0sJDR3J1NOFlrqc4n4VJ8jFO5Tq7+U+U8ujbb3+AvJ3mcROMuifjAx6/RfzZ+SDR1QNZhou/ObPC4bBufHLd77J28Gt1SASlyLuh7dr0BL0AqvyWGHmFilIUmFBpfQMRlaLfbHe5qKb73NVoLHc6xjo7e4HTSh5+0z9s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 11:42:20.1222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bebe3f-a87a-42ba-060b-08debbe502ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421

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
  v2: https://lore.kernel.org/all/cover.1746182670.git.salih.erim@amd.com/
  v1: https://lore.kernel.org/all/cover.1757061697.git.michal.simek@amd.com/

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
 drivers/iio/adc/versal-sysmon-core.c          | 1094 +++++++++++++++++
 drivers/iio/adc/versal-sysmon-i2c.c           |  153 +++
 drivers/iio/adc/versal-sysmon.c               |   92 ++
 drivers/iio/adc/versal-sysmon.h               |  125 ++
 8 files changed, 1661 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h

-- 
2.48.1
