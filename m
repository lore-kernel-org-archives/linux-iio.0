Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD9493D49;
	Fri,  2 Oct 2026 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942105; cv=fail; b=SU6adZ1OQ0KoAA5W9cXSsWHhX7OxXYKQjSOvS3tAh7KXhgOpT5hK88Cw05hbSPvrbWwlpSB8xERIlqOaEN2gwYNa17iNI57SLCXnw8GxzyPGXk8WkUUm4l+7OwbpDXFhN3UMJrwMwrngCNunHyR4WcVUvWCj0cb6+iOUJ4MqCBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942105; c=relaxed/simple;
	bh=D1WojFKTGit4xUAwqjN6tCNok4Z7ucF87OfiwotPsic=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=IQhgsvqN7WKHbjJ7OOK6YgdvbNEol+P38a8AsQSRyrPIk6d3F2+Y1AAWk+Fy6C49JhZ8buF9hxS7xsyxTBABWXg38y9/vsnx8OypI+LMpEaDvJ3Kz1ESFok9WV8+jc4RTPTm5i8UkBKZ2+ZRc+f7yoz1v9WRXh9gJ2FO+iQNS2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=jlUCieQA; arc=fail smtp.client-ip=52.101.66.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="jlUCieQA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJy5G4a8ewkPabUQfazQkryhLn0fZJV4PAinlFSE8sOgQlrzrkNFPBU1FBm2KwPMMWh0MC4pqxcyEGe3CdHGckJjIgkAeAbFFa7vcEG7KsJBzr+eIFXy2ZgWgjOHSuiDl+a+6cDkec4f2/5OPNYCNoIVK2rU2Wo3RXoLxAF1fF7LpVgCyPwXxZqrVgknnhbg88Xg/JwSqHpHOMmID6HFC2hn8xUgWfilmA+2JSiQ0eb5Xwkfk8VABGKZpu8J53CYLR3IH9OO+Rgz3fl1YJU9cHdygEcRtXgpldgrTMBbUV7TbJP13JIixbRNi3MJsfNaNhLBi4hAptVoM7W6w/ac8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MozylEJ9zfakapWIYs+GAhXBLQgd/SMT+l51Fh5tuME=;
 b=LM5XZa1nCAA7DDrlK8Da1yxGVySXblS6Ic7c6uY4f7E6hZcN5bDduk4EEoqpEyTo1B37B0Acb2CCzCupA4pJ11VBGXSVydqgi8IFMjgOezIe/ELeMhyiyim6r6kmi1OjtkxXfvIEITonPFeQdQBUtTqAejOJPSXbJJ0qjp3MYU4H4Sa+xK6jb5jX3pNW/sk8UuK8iMibnmGf1YNRNulZmkpEwQuYnVpL/MxM8QK6uvjfJviY8SXio/4YAtIk5vV0UrEoZ7d7/3MiGC7r37Fc7uRTKh0GbCRP76knqPiKbZI/Kqq6rMcwMKXExSIke1WFiRtdsRn+vZ5jbGKkgq6/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MozylEJ9zfakapWIYs+GAhXBLQgd/SMT+l51Fh5tuME=;
 b=jlUCieQA51XsprOp8NBxCebZYavyKLsKDjwvQSS38tFkXCwEglLnU4duiixszc9PqlYX+PeUDrzkhog3dUj4/usaVJMzQPI9Ftv6RydEhpetjuaPTIQfCgbiwwqv3cjZ+3fxABhrnsUPDTEPwtXLGzjXAcq+QBP0MCRgkBWAF1g=
