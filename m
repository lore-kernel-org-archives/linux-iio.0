Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DF84A0922;
	Tue,  6 Oct 2026 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301769; cv=fail; b=UfkYVQ7Cg/VeuKKj5UL6/RnadpLSw1oXmVKIu9iPWOCjsI07OidzZ5kGrcOiOYfVP40d7IptYX9PSfKFdVoqFr+JaU1hXAJhUMdI0ZPZ/Udcr36fnxWaNG9BlPHfjDATIYkviwh6TTkzMhOTL7RpAtzTxMLXK9NFT49CJby7hcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301769; c=relaxed/simple;
	bh=Oiy+vc59j7euMKP3sS4460KE7NmrYJjlh4416szVrxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tx84IgR1D645hs1JCpkgP50EcnZ1U6fFiiO76cu99JYYE++aKYqrpeUIK9qnbZyCbR3GgirUf8Tcr0vrkk1dYW5qQ6lJnRkshkiVb/tvzNx8t2V4W5s/gGXApkgITVfHyjYYymJs9jvHhMMnoVAs/5dhR1i02C207koLIAhmdAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=In0cGU2x; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="In0cGU2x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZOeNWJmKLMXAW08iGGHkDaI5h0OQzl7ksfMWf1M0q0QLEP4+M6OXaETlXagiVVTOpXVpzu2aH9c2A75F6FAkhPzSF/uTo+pE0hf3jpCpLJ85lGuEhfq2sioBQuAE84fBxwV47ddwYGKEXv0YqWzTUecB+8S+v2qMU+tL3Cag+QHn8m7sRPdmglPvFQ/QaT5kau5z9gbGdesei5E1qPQOJZOOEisvb64DUlUsRWhv112NSBXE9H9ukidUQkHxC36Dv2O/Vm+QNTaWCnBl99qIzqHt3CVb8gYHacT/txB8ohTkzDTxVAnsdjDvmyvvpXvDhchEBcG7dfLZvuwYFxsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKP6/yp0P7AgIYEvTJ/q9LUGXP7+ecdzNHuLMGR8ad8=;
 b=XB5PQO/72y4gSh3SlI2vGVJM52mO2CBlZzeVNZeO4EIXPTOwTEEyA/7j9/UeeV2+SxGoc7lm/9jIeNctJfmaIMrby44SyTK9gDtcDpbeyRV80AofaoaLEJnjvUoIlUQ+xf6Gv+yA5cOi42FPf9+EsSWCqU4iIew+8zWYmLWKjNs8yjrSwACpg2PjXOcK5koOMb5YKPgs5x1iN1AyrzE1r6d9aVfoZZ4PiEAz9E+uPi/xwtH7XRd5c1tWC0reX/YINBPXZEu9bAP8Qw5zje6smb3f2q0+Oz0ZT+NjoisMWDuyLjlQTw0S1ih4HkCd8YKs/uT36b9OdLRlblHhURdQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKP6/yp0P7AgIYEvTJ/q9LUGXP7+ecdzNHuLMGR8ad8=;
 b=In0cGU2xkQtmJJoGwHhGw8yFVrnZgCj4AnK/g9p4Z+umCWm5/Ph1t4nkXqalgQDNVitrIMQDvQDCvI55wuJuwVctwk4Xu63m0FFqMjmw/zn2VxSLOir+cDmvJBb4rghCsYSwDnoxeB0xQE3dpFrq7bjVtUathrKPZBEKXXh9K/VKGiTZ9xsaV6zhEb/sgC5GZokkgVWQEC2oj24gCvBxOLULsK2rDQPTWsWMdr0SD5B1ILnRdrRGPYiTordlccXnr973b991xt+GLVEwniUBm5k9xV2hxTJL2yPgJX2VR6Z5nn5GE47mKEk9eDME0YZAbgbWwIe72OJ/XLbUzHoROw==
Received: from PA7P264CA0299.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:370::10)
 by AS2PR10MB7602.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:545::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 15:49:10 +0000
