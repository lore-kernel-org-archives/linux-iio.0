Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482EF3CCFAE;
	Tue,  6 Oct 2026 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273513; cv=fail; b=jLL6JovXrQ2itIpqE5OJf91uf7OZZdJTaM5qO1XhuO8Gjsh5xLIRINHlQwPIW0JoQDmIz2v6kHCTte28mCibkDdUqeYBQaQw3wyLEhsbCv2JPqwC2+vl9ChDBJINozdsGgLqXt/ZN6SSM5RPUnFTw5o29l5RPH7SEFI4yd0zyRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273513; c=relaxed/simple;
	bh=CxHVTq3S+bpRHL9tJFLfNttBsA0uvwausnCoWJU8NRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MyXZGGPUzRKe5aV1k68NIit07Zj64/BGS19OUFKKkfXO/5PW5U47hRpbHBZfdOXtySXHsJABhing4Win3Aiohbm8c7jvaI4v9vsCbar2lt8bt73ztz2PYak1OS9bZefeH0Rw0lxKWEiQiyrSYhMQZIV5v10++LP1qIUyOS5YnQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=E81j9CLa; arc=fail smtp.client-ip=52.101.83.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="E81j9CLa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgpxEdtts7Z5wj+VCi3P14dn+Ob2ToonvTdW17b8vB+fVmY0PsS2CWjjOCXakOBJRHRzUb+bR8JgFPcD0BO6ggpe6A6x3ke1Mr+Qv6ElMEEMtWCwV17PMXuBWkDtqqETvaI8LaFvz65u4TaZ3Hh2fFDJEakgCWC7OJVMJttnktefcqPH5sgJVLmyV1aQ8Wpm6/7jErmdfIn3lioJeFOa8Bf7Y6RcErYvPalcK4oDvzVrQwSeWT5k5WZ94++tUrpUqJrWaqWYtqbqRw5gCcnav4fNaYoLl2R3rO6ARgkOxnQCZQ/lXIgqVl7jx/ZojiJnM4InOhAH/AlF0Xo/OSDiOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAE1GuU97+6bxe9iXtFIqCAC1vZBHlYiI40pmMJ5IgM=;
 b=spc4feKfFrUz0nQxmsbzMvFjHLBYrjG0Bfv+9vzVg+TlkjdP57jefw+fx86JCOM/WdO+ruH+SJO3lDFhMW2xUKy4QgUG1+m16FwNnaUfW/3s63cQDB6AuEQGY7RaXT7qdZhJXNi+Ekr1USkWNErKfI1IDcEWTSjp/YQ6Jb8OfEijf0el9Nd+OaXEkHiqbPocVGaGxbSudyOM2p/JjpC+igQtYe9nor1AoNASBdPoD+KKMMOrpq2h29pHDpgE1omJUl+hi0KcR5DAE+9w2YpPmRn5QD9dZf95x3PJqX/1I4r4zMQpAvjSCpkhDqJjBGWeMO5g9269BbDx/VhBrUwKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAE1GuU97+6bxe9iXtFIqCAC1vZBHlYiI40pmMJ5IgM=;
 b=E81j9CLa8eYWmY7wpaYnI68h8rWndp3gPIVkArhGaeQldRE5UP6quZ3F6wZoivPfT1yiqsbF7idPac7709/GzHq9jxkIIbUJAKbVU2FCLhTkihcFxBXbii2FeUWCVClNdbaAG1un7J2+ZVGscmnZv/COiIUhFFufoGucF2dGbfpFLQ5ezhrlknCW7vXTyIFesiGQ/S/mJUgE/UtzpJsDlU1Do9ZR1/Lhvm/0+4Jj1v510jrxb+M4+M2epswhd5Z8rRlNoD5KqtzQtr2a52o0dL6FkwY1zHZmyjn38Cl4KaykSEMpqBQxLgnBDeQ3+aetXUiO8vPyd2xY0jwBAZ4Qdw==
