Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazhn15012015.outbound.protection.outlook.com [52.102.160.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF455349C8;
	Wed, 14 Oct 2026 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.160.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996718; cv=fail; b=MB8WUfe+WM8WFEzcpy3Se35F/ZTIAijTRt7ZvUad/gtPdbkM2DtAwDAog85xqyWXlayHSQJGEwOtVo9S13mxUxh2+yvFdNASss+Awfn52y5LtvddbkrJmO4qbIodQyr6A7LD9weUk+uIo0PIquuKJ2HpgdSWhrVBXKddzNWwpJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996718; c=relaxed/simple;
	bh=6uNTYzrb6vx2YgY+8ywdAfDkucRiFSV2VET+rvy9Fbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZekJ3f1UrxHrcvj6vSZwxC+rFkxNo5UwTIbspMy9gRJlGCmzo0Xg86BMoGuPBVK38dcBVZG2DadZ0hnA4XAn7Hn7Ben528OTKzL7KUEWUCwveE+8FRhakI8FNG5Wu+9YAyWNEzyQCNdhkG9iUmU9+ppN0stNK2JWvG/aVIYAUvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=b49GJ3nI; arc=fail smtp.client-ip=52.102.160.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="b49GJ3nI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvU0b/OrlSzQySId3lrp05k7RN3n9jUYoLF9ge3/yLlsgmGuaEgCG4iPNrXqxpsi1P0+WuFPfOkLYcLHSZbPB6+g3EbRyAMPrLYWjoJIyKcnP5Sv6V7X/YQvAvs8Dcml1PYGVSky7Zqu5idqhbaPw+2GWelDCH1Gm8AKI/OJTQbr+aMJPj0VZ0qcy70J97gG/h3LB9jbDAqVmXvm0E118QPN1L5d3IOyICDjNg9Nq8e3PGxugufPIvH+ztLXAzTAwpMSz2MfABDb216EhT4FNMXozWfcIUv62Ges1pZgv+HQdwIMWl9r81yzgoXdN0eTzyS9u1YiB5U74PDtXgYsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZwyU5LOI3bGA37KDtA2toNoFMqyisx/bhH89n/m4Ms=;
 b=IF5YYpzpKAR0nFTqlC0m/tbvGG79tCaJZc9Bw92Lr7eBcOrZnmDffFpiOOWr3Ypflc2pgvQA8nNmBMXs0nsChCgInG0xZjDEt8ej6MKVj+tvwzkvuf3QnAEKcrj0PI6g4y8uNP980ZOZ2op9VekoJnIvEpSDelW5iyh6dHHko8457l1qU//yVpwJtlgmhvlRKIBVAN8DTjVgGT46ixFq2WU7ZfBNKV4dTpRpbbBcs8bSiB8kgNUjBsy/QVm0QyyMuklHCrue5T1CJ4Nk4E+8SBkiVC+KNPJIzpon1AXopa40hv2CCDGo44lv7R/ASLQSl69JiDyvQ5jyURxwejOxXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZwyU5LOI3bGA37KDtA2toNoFMqyisx/bhH89n/m4Ms=;
 b=b49GJ3nI1ZjxlnO/UHot+gUg9TAWmiHnUs8nKIIJyd93aKtEmUrmPWiP3aGgz+gI13p1piXhu/sWRtGvtc5MKAxZcJG4kfeWGSAqClnjq9ARihsl5TWAGP44Xg43uwvULWL2fJPTp1Hwh2BTWjBrEUTgkTuClMltY3YgBk8bGaV0tHOBB8R0fgNqXsIqKjOPNwYJlgJl45oBEY+tFfn3i3CC2uMbb8CebfByGuvDD5OiH7vCT6X8e7p3sUziVobyDQQnIURqELbBw/reUUpDgO7bZavJvTdE9m95yV75/ZFq3A81GNvX7kjOqe/UrXTQt7O8fzoKCehgziHjOS9GlQ==
Received: from AM0PR02CA0149.eurprd02.prod.outlook.com (2603:10a6:20b:28d::16)
 by AS4PR10MB5766.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Wed, 14 Oct
 2026 16:51:49 +0000
Received: from AM2PEPF00070CF5.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d:cafe::13) by AM0PR02CA0149.outlook.office365.com
 (2603:10a6:20b:28d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 16:51:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM2PEPF00070CF5.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 16:51:49 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 14 Oct
 2026 18:52:03 +0200
Received: from [10.252.12.121] (10.252.12.121) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 14 Oct
 2026 18:51:47 +0200
Message-ID: <48e528a5-0c54-4778-bd29-b6f44ae95be7@foss.st.com>
Date: Wed, 14 Oct 2026 18:51:45 +0200
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
 <950f2801-a613-4f5a-a5a7-cb30101cf293@foss.st.com>
 <20261009-8db882a9fa159f8759aa7327@squawk>
 <2ba9235f-182e-4906-92e2-e35cf831d289@foss.st.com>
 <20261014-untrimmed-partly-81a4a21db49c@spud>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20261014-untrimmed-partly-81a4a21db49c@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF5:EE_|AS4PR10MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b0d0ae-26b1-4019-7579-08df2a1370b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|7416014|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|4143699003|261009223327099003|261009223027099003|261009221227099003|261009221727099003|261009220027099003|18002099003|22082099003|6133799003|10067099003|13003099007|3023799007|12100799066;
X-Microsoft-Antispam-Message-Info:
	9W1HuLDENqs4dDC/gyDmdTJMcMmfBHbNk9LP2hUUGD3/cWIJlXQvpR0vm9CU6MovRx0l7SjWBzQALh+U97un7G6KTCpnvfV8gn+zGwZbtoFl//oi8pgPZbfVHEkXEdoD7L5+RvIT21hFgALA+Qc+z95uSIqFV931xJybj6d7CjiGkpUvkcvJxD3pFTaH86lKDj+XHiKJAP5GFxYMPMGp+DsyhCMd2D+4rxqTvYE9zrM+afBMCHfcZgJVn4aUcFpJIJ+9eO43XJG2Nfsz0E8izQz+eJd4OMAE6brezQ5naFrOUhmNB019xuTyiuK1yOyOm+XuSG8AUZAbrOUhwzAKxUNBNftAaIVDIkyXQQhhsYpLO+8plAlg2jLTz5UOwnd+EAoH6fuNgMa3+kORlLusd7TEQ+RX45q8ZIoThZkiKPgjYpUX7K6Alb31zHGGV8UDz1f6YbVsed/riwKAEyGQQDqrkS9RbpZ/bRS/E3Jq5wOWy8XmeiKpbfEtlUzJpPWZcxo6nPhs6csc8BTSLmKS+w0eXp305a0PIkaqX/fZ1huC70501YYAmXWVSZOIt9+VdJOCquw41xPc7SjX1B3nkxkkH89W9ykM6+6BH11cQHZ03wFo3wMjMWXd2fyB77IPo3d0Mx8q0TgMqAHgX1Km2g==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(4143699003)(261009223327099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009220027099003)(18002099003)(22082099003)(6133799003)(10067099003)(13003099007)(3023799007)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qiTID8cnfzgAJ+AXMXFl1SNXIYGkcuwNqdeiwj2PWfRQg07CIdUwImOj5iW5clohtG5a1eUhvc/IfrNKwKwDPYFQBE/0geT7UEfu2AiWjFgPbeARieuw/2VCuO8AOyHx4t7TxSfNE38u/djbe3xkxYrMTJUbVr/ntb4++EmV3UdidsopmgmjItbJFj6Ox/OdSofS7tExixcoiat4PDATuzyMKq9N3YYtrywiPHZIepWwVANPFEDlypk5gGafJiLMz1Z4hRBMFZ85UYmZB4y9pR3idPAJ9HszD72fiu//hbkVh8nciLyLShwJ9ujGldz/246VFWGeW7k1d/7JkW3bI9QU0+5bQ4p8awesCaAKtt/FIDY4ruOL+GP5zP5XUaCTEm359K7XQndp10GAUQQddeeW4kvqjXbSR86cJLgLKhQJVKE01LUz0qTnvrRlmJY5
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:51:49.2905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b0d0ae-26b1-4019-7579-08df2a1370b7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF00070CF5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5766



On 10/14/26 17:15, Conor Dooley wrote:
> On Mon, Oct 12, 2026 at 02:56:04PM +0200, Olivier MOYSAN wrote:
>> Hi Conor,
>>
>> On 10/9/26 21:12, Conor Dooley wrote:
>>> On Thu, Oct 08, 2026 at 06:37:26PM +0200, Olivier MOYSAN wrote:
>>>> Hi Conor,
>>>>
>>>> On 10/8/26 12:11, Conor Dooley wrote:
>>>>> On Wed, Oct 07, 2026 at 11:01:28AM +0200, Olivier MOYSAN wrote:
>>>>>> Hi Conor,
>>>>>>
>>>>>> Thanks for the review
>>>>>>
>>>>>> On 10/1/26 20:32, Conor Dooley wrote:
>>>>>>> On Thu, Oct 01, 2026 at 04:56:45PM +0200, Olivier Moysan wrote:
>>>>>>>> Add bindings that describes STM32 MDF settings to support
>>>>>>>> digital filtering for Pulse Density Modulation (PDM) microphones
>>>>>>>> and analog sigma delta modulators.
>>>>>>>>
>>>>>>>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>>>>>>>> ---
>>>>>>>>      .../bindings/iio/adc/st,stm32-mdf-adc.yaml    | 383 ++++++++++++++++++
>>>>>>>>      1 file changed, 383 insertions(+)
>>>>>>>>      create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..f2fbc3e150e8
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
>>>>>>>> @@ -0,0 +1,383 @@
>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>>> +%YAML 1.2
>>>>>>>> +---
>>>>>>>> +$id: http://devicetree.org/schemas/iio/adc/st,stm32-mdf-adc.yaml#
>>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>>> +
>>>>>>>> +title: STMicroelectronics STM32 Multi-function Digital Filter (MDF) ADC
>>>>>>>> +
>>>>>>>> +maintainers:
>>>>>>>> +  - Olivier Moysan <olivier.moysan@foss.st.com>
>>>>>>>> +
>>>>>>>> +description: |
>>>>>>>> +  STM32 MDF ADC is a sigma delta analog-to-digital converter dedicated to
>>>>>>>> +  interface external sigma delta modulators to STM32 micro controllers.
>>>>>>>> +
>>>>>>>> +properties:
>>>>>>>> +  compatible:
>>>>>>>> +    enum:
>>>>>>>> +      - st,stm32mp25-mdf
>>>>>>>> +      - st,stm32mp23-mdf
>>>>>>>> +
>>>>>>>> +  reg:
>>>>>>>> +    minItems: 1
>>>>>>>> +    maxItems: 2
>>>>>>>
>>>>>>> This needs an items list here. The size of the regions seems like crap
>>>>>>> to begin with...
>>>>>>>
>>>>>>>> +
>>>>>>>> +  clocks:
>>>>>>>> +    maxItems: 1
>>>>>>>> +
>>>>>>>> +  clock-names:
>>>>>>>> +    description: Internal clock used for MDF digital processing.
>>>>>>>> +    items:
>>>>>>>> +      - const: ker_ck
>>>>>>>
>>>>>>> This is pointless when you only have one.
>>>>>>>
>>>>>>
>>>>>> I agree that it could be dropped. However, it is useful for using
>>>>>> devm_regmap_init_mmio_clk.
>>>>>
>>>>> Ah, because that function if you pass NULL to it, it doesn't mean no
>>>>> string, it means no clock.
>>>>>
>>>>
>>>> The MDF has two clocks (AHB clock for register accesses and ker_ck for
>>>> peripheral processing). However, these two clocks share the same gate. So,
>>>> only the ker_ck clock is exposed in the driver.
>>>
>>> That's incorrect, you should have two clocks in DT if the block has two
>>> even if they have a shared gate.
>>>
>>
>> This would not be consistent with the architectural choice made for the
>> STM32MP25. The RCC driver provides an abstraction to manage these two clocks
>> as one, since they are controlled by the same gate. The binding incorporates
>> this abstraction to manage only a single clock.
>>
>> A large number of peripherals on STM32MP25 have the same architecture and
>> follow this implementation rule. So managing both clocks in the MDF driver
>> would create a consistency issue with the other peripherals.
> 
> Doesn't really matter how you've modelled the clock controller, cos you
> can just have the same clock be both inputs, and retain a correct model
> of this hardware?
> 
>>
>>>> The regmap api is a convenient way to manage registers and gate the AHB
>>>> clock only on register accesses. Removing clock-names no longer allows you
>>>> to benefit from clock management handled by the regmap framework, and means
>>>> that this must be managed explicitly, partially or entirely, in the driver.
>>>>
>>>>>>
>>>>>>>> +
>>>>>>>> +  "#clock-cells":
>>>>>>>> +    enum: [0, 1]
>>>>>>>
>>>>>>> Why is this not fixed? Also why are parts of your own device consuming
>>>>>>> the clocks?
>>>>>
>>>>> Reading the docs, this has to be 1, you have two clocks?
>>>>>
>>>>> Not sure why you skipped this and skipped explaining why you are
>>>>> consuming your own clocks.
>>>>>
>>>>
>>>> Yes, we can have two clocks gated independently but sharing the same rate.
>>>>
>>>> Using the clock framework apis seemed to me the right way to manage cck1 and
>>>> cck0 gating and divider computing. I think I would have to introduce
>>>> proprietary properties and have to implement code in the driver, that would
>>>> be handled natively by the framework otherwise.
>>>
>>> The CCF is still the right way to do it, especially since CCK0/1 can be
>>> exported to other devices. I don't believe you need to actually have a
>>> reference in DT to do this though, plenty of "real" clock controllers
>>> have only one input clock and hang a whole tree with multiple layers off
>>> that.
>>> Down below I mentioned this under "ouroboros devices", I think this kind
>>> of ability to chose which clock a channel uses is a fairly normal thing
>>> to do in IIO land, I just dunno what the preferred mechanism is - I just
>>> know that it is not referencing yourself (probably it's some sort of
>>> property that you put in a channel node that says 'blah-clock = "cck0"',
>>> but better that the IIO folks answer.
>>>
>>
>> The adc.yaml binding do not expose clock properties. But maybe IIO experts
>> can answer about this.
>>
>>>>>>>> +  clock-output-names:
>>>>>>>> +    description: |
>>>>>>>> +      CCK0 and CCK1 are optional output clocks, which share the same clock frequency,
>>>>>>>> +      but can be gated independently to save power.
>>>>>>>> +    minItems: 1
>>>>>>>> +    maxItems: 2
>>>>>>>> +    oneOf:
>>>>>>>> +      - items:
>>>>>>>> +          - const: cck0
>>>>>>>> +      - items:
>>>>>>>> +          - const: cck1
>>>>>>>> +      - items:
>>>>>>>> +          - const: cck0
>>>>>>>> +          - const: cck1
>>>>>>>> +
>>>>>>>> +  clock-frequency:
>>>>>>>> +    description: |
>>>>>>>> +      Common clock frequency (Hz) for CCK0 and CCK1 output clocks.
>>>>>>>> +      The frequency must be a multiple of the "ker_ck" clock frequency.
>>>>>>>> +    maximum: 25000000
>>>>>>>
>>>>>>> Should not be needed, the consumers request what they need.
>>>>>>>
>>>>>>
>>>>>> The CCKx clock frequency depends on the maximum rate supported by the sigma
>>>>>> delta converters (for instance a digital mic) and the expected decimation
>>>>>> ratio on the bitstream. Typically this determines the frequency on the SPI
>>>>>> bus.
>>>>>> This rate is defined statically and shared by the CCKx clocks. So IMHO, as
>>>>>> this rate is unique, it can look strange to let the consumer define it.
>>>>>> Moreover, it seems to me that clock-frequency is already used to configure
>>>>>> the frequency of a provider in some other bindings.
>>>>>> For instance: Documentation/devicetree/bindings/clock/silabs,si570.yaml
>>>>>
>>>>> This is a binding from the age of antiquity, using it to justify your
>>>>> use is actually harming your argument rather than helping. Your clock
>>>>> consumers should be providing the information about what the rate should
>>>>> be, and if you need to do this in dt you can use assigned-clock-rates.
>>>>>
>>>>
>>>> ok, I will move this to clock consumer with assigned-clock properties.
>>>>
>>>>>> So, it's not clear for me, what is the restriction on clock-frequency
>>>>>> property.
>>>>>>>> +
>>>>>>>> +  ranges: true
>>>>>>>> +
>>>>>>>> +  clock-ranges: true
>>>>>>>> +
>>>>>>>> +  resets:
>>>>>>>> +    maxItems: 1
>>>>>>>> +
>>>>>>>> +  reset-names:
>>>>>>>> +    items:
>>>>>>>> +      - const: mdf
>>>>>
>>>>> Same applies here as to the clock names fwiw.
>>>>>
>>>>
>>>> Yes, I removed this.
>>>>
>>>>>>>> +
>>>>>>>> +  access-controllers:
>>>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>>>>>> +    description: |
>>>>>>>> +      Phandle to the rifsc device to check access right.
>>>>>>>> +
>>>>>>>> +  power-domains:
>>>>>>>> +    maxItems: 1
>>>>>>>> +
>>>>>>>> +  st,interleave:
>>>>>>>> +    description: |
>>>>>>>> +      List of phandles of interleaved filters. The indexes of interleaved filters must be
>>>>>>>> +      consecutives starting from 0 (i.e in range [0..N]). The samples from interleaved filters
>>>>>>>> +      are muxed in a single channel and retrieved through the device associated to the filter 0.
>>>>>>>> +      The filters 1..N have to be enabled, but inherit their configuration from filter 0.
>>>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>>>>>
>>>>>>> No idea what these even are, but this is probably not the right way to
>>>>>>> represent the relationship between devices. They're apparently ADCs, but
>>>>>>> this is also an ADC so I'm not sure what's going on here at all.
>>>>>
>>>>> Yeah, after more thought this should not be done like this at all,
>>>>> especially if these filters the phandle point to are part of this device
>>>>> itself, which I suspect they are. If that's the case, you don't need
>>>>> phandles to even do this, you just need an int that says what N is.
>>>>>
>>>>
>>>> Yes, can be an index as it is an internal reference. I will change this.
>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>> +required:
>>>>>>>> +  - compatible
>>>>>>>> +  - reg
>>>>>>>> +  - ranges
>>>>>>>> +  - clocks
>>>>>>>> +  - clock-names
>>>>>>>> +  - clock-ranges
>>>>>>>> +  - "#address-cells"
>>>>>>>> +  - "#size-cells"
>>>>>>>> +
>>>>>>>> +additionalProperties: false
>>>>>>>> +
>>>>>>>> +patternProperties:
>>>>>>>> +  "^sitf@[0-9]+$":
>>>>>>>> +    type: object
>>>>>>>> +    description: Serial interface child node
>>>>>>>
>>>>>>> Why is this a child node at all?
>>>>>>> Probably not worth reviewing more without a link to the docs for this
>>>>>>> device so I can figure out what on earth is going on!
>>>>>>>
>>>>>>
>>>>>> The MDF is a digital filter for sigma-delta bitstreams, rather than the
>>>>>> analog-to-digital converter itself.
>>>>>>
>>>>>> Here is the link to STM32MP25 reference manuel
>>>>>> https://www.st.com/resource/en/reference_manual/rm0457-stm32mp2325xx-advanced-armbased-3264bit-mpus-stmicroelectronics.pdf
>>>>>> Chapter 45: Multi-function digital filter (MDF)
>>>>>>
>>>>>> On STMP32MP25 SoC, the MDF provides 8 serial interfaces (SITF) and 8 digital
>>>>>> filters (DFLT) which can be connected through a multiplexer.
>>>>>>
>>>>>> Below is a schematic view of typical applications targeted by this
>>>>>> peripheral
>>>>>>
>>>>>>
>>>>>> Audio use case:
>>>>>>
>>>>>> 		mdf
>>>>>>                +-------------------------------------+
>>>>>> +------+    | +------+    +------+    +------+    |
>>>>>> | dmic | -> | | sitf | -> | mux  | -> | dflt | -- | -> audio device
>>>>>> +------+    | +------+    +------+    +------+    |
>>>>>>                +-------------------------------------+
>>>>>>
>>>>>> For instance, in an audio use case the serial interface can be configured to
>>>>>> provide the clock to the digital microphone (cck0, cck1 or both) at a common
>>>>>> predefined rate, and to retrieve the PDM samples.
>>>>>> The serial interface provides this samples to a digital filter, which
>>>>>> delivers PCM samples on its output.
>>>>>>
>>>>>>
>>>>>> Analog use case:
>>>>>>
>>>>>> 		mdf
>>>>>>                  +-------------------------------------+
>>>>>> +--------+    | +------+    +------+    +------+    |
>>>>>> | sd adc | -> | | sitf | -> | mux  | -> | dflt | -- | -> iio device
>>>>>> +--------+    | +------+    +------+    +------+    |
>>>>>>                  +-------------------------------------+
>>>>>
>>>>>
>>>>> So, looking at the docs and a brief chat with Jonathan about this
>>>>> device, I believe you've got things backwards and this is actually the backend,
>>>>> and the adc should be the one populating the io-backends property
>>>>> pointing to this device. You should have io-backend-cells, and I assume
>>>>> that there should be a cell for the adc to select which dlft it is connected
>>>>> to.
>>>>>
>>>>
>>>> There have already been lengthy discussions in the past about a DFSDM
>>>> peripheral on STM32MP1, which has features similar to those of the MDF and
>>>> similar implementation constraints. For the DFSDM, a solution based on an
>>>> IIO backend had been upstreamed. The MDF follows the same architecture. I
>>>> need to take a little time to dive back into this issue.
>>>
>>> One thing to note there is that you retrofitted the backends onto that
>>> device, and the original design here is much older (it's a text
>>> binding).
>>>
>>>
>>>>
>>>> DFSDM sources:
>>>> drivers/iio/adc/stm32-dfsdm-adc.c
>>>> drivers/iio/adc/stm32-dfsdm-core.c
>>>>
>>>> Here is a sample of DFSDM DT
>>>>
>>>> sd_adc0: simple-sd-adc0 {
>>>> 	compatible = "sd-modulator";
>>>> 	#io-backend-cells = <0>;
>>>> 	vref-supply = <&v3v3>;
>>>
>>> Yeah, pretty sure this is wrong (backwards). The backend is the thing
>>> that gets data from an ADC not the ADC.
>>>
>>
>> The backend framework was introduced to implement complex IIO aggregate
>> devices. The hardwares that were driving this need were analog device ad9467
>> and ST DFSDM.
>>
>> https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/T/#m222f5175273b81dbfe40b7f0daffcdc67d6cb8ff
>>
>>  From drivers/iio/industrialio-backend.c:
>>
>> "The typical architecture is to have one device as the frontend device which
>> can be "linked" against one or multiple backend devices. All the IIO and
>> userspace interface is expected to be registers/managed by the frontend
>> device which will callback into the backends when needed (to get/set some
>> configuration that it does not directly control)."
>>
>>   *                                    ---------------------
>>   * ------------------                 | ------------
>>   * |     ADC        |-----------------| | ADC CORE |
>>   * | (Frontend/IIO) | Serial Data (eg | |(backend) |-------
>>   * |                |-----------------| ------------
>>   * ------------------                 ---------------------
>>
>> The MDF (or DFSDM) use case, follows this topology:
>> - The SD modulator (ADC core) registers in backend framework
>> - The MDF registers in IIO framework and exposes the IIO devices
>>    It also get configuration (ref voltage) from SD modulator, to compute
>> scaling.
>>
>> I agree that if we consider the terms frontend and backend, the elements in
>> the data flow do not have the roles that we would naturally expect. However,
>> if we consider the expected role of the elements using the iio-backend
>> framework, the usage seems coherent to me.
> 
> I didn't even get as far as sd modulators or whatever, if I understand
> correctly the ADC inputs on this device are fed by the onboard ADC?
> (https://lore.kernel.org/linux-iio/20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com/)
> In that case, I can't really see how it makes sense for the primary iio
> device to change when data is fed back through the mdf or taken
> directly from the ADC itself, particularly given how that would affect
> the userspace interface.
> 
> The "serial" side of this seems in a similar vein to the adi,axi-adc
> stuff, which when considered with the ADC inputs, really does give me
> the impression this is backwards.

Some clarifications about the STM32MP25. This SoC does indeed provide 
ADCs, and these can be connected to the MDF via a dedicated interface. 
(but not the serial interface).

However, this use case is not supported by the driver. Only sigma-delta 
modulators, external to the SoC and connected via the serial interface, 
are supported. On ST boards, the only available SD modulators are 
digital microphones.

Anyway, if the internal ADC to MDF use case was supported, the issue 
would be the same. The whole ADC + MDF set would be presented at the 
interface as an aggregated device, and the ADC data would not be 
directly accessible to the user.

BRs
Olivier
