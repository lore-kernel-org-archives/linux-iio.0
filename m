Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21282550D5;
	Thu,  6 Aug 2026 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020417; cv=fail; b=u+HgB7gh9ZVs3Bp+LpsUqHrM6jdES3VV5omVuokVdyIIJdKzTfXumSwaUMeCnUXR/H99wUi8LnW9L2ohxz2iIAdxT6JYTmLJnbtFt72A+UHgBGVhpJ6JfYHzQvg3BmcKWOftnYGzTTCkPovO+r7pQDNbktSmt1o7uN3n9Cx+H+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020417; c=relaxed/simple;
	bh=cgr1+jYM1R8kgRdy3dgldRpDFzOv9gYnnD2wfh1L/8I=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=OOXFvIQy4U4f30lEWJRf+mT5SFp78Trt9qIUV270pv8k8h3CR945QXQJkxOHJsNLE52ITlCr13P+6zlhPTZ/F0kKdU7u++8QFXtXE5esUVr1U5crAmQQjO+wSWCOaVp7gXh3T7rHA1MJ/2M98t5Ij/wRL/RFZ+CURFmpqxYxCGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=NvfFiWCD; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="NvfFiWCD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LW0+PKSdMVvPphyOmBm2sWcD2wwF/cXAC/LuDl/RNSQ8xiHZmg/P2P+JCsK3yj+91L98cZ+j0iRJSP+CqratgoOekLeVf/JtX8E/weDjiGPUhmNHZBq1VT155uXsecdUVG32UojxZ1RLLUjImoOtCe2CFvHqCG7ebG9TmtPC6hLqD5icOKM/ygKK9yXNwPW7jdQzjtb1TIsc9GWKga3nXaL7Hv+xu8Q43QoUTALW3F52Qcu76tVngkFBywjVt52esfoNfZ67UledYuWLDtquKXzUaoq+fVkM2lTBOSPnfv3HQyMN+qsJpX96S7dvWa6A8YPaJfPPs8MNfaW0mUsqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU0mEHK3aqmGP4zxGrchJYYlrUesaDrBox550V3x1nk=;
 b=i+cXgIazsUjrwEvZcLXaFdo0+Bx5rOMqyxbw4cYdi2h0Aelb8BNXe2qOKaiqRmP+BlM7nXwmB3n4dybHrqhrC+ZB0oUG97N7kdNk3qSlxYMs9ELjbUBiKxqTpQ7JE+UnXClZTMYuU00VdyTF+E+2qojyjxtvarTDR/ojYE/XuvrDLESi/lDGQ8RK+SQdV7F/wmHIFCINmCaSVYgxp85++8Pec2aRmZtfZ0Fp7vdE2Fyi0lF2HVFf0nY2mkFHrca71yLanIafLfBHZm59b7Pta/Pr5TerwE9Lz3sEJy6bpYVDL/U/hOkttFYRUYiy7wFkifd9/fd8h6lqn/g408DEAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU0mEHK3aqmGP4zxGrchJYYlrUesaDrBox550V3x1nk=;
 b=NvfFiWCDUjpn2dnvHSWooR8j42UzShOdhYwRCu7tCf1uRuMMKfk7mmj3SmlDS3EkuWzrOwms2WL89xLkEFxhUVKvst8pWFngOd0aqkZ8MOmlQ8UNfSnFBxEqYHe8vlKeRwb57zdQJ62VHRUWZdr7olXvlsKN2qLqy/5b3xYj9JE=
