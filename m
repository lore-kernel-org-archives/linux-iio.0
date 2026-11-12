Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493896;
	b=cBL5427gczENqGa+DvGcMImhorvkfgqfxtAE/dX0lfcnxCQrscgXtCcPAliQsyRmjd/v
	 0HXDWqZFpNZlS1N2bbv0YIPygCCIu2GiHlmcqNTlelCNv87nkvq6hcpYDqLDW3ZvXwidb
	 z2nx9XyQBFFqf9Iv2/RX+33aBOby2M2Pcoi3FxikdeS/pITp6WnzgVGpnRlELeV7oJu16
	 fUTZ+kD2fPzod/cryI6A1z7IIM2WuPyveKMD2dIZWvwf8yXD2WmZ37AsQAMCW8YjEc/Ok
	 bOPk4+mVj8jOFuaaSLqOru80wWvmMSTwt85Ug5MF47koMVHqqSv0AawFcDny7e0y3PQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493896;
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
	b=TMltZhXPgj3OxaG0tE8iwI+x6KIWeSFRwYfEYXojUsEtFsLfKIUResTUDLKFbDdOlExp
	 CVeWf8VKw+4oPBjxTUIQa7Ku65jfbzUnca8MrRxmBBWgzGsrXrIqWdb8f8y0daiKV+NM4
	 aCyPqwwzwnhgVbZWzYdyZ/HxfVmu72HdfaqXrHDK21l7TeFPrmNBdcU0IxzLfFZqeNNiC
	 SM+5AcuHb0EYDHGY2c8YO/GXLSemXUCje84r8GRa70bS5tL1bWFrlYxnErmheK5CoPGL4
	 wBhccOQW9GgbJlMVxMAZL0e+K9RVFswLPj0LYMk0Cvt4GHFTpauKVRu5TeAEtnhYZKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=YGQimY8r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.34
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013034.outbound.protection.outlook.com [40.107.162.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3124606D569;
	Thu, 12 Nov 2026 14:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3124606D569
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=YGQimY8r
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qc8ktPGbqWmDVlPiUmHNDwDtx6FR2m3+B4goNZjxSOer2OGvXqFQURFj28eti3RBw2r1reiChKFP8Aw2VkvaWdIumYsTUCJAfrznJ+XeGWhhC0FNRE4PXF/unP8spvjQE5Hx3l1fwViDrcwTBE4waFiE8LHKZgTi2Q3GwcQCnBCxmROVTd7CQ6v4AyGnujyiEyqPIIcFgqYQPglpdQpBtN09ROr0a09OY0V1e+9sCUWJ/mKCM5lTMbFzyG2q2vdqKq0mP+83fAtGC11SvLu6fyI9ShscQuZInte4TKe/YOjsPYvVWPoNfWZiiFD2NQok6OLM1Ld9sHNjMbAqnhxuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKy/rDfzGpJKLFFCn2k/MvD/HsxTS6xkWQsrYZpIg9U=;
 b=X7WUP8f65TNo3F2ciZjxd1YF7P8VgX8NGfTJi5G67W6n27HWMtHsr1xa3aPjOirmzXNMF45JKDzHoFBw71rVbHys+ech2w+o/qs6ykGcTBeEUX1JIyoW/8fNQYqZgJvRW21wrqI+qBRDLaLFgi0qWwyvKshIupGu9nA1HURO9i9PG7ZTrO+oGe2rR/LREU2JT/5G2HFWTeNMU2l+LhqgGqSZRkOdcvvDStsBu/2DdsBhiQEv+xvR6XVDkCp5IadaFluuoX82Mjr90RFZnVoUCYEYxo+/78xV3R5tKREAK23lWuMhSj7pf8QXBdG4LkXRhoxLJBzuO+pARv4bu9PpGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKy/rDfzGpJKLFFCn2k/MvD/HsxTS6xkWQsrYZpIg9U=;
 b=YGQimY8r/855ssMOf3Bs1Ru3TLAXvx1U5HFiI4t3pzgNkvTcLBwgID4CQOuEmfOkSTBKhTzVjJAHVCWUV4tiT/xJbkkzAViGKKQ3/GcDg71KsOJD23sC3iz4/31SY/duQa7E0YmIGbGdWvTENZS24Z6oOW6vY26VM64lXlkq5IY=
Received: from DU2PR04CA0267.eurprd04.prod.outlook.com (2603:10a6:10:28e::32)
 by PA1PR02MB10959.eurprd02.prod.outlook.com (2603:10a6:102:48d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Thu, 12 Nov
 2026 14:31:30 +0000
Received: from MAD0EPF000008B0.eurprd04.prod.outlook.com
 (2603:10a6:10:28e:cafe::86) by DU2PR04CA0267.outlook.office365.com
 (2603:10a6:10:28e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:31:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MAD0EPF000008B0.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:31:29 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 12 Nov
 2026 15:31:07 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 12 Nov 2026 15:31:07 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 0C6912893;
	Thu, 12 Nov 2026 15:31:08 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id DE1863061557; Thu, 12 Nov 2026 15:31:07 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 12 Nov 2026 15:29:31 +0100
Subject: [PATCH v9 5/7] iio: imu: inv_icm42607: Add support for ICM-42370-P
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
Message-ID: <20261112-b4-inv_icm42370p-v9-5-875c828a281e@axis.com>
References: <20261112-b4-inv_icm42370p-v9-0-875c828a281e@axis.com>
In-Reply-To: <20261112-b4-inv_icm42370p-v9-0-875c828a281e@axis.com>
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
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsj6enb149XWHE8/F7PPEw0s4L3R1vMkPlUv2kjDNprxn
 G7a1d2pHaUsDGJcDLJiiiznjLZH70/+pztH2ukSzBxWJpAhDFycAjARUwVGhsXLM/2dpqdODNqk
 tOg1/1fLJxPCdxz3Sjo7VXJLeH7IB1FGhrNsF2Nip8zf99q5TH/fkqnykyaEHvNoDW98EZv6yPm
 6ExcA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B0:EE_|PA1PR02MB10959:EE_
X-MS-Office365-Filtering-Correlation-Id: ed535e19-aeb6-4af0-08a2-08df40c9a459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|32650700020|36860700016|7416014|23010399003|376014|18002099003|6133799003|22082099003|10067099003|921020|3613699012|11063799006|261028144727099003|56012099006|261009221727099003|261022075727099003|261009221227099003|261021121427099003|261009220027099003|261021123027099003|261009223327099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261102130727099003|260925021311599003|261102123227099003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	LYksmNW5IxnHcyCeuHcbX5tav+aOsK2mrCP1+Apr9gvEdis05B6+E88zldkiN4xp3hMyS+kqsvYTkrzgrK8Qg5VvvTyw0bUUzARVw8ya8vsnGGF7cCWMz+eaub8L4tXitjd4Ga+eEDuNblM8/JjYdPVINNFGPMcMLxF3gafTeTf/UtOlivbvwKoEkScNGuWnjunF2KooYHmnT4eHzB+aFJzem4ILOufkdH4G6NIV6PfNIwZFOepXxt8JHwTD8peq/5gGBlXs+kOOs0IG6QES/AswAGmm4A4gHYl1vcW6GzvnAjcFCOVnF2eDBNdVHjqKSFfVY+V8G1f34Q1PLWi58FPIwsxOmwjEvWmLZKy5x5778bnePsbVB8A7SfOrnKosEsuRcENkeDupeP9yIeGSKOwmEg5/RBUxSPlJt9p6tcfIv7geWvUTh//Bq9ha7Y4v1CkeF7FU6mg15UagKWXDinKc70g85UH0wgSDtdD0UGHh8ig1Nbuk+5VlCNoELB9Whfgi/iprYXca4WmcY8pjhRQG+en+cGVh5q1on/+rvLgdKY9A3K7vAWlsMirfapAjig6YeZ7KRStwTLeZW5avIeX6o7Z7GDDfEfu8CpwMWM6Z6dkuAk8+ZAHgTxqTIcsF3sPUqsMsXcw9UrQsjtTHr0Cm/aIipGTNIDsLyzZJkzePllhKWRp3p4969gp4MxgEf/3CvY8YJ/ge2MyBpmvBpQpvybptclqSS+0aTwJO/qc=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(32650700020)(36860700016)(7416014)(23010399003)(376014)(18002099003)(6133799003)(22082099003)(10067099003)(921020)(3613699012)(11063799006)(261028144727099003)(56012099006)(261009221727099003)(261022075727099003)(261009221227099003)(261021121427099003)(261009220027099003)(261021123027099003)(261009223327099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261102130727099003)(260925021311599003)(261102123227099003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	atEPob1corAHUT6soCqlM37uiD0IY093Z6OIb2d/s4yR0FNXYtI+VNE9aIhTBRX9zmKZQ2kFTReQ9DomVkb24QfT4W77aCWRphrFREyE5UFtw19jMkUbKi2OcZaRzpPgwst/AEONFt769RZBFS0bY0nQwpocq3YBnEaQCPx0g62c1zXO1+oDOFP8T1RBH3tFIQ1uHGx+++Azbksl3k59VmYCif5vuW76VDLzFIaYy7Srq5gHAgDA+SnixwLvn2XARZsIi0wB2a0+tQD0Ml8VcUAYNRp8pOoEfRx3YdJz5FFwdjliFvWX+V0enn1ZPqhw6xka1YLHNiW3S/6GD+lhhwHqGqWMOoEVOQdY/FF8o54UBOzR/ch9Qu/q7iVYnqJo8QVb9NeLsBcwHjbRKcrLfRPAL/0+8fax8uuPJNKjiUjk5SNr0TzfYAk8ieBUutUq
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:31:29.8921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed535e19-aeb6-4af0-08a2-08df40c9a459
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB10959

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

