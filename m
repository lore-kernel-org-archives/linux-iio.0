Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795015097;
	b=NOvfRePmvtLiIn24UIgkpFrVdeKx6FWMxCrGcFwzlSCygn8bQSbBk0OEwSKVqfvJpJfM
	 jX0yk64UL8BQMKuwK5Rjt6e+cT5lIUOBnTfgbCUv8hPPWbZ8zYE8rQr2ftz5TgAg267C1
	 ee5bkfNtQdPENgOsvIeNc56U8K0KINChgBpdQtOCIeT+KaWQfqyE3yUDyylCoOnUx/5CA
	 kcHb9kHbvm5pgpKsNa1jhJUm3rNwaZXNDgAFhk9vY2RTSJvINOzQDzG8zhrFZuaotxk7a
	 SegjwYxD9rrkBh/bqNX4ZvSdB5fklFm5axCHbe+q5s4YjPjgyWyWIFNlppSoM4qrWQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015097;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1FcxbgvYLfQV0y+oN9uytRNXBXddDBOGdoIc3f1iHhw=;
	b=l3CX4ELyzfWB9geSTWN+9E6H+NysLaLPmPQO1pzzZfNZbOJzUkN4IiKbQ/gVs4ZAvleK
	 nOOP3RV/LtUaPAW2bnH8pvRWMdtzj+OL2vAERUyqDla1cLF/Oj2faAoVKnthpgPD89L6Y
	 v/L30msQpsGUXrkOCUn5O4OJL/fkCEs21NI3PH7eUtRtLNscmOQNeHZxijVwdPXJLRHsv
	 KCjr65EnP8JsbXdzil54IVCLSgjQAuBQ0ILpTducNLeQ1ammLgEkSBN1frR7vr8m3TtwO
	 BujSJMxLjxAfZsPajHawIt2ACZvn3Gd/FHzeTDapGUc0V6iHUKxtJ6qGheapCIcqQmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b="dU/uF5uQ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.14
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B6360A260D;
	Wed, 18 Nov 2026 15:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02B6360A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=dU/uF5uQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUNI0hH48v+ymIGMg0BmOQS0uxwoB6qbTqR1M9K4cZpJ2+Obp+PJBwds3IHqL8A0BGcK5bhjabuWCIk7n1+1wFwPw9/8pzGK3jZ4voLa8tCHAmgSaV6+AOW+iNthJHxnK34inctAX0uV6IC8Vy2g0jNIZfTWH7QLwe9Yjxvlkef21Z0s8Au7veSf9SKmfA4pZ1lb5x7PkXjZmd9MnAm2Alu/31h0WoMjtnklk/d6kQ9R4V31dmygwVwB7hm5gGLYZZzsP66IiIJvTdLHx2BUBaWRG0H5csuM3r43+FlXRwYhqOKuNdGxK6ClazlMQcsTyzfEnCSqk2x2NkwNEujOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FcxbgvYLfQV0y+oN9uytRNXBXddDBOGdoIc3f1iHhw=;
 b=K6wKXQY6MGfd7Ct/foq79gSrQJ6tHG0zclJG8ANVIa6+5XIGOS7r7EtQPS3lBMDNxrDnifh0vP5c38bWZa8hjcXPMaV06e5AsM4Ed8L4jBxzX6FQ+JqUcmv2wa9fmjBM0PzNE4n4vbaacxwN4DeJzWzGuIFZ9gHbUf6MAZoEmmwAATqnbQ7LVTU8euM/AfCGvE3MYwKnOU9bM5oDdvzl3rmdToT3/RQs8H5oC8wVGEqSnsAoRCi2cFfKXOutRy82I8o2sBIa/dngeWFT/hwhnafQ8gqkYwQJhM1CJaUGPmwdBQXps5MjU1lE1Agrbf2NTM/ZX7SlArjQQcXR/rfpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=amd.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FcxbgvYLfQV0y+oN9uytRNXBXddDBOGdoIc3f1iHhw=;
 b=dU/uF5uQWPZQYHecXv7cWDuLegSYddlcVpuHEmH3nnnjsWDxqT/eHhCiqvazbcl7NyxQbSGKQFZHVHCGfHw5lPpblQzR3N0WBuUe7freHVgIqfRuLuhgrOJNyBnQUUY/g/swPuRA5nTg1yWJME4vDiv2Lt0ScYc+nMt0KmEpJNutMnEEk0ZWpYRH8IOe3tskozyCmPqtRFA8EazfBY+9zPg+sEp8h2UYWpYBhskKQiI8ITyj7dH89lhKm7ORJxD7ynlI9Ovxp2nxSSR3kpsQWTKvufUuXHDgAP89Rt+6gFTR7YCN8bfUTRlb+TFnIePxm30dM7Z5+nquWdson1oP8w==