Received: from AS4P191CA0036.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::18)
 by AMBPR02MB12272.eurprd02.prod.outlook.com (2603:10a6:20b:762::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 12:46:51 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::8b) by AS4P191CA0036.outlook.office365.com
 (2603:10a6:20b:657::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 12:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 12:46:51 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Thu, 6 Aug
 2026 14:46:48 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 6 Aug
 2026 14:46:48 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 6 Aug 2026 14:46:48 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id BCAC117CA;
	Thu,  6 Aug 2026 14:46:48 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id AD1293060BD3; Thu,  6 Aug 2026 14:46:48 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Subject: [PATCH 0/3] Add driver for Invensense ICM42370P accelerometer
Date: Thu, 6 Aug 2026 14:46:26 +0200
Message-ID: <20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACKCdGoC/x3MQQqAIBBA0avErBPMZKKuEhE5TTWLLBQkkO6et
 HyL/zNEDsIRhipD4CRRLl/Q1BXQsfidlazFYLRBjaZXzirxaRY6rWk7fSuiFbtGIzraoGR34E2
 efzlO7/sBCn2I/WIAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2389;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=cgr1+jYM1R8kgRdy3dgldRpDFzOv9gYnnD2wfh1L/8I=;
 b=owGbwMvMwCW2Ztq2Vzx1cgqMp9WSGLJKmvR0Kp9+fjYrdL8EvyFbfcv69dtWhC633HNTXnIHJ
 9eTi/7LO0pZGMS4GGTFFFkicxqq3dd6Jd0rijoNM4eVCWQIAxenAEyk7hbDH76mi2z6E7b1vI15
 tF3bWLCu/apexOeckKkt08/sZRWUuMnI8KVAmGm2eQujmus2kayDHdsft+6ZNOGH1UWTew9mXwm
 4wAwA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=596C807B47AD4A62DE725ACBAC96B6EA0C7E1E20
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000197:EE_|AMBPR02MB12272:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c98132-eb8d-4f86-ba95-08def3b8c9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|23010399003|82310400026|18002099003|13003099007|6133799003|3023799007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	1dTO23a4hxp7nwfg2WOmRtIP72URbFoTVFdIQiC+nsscE7Y4VOcP1XZim0RdaozlMJfZkvBtWg+hilWG23SgNHieCU+jviEH12SOot6Nr8riKyho5Rq2NFJIRBHp8wxzr13vvS+TAKIUeBNmfnwy53Boj7TALFC1k3xXNYNUKzhpp04oLjs/Zj6EACQQMA06FDHq93siu6kjgSsHwgVMa+q8SEF4UqlFTj+SbbRndVXNq3rByWjWr1k1zV/h0EGMKkuQZqE44n6bvRewU8fERRznKJCrBA9eYAP+n7sdUXVAlgZg3H8xiM04pebGLI7ZIzZqJ6TaZQXbzb2ueC9GCpTnMau5EoZHVt0iUE9Rx/94JEO18bI+sDEH+u60isJgJBLJRHFgtxpSd9KpWkocSF4uw+HpgP7uMBgCQPNvTL+Z7/+tsHub11QvstmzE+cXl78dgrDJwCihEH4fAyFOFPQI5tAvUwDw+k4nzT1hugm6sx1UxrZRYNVQPblhkRjhSMA1H77YVEVn3F7ScYdQqI6xWDfu7vYOa9CPVIhIUoMm+hQiskQHWdXyDI6Uo4W4NE+yR4V+HYwfFkVmasQR8Tz4366m/F0fGAyC01EB983IOOOlj+t/EhlqucfgKvOxF9bChldEgMp9f/VZIYFSPbaFZh3i6pnUaQ/H2oW5R9gJzRezMWa7ILz65QFK3hbHvL65GWOZ56zGntHKCzfczg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(18002099003)(13003099007)(6133799003)(3023799007)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZGudwBR7hdElH5BIfckOZWsAz+witK9OdyQepl0AlOlUYrK7orlxzrPMXTO/Os5whhW2Fh3LzGRTrAsBH1JVdAS+KJOL0MKsybIfsXVd/ar+xLtzaxuNXiYx90/I6MCN6boHoHtQ2pe9cILbkA/G3EIxygVnkdD8F1nJxaqv80ghDN0Wile8lkQlQVP8uOAbjOnSNkEW21jmDjdyS6BamFrwHgJhwnSd4RjWfoyhPHVkpMrC99f7cZoQZDuXvsPNX2g8bMTUNeLLajpuSqy+SvdT9irG6RWnofq4JwGfE5uLXHsuNjYKVqJXDuDjgLmM1AB/sguap3GZ1vw6rZb2qTuPIxurGoV4JHkCzbUjrrslsdmqXy6qOQ7fNzNDAEC7VZ89kgZFqjfIGVCzcv4AfDZnSoUz88wE4Hhrufn/A1zlinU+RKrxcehWcqkbce+J
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 12:46:51.8168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c98132-eb8d-4f86-ba95-08def3b8c9cf
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR02MB12272

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

[1] https://uat.invensense.com/en-us/products/3-axis/icm-42370-p

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
Kanak Shilledar (3):
      dt-bindings: Add InvenSense ICM-42370-p accelerometer
      iio: accel: Add support for ICM42370P
      iio: accel: icm42370: Add FIFO buffer functionality

 .../bindings/iio/accel/invensense,icm42370.yaml    |   65 +
 MAINTAINERS                                        |    9 +
 drivers/iio/accel/Kconfig                          |   18 +
 drivers/iio/accel/Makefile                         |    6 +
 drivers/iio/accel/inv_icm42370.h                   |  371 +++++
 drivers/iio/accel/inv_icm42370_buffer.c            |  504 +++++++
 drivers/iio/accel/inv_icm42370_buffer.h            |   97 ++
 drivers/iio/accel/inv_icm42370_core.c              | 1454 ++++++++++++++++++++
 drivers/iio/accel/inv_icm42370_i2c.c               |  103 ++
 9 files changed, 2627 insertions(+)
---
base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
change-id: 20260629-b4-inv_icm42370p-ccd671066bcf

Best regards,
--  
Kanak Shilledar <kanak.shilledar@axis.com>

