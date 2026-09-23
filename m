Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010053.outbound.protection.outlook.com [52.101.84.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7097A55D889;
	Wed, 23 Sep 2026 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177983; cv=fail; b=shfUlGWGzE3KwpeLZaq6MCBdnGn9gKWg4ki+7pKXGUEyO0Qgdz/Zx3CY1L6tM6KqyHFCtW/fTvMtrdj2b+i6wEM48et8OVZmHOiEw77LerC8OMvi1aOIsBGNUHVET/gOwl9KHXrCwFLda9M56n1M3WJD95tgo3dAZ4W5dU/quOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177983; c=relaxed/simple;
	bh=E8vV2wCN9DdHeM0CDJuhZHBt1ceQscoOkbTITYr++6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZUgcDIOUs7RIlpRXMisLOPoz1KM6BOsKtwH+cAHMDtb9JDV0gV25siMV7sxLn1gB55MAZcqa1oBR1uiQH6FHeypMCsllOLmk22xfFxMbhBXAIAZSeCXgKDngZdHM7yTaew2KeNEnyKI7kFW5Peqo4qkPCbH8vuNwA2O0WuyS97Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gG32ZGf4; arc=fail smtp.client-ip=52.101.84.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gG32ZGf4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiTWrMd3/wpX8z28TamPnAkXYkqFf5wutm/LCud4cKvw49awIp7VCvfkt495y7OU/kIaHCd+J/+mll8oABdBLjH2KY6hepLrV8fR59eUqFK1ywBguiZtKH3eN4nzGGeSxmwAyeHDgPLIY9VJiYunFsKr8mGdDX4jDbAFn/3mdPqLe1JCCEp6Ws+17P3lPdp8mpAVKl877B5/Zf+AdwPoTVpY760kHZ1Ivo5B6UnLiq7PMOvKmXMHVPK9KtsAgo9L75XgAUcTj7ElTrMyv5MPBKNyI5DJcjBhLB/hJARNJNtyv65girCt70vf0vYw1mtqdZZmbNM90whfZ8CnNGaf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkjkwOkeHSZfXOGPL92V8g1PGNM8S2IzaMhySLNkPI0=;
 b=GZwux6Rjp4xeO+l1jfldYL47FaaCfRXlwUSIkoGsdpi8aJOieUrFcibzmFALKX9dxN/ejRSejbOUw4PfE/krK4IsVY/I40gEmZe7cC5WS9HGf6QT+9aUtjlTIcTxAwnE4vm8c9DAViHi556poVEO7FeUeTToQCK69snB3jlCgUuSxVjKXWPJJGlpPU05iIZ6CyqGmcaHbNwVcGdFJO5EVsALC9omfa5TefWTYrwZSoSeYK2Mfv++5//JQIFadAe01V3LIaBZ/ZiDeXF1ay7uBdWeO3DJsdcBuqp3O/0sJAmqc6J2X/YlqLoomaCR4/NG8qL2gu6aY0zd8HG05pmCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkjkwOkeHSZfXOGPL92V8g1PGNM8S2IzaMhySLNkPI0=;
 b=gG32ZGf4RaVT6l4yks0NFNAwS3ul6RKu/fdk66ebSW7jvyKy2RcvshfDOSBotXnj0Gd6+RaYagssUN3xtg6YvOtWOpDTCNQ5MCqS2a9pNP2mLFgGsNVpUej45rYBX36fqzrHqoZmjlxK+mfCwPJeMNDxqfSXM5Wk1lqtJKtW5iF+QOWplrnwxgyPFB+NjSQwfYd7rDPWjIp/Z7g3jhqml2O+KPJugEHZXR8SIhe0EFcYaAWWRcPEf8GnYeD+ZL5yL0XkvU5HS/OvDs3PFjJagZM4QC1mUuH3aaeBqHi45zSglqMaUYP25IFXCVuV6gOfssNXLqFbr16Bc73N0wTSsw==
Received: from DU2P250CA0023.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::28)
 by BESPR10MB9247.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:39:36 +0000