Received: from DU6P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::10)
 by AMBPR10MB148947.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:7b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Wed, 18 Nov
 2026 15:18:14 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::34) by DU6P191CA0016.outlook.office365.com
 (2603:10a6:10:540::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 15:18:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:18:14 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 16:18:52 +0100
Received: from localhost (10.252.16.78) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 18 Nov
 2026 16:18:07 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
Date: Wed, 18 Nov 2026 16:17:54 +0100
Subject: [PATCH v2 09/11] iio: adc: stm32-mdf: add external timer trigger
 support
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261118-upstream_mdf_v2-v2-9-7939d3c3720a@foss.st.com>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
In-Reply-To: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"Sumit Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>, Philipp Stanner <phasta@kernel.org>, "Arnaud
 Pouliquen" <arnaud.pouliquen@foss.st.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-sound@vger.kernel.org>, "Olivier
 Moysan" <olivier.moysan@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|AMBPR10MB148947:EE_
X-MS-Office365-Filtering-Correlation-Id: ba62b098-b187-4648-439f-08df45872a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|18002099003|22082099003|6133799003|261009223027099003|921020|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	kgVlENYs++H/2O9tkP7y38tOBU4xKFA2Wu/n56lMI+dqalPb/xdkeQZwaM0tnJeZeXYgWXULDiQ1Vt7qfWPzxG1SLC/dTg/UYdvC5EHp/8JdXw7sq9Ke08a/h57omK57Im+iSD6CZpPFE8dUT4+xeAiBHqe0Z5Wn5tduw/6CsGdCqpi72OgGm6p+jOCg/A6niU67LGVEBecd/kWD+QP7qH4UQVbnPO2B+LMMKNwD+QfkJnfYfYsRw/IldMU4TvBfIXtRX4Qs+yRkvggJVCY5HUZCHUNv9LVyXXVWyZoVMBzbYS5906UaqFbZzFW3wj2+2T530rhPRejeBqd51c2iR8R+4np8OLc+erFpiQBy1VZv40+gmp2TtWsu6QdJz0keDUmyRNpCH0KcyOqDK0mm+DhUjyb/bj52Xp3IunbbKc9hCRnQ016p9nBcJSWdUKYujSfSikRb6FAzgrs8FS4hoFcDb6Ev+PTXAGNkqSpqUlPPvMxgWfuYPJI63p5udZyiK4xGmsvFkwUN7ZroYUepGgdwvcnnoNRzLpD/ZpHJfLMpMqs9oQWShxGLwSKOWjfhhvX62cVP3s58Lje46/Vq1HxzfYhhme5Rq4pNbeOq8bila0RTH97F2Hb6zH7xQ1/E7A/s8v+wn05Kyu36J3IcCQ6GYwpVrcqHtHRmqojB6E9ERtU6MMP5zHU3JCUtLLk+8DxQmLAQeXkW/qfmDVgr4PRTHoq04RrV1aYo1EW5l7pd6UYVKhWXWUuJMDz6h4Vv
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(6133799003)(261009223027099003)(921020)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z5/3bkgLkCWpk1m8vBLTvJ9chlnnYlqAdTjPi6yhv4cb5EavlT9YftZH5BP3TFN/2M2bwjRO7KdktyCsWxVDjs1qEs0h5dTagDSkeOezEtXCjHZVn5ts31uZzsztFLsGagZCPuhdpGWHW1E3ix0fx3SRWORjRgb0nCJMetuLxuJNtslnlPY0frHVuzoNsjconpVr/7FM9+EAqWTSTmbNHMBYG16A4GFWp3yhMTryKFpIH4se7TMKH4HQbaOgoRp1cVsifNfWoptjQKKlh+XS0nZz+IaDbs2YvylOU2e2Mu0gFoMFMO56ja4c60A8oc+M/Due7TeXH8Iku7wBbcduJjtyHZ5eeoQITX+x9udyfTRRkqQgZKavHEhM1ByMvq0YSoXMjkPYDrT90lqF4rC+oCtDJwSC8UPpzxXwr412IeMByYlpvNdNPkeSPBhWE4Ps
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:18:14.0781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba62b098-b187-4648-439f-08df45872a44
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB148947

Introduce the STM32 timer and low-power timer trigger source definitions
and lookup table. Add the IIO trigger validation hook and filter trigger
source and polarity programming.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-mdf-adc.c | 108 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-mdf-adc.c b/drivers/iio/adc/stm32-mdf-adc.c
index 046ca3943a39..97099b4adffc 100644
--- a/drivers/iio/adc/stm32-mdf-adc.c
+++ b/drivers/iio/adc/stm32-mdf-adc.c
@@ -13,6 +13,9 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/hw-consumer.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/timer/stm32-lptim-trigger.h>
+#include <linux/iio/timer/stm32-timer-trigger.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/interrupt.h>
@@ -172,6 +175,43 @@ enum stm32_trig_type {
 	STM32_MDF_TRGSRC_NB,
 };
 
+enum stm32_trig_sens {
+	STM32_MDF_TRGSENS_RISING_EDGE,
+	STM32_MDF_TRGSENS_FALLING_EDGE,
+};
+
+enum stm32_trig_src {
+	STM32_MDF_TRGSRC_TIM1_TRGO2 = 0x2,
+	STM32_MDF_TRGSRC_TIM8_TRGO2,
+	STM32_MDF_TRGSRC_TIM20_TRGO2,
+	STM32_MDF_TRGSRC_TIM16_OC1,
+	STM32_MDF_TRGSRC_TIM6_TRGO,
+	STM32_MDF_TRGSRC_TIM7_TRGO,
+	STM32_MDF_TRGSRC_EXTI11,
+	STM32_MDF_TRGSRC_EXTI15,
+	STM32_MDF_TRGSRC_LPTIM1_CH1,
+	STM32_MDF_TRGSRC_LPTIM2_CH1,
+	STM32_MDF_TRGSRC_LPTIM3_CH1,
+};
+
+struct stm32_mdf_ext_trig_src {
+	const char *name;
+	unsigned int trgsrc;
+};
+
+static const struct stm32_mdf_ext_trig_src stm32_mdf_trigs[] = {
+	{ TIM1_TRGO2, STM32_MDF_TRGSRC_TIM1_TRGO2 },
+	{ TIM8_TRGO2, STM32_MDF_TRGSRC_TIM8_TRGO2 },
+	{ TIM20_TRGO2, STM32_MDF_TRGSRC_TIM20_TRGO2 },
+	{ TIM16_OC1, STM32_MDF_TRGSRC_TIM16_OC1 },
+	{ TIM6_TRGO, STM32_MDF_TRGSRC_TIM6_TRGO },
+	{ TIM7_TRGO, STM32_MDF_TRGSRC_TIM7_TRGO },
+	{ LPTIM1_CH1, STM32_MDF_TRGSRC_LPTIM1_CH1 },
+	{ LPTIM2_CH1, STM32_MDF_TRGSRC_LPTIM2_CH1 },
+	{ LPTIM3_CH1, STM32_MDF_TRGSRC_LPTIM3_CH1 },
+	{},
+};
+
 static const unsigned int stm32_mdf_hpf_cutoff_ratio[] = {
 	625, 1250, 2500, 9500
 };
@@ -365,9 +405,63 @@ static void stm32_mdf_adc_stop_filter(struct stm32_mdf_adc *adc)
 				stm32_mdf_adc_stop_filter(adc_inter);
 }
 
