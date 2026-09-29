Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6EF4EDCBD;
	Tue, 29 Sep 2026 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700521; cv=fail; b=JWB4Zqp2Aqr1hQ8pYX3zjwtoYXB3WPp24fi/TeNJaUszqFKiZLhmM5ZrcedzeRpkZutHnl0iBe9hK+z7r1hu4RPsd2COmrpyAzRo7wf2J/hTbCvSaM+01XHwyNmuPgjmBguZeaYFmEL4bNF4uWM2yIoP0XpXbfX1zac7caIfFto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700521; c=relaxed/simple;
	bh=L1RbcKvRIlD8k2Tb87GuL3PsU2yl4fVWmZyHuIsD338=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=O0gjqcnCymFG4xqJDecByX9FA7IK6ajPN7eYQBKEbtTNGyKcDpDwTEx7HHbyRmGrk+J3p7odXl31zgGOba/rh2dSzgx6w6g0fMT7KsBKlcb9XfyvReRpvzr7inemDDRf9ixWz+BrXai/dN/32s5XIqj6HiabmrW7ZDY6l/P55yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Diu/bvU/; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Diu/bvU/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elgdYpTdat7HWmEscyvKJbOnHn03sxu7bocoWvnCiP0PeGnEAU2uQwLxxEdGvbtM0aOZ6O8YTbhoQXM+KiGRw2AgAUIGgivTxKTIHkD0vwJs7zGKJwpR3J6s3kzr/ZdhgFXuFCnrlXk72/C2SXOmB4lzIm5R1iaT+Tkri70Y40XD8e1K1M7GJaklKdd89szUKRHNzgeDkzp5g/tiieQYnBSXH8r2eMkAB77wPDANMnmjYz5qCn+rpFit5JHJBh0gIANm32p32Z25kPaMAgwUzz17zHDvdYCovbEAVRkx9qud9M+xm/D8nys8lYMZ05ZgFXgG8alQNPO1gR7M5IXAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8EcGFG35fUvCgI3SEmlpZItRnkF1dPhyJLO4GABlxk=;
 b=LKVIxvzf4lxHWWH+UZpdMjBrs8QzjlIt608Bx0EBJLnRMCyiPQN/+5CnAUUBGerJo6N2ik9EkxHTH8UhOdAQMtOzdLUYe7/g2JNsV1J9A0LXmB/bgjDOvM2jhgqmppcfHXBXJcvHPoTN2bljgbjt5LqP6NsOHnfQLr8PrgLOCMq5Xu8xha8iG9GQfvs+tRLw6Pql67lAAI9sNbXWqzzeBu1Pt4GPA5oz1gssNvf+9kOuuVa32sQaDfoT0DMvxgQ6fSFEnMVsh8ngwEwaG0kD+jir8q1CwQ0OoqrR4ZdlVUOLyWk4w0+7NaLCNWk1+GpqdvOzEnBdxV71jdGtGNifDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=intel.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8EcGFG35fUvCgI3SEmlpZItRnkF1dPhyJLO4GABlxk=;
 b=Diu/bvU/6BbvJFjFsFnseqC4G8NB9Q+PJ3hZ8599RKP+1PT/86veLFZA/yDbAISXXOLQ2UkS8xE9UV3+3j/Ay9bE0dX7dU7of+macupNgGvEAlSbGk8DudjteH2Q9OAX6+4wHdpOV9b1iS5sjvQKwI6Dzui2bcin5SHR2UCr8q1LRn7yxM6qnPg97+wh6hxZeU4TQQz9mX7RA79bxWv4q9ZCiUi7N2pVZ5Cxw+QZqgo4sx/9/VIl5i8RNT1ref5AXafy5V0ce2a7xmiot8LzuI61MAwMfBzd02rWprAD6tiTBKPEHTQ3QTVQqdvHPLjfyHmGn3iwc+j/qVPEJyMMng==
Received: from MI1P293CA0006.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::16) by
 DB8PR10MB3291.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Tue, 29 Sep 2026 16:48:31 +0000
