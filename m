Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493888;
	b=qWOy1wqakArvWawFzXVNcduMxHTFAlu1vNiMiTe4qWoyjQ4Qj1pzDfg576MdwvGVwtXo
	 Bm8o8d855BsNp81Ovf/GrzAUVNRbbFzK9gfsuFpu9nDkJjXQCZ+o26m0+AlypPshkRiog
	 HVttp7gCutURdHFsMPKWImXQ5A382HMA5W56s7Z4VaN0dyz97EsSCuYah8x6yHsibodOb
	 7tn3MJN8KhuDxKzP01fo98utOVdZVZVZgPKOEamLxHAQv5hzacmM0UVKo4bsYYqwPge3r
	 nFPgCgWpqgpF0wUn6xRU3JheVKaEVaiLTbX93oMTO/TvSMjnn5fx8R21tcYjp7y4h+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493888;
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
	bh=4ZCpM/ob/i8EJtqAhrBc8RnH9k8w3bEUeTDYJVL0Da4=;
	b=DrZqJ8bWMT64F0e7SfuD0WrNZios0u2C3E9zp4g751PTcvZY9tNKMSfFtUzL/U5oC00p
	 2ce7X31u9lyua05P/ZfMRKmSUNecSdTfE82Ii07omtxW2GhjeT98d0spg0fG59JroIPvb
	 GrzsGvjW1Xv2v2KOLit4EtLv/6xY27dHZ0X7HdCyEJbZz6shWHPpIIShoNWokARA+mXDC
	 E/WQw4qds3frWv4gGol20UdIoJvnp6cgB3TOu9nFmH1rV9KMux5nZfSSIpKWxINUTnMET
	 EPNAZW3dAVSffxEGS0nbZWAZkLTMId8OBWKm8Jbj++rGWbabQWGsOLT2hzAB5NgUYsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b="b4xc/E48";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.58
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013058.outbound.protection.outlook.com [52.101.83.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1456F60A3825;
	Thu, 12 Nov 2026 14:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1456F60A3825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=b4xc/E48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TI5KsD2H8bq7QPUa1Iy/Y22NKxDu/Sc9PCU4LF7VrPZW4VADjMJHR44h2MU1XXers0TGu4EkbFOY2HMzRL6UNd3C7/qd7D8jCAE4ZiB/2+x7xRcLJFQ6xpwRUCl3LnlhjChq6qVPIoSETWeawcUXM4kWNZBf2KZs2pkDAhzW+W8FJbgCHJgGzCVplTWQtql5TVtliDsUAljQFvrJt55KXNcmy1hWt8rt2w0j0Ny4iUAu8Mt2VGrClTeph/wYiDuYJNkZVzCtwHA7CqoP6RBHDdFn24VHUATFBnWMpr2MZsnOycAkGYWVzVFy0/ptAHzpT3//pA2d6PUfiPuFx6ukvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZCpM/ob/i8EJtqAhrBc8RnH9k8w3bEUeTDYJVL0Da4=;
 b=DAsxPA7et7STVCL4JU3NZKgdu1yKCm0wDrFkJe3AvLsdKxfLEm80gpVQ/UBvRBWrd3BCi5ElWR+t7FM4ZEmJh7CFIYtXkJJykhk4NjgKty2JyWLlVcLNkpB4aYGHrIJw/wIQoAqhs3kM185SMXM4OeTCRhttRMeFJphAckwQA654BCjGR8sj8XtHhrjrG7cE4Lgb9RXJekH1Qn8vWwN7e3ICjEjhpLKoAdYmp2cey70sKB/1JN1Spe1WATRpP2OyAa3PEGq+gsHLVJ3b7Lk71JXAq6THZ3mXnsRXDS099XpoMrlhYP9eMR211zDI9iRemzc4TFj9bLzFVWJu7No0Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZCpM/ob/i8EJtqAhrBc8RnH9k8w3bEUeTDYJVL0Da4=;
 b=b4xc/E48RGNDFRurdkhk65pK/ojco0MQOn68BCwVBEt/wSmqVDWdkKT+Djddbj7/JSj6sElfB2hAVQZVhUnywmacYcg/n4auK/TGujCOsp20otUHLyXRykxSjh8bGRbvxZzYLnK4Aj1rUaDTIOHUGjUs4GRmCQQJDaCUmRQZJH0=
Received: from FR5P281CA0021.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:f1::17)
 by DB4PR02MB9429.eurprd02.prod.outlook.com (2603:10a6:10:3fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 14:31:11 +0000
Received: from MI3PEPF0000848A.eurprd02.prod.outlook.com
 (2603:10a6:d10:f1:cafe::51) by FR5P281CA0021.outlook.office365.com
 (2603:10a6:d10:f1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Thu, 12
 Nov 2026 14:31:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MI3PEPF0000848A.mail.protection.outlook.com (10.167.240.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:31:11 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 12 Nov
 2026 15:31:08 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 12 Nov 2026 15:31:08 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id D74DE27C4;
	Thu, 12 Nov 2026 15:31:07 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id DDE033061556; Thu, 12 Nov 2026 15:31:07 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 12 Nov 2026 15:29:30 +0100
Subject: [PATCH v9 4/7] iio: imu: inv_icm42607: Initialize gyro based on
 chip_info
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
Message-ID: <20261112-b4-inv_icm42370p-v9-4-875c828a281e@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9440;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=V0Dl7xaRGyDLOFQD9ultUSYNlfOitxcqLYuBHT0Iym8=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsj6ena19FOxx2s160qeOliGyisqVibse8vFaBGas1DuQ
 3HrC9vqjlIWBjEuBlkxRZZzRtuj9yf/050j7XQJZg4rE8gQBi5OAZhIricjw7IIHnZOzfUvFlmd
 6p3DnN3SGdTQeKv6Dtuu1X3fRC8YJDMyvN/+beakMw/OhTUevv5H8tg1jdlZT115Jjifa+/hEf6
 +gAMA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000848A:EE_|DB4PR02MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e00f4a7-4af1-42ea-16f4-08df40c9994c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|82310400026|36860700016|32650700020|3613699012|921020|260925021311599003|260925022911599003|260925021911599003|10067099003|11063799006|56012099006|261026140227099003|261022075727099003|261022105027099003|261026121527099003|261021123027099003|261021121427099003|261028144727099003|261102123227099003|261102130727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	42qiC28wZ1smTvrdVH1OA0vkI3HkobEyX7RgxQlRk0lf5bGJg02tLR/HVrqfrNxtPbCV3ZWv0Ft9XLTAUmEPKFRomOsQaC3YOv/hbFDNb2hbkA7YiE4a/2ehBxENgeZkG/C5dMZ1RNJoLvUJxc74OvZLiLKq5rgwjp7ahw/ckVmP/VRc9gmWJbqFJQCn4MpjW3Xy1tfrlA58q5LpbNd3h4NLSq3xzuSbfRN7ZuGnFtbT87dzB8i8rX4gN3RccdAGVowcalHCkavSSxIpyHC4fqUYNRus/O1sKB6weFc+HtdZVyvJ0oiSABfkZQ2aQg7ERFeDYgw0bUun3BcRqZKeG2UYxFyExoClrT2RgPf/+XetjPRpIcNhS52cT5t4XlXOJJxOvRf9YhxW/H86iYB0C0EYHF9C8pRL5PIgpS1WY/7XoF9dTzaVgLxIKihi+gMkqKaA0QnuJFjFdmfdNw20GyxOXn9xaozN1BSJBMzq4+UN3LmYr8H53rfPxQHvDGLRnmhQSyO+jBL6BnHx2enSNrRqSl2Mkyklif/BNG6Tv1Yizdti6kU0fo2JK7l9Z/p7imw2mldMIT8MByodJHdOuLHstnrnw4i3avZFpOj5A6fpnmLyMuaehcfTMAoMcU85m7kTxueuvHt1GwZWaoinAl/ydt/G2uoQOdMP6/RHroMqMJLN9LkeM0S6dTSRdGFmaY7NhXlBC2G2C50UcCZsZ1Y07vaPBUdQJxgkKnm2kpYyJY38q5IN1JJO9yNHMPxHWb7MLNZWHJ2Q6LLJhud4kA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(82310400026)(36860700016)(32650700020)(3613699012)(921020)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261022075727099003)(261022105027099003)(261026121527099003)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261102130727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i3vwrCgEZRK5oaHwqi7+XdvB4FoWz770DJsHaUWqmZC/m1HTBPfTdUpTap7fCN44qPtsZ9gCkHrw1LPHkdI2ZC8euL1j6rrRWoGq0i2JnGRgs6vgTBYe2QurwovXtG4Nduo/vgllM0pjHrWCZNdNzZpTBYg3ZpbWYefvwtA0zz96Yms0chCNXsY+i2gig8bsDw4LjR3ZG24COaxgHGCSQhE44YAuURvxf+5JOPPBXGKbXaDkdO/tnTVWRIC8TGPTwQBJG/+1waANyL2ZK4zLmSy3s90eGV+Ct3Oj3SDElMX2sr3xg/zddP56Rizz6+5Oe+5N0Br4avvGxgeKtySw1W3EBWjE52FpFBo8G5Uxg27Ml2Ao9DwRkLF3DRDcRmNSKfc/9dYjsTp8epe5A3RoPWPYTvA2vqjz4UpD34K/XVXv+7Feg3+Yfc8GSHofse/3
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:31:11.3771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e00f4a7-4af1-42ea-16f4-08df40c9994c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000848A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB9429

Update the chip_info struct with a new `has_gyro` property to support,
devices which do not have gyro functionality. This is a precursor for
adding support for the Invensense, ICM-42370-P. It is similar to the
existing device except it only has accelerometer. Check all operations
related to gyro with the boolean. Replace all the implicit comparision
checks with explicit to make it easier to follow the code flow.

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h      |  1 +
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 79 ++++++++++++++++--------
 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c | 12 ++--
 3 files changed, 59 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 4d51b0da1aa16..e4075288247b8 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -130,6 +130,7 @@ struct inv_icm42607_hw {
 	const char *name;
 	const struct inv_icm42607_conf *conf;
 	u8 whoami;
+	bool has_gyro;
 };
 
 /**
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index f4ef75da22c76..84a7a7718dc2e 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -96,6 +96,7 @@ const struct inv_icm42607_hw inv_icm42607_hw_data = {
 	.whoami = INV_ICM42607_WHOAMI,
 	.name = "icm42607",
 	.conf = &inv_icm42607_default_conf,
+	.has_gyro = true,
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42607_hw_data, "IIO_ICM42607");
 
@@ -103,6 +104,7 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
 	.whoami = INV_ICM42607P_WHOAMI,
 	.name = "icm42607p",
 	.conf = &inv_icm42607_default_conf,
+	.has_gyro = true,
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
 
@@ -160,7 +162,11 @@ int inv_icm42607_get_pwr_mgmt0(struct inv_icm42607_state *st,
 	if (ret)
 		return ret;
 
-	*gyro = FIELD_GET(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, val);
+	if (st->hw->has_gyro)
+		*gyro = FIELD_GET(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, val);
+	else
+		*gyro = INV_ICM42607_SENSOR_MODE_OFF;
+
 	*accel = FIELD_GET(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, val);
 
 	return 0;
@@ -190,7 +196,7 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
 	 * wait if it hasn't. In case some platforms don't respond well to a
 	 * sleep of 0, make sure the fsleep duration is > 0.
 	 */
-	if (!gyro && oldgyro) {
+	if (gyro == INV_ICM42607_SENSOR_MODE_OFF && oldgyro != gyro) {
 		disable_wait = clamp(ktime_us_delta(st->conf.gyro_stop, ktime_get()),
 				     0, INV_ICM42607_GYRO_STOP_TIME_US);
 
@@ -217,12 +223,14 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
 	 */
 	sleepval_us = 0;
 	odr_us = 0;
-	if (accel && !oldaccel) {
+	if (accel != INV_ICM42607_SENSOR_MODE_OFF &&
+	    oldaccel == INV_ICM42607_SENSOR_MODE_OFF) {
 		sleepval_us = max(sleepval_us, INV_ICM42607_ACCEL_STARTUP_TIME_US);
 		odr_us = max(odr_us, inv_icm42607_odr_to_period_us(st->conf.accel.odr));
 	}
 
-	if (gyro && !oldgyro) {
+	if (gyro != INV_ICM42607_SENSOR_MODE_OFF &&
+	    oldgyro == INV_ICM42607_SENSOR_MODE_OFF) {
 		sleepval_us = max(sleepval_us, INV_ICM42607_GYRO_STARTUP_TIME_US);
 		odr_us = max(odr_us, inv_icm42607_odr_to_period_us(st->conf.gyro.odr));
 		/* Track the earliest we can turn off the gyroscope. */
@@ -243,6 +251,16 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
 	return 0;
 }
 
+static int inv_icm42607_set_sensor_modes(struct inv_icm42607_state *st,
+					 enum inv_icm42607_sensor_mode gyro,
+					 enum inv_icm42607_sensor_mode accel)
+{
+	if (st->hw->has_gyro)
+		return inv_icm42607_set_pwr_mgmt0(st, gyro, accel);
+
+	return inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF, accel);
+}
+
 /*
  * Sanity test between old and new config values, and note if we need
  * to update register config0 or config1.
@@ -339,9 +357,9 @@ int inv_icm42607_set_sensor_conf(struct inv_icm42607_state *st,
 
 	switch (chan_type) {
 	case IIO_ACCEL:
-		return inv_icm42607_set_pwr_mgmt0(st, gyro_mode, conf->mode);
+		return inv_icm42607_set_sensor_modes(st, gyro_mode, conf->mode);
 	case IIO_ANGL_VEL:
-		return inv_icm42607_set_pwr_mgmt0(st, conf->mode, accel_mode);
+		return inv_icm42607_set_sensor_modes(st, conf->mode, accel_mode);
 	default:
 		return -EINVAL;
 	}
@@ -417,29 +435,37 @@ static int inv_icm42607_set_init_conf(struct inv_icm42607_state *st,
 	unsigned int val;
 	int ret;
 
-	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode);
-	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);
+	if (st->hw->has_gyro)
+		val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode) |
+		      FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);
+	else
+		val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);
+
 	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
 	if (ret)
 		return ret;
 
-	val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK, conf->gyro.fs);
-	val |= FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK, conf->gyro.odr);
-	ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
-	if (ret)
-		return ret;
+	if (st->hw->has_gyro) {
+		val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK, conf->gyro.odr) |
+		      FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK, conf->gyro.fs);
+		ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
+		if (ret)
+			return ret;
+	}
 
-	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK, conf->accel.fs);
-	val |= FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_ODR_MASK, conf->accel.odr);
+	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK, conf->accel.fs) |
+	      FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_ODR_MASK, conf->accel.odr);
 	ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG0, val);
 	if (ret)
 		return ret;
 
-	val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, conf->gyro.filter);
-	ret = regmap_update_bits(st->map, INV_ICM42607_REG_GYRO_CONFIG1,
-				 INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, val);
-	if (ret)
-		return ret;
+	if (st->hw->has_gyro) {
+		val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, conf->gyro.filter);
+		ret = regmap_update_bits(st->map, INV_ICM42607_REG_GYRO_CONFIG1,
+					 INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, val);
+		if (ret)
+			return ret;
+	}
 
 	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK, conf->accel.filter);
 	ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
@@ -547,8 +573,8 @@ static int inv_icm42607_sensors_off(struct inv_icm42607_state *st)
 	st->conf.gyro.mode = INV_ICM42607_SENSOR_MODE_OFF;
 	st->conf.accel.mode = INV_ICM42607_SENSOR_MODE_OFF;
 
-	ret = inv_icm42607_set_pwr_mgmt0(st, st->conf.gyro.mode,
-					 st->conf.accel.mode);
+	ret = inv_icm42607_set_sensor_modes(st, st->conf.gyro.mode,
+					    st->conf.accel.mode);
 	if (ret)
 		dev_err(dev, "Unable to turn off sensors\n");
 
@@ -641,10 +667,11 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	if (IS_ERR(st->indio_accel))
 		return PTR_ERR(st->indio_accel);
 
-	/* Initialize IIO device for Gyro */
-	st->indio_gyro = inv_icm42607_gyro_init(st);
-	if (IS_ERR(st->indio_gyro))
-		return PTR_ERR(st->indio_gyro);
+	if (st->hw->has_gyro) {
+		st->indio_gyro = inv_icm42607_gyro_init(st);
+		if (IS_ERR(st->indio_gyro))
+			return PTR_ERR(st->indio_gyro);
+	}
 
 	return 0;
 }
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
index 53f0484c0845f..526f33da7d67c 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2026 InvenSense, Inc.
  */
 
-#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -20,10 +19,10 @@
 static int inv_icm42607_temp_read(struct inv_icm42607_state *st, s16 *temp)
 {
 	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	enum inv_icm42607_sensor_mode gyro_mode, accel_mode;
 	struct device *dev = regmap_get_device(st->map);
-	int ret, gyro_mode, accel_mode;
-	unsigned int val;
 	u8 raw[2];
+	int ret;
 
 	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
 	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
@@ -39,13 +38,12 @@ static int inv_icm42607_temp_read(struct inv_icm42607_state *st, s16 *temp)
 	 * as the datasheet says the gyro uses 5x more power and it has
 	 * a minimum run time of 45ms.
 	 */
-	ret = regmap_read(st->map, INV_ICM42607_REG_PWR_MGMT0, &val);
+	ret = inv_icm42607_get_pwr_mgmt0(st, &gyro_mode, &accel_mode);
 	if (ret)
 		return ret;
 
-	accel_mode = FIELD_GET(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, val);
-	gyro_mode = FIELD_GET(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, val);
-	if (!gyro_mode && !accel_mode) {
+	if (gyro_mode == INV_ICM42607_SENSOR_MODE_OFF &&
+	    accel_mode == INV_ICM42607_SENSOR_MODE_OFF) {
 		/* enable accel sensor */
 		conf.mode = INV_ICM42607_SENSOR_MODE_LOW_NOISE;
 		ret = inv_icm42607_set_sensor_conf(st, &conf, IIO_ACCEL);

-- 
2.43.0

