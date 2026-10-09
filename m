Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9759F3D647A;
	Fri,  9 Oct 2026 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555154; cv=fail; b=Wt5goC5WVDay2qPvE4Q+6RkSc0bmEWQSphCO0oTAyXpTeTl/BXoE/VL3lH8RTnfYAvK+LGzvPMoafkmaQTR4wouQweBI08A1LYHkoQzLSkK6rbG+aiK2M28SH/tokj21jTL0XzpRSkm+83M7tuogCkdUqn/RkKmj9Tlz3gFAYMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555154; c=relaxed/simple;
	bh=zQPyB0Fl62rVGJoOIsQYFQk6aorIN8OLw/DZijz7TGI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=SEIfQBA1raFNzAssxB8k7134wirTPmCZ8WPFfH3iLzokYy8AL2imxm5ldKlzZ/kjq1hOYK5y8wyQB4hzZM7vEghCHb1BKaA6G1hPbbcMToXvGI3KEZgmBJkN/NoN5JGd46r+Wh1PFsAc1SHkqI9I6/PKkGWjDrBDFSW26ErWJCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=kmjN9ofi; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="kmjN9ofi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfsOt2HEqS+kGRtCIxlEKj+dbDaxQiKjv5/v91VqEMInTtNuc5SnV/xPN0zQnH+YvXG6at05VcEKaWY3XtM8lGqINsuSXr2OF4zfM5m6VedK2bUpu4xVIxNbP2yObpR3bX/MF0oO6WJg7vOcRcBs0Br6CXIuNN7YsiD/Yis2mPIid14/fZ12vRI3dyV+wD6qohpr2zrXvZsvdCq6pbgtWM+xPU3m+EWcVMin9fnafeWmR15Aq+nYW44PIUHvOMym48Bh/+yY+KSHBiCczXaT/jNzGPS8dLxH2naG5FPlN5Tuei1KXhcMoBIQuwAizRjtgHDL0KF/1DcjcoICJzW4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sL51BOy+lMBB6ZHgmalVEj3GtbUbpD/3WdxaoeircZU=;
 b=Eb+T14EIawgDn11PCslozjjYk6H1XTL9IzKWr4HLvmxVqB2NrRbfjUBEcG/OBDOAihigDs8unwzSgp+MRQ57c3XDp7+2Q72OOhO1uzNmpnT4P+wWZSOhhhZeSGnjwJ/L5++rTrX4uJS1LrrvS+g3yoQinbqu6Y0etmtDb0euXtt1FSx2stBDpzBZvtcTqUH0HOGGwjjvqKbD4ORW+77D0/96iOp1K8mvPfGDOCoChrD6DYey9QfA/9Julkp/eNJJHiHVUj1LeT7OTgg+9TIhwSWjZOgdMdxDo4+iXtQmBHNkyEKa+gZPj8WqN76yvzWEI4uq3uDCvUvJZQAR4YbUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sL51BOy+lMBB6ZHgmalVEj3GtbUbpD/3WdxaoeircZU=;
 b=kmjN9ofi7SB5waLlGlUi73ruTCn+YBUXeqjb+hLfx7ijDsrOX7NrV0jLos2TTUIkzmndcORX5izocmklCiQ4tobe2usvtqytncZ6PTh1fsASG87ZYt9G6qTbjSnG14lz4OAbFhMWZa5lHpKOnPJTUjEz9GkkGCrRnIo4ROAzxgM=
