Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793012605;
	b=GVe4ZTJ4zRJ8w3S5b7ra8mXFeO/1U+LYI1pGoXuFKzpJTSp/nGp6/+f77+bBRAOhwDRn
	 LoT5i239pmihPMm80VSOdiUS6Anzi5y9icPzL6zHZG3wwxcEI1fC9ARdwjHzcrOQvqScv
	 oL+1+sLONGXOiNgktnqzw+f6pY9r7XaqAbUX7Cl+diB203qNpgGbe29Kv71ejw2SQvq5Q
	 5DkOsigjW84StQQ5P6lzo7dHW4t/I6puikJHFZubV4n2+WYsgQZmRLCOaON6S48sU0byF
	 UqHsr8Kz6+qgXoYNvs5Nwovz5QgwgGjV4Cj4US63Ezn0T1N0HODkg4bHcPjp6sVUYug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012605;
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
	bh=QrdHY0Dyhj2IcsbH+rppibOXVPIKtnAzISA19gx6ZNE=;
	b=IB6+wP//d00dOOz6Df7lZs/gkFGDP2/NISFwzNRqlj36/sLXU+QrtyXAg52NaZRW0+j6
	 12NuYK0ft5mYKS0Yu+iQgKThAz/+EwaKjLRUbcFVVQzQEkxkhCNvIakTwNS0ebyFsOa8R
	 a4kMy831ixUH4IaMUIwpdIAw1cTXjv7gZmJle981imqPz+PaUA3GAP2+MaHpTykMtiJe/
	 4lfXgXRerbeGRxaQZ121GQ01eMGa6+IiqEKSB/obSftlJTBfBdNu49ZAPhumjEAksXZFM
	 z2VniYB7OxcupinbWZBmV2tdhkt8Y9v9cxuJgy5wLOkJ6Scs1AZAuFJ/BKaZ7w5cjDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b="C2qo/ag7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.61
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11112606A31A;
	Mon, 26 Oct 2026 11:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11112606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=C2qo/ag7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H214AdOep0iMeT8VS8aG8hvDOekMDXMDPTnuwZamMS/Ao4ydgU1LD9mCFaNA6TrlLjgtsFx1RsyLXhfP3veMYN2cOHdDrR0/Hdd+Szy3vNmdAeAAVPujn+HjDp+e+M8U6YmCzkQkEr/aj+/wCyuMpmXw047QxM/5md0X1bUoENF1tkOP/uvPJzuyKeZgZu5QXI1POgJ24ZjxNTHm4QoauSuwQfnPtjvrfKNCiki8eMRufBN95Q+3q9Zji8UBS95WTGvQlerUbARQgd+PUWyQHYin9U33HxHS1+PEpCRcxieQfXxqGhIk2ymH9o5EkfEIv6VmnWXn/0Cxf/uCMxV4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrdHY0Dyhj2IcsbH+rppibOXVPIKtnAzISA19gx6ZNE=;
 b=PczhKBkpIMpqYVCGJV6PqmAlpuaL62W8RDv8L6c87ul/b6bOSMKqA+NhpZZcHJcWR5svrsZulJgY/Y4BAurBGKSk9cUUKSBUn+lgPZcSOPb9TXKFwG0KCwAV3fpZXZlttHOMU/2fshDmT0rcpQPl5JqKHutt19/p2xJyxygGeBPBZx7/ZZzEPExpkuX7CckE5IS7T7ZYRDGQZFDmQ/5RojwC1PF+0aCS+hZc2jISSWqfymSq1w6RpWwDiic0Y18FW9Snhuo+Is7UCVkJPCc5OEX0NDlrt15QNw77xamwFe5wWse6LyilA6g5IGoi4i8SNLLZLikHmt+i5fv2kHjIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrdHY0Dyhj2IcsbH+rppibOXVPIKtnAzISA19gx6ZNE=;
 b=C2qo/ag7D6vweVOFw2iYryaIxFT5pikKaR42oM78rLGX40uvF8829uo2QdZbSlMMN/vGEMcq2wskFm3pV1IaHSNnEZSnVniC8KuW/l7cfbP69mARFEXMCRrIjhjKHbDdA8NL8h0F8ft0vHWk26dzjQLAJ7IuF76Jdd4IB/DHtFk=
