Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43965172E0;
	Wed, 30 Sep 2026 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777977; cv=fail; b=l2O4Rfzh0GSJBn/RH2DAKJspQrTLw9xYhufkKI+73ptoMgnDtEcZJkyGc2nHDybiB3gs35IPzMuYtvdeCnRR8xtf2wJ4m9qplePYPT8z/qRNJ/vDASU7uBUpFNYm5AxHh200zilYt1svtxf8CCGDCDx4wD+bhkAfGozQF84I9Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777977; c=relaxed/simple;
	bh=evuskeFTix1IugIz2BJgaDS0a1K76v1L7I5OfvOAduk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PlNr4uc+7YMA14AWDYiFvh3c4xmwiLz4n/2qV5t2HBv44qHx+rxuco218ZmyNVlTPiMTfLjOu5ixYQW7yc43PetvRmzky6kQYSj8zdDkseOMPwTXpADmw3F+dbYVPIs6FLjvio103eyPzFXbbnQ5LtNx1nzqLWQXofhHcqqq3Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ECc8JXTu; arc=fail smtp.client-ip=52.101.70.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ECc8JXTu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvYqrDWCNB3OdYWW/lBRysyOT01A4xUme7gk7y33YPBf2VFqSHdeAROSjoTBskH42CjIL0uexcUX7Pvf8tlsH9juEDMMuQFKfAvswywwife4gcS/Xc5tT1BYkaD0plrI7ChfW/3YaQeHyvpsE8Udcyv1eMTQVqYKKJuDQyZUBAEeyc9lXuC3FkLgpEeJumV+vq9AE7GMjWSn+IbK+K+magk7E2ge6A9FtVV/M2OoqbVHphdS+80VBHaWqBxqOOEvZjREznTmj/zygb0AHRjYXc/CehwzBQJLEc0M7opAM/3X0jpMU547+hhgnGTat7JCvQgbh2d+28cD/jo8D5mK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i+e0y7FghVLWH0mqzpP4kfUPSYEXnwPaSxJyGdOfLk=;
 b=wHE9/b7al4O+smmaRyXZmdnnr/AyB6VRimRXaecr5Y6pjLM2n7IFUME0g1Kjs4DIzKi3V96FPiupY1inY280MqsvSLlR2Kl9g6n5Xzy3IqUbwexC6LeNC8Mq7DfrwuNR8manM/JkQZ622o/mdcXUT279Kaj25f20l9JLXxoHKx1eP2XWluP5ifmlrenXit1KPtX3q8V2N27Q6Bpej26//vwj3QALMh3PAqjih+Xpi35h6uvjGFyw7/uEC+UyXcuexegfFKp1yUUf2abEbiBOVQyzepWD+VvxESaQjrruvnIZPkFFnJkyYIGsWEuBl4Bk6jmaYu2k1injsnbuXKN/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=baylibre.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i+e0y7FghVLWH0mqzpP4kfUPSYEXnwPaSxJyGdOfLk=;
 b=ECc8JXTu/rUH0NM+2SF4x4KgOx5ZU1ddUx9vnr4StkzO1IdabD8m2YyNzrBUClWyJknMg7I3l2omfjWQzpACKXCsP6g75dqyPrSp9NuZOVkuULn8fG6AhDi0TtoSglMMYAK2pAsuwTCckcefQB4KSHuMa3/j8weqpLmyiIddsb0dyksu69O+sVryUmSOMH+8XfY+rLTveTkby5HDEpsqxSeVGO6K2O8zrDOTcyvMpnitwrlNATmadQjFB6L+pMGtzOwzdlaJRNMCVTvBYI5XrXlzq6TXfvK9x8cvxzfZpRxzIWbyrZgZOfZBUS9JZy3+hKMMXojajLieXAA7V7qavQ==
Received: from AS4P192CA0022.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::20)
 by AS2PR10MB6709.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 14:19:19 +0000
