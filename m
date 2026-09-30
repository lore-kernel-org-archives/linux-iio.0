Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010045.outbound.protection.outlook.com [52.101.84.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407B419FA6;
	Wed, 30 Sep 2026 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757868; cv=fail; b=Y4eWlET8Pj9BeeXOsARJR2Ph3ilEM1trZGQnru079oSVHcGd3tWByVSMaELrc05sHCl2V7XTc8xmrE0XoPPptWOGQsTmqg0f5rf787VFe+3is7xHWzg0Qfdo79D0y5iKAJrZh8JBl1w+Iedn4MV+rIHVE/E/9bXB18FewTzg/oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757868; c=relaxed/simple;
	bh=PflQDzMZEc1gvmrKpecj8sX14ZRcpxe1LLCqHXe9xac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jAeXfa7o7VOAtsq7hd/GUGMXw/RTSnIT9ZUf2ud25Co/JHrHb8FeEcjIHxvS6flEnbjFuK74YwLF+uNFGl5SA11qeNUmRTsZsRv4yU6PxNF13ukFhZbtXIGpDWlzHuUsxdFyW32/1MBvnh2kZyYuqlnh/p0TkK69wya0attOKxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FmtwUqls; arc=fail smtp.client-ip=52.101.84.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FmtwUqls"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgXu4RB8RUxAraKzwVsx1Wr6olaM8S2Us9o7lyKgBMOgzx7dGjpainZRbTSGZeYWuNELZUAZQwQvWI92ZFU+3iZc6H8dRzvrdHwO+9UQ6G3lQI9bA6Q/J2tjzPqDSAA1pG1wUIUVoVjmNY0BKEDbcE0HTJbccrRvvUMJv2+9as4ST89qqDZH8Qu1tdMxpctHEkYSbdh3gFsWkecXG5XZ6+cVXaHYrG5O2Ws+YcOydI5kMwMfBHXfqg1r81Bcukvy8rfsiVASOXpeomGSHgMP8w/GfJmSn7jhpHWWtPm+YE52FKhDo0e5zcCeGpnrSGTNK9E2AWtzWRKiZPB+rB0z4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ9hptiZBGfXNR1HP8iVMghmS/PiOTs+/PvxakrVW2U=;
 b=rf2WVZZxL8xymcLZc4gZnbJGM66AaD9hzicyxjehCKRbaW0TgebRVMwmc9TDzmqT1JfU40aTa4o7aQY6vFNE13kA2C1aTisPgfQgpC+QHeWmms1FKdnedmRAU3nVDk9VY/xW1py3LCHbBuZQQY/lOgoONVi5q8yWdilx6nJ5Ip1jH01UbHDl7vq35Nv7yJTrVizLaSshAwadRNTxS0cKTskZCXSDefZ26qJlUdnsycsrS1RHXti2UwUkpGLfuyx6AQ39jX72XaXAYfakblk01qKnN5As6JbsnzHChPHfboHxmzfdZeUdt3nZrbpKxApgXBqm3sYsJqUB2EI6FgH//g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=intel.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ9hptiZBGfXNR1HP8iVMghmS/PiOTs+/PvxakrVW2U=;
 b=FmtwUqlscAUu6gw3uDFo1zccC9YAcGvXJItwvBa8jin4PT6xmyWeIiBSWg27OwUYWuByP9zytjM4xWa0ak4E+3zhMIFzLH3G7b9Cc4NNZCu7BPPAyqO6lyNpyP4It3SX5feHt0aLKG7ulEGAIg0/Ie3JbjQ7Z/iLt+GQIFgJiv1E3hbRgvzo/qs1ALkLjQYi+4PoxjdRF2k5z+Q3iXIIpdwabS6Le9LnxcaoOkFa+C8E4kd7GGUjVlxhKtuTr2W28tb7Mw4k4JLSfPSSzw3oTSxHzmv+HeCgDl+thnJIK5erYLxnesZf0RzRMjMN428vKFHszzjanE+CEUEzHMWyxw==
Received: from AS4P189CA0012.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::15)
 by PA2PR10MB8580.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 08:44:17 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::79) by AS4P189CA0012.outlook.office365.com
 (2603:10a6:20b:5d7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 08:44:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 08:44:15 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 10:50:09 +0200
Received: from [10.252.17.140] (10.252.17.140) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 10:44:14 +0200
Message-ID: <d83e2c8e-452a-4dfd-823a-624fe211837f@foss.st.com>
Date: Wed, 30 Sep 2026 10:44:12 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <8fd19ab1-6ec4-49d7-aadc-accec6e71410@foss.st.com>
 <arzJYg3cg73vYCOE@ashevche-desk.local>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <arzJYg3cg73vYCOE@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|PA2PR10MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc362fb-f33b-44d4-b613-08df1ecf0290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|82310400026|22082099003|18002099003|10067099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	ay78VrPWfi6fDeuIFtfgLhheSgs7rtQgMZPm18tI7pLw149L523/utPPolzUEFVg2oBR3l6P5GYqjdvLib7mdNXj+GKJttcdO8W0hDI7em+Liby2W6Ny+sv6TovLcFS18xeDirQNcjBfKzrAwc/zl9qaoQOqAaEzOfM80viCNsPl5hJyz+N5SBAn6kQEbOc/ILa015mIi4g1GrGpRBOrJpaS934YA5Gf6zzu6jbXWAc8zYYb6phftJQGGzdRUyVCvUMVPBj7rwK/zW66Bh02IObgHXDjeR/qbsvX2JHkmh6Xqk+JrNuNd5gRYC3ZR8CuuNtdM3SQYB3nr/BozAQ36iTzVWO8RyUhCsbljeQwsYcBtbCU2+lxHSPKWJZ5NBMtBWW6+dDWp8HmLBqMnxU0PLtmK+s5pSQo4czbj34IZ7z9uM9EF9Iac+B/TTvDTSZ6RtpjX/SE+4Oxk1/D6XI+4ee9mxSoYnDZhxtK/GHHd6Ef343ivuj7yU3UKgZQQJB3oLXGu2XSB8CfJImNVkrU5e4bYnL2uTquPxlfdRysiGacAnMmM9IN15PmriRXd8tJ5VVkBrJZD/vDuJYabK+rFrQDJKMwABw8y4NELL5FuIwBzmkwsaDU5F/+1Ejsai9KfXRDIS7OY+ryB0dd6zN0q3ubP+x9+l375grigZry+cxuVE97HIA4MYH6D1wLPzOtS6JDST6mM+dMJ+HcnOytAQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yMkkGOdcIyKE6ixXhHLo5QsIRVsx84P+8gtf2e9fCOl9zN8xdZ7PML76Dpcc/tu1+1WC097JZZ9LRZholzvZXD9sT6VA3IXoBdGRm2OC3uHfAjXDKUwQI58yrwflYIU7qj1aaIrm6kFxWsk6/z5R5TBUB7ES1IWSKDutERqk0XrlEeownZny6DnJXdLNzbvOXQtIRlsae+IjH5Y1JWRQQ1GXV8t2OcycHIC/AnbYZsguP25HnvqHqOnZ1Eel2egZeYrYCGptVfpyKbchSPn2bO6BX8uF7G6Z6ZMbNSN3y3zHEdKTmK8uVJeGiyRdNX7I375yYxZcHrf6qkrKX+cOCqlmmzXcNdzL0/n9rqwYCBUwtOlxgb0kbUYs5QMLeUsFAYhEy0kO5YUJbdenfW42Yf8z4vvJAN+CqOCL+mIZ/QFBR4lcB2yKObQ59sp/vi85
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 08:44:15.8851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc362fb-f33b-44d4-b613-08df1ecf0290
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8580

On 9/30/26 10:33, Andy Shevchenko wrote:
> On Tue, Sep 29, 2026 at 06:48:28PM +0200, Fabrice Gasnier wrote:
>> On 9/24/26 23:01, Andy Shevchenko wrote:
>>> On Wed, Sep 23, 2026 at 05:39:10PM +0200, Fabrice Gasnier wrote:
> 
> ...
> 
>>>>  		.compatible = "st,stm32mp13-adc-core",
>>>>  		.data = (void *)&stm32mp13_adc_priv_cfg
>>>>  	}, {
>>>> -	},
>>>> +		.compatible = "st,stm32mp25-adc-core",
>>>> +		.data = (void *)&stm32mp25_adc_priv_cfg
>>>> +	}, {
>>>> +	}
>>>
>>> Same issue and now it's a regression from maintenance perspective: you added an
>>> unnedeed churn that has to be handled from now on... TL;DR: do add trailing
>>> commas to the non-terminator entries and remove trailing commas in the
>>> terminator entries.
> 
>> Do you wish I add a separate cleanup patch for existing match table ?
>> This can also fit into 100 chars line now:
> 
> This is, of course, is up to you, but my comment was solely against the
> trailing comma removal.
> 
>> static const struct of_device_id stm32_adc_of_match[] = {
>> 	{ .compatible = "st,stm32f4-adc-core", .data = (void
>> *)&stm32f4_adc_priv_cfg, },
> 
> Here is actually the opposite, no inner trailing comma should be added as it's
> a one-line entry.

Hi Andy,

Sorry if I'm a bit confused :-), just to be sure, the preferred style should be as below ?

static const struct of_device_id stm32_adc_of_match[] = {
	{ .compatible = "st,stm32f4-adc-core", .data = (void *)&stm32f4_adc_priv_cfg },
	{ .compatible = "st,stm32h7-adc-core", .data = (void *)&stm32h7_adc_priv_cfg },
	{ .compatible = "st,stm32mp1-adc-core",	.data = (void *)&stm32mp1_adc_priv_cfg },
	{ .compatible = "st,stm32mp13-adc-core", .data = (void *)&stm32mp13_adc_priv_cfg },
	{ }
};

Thanks,
Best Regards,
Fabrice
> 
>> 	{ .compatible = "st,stm32h7-adc-core", .data = (void
>> *)&stm32h7_adc_priv_cfg, },
>> 	{ .compatible = "st,stm32mp1-adc-core",	.data = (void
>> *)&stm32mp1_adc_priv_cfg, },
>> 	{ .compatible = "st,stm32mp13-adc-core", .data = (void
>> *)&stm32mp13_adc_priv_cfg, },
>> 	{ }
>> };
> 
>>>>  };
> 

