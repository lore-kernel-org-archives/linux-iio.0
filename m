Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24C1CD1E4;
	Tue,  1 Sep 2026 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273375; cv=fail; b=I7PND45z/ZUzvbMOsWz0h+Q21jhnYrim8Xtv7pQ8FS6M/nu/u8pRxwFgRSOqc4lp9A5jgcsc/l49MLRl6KIuMCsCFbDINogpO/nTJ4AdxSJn6Siy/rRHmozYL/LYVj6Lavpp2ymhCiGe5BSdxcIcKnqNe5pPDoQJ0ThONZQKovE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273375; c=relaxed/simple;
	bh=+4T+VaRXV0wF8O7dZaNBfbU9eX2aJT0FfOKi8AXnX1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GkP+WPPsAq8jYyv+dIEGPuODDJ2hJ9DmR6mOFbehE56KqsRDgHZf0RUnAm9gL6XOeTQHLQ6fMr+pmiYLC7wd63UvIBWzR93MAoC2Nx9CpVIpU+NW83+yHsC46jjk4XWEw5pVsAs43jRobqX43KuIVNdIIwauEbMlUzhjVtAS+lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=hPZlrS+X; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="hPZlrS+X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYe46Z6z9/a9r15Dal6Sw+y2EFDyzROM0ZmMrDJnTXy5pyFMdh7lgjelIwTsEBrbufGCsO7ess6TTs3VEPJa+M6HmNpp1TWD0tOSxhOqiXDtOMPsEORmWZq2dZQ2xHmQ+b0CBDVy7sSgCP0ELUzkmuv2NTgZlAS4gFucF8i4bJ40Qzo9e9JyFcUtRW+KojBN9jdq6TqnZTR0GpAmPdeMAFO/9bNdVlgXpFFq47SG8x8VyLWQUPnKWTjP0Jz2dr3dKNU6ep9a6b7ZcZXyN6zpwD2tCsgNSFj0tqOZBx+z5Zdzy5jdRcbgO6Mev6LAGKK1/OENRhI6FzUcTUBY9piFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+CUiTIuPn58YWSMkioNTXBZ9QcPtJO8gxzk0Pmk7H0=;
 b=LEdiusjIBdJFCrJygLm6P9Xc0kAoB1+h2eYhbS/T0PqBmXNXlbFnEp4ZeOGTW5Xp4Oq2uHB/o7Gp7MXa4FwswMQ/hbb5HkYfFL+Xels3m/gGm2cOjccglbPoDyA8fnDMO9aUGdWTNKRws17btPv5HItMm1BWR8flrG2AoFvUtIps8eQC3STZ90Osw4U/RmmRMdrAtKVAQmyudwoWmrfy2PmWFW2iacIDf5KgiWeejyImro36NxeIKP7tTcPXCqta+CY/M9Y69/s5aMhqHrWjC7RSXkn4nvvR0/m5yJsMXJcsFH3ki/ylhJTvDIs6FOrKvL7tErzOsyeSGSRgq4tlxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+CUiTIuPn58YWSMkioNTXBZ9QcPtJO8gxzk0Pmk7H0=;
 b=hPZlrS+XawL8NAm9qhVIOo7VWLdqkix6hzLIlSDs7HydRIgh6CF7XeOJDrRbJ8zwO2Gs2ITOWmo6mGv6fWeK9LzsDIg1790OSkubBCuKh/wlE6eddI4i34aZ/31ClMXCsKy0V9GYr1gcskEHEMXh8e1Lk5ZFJ2dxo5w7NeBfuq4=
