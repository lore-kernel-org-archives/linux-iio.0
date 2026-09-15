Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8FE32D7F8;
	Tue, 15 Sep 2026 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458551; cv=fail; b=ebzaN/zcvVJKNCxmQjkLMImLhr58Jz4I17f24QsHLo0nkItJaVJUANkUjkQZM/R8qMgDY4Ne3p9ZnvcAMQtDAiu4xn+jTz6/Xhpygr2tp9Ygpr/bI6zwF2c3dq0tpJsvupc8CRojZBgWLKYSdz3m2rznO1CWHzMerPnmj7tbibA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458551; c=relaxed/simple;
	bh=kUXBUStaGMUegjjUy8EbkIqkQShx+9rZzU6POdtEHWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rbrCG4QwwRGR/S0u+tP1fcGPXPbFpZM/oybBw6BMETRKbXxJMGD+77cnIwvQ8QN5hq/lLDxIsCxq+koXlgjVjb4IWOK5xomsHhXIngu1/joYJtQg5DvXx5hCsBGdXDCcGJNwhlSQNKIAWyjDhQYypXR+6ev/3NEp0HfJaL56NeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MRJBOJYf; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MRJBOJYf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gchJ8iMpNJxz2dR907sJSOMozU4aBFFlahAgEh9plKmhwP16IQqk3jwcfwvdJP0nWDKvT6DfVLLYNxXn3pBIS/ioWwYWRKvh6IvWxoemTb4TSjeJOwD/x160RB9qBo/C84EhbrnMR42cZYhKRagLl9txNPPwCBLUaNz3ttoyP8VgtLvU0/BaDOtnwcLobvPAUHkukpQxdrL1vkJxe9zXI1xo9KjIkzgwZEArnc3iDOkLDM+WX9/clqsgmvhGAcPVKRBykQRuj3WZbXlugUD3NQgiQOMB0fnELSoUmmZBItPSVuOSdwSSPyzmjsBe5XncApwi1pwpTBO6brRN0MVl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC2QbhckKfcaXPmhe25l7iqs1Y7eT+0vMETIKlUBqNU=;
 b=XNNfFpg9i2Z9QlnBOto1WzBcveOQAofAyP17WCahfzT+sw2VFI/IP6+pohXjTOWafYnDeNBpvBKtJVpCbNHeOuDlR9/fSLlvjPNhLetmBTTu+E6jG6WbNWpZdDvb7TB36D/Py+C8IqeuvD7rqCVDdBYF7DstMyGPhrbkzrdu17bSjUGqHOBaAmsf/S4ST0+KXFVGdL9kiOMPOGVm5iZoaKN8MGgbdVbV+UEhHazJ4fshGXCT/x9GrzGSGv3JEIjaiwlmeQCztTCD8cnfi6guL6uDw0eORrbM1jjEmCKQKUIYIVuPadyVnL1bj4gAPsrgLxHUZuHlBUqWv0tRMVOMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC2QbhckKfcaXPmhe25l7iqs1Y7eT+0vMETIKlUBqNU=;
 b=MRJBOJYfYNZ+NY/upGS359ibYaV8rnPzsdO7lOz+HjOxrgTb3uBaFhTC03skADG00BBK6X1f6hgEtVATzvn4Rs435Bz8BPX34CUK/S3w1C6JbyFqFF4eAKYcXMB9YgyMZFTjmLsKHPFM0X1voI8gomwSyOgq9i30ZWV8kI7YhD3FhDoNMupaV+dmVGJctyLjlbnvlYvvFTF2P3WIcQGxaxjBeDdnFnfXwcwj4+DMwfMoZMh+U2on3wKEvE065BNs4A5PbW7h4XS471m/kFuwxTV2KSaBOfYp6bVNFu8oqZ/xIOd644yItyvc8RKYS295i3CewiRs4orltwaBpkzoIA==
