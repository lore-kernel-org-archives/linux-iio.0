Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2B3BBFDA;
	Tue,  1 Sep 2026 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273376; cv=fail; b=U8qhLuy1okhCiYPmBp1d6jjbvc4GVGjGesMFzDljOxR6RB6Tmm+bwRPU+d+L6Km6uqrA2qNfRXipRHkMBnxg/WC0FOZzLYYV+ep3JyR0mwxpUsy/AZ65YnEnT7OxSaBzb8xJ0cJ2iCTLKFkfunfvmZvqMqZGdSHieksMh7Vxns8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273376; c=relaxed/simple;
	bh=o0HEfwkeRv1DuD0zQym1qIftD/l+gblBfgEHGASXCAE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Z0cHs3WbtWQ0hfZAWLKmeE75LhPim7ktUPUJENUkEb8JeEO4doyNZZG4QPOB+L50pGGgRsLZhVao8jaMlT5rRnnh/wDBi6k7EHF+ptC4ni+litTaq8WoZDhXP5G/mxMdHGv1W6eaXVgZJyPo5OdPyvHwvLhMDWOhYH8i2LNaidM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=EBv3ey1m; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="EBv3ey1m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H71ctsi340DqF7mDdUD4y2/wmnQY0dZ8dXlgakMjOgRw4/olEwMLyMF66A4YKhC5RNQbD9n3doxo5mu9PXUKC8qdIX3VVvLLcPmhEWGIkJsq8Dlha8nL1Yzg3HBfZiJFFFI2PRPQEMzuKqaY5qUArEALzBt5RiuNhHEHLFpqCH71UjpjvTuOAdAdEdjzJk/7ZkFAypijub2SVnVgzNfQZcuMOPC3dWPyz/wrV752/i69DQFQkbepak/yPt5TdZkgMgldubsSaJFPzd4Hq/fFrmw4RGIOQpVGLZBpuci7SkWGlGCakpPjqNCFagk4VcbKdo3hIEseWKoX1fmWSNMDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0cPLt5oMhAJSmnnGC/iimNEibkhYg729wdupqspVxs=;
 b=OjCsV/r3OtRIjooGXnpl6iFX7CAsYlNyVbZR01Vhh/LTCBmSfp4OqtbY7FPhQIkosySdKN7D4YIQpuPf5g7+n0TKX5+B10BBBSfgNSAXBtkjfv58dA4QjD8FoMwDsE8nWf+kajZ/sktfRqNHrz6qmptIbxj67RlLbPzAQHuGQPRmAgJ+HzeYNQk6qWX/TVYM5nvMndpMtu7pKpm6lo5hR+P1cSw6upGgT/xQgFCppNXhKI4IgmUi/NKTp4Sqjmq7h1KxO/yKoCbMsknw4GSWTY+SvugISlgHdJYjYZq8Na52SQKIiSwuorCXSqHAwZF5Wqb5S+z8dlvg8Bc6dCeI/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0cPLt5oMhAJSmnnGC/iimNEibkhYg729wdupqspVxs=;
 b=EBv3ey1mu8mCHwAEMxImp9kH51TWqN/nTxMVQadtyQ/rJYnNIWPaOUIEQAvT+K+PemH/lNVjW296XkB85X4+eQ+MOaw1j9rxMUuR6Nb5avw1dwWeWvkquA9aCzSIaUkiN3M5COnSawXcbGg52w2OPlZOeldiSYBR06mDEXRHveI=
