Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013008.outbound.protection.outlook.com [52.101.83.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE03EC808;
	Thu, 13 Aug 2026 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623994; cv=fail; b=HT12T4+br6NLH9kjVVpW686rtT0Na8OrjO5sRrKjUgQcsqtZixkAH8YHpF2UiTS8LCSUWjhEb9e3PQQl3FC75SyZSwYsweWCcTBy7NPftQNq4BuZCWpKG0XMIRxLNJo+MQKzxzIz52F8l21QIDba1Ei2LKeKd6jwH/ieKnxjlRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623994; c=relaxed/simple;
	bh=fhcMMcj0mQRqWsskaUlcUWHo8oY9S2P1EpZ/PSpLT1Y=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=EtzqW0in5hG1ovz56c5+GBDBPB257joUrFbuoBTf3M5RSwtUHVbsoMOdGvHxDd371X31hjsiTCVHO+7xITKutsaoSiznk1c+vluTriNNuo/gCQWLDd2YHNWC6dd+h7ORIwdHxAUnym8MtMXS3te5KVApm/DbBgFwXLTEZcT9Y9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=eofBmWCT; arc=fail smtp.client-ip=52.101.83.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="eofBmWCT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7wzKsKa4fXRYDAKpiUr8fCSNzKceGlh4sSmP0h8ggOXpWSiEshcClm6ME5sDhfiAFbWzidk6/YGh2TrRUfksk6bN7geb6udL2q3o6mznmiXGmrqz8SfOTtA4Idu0orIppRxiR9izjAJfdhfwFQGdi60F5yRD5t6Fk8+C55/8+LLQTfRCS1dGTD36J241bL+7yWwndO93z6FRDOtm+5Aw5bvMIQXMYrt6v0qnwcd3NXUnmGj/Un5xmhhwSFXvwI85pFdYdfzdQnPgT1OEeL6FmLYgUHYbi+yyoQqIIQ//fgdA9+XKneetOV4wIM9Bh4TDdDFS8z1iTjfjYNSuxV7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DP9V6fxp6Im9HSwi/SYvj7D+2CIKcDRLwmM6c48Unfo=;
 b=EHS2cASJFMSWmWf1zHe3OQ67uX8h9558FFY888eHKI6vD1D+aR91TBpjwwPfDaPQpRLV21QAA6oYT/wRDISS83W5j3hLL7mUK7qgSt4iDltBfrQcSk0New1byvwC8tFoLfoqAiEPTYVlVK75dXDNDzac/8owECk/V2XDBmqq+p+eaZoBXnbO8dajfAZiWGuhQUzyvL8SU6zOgJhXwjYf/Rv4iShQHU8fmzZES2j2fyEtOdF/dS2I2D73IIknC0ZywfG+q3PQEwA7F9pKwIRkua004ufoyDuJJpmw3uQJKnCD7RaV9QG+ECHN3tDLtrTS+qmcI0LM+dODayYpwNcpIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP9V6fxp6Im9HSwi/SYvj7D+2CIKcDRLwmM6c48Unfo=;
 b=eofBmWCTwjZxdbF5mFWjbJ6FDKnAMbdUPCfzB18lhgRtC2qPKLnaEUmM5X0/vmu9lSq3/mZgyURz/7l6NPq2ajSHlKip/O043QqdoGLvTthCx91z000ca76VhGA97QM2PxcUHWnNnHjxHRtrOhMCWephC1daQZJaWThmWHvWrhQ=
Received: from DUZPR01CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::18) by DB5PR02MB10333.eurprd02.prod.outlook.com
 (2603:10a6:10:4a9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 12:26:27 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::61) by DUZPR01CA0095.outlook.office365.com
 (2603:10a6:10:4bb::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 12:26:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 13 Aug 2026 12:26:27 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Thu, 13 Aug
 2026 14:26:25 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 13 Aug
 2026 14:26:25 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 13 Aug 2026 14:26:25 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id EF3AA1D6B;
	Thu, 13 Aug 2026 14:26:24 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id E1A483066FC8; Thu, 13 Aug 2026 14:26:24 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Subject: [PATCH v2 0/3] Add driver for Invensense ICM42370P accelerometer
Date: Thu, 13 Aug 2026 14:26:09 +0200
Message-ID: <20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOG3fWoC/2WNyw6CMBBFf4XM2pqh4LSy8j8MMVBamQWPtKbBk
 P67FZcuz0nuuTsE69kGaIodvI0ceJkzyFMBZuzmpxU8ZAaJkpDkVfS14Dk+2Ey1rBSuwpiBVIl
 EvXGQZ6u3jrcjeW8zjxxei38fD7H82l9MI/3HYilQkEJdKXfRtXS3buNwNssEbUrpAzgqin+vA
 AAA
X-Change-ID: 20260629-b4-inv_icm42370p-ccd671066bcf
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Henrik
 Grimler" <henrik.grimler@axis.com>, Jean-Baptiste Maneyrol
	<jean-baptiste.maneyrol@tdk.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@axis.com>, Kanak Shilledar
	<kanak.shilledar@axis.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5006;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=fhcMMcj0mQRqWsskaUlcUWHo8oY9S2P1EpZ/PSpLT1Y=;
 b=owGbwMvMwCW2Ztq2Vzx1cgqMp9WSGLJqtz/baNK+pn/i84lB7PVHzl87lGJXbnz70RSza5Y/Z
 z/4sf3vxo5SFgYxLgZZMUWWyJyGave1Xkn3iqJOw8xhZQIZwsDFKQATyXRlZDiv/ai/1DzLe9PR
 N8vcp86bnPE6SaPmfoiJ2pt0N5a/d/4zMvz8JDz5ju6kAtufT7s5Nrxwtdbk09z4NGhJkObEyn1
 1QfwA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=596C807B47AD4A62DE725ACBAC96B6EA0C7E1E20
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|DB5PR02MB10333:EE_
X-MS-Office365-Filtering-Correlation-Id: f241d8cb-0d3a-40ae-6f65-08def9361901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|36860700016|18002099003|56012099006|3023799007|11063799006|13003099007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	LJBreXSzQ0CrW73Zcx87UPwe61/uGCFf7SueMqn0GEMMZxFukCIKSLLcle6bcwIEO5/AQUesPQNgU6QGWJJfYN7c0qwiDdXe8xkgTfITb1AgZOOIZsfjdACurswlHEDeIGxC/6czIBiZlzAGAJDkFpzZBKhzHGLL/miKzAJwSaXXUTOE41e0/yCqjwO4pz1TftZ/qRtk9mHh/Z91eC/1Ds/HErG5qBC7YGEyIysJ1GnQOdnDUuiG1xQbmF0dMXKPsBGcFOPvqvANHkP8Hm1n/4H4HFzbFv6h8lpS2WBeANsli2vDUaioEbCLDl9pXRVFEQZJ/kvwqA+7fFkXPVvM3p/1XzvkGUMguQ62MZHF+f5ozuF6FsfIqvsyCe62Jk785ULst1LUf4ch+ps+QdS/K6zeNC2+xz0MoIds1Zc1N41IW5HJY+Hw1QARP4samBZu3vyr8bSuAqzfGo+NRlnLlp45W6f3kyN1ECpNmVtVCLkV7cuvrll1QASf2nmOapDLbNLi4XJMSYFTs/UTtrvd2I5Nel6BwncIUES+V49qJrxSjBjCC36rNJMEvu+6bWlvEyfOGkQsdfcHSkCYSws9jHOg1d4cvWayS4hXHpt+a8P7XuPjbRCEXXQc5hK+8VR1gl2pgNXz49PAovW0h7ruFg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(36860700016)(18002099003)(56012099006)(3023799007)(11063799006)(13003099007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0YkPgIQEjf6S/E/ywV3NgdsRb4dgtK/PZFmrMqIJAygiKZz730bkEwdBHxK4UWc5zX+Tfj+uw8k8/Lb+O8nkkpFqUVCvvP8D2Brc48reVdPYlDi2Pk5hyFodT9fAi3pyrqo0hOrq+IEogejHexVbvz3Hyq1jxSQ1UiJPWcMZs1iE3uoACgUWyn6zaPablShjB2OMF+GPfHnFB7wql8HQor5+sXpiURg3TDx0swhklKDIdWG2G12ud7CWvx4UZ1jGTm9tPvQYHTg1zR9qrWT2Aq43w6ulgM+tPmVfCc/kEAM+ZNO2B3zeVu78Jp5XC5FDyYugG0KR3nxn6dscXv0RXvMhow2lYJQtb/A165My4TELrWml+g+CHITBxKCE+gL1e1H9kcusC3xgR1FyONrIdYLZB43gk2HYQFDbYZR/WfQAVCcCGSVld4T3cPdGRlLF
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 12:26:27.5764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f241d8cb-0d3a-40ae-6f65-08def9361901
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR02MB10333

Invensense ICM42370P is a high performance MEMS MotionTracking 3-axis
accelerometer. It supports I2C, I3C and SPI protocols. It has a 2.25kB
FIFO and two programmable interrupts with support for ultra-low-power
wake-on-motion support. It has a built-in temperature sensor. This
patch series adds basic support for the sensor with functionality of
performing raw reads and writes along with buffered reads via the I2C
interface.

This device contains 4 register banks for configuring the device called
MREG0, MREG1, MREG2 and MREG3. Unlike other devices from the same
vendor, this contains a very different way of accessing the register
banks apart from the default user bank 0 (MREG0). The register bank access
procedure is mentioned in the datasheet [1] Section 13. Due to this
specific reason and that it doesn't have a gyro sensor, it is implemented
as a standalone driver.

This device has 3 formats for the FIFO structure (datasheet [1] Section
6), currently only FIFO packet format 1 is supported, others
formats can be added as part of future work.

The device supports EDGE and LEVEL triggered interrupts, refer the dt-binding
for example of how the devicetree should be setup.

The driver is inspired from iio/imu/inv_icm42600.

Thanks to the reviewers for all the time you spent going through the
code and the comments. The changes for v2 are quite a lot and I hope
that every important change is documented in the changelog. After
implementing the suggested changes, the driver is in a far better state
than v1.

[1] https://uat.invensense.com/en-us/products/3-axis/icm-42370-p

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
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
Cc: kernel@axis.com
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Kanak Shilledar (3):
      dt-bindings: Add InvenSense ICM-42370-p accelerometer
      iio: accel: Add support for ICM42370P
      iio: accel: icm42370: Add FIFO buffer functionality

 .../bindings/iio/accel/invensense,icm42370p.yaml   |   84 ++
 MAINTAINERS                                        |    9 +
 drivers/iio/accel/Kconfig                          |   18 +
 drivers/iio/accel/Makefile                         |    6 +
 drivers/iio/accel/inv_icm42370.h                   |  352 +++++
 drivers/iio/accel/inv_icm42370_buffer.c            |  496 +++++++
 drivers/iio/accel/inv_icm42370_buffer.h            |  100 ++
 drivers/iio/accel/inv_icm42370_core.c              | 1502 ++++++++++++++++++++
 drivers/iio/accel/inv_icm42370_i2c.c               |   93 ++
 9 files changed, 2660 insertions(+)
---
base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
change-id: 20260629-b4-inv_icm42370p-ccd671066bcf

Best regards,
--  
Kanak Shilledar <kanak.shilledar@axis.com>

