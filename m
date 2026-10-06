Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013010.outbound.protection.outlook.com [52.101.83.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA03C4542;
	Tue,  6 Oct 2026 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273511; cv=fail; b=kFiQGUnnhwibHAZnZct5hWUQGHsYqbHh2IKPZHNF7Bo+epRX5qW4d4i+VCQvsLWTZ/w2uPYLnBH+AV/NfiQ2hCCMts8BD2NxqnWlXmI3S8r6y/jMp2kHoygy2H6eUjmioUEaYxvxIkDuZI1b83Ed6OhyJXakN6dchVCfWnz8ZWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273511; c=relaxed/simple;
	bh=E8vV2wCN9DdHeM0CDJuhZHBt1ceQscoOkbTITYr++6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IZFVtG74av5ItYD73RjtZvCk/yWCTnazhPts/ToYyET2lQeJJ37EKBNHxL3ySK8yXoGOC89dlDHreC0vRImryxHMXFGbK8AiKUieAxycRBpHhH+HR/Y+UlGCQxEJm9ZaMEHgJ4UDL01wt3mTMxGOoqfvraEpQ+Aw7VPQUC+Wi3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=fu6GwArx; arc=fail smtp.client-ip=52.101.83.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fu6GwArx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnkC0qjFTar3Yq3xMNni6l15gtJamH4ybngo1yzwFOCUb7UmY36ch+CukRRu+sqmnJ7r3Q83M6m4m4EjNEgYfwaU80RLUFQc3ESkgB2QoZ7jwRzd6J4AC9vbXlf5dqvU1qwc8RBSbMFrpf/pXcCf1glkaeRjcOnmQs8d8rJY3onM/CmmwtXShvjMg0HqHsB2o/kKX7Wikw5rHsDT9lg8gsLGKuRxSOQdRWqDG1tWiSWsPaEVDx42vh0ecSBSZWOhNwRV3DGgsPCYtkSqFwlyLs7k1bod8nOMxC5k5yrXBCUpcvbTEdq0AWT3A7SiqwZRT8d4CovuNxlMJR+xmUBGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkjkwOkeHSZfXOGPL92V8g1PGNM8S2IzaMhySLNkPI0=;
 b=KA1YHC6ECfPyNvObA9xEJsjfPC+j397rSlX9wO/u1fJahSOU3GKmIYp+5z5d5HH2xLRl9jXGQv73JCE45faP1yCXwFXT4K0QOCU8qpUr9D/x/Pzxeq/Qiet8g5dKBhyZxNxBsiG66dFEI6a0pobT1LaYYxYY7jdCm/1ZNHobdPJjfPmZ1Xas4Xig0ejISJK0GiQutBqRn90k9V+14vvYucD/xaZXclTQwiLOOSKDUWTgNjAIw5y6uExDFZKTVLxoUxDJPB1loULMvvHHNnBnMzjqyLGyz8L6lJUjOe+45rbHCxT1HmTwlTPSx/FeLQiQgLIt5dZPNY86ASU7L9ul+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkjkwOkeHSZfXOGPL92V8g1PGNM8S2IzaMhySLNkPI0=;
 b=fu6GwArx06txQQow0eKgpzJJc9hFPqOlSNzV3OhvFCQVsuCwUG/SECyh1Svh8vxjsfp909pWqY/lwYrnICsk2JsvQKAw6CEOUW1aBBR/Onv67CyKHeGtOVeIRxD7b1h2hfRxAnsjJcsgLJGYkvFuAQ+c6osbg4TNHkHgkXT2DjXmK1TLO9NXopBg1IjLfU4Wup8p2oh9rAauF2SXPlEKhat3MP6dD2bwGX5+/IiXi01HydUFx2wBJdqIHoIWRFdKPp4n34a6lYXwNW8gcS1djOC0cwSbAH/n5CCXM0WC9U6X1cPs53FHvkOKmeZGdxmKhldBe8foQyZAT3wR2TVT9A==
Received: from BE1P281CA0455.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:7f::27)
 by PA2PR10MB8337.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 07:58:18 +0000
