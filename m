Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD437DEBE;
	Thu,  8 Oct 2026 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477457; cv=fail; b=QlF9S+kpVp9FWim++FcwkfckYe5+nTuHySm/S+oRlr1tCrpv3cn1M+tTWppz0dP+GtmY6fjFrGXRfOTCypJspgroKcPI+wuz5ldC/sZag+A/ZcoN2VW+nlsTgguaoYV/FmYexprGaYO6+JIpqayxlfbx8AEfJoq//1lc2pKub08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477457; c=relaxed/simple;
	bh=4h5t3u7Sr42rAq5F3xvW+fbJrs9iKV9RSmqHskUN/W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GUv4qIZgy9/oNneqHlJ4tmUXJQwqFpOyuKkjck907AY0sFgAVHpXbmk7Iga3uRsmtgqGYsdM/zFIANYJ4DGwU3L9iyNMTBX6dI+3dUXSCO0qaBOwbD97c2q7n5xmnqHBWkoan5N7XU+nqDeGfQrgbzN6AdbCbVaQ6KaYdkwQAMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oszsKHcr; arc=fail smtp.client-ip=40.107.162.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oszsKHcr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSUXsoIFXRua4QTnPxxa6KYfXf13RyGCNyodjFZry1MHmjr/PaorEvYmsLnuzElcuHaLxtrBdcXiUnzksQpP/7TrNZZRy8I0oaUnOHoh7CZuQu+rraMKzRGkjGO9W8A9fZJ4Hg6PjCjMrLloxUQPZkWFYfsfEFyWXUqSHCdqMEkb563FRS++UNEBVxQrpI3v1ZeXR9Fejep9uWJCvmGnou2JxhhPEW2CHB3gSovmYme9hGkxJ8oV6sTKJPVA4d05r6yriQRP86V5IWWwY+dikiU29G31LfiZ9tpIPwwETGJTi4ylBDMo0KFXEQqx4VizDDG7E+p0Fd+ySpquYSelrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vgb6AtBdxBWMEbtpo5vHTNHqts2UTk1iiV4kjLN/Mlo=;
 b=FkEaH8BqWwX9idE097oOJBez6cN66fyg26C7V+ZXYfUBfHdI5avzw2/LDh7q4lYEOwXUpt38lfrrI2Vg8AgxeMZ4iW+YgEjjf3z5/LddZZ7lYjO6gHAqI6vkPRxgLKLvRWJ364/1rRQEx/QdJe8G5O1jA9ftg/V1DgmGJvOi+So9u6ie4+75EvYoEqjYfaEi8IyDO+LKdPyqYBMYYBpERrHERem5fFHt+tERkSS8mxryRwFYUna5lWFGmaqjGPgcA4JO2YtC1LvlDsIgGkEKALFUG3duk89/QRz9rjuL9niZX9rr2Vi7ng7mHDvKVJ3hvz7cCr/3itCZj2/E7JT+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vgb6AtBdxBWMEbtpo5vHTNHqts2UTk1iiV4kjLN/Mlo=;
 b=oszsKHcriU7rcb0RXmqMvXpX4k+O4ZPrYs7A8/unal6qvTejcV+Sz1xd4OA5LincypM8+PX8bIMZQprIBEPXi2LAixBXSaSMag6CKY3u1OevLTHhfMcQKThqV03KnqvZnUkKLlvayKk8aTmHdtMoSzr3dmW/q7s5203bukW93CtZM9YLUH1Jph7eDYgq5mIJrs5cF5+LNNfjKmz0pa27X1iwbP5xH0528jRJRDWmA1dmlmu18lnvwKUSG/17TpqaSqN53iZsj44yL2Pvsz9Cg1wuO6gf/VNIdKAqSq3bXYq3EK5J4sdFOuFwbhnML6I+YzeCFQ2V8dh9+yojKsg96g==
Received: from ZRAP278CA0014.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::24)
 by AMDPR10MB992292.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:750::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 16:37:29 +0000