+static int stm32_mdf_adc_get_trig(struct iio_dev *indio_dev, struct iio_trigger *trig)
+{
+	int i;
+
+	/* lookup triggers registered by stm32 timer trigger driver */
+	for (i = 0; stm32_mdf_trigs[i].name; i++) {
+		/**
+		 * Checking both stm32 timer trigger type and trig name
+		 * should be safe against arbitrary trigger names.
+		 */
+		if ((is_stm32_timer_trigger(trig) ||
+		     is_stm32_lptim_trigger(trig)) &&
+		     !strcmp(stm32_mdf_trigs[i].name, trig->name)) {
+			dev_dbg(&indio_dev->dev, "Trigger [%d] found\n", i);
+			return stm32_mdf_trigs[i].trgsrc;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int stm32_mdf_adc_filter_set_trig(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct iio_trigger *trig = indio_dev->trig;
+	u32 trgsrc = 0;
+	/* set trigger polarity to rising edge by default */
+	u32 trgsens = STM32_MDF_TRGSENS_RISING_EDGE;
+	int ret;
+
+	if (trig) {
+		ret = stm32_mdf_adc_get_trig(indio_dev, trig);
+		if (ret < 0)
+			return ret;
+	}
+
+	dev_dbg(adc->dev, "Set trigger source [%d] on filter [%d]\n", trgsrc, adc->fl_id);
+
+	return regmap_update_bits(adc->regmap, MDF_DFLTCR_REG,
+				  MDF_DFLTCR_TRGSRC_MASK | MDF_DFLTCR_TRGSENS,
+				 FIELD_PREP(MDF_DFLTCR_TRGSRC_MASK, trgsrc) |
+				 FIELD_PREP(MDF_DFLTCR_TRGSENS, trgsens));
+}
+
+static void stm32_mdf_adc_filter_clear_trig(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+
+	regmap_update_bits(adc->regmap, MDF_DFLTCR_REG,
+			   MDF_DFLTCR_TRGSRC_MASK | MDF_DFLTCR_TRGSENS, 0);
+}
+
 static int stm32_mdf_adc_filter_set_mode(struct stm32_mdf_adc *adc, bool cont)
 {
 	struct stm32_mdf_adc *adc_inter;
+	struct iio_dev *indio_dev = dev_get_drvdata(adc->dev);
+	struct iio_trigger *trig = indio_dev->trig;
 	u32 mode;
 
 	if (MDF_IS_FILTER0(adc)) {
@@ -377,7 +471,7 @@ static int stm32_mdf_adc_filter_set_mode(struct stm32_mdf_adc *adc, bool cont)
 		}
 	}
 
-	if (adc->synced || MDF_IS_INTERLEAVED_FILT(adc)) {
+	if (adc->synced || MDF_IS_INTERLEAVED_FILT(adc) || trig) {
 		if (cont)
 			mode = STM32_MDF_ACQ_MODE_SYNC_CONT;
 		else
@@ -977,6 +1071,10 @@ static int stm32_mdf_adc_postenable(struct iio_dev *indio_dev)
 		goto err_dma;
 	}
 
+	ret = stm32_mdf_adc_filter_set_trig(indio_dev);
+	if (ret < 0)
+		goto err_trig;
+
 	ret = stm32_mdf_adc_start_conv(indio_dev);
 	if (ret) {
 		dev_err(&indio_dev->dev, "Can't start conversion\n");
@@ -986,6 +1084,8 @@ static int stm32_mdf_adc_postenable(struct iio_dev *indio_dev)
 	return 0;
 
 err_conv:
+	stm32_mdf_adc_filter_clear_trig(indio_dev);
+err_trig:
 	stm32_mdf_adc_dma_stop(indio_dev);
 err_dma:
 	stm32_mdf_adc_stop_mdf(indio_dev);
@@ -1006,6 +1106,8 @@ static int stm32_mdf_adc_predisable(struct iio_dev *indio_dev)
 
 	stm32_mdf_adc_stop_conv(indio_dev);
 
+	stm32_mdf_adc_filter_clear_trig(indio_dev);
+
 	stm32_mdf_adc_dma_stop(indio_dev);
 
 	regmap_clear_bits(adc->regmap, MDF_DFLTIER_REG,
@@ -1377,6 +1479,7 @@ static const struct iio_info stm32_mdf_info_adc = {
 	.write_raw = stm32_mdf_adc_write_raw,
 	.read_raw = stm32_mdf_adc_read_raw,
 	.read_label = stm32_mdf_adc_read_label,
+	.validate_trigger = stm32_mdf_adc_get_trig,
 };
 
 static irqreturn_t stm32_mdf_irq(int irq, void *arg)
@@ -1485,6 +1588,9 @@ static int stm32_mdf_adc_init(struct device *dev, struct iio_dev *indio_dev)
 		return dev_err_probe(dev, ret, "Buffer setup failed\n");
 	}
 
+	/* lptimer/timer hardware triggers */
+	indio_dev->modes |= INDIO_HARDWARE_TRIGGERED;
+
 	return 0;
 }
 

-- 
2.43.0