Received: from MI3PEPF00008485.eurprd02.prod.outlook.com
 (2603:10a6:290:2:cafe::23) by MI1P293CA0006.outlook.office365.com
 (2603:10a6:290:2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 16:48:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008485.mail.protection.outlook.com (10.167.240.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 16:48:31 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 29 Sep
 2026 18:54:23 +0200
Received: from [10.252.17.140] (10.252.17.140) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 29 Sep
 2026 18:48:29 +0200
Message-ID: <8fd19ab1-6ec4-49d7-aadc-accec6e71410@foss.st.com>
Date: Tue, 29 Sep 2026 18:48:28 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v2 07/14] iio: adc: stm32-adc: add support for stm32mp25
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Marek Vasut <marex@nabladev.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Cheick Traore <cheick.traore-ext@st.com>, Olivier Moysan
	<olivier.moysan@foss.st.com>
References: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
 <20260923-adc-stm32mp25-v1-v2-7-46bc019537c6@foss.st.com>
 <arWPjx-JKt1IZCZl@ashevche-desk.local>
Content-Language: en-US
In-Reply-To: <arWPjx-JKt1IZCZl@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008485:EE_|DB8PR10MB3291:EE_
X-MS-Office365-Filtering-Correlation-Id: bd34c4bd-5e74-4e0e-8bcb-08df1e497e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|4143699003|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WEU7xC9g/yLvCwYbqaMp8wfrMWeDQLe5VcSPqANHxwtoPXFVKOq6c38gcZXyp8wuSqW6K1BZwp5iWHIPE8mzb1t3wzw0+pHFNeHFOxn0gRy2epVMctFkQmu8b33ClhHreQ1rGUVZuo8poFOJXyFUGheR14gCiY9x6/w+/jwQjw1yYoSohfJdzVDgnjjkUvIsXPHzRlDxYS5LmU/YQPxxFe0af6mCpK38h2eVnvelkHi4k49lXTxS0hwi4k5Q5bTSybELawucv9A4oG/cnf4TuDpB6rQIWi1+UxPExB86J8XcX3TtRknb1wZ+NyB/r01RXK0F0420jFOv9N6IgvvQb+p5hFR2RUSnKpylmhp76UozJm84KCCz3rLhw98XgrT1DQSoRbT0POHarVvIG5S/6UfsQfeTaM7BRdC7CmTgeRpLxHSUqHrNc2Yph3PG0NIAAns0YWQAxQgfvsPW/gpz75LNDvR6oHyeQQ7UyJYwNtXM8RPBF0bPLucG5+FVFMo5PTAUW79AwzN656HSUUTKihtR/X4lER1XlWra7LOL4zGjyo0uSpoVGJTN5eL9CnWL1H1pYo+e89bigPr5iythY4iwNlev0V9dTUO6whGQuSr9RYPhSczfHeNOcn5rTwpWefpdoFpVNACW5wAvA9OhP8r85dHXH6ER2VqoQq///6JxTRu+ZYVlVJRVkXYk1spOkatyXjj83Gzfh+aTgW/1uw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(4143699003)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y19eOb2BbZH5UEQiZkRbc+S55S+X7z8ayXfLuJolJxWPyAmA0Z46TMtP8xnFP5HmKO96OpIpJG9sn5oykxMjOVkO5hBHGEJzxbcD61PrZ9JNGJYfX1k/qrCO8q8TG43q+FSEliklBTdIMKuBvwUfQbLgSbR+Yv6M+UrWdymeytEAzRKyl97JwMtWzHGqxh5FksaLNY4DkKipF/pIMvVrVitdDANILH2St0XudoG6FeKihWzUYCpjT3QRhP/+0oFSrM5YekMXr3wWgDAMWUkbASopanHY9aUl+EOOtT6UNl2ljmdE4TglnZ6C0Rliol9gvCWG9QZqQbz8iJ1eaZ1OIJxZOxhYhs6b0RCWyijsf8h9Y2hmSo9DQ3ko+Ecyc2j95D0jHl2oVAiNQUXnwwy5sRYzKoF4yT9+bw98HwTrH3gqQLzxbZ8MBYMGFJGPaznh
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 16:48:31.2892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd34c4bd-5e74-4e0e-8bcb-08df1e497e80
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008485.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3291

On 9/24/26 23:01, Andy Shevchenko wrote:
> On Wed, Sep 23, 2026 at 05:39:10PM +0200, Fabrice Gasnier wrote:
>> Add support for ADC on STM32MP25 SoC. It has 3 ADCs, split into two blocks:
>> - ADC1 & ADC2 are tightly coupled.
>> - ADC3 is managed independently.
>>
>> Trigger list slightly changes between these blocks (ADC1 & ADC2). Other
>> differences are found on channels interconnects (similar between ADC2
>> and ADC3):
>> - ADC1 is connected to 18 external channels + 2 internal channels
>> - ADC2 is connected to 14 external channels + 6 internal channels
>> - ADC3 is connected to 14 external channels + 6 internal channels
>>
>> Each ADC is a 12-bits successive approximation analog-to-digital converter,
>> with up to 20 multiplexed channels that can be configured as single ended
>> or differential. ADC resolution ranges from 6 to 12 bits.
>>
>> It introduces diversity regarding IRQs, clocks, software calibration
>> procedure, internal voltage channels, sampling time (prescaler) and
>> trigger list. Most of the architecture, and the driver engine remains
>> similar. So, handle the differences w.r.t. other STM32 ADCs family with
>> a dedicated compatible and compatible data.
> 
> ...
> 
>>  		.compatible = "st,stm32mp13-adc-core",
>>  		.data = (void *)&stm32mp13_adc_priv_cfg
>>  	}, {
>> -	},
>> +		.compatible = "st,stm32mp25-adc-core",
>> +		.data = (void *)&stm32mp25_adc_priv_cfg
>> +	}, {
>> +	}
> 
> Same issue and now it's a regression from maintenance perspective: you added an
> unnedeed churn that has to be handled from now on... TL;DR: do add trailing
> commas to the non-terminator entries and remove trailing commas in the
> terminator entries.

