Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9333B3894;
	Thu,  1 Oct 2026 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866663; cv=fail; b=mLOaKs73A9O8hiEkE06Hq9Yhw8YGeDPEf7PtB2BvdU7uEGRX0DuNDKCGFcw3kmm6ZabuUKBV3LKxQLQRcAbS4oXc2PQ/Bx6R1+9xLtR5qi6xoRiALufNo9/1nbfOz6cZ/50N37/Ii+TMIBDLvUAzUNhinOkLcNKwKayWfMFWjI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866663; c=relaxed/simple;
	bh=PRpGlNKvmMrxs5p9lok3tAdHLKgQOp4tJ3DY+yx9wVE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j4o0Loxk7fHOUJRi1BkD+aSa5KjNyOhf2T8k4sFZPRPMfXbHkUhkb3GEKF3T2ziz1foi/Tpm1+4bOq1hSlyavdWgsm3aFRNmUEHVDLVgB69I4GvDPdRB9FUx8pg5eIz687PP7wCN+IXnWbfKgmo4IH4TQVcUfT/fFXeqqQrq8wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LEBrnH8L; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LEBrnH8L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjy8TLcphMWh5dpDL7IKDETDO2HDRDtO40Mf43up7MvkonbVWR3xp19v0Bn49ywls2Gyh+xdFpL58/Yr64hYr57vvEllpFAQioPlv+M3Y0uncClXF4UFK8gs0rJAyAMf/mBRoGYDxjvUlGof11ZeHFcURB+f6YxyZNXoDNAv6GOQFUsUZF4ZhU10lMl5C9E0bJZpS23WEo2iHmaTbjtBBOS+Y5sXZe5KAW8UmI+PUNF+WghNUDs8SkIVnTchBxAT9EGdxmJhPRfHRPUHPR4eSyvycrUoCeVigw4fe8KgawSjmlwJ1bayEYhI3vQ6w7XYXiUUaS3MyXmPff82aawa2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7TPl4uTPNs7LN5nfwcD594PSS6CnCAOs7AbrrZoP40=;
 b=gTBtHzMx29ZlfBBJOCCvXlAPf+7UZlDIPsMfgrLe7ZGGAXC+ylmvvnAVXrPYB01T5KY0WXfzpj8PkLg9zrkGvpE4qReIga6xS5R/FkTapVBo88FnPeEAFLWHSw47zM7rOQvPbMkCS1BW9LhlS2MqXCL/LQTzw6M4lPvBfEfwQKOHFiFKCEM4RRAtr0s/9rr/wnZcAwAyOXyKtUGdYWSUgCU5Cux6EdAp5454AgqXfbpOijY5vTK5pvcwxJ4s3D0NvPNRAWPEhxcbXOje8x3wFnVGruK7Q9qnoYHVRzxn+M41A8bu9ZrqrFqiucEDnz5IfK8T5S8zWbTxtY/0yLUDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7TPl4uTPNs7LN5nfwcD594PSS6CnCAOs7AbrrZoP40=;
 b=LEBrnH8Lh5WAt/XrtitT8LZukYrhjj96N1OUVwC/vkOSpV+4cPyAwWXK7B37csEq9JAnydP/KaEfmkp6nSiZBSqQmVoQPUz2zTES2eGRxPWWeGY1OveY4avPWEEgzMUqTlqShH/DYKxCIOXyDsrrcPMEV04GxKlsxme8JA/vUy08IioVkv9IX4eZ2VOGRAtUaM21RxCJ7quIlo73e8Wu/ThbYj26p1TQtt6cWnH2a+MXgnjArcHHwofnnYzpxyuYHWaRg9LwOZlqv1PD7NSPhFDB6RPvOPE3l07R37yjVdubcDxIEEvH4fhYNv5mBGntTqkbJp3zGpoCwBGZBfshzA==
Received: from AM0P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::30)
 by PAVPR10MB7114.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:318::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 14:57:34 +0000
