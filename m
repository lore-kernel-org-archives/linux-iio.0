Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C5560AD7;
	Wed, 23 Sep 2026 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177987; cv=fail; b=IzTuaeoLLWN/qfl/lM6vx9I8FqVbA5JzwxVdSfyHFr1NbVt09PgCudHkMxEWg2+ZjWpQCpqCjX7Cy+2GRVpaot+Nh/5aGxy67cs2hfngNZsN4AG4/X5fdswoRdOHx/2B1EhMaqp2DlnlkfSvN0qGAXTVRcVN5k1kvxJBuNAvFVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177987; c=relaxed/simple;
	bh=CxHVTq3S+bpRHL9tJFLfNttBsA0uvwausnCoWJU8NRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=W0S/pvtOlKBBYXmCGpngXXXOG8/gP3YHxgHBSWJPxPqnBDEC1GLDZkD2ZA/LxnxUDKV4W0SifJfaYXCX4X1cIYb1TTwIwfZe9Rlh+u7nhZYo0UZ39M70eEI6DU4/OYbFdvLvvwqulHll2IGKX75Jb6mWnQsnHaOnA5lM7mmi7pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GQ7AEuXl; arc=fail smtp.client-ip=40.107.162.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GQ7AEuXl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GY21q/svm7FeP+ZWAOOvjfZoG8vkwLNW2xAyBFH1h5nx7ifMVC0E1/vF2GYj9Dc38gZP5RmEzjQVusARBUkTZ4Jst/I9HYPi9RN21jMNYQKtVpY3orNKA0A8VeVLnYLEZIXjRq+r0gyRfaJMjzFvegaL72my31VXnjufcfVLwPJLMQix27670Cm303VXHQq46JrpoUFf9vzd2nCCJV6MOX1N6vxSkHYDJWNvWsV/HJpBnOngx6rM5DfQ6sVgxv/GpTzjRwfZzn49xVFD1r1p/40DRUuumZU6zbzGeyQkqetbADHhjjV0x7TcxwYzFSN2/eKKdJVCZUM5TNvbafgQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAE1GuU97+6bxe9iXtFIqCAC1vZBHlYiI40pmMJ5IgM=;
 b=MOtAuBsDZPhiUxikQn+ur8yyQp9mb7jjpWyXKs6b4ob75CUYpuEyXlqDYQKeyqlH1l0lUUGuUksBWleNKfmruQ/+fQT7QRMUKqFYtzXCTyGzp07ISL24NYCSbO0ymsLCPs5lIeCU8mzhJ4z1V6Cr5G/LJK7NC0WS1wBRFKOqu9LRWQgAk600zRv/nexf/WuTMqGo3/GQCLbYxEPvHe02U81ye/LC0unn9x7dLANq5zXSj35xLEIt9fHQ7xgUGJ4yRkX17TBHs4M9mHE/JSD4oBfG08gMGq5SmGVhIo34WINRqWEUT9hLTVsiA504MN8TSnHsMz6EkCWyu86FQxp04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAE1GuU97+6bxe9iXtFIqCAC1vZBHlYiI40pmMJ5IgM=;
 b=GQ7AEuXl4d0lFcUgXJt0jNZNT1pmaftgVijmfqx5GJTIkapF+pAlGl6X0p7RdcyXoYrmaNwbNBKfp0oxt429IpYCw7pDWJ88f0wK3wcMQrWQy84J5ORs57Oyg32ieSH23d9to2BAbtzsNxVKMXKXG/suAOz2idWnPq3DYitsMwGKcMTEaonrVei1qF1crfyTPpe6D3YjSCRDMY35vhRgPDbTP4YiCugrSxgFyoWvP/2tSMBu9bBid2fSPa1s6s8AsI4QTQhNZ49RwVjB1evw5nssTGeJtvX3CVMM374dl8q1aWkSlyiuRtlsRTejGNC9coOSr8Lyuv+vWDSxeGhEPA==
Received: from PA7P264CA0204.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36d::7)
 by DU0PR10MB5775.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:39:39 +0000
