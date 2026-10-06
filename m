Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F036CE19;
	Tue,  6 Oct 2026 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302649; cv=fail; b=ojS0kO6IKuvEU+VD//MibKaCyLOThoQtWfGAPgAY0ffJJ86JzyzKl5Bj6eAQeD7jm28qoFh28R1U/mwjFRzwdlsPuAEIOgXo2p+kGsScLlkSmvbh4O+H2oO7IKEQVs0MFYAh2Uey/8Cm39X8ecCSeyImeZ0M/wRMl6Bf9RG+7fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302649; c=relaxed/simple;
	bh=3snGnEA3nAkDrQ36pPltsK/9zqZdn8y42xpQSBKN/Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hd8KwROnaKrKxja2p3u46zeSThHOLJadyidRXtB9MQIwYwtinNf5S7Vtm/fBF5v8LnTQ0YWsMdd5R563cF4L0a5Xb2krOCvSVwm61zlQKFULuUal2JDsGlCnbuGbvUB+8Vir+t8WLVWk36fSsEL31+CBmXvCOOZuubfoRPelIug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RFwVQFr/; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RFwVQFr/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWtk8HfMOdrNklQhbeOota/Xm/dfxq4xSEvto+tBkhsu9V5gomh6+keI9b6zDan/cTdqFoDLiILUIDI5sXyY9HmdyjhPyE1GkUoNtN+9lZqRk/V/VHbN6kNe9qicnPGzwhxkYLF/rDpfvCXO0CD3Bxz2PCO6xMb0setlki4A5lFdmZNNbtQMmDEDreMISd/zUqmQMv72r0C/OqdlE86gGh9qK2rovzvQCHUHBfsWp17nHnBwmyOuhGxhuSeVjSsJlNdrKB4Z0Az4X7SlmZu5arJS4pOziRRRf0JS/Pgm500+ajnhsTA0n2yMrMJLrxQDJM+VrabxHo3fR6ovnBdHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0P6GAC4ZRUUwwT50gnm38AeYR23IigAKOUQaXFu2Fo=;
 b=WK90WhrduTpDA8xMofsl4Ld+uGsHV/+mWP/LhdYF/OZGdqfRHr6d3RzV/mWO+rO8vE+35PlVFGyb3PUQrBu7++15qt/z8zOzJknsjOyuJRFKC4ETgRu7169/7c8ZmKiE5L/Q1ErYsP+k0EpoT7EU12JLVreGwIxrdFTyE/J+j3SWqEgxSCD1jxjpER99T9eEKWs6SX3RBK3ZCE2tJv1oFMGdNj26BA/WyjKJmwbUPE5O7Fl3bRXvn/CBvlXDt5cPC+FJXBvb8ls76c1JIUFkROMVGVX9F2LkdIVfyq0bgwWkFA94CmTg7C0ohnF55HbssGVTxhMGKSt7L6pCpCvxOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0P6GAC4ZRUUwwT50gnm38AeYR23IigAKOUQaXFu2Fo=;
 b=RFwVQFr/6ia4tfQIW6Sy/TUKV+UodUuIPH21JWcf00bRwzGCVx+AiJU4upWL57W7LApvYUS8DJw9A3HrDPkkNCEhO3dvUPZBWjJtdOHuKMF0lReWGys26HUQfru7jLkrhHCyLe37+TyXMA1mNxlkHrBO6LxILGCKDQguZin7cDgj2JEG5+FSb/Xa04Htf6wrgKK1PSFLnGvKxail/fAp4osaxP7pjahfK/Ip92B0sBAO4i3KUCwSiZDCwwicdduDUSS7czDmwuDGEJ3gNIRip7M437NH3QRmh0Exh1DJcLRGZmhLeMCQTh81b85vPYqREMIUhlalxpz9iPU9gVCaFw==
Received: from GV3PEPF0001DBF8.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::309) by DU0PR10MB6932.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:417::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 6 Oct
 2026 16:04:04 +0000
Received: from WA1PEPF000099CF.eurprd04.prod.outlook.com (2603:10a6:1d8::167)
 by GV3PEPF0001DBF8.outlook.office365.com (2603:10a6:158:400::309) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.382.12 via Frontend Transport; Tue, 6 Oct 2026 16:04:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 WA1PEPF000099CF.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 16:04:03 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 18:10:07 +0200
