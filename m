Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDC03C1F22;
	Tue,  6 Oct 2026 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273506; cv=fail; b=jdlm5fSx5XyjKBGGYAwV6u3uZLQucG9MvrxRHrzBZN1oZKYsMm7mHZNT0ApdvaQ8YZXrsLA2rK/KeisZh//X2uSrqQyydVC9x6+3+cSchJpgtOMlTRbMdOOGm6bSRaLdavL4IULu1pMuSIkUb7XJcCqymhKQV29HzZPJqEbeMN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273506; c=relaxed/simple;
	bh=AmE/s6560l/VMJYv4Hj3EdUieAroruW6NuBHu8Nm61M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cy1gfxycum0DE1UH7np1s2zS6IoEbjYvoWypMmk3X43jX7bIX8sHm8WX379wl/49s0GkV+rZ7T1DGS3hZQZF3vGuOvom2qHzsUqIey2X5LkBJ4B7N5BHg2BykC4i3cmupoTvcToo1gR4UJXJ6J04vvXZyZFjDwagzOlPzPdX0dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=i8S0+ggm; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="i8S0+ggm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZz+VhRYCDVxkSxeSfs3JRwVdsfHC/fsqTxX8kE3H7v/+/ml6V6IYXGSP7MNHcW4zGH1uGQU7E8Oceu3hlgOKS+1IjeRNvqrlP4q5hC6n657d3f5TtZC6+IWYu6HHX+e0Yny+4k5amXI8eDOpxgSzcVqdiP8Q8TRVgPEkFqeWIgnvZJW6C0PlVLBCewKbbvVY4tfFKb5aNqEpK7YO4XbeRtLQL3nCe/1LIa5k7IFE9XjWq6lU57x8Y4qUqM14lonul2S1PphhscoYbLEG4GVdvb8Pxe0EavU4zHVX+k1EdrFiC0urSfN45k5xPbc4D2r7Utfzt3g1rCCA5EJ3B/28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmNunBPpLVS1iSEeJX30OrgF4RavnD1UeHbM/xjnyf4=;
 b=Jck7iRZIOiWh5Ny791CajtvGd+M/R/u1fzTMTtA5LusI5NbSz+NoxDByrJUkaq2Iph30SUnv4T4iQ7OwfmuREsDPnBZ0ilw1zy9Ln9tWYTwZXmMvdZiWgU3s7lK6tEToMhw4/MJmyUnd7K6ApMGLtBZN1eD2rkhZtb0g+pXX6IDM5VznBdBSApqqhxNz1Lu55nQhR/QPstZ/lpAWWLEX/pjUjYbJj4h6eVPuV2Ivq3XVEY9CqLf9WIMmGArzrUfqFOenwbpKttS/v3JpPibJOGsf73bGf1ZRTP6v5eaHq455L8JImXrtP+9+rwXE5HFOEWsU3IfnGKZBhwLc+yJ5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmNunBPpLVS1iSEeJX30OrgF4RavnD1UeHbM/xjnyf4=;
 b=i8S0+ggmY127L/IKF4ijJ+b8evyEzAuSLfx0tq4yC5XS8c9e8Twzj9w2Wnqu3QM378GwHW7e5rXpped991XvN2cX4s+3l7AO7wqiT3GgxJw3jDoErMcNOny3aFm8f4aVEbee9Adcbj38l62iMHFPGqRApt34v3Zhk6JUhNLdVyeZqgoj+t2WKgxaWXWzr3Uvhy3NIVpq8D0jpnnxcY9HU0VONHPfxfKmrCLxsTKElESgn2eFhn1kqkIWKtB6mZ0rMVdLDfSMPilcww3hvqZvgc6+jvyGAGeDZAHPqIbUv8v9ReSuxZAiV904RHeKDSE9IbqFDaNmc2b6WLTzKXZdsQ==
