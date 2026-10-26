Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793012608;
	b=PAhRF1DvuXP7zcSOiAwA3j0lUV90kGshLBde25K1rRRQUc1KKzDsL6VWnYEa2xpdJntc
	 b0ODWIsXXksrzTH3BDbWL/fItmTDFaZCP624pdtKocmAt3YhcYlqNsNbPScwKs51aRjED
	 AAzUte7NjOoebJJbU0M53ukPcRgq8f6/ODuyta2VYSZZ6fRHtBslmI626NMm79vuere0m
	 OveD0t16B+niIotwsP8j9lx2gvhRveLbX5iB1reWRM3xhGoZEra9FPdCR9FJouX68/0oM
	 QwiVhSso7ZgfvJ2p3Q2S9ScY8jkob3jnFdb7VlrCfPSWqrIb+FfC1EwG4frVgC9X0AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012608;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
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
	bh=Hf7BBEbMPumiSpXSeqNG1OA4zsNgj7fNXg1s1ZGDMao=;
	b=NGHRuJ70bR+CuNiNrmWhuM2MPqhwxuYdmrQtnzrRePV+AifRHoOMxTSupu+fLvTQ+fW0
	 ke3mzdByq4G7jfXjiHvLwhOaKaU7yyO58N7zOSwBxn0079Ti0hb652kdwvFP/xRAjoezE
	 8C0SGgdVgmW/O7eKhPkFCGt0oMG9Fxvo+z+V/86dwCDoPdq4uRBXgWlQ86cxDf4/nUSZB
	 cVnFrWxSn5gO1KbmrYHath6vLIj/dSwJVWPHjDmLNGasE5hunbJuE5L6Hxu4PSGaMZb3R
	 wHZwdr6DTHb441zeB87eobqOkYl9rB79Ldt3sj6T43cxAjZj1bSbtljJ9jdq8XJ5iZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=C7GDp5oC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.31
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514FD606A329;
	Mon, 26 Oct 2026 11:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 514FD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=C7GDp5oC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKRxGDw5NuVl+5EyK4v7qHa+WVvP6K/GbnkJAKrrb+MqarQs5mBmEr/OuKlJpn8PKjbUWkZXz9mNCR7vlYeDKQXH+mMwtu8npfMPFtNSL+BxMSAbWkrPT0KTcLXVG7pA6fNyqy+HUhtPyufdXOOrB3NxX40o2bivHeEu2YIYPxkp/wGNYLLeGwimoWgeHl3A3ufg82YgABU4B9cYnzmxYgB4YIo1sxeCWE1zOynWpb/uE6n6tGJeKTjU39cuKz6rR8KGljgDu9vva+7LwMmgh0Y7dCZWkwDITXeigHCnKKf5Iij7suPZPOYjyZe8yQijwfbpT143xQxl3paG7hErHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hf7BBEbMPumiSpXSeqNG1OA4zsNgj7fNXg1s1ZGDMao=;
 b=Dh92gsqLpA8wRWNbrbjV6MWvJtbdHsMUlnSsEaSMQKrlXa5sLAIhH0+ldSST7RgqkL+Z5oE8W8B9Ki+UpoNThW5GXkoE93EQr4E6RxosjYZ60tmwFw0+v0brCNeFYgvqA0foazLp/GHLYOIhwCey0R2M49nKta/Vw6LJPqsNcbSc1dn0ClpNyj2AcTx+iYVbfmWpUKBqh/DIfBBDb+Ggz6PAN+auCh0RJ5+XT5NCHWQSrp7fGxxX5uc6JR5owqrHbRgmvmBB01UPv1/uWWKrZuhQ8zT9qRwW0Gh6Ag/UFf5CuPolUoFS0cPCwtxTYjgiBCRTIXb9XxWkmrHUCIjnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf7BBEbMPumiSpXSeqNG1OA4zsNgj7fNXg1s1ZGDMao=;
 b=C7GDp5oCVu9AfMRYKlLGqHRBPz0dIAkWleod0XKmAnXZcmoQluG1VbihObZRExXt1xbobAzd5zQC2eNzpb9WymZD8dj6aYPUDLMewZnaNXhswXINqR0O0XNJqvrwA+MXfauxeMzdGqkBgYbeTvlJqjZWsCfAG9B48q6ePxDGbKI=