Received: from DUZPR01CA0219.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::16) by AS4PR02MB8646.eurprd02.prod.outlook.com
 (2603:10a6:20b:58d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 14:12:26 +0000
Received: from MAD0EPF000008AB.eurprd04.prod.outlook.com
 (2603:10a6:10:4b4:cafe::7e) by DUZPR01CA0219.outlook.office365.com
 (2603:10a6:10:4b4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 14:12:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MAD0EPF000008AB.mail.protection.outlook.com (10.167.241.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 14:12:25 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 9 Oct
 2026 16:12:24 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 9 Oct 2026 16:12:24 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 34CAB1731;
	Fri,  9 Oct 2026 16:12:24 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 26C0C30604EF; Fri,  9 Oct 2026 16:12:24 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Subject: [PATCH v6 0/6] Add support for InvenSense ICM-42370-P
 accelerometer
Date: Fri, 9 Oct 2026 16:12:05 +0200
Message-ID: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADX2yGoC/23NwWrDMAzG8VcpPs/Dkmw52WnvMcpIZHv1oUmJR
 2gpefe5HWxdluMn+P11VSVOORb1sruqKc655HGog592Sg7d8BF1DnUrNMiGsdW91XmY37McLZI
 3Jy0S2INh7iWpyk5TTPl8T77t6z7k8jlOl/uHGW7X71hj+H9sBm00e9OQT66xmF67cy7PMh7Vr
 TXjgwfa8Fg9QBdDCslzoJWnX98a2PBUvfciBGwRwK28ffDgN7ytPoWWPCVAknbl3Y8HY3DDu+q
 FHTbQe+v++GVZvgCssmYBrwEAAA==
X-Change-ID: 20260629-b4-inv_icm42370p-ccd671066bcf
To: Henrik Grimler <henrik.grimler@axis.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jean-Baptiste
 Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
	<joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>
CC: Kanak Shilledar <kanak.shilledar@axis.com>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9203;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=zQPyB0Fl62rVGJoOIsQYFQk6aorIN8OLw/DZijz7TGI=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsg68c3myN7nM1/mTKlYvGc226W03pm/MhwfbH29Lmsr8
 8HEW3UzYztKWRjEuBhkxRRZzhltj96f/E93jrTTJZg5rEwgQxi4OAVgIi5RjAx3cl99mCziuruz
 fbLjei7GV0qqq17tEH8lkn92pskihyf2DH8FV/+8Vmv5YvH9ePMAnwVblgvMcNzb8krg3P5dz2c
 57T7FDAA=
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008AB:EE_|AS4PR02MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: 7706ad62-1e2a-4673-a9b9-08df260f5859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|32650700020|376014|1800799024|7416014|6133799003|18002099003|10067099003|13003099007|3023799007|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Cf1dgyBj0dGemt+1I4iUZD1j55BmUL3tz1jnP4CUcCR01XGcv+BMBw31UI2vIR+7wyj+OGG/YRqVzy34tRGsBJ4kEoxG5DCf2YYQ3G0wyWsfm9Hf764pdLe9C7ta3A2YsOmGUxBx6Yiy+j/rTmZGKMkhZDljBiKLFoMcDRdY4G6f1IUPLttPF/m55ZuDiqlSAcvoOiVwha1NfguIM5I+PM0zBKiR8Qtvv9Eu79BKYc85DRxvlIwyvlxkuD8VYjsfA3yX21J5QYH5XPkBweabvDmrGqn8/yL/PmPtQBkDUyo8QV6y1BEsE66+yYKGMUJn8ayXUicyuPsqxjVRRFVyKLPNJ7hVe1k5BwdvOmmwCX4bzp/azdbfsQSLONnEUu1xK91dkwmaz8EKMrDaW3wZMtr+UyPA8AZv5o38egwID0pnW103UBFeyEiuksCFMXmpPsjrkiF9bEecAfV8KhIj5HkrT4DHCyRp1IkBz6zjFlr3kxKrHgZnJQTeAti5Hxxuzlvv7mV+FulG6wUv5E2yttae/RdI64RbJKNyMu+mKoecdMMBmH+rQg1GdQSmgxTeiRYmPGxQZ3+zFz9BLSVfe8PkmOkGIQ6n8MTusKMdq/ZA3FGmYXA+iM3AkiAcpIYpGERezS6+WZu2j95RXxLBKWnwTZuPN6jjsM/Fgfz2MB6CKGh7K75ApUEsL+SbAJc3
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(32650700020)(376014)(1800799024)(7416014)(6133799003)(18002099003)(10067099003)(13003099007)(3023799007)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gRpgU+Q2h6ydLKfU/C/BZX8XXLa9sN0bdWYafY/Yp0JecGQd5dTOwzuK612VPN5B6myW0Y9iQ4ZKok48wBnA6VUbyWf6TkmSTNxIZXqSeELGZuz1OKgJarnK7RTnZLSMrGZT9cwF6EpNMwPZCUz1HAFYwfh+ty4PXc/ULPM6YdS1Dp0ZZBwd5cHvlew8Bo+HeyTipTHIvW8kU+XeSa3wX10g/J9YuxSBIu2NNzculSPUdmfIEMb/T5OuJnH4oZJq/1OyFtszfQTRPYerwZMN5FH3qusfmmhJJ7Fv54eb7QdUJflybC71hRuYO1T8IsL1xTyq+DH0aw6fCkpod4m85Ysn9oJn2I/Nqco0mtkkJiQYs9VnmzJJRY7/Lb6zKEklKKNhWrV2akhCZAobqcLHb+0a+72jnL/AXUqFVEZUsbeHOaHqrYCMDa1s8vigu2bo
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:12:25.7669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7706ad62-1e2a-4673-a9b9-08df260f5859
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008AB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8646

InvenSense ICM42370P is a high performance MEMS MotionTracking 3-axis
accelerometer. It supports I2C, I3C and SPI protocols. It has a 2.25kB
FIFO and two programmable interrupts with support for ultra-low-power
wake-on-motion support. It has a built-in temperature sensor. This
patch series adds basic support for the sensor with functionality of
performing raw reads and writes via the I2C interface.

This device contains 4 register banks for configuring the device called
MREG0, MREG1, MREG2 and MREG3. Unlike other devices from the same
vendor, this contains a very different way of accessing the register
banks apart from the default user bank 0 (MREG0). The register bank access
procedure is mentioned in the datasheet Section 13. This is very
similar to the existing InvenSense, ICM-42607-P driver. Thus, it
improves the existing driver support and adds the ICM-42370-P device to
it.

While adding the support for new device, I tried to perform some fixes
to the existing driver which were pointed out in the v2 of this patch
series.

The buffer support will be added in another patch series.

Note: The datasheet for InvenSense, ICM-42607-P could not be found on the 
official https://www.invensense.tdk.com/en-us website. Thus, I am 
using the datasheet available at https://www.lcsc.com.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Datasheet: https://www.lcsc.com/product-detail/C5129967.html
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
Changes in v6:
- Add reviewed-by tags.
- Arrange ID tables based on compatible.
- Reword some commit messages.
* [patch 1] dt-bindings: Add ICM-42670-P
  - Explain the new device properly in commit message and dt-binding
    description.
  - Remove invensense,icm42670p as required from interrupts.
* [patch 3] Initialize gyro based on chip_info
  - Fix conditional flow with if-else statements.
  - Do multiple similar assignments in one.
  - Fix inv_icm42607_set/get_pwr_mgmt0 functions with has_gyro condition.
* [patch 5] Implement MREGx register access
  - Elaborate more on the bank switching mechanism in commit message.
  - Fix return on error handling in inv_icm42607_mreg_read/write functions.
  - Fix code formatting and reduce priority of "failed to clear IDLE after
    MCLK timeout..." to debug.
  - Return early in inv_icm42607_mclk_put().
  - Deduplicate regmap_config for i2c and spi regmaps.
  - Remove MREGx registers from the list of volatile registers. There are
    few volatile registers but they are not used currently and are not
    being on planned on using in the near future.
* [patch 6] Add accelerometer calibbias support
  - Move the Note to end of the commit message after ---.
  - Replace div_s64 with DIV_S64_ROUND_CLOSEST().
  - Replace masking and shifting for accessing the USER_OFFSETx registers
    with combination of FIELD_PREP/GET and GENMASK.
  - Fix switch statement by combining similar return types.
- Link to v5: https://patch.msgid.link/20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com

Changes in v5:
- Merge the dt-binding properties into icm42600 binding.
- Revert the unnecessary moving of iio_chan_spec_ext_info struct
- Move the addition of has_gyro property to a separate commit.
- Reword the commit messages for few patches.
* MREG bank access
- Update the bank id defines.
- Use graceful error handling when clearing mclk bits.
- Use FIELD_GET macro whereever possible.
- Change to get_unaligned_be16 wherever possible.
- Revert removal of _is_readable and _is_writeable functions.
* Calibbias support
- Make _accel_calibbias array a static const int.
- Fix casting of values throughout.
- Link to v4: https://patch.msgid.link/20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com

Changes in v4:
- Drop the little endian ABI change patch.
- Drop the odr formatting patch.
- Drop the gyroscope calibbias implementation patch.
- Reword commit subject for changes to the IIO channels macro.
- Fix formatting across patch stack.
* DT bindings
- Reword the commit message of dt-bindings patch.
- Drop the MAINTAINERS entry.
* ICM42370-P support
- Update the probe to select gyroscope functionality based on the
  chipinfo struct based on the `has_gyro` member.
- Drop setting gyro member in the `inv_icm42370_default_conf` struct to
  NULL.
* MREG bank access
- Update the bank access as per @Jean's comment to make it similar to
  icm45600 driver.
- Use the regmap approach to handle bank access.
- Dropped setting the default configuration for the ICM42370 to be
  always start in the LOW_POWER mode.
* Calibbias support
- Add calibbias to `inv_icm42607_accel_read_avail()` function.
- Instead of clamping out of range values reject them with -EINVAL.
- Fix return handling of calibbias functions.

- Link to v3: https://patch.msgid.link/20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com

Changes in v3:
- Updated the cover letter to match the implementation.
- Add SPI properties to dt-bindings and fix typo (leave out I3C for now).
- Move the implementation to inv_icm42607 driver as both are similar
  devices.
- Fix formatting of the drivers based on the comments received in v2.
- Switch endianness of the driver.
- Update mreg checking to perform bank access even if the device is in
  OFF or LOW POWER state.
- Implement mreg read writes and calibbias support for inv_icm42607
  driver.
- Drop buffer and interrupt handling implementation for next patch series.

- Link to v2: https://patch.msgid.link/20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com

Changes in v2:
* Changes across all files
- Update MAINTAINERS with company mailing list
- Sort/Cleanup of includes
- Use `guard(mutex)` and newer `pm_runtime` APIs
- Fix code formatting and add empty lines
- Be consistent in inv_icm42370_data variable name
- Fix MODULE_DESCRIPTION
- Drop secondary state struct and merge it's properties in
  `inv_icm42370_data` struct
- Update mreg_read/write function calls
- Change the compatible and filename to `icm42370p`

* Changes to dt-binding
- Add dependencies property
- Made vdd and vddio supply as required
- Add description to drive-open-drain property
- Add mount-matrix property
- Add interrupt-names property

* Changes to `inv_icm42370.h` and `inv_icm42370_buffer.h`:
- Resturcture the file according to @Marcelo's advice
- Move struct __aligned properties to the end

* Changes to `inv_icm42370_core.c`:
- Fix _accel_scale[] values
- Add IIO_TIMESTAMP to channel spec
- Update mreg_read/write to fix bank access
- Replace usleep_range() with fsleep()
- Use constants from linux/units.h
- Call `_update_fifo_period()` after updating the ODR values
- Fix mathematical error in offset calculation
- Implement handling of mount matrix
- Implement handling of named interrupts
- Use devm_regulator_get_enable for the vdd/vddio regulators
- Use better error handling
- Move iio device registration after performing IRQ init

* Changes to `inv_icm42370_i2c.c`
- Change compatible string as per the binding
- Use named identifiers
- Add `id_table` to the i2c_driver struct

* Changes to `inv_icm42370_buffer.c`
- Update FIFO enable/disable logic
- Update FIFO buffer to match the specification and handle increased
  size dynamically.

- Link to v1: https://patch.msgid.link/20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com

To: Kanak Shilledar <kanak.shilledar@axis.com>
To: Henrik Grimler <henrik.grimler@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: kernel@axis.com
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Kanak Shilledar (6):
      dt-bindings: iio: imu: icm42600: Add ICM-42670-P
      iio: imu: inv_icm42607: Simplify IIO channel macros
      iio: imu: inv_icm42607: Initialize gyro based on chip_info
      iio: imu: inv_icm42607: Add support for ICM-42370-P
      iio: imu: inv_icm42607: Implement MREGx register access
      iio: imu: inv_icm42607: Add accelerometer calibbias support

 .../bindings/iio/imu/invensense,icm42600.yaml      |   6 +-
 drivers/iio/imu/inv_icm42607/inv_icm42607.h        | 177 +++++++----
 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c  | 202 ++++++++++++-
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c   | 322 ++++++++++++++++++---
 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c   |  13 +-
 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c    |  12 +
 6 files changed, 611 insertions(+), 121 deletions(-)
---
base-commit: 04434a1d0f311d76b1f15fa987918b471a0b8c6a
change-id: 20260629-b4-inv_icm42370p-ccd671066bcf

Best regards,
--  
Kanak Shilledar <kanak.shilledar@axis.com>