Received: from MAD0EPF000008A9.eurprd04.prod.outlook.com
 (2603:10a6:102:370:cafe::92) by PA7P264CA0299.outlook.office365.com
 (2603:10a6:102:370::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Tue, 6
 Oct 2026 15:49:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008A9.mail.protection.outlook.com (10.167.241.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 15:49:09 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 17:55:55 +0200
Received: from [10.252.29.133] (10.252.29.133) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 17:49:08 +0200
Message-ID: <57322a17-7fae-434a-b60a-f879855cbb2b@foss.st.com>
Date: Tue, 6 Oct 2026 17:48:36 +0200
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
 <20261002-pragmatic-smart-piculet-cacb3e@quoll>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20261002-pragmatic-smart-piculet-cacb3e@quoll>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008A9:EE_|AS2PR10MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: f79f09a2-a5f8-4bf8-e059-08df23c15cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|7416014|22082099003|18002099003|13003099007|56012099006|4143699003|6133799003|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	OFCDU9WASux/X97I2Szx7dcj5yWhK11tFcE7qcpQtENc3fKDQxyJ3lRg6mFz1fqV08IFSaknrYhxPv7Ni5F3Jpba/8M2fGgt7F55YmCn5HIQ2goCk7Dm2WTNzHVj6xeF/Vzfao5M5J7idAUhYTY8uhA6LjqqzIt4lZBkag2lat7kX/+N4eqm1XsAUhaWZGADcWKmi0Tb9zZqT9Dq64oGrxurSYSWis/WWt005zuWgSiQZqv0UG+DycOmG2Vvq6ATLpt1i4G5Y2r01HgOQgXLq2EXBO54trNyIE+m+8IC0WGQ0IvbdDb0ac8zoytyYRHSRp+XwAfXAf9KE63TlI71Y7tXN18TS9cGJSaLTuQndpz+4AIdLwjp6L6huPGwiFGjvAOyFRRpCJjJvfqrlNak8oKFYdkrnDUlMod+bUrIux/4FwQBtISI7o4UPxNxLCd9w8y0RzQRL0BGHUAYbwhKEcfYtgvVDLRwDT7K5NtHDyx+PxoJRbszAV+iOi1WRGoIylk/ysVWrRbXWklO07zoXTiF3bozOGcgWqthdzF9Y3khlHZBtQSp22KH59o4HExejspsA1wGVOKuaRBMapwPQChO7dFqareBfwoxqnc7gAsr50n0qdKntlU4AwT9N4TPFlQh3wW94ZlaQ2z6RYvRHg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(7416014)(22082099003)(18002099003)(13003099007)(56012099006)(4143699003)(6133799003)(3023799007)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4znojw9G7pgG4StyXNxRJWEYSM7f74as0//8VIXgJQ8G7vNtsN1gSqU548ZiagR4H4lm08c+56LNx3J6axxc2hgz3bENknpTgQB4wWFw7Ru1RgW9NPVGp0I1aEMNNdTnjaop/5PPQfArVacTRUiWZd4kufPAHKTl6Qu6qeyDQqrnpUY5xB5f8XOPClmXCzO4u4KG1gaVJ2uQJ+CRlbBWcfW8Dugc2CxiOUvQqaMGjA3ZA5RA1kLoMdt3RXlOXnllRCR/WH1MjaM2m4KJ0Y+salpHPLtzrX5RkiB7qQUjiqLH49GUgFCxzs6pe8XnW9Fz7n6Nw7t80WK4mj6FDG4OF6cQ86YolU++ttCmisNfav9/9g96ooICK35oBv7/dt6k4fA39aKDRTqHDOnJdnFD4prOcM+ZWyb6qC8xf44rGbp096wpkFdSXJ2IXkZryQ1v
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 15:49:09.9960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f79f09a2-a5f8-4bf8-e059-08df23c15cb7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008A9.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7602

Hi Krzysztof,

Thank you for the review.

On 10/2/26 11:22, Krzysztof Kozlowski wrote:
> On Thu, Oct 01, 2026 at 04:56:45PM +0200, Olivier Moysan wrote:
>> Add bindings that describes STM32 MDF settings to support
>> digital filtering for Pulse Density Modulation (PDM) microphones
>> and analog sigma delta modulators.
> 
> You already received review, so a few things on top to spare you one
> more cycle:
> 
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23
> 

Done

>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> ---
>>   .../bindings/iio/adc/st,stm32-mdf-adc.yaml    | 383 ++++++++++++++++++
>>   1 file changed, 383 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
>> new file mode 100644
>> index 000000000000..f2fbc3e150e8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
> 
> Filename follows compatible, so st,stm32mp23-mdf
> 

stmp32mp25 is the main SoC, while stm32mp23 is a variant.
file renamed st,stm32mp25-mdf.yaml

>> @@ -0,0 +1,383 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/st,stm32-mdf-adc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STMicroelectronics STM32 Multi-function Digital Filter (MDF) ADC
>> +
>> +maintainers:
>> +  - Olivier Moysan <olivier.moysan@foss.st.com>
>> +
>> +description: |
>> +  STM32 MDF ADC is a sigma delta analog-to-digital converter dedicated to
>> +  interface external sigma delta modulators to STM32 micro controllers.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - st,stm32mp25-mdf
>> +      - st,stm32mp23-mdf
> 
> Why reversed order?
> 

Ok. Reordered alphabetically

>> +  ranges: true
>> +
>> +  clock-ranges: true
> 
> Do you need it here?

clock-ranges property is used to allow the filter child nodes to inherit 
the MDF kernel clock from the parent node.

> 
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    items:
>> +      - const: mdf
> 
> Drop
> 

reset-names removed.

>> +
>> +  access-controllers:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
>> +      Phandle to the rifsc device to check access right.
> 
> Look at other code how this is done. Don't come with own stuff.
> 

Replaced by:
   access-controllers:
     maxItems: 1

>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  st,interleave:
>> +    description: |
>> +      List of phandles of interleaved filters. The indexes of interleaved filters must be
>> +      consecutives starting from 0 (i.e in range [0..N]). The samples from interleaved filters
>> +      are muxed in a single channel and retrieved through the device associated to the filter 0.
>> +      The filters 1..N have to be enabled, but inherit their configuration from filter 0.
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - ranges
>> +  - clocks
>> +  - clock-names
>> +  - clock-ranges
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +
>> +additionalProperties: false
>> +
>> +patternProperties:
> 
> And this has odd order. Please look at example-schema.
> 

ok. Reordered.

>> +  "^sitf@[0-9]+$":
>> +    type: object
>> +    description: Serial interface child node
>> +
>> +    properties:
>> +      compatible:
>> +        enum:
>> +          - st,stm32mp25-sitf-mdf
>> +
>> +      reg:
>> +        description: Specify the SITF serial interface instance
>> +        maxItems: 1
>> +
>> +      clocks:
>> +        description: |
>> +          Serial interface clock (optional depending on interface mode)
>> +        maxItems: 1
>> +
>> +      st,sitf-mode:
>> +        description: |
>> +          Select serial interface protocol
>> +          - spi: SPI mode
>> +          - lf_spi: low frequency SPI mode for low power applications
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +        enum:
>> +          - spi
>> +          - lf_spi
>> +
>> +    required:
>> +      - reg
>> +      - st,sitf-mode
>> +
>> +    additionalProperties: false
>> +
>> +  "^filter@[0-9]+$":
>> +    type: object
>> +    description: Digital filter path child node
>> +
>> +    properties:
>> +      compatible:
>> +        enum:
>> +          - st,stm32mp25-mdf-dmic
>> +          - st,stm32mp25-mdf-adc
>> +
>> +      reg:
>> +        description: Specify the MDF filter instance
>> +        maxItems: 1
>> +
>> +      interrupts:
>> +        maxItems: 1
>> +
>> +      clocks:
>> +        minItems: 1
> 
> Heh? so here min? Is there any logic in your choices of code style?
> 

As the filter node always use the kernel clock from parent node we can 
remove "clocks" item. "clocks" is not relevant here as the filter is not 
supposed to use another reference.
clocks & clock-names removed

>> +        description: Internal clock used for MDF digital processing and control blocks.
>> +
>> +      clock-names:
>> +        items:
>> +          - const: ker_ck
>> +
>> +      dmas:
>> +        maxItems: 1
>> +
>> +      dma-names:
>> +        items:
>> +          - const: rx
>> +
>> +      "#io-channel-cells":
>> +        const: 1
>> +
>> +      '#address-cells':
>> +        const: 1
>> +
>> +      '#size-cells':
>> +        const: 0
>> +
>> +      st,cic-mode:
>> +        description: |
>> +          Cascaded-integrator-comb (CIC) filter configuration
>> +          - 0: MCIC & ACIC filters in FastSinc mode
>> +          - [1-3]: MCIC & ACIC filters in Sinc mode order 1 to 3
>> +          - [4-5]: Single CIC filter in Sinc mode order 4 to 5
>> +          For audio purpose it is recommended to use CIC Sinc4 or Sinc5
>> +          This property is mandatory for filter 0 or filters not used in interleave mode.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        minimum: 0
>> +        maximum: 5
>> +
>> +      st,delay:
>> +        description: Filter delay in samples
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        maximum: 127
>> +
>> +      st,rs-filter-bypass:
>> +        description: Bypass RSFLT reshaping filter.
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +
>> +      st,hpf-filter-cutoff-bp:
>> +        description: |
>> +          High Pass Filter (HPF) cut-off frequency expressed as a fraction of the PCM sampling rate.
>> +          Cut-off frequency = st,hpf-filter-cutoff-bp x Fpcm / 10000.
>> +          If this property is not defined the HPF is disabled.
>> +        enum: [625, 1250, 2500, 9500]
>> +
>> +      st,sync:
>> +        description:
>> +          Synchronize to another filter.
>> +          Must contain the phandle of the filter providing the synchronization.
>> +        allOf:
>> +          - $ref: /schemas/types.yaml#/definitions/phandle-array
>> +          - maxItems: 1
>> +
>> +      st,sitf:
>> +        $ref: /schemas/types.yaml#/definitions/phandle-array
>> +        items:
>> +          - items:
>> +              - description: Phandle of the serial interface connected to the digital filter
>> +              - description: |
>> +                  The phandle's argument selects the bitstream on the falling or rising edge
>> +                  of the serial interface clock:
>> +                  - 0: rising edge
>> +                  - 1: falling edge
>> +                enum: [0, 1]
>> +                default: 0
>> +        description:
>> +          Should be phandle/bitstream pair.
>> +
>> +    required:
>> +      - compatible
>> +      - reg
>> +      - interrupts
>> +      - dmas
>> +      - dma-names
>> +      - "#io-channel-cells"
>> +      - "#address-cells"
>> +      - "#size-cells"
>> +      - st,sitf
>> +
>> +    unevaluatedProperties: false
>> +
>> +    patternProperties:
>> +      "^channel@([0-7])$":
>> +        type: object
>> +        $ref: adc.yaml
>> +        description: Represents the external channel which is connected to the MDF.
>> +
>> +        properties:
>> +          reg:
>> +            maximum: 7
>> +
>> +          io-backends:
>> +            description:
>> +              Used to pipe external sigma delta modulator or internal ADC backend to MDF
>> +              channel.
>> +            maxItems: 1
>> +
>> +        required:
>> +          - reg
>> +
>> +        unevaluatedProperties: false
>> +
>> +    allOf:
>> +      - if:
>> +          properties:
>> +            compatible:
>> +              contains:
>> +                const: st,stm32mp25-mdf-adc
>> +
>> +        then:
>> +          patternProperties:
>> +            "^channel@[0-7]$":
>> +              required:
>> +                - io-backends
>> +
>> +      - if:
>> +          properties:
>> +            compatible:
>> +              contains:
>> +                const: st,stm32mp25-mdf-dmic
>> +
>> +        then:
>> +          patternProperties:
>> +            "^mdf-dai+$":
> 
> This makes no sense. Why is this a pattern and why mdf-daiiiii is
> correct name?
> 

"^mdf-dai$" is intended here

> Not mentioning that your are not supposed to define properties in if
> block (do you see any code like that?). Mixing addressable and
> non-addressable children is another odd thing.
> 

This binding is inspired by the one already adopted for the DFSDM
https://www.kernel.org/doc/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml

I assume can move the mdf-dai node definition outside the conditional 
branch easily.
However, it seems to me more complicated to avoid mixing addressable and 
non-addressable nodes here. Can we keep this binding aligned with the 
DFSDM model? Or would you have another suggestion?

> This entire schema is quite chaotic and overcomplicated.
> 
>> +              type: object
>> +              description: child node
>> +
>> +              properties:
>> +                compatible:
>> +                  enum:
>> +                    - st,stm32mp25-mdf-dai
>> +
>> +                "#sound-dai-cells":
>> +                  const: 0
>> +
>> +                io-channels:
>> +                  description:
>> +                    From common IIO binding. Used to pipe external sigma delta
>> +                    modulator or internal ADC output to MDF channel.
>> +
>> +                power-domains:
>> +                  maxItems: 1
>> +
>> +                port:
>> +                  $ref: /schemas/sound/audio-graph-port.yaml#
>> +                  unevaluatedProperties: false
>> +
>> +              required:
>> +                - compatible
>> +                - "#sound-dai-cells"
>> +                - io-channels
>> +
>> +              additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    mdf1: mdf@504d0000 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> If you cannot find a name matching your device, please check in kernel
> sources for similar cases or you can grow the spec (via pull request to
> DT spec repo).
> 
> And drop unused labels.
> 

The MDF is a digital filter for sigma-delta bitstreams, rather than the 
analog-to-digital converter itself. So "adc" would not be adapted. I did 
not find "filter", that probably would be the more relevant generic name.
The closest similar case is the DFSDM peripheral, which already uses a 
specific naming:
     dfsdm: dfsdm@4400d000 { ...
https://www.kernel.org/doc/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml

What is your recommendation: keep the naming "mdf" or make a pull 
request to add "filter" or another more appropriate name ?

>> +      compatible = "st,stm32mp25-mdf";
>> +      ranges = <0 0x504d0000 0x1000>;
>> +      reg = <0x504d0000 0x8>, <0x504d0ff0 0x10>;
> 
> Address ranges of 2 and 4 words?
> 

These two sections correspond to MDF common registers managed by the core
- Control registers: 2 x 32 bits registers
- Identification registers: 4 x 32 bits registers
The other registers are managed by filter and serial interface driver

> Best regards,
> Krzysztof
> 

Best regards
Olivier