Received: from AMS1EPF0000008D.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::7e) by AS4P192CA0022.outlook.office365.com
 (2603:10a6:20b:5e1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 14:19:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000008D.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:19:19 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:25:12 +0200
Received: from localhost (10.252.17.140) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:19:18 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 30 Sep 2026 16:18:31 +0200
Subject: [PATCH v3 10/15] iio: adc: stm32-adc: add support for vddgpu on
 stm32mp23 and stm32mp25
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260930-adc-stm32mp25-v1-v3-10-406834430d72@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008D:EE_|AS2PR10MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: d49493a5-77dd-4936-81d0-08df1efdd164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	yFrNhhgCPxS/fNZqeeuSY4UXKHpEgol0loM1g9Q2rThmP9LRA0W8ldKRJ3EmLvIlik57krj7oFzGoZAZAWvQ03ds9YdG4OCmCdUiveYR2x1ii1KSKx8oFwaLSCZgMpEh3dW53AZTVl0ffWUQHgINxxKX5eNAg096dcKHCmjGCnIn3s60LAPTHQikVlgu5/v/GPVuQykVprpNEmzodA2Dd1rcWflprkE36cA4/cbB6qeZog482uFq/JiwzfpeU8noThK4lKjeXz4HPEU2qqPptE+EumwYveHrt018wSb25BH/6pTt7Z2X9GrnuHPtuMMWE+HeubM7fOuow9PR1OCHTDlA7w1AheQVHVNhF2dXswvJ9e2WF072mUjuACvxXVqNFdqQhgFfkj9ihiudoiWhb9+SClT8rVfT8p6VLT9e6RP6fnCKnrJgFt+nHN8H4vSc0gwdpA93bVM5WY7fbA1eYRO1c9oQIR4CQdjL6TXuOcnk8jMvFxn53kPoEIJZfKPvUxvWgh5hEgYkEKi9WDGWY1fn9zOz/c/MkV8NIzlIv0ZwDRHsNAgiqdUwAMrC0S4m/1ErF/lOQrA/FjTiqB+/Wmfgdrm08bjEcwqr3mdMZZByo7pnFY1HtxTMhJj+QGTTfMejcHffXq9IaP3H7U5xp9O3xhveGulvVrV6ccFanMNgaWu49ziN5dLBYMjdAwzyl689WRmG3CjH05jVRz01QA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yVt/1Z3q4ISUYOXVsRHsvW8FiMY0xwSw0Z6rk3AxtUYd8nQmIU6bhwtoYRuXM+642cby7Gcoctyl8KqYQjYiVRrZmqk9snTl+yYTTXmMw5d5BPCWGIsJzCFIrVH9ehwxzDSqTTEjTmOAWFWOgw1GtI561xRw0oKJ23WNIUJUaGHVP6efJkb8Dh6NCkD3qudMLMba9UcpGsX7mrh7GZNeof0Gw73d5G9DnXFL3Ts096yWoeYK+Deyl5FYbJR60UrDVFffi2++t1vQelWTeluKBVYKlKcjW3bnL2g1QucMQKBR0o0OItW9alwa2hVvtxZb8RKVAC9YrEdFhEPImFjSCKckhod78xSyEpUdl+zMZfgkDGn/jQwqaSfSGvLS1c2JY5yT1CZdOcWuBvCUt3V3lBBttGRudFWGzD1Jp8/JkykGrloVCiDDlVA5L29UsWPb
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:19:19.7569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d49493a5-77dd-4936-81d0-08df1efdd164
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6709

Add support for the vddgpu internal channel available on stm32mp23 and
stm32mp25. It is enabled by using ADC2 and ADC3 option register. Add
VDDGPU to the list of supported internal channels. Add sampling time
information from the datasheet.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3:
- Style: add commas to non-terminating entries
- Rebased on top of "iio: adc: stm32: fix minimum sampling time values",
  that has been already applied.
Changes in v2:
- New patch split from V1, to avoid mixing new SoC / feature.
---
 drivers/iio/adc/stm32-adc-core.h |  1 +
 drivers/iio/adc/stm32-adc.c      | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
index 68b937e3819f..330c6c30e4f5 100644
--- a/drivers/iio/adc/stm32-adc-core.h
+++ b/drivers/iio/adc/stm32-adc-core.h
@@ -273,6 +273,7 @@ enum stm32h7_adc_dmngt {
 #define STM32MP25_RES_MASK		GENMASK(3, 2)
 
 /* STM32MP25_ADC23_OR - specific bit fields */
+#define STM32MP25_VDDGPUEN		BIT(4)
 #define STM32MP25_VDDCPUEN		BIT(3)
 #define STM32MP25_VDDCOREEN		BIT(2)
 
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 210b76b21d13..b7024f280b77 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -97,6 +97,7 @@ enum stm32_adc_int_ch {
 	STM32_ADC_INT_CH_VDDQ_DDR,
 	STM32_ADC_INT_CH_VREFINT,
 	STM32_ADC_INT_CH_VBAT,
+	STM32_ADC_INT_CH_VDDGPU,
 	STM32_ADC_INT_CH_NB
 };
 
@@ -107,6 +108,7 @@ static const char stm32_adc_ic[STM32_ADC_INT_CH_NB][STM32_ADC_CH_SZ] = {
 	[STM32_ADC_INT_CH_VDDQ_DDR] = "vddq_ddr",
 	[STM32_ADC_INT_CH_VREFINT] = "vrefint",
 	[STM32_ADC_INT_CH_VBAT] = "vbat",
+	[STM32_ADC_INT_CH_VDDGPU] = "vddgpu",
 };
 
 /**
@@ -167,6 +169,7 @@ struct stm32_adc_vrefint {
  * @smp_bits:		smpr1 & smpr2 index and bitfields
  * @or_vddcore:		option register & vddcore bitfield
  * @or_vddcpu:		option register & vddcpu bitfield
+ * @or_vddgpu:		option register & vddgpu bitfield
  * @or_vddq_ddr:	option register & vddq_ddr bitfield
  * @ccr_vbat:		common register & vbat bitfield
  * @ccr_vref:		common register & vrefint bitfield
@@ -186,6 +189,7 @@ struct stm32_adc_regspec {
 	const struct stm32_adc_regs *smp_bits;
 	const struct stm32_adc_regs or_vddcore;
 	const struct stm32_adc_regs or_vddcpu;
+	const struct stm32_adc_regs or_vddgpu;
 	const struct stm32_adc_regs or_vddq_ddr;
 	const struct stm32_adc_regs ccr_vbat;
 	const struct stm32_adc_regs ccr_vref;
@@ -725,6 +729,7 @@ static const struct stm32_adc_regspec stm32mp25_adc2_adc3_regspec = {
 	.smp_bits = stm32h7_smp_bits,
 	.or_vddcore = { STM32MP25_ADC23_OR, STM32MP25_VDDCOREEN },
 	.or_vddcpu = { STM32MP25_ADC23_OR, STM32MP25_VDDCPUEN },
+	.or_vddgpu = { STM32MP25_ADC23_OR, STM32MP25_VDDGPUEN },
 	.ccr_vbat = { STM32H7_ADC_CCR, STM32H7_VBATEN },
 	.ccr_vref = { STM32H7_ADC_CCR, STM32H7_VREFEN },
 };
@@ -953,6 +958,11 @@ static void stm32_adc_int_ch_enable(struct iio_dev *indio_dev)
 			stm32_adc_set_bits_common(adc, adc->cfg->regs->ccr_vbat.reg,
 						  adc->cfg->regs->ccr_vbat.mask);
 			break;
+		case STM32_ADC_INT_CH_VDDGPU:
+			dev_dbg(&indio_dev->dev, "Enable VDDGPU\n");
+			stm32_adc_set_bits(adc, adc->cfg->regs->or_vddgpu.reg,
+					   adc->cfg->regs->or_vddgpu.mask);
+			break;
 		}
 	}
 }
@@ -986,6 +996,10 @@ static void stm32_adc_int_ch_disable(struct stm32_adc *adc)
 			stm32_adc_clr_bits_common(adc, adc->cfg->regs->ccr_vbat.reg,
 						  adc->cfg->regs->ccr_vbat.mask);
 			break;
+		case STM32_ADC_INT_CH_VDDGPU:
+			stm32_adc_clr_bits(adc, adc->cfg->regs->or_vddgpu.reg,
+					   adc->cfg->regs->or_vddgpu.mask);
+			break;
 		}
 	}
 }
@@ -2676,6 +2690,9 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
 			case STM32_ADC_INT_CH_VBAT:
 				na = !adc->cfg->regs->ccr_vbat.reg;
 				break;
+			case STM32_ADC_INT_CH_VDDGPU:
+				na = !adc->cfg->regs->or_vddgpu.reg;
+				break;
 			default:
 				return -EINVAL;
 			}
@@ -3187,6 +3204,7 @@ static const unsigned int stm32_adc_min_ts_mp25[STM32_ADC_INT_CH_NB] = {
 	[STM32_ADC_INT_CH_VDDCPU] = 34,
 	[STM32_ADC_INT_CH_VREFINT] = 34,
 	[STM32_ADC_INT_CH_VBAT] = 34,
+	[STM32_ADC_INT_CH_VDDGPU] = 34,
 };
 
 static const struct stm32_adc_cfg stm32mp23_adc1_cfg = {

-- 
2.43.0