Received: from AMS1EPF00000094.eurprd05.prod.outlook.com
 (2603:10a6:208:190:cafe::97) by AM0P190CA0020.outlook.office365.com
 (2603:10a6:208:190::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 14:57:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF00000094.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 14:57:33 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 1 Oct
 2026 17:04:06 +0200
Received: from localhost (10.48.87.64) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 1 Oct
 2026 16:57:32 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>
Subject: [PATCH 0/3] iio: adc: stm32: add mdf support for stm32mp2
Date: Thu, 1 Oct 2026 16:56:44 +0200
Message-ID: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000094:EE_|PAVPR10MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bd8b37-20bc-4df1-3316-08df1fcc5312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700016|1800799024|23010399003|260925022911599003|260925021911599003|10067099003|260925021311599003|56012099006|6133799003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	8fOVAyxtlNbvn3b93eh2uemfRx72/f4OinyDiuf0w53sfXDo6i9u7LoGvIL8J4RXZN8aanHbS781xPdHiZcGfLi/7D4O8/9zFkIuSpw8Vugfy8JZ1IBShqnxy6mBET51ZooWkciwRa6zwPnthuU3bt6zT2yhlJi3dyW8U1qf8fG2RUWPtzeCrw9xQJxGBosHmu/lGLLO4uy2qp69BJA6nZ/TDPIkZHWojzlthn/6+iUT8XsKRhFMatZIfkjG1R+lUuw/sgGQqMC8YROKv206X6KUDVxqHgoznsC6DkPj4afe3iZHQljfdwf/MYskOK/Lqd1nADmS7LtLmEZRDw+1fAv0L0elaQqkJcFxVwYW9m0RN0t7F0JZ4Jy7215apyD1dBF9Ev8TjiXliCYTt1UUSQVIVIPpzktop9HW+B/zChWxjoM4zeyPbpwtPbVgv47mG45491oNqCIxWEMieUajk4Wtizyq+Cnz9jCar86WVifBKKj40shN4TFhrKD2JIIarYGSM5NXGh91kEhB22sqUFiEEf4L7lfe2/+F/n+s31A0AIV72BLiNVz0RUpSxiov2HubDgDLsILsg4HMGt9Y9DuOfJ9qCyUvRyzJx0A68WOFl9pGJ9qTrPFrwmTWgUG3pal65XY2PACfz4PEfIr1oCRHeNW5LyvmNCd/eX53KNeDbs1O6CdEoS2oQjH7ptcEZJkii0w+PAw3BtqBj4VHeE371G3Z0WU3PWidypXyjNQdxQ6Zz4XopV52Ndz2fzup
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700016)(1800799024)(23010399003)(260925022911599003)(260925021911599003)(10067099003)(260925021311599003)(56012099006)(6133799003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jJerGZlPRmOaGSSNevSJy7N0/nxJGvJBc5Roj1kytY7X7koYfbC5JosgGi+ge+VVuUnUmYX8fSFV6Hw4dni/8GeJBY8VtIfGyF5nbdC1YVA+aVEp/d/F0PxG1vR0P/6obA7x6LN82ib/p6onvZujk5p3QivuzRKmdTj3YlhDltEjNHKSVmBM2rpqAvuby5kfZCYK7tGctCRIbDWYDvq/yOtz7XrzMp4k26FDifV2YpqFdJv0sL3Y8ZxvzytzI8rOwtfd/GygNlFlas4CUnoizXwZuKKLFUZv/0TAcxnNfjZjJmMbcmoFxzeRP7m0gVUZwkj4a1g2IJpDNqQMloCsrFYsan31ucqJ3CEAWaQU+blWyd29e3HqBFcyP62YsP2Y/e1Rr+VGijRt3tlXnSWoPEINQfEmPRjP0SnmFifJ9Gko038aqn1tmSex7czKbZxe
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:57:33.6569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bd8b37-20bc-4df1-3316-08df1fcc5312
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000094.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7114

This series adds support for the STM32 Multi-function Digital Filter (MDF)
found on STM32MP2 SoCs. MDF filters bitstreams from external sigma-delta
modulators and PDM microphones into samples for IIO and ASoC consumers.

The first patch documents the MDF core, serial interfaces, filters and
their connections in the devicetree binding.

The second patch adds the core, serial interface and filter drivers.
It supports IIO voltage channels for external sigma-delta modulators,
with direct reads or DMA buffering, and PDM microphone capture through
a cyclic DMA buffer. It also provides CIC filter configuration,
synchronization and filter interleaving.

The lastest patches add an ASoC DAI for PDM microphone capture.

Olivier Moysan (3):
  dt-bindings: iio: adc: add bindings for stm32 mdf filter
  iio: adc: add stm32 mdf support
  ASoC: stm32: add mdf dai support

 .../bindings/iio/adc/st,stm32-mdf-adc.yaml    |  383 +++
 drivers/iio/adc/Kconfig                       |   27 +
 drivers/iio/adc/Makefile                      |    3 +
 drivers/iio/adc/stm32-mdf-adc.c               | 2078 +++++++++++++++++
 drivers/iio/adc/stm32-mdf-core.c              |  857 +++++++
 drivers/iio/adc/stm32-mdf-serial.c            |  309 +++
 drivers/iio/adc/stm32-mdf.h                   |  312 +++
 include/linux/iio/adc/stm32-mdf-adc.h         |   19 +
 sound/soc/stm/Kconfig                         |   15 +
 sound/soc/stm/Makefile                        |    3 +
 sound/soc/stm/stm32_amdf.c                    |  376 +++
 11 files changed, 4382 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
 create mode 100644 drivers/iio/adc/stm32-mdf-adc.c
 create mode 100644 drivers/iio/adc/stm32-mdf-core.c
 create mode 100644 drivers/iio/adc/stm32-mdf-serial.c
 create mode 100644 drivers/iio/adc/stm32-mdf.h
 create mode 100644 include/linux/iio/adc/stm32-mdf-adc.h
 create mode 100644 sound/soc/stm/stm32_amdf.c


base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83
-- 
2.43.0

