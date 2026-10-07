Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579883D1AA2;
	Wed,  7 Oct 2026 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791388980; cv=fail; b=qhPDvW7zAj6wMss0IM+zw7T7hUgNwh5Ao5vccNS6Qn/RKStmZlFL2tGXb0H4vmp+gnV8sXTUFVPEYBiNsSenFYEuEJEkzZavPq3VXU/IVQfJIsleWEBBaZnAWTnjRS0BJhL53Ho9jcj4PKPzwRoV6s/wAH0kVzg9u31nxDs78Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791388980; c=relaxed/simple;
	bh=GdT5AVgCYrYDCq8skm3ypahO6k11wtz8owHYN4RdXrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NwSvaV2OOr/gEgpwcS9V7DugAQNH38N0EY21WlhBUBZd7RhDEQaG0Earc12l/qz5dEI+123SyZ3n69V1qd41u6TSqwB60qBh/rxVBg/E+6D5y1m6lgorCYjQWjJIGhTdn30dmPPlJlTjEZsnaMtZeSKCNykM9cXPu7IktMjwCVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gCuqMHDM; arc=fail smtp.client-ip=52.101.70.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gCuqMHDM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkC0zxGl1558EMpo/JIN+kK3n4eo8ZYUOn4NF4a8c8cbOaWZGJci158mpLJ/XY3w9QvEBgvyOiIo/5sdcs2csipXNNDlB7RnCedNfFKXKnng2bf3NsY5uhz1MuDs/8wUE11/NWSjVUUqp8JCynyOof0KiRThkpxA5xgMuNn5rjCBgsMBdiXN5ciSYWPl8GjIr1y0k63xmhc18RLyaYyvO9dYnAkBsvCVarZtKrvvDVYd9f/gd50R9LX6U7q179OIlB0wdlHc8+ZdUycOPYY0vY0oELe0C1cxLCR71UZoUfGxpVZ8l3+Is15QHc7dS8u1RdVpo5UUIv6sVwYDrvn0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayY1qntB3Q0I9nj9GwC4lUQQG2QMB776/yGYyhijWr8=;
 b=KgCnqbN3vyQ1z5L3pTP5iqfwV7pkIM3iV4sxWuxx9pr4gIfJAYmnYiN1NTZ1VI+mo7uPhwA+rcOJOkHWdiuCDsndrJF48Q6l/28SbT+eln4UP7RuzQ+8cec0vuP6nfv4VImhRppMdpJDSJ19PlXw1HbL7/FTMcEsBx9EKdLnjqNPOzrBPvwacRkmkAAqg3CnsJGyplUckSLX35Vx+vb5H6scWCgH+SHTnDyJ8eGC9+SF4VWTGt0yC9jWL3l4YA9pmN9/P7wGF1jicJrG/ENBqXvbpGDR2r/hDhmW0VAsyGI6UC4q2ddlS+oifg+tCLmU1lJyVN9ZtwT8O3om2igELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayY1qntB3Q0I9nj9GwC4lUQQG2QMB776/yGYyhijWr8=;
 b=gCuqMHDMxlwEi6E8jS5VTll5sgahnP10ZgoEQyveXVKoYH8+N3nQjwLYGU+F/4h1F65zarhz/Zx8ZNtxZhQd2cu8lRdunFxxr4QSydzNFl0oQYvQjMbrN1G9nPWjXJLgGt6JfDp3G7+6FmElgV6t4J7krgAZafYl7ImDz+iwnmW7MY/kg5VJlm2bcC7Hq8ceb6rIWdFb/6hgGIzzbEbArNRd3Ls1U461CRyz4dMgOYkfsKvZZEOSxuhFFwtcFzmpBsJIOtIe/Fj2GFsbEIZamBqXai+yEe9qHLjn2L28bz4Ja8b016Ry7NTUQzWiY6t7jL8wj9bN6uzQoFt/XXw59g==
