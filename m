Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013002.outbound.protection.outlook.com [52.101.72.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47342AF85;
	Thu, 24 Sep 2026 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244189; cv=fail; b=eKg6/l8OWPMv/EO2H5C0LllVARJE6ZhyLsWDPr22X746Noo8Jm7ttyH9YFHk1owm2EGq+Mb8kZ0omqrXDEqlAZajvJOfV5Gnj3p3BV1hRHogOyX72Niz4PILKvpk7YLtzZmvEEHaDWrDuJjXLjPBhTnEzPeEgEolOwM5rAxmzy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244189; c=relaxed/simple;
	bh=73iV088va7Mg7D+g8ARx2GYA47lgVZUqj+0KM2z2DJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZNio57EGJ2aWzoTfpkXVg24zw6JLX4mBCvgfNnGGLYG7dquB5if6inkR0G+6NJTTsKuiPFMiCv8fXRW4KASf1rn38nUBZGXoFyYMA8g+L4xLCQ2s334jgcBYLCfAHkL5Ox35LHa3ZjdU62ZbWP4vBQ8mozh8Ute8/GJSVjc4N7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ecXCL09b; arc=fail smtp.client-ip=52.101.72.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ecXCL09b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eh3kwuGOBC1NrQ6hh/a8pBriKPqYFF2GP6IeuRgseq0qcypfKfAO4rZMxZGClcuZa91bB4pKcKj1dfObvGYC7zPlIMlOUgsTlKYRwpsxU3TbFuT+rQ4/m43YgsMJ3R3clTfiYMDcNGJC86b4y7uFFSzpVKeh77n8yjoiuGbyE7DCJ2HTOTzGFWRpE40NNoig/p6oXhkWe8fASlvkKF7fUHPrsvedFjyX7a7mzOeZ1utPgPWXS6mK3EYLsCG7dgehgLu/BWG6hyLw2A9tcLJ/MnSAyjvJFlt1hfxajB7D1DpmNWmEfuTrUjpZ6pHj/oSE8DH+lZ3Y9jSUFp+XiNTVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fspICiYhf6bOkPX3VdB3DM5eceotDOWCxay+2dEmLY=;
 b=xLSzzeXHrRNGRmDgpkNZ9+zLEGiupIcv9SGEIg7afbymddhwEtrhrqKrfUgWNrSAUj3zRki6hkHKDWBLndGkqRMihOWH+9MnrNIE4n8WuMxyg6y1WD885RvgGz8zOHFw0usGMumeOZEhqVNdZJoKdQ3dNesrg1ryyEjgXkdXqfrYgqiw7crSI+sgY+yZzN7AQrZvrRxBNidFr8FqLoTdoBEn/PO9FeSZr470Dk/4VjQsuIawh80xExZ8H/YzoSOaOUzMrPDcUcyJhQ++1ARyRoKwSk0setveZ4otfvcFB6GgBwJuYloQ4j0ElwtgjHKR2hof5AbqG7Z0OO+mrIAB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fspICiYhf6bOkPX3VdB3DM5eceotDOWCxay+2dEmLY=;
 b=ecXCL09byU//RL0rFb8DXN29tuZZhM9saYitmCaL3d6nWR7SeVXhMPlj2mBBgC1Tr1Vz1eP9zUn8pjJfH2+M+QDLS14bekhr+P70zzTbQ0U9xyU/tZwpcd1y8lS3ra8GRuYUfCM0Faa6N+PUYgrB8j9CgzAcDK10txQhfUdBcE4NafLc/kcYbnagYp0o+KYZKHENE5Req6RYaWTv5uYXAgD7BCyq02H3KS+RnDAGM60/AeYIZtMBwbY9Hn8yj6AnpCKs/1LXcriAUgnXxwy08qdyS5UFx9ZYTRlO0wwS6P3TqCn9VoY8eX+tVfIVx5FWV3pMSJIdEwIKmQ9JKaFfxA==
Received: from DU2P250CA0012.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::17)
 by MI3PR10MB9900.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:73::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 10:02:52 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::80) by DU2P250CA0012.outlook.office365.com
 (2603:10a6:10:231::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 10:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 10:02:52 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 24 Sep
 2026 12:08:42 +0200
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 24 Sep
 2026 12:02:50 +0200
Message-ID: <d2fe0f9c-190c-4359-8a91-cebe8a95693e@foss.st.com>
Date: Thu, 24 Sep 2026 12:02:49 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] iio: adc: stm32-adc: rework internal channels
 data
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
CC: Marek Vasut <marex@nabladev.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
References: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
 <20260923-adc-stm32mp25-v1-v2-5-46bc019537c6@foss.st.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20260923-adc-stm32mp25-v1-v2-5-46bc019537c6@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|MI3PR10MB9900:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d83fba-f927-4511-1d79-08df1a22ff68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7tI1xhLnRUU2MkZjSdgM1aF96Tux4eTlNIDFZ/p8Qwr6VrcKLPSCnO2lDcpbmdkTMZhfp9EO/ctXXj1Az/wclUU7ZC/VZuMvyB1pks4NhO8kPPlx1eIoxvgYVYsUOHjSw0fXlr070iHGrDHc3BsIZBMGUbAEen5CbK1Ckr0Y7wqex7Ka9fuIYJlYqcBmCTTvHRAtFbgqTbSgbyzZjQVW/Rg0EKUFsIFhJAaZqFyeDz/UEXaMYrq5rhWcvMWw4niU/MOpQKb9CYydpChsW7JNj8a+rTovIZKCfX8aU4LX1DLBBvik+kKicmuetqEHKHCazvtgISTJTItLmxXut5AoISNUY3nxDrJQtpq5SejZWAKBDnt7uk8y2ofeO7dZOB81ypoecY+oXcy077feIBtoOoOBwMsE2tJotyCGvbZ6LYKthSoC0vpdcFVk0ZiEzYpjxtlyRhQL9XHPqBUM3Q+tdkjOmyguyoLnG4uXQ2nBUFwjBM/wPg0uWZPhiUUvwhDg/ixPOeXubnBxtz/C8Bo7zq0VV/x0oMOskJUIdqcsQYOcctJmgLGk2vHdr2TJm509Kk/keHfYtM3wmmYL8fDERjSWcqRMY4LczOcY47qUXxyZfKWbSf9Crk5s0TE5nFeAhVJgUs6S33/9ymW9yTobhQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9DskYKj+kcGeJlr0+ggS7HP0aqh9tL5kTtEzNJCR6QhyPPeYXHNIlYP1sasG0DPJRbaeMNj0fOw7pzSNJ6JSe4A4ORAgt6mp7jkLnU8fvahnpYjyDb6hAotIjOZTd0LNLbiq9fOEOjs9HoGCLQFZQ7oOgq7H6kfUGjVzvfIJZMF7y7UnBsPqs1IqIKHxYfteTTWSJGIpmgdmtDb2eTOXEMwyMJIB5ey1rLkiGf/+VWc0Bg880xaq+NVqSdtQmyh7mfcMmE6tYOy7vL3GzLJ4kAGqiLmpJR2Thl8Z9kjSJi2qPvtSEIhVT2nt8Fja6NEwSA/uFO02F8+OPhNwBGRA9VXc4qT2u6gOmJdIWRFwKLgezogAy36fz/tdRvpbDvX/ZBOHKjtAh4x6DWoJS/VhkLFdqg/s07KdERc7tlmrGmyQI2/5rPGS61UJ5bjuqIMd
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 10:02:52.4886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d83fba-f927-4511-1d79-08df1a22ff68
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR10MB9900