Received: from PAYP264CA0030.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::17)
 by AS8PR02MB6902.eurprd02.prod.outlook.com (2603:10a6:20b:2e9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 11:54:52 +0000
Received: from MAD0EPF000008C2.eurprd05.prod.outlook.com
 (2603:10a6:102:11f:cafe::84) by PAYP264CA0030.outlook.office365.com
 (2603:10a6:102:11f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 11:54:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MAD0EPF000008C2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 11:54:52 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 2 Oct
 2026 13:54:40 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 2 Oct 2026 13:54:40 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 5D0A015EE;
	Fri,  2 Oct 2026 13:54:40 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 51B70305D600; Fri,  2 Oct 2026 13:54:40 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Subject: [PATCH v5 0/6] Add support for InvenSense ICM-42370-P
 accelerometer
Date: Fri, 2 Oct 2026 13:54:24 +0200
Message-ID: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHCbv2oC/23NwW7CMAzG8VdBOS8ojtO43WnvMaGpOMnwgRY1U
 wRCffcFOFBBj5+l399XleMkMavPzVVNsUiWcaij+dgoPvTDb9QS6lbWWG+87fTeaRnKj/DRWSR
 z0szBExjv95xUZacpJjnfk9+7ug+S/8bpcv9Q4HZ9xFrj32MFtNGeTIuUmtbZ9NWfJW95PKpbq
 9iFB1zxtnqAPoYUEvmALx6fvjOw4rF6ImYE7yxA8+LdwgOteFd9Ch0SJrDI3cLP8/wPvvfF1m8
 BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7740;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=D1WojFKTGit4xUAwqjN6tCNok4Z7ucF87OfiwotPsic=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsjaP7tUnynm3UKLe12Lj9alrj3ReoV1bkOZ0c+qiv6zj
 42MJ5652VHKwiDGxSArpshyzmh79P7kf7pzpJ0uwcxhZQIZwsDFKQATebyE4X+tTEFFvYDPpfh+
 ebN/i+f3tCrVZ804eOt0wat1em0NYYIMPxmrMl/0mvOdvKAvat01IfBFesmMxWFLWn7uOn9Aad/
 hbAYA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C2:EE_|AS8PR02MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a34183-6dba-4976-633b-08df207bf82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|32650700020|82310400026|376014|7416014|1800799024|10067099003|56012099006|921020|6133799003|3023799007|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	hh1LCZFwqz2d6H28klqGfbzgSc38F+i3tvoLnpjdeTZ/DSat/j838Ts2zaKjYfuwQE3kuOgpwG5AqW40hLOCl4JGPT3Hbkl6sycIYRQqX4khDWdQ+iEg/G+yEqvZfBFy5eAczHOJWiHwdNL1DK7GNO0bQAs0pURD3tYq3bPO0Jb8gSQdBPwMTzmLoxxPjBz+LILcopdwSEd/aHNVkJH46Et7oH2npTuWNCTQNMc4Hfdu++EYPWo3WnEXojQgrBBcnHJIgkdnzOw/RB+VKXKa0oFeqWJQEVswS4GwntYvtfkCkn2M91RQ6lHdeKxxZvGp0Kbj3VemQp+ziBsN3aURtbv4+j/nsXdBiP8wnpQQSUDfO4Wq9XLy4TWs/dhbiqvtRZxsmMTPG8XXoNqAct2Dqpfenact2j7Tpvfr4X3Se34dRRYd4NGkuqhYanRWjl0dJJhCbGFHZjKT+cWLOE9WnrqoXKJ09W8WEPBAMBAJEHRm/yc6PJGT2fZm0LoQbmYLhmyzzovwKbdwjNqxncvmsvIJQEPcqeVHeHXkBr8Y3PY6kRTZzQtFWQmeq0mpXHe4X7838qHXmAMESiy4TEU6uJvUSFlAtIhVtYws673qYWd6EdrauGbiftq207SEH9wv9dGxb62pcM6KnivyGkwr+owCw9BtMN7hSU9cBMq7UoMGtMoMYovUElEreH64UenT
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(32650700020)(82310400026)(376014)(7416014)(1800799024)(10067099003)(56012099006)(921020)(6133799003)(3023799007)(11063799006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zvWzmunKhf/H0QfXv0ycfMsWE1r+fw1Lu29pSyfj6J6RpvFsxhg0kvQh/FEwQ/JbP8OAoH3NZjkdPfEcGq2Bal3jyAFxbfKrReRsHr1YpFUaBjIwBuLQgrogQ2dzsUVdoJHHL50IAUc55jnPmhBcM9Iql2GD33smvuZcj9y0FLUkgtaJZUEEqFvGXCKIz9Qdj+GDRkS5EH/JudKUrt+ZwXzRn40ROfmmAYH2PNYetk0/5OYQOw/4NwPblM67EN9rSsp3pSq/b+n5ED8+B0Fd3oe3XolvGHpRDfnDPHG6xmBfCWV6+pn1gkaUD9S5SKptabFSDwc5eUNtpMi4MkZE9iJ7VpCZ5gxZy8tswPtI0gLPJtUjfR+llN4ftX/vdG2fSZolnocrg0x9qDk0ITQg1EVP32NpBY+cuJEEfx6H0NxFHOLIPcUSWQq8FFJhsWz5
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:54:52.5374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a34183-6dba-4976-633b-08df207bf82c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008C2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6902

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
internal-v2:
- merge the dt-binding

---
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
 drivers/iio/imu/inv_icm42607/inv_icm42607.h        | 170 +++++++----
 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c  | 207 +++++++++++++-
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c   | 313 ++++++++++++++++++---
 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c   |  13 +-
 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c    |  11 +
 drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c    |   5 +
 7 files changed, 606 insertions(+), 119 deletions(-)
---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20260629-b4-inv_icm42370p-ccd671066bcf

Best regards,
--  
Kanak Shilledar <kanak.shilledar@axis.com>