Received: from DUZPR01CA0064.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::17) by AM7PR10MB3479.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:139::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 16:02:53 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:3c2:cafe::1) by DUZPR01CA0064.outlook.office365.com
 (2603:10a6:10:3c2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 16:02:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 16:02:52 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 7 Oct
 2026 18:09:38 +0200
Received: from [10.252.29.133] (10.252.29.133) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 7 Oct
 2026 18:02:51 +0200
Message-ID: <7cfb5d1e-b79a-4f95-9724-70818c82b379@foss.st.com>
Date: Wed, 7 Oct 2026 18:02:49 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add bindings for stm32 mdf
 filter
To: Rob Herring <robh@kernel.org>
CC: Conor Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-2-olivier.moysan@foss.st.com>
 <20261001-tribesman-gauze-862e1ef0cdd8@spud>
 <bb8af256-5a77-4215-9eeb-fbcd0cae1829@foss.st.com>
 <20261007134750.GC2792240-robh@kernel.org>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20261007134750.GC2792240-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|AM7PR10MB3479:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b1921b-9e0a-4343-1223-08df248c714f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|7416014|13003099007|4143699003|11063799006|3023799007|10067099003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Eiv1BBSP8d0TEKtTCs2T5VNg1WKbpCIRnAXH30mgBmIHtGfOdoCxodAko8FZ3nVHdcladtX/Cp2AUFhZIVlms+a+wHukTn+PfSn6uODexiyhlcPobzt3/siIpiGcICs//p7oqGj9bqR/okEhcHx7uY084bxFa4JBGoyLGV1rLhs+4hhqno6Dj4YPVQL499ogbMF6/TEsub4nhehAxj4D5r/Yg4reXZWfAIwjrpY739D0el49rq/bCD7toQM60bcWfoxhAGhIgz1Zl1edaTsPdFAYS1UZzi2KhG6/yV2+PR5cJr3BKnfiQLx0KgcBnEHqtfBQdGpKQ+myR+Es9Fs7wA10EsUlddTrAqnxKDyY5U2uSQWWivGmB4ElKtfqlAmu4h1qU4KOnMTBmlzHZ5UOtqhe9VmVgMveCHx9ogTIIWeWv5AFeoFAui82hZ5LrVeCGyHigprERwUsnxA4hgSstCGV9LVVFGpQfNhd1VoKfRwlur55UW94bStKQb438PTXdUzJV1Vc6/ImucyHPLlKwZy+vS/Bk88bEFL5nYKcU6DuxtWYy6bg7ZgewBdGjWn78kWSVK3DOxsfNrtFE82oM1eNmvD5+1KFhGkeif8kTwP8Aq1bj/m6mhePuicFQ95NQ1HwoyJvPlhwrgy4DYsdyw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(7416014)(13003099007)(4143699003)(11063799006)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u4mbWDaC63UoaWqfNrQBoPhmgU06MyILkPKrwbtS1u/duCWZnDJK4AlbpRCGSQHbxgQKIhEP9CwsZ8Nrmrd3CAvxV/S+VYDQggIusiDiMTEDRsQbKEEZwCTtQC/KXsi/w0w/K/cMmqDrgwUVSxG0od5E9W5jesSxc1GN8NVcU8k+y7lq2gjQyRS2iOkIDWXE0b9oVNHQCq0X8UTTAvvxOJKbgGzunFsZd4sZ6k+24S4DIJgm0kKpTaSOJ+tDWmQ5LmEc0FOciw2V29O6z/9ssWtb1I0Edd8SRIVLaQL21CEln6e5ZUiNGM+R8dwdfvXe/MDRiskkV+5LLYOkGzWj4O7pR8yqaCVi0xbFxSPQiACDr1d1iuwEwUFGB5UPwNdKiGhU9/nJTYuOJTcUynVzFsnHMH7otRI/AvIy6ocSyts0BrIlYIHKj9+tNGH1QIFF
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 16:02:52.3716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b1921b-9e0a-4343-1223-08df248c714f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3479

Hi Rob,

On 10/7/26 15:47, Rob Herring wrote:
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
> I don't know what that function is/does, but that's not justification
> for bindings. Maybe you need a helper that handles a single clock. Or
> that function could take a NULL string for single clock?
> 

Ok. I will drop this clock, and use a helper to replace 
devm_regmap_init_mmio_clk api calls.

>>
>>>> +
>>>> +  "#clock-cells":
>>>> +    enum: [0, 1]
>>>
>>> Why is this not fixed? Also why are parts of your own device consuming
>>> the clocks?
>>>
>>>> +
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
>> So, it's not clear for me, what is the restriction on clock-frequency
>> property.

Would you have any feedback regarding clock-frequency property usage ?

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
> I don't under it either, but regardless phandle-array needs constraints
> on the items. It's really a matrix with array of phandle+args arrays.
> 

What is expected for this property is a list of phandles (from 2 to 8)
For instance: st,interleave = <&filter0 &filter1>;

So, if I just consider the missing constraints, I need to add
     minItems: 2
     maxItems: 8
     items:
       maxItems: 1

Is this correct ?

> Rob

Best regards
Olivier