Hi Andy,

Do you wish I add a separate cleanup patch for existing match table ?
This can also fit into 100 chars line now:

static const struct of_device_id stm32_adc_of_match[] = {
	{ .compatible = "st,stm32f4-adc-core", .data = (void
*)&stm32f4_adc_priv_cfg, },
	{ .compatible = "st,stm32h7-adc-core", .data = (void
*)&stm32h7_adc_priv_cfg, },
	{ .compatible = "st,stm32mp1-adc-core",	.data = (void
*)&stm32mp1_adc_priv_cfg, },
	{ .compatible = "st,stm32mp13-adc-core", .data = (void
*)&stm32mp13_adc_priv_cfg, },
	{ }
};

> 
>>  };
> 
> ...
> 
>> +	STM32_EXT23,
>> +	STM32_EXT24,
>> +	STM32_EXT25,
>> +	STM32_EXT26,
>> +	STM32_EXT27,
>> +	STM32_EXT28
> 
> Same issue and so on...

Ack,

> 
>>  };
> 
> ...
> 
> Are you doing patches with an assistance? LLMs might have a problem with the
> style issues.

My apologies, that was just me between the keyboard and the chair.

> 
> ...
> 
>> +retry:
>> +	/* Clears or set CALADDOS (also clear old calibration data if any) */
>> +	stm32_adc_writel(adc, STM32MP25_ADC_CALFACT,
>> +			 FIELD_PREP(STM32MP25_CALFACT_CALADDOS, *add_offset));
>> +
>> +	ret = stm32mp25_adc_calib_get_average_data(indio_dev, &average);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Add offset and retry single-ended calibration if the averaged data is zero */
>> +	if (!average && !*add_offset) {
>> +		*add_offset = true;
>> +		goto retry;
>> +	}
> 
> Refactor to avoid a label. It's possible to achieve.

Ok, I'll refactor in v3.

Thanks for reviewing,
BR,
Fabrice

