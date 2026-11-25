Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795623232;
	b=hlYl+9OKfNdDwCE1EesOwsKqWvhmHeU6inO6iJ19JxA+ArhtmEhHCi4ZUCWWHtHMzk74
	 j64QsKaBsKEZ/mPsb7Uh+vv1EGmhc9C75RFQ2YS3bIZ393n/vdGDLNIgt1qUhXjH1CfMq
	 N8ydwSYWEDBVvpRAMJlJqwM+NshwVxz0MJffWlzkGVl1QLHSpPHRS7jhRO839ZsXkEJ5R
	 CSIF9F3G6krZfz3Hn9JGWrFaT7zOwavkJ2MhfDPzsHmBQh3Xr8VNg8Xz2lO4Mktt7wENJ
	 lZb3e17OtOP7aQIJHmM74ZUcRgTuHjvhN9K2UgSPDmLWBpvdHpO1E2TFUjDMUutSmuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623232;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pJ3jiXjc0dbtp1gpHGxkuxTP4xnJ6p2qseuosud8wjU=;
	b=nUMKcU7QNLcVE60v+sO8wG4cqq++Sd37eoCaWZ45WnhMQKlnqhfuiE7wNnYkrgakgIxk
	 nehTm9FGua/6DSSrg7XgSgfoihFJ5i0+vNbK+Wb6mx7QQKkyNk9uc7KQ+K4XiZ4wyKMPk
	 zN99am2T6pGgLyztilSj7ZURnBVke6VkIQBfRBxpfgMXmCvoi0f9ECvAIl/elEGyHbJWV
	 /l6gNC0zxROpVuT16gdmYeWSna+o4tcAERemrIzjclOaOgKg4Yv2/Ug/kAm9A70bi1OVg
	 STHYZLzyuIuBgVzGQbew92GbF0btPYxQiZravB0ArkmLBgiQJ8V/3YOKiIFiAAx0lTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=doebPFNN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.44
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF26606A321;
	Wed, 25 Nov 2026 16:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EF26606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=doebPFNN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QU8vWYO49ODEYo3SZLB3jrvs54b8Tzz7eU1sbiGqqIxSB1enltqQQZiJAC7LE4Me87fCQYH43wkvX0QypgLv/qk2DredOA6E/uyk0UwPP/fX1yaDBhrM/XgEI+aLoeqxdZYdwwt9bCfVm4RZ+9JScCM52S02f+wsTu5t7TsA/FyfKCOCPj8y+aS5BgjicJIGvVcRbB3kW7u07imjpw87g5i3K6YXk1KcRxRsFF4FxNk89bJmxnZ+qS32N3hkFxubLucaXrEgL+UnJ0+9ur4h76j4KIdON8ljpII3Oe5D2DQd04Y9Fr+cwSdtYsaqXHgFbBVvJZpiovW1EWrtOAyhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJ3jiXjc0dbtp1gpHGxkuxTP4xnJ6p2qseuosud8wjU=;
 b=ZlEcpCZhsvUcq4UdhELKMXa31UH33O4NFWZGk/psjHDoF6xVV5aWHLFLK7ajV8o3p5YhLg6QTNB1lr5DFvxC+wH00betoxzEB1yDtNrouPrhwTD7cLYu5fZX8liEcjZZ0zmdT9gwT4qYFdtBAi9dJYUE6PhLZ/3NGGO8Iya+5cbTNmF2mpTZrDltIfuCcMVJBknFC+bc4e5HVfWBV6G1fJu1f7pZnIozohHqfe0DcwNG/hewSefChNyizFCRw25KbjgA0JX6I5Lk/PqmSq0awEREK3x2UrefOhlbJ6Hh8MvftT/OMSxWihxtCoTDLtkQIKdJ6srmBOwiHsE+WuNx2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=teslabs.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJ3jiXjc0dbtp1gpHGxkuxTP4xnJ6p2qseuosud8wjU=;
 b=doebPFNN01sLtM9IAGXYBwlyA1V1C7t0zDp7AaujRBgtCIJkRVvNIxosqGl+M1KQCrRvpUQzz+MPmUIHYXpX7M820et+hnb5DbJmA8WLBzNkHO9dCFI5XtgsPO4EFWDbtN568rsbdL06bjq4Vr6btMu5A/C8jRqr+XFm5tyS6Js8JlRSqfYAo0CwGBcW7HDJWXqR3hGLlm7APEm7HkFP1pA2Ctk1vySFO0FOQ2ryxZroZ7aUeeqaJoqqOeQGGHKS3/cO8QDTgsrs+Ewkn42LhzEvvH/0FYPovvnHSm/zTzB51dRgwZSeoiLSYxpJz2dIJbSjRpQkvbnjiqr4TwJyDQ==
Received: from PA7P264CA0279.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:373::20)
 by DB9PR10MB7292.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:460::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Wed, 25 Nov
 2026 16:13:47 +0000
