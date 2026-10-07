Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEFB4756DF;
	Wed,  7 Oct 2026 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363765; cv=fail; b=W30kDfgbVmv7PX0bUe4HzyqWFuAh9eQcbfGuH1JvOaIuQyn+NJuZdKEcq3jtuDftXrTrWX+VaKHJnaV4kLog+ytjizZSLSvVrqmKbJ+uhQljx3stY+wYj0v03W5BGKVvZBiExBagTROp/pbeppduyOJDBPFpdv+nocBJZ0u41BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363765; c=relaxed/simple;
	bh=jcO3JEPSd72AcEv4uSfIzUQQyz/JWJ3HEvOsfHrslrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kZyQYLKmb547NA9RELPdNYwAW04UGuZrWkP8McXHyRiDGRn7fY8v5S1qkSShQdBLbgzJNlSFytRqqyq7gMIMd1cb8S71yRC9PSX5KQzhjdJZikEDUvO0PQlNgstVaovx7zvPYvHi38X4y2O0yJCrGsPh1pph8a61lmDM52lVnac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=l+aReN/B; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="l+aReN/B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZ+Gos5Vtuw+gDWsXkzTc+h5+wcml3b08OOZorX6i6uhAYsaZIaAVVsWHrT4KSdXSTS81WG2sOAGm5FXvFs5t6nOWxhQ3tdRE6Z788jE18GQ46L74JlTIx6YEzVO8jqXGYaU4vWTwM6LIMfLviU2IQEk+46tRAQA6f9p1kM7s4NmjC3KJDqCdBqDRz0kKfIgdmzaOYlR8jlMDEQdn1Dq7JRSZ1aZma4ezWbsOOfsxIKdDeBI3v6MvckASnSbimFUVdsPmuO8zfzgrZlMMzUaLiBprQDUKKj3dH73SGLkNbuyNtBihIfcT8Qog34dM8OQwirS80vdmqXJItGUKEqfRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvqHwLpqnuvN2ZF0b/YevVwXYLPucgCfw/DkuNMEEQ8=;
 b=q3t3/f7gZa73Jmn0D8EzD0GVOcfyg+o2M0UDNLhPQ0G4RLiuhhZecw+F3YFHqEZgjoGcJC7qtDhwixQAvRsc3z9fAb4UzmOVRcAdXkqr4Qs7NU3w8bn2oNw8Z2Jyf8/YFiJYAhZvQiJp1Sd4F+jsO4XKJfZbJO18wheJW/scmc6dj84Ig53uSZdPKGfS6IoNQPoMaRTnTBJUIwS0TeLZxdLayRknGMZsWuTby4PCTNCjPcEUetZ2vgIB0C7d4QCPsqVYuq4XZazUDw+Md2ZWavBlBASF46Rq2p4+NNglwriI7zTncshe1/gYrRpPz3zd8uDQ0d+1VPdDQEmja/xSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvqHwLpqnuvN2ZF0b/YevVwXYLPucgCfw/DkuNMEEQ8=;
 b=l+aReN/B2qyWliLZtCpq/Pv4t2ujTNN0kn+yKZfb4KJrl7GeDsg2dzbP8Qq6MsnWLwvmNdf+cvI4gjMH4wKnumCpR2kNE42G2uO+Z9Mb7G9NVhJM1VZx6ZIA+8Nop5psRWcHQ1KDeVqDIqy67eL4fqb8GGwJykwDThUlGQ/k5S+xbcCADMIJP/tdZUIWvim/kFd3c2lDNdA+XH+mDPfZfrNubbP1RVRysNyOoQQEy3MYZkXbs4/l/TuIsxfsB+Jj22wIjvngGXxmgcFLqyahlKjGsVQUpjCgYWtQAgfoU8D+dyAG08duTaUQSU1wD/aivbqiXdmJ8pMGcw4libvNDw==
Received: from VI1PR04CA0129.eurprd04.prod.outlook.com (2603:10a6:803:f0::27)
 by AS1PR10MB5365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 7 Oct
 2026 09:01:31 +0000
