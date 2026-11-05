Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793893752;
	b=ov81ikg/WzwqJD6pNPUe9vZXJz2yKrZEdmNAvJOOXABMIxXX0/PiQGA1Nif1BHyfDRlU
	 YiFGT6td+M+AGx1bkUxZmd8MEYcTIMQz5FNTor0P29o0UE0WrcDtjqkYkWCVL7vFDU7iZ
	 WA7nSas3y6N7ZHkzzUdceHPNdzh2y+zWj0YdS+xwmdH0VC91fcXT2BWhKjyPmbQ5ribkV
	 mV+qhGB6CQnSJZDHMFboHXMe1bw7YqAA8lSls/GoGz4lz9y6Y20vzbxqN1OqeM5xTtoru
	 kASpqqdRx8VPOK58yx3Agu3a61A3YCqQ+eJdo3hiF7AQsEhFQ0xl6Hl1s74V2HJW6AQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893752;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=OKy/rDfzGpJKLFFCn2k/MvD/HsxTS6xkWQsrYZpIg9U=;
	b=VORA0/5wMSLf0p3DGh077EpbwCjrCCoTFb4Ic64Hk/XYFIT0NGpnZnASifFViwHsyEr0
	 kj4ey5Z/S9cctQE8QLxSjHn9IbZXW9Uz69hENwxhcKZ7VU+DYzJMdMIlRH5vf+vcxFU6O
	 jOfm9asC0m0NHnQ4jgsth915zRoFlvbaNw5h8TZlYLQmmSpZogj05IN2gjSYtARq6FyUE
	 s2OXKxRyGqYkh6ZhSjLrWqyfJXP5B0hGM6Cj7dl3G71xCqXUdaA/tVveKMlCWIWdHa78l
	 7XxiGpgJlHPCpE/lYctSV4Irx4QOqqAJYpDl3Ytr6B9uIFchCFvXfmxWHg4gsxrVD2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=kfgBR6GD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.6
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1994606A336;
	Thu,  5 Nov 2026 15:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1994606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=kfgBR6GD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHFSFpiWAXuH5pnlXjh6Hukvs4zJzCqEoulFFhTlQeKw7GU8kVwq6fMf6DaO2FiTh/p+L62DUhGp6Bh3ngxX9qIouDzNxkO7rrpXv3b+yX09+ysLSDN+LfyLW9UFlx+0G6JGME1A3eDmmtqXpPywf5g/LuXmmz65fW+RKzmntXY7hJT3Mv2ewUS3Jy6MCKw4YGGgj+IAtKwa/mdaB1CdDZLJ976VV1YSsxaHCXpFFJXDOl1Whs2QgTBkL6BggAXvbJLEC5Ay9E0OC8q298nnJa82H2jkDZ5T0kJFsDJhhdB+FdzhjUQzRvwMNGJsqzixSe3cCvJ0H8QkIL78Z7aStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKy/rDfzGpJKLFFCn2k/MvD/HsxTS6xkWQsrYZpIg9U=;
 b=KDXCg5zhGb5M27U1NHeKNgq6zZ7ZA/OwvLcUE32gJBj4mjGFixsIdwaFL3S3iAIHaK7ca69305DPRMySYQ/Ty1txPRIlM2gklZBgRow2eN3uJ75dK3NOBc4GhHLXkfXZM12zZeHqvBm3wVoqciTtbqt7zVObe1YvNWiiXiu9htOupKc6npVge/FZ2E2ci/aYoIk7UR/9rV3qVmKTlcA4ZctWRj7rUvmUWP30EcDfjI1r8F0kavML9tCj09P4YHwMxY6fKw9wqtgwzV+YEN0EZr2xpL3GSolDgjCMxEzDhaxkT1r5RlwJoOKnYLCxi9DGGDUtyOa7AQv2x8E+FBZQKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKy/rDfzGpJKLFFCn2k/MvD/HsxTS6xkWQsrYZpIg9U=;
 b=kfgBR6GD9cRhlQixdQ4wuJHgKYnjiq54zPMieELEh4tfK0zopa38CYGJEcKj3yEoaBasBbtedEqJswIoc4UcdkbdIuFtP9o6R9UTBBnsRLx809v1SCY0jPb3G4u73Q5x2qW0kxrTZk5eIrTmdWLnkxuxU2+HLS/LgcBUw04bcCA=
