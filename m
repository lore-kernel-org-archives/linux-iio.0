Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011024.outbound.protection.outlook.com [40.107.130.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12951E445;
	Wed, 30 Sep 2026 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777983; cv=fail; b=AjoioWwhZ5tFm9A8sI05XfcuvROcWOO3KUMhQ0TVK17xFlQpumEF8hAQyIFJXL5v6Eq/clDeFZVaVoejalQlWs39knlXHUkM/89JQc0dPSK7JQqWiYXRqxCBPkk8LhRn+9sv6AJ5TIo9Hb+312S9xkdqmeEYq01ULhY4gi4wSp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777983; c=relaxed/simple;
	bh=CxHVTq3S+bpRHL9tJFLfNttBsA0uvwausnCoWJU8NRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rSp7OmfJF7Dtcp4qJUEJP7kxoZ+GdtNl/3WkP0N++D34cdfg7lOwWPW21M6FLimR9xOgqt/lc0bqcmZ6bPK+cCsefZAjlwiRWrnqVEPeekQvOpjXMNMLs2Z/n6BlqYymYyEDOpzPXseJ/Fc5dXiR2EH2PZVCChgjFUxdbmQuUB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Xbm+doNi; arc=fail smtp.client-ip=40.107.130.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Xbm+doNi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1j1bT3K/x0ZEET/OzwQ3kVAN0qpISFjsDkz7XvqogPsndBD25upmt7yjXRmsyc8rook7C4R7YIIJTva8jqAMdVrYloh07HdQzTC7PCeMcNg02k+yXQwz/QagOKY1fglTkofeXvwEHw2Vf34uAU5YMV+v/8iJkLZGW6SZGyz6YaUgusmiFFhMyGf+bOk6yN9jUxI1r2iWxfb38dlaDabRSI5Vg6VLhVriMyLSwmsKbJP1RQSbKgz4wZaqll06cubvOjx+k7BPpXxiMlLBkToN4Zm8rg+Nyzvo4uhAVoCpS0vBJCBJLqIxJu308Nhu71nAGJkWCkJuXepBvVuYpyWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAE1GuU97+6bxe9iXtFIqCAC1vZBHlYiI40pmMJ5IgM=;
 b=cYA2zjmVEAGuD7+inn5TyRPuq0hZNcqRGLUI79BFfNOj4g5ZSrJe4rQ1zbJ54iKkIxN896C81TtYtfSPVg7FK0d3Vx2oz9Yl75hH1vDmkuWG6lulbO4bkPOe1SZuj+1wPSwbN7KnWxLehb83yApOSv7ZM17+Dh2G1E7LPn1RtRaAJaMg+sSzUb9XKnWdVXKi6QZQj0b0l1CQV03Ou6kZPpEnQ2Em7Dho4+I2LYvlK8LBZ3v33TkRUR5Ic/ks+fDrPMvOBD3lWyw9APqq7DozE+Zy7KTWyhZOz5SSoKcP5Jn1cwrEkHO7NsC2Z/p5+JBNG9RC8t65Q+oYPtnnnJDlFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=baylibre.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAE1GuU97+6bxe9iXtFIqCAC1vZBHlYiI40pmMJ5IgM=;
 b=Xbm+doNipKgDlRdVQzDNW8fzwrd51cu5cVtWaaKc4cePDUHi/DCPhknJVVckZa0YO0AC8IEus9z6BUOc+l9TVqCijuaVgL7pPOBvGBoC0+9Rq1ZwYOz8jjOiGBNPdl0Wm5ZQUY/5DYFcgMJ+zrNhqWUFtvkefg7Mm96ftH4ULyzS/zZwsw2Oq34VJTCq0oW3KhiTJh9DHfsiH63ZClg87ZO+EuaZdI7EDmgcvNNeG7Vaj3lvMklAYIQl+vVGRlUp3ZRPRMi8A81W6zKC6XFeykpYBGs1K1/7+uDtaJPLs4gsy1sircMjk4O9UvXGPWfJiR9es4WRc/iHa43SecAVcg==
Received: from DUZP191CA0040.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::18)
 by AMDPR10MB992172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:70d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 14:19:24 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::8d) by DUZP191CA0040.outlook.office365.com
 (2603:10a6:10:4f8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 14:19:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:19:23 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:25:55 +0200
Received: from localhost (10.252.17.140) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:19:22 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 30 Sep 2026 16:18:36 +0200
Subject: [PATCH v3 15/15] arm64: dts: st: add ADC support on
 stm32mp257f-ev1 board
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260930-adc-stm32mp25-v1-v3-15-406834430d72@foss.st.com>
References: <20260930-adc-stm32mp25-v1-v3-0-406834430d72@foss.st.com>
In-Reply-To: <20260930-adc-stm32mp25-v1-v3-0-406834430d72@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E3:EE_|AMDPR10MB992172:EE_
X-MS-Office365-Filtering-Correlation-Id: 19933a72-27ba-41c1-9db1-08df1efdd3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|1800799024|82310400026|376014|10067099003|56012099006|6133799003|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	S17R87cFtgr+xKCbvIKeni9Y8Huzt6LDmrronV+XLq8rdpCiTYXrM67HSIurNrWIm46GnNEN7SRvs/bBbuykvrWmWcytOII0K/5kVh5vT97bMAHpPcvNzg9WxOOZ4/ihSqZGE3XwajxYHeE5gS+mlY2/zGfdLCf7FSvl2Rke0AraaXZ4Ky1eLZK4z6GswxdLTzD4FxOgGvzTxySEDyed1RdRnrPEXY+aEdczZZA6IJSrQo7B0j5WxYNDMzj8NtkeOo1kOjbZA0DvX6jlpdlDtzsbw7B5k9WoRVFeLGD0HGaKet1do1q7FFV10WBKbfD2gmxZVfCK1rV3KSQ1tuCFUKdfEkSkBc9LfkNg70n+zQNCejOEVkRVeQKWff52YrXnDMAEwfwastCTp4YrCX5+Ak7R5Wcm+UdiuYY4a9iMGSo2YAXN5hl0ViB4SxwVObA/Hl4ixLeleZi0/G1/8GwSFMe6SkCbm97PuWBv/Y4m1iNlMAQDJwzbCqapWLyS9iMtKzgDxKgpEKQ+GIi7d4oyWvnM/q2/NzBlbrgijQJXQ1tj6DlqDFca2WuFBYpiOEDt9rp74SaNFEp/Sv4SGfS3aGU/zM36u5swfoVvb4qqIRj+RfPZjxIfvZIKLfjglbc2HfWt2FX5DW7ov99DsRQt4x1brja0Q15PDVd2XqkIvjlTSfr50PUhmpdxohYQwSCOLNbAyneRVmzKTLzNV8eESw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(6133799003)(3023799007)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+CvupByN/t4iCZa3R2/FpD+fdZQyH1udsabZBACgSUNBCFNGQwPfM0nXj1NQTR+hgmWd3p3mt7gs4xlea38tFfib7PLy8X4KlCmLbvchF0QlwDHBZfDxhzm2Rq2uHUTq/6M64PuwgRfEYPIFRKUBJq+6uxQngQBVZpOcCVsj2/ATXLPTA4Can3m0UhCr4hnW51jGwHATrc8xIxkMEzCyCcXYTPlVbvDI6Trhp5ySnomQBvsE4xuX6v9vYcIjOOY2h5ZCpLgaR1gyOME6Wp4Blpf+RBXkXQJb2sg9E3VMAR0DrDZAW8oUytQ+9aebgOAyVFZcq6Y3iLZ5Jz42D8jH8TxfWkEanyDXm1Ut2Z+NoydQULGRxQPutA42Yvjjr83D3U1vfgeGmH8EtVpEM265sPzL2KdO1Z5EcHkQEqIrzJS0DRE5s62CtqAbWMOYgSQm
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:19:23.8763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19933a72-27ba-41c1-9db1-08df1efdd3dc
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR10MB992172

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