Received: from AS9PR06CA0312.eurprd06.prod.outlook.com (2603:10a6:20b:45b::21)
 by AS8PR02MB6950.eurprd02.prod.outlook.com (2603:10a6:20b:2e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 14:36:10 +0000
Received: from AMS1EPF0000009C.eurprd02.prod.outlook.com
 (2603:10a6:20b:45b:cafe::38) by AS9PR06CA0312.outlook.office365.com
 (2603:10a6:20b:45b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 14:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000009C.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 14:36:10 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 1 Sep
 2026 16:36:04 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 1 Sep 2026 16:36:04 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id A7C1B2E3A;
	Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 766DC305CBC7; Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Tue, 1 Sep 2026 16:35:57 +0200
Subject: [PATCH v3 4/8] iio: imu: inv_icm42607: Switch to little endian
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-b4-inv_icm42370p-v3-4-77cc31642115@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
In-Reply-To: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4057;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=+4T+VaRXV0wF8O7dZaNBfbU9eX2aJT0FfOKi8AXnX1A=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsia9ujyOsMGbdHIh2ZF/wt/JzvKMcw408Jyydv38Vxnl
 wa/VsZVHaUsDGJcDLJiiiznjLZH70/+pztH2ukSzBxWJpAhDFycAjARF2ZGhrMqU+Y8nDRpXk76
 DT++yKSLNSGxcv7ayw4c26ItMPfAiSqG/zEWvF1BgkLGgjGz/sw+dsLgY7vUvL+uwcKNiWeEtvn
 84wUA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009C:EE_|AS8PR02MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: d17658cb-9c9e-44b9-9de4-08df08365df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|32650700020|36860700016|1800799024|82310400026|3613699012|921020|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VjHxa+KZ3m8N8JFvmvZnKsdfJqu1r/oDKRmd7kQL5MJdLN7Ix+gR6Mm71WT90aHu++xTbrtbjA79Gmho4qEgIXkbVK/hte+DBR8911x41M2BXJONL3XKaF8NzfacaMzxvAlDWvMYThF3C6fnMti7lKmvgplxUwbScs1EvrASbyzAfWjiUv4TMd8gpkDXC+g+TGALH6Ia4squuFdsVELQUPB5KjxRWMiyWVoYEF+MRRcHWV/Pn0lkEf21N8kXsXGWCnu+y9/Y34xOBvi4JE8zO7wSNZofSNyNibf5ud7CoNDe+r5E3VmMsKjPznqOR+169yF9NgtsyXvmR8V2LDziTOg8Bg8hPfFMFP2eD436vw0eeWXfSIi83Z4y0MCPQowyoXecMkP0c5rvT5cqapKpYS3YwxYsP9UiJMlaAAyxdI6PFxD2rQ3hIsd3mYmxTtgaEQ4Rgp2xCv3Q/0INhbskttYdUYia1/DJPV+kmOLinPeAGbsezWUtRd78S3JrJTxo74dl/QiUF6uEK9KlLLkK6yG/c7i6ZrGdA88DOiMNTEbrhejNr1i4GNf4p3Rl08aQ29+lyocw5OmWdi6yAqzjIavtxCEYzQ/ARrb2TJgwaoDWbOtOURT9e77f3H/E+PW1tOwG6tbrior0j/W7a7cgfn/6cOz12kJUZhS8wI8X+e7aZ2LqbAvALCNPHzcBcu6Fcfa9N9hVT6SKJpHeG5DjCJovAK64DW26vzKWMemr158=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(32650700020)(36860700016)(1800799024)(82310400026)(3613699012)(921020)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GJmLzuwzMXZsXAoXe9T+Vb3MDkZHKkAn7mR2CTvi9hLkd9Pcx20Vc7YaT9ZNo9+PxArJXeMNCJey6R1ZscoZ10klEO1g+wDo5khXk4Z6m17VD0sI10BAQRNJev0crkKjNdKVqwbzai+txGJIdOnELfNJBdq7SpsslwlYIxkULk1wmx6Xsr9N9eW+xwlaHSvHesfcObCd16XQj+BljvBCh6CnbGqDyziKtrXZePy/RKKOUd1iYWW1kDA1WmG7sf4kX9Rop+Ci6VmDB9Jr2i+RGiZUW8Z4GLaXLkmQdHWKZAqy0FzXKhwHH1k+4S0ZB0ceEk/YM7wCcV8pZJAHZyz5N+3pZK6N63igqp1eMIzGEEVhWBEsCArUzAhls+hORi3Uo80ldQ2MihiQShj+SPekon4XjVTdwo3jSjo8SpBxYQFkkJossr28nSt8kL2r5IOW
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:36:10.6842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d17658cb-9c9e-44b9-9de4-08df08365df0
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000009C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6950

The device supports both big and little endian formats for sensor data,
this is handled via the SENSOR_DATA_BIT in INTF_CONFIG0 register. The
default value is big-endian format.

Switch to little-endian as it matches the native byte order on vast
majority of systems and avoids unnecessary byte-swapping.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Datasheet: https://www.lcsc.com/product-detail/C5129967.html
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c | 2 +-
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c  | 6 +++---
 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 2 +-
 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c  | 2 +-
 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h  | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
index 8f61bc901452..318373efeb9e 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
@@ -32,7 +32,7 @@
 		.sign = 's',							\
 		.realbits = 16,							\
 		.storagebits = 16,						\
-		.endianness = IIO_BE,						\
+		.endianness = IIO_LE,						\
 	},									\
 	.ext_info = inv_icm42607_accel_ext_infos,				\
 }
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index de3b158f446c..7eb486ff673b 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -343,7 +343,7 @@ int inv_icm42607_read_sensor(struct iio_dev *indio_dev,
 	struct inv_icm42607_sensor_state *sensor_st = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int reg;
-	__be16 data;
+	__le16 data;
 	int ret;
 
 	if ((chan->type != IIO_ANGL_VEL) && (chan->type != IIO_ACCEL))
@@ -391,7 +391,7 @@ int inv_icm42607_read_sensor(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	*val = be16_to_cpu(data);
+	*val = le16_to_cpu(data);
 	if (*val == INV_ICM42607_DATA_INVALID)
 		return -EINVAL;
 
@@ -490,7 +490,7 @@ static int inv_icm42607_setup(struct inv_icm42607_state *st,
 	if (ret)
 		return ret;
 
-	ret = regmap_set_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
+	ret = regmap_clear_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
 			      INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
index 8e8d36461e51..fb9bacee4e8d 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
@@ -32,7 +32,7 @@
 		.sign = 's',							\
 		.realbits = 16,							\
 		.storagebits = 16,						\
-		.endianness = IIO_BE,						\
+		.endianness = IIO_LE,						\
 	},									\
 	.ext_info = inv_icm42607_gyro_ext_infos,				\
 }
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
index 53f0484c0845..ab2ba7900095 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
@@ -58,7 +58,7 @@ static int inv_icm42607_temp_read(struct inv_icm42607_state *st, s16 *temp)
 	if (ret)
 		return ret;
 
-	*temp = get_unaligned_be16(raw);
+	*temp = get_unaligned_le16(raw);
 	if (*temp == INV_ICM42607_DATA_INVALID)
 		return -EINVAL;
 
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
index 18499b4d0b94..eb55e2daac89 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
@@ -27,7 +27,7 @@ struct iio_chan_spec;
 		.sign = 's',					\
 		.realbits = 16,					\
 		.storagebits = 16,				\
-		.endianness = IIO_BE,				\
+		.endianness = IIO_LE,				\
 	},							\
 }
 

-- 
2.43.0