Received: from BE1P281CA0462.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:7f::19)
 by GV1PR10MB8027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 6 Oct
 2026 07:58:22 +0000
Received: from WA1PEPF000099CE.eurprd04.prod.outlook.com
 (2603:10a6:b10:7f:cafe::5) by BE1P281CA0462.outlook.office365.com
 (2603:10a6:b10:7f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 6
 Oct 2026 07:58:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF000099CE.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 07:58:22 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 10:05:04 +0200
Received: from localhost (10.252.27.219) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 09:58:18 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 6 Oct 2026 09:57:46 +0200
Subject: [PATCH v4 15/15] arm64: dts: st: add ADC support on
 stm32mp257f-ev1 board
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-adc-stm32mp25-v1-v4-15-d31ec75aecf3@foss.st.com>
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
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CE:EE_|GV1PR10MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e1d804-1ecf-45e0-b2c2-08df237f97c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|7416014|11063799006|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NK6xLusTn1XltbSDc0OMsLXpm8pLShayP0lNRfRpphIgOo/X31g2i/WtO1GoxEMvmeTh5mQaVI43ItOL4kpz84IQhLTPyBELMBFkAyx6gPra+VGJpl60CjiB+dhhhqe0ZWHuTroyAsIJo3o+M5z/zzjgYOwLOKH7FhIb7nR0wUdb+Nzt7IpoASl9k/jEKQWJXKRUS8RlHDg9sT83xq6EXj/JSr87jk8MxtdHnCwRFCjwUt8E6Z/1ruR7i7qX0mcJrXZOTzJA18qg/PIqrLrgY4jetNaPX83drceJDUX0QVEmmhBh9Kiwrorlhfef4cd8JBUgck0k6Gnu/pE1QeaWsAoR+cp5nzLWjCcKPtgvPd/4T81vIJ0Q4o4f79TDOxFGjfs83IA0PmGRr8soR9pJ1+slR18ASHEQvEdPI1NrExOdhrC8tJbmWOFB6fpSwxfrS3r/eT1upmWtKB3mdp3p1UclSCduQSLLpmX1ddV0jgeTNU0mkmw4xsARjVI5p2CnBbIfqoZL3MO+Imji6dGNSdZvVCCRZlspBzXwcUEMH5QAfJdtSZjQeyMlP/CdDBZiIUGCZH2ZeZnhQyFsrN5Zrm9fDFDAxEBYY3FWW3tiahEiPg7YFNCXCHvIflGQnSlhK+d4n4KVDVkNRlRrlsbwLrdYDTG/ReoVkfarZv6KV6OW4j486IhLO+xHO2hZHTM3munRhT6HwoqqM4c3Mf+2GA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(7416014)(11063799006)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x5WZbPWodr6RnIlcJOd0QX9uGF2LMcDDfol0V248c3JV1Solp+1fEVU05kRqy4hJ6U4CqiHF965pxgEQXDhi5mhl+BZaiiMwpCsZNIC+90CZm9UHlXjdgqzjKAMq+e72Ij6RDoRRX1+5axFfbW/WDW64F6OtDNVtd0xy2z7xUGn+0eOkP9f9rK7fBqlXDvnJ9a6miw2c1XXBKujyGcPZXkgWXu7V++dXG29kEuwVEiEoe+ij16W6gAkX16rOfe3Ht6CSvkxSeHf48GR6gVhsabNorm9011qnQ0gdJVt1hviD99bC+6mkFom6AfHg1eDRuDsgiqnAU6UtjIL6rA0kJxgz/rTAj95qz2dRlkzNmUggUhEkzpNDabrwHrMRcH2JRj4SL35Opq03SaKAiE09gzHQQA/UFKfB22vRca1NjBXe8IHLXv94TSrby84BWt/e
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:58:22.2604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e1d804-1ecf-45e0-b2c2-08df237f97c1
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF000099CE.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8027

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

