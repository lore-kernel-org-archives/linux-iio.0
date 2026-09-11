Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013044.outbound.protection.outlook.com [52.101.83.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A584A0EF8;
	Fri, 11 Sep 2026 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141913; cv=fail; b=ClSU/rQ4PI9S6cRqmFXCNK3hgc6EBu921gkHUfNBSSqJpbi7LErAitiVH/0hD4BzxXwpY3ysNw+W9pyXswP2YDVpxaSPfeCBt6SVnqd3r6x2WAL59fwXAy2/UfQXW6OCn5UkpvR+4yGkANIy8dMMZp7EDti/9GWc5yvC/rv//Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141913; c=relaxed/simple;
	bh=905Mjme5QbYFQLyhJPrM1mDV6R14R7etHou5FiXrooY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ir2m9TFIQLWg4EYmSy61FwQNL6p32uC0sgsENe7Jl48Z1s9ZJRdWGX0nbCCasGr99p1E23zm1s10EpCak0LyWPHbRuPiB6DNaI8Glw2qUpGe/iVkD3n567nsSIqyPVQobpptK+2fAYDJsM/IzHNiAlNv+nQ45IJp6iO+saBD4+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=fIz0v2px; arc=fail smtp.client-ip=52.101.83.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fIz0v2px"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/36EyMh9BRMJOT/0xE6mk6wAKq8Gz5OOcHfC2GdvbbtZig0TUAo7sh1wzP4P6W2ry1WpQRH4QipTwTUC3Tz16gQkhQzt5WfXIQ+xWs+tRqW7lDunT+KM2xMCmQX0HZ0lLHLnM6IFB9KIt8Z+LtjI0Z3dQ5nY/lOu2TQYlnfECO7Wa9q1EEmICyy+N69WWjb0R31XYbw4lFgUgN44pl0PfbQ7ha0XL3j+/hWObzMojmVuDEvmcyzhv4O2iferHRCIzSpEQXmeyzgW/aKiTojtyBbkdnP7k/yyuHQFoXKizrKP9/UiRK4anjOwNiL3ISjCqI1CBeoL4EB4oTSZI5Gkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fN/vuoGyBl4Zf9471sx1vBiHIUbeclKC0kYzlbY/gk=;
 b=SlI8MLXCOkaBaAcLPuMHsXELkjytr/bc3Iu8sGx4RgXo8WCKJHghl7Zf/3+rezvEboxF/Kg7r9vO8vqHocYVX/rFQLjP2LZObAd7hYTBBcltAV3OXIERh0Yy2ACX5E0MYLcP4CZgbTDEQS2qZY0ue+jjFKAkDdIMGL6xaq+gkFTuQrUK6qKrpVXWWmz4R8azeGu4OaGCoWOTaX60LLRIW4zbrq4tCkoWzGFmuuVVTZi6kD9/RQyoCJHGjJRbJwm/Me88RCy0Dpr/D6XcOS2n6t30puARJSpSL5KiW1dr79BC+dc+4oaG6qnhB5EWOgZ2AgHzlLQkmxjTv3WEwLgY2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fN/vuoGyBl4Zf9471sx1vBiHIUbeclKC0kYzlbY/gk=;
 b=fIz0v2pxBZ3TNYIFiAB/oDITcB1kO4YpBht4fWla0B9OIuv8QfxSGOfbfGPsJSBo5T1jhb4awUjGstb6LG7CqfAUR19mcsnR8Mj8rI6AvFz5TuezcrawfhAAX5m3DXZI4Xi0I6bffJ1iu0Y5ci5AOyIho364Fv8t2sUqflM38OEiZbt+oNgN5irjltki+9atsYdh0UOTAVtDFm7Tb/RdNlXEEEF+W/651mIWgN+pkNLwt5PA2rWs3GNzrK8SSLWJq44gVNrxunX8C6U+MsL5TO7EbYvIut03Qf1164jXMt6fnNaDgjwba+WO9RVell7ikKgaWzvCNsTXkC7bPFz/KQ==
Received: from LO4P265CA0053.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ac::19)
 by AS8PR10MB7304.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:51:47 +0000
