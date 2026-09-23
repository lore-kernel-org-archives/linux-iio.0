Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45135304D4;
	Wed, 23 Sep 2026 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177986; cv=fail; b=rBeV2Qaocep2ndACyrJRNi+o+DRSya7u8BeAfozWVUpLCYR+U/BNna3Ku7AQVc60PWkARzVsWgxzvcQQiO2MI1aBR9dxDbWGicmXkN9rhjytAjgCOjvUhrSnoJOHwsnTKnIq5Vj7/W3EXYlU0n/X2gOYBW8gGuJshWhgSInqNEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177986; c=relaxed/simple;
	bh=/EuvbZg56B6sh8BFg7LCKG76krp94n2+ERgYZDIhQPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RG6V2jOQU/o89TncekN4NzY3HuiqUwGZatW3TzCoANd8TdPlCjQ0sQ7zi9esryqkRWL0HBMIcoCM30LE3DDgoN6qnM6zRgepS6FWCxHYsFABK0RxyX1B3tFflCGnq6oi2A9XHNc+MpXAogBshsXFG2m/sXjSL+TDqYfASPRR7uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=e2k0TfPX; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="e2k0TfPX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pyx/Wb41leFmmcJenH2n9APjvXH7mwW1QEnSwT5b5JdWhnE1uAuP/Oc6YdpTFRf/1SxkgAnQT3fCk3Q3uPHeqx6zH/B45qo2a2ccD2M/3Hfmc3lNA8xzazunG0w1I8QEOXcd5QOC9xSyJyCGHVNYFYVxmT3pRodeFTrvCQR8rGlUU/8Mi2T/agdIJBKs9fiuE79RB6th4bLFt5Vcpzf8BIW4KCeqLFLHHcOXNByM2qtJQi147x3UX8inJbjQicwzY3z31YN/jQB5IvpVTJTFJgrDKW4mbejcX4EB4SnJc1OntWxl2w0lLmRazEEGFnvc4RKqIywXdLyu+ajyL1cCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPbFNsZLvdThwohuFoxuz7Dt+lLXspWabhIC+wYJaUY=;
 b=E56Hg9CrUVMUqnYrfhdcuJdAPhpsHpJLU5KGty7iQgpX5vgc+ENldplsHqUv227tTBDJSbBPGMNkk4TcacFqQiuHIOtLrMSxcVnkzlZ57vfkvxeaxEBwU7Mp4aNrFLgr0GmsSnO6Gh78TJONxCQ24tAJT2BvZEIv4hl8ueXBgQDOPgK/l6HC5wFH0Ib3f5aLjvwRoM6SJue8edoe3lEfWByIq3M6VC3bbcx59jKZtaLtJxD8sqdO/OKSIS+jCHKQNWk15ARHQo9voycRPHhZmp42smN3F/C8cRz78S/GN5U0Fv/O8YUUVAh+b/Jj14fRURPsOxIJ11IwYdgTFkcpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPbFNsZLvdThwohuFoxuz7Dt+lLXspWabhIC+wYJaUY=;
 b=e2k0TfPX7dFCVM8JS35fev6U9sAxhX/o4ItyzWYhyh/hr+BRjKswSuNpg2hfgmkBwvMDLjN4FcuYTj0PjtDO/LQEFnnUvUqIBZaItcHvrU4VUhaM8qcSzDTZbG0k7Alp9rHwDJ0XAURtzXzXfa980zK3W3bvTyjcgi43TGusflUrspLu9rfosRcNgZ7yXOOmEid+dOtHgAYuP2gBxEfeiQRfuxxhwEDrpbdbpDn11l0wSa+8GvSTR7Ej6tdC+xt1ov4V2tuVXKYDOCnQY+K2F+zzsHI0x3LY+27Eo69WLl47/i4+KMwmfe+IxclAzMPPk4Osfcrpbb27bitnaQ177g==
