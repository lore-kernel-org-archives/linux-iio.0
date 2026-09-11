Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013048.outbound.protection.outlook.com [52.101.72.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6434A206A;
	Fri, 11 Sep 2026 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141916; cv=fail; b=IvAPeSmFdoCJBWaoTTshpKEzrJ08Z94GJGPV2c4unCACusi7mzD5PmO+5GL3zOQMK/HpQOWjF5uKi3565nL3uEqcxkXFY45korqlyVwlUNLc7eF4kbrhT6+5ekC21IzcXBDdL9whtf3msxV3yVQIhZcTeEafttZS9awa4KsKyzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141916; c=relaxed/simple;
	bh=69/v6AGGM+R0frtOx6cIBEdSlt58crvJIl5p+BOZYRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tCP6Zix3ZyeHSU8kYkLPOmEYQL2F09WRfzurmjdzsqObWYUzKgDhecwuLx64nHcoZV1kKvW1+zESg1gvbkHm6EnM9C1Zqh/t9XdG/TK51N17Enn/oWtKDhBq7VmnPk2rqGtQefOUgwuIMZ1/TK/E1dWXiTFJk2wkeuHIoGN3x/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ZyRmEDKN; arc=fail smtp.client-ip=52.101.72.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ZyRmEDKN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0jGfNVrfCCHsbyH2DJ8qIDvzuBHtyWUiJexNd/mICfjkD9HPVKOoNgfzu60/5RTaVgNIb0qzp1aPLxepBN1vJeD+Oixit6kWcEXGp7bpAQWiuMwxfLV5sGQI/o1rZrmvUZ2RsH+1KAT1etedcEw9iv4KE/dOVrkgmMgzrLMO2hrKBGa3B9iky4AfvwTfkMvorzynRiYLgrCGYOpvphA3Z/1cI9b0DC6vaY3h/mONc9qNWquxdMYiwr4ZOhLKeZN/EPV7BXr4chfQwNVAPv+OgK/BYELz5g2DBEHQ6CE7/6zoGU/luGMkgsTwCpxeaqIqFmSTkpSmHouRHPtXY5x7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufPnALZ6g/ffAF6gkJZ6oaBlqKqWpUNKgpQSYmkm+P0=;
 b=F89Z1dI+qsfvDqNZMbWfK6VQmJ0biHqkS2WJY/4aPfXNUcqHBexZ7wEv/NqzBkOyPEa105u2z5CjkT5YMHvqXhwXkjnFWqKtaZHR4cDLH5RKXb9zy2cl1DqVqnQSSS5t92ldHN8nrwZAm821/kpcZdP5VjUWD4097iXj/FflJK5PXjQ+jNTvSzQ5ZzlbsmvhHH0m5fTY99NhO1UJmDdYmpAVr08nnyRK/L/RhqWreQdgy1JnZXfh8fLkLDoE+ufaMA7X/KUh5eWp3MVFWYEDGdFTAtYihFwNTyemsWp3rtfm7GAlota7DpmGkiaQSRyhizLgDxlSZnSEyHXy7I231Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufPnALZ6g/ffAF6gkJZ6oaBlqKqWpUNKgpQSYmkm+P0=;
 b=ZyRmEDKNlycrfahGcwUnn2CuNBCdwGvBoMez16t8K4aabfFHZK4Zvv2pKgDT8wc/coLGYW9DwMclakMAKi90OglF6Z1NR1HE468YhtRk+Xz3jXCwrMID7yQz5KJJXTPQJC94G7f+dV8Pl9DQeCka3cxOCUmHUDQq7JfNM6jvyaVMsIl6ZjHtbm2qID0h9JgrRTrak7I5AOU2EyHHaKF/hDriXv2EybwikRNzex0IjGDO+6SihVtTzOksgiHeD3LRdBzm0a33QJGzSMtgX3bp5vXRRW4IYdrA6W3Da8fCVkxSv0JW0W1Hfi9byygkcAzcRQQR51D03bYJpirZDZAnfg==
Received: from VI6PEPF0000020A.AUTP296.PROD.OUTLOOK.COM (2603:10a6:808:1::8d8)
 by VI1PR10MB3357.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:51:48 +0000
Received: from MI3PEPF00008484.eurprd02.prod.outlook.com (2603:10a6:298:1::6b)
 by VI6PEPF0000020A.outlook.office365.com (2603:10a6:808:1::8d8) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.406.9 via Frontend Transport; Fri, 11 Sep 2026 15:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008484.mail.protection.outlook.com (10.167.240.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:51:47 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:57:48 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:51:45 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 11 Sep 2026 17:51:27 +0200
Subject: [PATCH 5/8] arm64: dts: st: add vrefint calibration on stm32mp25
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260911-adc-stm32mp25-v1-v1-5-cef26eecdef2@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF00008484:EE_|VI1PR10MB3357:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb235ca-0930-4886-e301-08df101c9615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|7416014|376014|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	lZPuXsAMr7/773cb7Hg73zLGArVSPj2f9r/5pBfZ6VcZ09C6RQEjbhyM6DixzfkvAU0kDDAKOTO+CD0MQGf0lZnHXJcFOw1WZIdhdhcE4y/J02bjHhWFx5wp5uiKR1Jei5KsPbKDDYznRG49WaZNfotXKiCRkGjY/PUbTzn5d8a17YCL9x3ZbOvrwPivA0fvf8VsVcWq2UiAXms/3RsGDA89y+XIZUYeOjeXNchRxv3TWtwqt6odU3o8ukWjG354T11cQkk66AEi1gpuO1Ljai4h85jh/l1h85EF0S5KY5izV9rDlKt/SZ4uJwGB8voZl6GJYUkuutD5kLD6zPO0NSHstA5bywqdjzeNpXQ0jD30hknS6jdW5yA1k0qI2ehnpaDC0UZrAvBGwyrwNKHhcvrACbdJMle4wI/x4N6M9rRYkcPGdWYCD5ET0UAZzk+iKvufVvaoDF1b4WfQROoHvqlRpyli1jUVh0dfPuPvBEAEMW+CXiJmbRMY1lP+i7+0v0vox3sS7rhqlupglCquL+81Uod3IllQ2EACQ6OLQtx50/CUjhTQvulxSmNFAik784VM/jiGnCgED35vS+IUOSe+OUJdG4B4cgxL+WQiHAy3o+2ego61GETy4EX96QVA5cQc8eoV/OTAmMvqJXgqP3l65HWV21mZ/aWGz7s0m0XZpi9x8IEIeQVNmytkIyxjgn1Qhy1S9STLOVBHX0m+tw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2gFR40QNwBlDCvZhHjXbPHIEvfTycby/0OiuAJpJbhQtJEhQ0FeqhSdbIItJZnioDvmP18TiOywGTMFpQidxVkwAHjhY+iT2/EYSDNbpurranm7ZSgTSLxHlpxud2jLaUVpilnxrkudrUdl4ODUzQFmO13/y6NT+ahhwjzEVORSscIvuIQTe65w4Efn3pd5SdwhK632HszmOiNgLElXVGFuwvCOmantuTa3qVWsWvaG/qPura8TkS+TwZ5IJ/o/LK26gxU7yi11WLl08ac02iWCyLTpqQFKe5mvL52DkopkF/Rk8jUCU9xOMhYnJYdgKtoZOj4OCAPqL5g/WkYnqJntOyRNgpy5bLXBygrwTDRnBRdXDKOLA365p7E78G7omFyhvErgBUml/27qoRqvEfbb0KnoqJj6fMceg/Ny1YY1H3BCTYQU0sx+F0P3hetxN
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:51:47.2270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb235ca-0930-4886-e301-08df101c9615
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008484.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3357

From: Patrice Chotard <patrice.chotard@foss.st.com>

Describe vrefint calibration cell to be retrieved by ADCs through bsec,
on STM32MP25.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index a6cb5378aaf9..cebfcb985cdb 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -1777,6 +1777,10 @@ part-number-otp@24 {
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