Received: from GV3PEPF0001DD92.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6d9) by DU0PR02MB9750.eurprd02.prod.outlook.com
 (2603:10a6:10:44e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:03:22 +0000
Received: from CPH1EPF00000524.eurprd05.prod.outlook.com (2603:10a6:388::1e7)
 by GV3PEPF0001DD92.outlook.office365.com (2603:10a6:158:401::6d9) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.406.10 via Frontend Transport; Mon, 26 Oct 2026 11:03:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 CPH1EPF00000524.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 11:03:21 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 26 Oct
 2026 12:03:17 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 26 Oct 2026 12:03:17 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 732A62EA2;
	Mon, 26 Oct 2026 12:03:17 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 43E7630182D8; Mon, 26 Oct 2026 12:03:17 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Mon, 26 Oct 2026 12:02:53 +0100
Subject: [PATCH v7 5/7] iio: imu: inv_icm42607: Add support for ICM-42370-P
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
Message-ID: <20261026-b4-inv_icm42370p-v7-5-222e296ac1e0@axis.com>
References: <20261026-b4-inv_icm42370p-v7-0-222e296ac1e0@axis.com>
In-Reply-To: <20261026-b4-inv_icm42370p-v7-0-222e296ac1e0@axis.com>
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
	<linux-kernel@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4555;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=9lnYCJmEu7mNHCdKrbLugMOpNdGZ7LyB1WNcrA9aOX8=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsi6b1ySGWC8c/HWhE3cZ/aV17Pm8wjqvhPyXh24WvTp3
 5fONy0rO0pZGMS4GGTFFFnOGW2P3p/8T3eOtNMlmDmsTCBDGLg4BWAiyTIM/9Nvi3ts9HZk8P5Q
 GOg8/ccpc+kNHzhY7h766pa2vL7y3RlGhuPfuA44fb8Z4Kvy9JtG+RyJr+VXJd8aqxQkXjnJ8U5
 4DzcA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000524:EE_|DU0PR02MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: 328ab580-6f5b-4e08-b1c6-08df3350bfd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|82310400026|36860700016|32650700020|261009220027099003|261009223327099003|261009223027099003|261009221227099003|261009221727099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|260925021311599003|260925022911599003|260925021911599003|10067099003|56012099006|6133799003|18002099003|22082099003|921020|11063799006|3613699012;
X-Microsoft-Antispam-Message-Info:
	IaZqQ8ujELW9diypJEJ8TYlu/LNmq5B2Zh2kXwfWzrupuDIMptOmTzWdMM9LH0bSYirBgAytefy+4u4z0obg7Ofe1pgP4925ThCYUexJWILx2N+FC6yhZAdLcyPQ/AspzE1b2GWqTAo4HEDuJGg1M9IzZ6i+L65UnLRMzviJZuVPqIOsYETEPHBln5RdTxo3vF9J98dc7jawLAFSqDbCCkOw5QpIEF5GHkNCWIKT8QsfS8QWnI6zUVxr/pPdomtRgtF5nPg4FYGNAb59z13amXGy3p+xUgRMy1XJqLUSOC3enLs7hLSUTUyTd5+p2Gyj2nsNkf0QKhtDxO3uuV07CS3NxnJ3GD37hHPUnnWtKI57yqap9q8Y4Qu3uSEQ2gSovcqtZdQ6pRA2MbupgXidWjtpQIXGCT1Wsu3H170P29teh0IliDZob+CwC6lf/6QoAQXQiDPLmAC9ArAwu3faCPl0qLpEJF6oHNYS/dz0OJ8YDU+Zen67+sVskxV/+3gzEpW4fLyaYvP7t9GkSlq3hmg48hiHiPKf8TWqGCrag+ptduxyWvDUrunlfI17170k22ZoW2tqR7A9n61XFEbTgN4d4ZyxMSwHPnJ8rhgITI5PFic35QGwFCGcIMfoqUBCXZ5oM3QksHE+g5274ePRMvLoNjpFXai+j5zQXjeYk8eto6vGigGycsijjjnc+o54qomMe+q14vc1uJvqMbX2LkiOT+TcVRnG+G4HPFamJRY=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(32650700020)(261009220027099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009221727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(921020)(11063799006)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K8dFPuODvIkA3/uo7VirnehQhIoaeRbhdkvKs3NoF70p34PRF9Q3H5iQRidcK4DHrBopkMqJjmoa6ax9ZQrGCECFDfBzYCzO18enn11PkE2HGOUnbPaEvgEO2e7eEf2yYJ6aGOMpaYDRmp76DivpIJSYdpNxz6D7ZKHXNqcOWQDgrVkW/5P0e8F2wYqaLIG/BpTR0a9Yg5KzYF4q3XVa7Su6P4hoojj5z6d/NHRIWKvCKPctpaaTGY2JulC7Tm4Nlo05c5oV0rNqs9gKMboxNgF+fJBovv/npa54SEov+/I1DOdWHubDUYvan9BtCzqx5Nc+bvpwrjGtBIpZ+6d1aSmVYON8w9+XNAKAh4KMbBXUUQoVK+h8sv9rxaDWmMl/ss7U09y3oYbDbwa+pCldoCzSEfGXSfU8ZTn9ldGelA/DmjmF/TzroB5TBRDOXuZF
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:03:21.8429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 328ab580-6f5b-4e08-b1c6-08df3350bfd3
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000524.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9750

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
index 8acf745b1451e..018a7506ad50c 100644
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