Received: from DB8PR04CA0013.eurprd04.prod.outlook.com (2603:10a6:10:110::23)
 by FRWPR10MB9228.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:183::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:49:04 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::62) by DB8PR04CA0013.outlook.office365.com
 (2603:10a6:10:110::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 07:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 07:49:03 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 15 Sep
 2026 09:55:07 +0200
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 15 Sep
 2026 09:49:02 +0200
Message-ID: <6e28ede2-686c-4972-8a15-348ae090cec8@foss.st.com>
Date: Tue, 15 Sep 2026 09:49:01 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: iio: adc: stm32-adc: add support for
 stm32mp23 and stm32mp25
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Marek Vasut <marex@nabladev.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Cheick Traore <cheick.traore-ext@st.com>, Olivier Moysan
	<olivier.moysan@foss.st.com>
References: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
 <20260911-adc-stm32mp25-v1-v1-1-cef26eecdef2@foss.st.com>
 <20260913040801.30e07d4c@jic23-hlaptop>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20260913040801.30e07d4c@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|FRWPR10MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: cef1148a-aafc-40f8-d5a4-08df12fdd03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	uZjAaSBcjnNnur7gSgrI2OSbtTyZadjFqFsI9At7TWlhawPE5OygXTSaY5GeKdEdWLB6rcmDY88tM2iduF7zNSLnwasscUl4rBk4QAUH/fke4fYNxZqitaurWQG7ZBwc9DkOXqOhFIWDwe/r6OhVAUoXKN8sez1rW8t+qdJikB1+NzPLKciuotziVGM+ujwbXNLpg2fg9nwA+uG+ECufpY0bWkC59R4Vx/kZV0LB2Ktp6msaqdEOFNlMOH5LBTghn528u3ge/82PtpvXlvZMzh6T92j2Ew6MGIBu/XtAv0gNYQ0CqzClIbfZwBlGVjU5CAPoitsHURkRrpfgK4wzxjoyZShSKsUQp2PlIirSLYEhfGqj5CzpQkvf0pqdM5Y6sTcd1tx2KKSYBw/k1Fz9tPEl3F+0vUJAgN9D83i6ufQ2o/9Pykfa35Ao4KLVf3Zqo7on7st9W554US+Ih9lTBuoXqqS36dZx1LD8H4zJAjhsrd2mSRDvJ6dBDZ8TJbzfyig/58kXT4lhScLpVUDSIFP19mnHwzBu0R2mf0oHDsPTUtI3bADEG99ppc6/B96tOWQ433i7VFn0nXtSauGvAmfaAEH6aCfd79ptfCClFj62yF1Pw0M1FH8mmYuQ2NzKaCsTbPVRDGZFcMYQ5MVjAhoEtoynufC+5qbLF46PNLiOj7aDbDg7oTNtTy9wXHZE87asRG9CObXH3FYWfBaiXg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X0flhoFC/3khBAZxw9E+Fax0swe3BeQCDegcWLhti6Un0od+cck9hkI8R23dJFi2WYum4ukyyk3FYTCG3Hq2reHoaCjcD1mZpiCTnPVZAXse0z3ODMGI70cUIjGqZJU2TX0sFU0LUh+2BSAMOGSzW8ivXenZz/XM1SBI4hmcUXV3IvFuvYN8xHm1TqMZK8jtn2QxN2O0Q5bQKa2SwHEiTUf3gWjCUnPAiUDIZjhFjnxjFnGNYx+zUqR7GFQtihFqq74mi6eXUBMoFhDof2NGkJhVKtu4IplDEHAD7zQk8Fia1t+sByiDzW0qpLsuVoH4uTqNatYodJgBUBG/Id0q33fwWaMjzJbI0yBd3bKjQ5RXlf7n0dt6ZKFv/64OEGn7UuVmzns6gy/vo5Ymo1gW2BrkzdrMAaJMRsBEzWst76pJFstU8PH2DMkMWc6s1OkX
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:49:03.8501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef1148a-aafc-40f8-d5a4-08df12fdd03e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9228

On 9/13/26 05:08, Jonathan Cameron wrote:
> On Fri, 11 Sep 2026 17:51:23 +0200
> Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:
> 
>> Add stm32mp23 and stm32mp25 compatibles. Three ADCs can be found on
>> these SoCs, split into two blocks:
>> - ADC12 are tightly coupled (common registers).
>> - ADC3 is managed independently.
>> Each ADC is a 12-bits successive approximation analog-to-digital converter,
>> with up to 20 multiplexed channels that can be configured as single ended
>> or differential.
>>
>> New property "st,adc-trigger-sel " allow to make the difference between
>> the ADCs and to apply the correct trigger configuration.
>>
>> STM32 ADC may be in a power domain: allow a single 'power-domains'.
>>
>> Restrict the last channel (19), as it is wired directly to ADC Vref+.
>> It's meaningless to have direct measurement. Internal Vref with
>> calibration data from bsec (nvmem) must be used instead e.g. vrefint.
>> Restrict deprecated properties (st,adc-channels, st,adc-diff-channels,
>> st,min-sample-time-nsecs).
>>
>> Co-developed-by: Cheick Traore <cheick.traore-ext@st.com>
>> Signed-off-by: Cheick Traore <cheick.traore-ext@st.com>
>> Co-developed-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> 
> Hi Fabrice, all,
> 
>> ---
>>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 106 ++++++++++++++++++---
>>  1 file changed, 94 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
>> index c4c4575d3fa9..0e0ceaa3d8d6 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
>> @@ -23,11 +23,18 @@ maintainers:
>>  
>>  properties:
>>    compatible:
>> -    enum:
>> -      - st,stm32f4-adc-core
>> -      - st,stm32h7-adc-core
>> -      - st,stm32mp1-adc-core
>> -      - st,stm32mp13-adc-core
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - st,stm32f4-adc-core
>> +              - st,stm32h7-adc-core
>> +              - st,stm32mp1-adc-core
>> +              - st,stm32mp13-adc-core
>> +      - items:
>> +          - enum:
>> +              - st,stm32mp23-adc-core
>> +              - st,stm32mp25-adc-core
>> +          - const: st,stm32-adc-core
> 
> What is this?  Given these all vary in features
> why would we fallback to a generic match for
> these new compatibles?

Hi Jonathan, all

Ack, I'll drop it in v2,

> 
> 
> 
>>  additionalProperties: false
>>  
>>  required:
>> @@ -239,11 +276,18 @@ patternProperties:
>>  
>>      properties:
>>        compatible:
>> -        enum:
>> -          - st,stm32f4-adc
>> -          - st,stm32h7-adc
>> -          - st,stm32mp1-adc
>> -          - st,stm32mp13-adc
>> +        oneOf:
>> +          - items:
>> +              - enum:
>> +                  - st,stm32f4-adc
>> +                  - st,stm32h7-adc
>> +                  - st,stm32mp1-adc
>> +                  - st,stm32mp13-adc
>> +          - items:
>> +              - enum:
>> +                  - st,stm32mp23-adc
>> +                  - st,stm32mp25-adc
>> +              - const: st,stm32-adc
> 
> Similar to above, what is this?

same,

> 
> 
>> @@ -344,6 +388,12 @@ patternProperties:
>>          items:
>>            - const: vrefint
>>  
>> +      st,adc-trigger-sel:
>> +        description: Selects the HW trigger configuration available on this ADC
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        enum: [0, 1]
> 
> Magic value that is meaningless to see in a dts.  If they
> are effectively not compatible, give them different compatibles and
> drop this property.  I'm unconvinced this property is more
> useful than that given just how opaque the description is.

That's exactly what I was wondering about. As you suggest, I can remove
this property, and introduce dedicated compatibles in V2, to clearly
identify the differences.

Need to distinguish:
- ADC12 are tightly coupled (common registers).
- ADC3 is managed independently.
Triggers are different between them. The purpose of st,adc-trigger-sel
was to identify that.

Also MP23 and MP25 are also different (trigger list). Combining this
would lead to introduce four compatibles, I'm thinking of:
- st,stm32mp23-adc12
- st,stm32mp23-adc3
- st,stm32mp25-adc12
- st,stm32mp25-adc3

I plan to update it in v2.

Thanks,
Fabrice

> 
> 
> 