Received: from WA1PEPF000099CE.eurprd04.prod.outlook.com
 (2603:10a6:b10:7f:cafe::54) by BE1P281CA0455.outlook.office365.com
 (2603:10a6:b10:7f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 6
 Oct 2026 07:58:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF000099CE.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 07:58:18 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 10:05:01 +0200
Received: from localhost (10.252.27.219) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 09:58:15 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 6 Oct 2026 09:57:42 +0200
Subject: [PATCH v4 11/15] arm64: dts: st: add vrefint calibration on
 stm32mp23
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-adc-stm32mp25-v1-v4-11-d31ec75aecf3@foss.st.com>
References: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
In-Reply-To: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Joshua Crofts <joshua.crofts1@gmail.com>, Marek Vasut
	<marex@nabladev.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Patrice Chotard
	<patrice.chotard@foss.st.com>, Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CE:EE_|PA2PR10MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 80947fff-26ae-4366-9eae-08df237f9598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2b8CrqDcwym0WoBx+66E7EkAQLDTRtaNH+/oKz9jicdutEnzkXmLWgTI5SQueoUq4pr0P5uVw249kow41so2JQ8/FYljuKGRVpRIWzHUAH9n9CTDIH4LmgB1D7w/cjVon7p22jiVHeX6zGZj2+bVUn+/VqUo1vNfOp7Jjar2d7XA/mBPssZIiA5yuObIxXEVsbJIhH2O+hmeAOAqDoYzhL/+nVyeiVYHvXpNBXEjMRjzHgc6y09NHUaabJGhp0JuXTjZ78Gxk+QKZS+GpGoq1NXpfm+bwK24WDLmrK9WNMRwGQ5Bg7B+e+muDH4kHlKN+FfoXVqRLt4qVOAxCzYTDe5+5J9BIN5GJOOIyJCfn2+U9hbVA10eA8Wq2E27dwZT2htqZZdtcY7I5mmcknvLmt38/OUs7vZuCa8c9dAsdZfiBb4suT159iF4kb3ND4k0SpRMfs/5B6sFTcrx5B6Fs4PAqPHEgXwWwt9QAu54GwihNoK92dBEnOZsMH8tM60n3jrK4GR9bhe3jR6zl1Zv+KoqxWRT0+mIgdoig12Uo2hdywR/ueQX4v9e1UgZbJN+3fAGxt3Lz60OS4j76UZp/ERI1sUMin4MkcLbWFpEHwMK4Uw1ewXx/WFxubCHDSTl6FPAL2y9U6cvLDroWxdHwavi/cjZtv4n3gBoiJ4tCRJJ8ZM9QIoqAmrsjYNF3UUXiEkZVoS0PsF4dosgc7jBsA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r4KDgylfmvOS54/zA3hS6WX5pp/uuu0HqLkcZ9eqI1htty94VvMSoOei5SkUL/1lW1z//IYy/Ykl015hum4I1WqO00RgLbuH+tr+vcQYwuCqrupruUTqMpjE9BsWRrD1aOStzDHM9yKy8mNKiGznMvGNhVdmeeYZSkmr54RJJ5t37MjtqNdjmdCBJJHqzf1ojXS1jya69DfSAMu8KvEXN+DAu36sMq8gxaK1D2SL6i8FlTAudEWgWSGQaVCmraVdAsnessvoTK3jnzY1ZaLR/qfv7KYqStcqInjcZBpba1EGUmb+TReDw7PLkwNwxxrBBBKkWjuppu6aZRYZTmaW5hQs3aME81GMRJ8QPrgPswwPrI52alIzW5ChC1nmBNL/2lpKZqW5mNNVfgL9bLJFBDDh+d6i77ZMoxDMWGtjLoC4Mp9VEt95PIOjOtNi69kp
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:58:18.6371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80947fff-26ae-4366-9eae-08df237f9598
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF000099CE.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8337

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