Received: from AS9PR06CA0073.eurprd06.prod.outlook.com (2603:10a6:20b:464::17)
 by AS2PR10MB7300.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:604::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 07:58:15 +0000
Received: from AMS1EPF00000094.eurprd05.prod.outlook.com
 (2603:10a6:20b:464:cafe::7c) by AS9PR06CA0073.outlook.office365.com
 (2603:10a6:20b:464::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 07:58:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000094.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 07:58:15 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 10:04:19 +0200
Received: from localhost (10.252.27.219) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 09:58:14 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 6 Oct 2026 09:57:41 +0200
Subject: [PATCH v4 10/15] iio: adc: stm32-adc: add support for vddgpu on
 stm32mp23 and stm32mp25
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-adc-stm32mp25-v1-v4-10-d31ec75aecf3@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000094:EE_|AS2PR10MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 37234e45-cf6a-4b80-cdba-08df237f93e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|260925022911599003|260925021311599003|10067099003|260925021911599003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xYIzp1dlClzqWGtzWlwwLROUCHd89E+oS5Rcrbi8WFNNS8CeuUounNahovIaGcngBfzfuUBu/1XkGF48W8vjeFiQt8lK804jEv2NsaovpMJCFuXOEFLKCaOoGbZSplw/UypMH4b4yycPu8xv2/vymMf2LpT0yH/3nHCZV0SEMgywT0yQk2LrAAVsXfPXSPcFsitU5Wjl8bY7CIVG5ja6EeOBhJfTPfzV+r5FGVHoKyaeNzB9Bc81g4zm99nkDnsPdf9bfUTNhGXTa35fddPOv9BacjzPLVpIemaQqUMyNTq2nEIC/LVIbuNGyLG/OdWHHtuVWDJB1Q4wcYD+++c5Zzvc+4qW9x2mM8DruJko0X2D4tzxd+EORE3TysivoQ0UNlIRc8ogCCiJWvp/ISu9n+wU2pgVhUHjmT8VivlXgzpfuwUrMN3pAT8cGzlesLSZXOwIu9ldmxlKHwdQxKpWnBaG06CDn1vff83Q09hf2ZdAiaidEnM34P4sgOguWfp4lSSFiasSUC0x0hBK731BCrj0cGiQWHTgnxoUODvfNdFcoR5Ixhgn6xWyLmdRW8ru2JdUvluVoIUYhRLFkN3KKm+kDEXqFIcpIaSILNeEo9Hx/JNE/OHfS9f9qmIC1oDo9hdCfAhTQKUWcRrGlsJGaLn/fjVbMEKmlMuhaf26FgrRVJKozGkEVi1Lr0G+rkATxpr0gweaOqrWjOpxN3JHkA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(260925022911599003)(260925021311599003)(10067099003)(260925021911599003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Br3J+ITXjYnY5zUuoNQVziLE+M84QJ12oqju+52dl3lwzdVAw0ys7klYFd4b82O8VcoLGjNXRM9G8u/WVFssVc9gcyfBOiaIb6YAqX+NM66IXSoHXvPbqrJ3u0JFxJyKTPusMej6YdNTComEdAAbkT+ZTKa0I24PHeXAH7f+5dX1BmdtaNHRLzrbvyKzzike6xo8mRYA0RPEi3fAoziKYPKCv9o1bCcOQqZM3fO6TzaSsggrpmoxDkuLkShaVx9BoHQNVEo9K5/b0YeZnUFkbsBid50feSguNlLMP/IhO6v2IrppIQ4XUTXNM2uNFs1BnwwjnndbLRwhOCemi4WY+c8NVsrWY9ytEt4PrsvGwQ9W07lR8Vyab4g3kuud5nSWvsdVvtmdT1D7hQlbiFcRsS3xUQEdZZqmUj46EZGJQUiYphPd/uAFfQWWwz+bGh6O
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:58:15.7154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37234e45-cf6a-4b80-cdba-08df237f93e3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000094.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7300

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
index e744e1d48823..8503728265a0 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -100,6 +100,7 @@ enum stm32_adc_int_ch {
 	STM32_ADC_INT_CH_VDDQ_DDR,
 	STM32_ADC_INT_CH_VREFINT,
 	STM32_ADC_INT_CH_VBAT,
+	STM32_ADC_INT_CH_VDDGPU,
 	STM32_ADC_INT_CH_NB
 };
 
@@ -110,6 +111,7 @@ static const char stm32_adc_ic[STM32_ADC_INT_CH_NB][STM32_ADC_CH_SZ] = {
 	[STM32_ADC_INT_CH_VDDQ_DDR] = "vddq_ddr",
 	[STM32_ADC_INT_CH_VREFINT] = "vrefint",
 	[STM32_ADC_INT_CH_VBAT] = "vbat",
+	[STM32_ADC_INT_CH_VDDGPU] = "vddgpu",
 };
 
 /**
@@ -170,6 +172,7 @@ struct stm32_adc_vrefint {
  * @smp_bits:		smpr1 & smpr2 index and bitfields
  * @or_vddcore:		option register & vddcore bitfield
  * @or_vddcpu:		option register & vddcpu bitfield
+ * @or_vddgpu:		option register & vddgpu bitfield
  * @or_vddq_ddr:	option register & vddq_ddr bitfield
  * @ccr_vbat:		common register & vbat bitfield
  * @ccr_vref:		common register & vrefint bitfield
@@ -189,6 +192,7 @@ struct stm32_adc_regspec {
 	const struct stm32_adc_regs *smp_bits;
 	const struct stm32_adc_regs or_vddcore;
 	const struct stm32_adc_regs or_vddcpu;
+	const struct stm32_adc_regs or_vddgpu;
 	const struct stm32_adc_regs or_vddq_ddr;
 	const struct stm32_adc_regs ccr_vbat;
 	const struct stm32_adc_regs ccr_vref;
@@ -728,6 +732,7 @@ static const struct stm32_adc_regspec stm32mp25_adc2_adc3_regspec = {
 	.smp_bits = stm32h7_smp_bits,
 	.or_vddcore = { STM32MP25_ADC23_OR, STM32MP25_VDDCOREEN },
 	.or_vddcpu = { STM32MP25_ADC23_OR, STM32MP25_VDDCPUEN },
+	.or_vddgpu = { STM32MP25_ADC23_OR, STM32MP25_VDDGPUEN },
 	.ccr_vbat = { STM32H7_ADC_CCR, STM32H7_VBATEN },
 	.ccr_vref = { STM32H7_ADC_CCR, STM32H7_VREFEN },
 };
@@ -956,6 +961,11 @@ static void stm32_adc_int_ch_enable(struct iio_dev *indio_dev)
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
@@ -989,6 +999,10 @@ static void stm32_adc_int_ch_disable(struct stm32_adc *adc)
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
@@ -2681,6 +2695,9 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
 			case STM32_ADC_INT_CH_VBAT:
 				na = !adc->cfg->regs->ccr_vbat.reg;
 				break;
+			case STM32_ADC_INT_CH_VDDGPU:
+				na = !adc->cfg->regs->or_vddgpu.reg;
+				break;
 			default:
 				return -EINVAL;
 			}
@@ -3192,6 +3209,7 @@ static const unsigned int stm32_adc_min_ts_mp25[STM32_ADC_INT_CH_NB] = {
 	[STM32_ADC_INT_CH_VDDCPU] = 34,
 	[STM32_ADC_INT_CH_VREFINT] = 34,
 	[STM32_ADC_INT_CH_VBAT] = 34,
+	[STM32_ADC_INT_CH_VDDGPU] = 34,
 };
 
 static const struct stm32_adc_cfg stm32mp23_adc1_cfg = {

-- 
2.43.0