Received: from MAD0EPF000008B1.eurprd04.prod.outlook.com
 (2603:10a6:102:36d:cafe::84) by PA7P264CA0204.outlook.office365.com
 (2603:10a6:102:36d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 15:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008B1.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:39:38 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:46:06 +0200
Received: from localhost (10.252.7.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:39:37 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 23 Sep 2026 17:39:17 +0200
Subject: [PATCH v2 14/14] arm64: dts: st: add ADC support on
 stm32mp257f-ev1 board
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260923-adc-stm32mp25-v1-v2-14-46bc019537c6@foss.st.com>
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
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B1:EE_|DU0PR10MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a9e11d-b816-445a-b356-08df1988e0d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|3023799007|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GK5byvWnuylWf+1W0n2piHGWcYv4or774VD8/hzWTXbwf3sxyGvRf9U+oCIpuokkFMNjyqNM6ia2m38U1WYS6tcbD2D7SlLQ66k3ZlTGEwxOm8Hj/7XOM085lIYchpmia4H5tVTS6XFQjeXVSmDLecEYYNgeKH0SG3npVPemnFQ/UP6Y/j9gIk7zFO5E+n91wZHxe84itFE/8UdVmFrzAvGG6fby6O8Ogd50qoqDaPoxhSii9shcvR9WuCWdxdNr4MROF4A4YJ/qBmN4svalhh2LbCMMy7p/yv5vn0f1NaJ7M90N/T5BT0aljr/hY5sjc6G1SKFfkPk7VC80wfy6G8Y6VN3yhDBSxhe1tPAvH6N/Zlsomp1TfIC4HUmUgdjdUx84943n7kNDDYoz/lJzZ2DWg3adLNyjV3J8zqsMbXVjNH8aHm3ccPi1DPviYvMQFNsXle96ompOyvSxe9G13IvLQmG6g9PEUY6r45uvVsmm+nYve50N1Hyoh/4PvL/R7sH3Fq5GT9/hHGGV4SL1WXJHzmR+m5qKjQwk2h8h8YfqHRx32p3IxNI80i9bioi0lzHofmTuCXf2B4rU+FWZ6ThziwhDICAxcVZJxVCk+fDK9ox5lRJG1DSa+1/FFI/saTMaVOO4K/3U4EYfKdCgu6bI8JaxuSxtb7ZowtXeLLSc+me89VmEWGDEwetkxwBsoljaHxL1fUNzkwcgHfTZWQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o84CbYKsUOdFyob72BsQxkVuRqcH+wCXTb5B0Jn4C3BZR1wKVnxBkWM6p5yeu09E7YZiioWh0KzJ172XcC60cixYDeLf8n2Y/5MDbDJLPFOeYFq7SSUQfEgRpkLdx8Dy40+jk5Tju9OyQUP0Bnn1+1n6Og2BujlNrjBs+7zAGF4Z7F1FM9oTJwwyPP6hQl2N7kbAkn0GaGQAsztj5E0GSQpWbTrC9C8ez/2iu8Jm5ARoZiq+VWR1nPxvdmuIDWxqdGFTfcGF2aGjJwNmmAokilzz1+9oACTCD0IPrsvHGYEf7utSsIZZw85ixSMYiu+t+mYMnf9amL+/GFEKgNrPIib5r7jbkmqwX4pf91mBYvH/fCXVMS8uSnqy2KDhA9rb8dT58R7azz0zrFVA3e20HPCGjdutmBljnNGlSIYPAEc6eR3rb4b7JRK0favh40kD
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:39:38.6802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a9e11d-b816-445a-b356-08df1988e0d2
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5775

Add ADC support on stm32mp257f-ev1 board. ANA0 dedicated pin is wired on
mikroBUS connector, through a resistor divided and operational amplifier.
Configure adc1 channel0, and voltage divider in the DT. Keep it disabled
by default, to allow ADC to be used freely for other purpose.

--> | 470K | -+-- > | OpAmp (gain = 1) | --> ANA0 (to ADC1, ADC2 or ADC3)
              |
              v
           | 560K |
              |
              v
             ---
             GND

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index b5db62a0a550..ed61ff70c0de 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -160,6 +160,28 @@ mm_ospi1: mm-ospi@60000000 {
 			no-map;
 		};
 	};
+
+	vdiv_ana0: voltage-divider-ana0 {
+		compatible = "voltage-divider";
+		io-channels = <&adc1 0>;
+		output-ohms = <560000>;
+		full-ohms = <1030000>;
+		status = "disabled";
+	};
+};
+
+&adc_12 {
+	/* Don't need a pinctrl for ANA0 dedicated pin e.g. Channel@0 */
+	vdda-supply = <&scmi_vdda18adc>;
+	vref-supply = <&scmi_v1v8>;
+	status = "disabled";
+	adc1: adc@0 {
+		status = "okay";
+		channel@0 {
+			reg = <0>;
+			st,min-sample-time-ns = <400>;
+		};
+	};
 };
 
 &arm_wdt {

-- 
2.43.0