Received: from MI3PEPF00008484.eurprd02.prod.outlook.com
 (2603:10a6:803:f0:cafe::7f) by VI1PR04CA0129.outlook.office365.com
 (2603:10a6:803:f0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 09:01:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008484.mail.protection.outlook.com (10.167.240.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 09:01:31 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 7 Oct
 2026 11:07:35 +0200
Received: from [10.252.29.133] (10.252.29.133) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 7 Oct
 2026 11:01:29 +0200
Message-ID: <bb8af256-5a77-4215-9eeb-fbcd0cae1829@foss.st.com>
Date: Wed, 7 Oct 2026 11:01:28 +0200
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
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20261001-tribesman-gauze-862e1ef0cdd8@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008484:EE_|AS1PR10MB5365:EE_
X-MS-Office365-Filtering-Correlation-Id: 2323cc00-3212-4196-156a-08df24519471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|7416014|23010399003|82310400026|56012099006|11063799006|4143699003|22082099003|18002099003|6133799003|3023799007|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	DwgitnqTIOW1NDbnPsrjbkCfYODQUQnULDmdM9J8Qba7uWL0U3OpxrMWlKU/tUWZldvRde7nOeqf8xRhrK9svtmZuI+wjJu82RvP3R0mWrcAxJBCGuCCr8g2IzE2pLmLxDgwL8SYRxlyc28FbkX/0w2tCaHkp2qs6LAbr7iIyePFBuyvSokZOUAXHdJQuPs5Q2GZ6SM85Xq3o9uYAnmXSf1zkKhUv1MDE5EXYluJgE/gQVfsoIziAy/7XUYyTNRm8no+zqHdgDCEQDXmFFOriKREXESKaQGaT4UVAq56+hF7A2Epb5ivjzn5DkRdOhUv6Riqc8IeL7+n5pwDm21ufyGt5JtahG+hl12tVhg3dSroUgsasw0ooYS2GKUaszm32HgpQmaZxPblicjRX2W8Y8C48X/SOH6SUXB2Jn9tq9csMGaSou/LfVN7q35CwTu+A6cCboMme8d6ZPdvyqntotm9AE7l7krSGbAloHxEoc1br2TBzV0huNLP7ybeXmqCbhVs5yX+j7kjP7+nLVyp2ht2SGnJXLrzRN8ORbM7Ej4bf6mcJd52WvsPX3vIt/SScywXn565snxq3si/KWZo3YdPa/GgoxZe0Aqjc9qMu9/Rwo2+gCbdLcRjIY96Ng5maXWDul6kpSLDRHc5c+6ZQg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(7416014)(23010399003)(82310400026)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003)(3023799007)(10067099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5bVgGDZ6xTe0HQsynhDF8y2YOad8U3z5PdUs8ZJkKxxiA/wNs0Ws5W/gMSDlT2mBOlbmxFuGK4WIV6Q8uZxhuBXXBfIAMW3WkkrLY2giTKyvH8LgPfZMnIfulm7oBO9FQVr2mjlPnxxy2sSCl0gTuCB2mD3t1O9mDA5dxzRoxyNvwkSD62AdprnK1B3VLM7orTsMrHms3SVA+mH+9cFvvMtsEnmyDmrk85k6h1DpDOZgDuOc9GmyLBKxR6v7lXdvyObRRxWy0ZsPYB+5G0gHDHlUsZpmgCGosa6Jl29xVvzTPK7oktX0Kgcuj5bDX/ZnNcmLbkutQIJ4d3OTDu7eDxompUF3tMtIuV68/72c/Ear1zq9Kypa3qhnNZyyZE5oRwbyjTTyCzYSiq36vhih11p/i4WCaf3k+zfqoCm0Uv42XANYij8LWn9c0Sipe+c7
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 09:01:31.0520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2323cc00-3212-4196-156a-08df24519471
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008484.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5365

Hi Conor,

Thanks for the review

On 10/1/26 20:32, Conor Dooley wrote:
> On Thu, Oct 01, 2026 at 04:56:45PM +0200, Olivier Moysan wrote:
>> Add bindings that describes STM32 MDF settings to support
>> digital filtering for Pulse Density Modulation (PDM) microphones
>> and analog sigma delta modulators.
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
>> +
>> +  reg:
>> +    minItems: 1
>> +    maxItems: 2
> 
> This needs an items list here. The size of the regions seems like crap
> to begin with...
> 
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    description: Internal clock used for MDF digital processing.
>> +    items:
>> +      - const: ker_ck
> 
> This is pointless when you only have one.
> 

I agree that it could be dropped. However, it is useful for using 
devm_regmap_init_mmio_clk.

>> +
>> +  "#clock-cells":
>> +    enum: [0, 1]
> 
> Why is this not fixed? Also why are parts of your own device consuming
> the clocks?
> 
>> +
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
>> +
>> +  clock-frequency:
>> +    description: |
>> +      Common clock frequency (Hz) for CCK0 and CCK1 output clocks.
>> +      The frequency must be a multiple of the "ker_ck" clock frequency.
>> +    maximum: 25000000
> 
> Should not be needed, the consumers request what they need.
> 

The CCKx clock frequency depends on the maximum rate supported by the 
sigma delta converters (for instance a digital mic) and the expected 
decimation ratio on the bitstream. Typically this determines the 
frequency on the SPI bus.
This rate is defined statically and shared by the CCKx clocks. So IMHO, 
as this rate is unique, it can look strange to let the consumer define 
it. Moreover, it seems to me that clock-frequency is already used to 
configure the frequency of a provider in some other bindings.
For instance: Documentation/devicetree/bindings/clock/silabs,si570.yaml
So, it's not clear for me, what is the restriction on clock-frequency 
property.
>> +
>> +  ranges: true
>> +
>> +  clock-ranges: true
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    items:
>> +      - const: mdf
>> +
>> +  access-controllers:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
>> +      Phandle to the rifsc device to check access right.
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
> 
> No idea what these even are, but this is probably not the right way to
> represent the relationship between devices. They're apparently ADCs, but
> this is also an ADC so I'm not sure what's going on here at all.
> 
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
>> +  "^sitf@[0-9]+$":
>> +    type: object
>> +    description: Serial interface child node
> 
> Why is this a child node at all?
>   
> Probably not worth reviewing more without a link to the docs for this
> device so I can figure out what on earth is going on!
> 

The MDF is a digital filter for sigma-delta bitstreams, rather than the 
analog-to-digital converter itself.

Here is the link to STM32MP25 reference manuel
https://www.st.com/resource/en/reference_manual/rm0457-stm32mp2325xx-advanced-armbased-3264bit-mpus-stmicroelectronics.pdf
Chapter 45: Multi-function digital filter (MDF)

On STMP32MP25 SoC, the MDF provides 8 serial interfaces (SITF) and 8 
digital filters (DFLT) which can be connected through a multiplexer.

Below is a schematic view of typical applications targeted by this 
peripheral


Audio use case:

		mdf
             +-------------------------------------+
+------+    | +------+    +------+    +------+    |
| dmic | -> | | sitf | -> | mux  | -> | dflt | -- | -> audio device
+------+    | +------+    +------+    +------+    |
             +-------------------------------------+

For instance, in an audio use case the serial interface can be 
configured to provide the clock to the digital microphone (cck0, cck1 or 
both) at a common predefined rate, and to retrieve the PDM samples.
The serial interface provides this samples to a digital filter, which 
delivers PCM samples on its output.


Analog use case:

		mdf
               +-------------------------------------+
+--------+    | +------+    +------+    +------+    |
| sd adc | -> | | sitf | -> | mux  | -> | dflt | -- | -> iio device
+--------+    | +------+    +------+    +------+    |
               +-------------------------------------+


Best regards
Olivier

> Thanks,
> Conor.
> 
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
>> +      compatible = "st,stm32mp25-mdf";
>> +      ranges = <0 0x504d0000 0x1000>;
>> +      reg = <0x504d0000 0x8>, <0x504d0ff0 0x10>;
>> +      #address-cells = <1>;
>> +      #size-cells = <1>;
>> +      clocks = <&rcc CK_KER_MDF1>;
>> +      clock-names = "ker_ck";
>> +      clock-ranges;
>> +      #clock-cells = <1>;
>> +      clock-output-names = "cck0", "cck1";
>> +      clock-frequency = <2048000>;
>> +
>> +      sitf5: sitf@300 {
>> +        compatible = "st,stm32mp25-sitf-mdf";
>> +        reg = <0x300 0x4>;
>> +        st,sitf-mode = "spi";
>> +        clocks = <&mdf1 0>;
>> +      };
>> +
>> +      filter0: filter@84 {
>> +        compatible = "st,stm32mp25-mdf-dmic";
>> +        reg = <0x84 0x70>;
>> +        #io-channel-cells = <1>;
>> +        interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
>> +        dmas = <&hpdma 63 0x63 0x12 0>;
>> +        dma-names = "rx";
>> +        st,cic-mode = <5>;
>> +        st,sitf = <&sitf5 0>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        channel@0 {
>> +          reg = <0>;
>> +        };
>> +
>> +        asoc_pdm0: mdf-dai {
>> +          compatible = "st,stm32mp25-mdf-dai";
>> +          #sound-dai-cells = <0>;
>> +          io-channels = <&filter0 0>;
>> +        };
>> +      };
>> +
>> +      filter1: filter@104  {
>> +        compatible = "st,stm32mp25-mdf-adc";
>> +        reg = <0x104 0x70>;
>> +        #io-channel-cells = <1>;
>> +        interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
>> +        dmas = <&hpdma 64 0x63 0x12 0>;
>> +        dma-names = "rx";
>> +        st,cic-mode = <2>;
>> +        st,sitf = <&sitf5 1>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        channel@1 {
>> +          reg = <1>;
>> +          settling-time-us = <1000>;
>> +          io-backends = <&sd_adc1>;
>> +        };
>> +      };
>> +    };
>> +
>> +...
>> -- 
>> 2.43.0
>>