Received: from VI1PR04CA0105.eurprd04.prod.outlook.com (2603:10a6:803:64::40)
 by GV1PR02MB8330.eurprd02.prod.outlook.com (2603:10a6:150:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 15:49:07 +0000
Received: from MI3PEPF00008496.eurprd03.prod.outlook.com
 (2603:10a6:803:64:cafe::57) by VI1PR04CA0105.outlook.office365.com
 (2603:10a6:803:64::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 15:49:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MI3PEPF00008496.mail.protection.outlook.com (10.167.240.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 15:49:06 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 5 Nov
 2026 16:49:03 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 5 Nov 2026 16:49:03 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 982341A38;
	Thu,  5 Nov 2026 16:49:03 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 794BA305D285; Thu,  5 Nov 2026 16:49:03 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 5 Nov 2026 16:48:53 +0100
Subject: [PATCH v8 5/7] iio: imu: inv_icm42607: Add support for ICM-42370-P
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261105-b4-inv_icm42370p-v8-5-b44eb96020b6@axis.com>
References: <20261105-b4-inv_icm42370p-v8-0-b44eb96020b6@axis.com>
In-Reply-To: <20261105-b4-inv_icm42370p-v8-0-b44eb96020b6@axis.com>
To: Henrik Grimler <henrik.grimler@axis.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jean-Baptiste
 Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, "Joshua
 Crofts" <crofts@kernel.org>
CC: Kanak Shilledar <kanak.shilledar@axis.com>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4555;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=BvUv+MHyknp2TjBp4CQJA0GCDASYWQCY1WB8LtvwtB8=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsh6szQvjZNve9P1xUWRsz//vi+T2d15vy0ovuOHja9K9
 5aHx57O7ChlYRDjYpAVU2Q5Z7Q9en/yP9050k6XYOawMoEMYeDiFICJGNQwMmyu61RZHa8vdfjJ
 WQ73I6f+73GaYeJ3TjFxYTmfzfEdFW4M/7NDBXMm/BXZwNE7w6YyKDy6I5Z33u8t+laRRnYnamJ
 msgMA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008496:EE_|GV1PR02MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9f5c61-362f-4bb8-6fec-08df3b54531c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|32650700020|376014|1800799024|7416014|82310400026|36860700016|261021123027099003|261021121427099003|261022105027099003|261022075727099003|3613699012|261009223027099003|261009221727099003|261009223327099003|261009220027099003|261009221227099003|921020|261026121527099003|261026140227099003|261028144727099003|11063799006|261102123227099003|260925022911599003|260925021911599003|22082099003|260925021311599003|6133799003|10067099003|56012099006|18002099003|261102130727099003;
X-Microsoft-Antispam-Message-Info:
	lGdUz2i01Jss8DFIjcmq7X8+j43d/j+v7qrN+Cd/CpYyzGEyL3s5waYUSjI35+uL7F+w0zkpsnsg3/R7mDAJQcKTqf3uR2feWpzHZ3T7drnbLRTt7pWxGu+imKoU8TBy4QSNrlGhxCAq+1/Cr5kzyuyhsvxIkfQ1yStzvzR8wYicoSFaxiLSUkXS/jFPPR2bHP6SgJqM/LSRpXJavsFXHVZPoaxSOEj3RDzEvYHC5lQvIlIXO0K2OKhxQW/la0IeHwsvh0u6Ktj5V/gBavJ1OhGgN3MsTqwvltFetvgHCIYQUwJY1fVfKwt+7Z3NcNEhVFf6Z8/UB7/WDTnze1WYZnI+PTrc8vj321dEy9hpw0e1y1BHM5261eNZI7EI3uw7Wyn7Ly2wOtNHK+BLwbsxe8ZsrxaBRG23eFOv9QfE+XnInn8urWyny0OxTipaHiqEAdc28EGE4NPzoiIUtLu38k1Kn09jOg2KlPpGWRBSSjEfTiP206lIpGOk8Vvf1tg2cfqgnQxvQCEIkOiWP2bY2G5FKYXbQLGNDJZAYeOc/BMfk9hXhnppbSD4K8xQT+kAhPgwQbjblEfV1w0F7R3TNADNymKlPjvsriDX3CzI4WH7HAZ8S/5+6wW+N5hgQznuwDsdJk6xLoABRpYSqKE3hIrwexbrAvVlVoU48WsFCwwWWeh3jW4Sqdv3NHkD6QMC5jIGl5akH89A3G400VahfQUH8/85aH+dl/1BrBvz14E=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(32650700020)(376014)(1800799024)(7416014)(82310400026)(36860700016)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(3613699012)(261009223027099003)(261009221727099003)(261009223327099003)(261009220027099003)(261009221227099003)(921020)(261026121527099003)(261026140227099003)(261028144727099003)(11063799006)(261102123227099003)(260925022911599003)(260925021911599003)(22082099003)(260925021311599003)(6133799003)(10067099003)(56012099006)(18002099003)(261102130727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cw8qskOw9ytTDHe9DdIiEj3z19uAyqMG1iBtwRU2lk4wY2vTM3rIX1JOqS+JUu8thSIDsLoFt/S0++RCdL0J2qPKlUL1Tq+oSSIy5pjCxfmozjnWl0Eibg9yn7hMt9quuj4xAXDkRWJ35eH1ytWE7EYfBc4lWfFkO5Uc0Q7nMyK2UazW9keNV92GxM0Sb/cLly0Nhj4nZrbnx+yrciuGW1N/5V3OcHo0pKkLcmYesjhXlnj0o4c60ysXA+00E49fQE3bqWzowAjWWxW3Ah+LmgK89JXxtIuJjHQCWDBk6/zaNS48FTc+lb3++7Y6RNxkfgIUIeRRCroLuZqWMpiRxrNPx5edrP4NOfMbbdoF806rw2p88YlMH2GgLVFUrxapLKfujNjXPiEsLXRl7WjG3y6K1A+ercfhcO8gCaFNjGn0af6SLCZbarPrXQZ9UHTx
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:49:06.6931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9f5c61-362f-4bb8-6fec-08df3b54531c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008496.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8330

Add support for the Invensense ICM-42370-P MEMS MotionTracking 3-axis
accelerometer with built-in temperature sensor. This device is almost
identical to the existing Invensense ICM-42607-P IMU, but lacks
gyroscope. The device supports I2C, SPI and I3C. Implement only I2C
support for now, and provide support for raw sensor reads via sysfs.
There is also a built-in temperature sensor but it can not be turned off
similar to the ICM-42607.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h      |  2 ++
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 22 +++++++++++++++++++++-
 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c  |  6 ++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index e4075288247b8..674a9896fabb3 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -367,6 +367,7 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_REG_FIFO_DATA			0x3F
 
 #define INV_ICM42607_REG_WHOAMI				0x75
+#define INV_ICM42370P_WHOAMI				0x0D
 #define INV_ICM42607P_WHOAMI				0x60
 #define INV_ICM42607_WHOAMI				0x67
 
@@ -391,6 +392,7 @@ struct inv_icm42607_sensor_state {
 typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 
 extern const struct regmap_config inv_icm42607_regmap_config;
+extern const struct inv_icm42607_hw inv_icm42370p_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
 extern const struct dev_pm_ops inv_icm42607_pm_ops;
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 84a7a7718dc2e..5ab15525c63f7 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -77,6 +77,15 @@ const struct regmap_config inv_icm42607_regmap_config = {
 EXPORT_SYMBOL_NS_GPL(inv_icm42607_regmap_config, "IIO_ICM42607");
 
 /* chip initial default configuration */
+static const struct inv_icm42607_conf inv_icm42370_default_conf = {
+	.accel = {
+		.mode = INV_ICM42607_SENSOR_MODE_OFF,
+		.fs = INV_ICM42607_ACCEL_FS_4G,
+		.odr = INV_ICM42607_ODR_100HZ,
+		.filter = INV_ICM42607_FILTER_BW_25HZ,
+	},
+};
+
 static const struct inv_icm42607_conf inv_icm42607_default_conf = {
 	.gyro = {
 		.mode = INV_ICM42607_SENSOR_MODE_OFF,
@@ -92,6 +101,13 @@ static const struct inv_icm42607_conf inv_icm42607_default_conf = {
 	},
 };
 
+const struct inv_icm42607_hw inv_icm42370p_hw_data = {
+	.whoami = INV_ICM42370P_WHOAMI,
+	.name = "icm42370p",
+	.conf = &inv_icm42370_default_conf,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm42370p_hw_data, "IIO_ICM42607");
+
 const struct inv_icm42607_hw inv_icm42607_hw_data = {
 	.whoami = INV_ICM42607_WHOAMI,
 	.name = "icm42607",
@@ -662,7 +678,11 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
-	/* Initialize IIO device for Accel */
+	/*
+	 * Invensense, ICM42607 and ICM42607P both have accelerometer
+	 * and gyroscope functionality. Whereas, Invensense, ICM42370P
+	 * has only accelerometer.
+	 */
 	st->indio_accel = inv_icm42607_accel_init(st);
 	if (IS_ERR(st->indio_accel))
 		return PTR_ERR(st->indio_accel);
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
index e903106af84a8..9f34199ce2949 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -58,6 +58,9 @@ static int inv_icm42607_probe(struct i2c_client *client)
 
 static const struct i2c_device_id inv_icm42607_id[] = {
 	{
+		.name = "icm42370p",
+		.driver_data = (kernel_ulong_t)&inv_icm42370p_hw_data,
+	}, {
 		.name = "icm42607",
 		.driver_data = (kernel_ulong_t)&inv_icm42607_hw_data,
 	}, {
@@ -70,6 +73,9 @@ MODULE_DEVICE_TABLE(i2c, inv_icm42607_id);
 
 static const struct of_device_id inv_icm42607_of_matches[] = {
 	{
+		.compatible = "invensense,icm42370p",
+		.data = &inv_icm42370p_hw_data,
+	}, {
 		.compatible = "invensense,icm42607",
 		.data = &inv_icm42607_hw_data,
 	}, {

-- 
2.43.0