On 9/23/26 17:39, Fabrice Gasnier wrote:
> Diversity in internal channels data array lead to have zeroed data.
> To facilitate addition of new internal channels, without touching
> all array initializers, only focus on exiting channels on each
> supported ADC variant (e.g. each SoC).
> 
> This also allows to get rid of static_assert() checks.
> 
> No functional change intended.

[ snip ]

> -static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 100, 100, 4300, 9800 };
> -static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp1) == STM32_ADC_INT_CH_NB);
> +static const unsigned int stm32_adc_min_ts_mp1[STM32_ADC_INT_CH_NB] = {
> +	[STM32_ADC_INT_CH_VDDCORE] = 100,
> +	[STM32_ADC_INT_CH_VREFINT] = 4300,
> +	[STM32_ADC_INT_CH_VBAT] = 9800
> +};

Hi all,

Oops, I just figured out I've mixed changes with a fix here. So, I just
have sent a separate fix for that [1].
It's been noticed by sashiko [2].

I'll wait a bit before sending a V3, to leave time to review other patches.

>  
>  static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
>  	.regs = &stm32mp1_adc_regspec,
> @@ -2760,8 +2756,13 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
>  	.vref_charac_mv = 3300,
>  };
>  
> -static const unsigned int stm32_adc_min_ts_mp13[] = { 100, 0, 0, 4300, 9800 };
> -static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp13) == STM32_ADC_INT_CH_NB);
> +static const unsigned int stm32_adc_min_ts_mp13[STM32_ADC_INT_CH_NB] = {
> +	[STM32_ADC_INT_CH_VDDCORE] = 1000,
> +	[STM32_ADC_INT_CH_VDDCPU] = 1000,
> +	[STM32_ADC_INT_CH_VDDQ_DDR] = 1000,
> +	[STM32_ADC_INT_CH_VREFINT] = 4300,
> +	[STM32_ADC_INT_CH_VBAT] = 9800
> +};

Same here.

[1]
https://lore.kernel.org/linux-iio/20260924-adc-fix-sampling-v1-1-13814954d8d7@foss.st.com/

[2]
https://sashiko.dev/#/message/20260923155115.20E4E1F00893%40smtp.kernel.org

BR,
Fabrice

>  
>  static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
>  	.regs = &stm32mp13_adc_regspec,
> 