Received: from [10.252.29.133] (10.252.29.133) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 18:04:02 +0200
Message-ID: <9bdf2258-9310-48ee-b3c5-226ce5fb76e1@foss.st.com>
Date: Tue, 6 Oct 2026 18:04:01 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add bindings for stm32 mdf
 filter
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-2-olivier.moysan@foss.st.com>
 <20261002-observant-gleaming-koel-4dc04c@quoll>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20261002-observant-gleaming-koel-4dc04c@quoll>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CF:EE_|DU0PR10MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ac9b37-a188-4d79-f9e8-08df23c37187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|36860700016|376014|82310400026|10067099003|11063799006|3023799007|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1Oul3/8hFN9e7TosB8RxBWkKq6BqAyJ6bjiQAq5u4rRZFIn66alOjBd4guG3vzDeTa+X8zEoVccbIYFqAP+Qg3BA1a/y5cgCZzMWqIU+HB/2L9APsdxmOFiD3IV+VtJ5j/6akYNbFAQLgifaXCh6HIRgF7melhmlnwaj7dBH7ZkFBHNagMCyTX6yIu0OMfcOW2nQxVwnOj6sGdHCArX5bKmfzxNB9gf9p7R8dUG6/G6WSW1ELIs+EVZ3nMiF6WZRXh9pyv0ynpOBxUJEnRiRIt50O2wGg3rIJo8UgQu2oSH63O/jEbwREfWfax+8g23PI4ymE4N/l8tnIGYmQHTmfkJfvX7+87+fz0wY+OAOJOPUMUbBGnBSMvJm8ftwUJDgxFoM4EjUnXBSY9PVIgapYNRjvIze0CJ81RFXs/3U+nhZnd036epZCSj/5L8CRfnx2LmjwfFhFhbvXelJ/D+I1ve9vi62zL0dO1nVLQmBpPaRKRi4ydZ+Jel7G8U3o9wWYfeF49hlCciLBJlPxDK1c6RABrNbm7SPE5RY1UNPqttHOo4fvNHYeXat8LlA3E3Tgz2B615/3sT5IkWvBJ40pXf6yROD040XLHfqF9aywXc5YuSegpuLdACWFUEVzn7Qy9LxLiS08yftxbRx8lAtVxS+0h4N7D5X4JuhS69MxviyAa9zt022HyoRYF/cxN31NSaLCkYIgZcfDwzzeHd2Cg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(10067099003)(11063799006)(3023799007)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2MkjSoMONRlB5zmisfMLxzub6ktNFEMlHhHUxUL5pSmQr+rPsQ/pXGtYu11Ei3c3LX58cX4/QP1T2+rryUibfY+F4XlRtThwj+Go2bJhy54LXLsJgqVdABbZYJxsuTyu3bGMhKKv4XrBCInxw59goDt9EVOJ2SIo4Y2BK5qmnz9SlUtKpIQcANLDVAEQtUopGmusthL6pwuNN+GSfZNMLLll7Z1jRKwBsSQMiLLm+TlOcwdzhcgdKj6E0wvOkOe020Hm9JQaNGuWWr+l82361T5eoI+xwCmQ22J4eiIDJzX3gYiXCD7RJowx+jg8DEcujFNR/7bip6TdNZv6bphEkNPwNZKWdQ1Wynhx3OQoFMecn2BRrpB0riv/nvddMXMDglntWR88RR5pADcgh1V4qtRddFWz2eHbH3ihD/UWNZLw2GoKCoiQuH/hIr8+mI6Q
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 16:04:03.9203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ac9b37-a188-4d79-f9e8-08df23c37187
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF000099CF.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6932

Hi Krzysztof,

On 10/2/26 11:34, Krzysztof Kozlowski wrote:
> On Thu, Oct 01, 2026 at 04:56:45PM +0200, Olivier Moysan wrote:
>> +  clock-output-names:
>> +    description: |
>> +      CCK0 and CCK1 are optional output clocks, which share the same clock frequency,
>> +      but can be gated independently to save power.
>> +    minItems: 1
>> +    maxItems: 2
>> +    oneOf:
>> +      - items:
>> +          - const: cck0
>> +      - items:
>> +          - const: cck1
>> +      - items:
>> +          - const: cck0
>> +          - const: cck1
> 
> Use simpler notation:
> minItems: 1
> items:
>    - enum
>    - const
> 
>> +
>> +  clock-frequency:
>> +    description: |
> 
> Drop | when not needed.
> 
>> +      Common clock frequency (Hz) for CCK0 and CCK1 output clocks.
>> +      The frequency must be a multiple of the "ker_ck" clock frequency.
>> +    maximum: 25000000
> 
> So here is the clock-frequency. No, these are output clocks as written
> above, so consumer sets it, not the provider. Or use existing assigned
> properties. This is even mentioned on DTS101 slides, really...
> 

We expect the clock frequency to be defined statically for a given board 
So, using assigned-clocks properties looks the right choice.
What bothers me about this solution, is that the frequency will be 
defined in each consumer, whereas a single rate can be defined for the 
provider. This may looks a bit strange, but I will implement it this way 
if there is no other mean to set the provider frequency.


> Best regards,
> Krzysztof
> 

Best regards
Olivier