Received: from MI3PEPF0000848C.eurprd02.prod.outlook.com
 (2603:10a6:910:10:cafe::98) by ZRAP278CA0014.outlook.office365.com
 (2603:10a6:910:10::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 16:37:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF0000848C.mail.protection.outlook.com (10.167.240.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 16:37:28 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 18:43:33 +0200
Received: from [10.48.87.64] (10.48.87.64) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 18:37:27 +0200
Message-ID: <950f2801-a613-4f5a-a5a7-cb30101cf293@foss.st.com>
Date: Thu, 8 Oct 2026 18:37:26 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add bindings for stm32 mdf
 filter
To: Conor Dooley <conor@kernel.org>
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
 <20261001-tribesman-gauze-862e1ef0cdd8@spud>
 <bb8af256-5a77-4215-9eeb-fbcd0cae1829@foss.st.com>
 <20261008-9e2a48675c1a4c28f2dfa73b@squawk>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20261008-9e2a48675c1a4c28f2dfa73b@squawk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000848C:EE_|AMDPR10MB992292:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b9e03c-1b8f-4597-758f-08df255a7139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|7416014|23010399003|22082099003|56012099006|11063799006|5023799004|4143699003|18002099003|10067099003|13003099007|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	/GtbRvsqkiStCu4oM+ruxFB02UkfHMU9xOjgAlL07jzWH6Ggr7FdFsGc6hmTXT12oFZXObda5MIJld5DCyyTLUgaZHEMgMMFLLiB7+4fCCoEFqMTy/oVcicsE6iMCsgkY/48wjmxR2xK76uWSjn9TL9A5Kd5Ff59ijvWkj5AqR4CFyWBQJkMkTU4/sDVRsG/UODfz55vKDWeZJG9GrQEQKFrbY0ZZOIuYiW++iuT8crH+2Ml33jh6Go7Fhcp0xdhJ7Vq0R7fJQwHZVNdKeqDfIysBgKvPo/CgcmcEkROEliIVPGBVqY59t+6rAw/LLb/7r0O/5IAk31hxck5MYtDR9Ib2V0lTyyvfXw2f0XLo4rgo8cKWtPKXYPZsagHddh+Qcu8opk3yvEBlFPIepLX06wEA6rZVzvfouHts0ZyRTgecEhhbjJ2ku2gbgsSDbbEtEHemB2a4gOtfEKqgE173kTEfzC91A3Diw/QfSlQdfEwfawfKiMrIQ+3uDhDy8GXFgE65qfMwe3RhRKPviIevzevw/hShFxh2UzqggKKYNXc0WStT6OkfzRtQmojQ9ly6wXgut/wDpBuLq+cVF/nsONssv157PdV/Khk+TxNBK7vY+RY5pzqErJbXCOo/aaf/Vd7SixpxCXCdIlUS1JCBw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(7416014)(23010399003)(22082099003)(56012099006)(11063799006)(5023799004)(4143699003)(18002099003)(10067099003)(13003099007)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6StG+wgZLrxQs1SEyHv3RCuZAk9xglrTiS1Y7xV+OYHnMABjjW5WI4KwbdJmtdSp/M2zKhEnTOjQQbfHAfYfCTKGNnw5wRydBUVNN7Dydo2Q1Ylr0r/kyPa+3CF2TOpr0dQPBKPAl5IXyBiToqD7Nyl7Zln7Ftcqtv+UqiwjyvqgyQkp5rtODwz9R30bYEadHsGS0bRbFutkc/pT6iD9NH9gaEC9FM/UJ/o1OBfyW2M3un1m9sRgHsiQ78PUzotnTSIkvk80qOBEX+wm7c8DtpY+UCpT6jSfCwD5FQD+NNFMvCDXeKFB3vECwVAe7JUI6j+xl5CNBT2BA70sLKpFX27Kw4haC0RNOA6nQgWnQbPQAqVEYeBw/ATk7Vafakbrxm1o4xbIjLLO4RxjeQTqRKhGa8zCmVSUZxj1ptkwTmgumOjwuVTqxqHIg6Tbj3XJ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 16:37:28.5957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b9e03c-1b8f-4597-758f-08df255a7139
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000848C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR10MB992292

Hi Conor,

On 10/8/26 12:11, Conor Dooley wrote:
> On Wed, Oct 07, 2026 at 11:01:28AM +0200, Olivier MOYSAN wrote:
>> Hi Conor,
>>
>> Thanks for the review
>>
>> On 10/1/26 20:32, Conor Dooley wrote:
>>> On Thu, Oct 01, 2026 at 04:56:45PM +0200, Olivier Moysan wrote:
>>>> Add bindings that describes STM32 MDF settings to support
>>>> digital filtering for Pulse Density Modulation (PDM) microphones
>>>> and analog sigma delta modulators.
>>>>
>>>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>>>> ---
>>>>    .../bindings/iio/adc/st,stm32-mdf-adc.yaml    | 383 ++++++++++++++++++
>>>>    1 file changed, 383 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
>>>> new file mode 100644
>>>> index 000000000000..f2fbc3e150e8
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
>>>> @@ -0,0 +1,383 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/iio/adc/st,stm32-mdf-adc.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: STMicroelectronics STM32 Multi-function Digital Filter (MDF) ADC
>>>> +
>>>> +maintainers:
>>>> +  - Olivier Moysan <olivier.moysan@foss.st.com>
>>>> +
>>>> +description: |
>>>> +  STM32 MDF ADC is a sigma delta analog-to-digital converter dedicated to
>>>> +  interface external sigma delta modulators to STM32 micro controllers.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - st,stm32mp25-mdf
>>>> +      - st,stm32mp23-mdf
>>>> +
>>>> +  reg:
>>>> +    minItems: 1
>>>> +    maxItems: 2
>>>
>>> This needs an items list here. The size of the regions seems like crap
>>> to begin with...
>>>
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +
>>>> +  clock-names:
>>>> +    description: Internal clock used for MDF digital processing.
>>>> +    items:
>>>> +      - const: ker_ck
>>>
>>> This is pointless when you only have one.
>>>
>>
>> I agree that it could be dropped. However, it is useful for using
>> devm_regmap_init_mmio_clk.
> 
> Ah, because that function if you pass NULL to it, it doesn't mean no
> string, it means no clock.
> 

The MDF has two clocks (AHB clock for register accesses and ker_ck for 
peripheral processing). However, these two clocks share the same gate. 
So, only the ker_ck clock is exposed in the driver.
The regmap api is a convenient way to manage registers and gate the AHB 
clock only on register accesses. Removing clock-names no longer allows 
you to benefit from clock management handled by the regmap framework, 
and means that this must be managed explicitly, partially or entirely, 
in the driver.

>>
>>>> +
>>>> +  "#clock-cells":
>>>> +    enum: [0, 1]
>>>
>>> Why is this not fixed? Also why are parts of your own device consuming
>>> the clocks?
> 
> Reading the docs, this has to be 1, you have two clocks?
> 
> Not sure why you skipped this and skipped explaining why you are
> consuming your own clocks.
> 

Yes, we can have two clocks gated independently but sharing the same rate.

Using the clock framework apis seemed to me the right way to manage cck1 
and cck0 gating and divider computing. I think I would have to introduce 
proprietary properties and have to implement code in the driver, that 
would be handled natively by the framework otherwise.

>>>> +  clock-output-names:
>>>> +    description: |
>>>> +      CCK0 and CCK1 are optional output clocks, which share the same clock frequency,
>>>> +      but can be gated independently to save power.
>>>> +    minItems: 1
>>>> +    maxItems: 2
>>>> +    oneOf:
>>>> +      - items:
>>>> +          - const: cck0
>>>> +      - items:
>>>> +          - const: cck1
>>>> +      - items:
>>>> +          - const: cck0
>>>> +          - const: cck1
>>>> +
>>>> +  clock-frequency:
>>>> +    description: |
>>>> +      Common clock frequency (Hz) for CCK0 and CCK1 output clocks.
>>>> +      The frequency must be a multiple of the "ker_ck" clock frequency.
>>>> +    maximum: 25000000
>>>
>>> Should not be needed, the consumers request what they need.
>>>
>>
>> The CCKx clock frequency depends on the maximum rate supported by the sigma
>> delta converters (for instance a digital mic) and the expected decimation
>> ratio on the bitstream. Typically this determines the frequency on the SPI
>> bus.
>> This rate is defined statically and shared by the CCKx clocks. So IMHO, as
>> this rate is unique, it can look strange to let the consumer define it.
>> Moreover, it seems to me that clock-frequency is already used to configure
>> the frequency of a provider in some other bindings.
>> For instance: Documentation/devicetree/bindings/clock/silabs,si570.yaml
> 
> This is a binding from the age of antiquity, using it to justify your
> use is actually harming your argument rather than helping. Your clock
> consumers should be providing the information about what the rate should
> be, and if you need to do this in dt you can use assigned-clock-rates.
> 

ok, I will move this to clock consumer with assigned-clock properties.

>> So, it's not clear for me, what is the restriction on clock-frequency
>> property.
>>>> +
>>>> +  ranges: true
>>>> +
>>>> +  clock-ranges: true
>>>> +
>>>> +  resets:
>>>> +    maxItems: 1
>>>> +
>>>> +  reset-names:
>>>> +    items:
>>>> +      - const: mdf
> 
> Same applies here as to the clock names fwiw.
> 

Yes, I removed this.

>>>> +
>>>> +  access-controllers:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +    description: |
>>>> +      Phandle to the rifsc device to check access right.
>>>> +
>>>> +  power-domains:
>>>> +    maxItems: 1
>>>> +
>>>> +  st,interleave:
>>>> +    description: |
>>>> +      List of phandles of interleaved filters. The indexes of interleaved filters must be
>>>> +      consecutives starting from 0 (i.e in range [0..N]). The samples from interleaved filters
>>>> +      are muxed in a single channel and retrieved through the device associated to the filter 0.
>>>> +      The filters 1..N have to be enabled, but inherit their configuration from filter 0.
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>
>>> No idea what these even are, but this is probably not the right way to
>>> represent the relationship between devices. They're apparently ADCs, but
>>> this is also an ADC so I'm not sure what's going on here at all.
> 
> Yeah, after more thought this should not be done like this at all,
> especially if these filters the phandle point to are part of this device
> itself, which I suspect they are. If that's the case, you don't need
> phandles to even do this, you just need an int that says what N is.
> 

Yes, can be an index as it is an internal reference. I will change this.

>>>
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - ranges
>>>> +  - clocks
>>>> +  - clock-names
>>>> +  - clock-ranges
>>>> +  - "#address-cells"
>>>> +  - "#size-cells"
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +patternProperties:
>>>> +  "^sitf@[0-9]+$":
>>>> +    type: object
>>>> +    description: Serial interface child node
>>>
>>> Why is this a child node at all?
>>> Probably not worth reviewing more without a link to the docs for this
>>> device so I can figure out what on earth is going on!
>>>
>>
>> The MDF is a digital filter for sigma-delta bitstreams, rather than the
>> analog-to-digital converter itself.
>>
>> Here is the link to STM32MP25 reference manuel
>> https://www.st.com/resource/en/reference_manual/rm0457-stm32mp2325xx-advanced-armbased-3264bit-mpus-stmicroelectronics.pdf
>> Chapter 45: Multi-function digital filter (MDF)
>>
>> On STMP32MP25 SoC, the MDF provides 8 serial interfaces (SITF) and 8 digital
>> filters (DFLT) which can be connected through a multiplexer.
>>
>> Below is a schematic view of typical applications targeted by this
>> peripheral
>>
>>
>> Audio use case:
>>
>> 		mdf
>>              +-------------------------------------+
>> +------+    | +------+    +------+    +------+    |
>> | dmic | -> | | sitf | -> | mux  | -> | dflt | -- | -> audio device
>> +------+    | +------+    +------+    +------+    |
>>              +-------------------------------------+
>>
>> For instance, in an audio use case the serial interface can be configured to
>> provide the clock to the digital microphone (cck0, cck1 or both) at a common
>> predefined rate, and to retrieve the PDM samples.
>> The serial interface provides this samples to a digital filter, which
>> delivers PCM samples on its output.
>>
>>
>> Analog use case:
>>
>> 		mdf
>>                +-------------------------------------+
>> +--------+    | +------+    +------+    +------+    |
>> | sd adc | -> | | sitf | -> | mux  | -> | dflt | -- | -> iio device
>> +--------+    | +------+    +------+    +------+    |
>>                +-------------------------------------+
> 
> 
> So, looking at the docs and a brief chat with Jonathan about this
> device, I believe you've got things backwards and this is actually the backend,
> and the adc should be the one populating the io-backends property
> pointing to this device. You should have io-backend-cells, and I assume
> that there should be a cell for the adc to select which dlft it is connected
> to.
> 

There have already been lengthy discussions in the past about a DFSDM 
peripheral on STM32MP1, which has features similar to those of the MDF 
and similar implementation constraints. For the DFSDM, a solution based 
on an IIO backend had been upstreamed. The MDF follows the same 
architecture. I need to take a little time to dive back into this issue.

DFSDM sources:
drivers/iio/adc/stm32-dfsdm-adc.c
drivers/iio/adc/stm32-dfsdm-core.c

Here is a sample of DFSDM DT

sd_adc0: simple-sd-adc0 {
	compatible = "sd-modulator";
	#io-backend-cells = <0>;
	vref-supply = <&v3v3>;
};

dfsdm0 {
	compatible = "st,stm32-dfsdm-adc";
	...

	channel@0 {
		reg = <0>;
		label = "in0";
		...
		io-backends = <&sd_adc0>;
	};		
};

> I think all of these child nodes should just get deleted - all your
> devices here seem completely fake, since you've got stuff that's only a
> single word wide. With that, you could also throw away these mickey
> mouse nodes with sound-dai-cels of 0, and use 1 instead, with that cell
> again determining which dlft is in use.
> 
> The only child node I can really thing of any justification for here is
> channels - albeit not adc channels since this is not an adc - so that
> you can individually configure a dlft using those channel nodes.
> 
> These serial inputs, what is the source for the data that is ever
> actually sent there? I am assuming it's effectively another IIO device,
> just not the onboard adc? Are the outputs exposed on pins on the
> package?
> 
> I would encourage you to remodel this system, where this device is the
> backend and also try to get rid of as much of the consuming your own
> clock as possible. Certainly consuming ker_clk should never be required.
> It's hard to reason about what should happen with the serial interface
> clocks, when I have no idea what the input/data source device actually
> is in those cases. Being a clock controller does make sense, because the
> device exposes CCK0/1 to the outside world, it's the internal routing to
> the SITF blocks that I am not sure how to deal with. A ouroboros device
> that is consuming a clock it provides is not really a done thing,
> hopefully the IIO guys can tell you how these kinds of things are
> typically done here, since I'm sure there's plenty of other devices
> that have some sort of ability to change the clock source for a channel.
> 
> Probably you need to add two optional input clocks to this device, since
> mdf_cck0/1 can be inputs too?
> 
> Let me know if any of this feedback is intractable stuff, and maybe hang
> on for someone like David or Jonathan to provide some review before
> going about a significant rework. It's worth bearing in mind that I am a
> binding reviewer and not a domain expert in ADCs etc.
> 
> Thanks,
> Conor.
> 

Best regards
Olivier

>>>> +
>>>> +    properties:
>>>> +      compatible:
>>>> +        enum:
>>>> +          - st,stm32mp25-sitf-mdf
>>>> +
>>>> +      reg:
>>>> +        description: Specify the SITF serial interface instance
>>>> +        maxItems: 1
>>>> +
>>>> +      clocks:
>>>> +        description: |
>>>> +          Serial interface clock (optional depending on interface mode)
>>>> +        maxItems: 1
>>>> +
>>>> +      st,sitf-mode:
>>>> +        description: |
>>>> +          Select serial interface protocol
>>>> +          - spi: SPI mode
>>>> +          - lf_spi: low frequency SPI mode for low power applications
>>>> +        $ref: /schemas/types.yaml#/definitions/string
>>>> +        enum:
>>>> +          - spi
>>>> +          - lf_spi
>>>> +
>>>> +    required:
>>>> +      - reg
>>>> +      - st,sitf-mode
>>>> +
>>>> +    additionalProperties: false
>>>> +
>>>> +  "^filter@[0-9]+$":
>>>> +    type: object
>>>> +    description: Digital filter path child node
>>>> +
>>>> +    properties:
>>>> +      compatible:
>>>> +        enum:
>>>> +          - st,stm32mp25-mdf-dmic
>>>> +          - st,stm32mp25-mdf-adc
>>>> +
>>>> +      reg:
>>>> +        description: Specify the MDF filter instance
>>>> +        maxItems: 1
>>>> +
>>>> +      interrupts:
>>>> +        maxItems: 1
>>>> +
>>>> +      clocks:
>>>> +        minItems: 1
>>>> +        description: Internal clock used for MDF digital processing and control blocks.
>>>> +
>>>> +      clock-names:
>>>> +        items:
>>>> +          - const: ker_ck
>>>> +
>>>> +      dmas:
>>>> +        maxItems: 1
>>>> +
>>>> +      dma-names:
>>>> +        items:
>>>> +          - const: rx
>>>> +
>>>> +      "#io-channel-cells":
>>>> +        const: 1
>>>> +
>>>> +      '#address-cells':
>>>> +        const: 1
>>>> +
>>>> +      '#size-cells':
>>>> +        const: 0
>>>> +
>>>> +      st,cic-mode:
>>>> +        description: |
>>>> +          Cascaded-integrator-comb (CIC) filter configuration
>>>> +          - 0: MCIC & ACIC filters in FastSinc mode
>>>> +          - [1-3]: MCIC & ACIC filters in Sinc mode order 1 to 3
>>>> +          - [4-5]: Single CIC filter in Sinc mode order 4 to 5
>>>> +          For audio purpose it is recommended to use CIC Sinc4 or Sinc5
>>>> +          This property is mandatory for filter 0 or filters not used in interleave mode.
>>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>>> +        minimum: 0
>>>> +        maximum: 5
>>>> +
>>>> +      st,delay:
>>>> +        description: Filter delay in samples
>>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>>> +        maximum: 127
>>>> +
>>>> +      st,rs-filter-bypass:
>>>> +        description: Bypass RSFLT reshaping filter.
>>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>>> +
>>>> +      st,hpf-filter-cutoff-bp:
>>>> +        description: |
>>>> +          High Pass Filter (HPF) cut-off frequency expressed as a fraction of the PCM sampling rate.
>>>> +          Cut-off frequency = st,hpf-filter-cutoff-bp x Fpcm / 10000.
>>>> +          If this property is not defined the HPF is disabled.
>>>> +        enum: [625, 1250, 2500, 9500]
>>>> +
>>>> +      st,sync:
>>>> +        description:
>>>> +          Synchronize to another filter.
>>>> +          Must contain the phandle of the filter providing the synchronization.
>>>> +        allOf:
>>>> +          - $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +          - maxItems: 1
>>>> +
>>>> +      st,sitf:
>>>> +        $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +        items:
>>>> +          - items:
>>>> +              - description: Phandle of the serial interface connected to the digital filter
>>>> +              - description: |
>>>> +                  The phandle's argument selects the bitstream on the falling or rising edge
>>>> +                  of the serial interface clock:
>>>> +                  - 0: rising edge
>>>> +                  - 1: falling edge
>>>> +                enum: [0, 1]
>>>> +                default: 0
>>>> +        description:
>>>> +          Should be phandle/bitstream pair.
>>>> +
>>>> +    required:
>>>> +      - compatible
>>>> +      - reg
>>>> +      - interrupts
>>>> +      - dmas
>>>> +      - dma-names
>>>> +      - "#io-channel-cells"
>>>> +      - "#address-cells"
>>>> +      - "#size-cells"
>>>> +      - st,sitf
>>>> +
>>>> +    unevaluatedProperties: false
>>>> +
>>>> +    patternProperties:
>>>> +      "^channel@([0-7])$":
>>>> +        type: object
>>>> +        $ref: adc.yaml
>>>> +        description: Represents the external channel which is connected to the MDF.
>>>> +
>>>> +        properties:
>>>> +          reg:
>>>> +            maximum: 7
>>>> +
>>>> +          io-backends:
>>>> +            description:
>>>> +              Used to pipe external sigma delta modulator or internal ADC backend to MDF
>>>> +              channel.
>>>> +            maxItems: 1
> 
>>>> +
>>>> +        required:
>>>> +          - reg
>>>> +
>>>> +        unevaluatedProperties: false
>>>> +
>>>> +    allOf:
>>>> +      - if:
>>>> +          properties:
>>>> +            compatible:
>>>> +              contains:
>>>> +                const: st,stm32mp25-mdf-adc
>>>> +
>>>> +        then:
>>>> +          patternProperties:
>>>> +            "^channel@[0-7]$":
>>>> +              required:
>>>> +                - io-backends
>>>> +
>>>> +      - if:
>>>> +          properties:
>>>> +            compatible:
>>>> +              contains:
>>>> +                const: st,stm32mp25-mdf-dmic
>>>> +
>>>> +        then:
>>>> +          patternProperties:
>>>> +            "^mdf-dai+$":
>>>> +              type: object
>>>> +              description: child node
>>>> +
>>>> +              properties:
>>>> +                compatible:
>>>> +                  enum:
>>>> +                    - st,stm32mp25-mdf-dai
>>>> +
>>>> +                "#sound-dai-cells":
>>>> +                  const: 0
>>>> +
>>>> +                io-channels:
>>>> +                  description:
>>>> +                    From common IIO binding. Used to pipe external sigma delta
>>>> +                    modulator or internal ADC output to MDF channel.
>>>> +
>>>> +                power-domains:
>>>> +                  maxItems: 1
>>>> +
>>>> +                port:
>>>> +                  $ref: /schemas/sound/audio-graph-port.yaml#
>>>> +                  unevaluatedProperties: false
>>>> +
>>>> +              required:
>>>> +                - compatible
>>>> +                - "#sound-dai-cells"
>>>> +                - io-channels
>>>> +
>>>> +              additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +    mdf1: mdf@504d0000 {
>>>> +      compatible = "st,stm32mp25-mdf";
>>>> +      ranges = <0 0x504d0000 0x1000>;
>>>> +      reg = <0x504d0000 0x8>, <0x504d0ff0 0x10>;
>>>> +      #address-cells = <1>;
>>>> +      #size-cells = <1>;
>>>> +      clocks = <&rcc CK_KER_MDF1>;
>>>> +      clock-names = "ker_ck";
>>>> +      clock-ranges;
>>>> +      #clock-cells = <1>;
>>>> +      clock-output-names = "cck0", "cck1";
>>>> +      clock-frequency = <2048000>;
>>>> +
>>>> +      sitf5: sitf@300 {
>>>> +        compatible = "st,stm32mp25-sitf-mdf";
>>>> +        reg = <0x300 0x4>;
>>>> +        st,sitf-mode = "spi";
>>>> +        clocks = <&mdf1 0>;
>>>> +      };
>>>> +
>>>> +      filter0: filter@84 {
>>>> +        compatible = "st,stm32mp25-mdf-dmic";
>>>> +        reg = <0x84 0x70>;
>>>> +        #io-channel-cells = <1>;
>>>> +        interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
>>>> +        dmas = <&hpdma 63 0x63 0x12 0>;
>>>> +        dma-names = "rx";
>>>> +        st,cic-mode = <5>;
>>>> +        st,sitf = <&sitf5 0>;
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <0>;
>>>> +
>>>> +        channel@0 {
>>>> +          reg = <0>;
>>>> +        };
>>>> +
>>>> +        asoc_pdm0: mdf-dai {
>>>> +          compatible = "st,stm32mp25-mdf-dai";
>>>> +          #sound-dai-cells = <0>;
>>>> +          io-channels = <&filter0 0>;
>>>> +        };
>>>> +      };
>>>> +
>>>> +      filter1: filter@104  {
>>>> +        compatible = "st,stm32mp25-mdf-adc";
>>>> +        reg = <0x104 0x70>;
>>>> +        #io-channel-cells = <1>;
>>>> +        interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
>>>> +        dmas = <&hpdma 64 0x63 0x12 0>;
>>>> +        dma-names = "rx";
>>>> +        st,cic-mode = <2>;
>>>> +        st,sitf = <&sitf5 1>;
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <0>;
>>>> +
>>>> +        channel@1 {
>>>> +          reg = <1>;
>>>> +          settling-time-us = <1000>;
>>>> +          io-backends = <&sd_adc1>;
>>>> +        };
>>>> +      };
>>>> +    };
>>>> +
>>>> +...
>>>> -- 
>>>> 2.43.0
>>>>
>>

