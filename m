Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793893752;
	b=CfDjPzxN5u/uGZLGJGNMjQqEm9Q+7U+lXR9xmcrlk8IPYsMigo/mN2yBAgEVA/clojKe
	 e+beVq8QsfagOhGs1262Apnpf8hwRFN4BY1GM45fVcKs6OA41fh2kHPxx3vA6lFCTqL/l
	 nMHueUJPGb+dDW+diEjKKgMByA0+R3aE949mh0Y0oSJWc39PbFBvXms53eVL79tbEgWUY
	 pLnjYrM+/H54dimPnONC6PaDozGlyGq8NrVqPpQWDYwH7rG/ho8GKhRc0mDnywsaQ9nJa
	 ool9kqX+TA53VKpKe0haE9QSYltB2e10xX27klc3MKuY5HzULzoyke6ZqdrDX8fiFVg==
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
	bh=kqoIxsWP4l8pxbinmfx4iASacEe6edQHztB1ft9XEJM=;
	b=bZVlAlc+f9t9gCCvboCr7/9dKI0vVBcxsNW8EuKmS1zlhbQc8WLUFyjWbnfRTj0P2X78
	 mur4UmYV5eKfZLXqaZw5sXOfM3gDD5QJUZ/qmbQQS46wLZ3tDFnTaSwxlwVhM1IdZsUBx
	 82MlJJWpPXTn59fIZc1rGplhlbZE6H6uPNapFNY4ClfIwuXfWLyniDR/oVrwqPu40UA7E
	 5KpvOEszCwB8z0K8iLAlxUbhJR7A/i9urQig0EI31Ppt9p2EptjGfP2uaZmfo1zty40QN
	 eGfzTlz0SZQnwC0xeAUaO7YnT1nwp9dnZDOQo4jmIWCzlMh0TDbqx+7dn6kW7UTUEAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b="iCG1/ztt";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.43
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013043.outbound.protection.outlook.com [52.101.83.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF824606A32F;
	Thu,  5 Nov 2026 15:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF824606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=iCG1/ztt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ifnt1bbvcgtHlvAaRmw077D/OYVqt+tM+50/wowOOpAtOP4IBrjUKR1mwGZKnO8VdV7v9Aqn8sMFbseV8qooP1R69Iqq9AmT/kX6hjNR37p/Ph7dHygXJo1wTX2zrvMifOT6bKAm4Cjs4PYgAXkeljax/IGyTgocMoU7QKX52eWHHDoPGnZcK3ZD3FGVTOiWgmdiOYEDvFv6NeefiqS5KE5LpK/oscl9YfZnd8qbVhnFjXEXjJDyxQCvCPGXbjYeQ0XZcnRPB46H6PXU/a8HvS98grtjm4QDQWkG5wb0HHGOyvp1F/T5n0icjeD6SGWof32oxRjDWbRqQ6blEwdVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqoIxsWP4l8pxbinmfx4iASacEe6edQHztB1ft9XEJM=;
 b=L+luYtDH/cdLmuHNDHXxS0TUtW5/TO+jToy6Yb4+2b50mrrvpu4LlOHTkrZaw2tycuQFTRlatWBIce/F00mLM+GoeT7NIyxkSHwHsZBV0bUEfXJufiZTundRredMU5GnLLvgySQt5u2K2wkDzUrX1TA/ivicyuemx4HY3wlXNfSXWUhnpjZRFhWTuEXQP/TVLfNechIum+gTxr+h/GFjLfA3oXB/i6N1wYWAtIlpRi8jTbrR1o/6zq4cqUOYw7YGj6Axv1KGbiIz2F3kui3BNyJMRvystREdG+nXgXKd4rHu2lqSR5n6TvjOMSDoUtcfH1NBdfKFgBwFRpscUm1fGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqoIxsWP4l8pxbinmfx4iASacEe6edQHztB1ft9XEJM=;
 b=iCG1/zttOuI/roa+3mBSQ5+QdmFDKtmnCLB27kYtHxULhsmhmUonKWLvm0hGuwmwWt7P5bpq92oTYMrmZYDNNWFiGrdKtusCr3GwFaNBMguBmbCyHvBg+NJVKX95ZsM5PyX/Tnw6l0CuppoMUZZA6RFKOHSXbskPiYzp+wzqEBM=
Received: from VI1PR04CA0101.eurprd04.prod.outlook.com (2603:10a6:803:64::36)
 by VI6PPF7108BCD20.eurprd02.prod.outlook.com (2603:10a6:808:1::30e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 15:49:05 +0000
Received: from MI3PEPF00008496.eurprd03.prod.outlook.com
 (2603:10a6:803:64:cafe::c) by VI1PR04CA0101.outlook.office365.com
 (2603:10a6:803:64::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 15:49:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MI3PEPF00008496.mail.protection.outlook.com (10.167.240.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 15:49:04 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 5 Nov
 2026 16:49:03 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 5 Nov 2026 16:49:03 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 84F891A2F;
	Thu,  5 Nov 2026 16:49:03 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 782D0305D284; Thu,  5 Nov 2026 16:49:03 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 5 Nov 2026 16:48:52 +0100
Subject: [PATCH v8 4/7] iio: imu: inv_icm42607: Initialize gyro based on
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
Message-ID: <20261105-b4-inv_icm42370p-v8-4-b44eb96020b6@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7686;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=z9313548Zaj4TXhRJjUJAiYWjHqjzcNSrBZeC4Clwno=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsh6szTPdNoyWelHf5bn/Vz/x162WDbjvWmd/59tMXWfJ
 j/pick911HKwiDGxSArpshyzmh79P7kf7pzpJ0uwcxhZQIZwsDFKQAT6VFiZFjOcd/79NRbK/5e
 6n769+qcDou7rgo3rp74JHnzUODcZR5LGP7n/H/P6jxn66Z8NfkFlTPm8O3nf9p/SNkrhOWLDL9
 O0hVeAA==
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008496:EE_|VI6PPF7108BCD20:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da55adb-9096-4243-dd08-08df3b545211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|32650700020|82310400026|7416014|36860700016|56012099006|3613699012|11063799006|260925021911599003|261021123027099003|260925021311599003|260925022911599003|921020|261021121427099003|261022075727099003|261028144727099003|261009223027099003|261022105027099003|261026140227099003|261026121527099003|10067099003|261102123227099003|18002099003|22082099003|261102130727099003;
X-Microsoft-Antispam-Message-Info:
	QQyygZB88/NlKoC8tlwmEvV6ZjkUP8oZ4dqMMm9a88duvikQSKRYSrIRF4fJ/vIdZtEmbjt48VYQPik16DAuqxH05j+c7vpLZdxIkTAxaWwOMCfyg9FsYp+vxzpdRpy0HA6KbB7F6bi1CtbBVQ2Q3eboJpqPbi5g6C7oHCa4EEEbaWGhA5PQh5oJxdneDphifSJpd2iuKpYMz/gexGJ5ZL+pPx0czlBkYF2GjI01LM0ktfBd55AAR0FWKTwDSLiq+cH5Ht6IipFTpXGy2DxiMjZzDK2dR/e5b1shzTSb1y3wyXPHRzwnZSjPT6xRovKllDp6R1SK6biEDs5PWrcLvUVbhWG36byxSWY7YArdVjWifVYV8wKucSI8L64cel2RK/yuV1U+XmNBbWGkeMCdkfWUlMouqXBNRhWxG5q3/ba/z0ueDBmprkTXT2+HH7sHI9Rna08db33QpnEoYfZOp+TNLGH9931M4DCkrOxb18sDjA7RFlM5mDLcRNE/4jVRdvdfCGMXAZO72btdv5St1I2b5b2QWysoDUTPXeXwFlkPLafW3I5ZyZsjFtuH15lMFEtHqfaaUs0QePWELU0GR3fAp4Q+nkVig3gzzZlGcVogUiE4ayeWadlE2kHOm1YqUP1icRl2MFW4Tz4rsaBvjl4On44kODFG305Orrj9Tb1wDG4qqI3YABeCzD6eA1WchYzAlOnOLSFNdol9siuLX+kW4/z+/Og4rrrOHagL+gWisb4AvEubKjPLHucPIrJD+MdKehHDEwXN6vP/MRD1yw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(32650700020)(82310400026)(7416014)(36860700016)(56012099006)(3613699012)(11063799006)(260925021911599003)(261021123027099003)(260925021311599003)(260925022911599003)(921020)(261021121427099003)(261022075727099003)(261028144727099003)(261009223027099003)(261022105027099003)(261026140227099003)(261026121527099003)(10067099003)(261102123227099003)(18002099003)(22082099003)(261102130727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	74KXrU+TougcU/vXI2flTz0qVBpNKSjoeV1B2A5c0z2P6hIn6cVuBSUzxsl1yPOUqFLr0G0grFpD0wMKGa+lHen4X7w+MSN3/esxU8eKjk4RL5XdmRoZ1Gnp5wW4WCAHDCEzYvxKG+8X63mryDW/inWQ60Vjw6K+JzuXfqdHxJvw3QsYOpcsK4U4BaLSg5fZSdegsc3DphbeAHYFCpfpmj3DbYsnrPCxx/iWRDzJPA1HzpZfSk669z8KoghjZhQip+OUZgucz31574eyA92MVenGsUCu/+AUVdzeOeKOacghNzkaISVsNlARo67xbIYhrnAV1/1cn66ahUEFDNjeZ3jjAn813XREKsRs8QEpEr5IfdH7H5ojQabc7nV0KVBrwfo4TrB51bMahoW0YioI05V9l2WZ36b0//4E2rRfsoLUdstQk3HwLsBKAC4tg0Mq
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:49:04.9457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da55adb-9096-4243-dd08-08df3b545211
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008496.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPF7108BCD20

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
 2 files changed, 54 insertions(+), 26 deletions(-)

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

-- 
2.43.0