Received: from ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
 (2603:10a6:600:2ac:cafe::9b) by LO4P265CA0053.outlook.office365.com
 (2603:10a6:600:2ac::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Fri, 11
 Sep 2026 15:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 ZR1PEPF0000E6AD.mail.protection.outlook.com (10.167.241.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:51:47 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:57:13 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:51:44 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 11 Sep 2026 17:51:26 +0200
Subject: [PATCH 4/8] arm64: dts: st: add vrefint calibration on stm32mp23
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260911-adc-stm32mp25-v1-v1-4-cef26eecdef2@foss.st.com>
References: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
In-Reply-To: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
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
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6AD:EE_|AS8PR10MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: c4cb8ec1-c9f3-403b-7bb6-08df101c9609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|23010399003|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	LkftZ1Ta0sfICC2yszrnskw+QNsXpmYDkEx2IUvGe39ru2Wdz4rNiCr/WaKVBFglb9wfH8L5nPaJR2j6NWvXd1T2USwJ8XmzSOZZDQlv8D8qbJukKQVEverg0UtuGuy8jrLBTitUILEqTCFGTY1x2uJ8QgGM5A9jRHMgH6V0cTjf6JXCLqfob6L28c3sC86hl03/SdZ6yz6uDtrp3YrpL2/21aLqeJe57vMrV1aX/p3XNNDCVp+by15xr3chgRKV29FZM8Ci/Bd+72V6ZMnGKO3hGncgmYIp0NGHzJ78a1tbslsozgwyIn/3qTErdQFtyr+SGF5ph+nvuA3whqVyOITZAjUHuOkQUM5gMuCPxw3smyxT63giakQh/7zCf5kGBYfVUG6Qh46Gkb5oi91livqPiIz1EZWHjTp1mrmJTOUbDtiblsQAapEJ0Qq3hLMpW3Fn38VlK7qxyZFHiUicj7TM5lmQlADte4lY+CZIl+AFmsU50F1z0hoYA57/+3jT7Q8cSXD11sL1LvYbvzTN6On/BeO2mPsIjgrHblWM9nMCo93o6JJJAvrM8HbBYJtsRnEOXvt+GmuqMuyFGm9UatXFATIALaJyw1e+Na/oELR3lbNt0HR0qgjO6uQYHOB5fnlFyFalIr+47VCEgvsMHloz8yWEG2EVbd4rAyLflcC/+xGLt0U8mFDu77+1HgSBYF2oqqyvLKRV33PaDswoew==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	izmxFCYy0FEdDmMLuHLYUJXvzzo6bxNXDlCm1sdzkTsI/Gttko5t+jrIVDoPS119uIWZ2OB/RAo79cgonM1rt0LXBUP9rd1KhuO4xUovhpk2WiFdZXYWiCr+TEyt6KYr731MtLm4BXLxnHlVfnMtuWFdEdaHwTl3oinrf/QRCRhnkOstVSW8BcIp0jYpr05Qhdkf960gbsCQ+H+/QlXTnfWYJCimtNs50+XO37fptLfZ7MiJE8Ps+MtnT+/wPXXewQbAUo485Z9fHT5+qsuu6aaz3Kt1T/pRowPt5XC2CK4Pk3H8AbtQf770IsT40YflxMrRx/9q1NbP9QKyHpRPR4FVrfCow1kVt4bYV0t0osJAtbWSMPTJ2oN47npuDnofj4bMwMEotFvuRARj9CDVx1XkhzNC2LHb/pCIP7kzSrd7Tulw6jmXRys+AJLRgwSI
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:51:47.1543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cb8ec1-c9f3-403b-7bb6-08df101c9609
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7304

From: Patrice Chotard <patrice.chotard@foss.st.com>

Describe vrefint calibration cell to be retrieved by ADCs through bsec,
on STM32MP23.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp231.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp231.dtsi b/arch/arm64/boot/dts/st/stm32mp231.dtsi
index 35e247af957c..959500140d98 100644
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