Received: from AS9PR06CA0310.eurprd06.prod.outlook.com (2603:10a6:20b:45b::20)
 by DU4PR02MB11215.eurprd02.prod.outlook.com (2603:10a6:10:5d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:36:07 +0000
Received: from AMS1EPF0000009C.eurprd02.prod.outlook.com
 (2603:10a6:20b:45b:cafe::2b) by AS9PR06CA0310.outlook.office365.com
 (2603:10a6:20b:45b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 14:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000009C.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 14:36:06 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 1 Sep
 2026 16:36:04 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 1 Sep 2026 16:36:04 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 9289B2AE4;
	Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 72ACA305D5AB; Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Subject: [PATCH v3 0/8] Add support for InvenSense ICM-42370-P
 accelerometer
Date: Tue, 1 Sep 2026 16:35:53 +0200
Message-ID: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMnilmoC/22NywrCMBBFf6VkbWSS1El15X+ISJuHnUUfJBIqp
 f9uWjcFXZ4L59yZRRfIRXYpZhZcokhDn0EdCmbaun86TjYzkyARUJ55U3Lq04NMV0qlYeTGWNQ
 CEBvjWdbG4DxNW/J2z9xSfA3hvT0ksa7fWAX4G0uCA0cNldL+VJXSX+uJ4tEMHVtbSe58of74M
 vtC1M566zVatfOXZfkAObubkO8AAAA=
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6973;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=o0HEfwkeRv1DuD0zQym1qIftD/l+gblBfgEHGASXCAE=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsia9uiyVZUih3reotK9cqXJN/q+WD+JkcgQeCJaYGpm+
 3BfzkuWjlIWBjEuBlkxRZZzRtuj9yf/050j7XQJZg4rE8gQBi5OAZhI8iFGhoYzmhs33DeUqrJe
 ek24W//ytdue/UZJy9sq7Cff3yMSysDwV/iSQljk0xZrb8tbF88/+Jl1cTnvR5lu+aksHpuURY7
 lMwEA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009C:EE_|DU4PR02MB11215:EE_
X-MS-Office365-Filtering-Correlation-Id: d28bc241-cbf2-4f91-b46f-08df08365b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|32650700020|36860700016|1800799024|82310400026|23010399003|376014|7416014|10067099003|6133799003|3023799007|11063799006|56012099006|18002099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	g8AqcKgGK9MXC3Sxc+3f5ZpNx9DhFR3p/OB2PthT0QwlFiFwi7W9wFCkFBka1dbAUC2/IBsgAQcSrIVF/8z4VMhrCf9Gy5t9VtYHVg6oX2LQCUgf9RvRhbuGmEHJrhkudA/yiTAbxAJYxp+tl943xxjTDXADSN9c/h3R7Src7bQwEiXQZ3qu8otCkTNGPYt086i2Is5zT5y94rGhAAn6Zg1sM7kMn7sVG7Sey6sQb9H1wS2RXsIYgVyDwtJwMcyR1otw7wvQ6bEiRbOk0qUiX/neZH7hrUkxx2iIKQ8atGWcKhcs8jTxtzyG+cLp2jkj8uaiNJ23OdFAn1+vdcrEwaj/zuNWsekCJxGXr2wMsWdQ7KSnVz0jP9KOgMEFcojQyB1hnRpY2R461m2q7Ls/br8tLrgo2LpRukzqKws5uWnPVoQ1BtS2Iitx0jFPJNjqFWfwgk+yns/x2PTGOZK8XnGjMg/SLdunCXw8RiUABLtUxpczaxfiv34llKnW5WKKZ7aieI49fTzWqnT/+kBGjIz9erCVbFo+5A2FHldYg/MgauD7Qy4t1yzg1EvF3hZkKzsyRVaarBdnuA1Poh22aht/v/qcNHYVmEv3QO/OKgvTe0Iexf9W7246LBLXFlakjbR9s/vI1dHq/2Fo0YJCxzRb8VhfmnMZ45baZoD9awDbQycXQ+nQxWIu7o28qaaC
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(32650700020)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(7416014)(10067099003)(6133799003)(3023799007)(11063799006)(56012099006)(18002099003)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0hoh+g2tEmLGW3hncFEnidH0mCu3xENFTL08N9V8lGO0UIM/jkIseOGoqfrOnUq3mdYNb7UwntimKO4O4uzkb0pIofr9lDtH+Ixo5gkSF+4obk33VWYjMj5fkk5kc67i38jSf7uOnynGNI9I7xVGsuf2BVTJcSWeqdLv24GGDWyGn5fQQK5kIl4JFDIah1fgxl8LJtZdOaJ2LTKjGEgf6yNnGXhpZmG5u3ONpkvskvqB7ohQoNzpXAB//VI1jPUsyuvxx4yRjvgeyb48ADKinUVVKfzrrkFY7EmfgzMIaCtAmD8rimSyB1jnCb/Vxf66o7v/0CsMKX5Zx40alxlmv0pqjL20mao968ea3TnJhkKVRbAC9ril7jEYe1dvgeosOwLw3axvp2BFZCb1mmZ6lRcDQMeBaD6CB1etKZ/dYQTYqgQti9/vXuZYSEFD5POq
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:36:06.0718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d28bc241-cbf2-4f91-b46f-08df08365b30
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000009C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR02MB11215

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

Question to the reviewers:
* There is no entry for drivers/iio/imu/inv_icm42607 in the MAINTAINERS
  file, should a new MAINTAINERS entry be created for the inv_icm42607
  driver with the original author as the maintainer? Currently
  `get_maintainers.pl` is able to add the original author to the
  recipients list, but `b4 prep --auto-to-cc` is not able to add.
* As per the comments in v2 from @Jonathan regarding splitting the
  driver into multiple files, should we still have the driver as
  multiple files or should it be merged into a single file?
* As per the comments in v2 regarding the formatting of
  headerfile with the positioning of macros, enums and function
  prototypes, as well as indentation of in the register values, also the
  all the enum values are numbered which seems unnecessary, should these
  be implemented here as well?

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Datasheet: https://www.lcsc.com/product-detail/C5129967.html
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
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
Kanak Shilledar (8):
      dt-bindings: Add InvenSense ICM-42370-p accelerometer
      iio: imu: inv_icm42607: Update IIO channel macros
      iio: imu: inv_icm42607: Update _odr_to_period_us formatting
      iio: imu: inv_icm42607: Switch to little endian
      iio: imu: inv_icm42607: Add support for ICM-42370-P
      iio: imu: inv_icm42607: Implement MREGx register access
      iio: imu: inv_icm42607: Add accelerometer calibbias support
      iio: imu: inv_icm42607: Add gyroscope calibbias support

 .../bindings/iio/accel/invensense,icm42370p.yaml   |  87 +++++++
 MAINTAINERS                                        |   7 +
 drivers/iio/imu/inv_icm42607/inv_icm42607.h        |  51 +++-
 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c  | 263 +++++++++++++++++++--
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c   | 203 +++++++++++++---
 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c   | 258 ++++++++++++++++++--
 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c    |   8 +
 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c   |   2 +-
 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h   |   2 +-
 9 files changed, 801 insertions(+), 80 deletions(-)
---
base-commit: 26bdafb3bdf58436579a1f6f0ef1ddb9011015ea
change-id: 20260629-b4-inv_icm42370p-ccd671066bcf

Best regards,
--  
Kanak Shilledar <kanak.shilledar@axis.com>