Received: from GV3PEPF0001DDA1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6c8) by DBAPR02MB6469.eurprd02.prod.outlook.com
 (2603:10a6:10:19b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:03:20 +0000
Received: from CPH1EPF00000524.eurprd05.prod.outlook.com (2603:10a6:388::1e7)
 by GV3PEPF0001DDA1.outlook.office365.com (2603:10a6:158:401::6c8) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.546.22 via Frontend Transport; Mon, 26 Oct 2026 11:03:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 CPH1EPF00000524.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 11:03:19 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Mon, 26 Oct
 2026 12:03:17 +0100
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Mon, 26 Oct
 2026 12:03:17 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 26 Oct 2026 12:03:17 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 534E52E69;
	Mon, 26 Oct 2026 12:03:17 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 42B9B30182CD; Mon, 26 Oct 2026 12:03:17 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Mon, 26 Oct 2026 12:02:52 +0100
Subject: [PATCH v7 4/7] iio: imu: inv_icm42607: Initialize gyro based on
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
Message-ID: <20261026-b4-inv_icm42370p-v7-4-222e296ac1e0@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7643;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=iCmXxuB6RLENRUCYjkvfb6RnnkuY8YOXlSrEURX+uck=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsi6b1xSGh3z6lBaouvZdplS4WOdijNdQv9vLVx4wbf7g
 rpC19kzHaUsDGJcDLJiiiznjLZH70/+pztH2ukSzBxWJpAhDFycAjCR8ExGhtXsz+p3tCcsCHh0
 dbrV1mnLTrK0LTz+NuuiwqIG0RXPtM4w/E8Q/3+X2bvIpsPz6ym7nFUbN8yWFA047pPco8XoMFN
 0Ng8A
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000524:EE_|DBAPR02MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc5bcfd-d62c-4676-ed5c-08df3350be89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|32650700020|23010399003|376014|7416014|1800799024|18002099003|22082099003|921020|3613699012|56012099006|11063799006|261021121427099003|10067099003|261009223027099003|261022075727099003|261022105027099003|261021123027099003|260925021911599003|260925021311599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	TCyKnhaUwuHx4p6qmEHJ4iwtpxeciVE98SkQ/QWX/h+wT5bkvshr7dOgjnb7/IFiFnsPAkWt7J8tLHzRaA+vOxF4atOzcRv291ylNqm37Lpmmz20yEZo5ndnPtpQvFBhHPuOm4ivJwQvKC5vOqc3AwM55JIbnvEJ1va2yrw3F7NXpf+58jqvrMMUmZdknQaJGrfCXzUUtmP+c4b9hk1EacKA2H/uPWw7/9KnAuV1GEInE4uNj/TLlabgLcCpV1VOjAzZPdwXDKub0y9GB5bhA75f81abXCIjpQ68EXtwFGU/SAPHtGrMDnSrIdFwjZN92xHIktmn167o9Q6xmVl52U0iKzhjX6wcSoUx37TdvNs/SOYxupSD9f+Tif9BlUVjTaVbY8LqwFr50n4+U5t1f3fUIZHX8tI9rstk+lStdRMTRi1GvZk2Uw12YMoXu3INeAbDAiI+61dwWXQw43lSplNojYlZM2Ic9TJfkhFCR8hlhw+AZruE/0YZHjalV9thoUPhoTxhghQ39DGI8ppfPzgzis6aN7DHUDX5YxxrvYAQsWI1oTb/rXL8nibYQYln3PZgbBlO18Ub+M8WQWMMIGfGa1ofhRVlGErYYv+8Z8cxDduzr/9ebp++XssIPAJW6HOVz4tqx5cB25r8aZht283f+6UFpCzsqkB/KqjSS7/AzdG1Snrdc12AByPFNm4+51+i0MUn2VNDlU+7OYlkihloVyzQZQNHQDGzhi3hOZ/byIPjqkHnd8+sYdK4apxyXx4/+hoi8oVEBv7mUiUZEg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(32650700020)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(921020)(3613699012)(56012099006)(11063799006)(261021121427099003)(10067099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021123027099003)(260925021911599003)(260925021311599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Nn0cvYPLLPeorVzcSLklgDAmzO7m2X8djnngDitYAQz6ePzfcU80kEvydk01KsplFc0Y0n1tQYjjIcQJBUGZdeA3OMuap/Scs2V3FsZO4W4/uy67HTmHpbzbNAgQmc7zOxePHgRF0+8in5RssZ8q03RmyNqG6XytPdXo5UNWjSLw8EndoktxPapsM704bbrt3tua9pporTlVbPOyICz2NmySqUUZ45XdQ1U84K7m4YuKINwWduQk78EFlnY1majvdcpmzA0ctoWr6lX8gCExHUdU3xrbyd/91D09xPAEofzb0feyUfT/MbyWWVyiJ3fI/qOE2SDwY/vd6duKVTOWJxc+6+xiZoeT4v8I/nORaVXPkY/tQURHLciOz+O6hMD+PBnIqgWyHsiwVnnUkpSyiGsVsmCfyc1Zfk7JAV/fotUTC5fo1iolX4yNZZdDyunH
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:03:19.6819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc5bcfd-d62c-4676-ed5c-08df3350be89
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000524.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6469

Update the chip_info struct with a new `has_gyro` property to support,
devices which do not have gyro functionality. This is a precursor for
adding support for the Invensense, ICM-42370-P. It is similar to the
existing device except it only has accelerometer. Check all operations
related to gyro with the boolean. Replace all the implicit comparision
checks with explicit to make it easier to follow the code flow.

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h      |  1 +
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 77 ++++++++++++++++--------
 2 files changed, 53 insertions(+), 25 deletions(-)

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
index f4ef75da22c76..8acf745b1451e 100644
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
+		oldaccel == INV_ICM42607_SENSOR_MODE_OFF) {
 		sleepval_us = max(sleepval_us, INV_ICM42607_ACCEL_STARTUP_TIME_US);
 		odr_us = max(odr_us, inv_icm42607_odr_to_period_us(st->conf.accel.odr));
 	}
 
-	if (gyro && !oldgyro) {
+	if (gyro != INV_ICM42607_SENSOR_MODE_OFF &&
+		oldgyro == INV_ICM42607_SENSOR_MODE_OFF) {
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
+		val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode) |
+		      FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode);
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
+		val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK, conf->gyro.fs) |
+		      FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK, conf->gyro.odr);
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
+					INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, val);
+		if (ret)
+			return ret;
+	}
 
 	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK, conf->accel.filter);
 	ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
@@ -547,7 +573,7 @@ static int inv_icm42607_sensors_off(struct inv_icm42607_state *st)
 	st->conf.gyro.mode = INV_ICM42607_SENSOR_MODE_OFF;
 	st->conf.accel.mode = INV_ICM42607_SENSOR_MODE_OFF;
 
-	ret = inv_icm42607_set_pwr_mgmt0(st, st->conf.gyro.mode,
+	ret = inv_icm42607_set_sensor_modes(st, st->conf.gyro.mode,
 					 st->conf.accel.mode);
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