Received: from MI3PEPF00008559.eurprd05.prod.outlook.com
 (2603:10a6:102:373:cafe::1a) by PA7P264CA0279.outlook.office365.com
 (2603:10a6:102:373::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 16:13:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008559.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 16:13:47 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 17:14:42 +0100
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 25 Nov
 2026 17:13:35 +0100
Message-ID: <40e3077d-8562-4340-804a-43691b62a9cb@foss.st.com>
Date: Wed, 25 Nov 2026 17:13:35 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: adc: stm32: describe the STM32H7 temperature
 sensor calibration
To: Gerard Marull-Paretas <gerard@teslabs.com>, Andy Shevchenko
	<andriy.shevchenko@intel.com>
CC: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <andy@kernel.org>,
	<krzk+dt@kernel.org>
References: <20261124202220.23721-1-gerard@teslabs.com>
 <89f43760-01c7-43e8-9682-b7363ffc931f@foss.st.com>
 <20261125135500.5306-1-gerard@teslabs.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20261125135500.5306-1-gerard@teslabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008559:EE_|DB9PR10MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb68775-971e-4be4-74a0-08df4b0f15d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|261026121527099003|261026140227099003|261028144727099003|261022105027099003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003|261009223027099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	HDjSsmBTCYu+lA6UoTfO1zKGJhPnA+BCpPWOME7tRmqdH02wCvtGvLR+YeVUsQIBebpSNevJ4Y88eCz2udtoZJrH6IV9d46yMRNE+N9DR+UjMIWPRWuekb3XBM2aKr2W9U9A37ico37bCPdbael5eQziuD9KgnYSs0GMEzEAKBATmAYvrd7bMdlefoqOzW+FQAz/dJHGsJomiiigG0nWtSf3g8EBYBvbrrp7aosRNvOw7nqVEC0yeF2dK7vZNzX/C39Dvb5KG1I023mlgD07VjN5zxo88x5o33g3HSvwRcL+ljdcmbt7O9vKV9rMgjyPI8KvXG2ZOPilk3yKPpnsG1/FXK6dCRyCzjUJIdHVXqcXoIEN3SZFzi70nwiopaxf5Ejbtz9BcWfkeuw72CTTyGcxzYMAGTrkRcAUmK2j2IghFLy9UQ7WZ6cDWXHyRYSONj5uT09NGkPsKGFbRmhiHIucyvSHv1/gIL8YyynvgsnmX9TxJzdJqMdG8w/F3Q/+GmA/0xz0bK/qD3USGUPW8BfSXv1k4MQA/1ehX+Ab7QhC1VIt5/jSXeq+s9LQdxtias8TJgqHPENQESJatvuf2aPhqFG9A/o45peqQEmfhOOlw+b0DAQTzzSRE9hMJv8DkY6GDVML76mvHekaJZW8ui0Rbb0+XRrzk5x5w1GWAOE=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(261009223027099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mhRtbMUyRb/ctrbKAEaqpd0QBWFCHMmZriuQ9bWf4lhffRJym+u6fSFAmA75Urm9tj3cWeY/GzWlURQ0tgHlhdSzLbc+8yCWL9/ax/K9u+GmNnq2A0ch9JGCJe7MWtqx6nUXvSehajS0hrikKiPcJBTT7HEYJvX5A10F9R5ag+VszKyk1hq+xq6LzhZQiGzC580xmXCO7gnjlmmmjjhlNE/jjYsGQYJ97sWyO9j+dTe/XU21u5Xbncxb+hDFKWwI/8G+FD8qOVOreCM27Udw3bEVSoRVinaTY5JJMr9WyCeIFFr8i9UKRMbgNKB7ISSvwSSafGN+2dIMMG8/NqiWjO5LAcdUpi+Wt1bK0MOFkypKyPJHfzTJErgstFDpjT/HtCvaCbXe8yIGl1spuaEBVtL9Hee8TW+Cq3s0s1qkXXtg4aCPAjZNv0E4dkmkPCBy
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:13:47.1957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb68775-971e-4be4-74a0-08df4b0f15d3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008559.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7292

On 11/25/26 14:55, Gerard Marull-Paretas wrote:
> On 11/25/26 13:56, Fabrice Gasnier wrote:
>> The DT is deprecated and are going to be removed [1].
>>
>> [1] https://lore.kernel.org/linux-arm-kernel/2afd5f78-0174-4955-8c1b-be18aea3800b@app.fastmail.com/
>>
>> So I'm not sure the dt-bindings update is useful.
> 
> Hi Fabrice,
> 
> Thanks, I wasn't aware of the removal. I'll drop the dtsi patch then.
> 
> The binding itself stays, as it covers the STM32MP1 ADCs too, and it is

Hi Gerard,

Yes,

Well, on STM32MP1x, there's a dedicated "Digital temperature sensor (DTS)", used
in Linux for thermal protection. Hence the ADC based temperature sensor has not
been pushed/supported here, as ADCs are usually kept for other usage. I don't know
of usage for it in Linux currently, I think it's quite unlikely.

That why I wonder on this is useful or not, w.r.t. stm32h7 dts removal.

> used outside Linux: PebbleOS describes the STM32H747 with it, so the

I don't know PebbleOS. Just for my own understanding, I guess you're using kernel dt-bindings
to validate the external h7 dts ?

> temperature sensor calibration cells would still be useful there. Would
> you be fine taking patch 1 alone? If so I'll send a v2 with just the
> binding.

The binding (patch 1) seems correct to me, also regarding STM32MP1x.
Just as mentioned above, I think it's unlikely going to be used here.

I hope others can comment, on taking patch 1 ?

Best Regards,
Fabrice

> 
> Best regards,
> Gerard