Received: from OL1P279CA0043.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::12)
 by DU2PR10MB7741.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Wed, 23 Sep
 2026 15:39:36 +0000
Received: from WA1PEPF000099CF.eurprd04.prod.outlook.com
 (2603:10a6:e10:14:cafe::31) by OL1P279CA0043.outlook.office365.com
 (2603:10a6:e10:14::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 15:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 WA1PEPF000099CF.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:39:36 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:45:25 +0200
Received: from localhost (10.252.7.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:39:35 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 23 Sep 2026 17:39:14 +0200
Subject: [PATCH v2 11/14] arm64: dts: st: add vrefint calibration on
 stm32mp25
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260923-adc-stm32mp25-v1-v2-11-46bc019537c6@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CF:EE_|DU2PR10MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff55950-a807-49f1-35a0-08df1988df55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dJL008YgjX8QXxMFbq33BOMI2LjrAIaafyjC+EHVDUcm32WjyO5uJo9BNPtntxc3ul7RNiyv/J4Emm+wG1nRkCOADPyn7ux8xLcnlkbJ9tki4UyucIENN5OaoR8SLviws78DrCy0AlPhcOWhn9pVWvxw59//Ign0KmcSwZxSU4SujiNruhXJez+pyQNMp3RmG61zoGdOQVqT1LcwQRBEzh9yJy8PaOLpPv5QXP8/kK4AlrNnn0kVPC9/lQdjfvofAYMbQcXr+gqEHeTSvNHuk9QvuF0Xcx1lMGSn/yZxcngOtVR2HK85qXSxQfH1TA9hjabOicvp88nV7ZZ6n6OpEUHBH55e+7J64gScxeBuI7beRKKPzzysieM7+4ZIqgexeHywpi1uT6h7D7RvqGzJHuODK0S5WGqvbANSb0urI8RyZVjKS37cJttuR3AYP15e3boLpLQ4MbMFQjphkFat2l6JKO398N1GvI87FDDNhxa7exY0XpKr9tDVv/zsc/aDzt32C4ZYQ9CP4VWJQZ1lBLcQyn4No5E7iK5vNdZsrvUi4vnD2s1t0l4hsyMr0ecRD/zJihcdWHg8QLZhbHTDYQkar/Dbg7eBLmqGtAg1iqoyFAxpeiV9f7RKS7jcPk7wMpGNLjdjT1HYVOfcV4GGuCLNOrT3ibZ8gu5OOHDovKpnp8HwB+qRBjM+jypfjLoKYEgpUdvc3XB2ve9zOlwOZA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z3aKlhCMDeHjnKoz1ieL6RSnqAAnsaJk1eTB4v3fNR2vcG8PlQX7weZPua3g0nNK06CJ1rvYax+gemvdP7/e0LT0q5rYOUftz66QF1Q6HK05xVJAZQVhP89sBqMI30s1cxIMyt11JAG8WH4Iod8LfkSXChVkOPCjTb4V2MSvowv7kgV4LZ7c+Mi82p1RBbSu/u1DYCGyxpFWdD1IGDzifTuoK2UPKyGNOb+4iu/mjRUhqQ5g6iX1/idu4IjEBlX+yPzIc7o8U7IG7cnnn4yB2mYuv6fcVeiix0m+CqKdDrhLwDc4TnyjbGGSfInzo2tE+qtRKXiP5ThtgzeQUSy55x+yberoM5VGQsD6dc160DBndFqBRctfkgS/mQrJAUSsc3+Do87bReNulQYvva/m97Fy6ch36BloV3ilXgJajCtAvkr7Tzrhu9g6L3+QuwNa
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:39:36.2004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff55950-a807-49f1-35a0-08df1988df55
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF000099CF.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7741

From: Patrice Chotard <patrice.chotard@foss.st.com>

Describe vrefint calibration cell to be retrieved by ADCs through bsec,
on STM32MP25.

Co-developed-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 9c63fdb5a885..82a8a6f1f881 100644
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