Received: from MAD0EPF000008B4.eurprd04.prod.outlook.com
 (2603:10a6:10:231:cafe::5d) by DU2P250CA0023.outlook.office365.com
 (2603:10a6:10:231::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 15:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008B4.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:39:35 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:46:03 +0200
Received: from localhost (10.252.7.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:39:34 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 23 Sep 2026 17:39:13 +0200
Subject: [PATCH v2 10/14] arm64: dts: st: add vrefint calibration on
 stm32mp23
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260923-adc-stm32mp25-v1-v2-10-46bc019537c6@foss.st.com>
References: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
In-Reply-To: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Marek Vasut <marex@nabladev.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Patrice Chotard
	<patrice.chotard@foss.st.com>, Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B4:EE_|BESPR10MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 52af73c2-a1fa-41bc-6ae6-08df1988ded4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yC7WsNOSYDxt1aGc9hRCwnSIJ7wO3VRSAbsvkfeZAgQZ1djgy6JE5IrdM6YWd1skOMP5reLsqztsyd6GPbwTjgUkdcnTc/2Ol8HggIuCPRNLN9QqqUuR46g9DxSF5mFi3eMqZO6QwEPZ821ZPadu9KZREF7yJU1GklGobgIcuLhRCM9RZURy23XNY4NvfSy8Wm1BQLFPdI0NPYpIC7aBSFZTCKDDLh2hQuW2n3De4mVFzr3L7BbS2hW9o6looX17rCPVRH3y2g8ci46mnV2x0/I8hhqxjY5C2ZWrZ0yaDpgad8V4j0DDbCszYmuR0kIjS70fiSzrpnZrZdNY2esLncEpJgrukXjwHTTJ/z9ULHe0I/LZp0pKVFXWo4krPOpTCYGOyzK4DPYuaRQ6L1U2Vme68hM3B9Zg3ofBAYpPs389nH7piTCe6y1KpRB0Fi29BjK0ZcNCy22CepMydbh92DWYtT+o9RRx5qIRiS4DdkS6IfFWwBeFP2Jy2sC1L1yPvMGnlnBBPfwvY9MizwIB4mnTOFj9CbRyVCeTm74hR5cJo0pluSMB1Y/GcKczM0akfCGKeTbIIx09KJVeYDzLF8n666jMKiT1AwJpoYF9JENQevgOJAh65TAEQCiaTwe5QDhaut/GZTVVMJEn46+JmCgyO9un5Ox/AwTHh9tq7g1omSMP8/V+2/l+xVnXNmH9p0UBYNJqnn6rDQxYhrM9DQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+TTfAyGmuxPZOOomO3BefDCb8nfBVbIkuXUNbFztFbqPM43nArayxCMbpsQKr7O/LyCQL4I3dM9LL2HeImDn7o+gi13RdNul8Lc0dIbOumJ57EI6TfxndgH8GLYYRQ+zw702t4ANxXe6jD4r5FW8642IIIy7F/DqGD3hHOEZFHJHxF5EgyWVcwPV81ZLAKreDRFhHvrgbCW+0ci3NBzkMXxBTcy0BEuRiyaSjuZzyC/Jujg0mGfnNKiCqGyJPZXTCYispSZpFvnZ97ZBkq/9hQ0JIek236qKQqE4j7f5EVeMPBCSAZpXzaUmWJ2QIpdxZvx0/LMHejFJ1A4GeE4FOzPRMFIb2S0wK2GmuWjOE0cXK2yt1NwezTyTL6gcRaIG7f7KQNN0rnISY7U4f64JEV8m/RmCBAr+C/Sn3PxT8DT/5TBlgM3RzH+InT7ITax9
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:39:35.3370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52af73c2-a1fa-41bc-6ae6-08df1988ded4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B4.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB9247

From: Patrice Chotard <patrice.chotard@foss.st.com>

Describe vrefint calibration cell to be retrieved by ADCs through bsec,
on STM32MP23.

Co-developed-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp231.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp231.dtsi b/arch/arm64/boot/dts/st/stm32mp231.dtsi
index 9e1d240888ff..938d6f0098ac 100644
--- a/arch/arm64/boot/dts/st/stm32mp231.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp231.dtsi
@@ -790,6 +790,10 @@ part-number-otp@24 {
 				reg = <0x24 0x4>;
 			};
 
+			vrefint: vrefin-cal@1b8 {
+				reg = <0x1b8 0x2>;
+			};
+
 			package-otp@1e8 {
 				reg = <0x1e8 0x1>;
 				bits = <0 3>;

-- 
2.43.0

