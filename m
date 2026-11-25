Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795622314;
	b=UE4GS/Md6SmtE2BjoRdj3fApbbZCo4ap4HjQDT61l1MjSpjEvq/xjAZFeC4uPXWjhuU4
	 6LOqDO0yZR+ikFsG5oZtdorzI+Ilu0ZfzQGVuMjFVblNcg1G2wL7eagxfzxBLu2wM7mJC
	 3icxargBxuKfkOrIk2WMsRU4/5QILNSz8pkWiwM4+4D4w7XnHCSM51TmfJWdB1Lx3xDDi
	 5VsQj68JAHPVWEoH61PV9PoKITNPgfw9tOPddrmnnPnPBoTWKUWbLuJh6df7MMZHbhxZ/
	 2hjFn3gsitZNYtoMhkZDwZUzm48kesPObuqtxffKuJKWtGvbyOHmpsBuuWqzmtuXQhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622314;
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
	bh=3os6OJ3R92oD2fbICFlSvVddNzf23MQ7FMWbwwvNVRo=;
	b=n8dfHsH/pwV53g4mG41zNaDZOcllJnfAv5RlOrm1wbrQmc9TRAom4/TJ2NsiSFG6O60D
	 EfdM+4JKx8yxWb0wBNBRZaeTu8UHQJ1PKGfz2B9tASEkveWolJ+84h51At8H3jWakQBq9
	 i6hZ2M65BZ3dewmj9vN48ESou7x43nNgoSxrGC6RD6sVc6zLfm0GuPCYQqZtV+bbuJLY2
	 3wSlk5mhLLnjrpWgXA6NVkANqou1GHl8ORIu5MlnNjIsexKAPahx2e6Df8s4KS++DP/04
	 Q7f/+dBFpM/QZOuYmd/KLJjEM8B3YVQekGWKe1ekat5Mgdlp2n3ZtEmCiWdIcXs67HA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b="MRhP/2mV";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.64
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824C0606A6B7;
	Wed, 25 Nov 2026 15:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 824C0606A6B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=MRhP/2mV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mggttwu4tni1ARCqyMmkY/+ZHTa0sI3JQba1fdpOQTwys3jv8loXydHsa8AeX55aTK0Z7kg/EE31ukMSksFikWz3k5+/8pDDEyStdC4HpVQ8boRuAkc1fCn+dZvMvL6Vkpd8XFtT54SgN2icjC0n0IB9RtO37nyLwO8lGUWDyK8ozpaQnq08puNXEu2EkH+DJEIDnh2aILXXSOcQoeykV7R99n7IAJqjGswuq5/O9N1vrruab4iUJ8hIXe9v/ZNXIZDPaCflxIimPaBiWFy8K6akK1itKJGM7roS2A8XGh8F+fM5G2Vm8la0W6D1FYAvUNUZixFTLJw5D0CM9aj4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3os6OJ3R92oD2fbICFlSvVddNzf23MQ7FMWbwwvNVRo=;
 b=BgsklVzi6TbqfBWVtGl3T5ThG85tbStM+9ZUGCuiXOq6YM6ch7rZrP2vt9k0UoukblUUvXOj4O/7/P+8VBA+93osCsIuAXeOEC6m70N4StZxr/8yTHxDUzRpLD468Ofkapn5EE6hvyYqwuhhOXBUUgX0Pwb1CyPRBXWrtl/IrwW+/4RQAqZzw7hm1yLYUSy9rT4kPH9DV9/uwrPCTjNAfY60AZQFOD+I7LNXmFfAlhVNkK3Czl5Jta75y4pdyVEivOtJ17mOaQZ1CtjdYTV3BMMGgtC0AgyHz3l1LZXOmwYu0lV5dxNz1micFWmSV1P1/Scp+8I3Ovq7stqbzryWWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3os6OJ3R92oD2fbICFlSvVddNzf23MQ7FMWbwwvNVRo=;
 b=MRhP/2mVVcAaDPFeLTnNRwEEtqBz/LKwkNdobXvfkV84dJfLEyXvFcDeXGKktIN98YLm05xLAS/ih+25G7u/YTsZGKOog04aH2xMX1ooJUf6qNDvIcQBJQtSMt1wZiD8UCLdypL5RbhLbth7bR2KkAeamde4KXCMyxPZ6/duCsIpHAmKiF2qdvwGoxm9DG2VKpatv/1vx2KzwAx2K9igLN48UX0QhyX9HFFn7kxIofdH4dT61PxAKCfoQogojjlNz88WBiFJ9zUXYenWYR99XzDU7QUyp6RCrM+F0UkPgrLO1n5GIHP1lwfOwgf3aGZbfgXZKOUSP0geUH95uwnVYA==
Received: from DB9PR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::25) by VE1PR10MB3759.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:168::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 15:58:27 +0000
Received: from MAD0EPF000008AB.eurprd04.prod.outlook.com
 (2603:10a6:10:1d8:cafe::6c) by DB9PR01CA0020.outlook.office365.com
 (2603:10a6:10:1d8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 15:58:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008AB.mail.protection.outlook.com (10.167.241.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 15:58:26 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 16:59:31 +0100
Received: from [10.252.2.245] (10.252.2.245) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 25 Nov
 2026 16:58:23 +0100
Message-ID: <a11d734e-3c08-405b-86ac-96cc10bd6a34@foss.st.com>
Date: Wed, 25 Nov 2026 16:58:22 +0100
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
Subject: Re: [PATCH v2 01/11] dt-bindings: iio: adc: add stm32mp2 mdf filter
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"Sumit Semwal" <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>, Philipp Stanner <phasta@kernel.org>, "Arnaud
 Pouliquen" <arnaud.pouliquen@foss.st.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-sound@vger.kernel.org>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
 <20261118-upstream_mdf_v2-v2-1-7939d3c3720a@foss.st.com>
 <20261123-barbecue-trickily-4ae8d9f01b3d@spud>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20261123-barbecue-trickily-4ae8d9f01b3d@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008AB:EE_|VE1PR10MB3759:EE_
X-MS-Office365-Filtering-Correlation-Id: 81cd9bf1-554a-4bd6-9fed-08df4b0cf138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|7416014|376014|4143699003|18002099003|6133799003|261009223027099003|22082099003|3023799007|13003099007|10067099003|56012099006|11063799006|261102123227099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003|261022075727099003|261021121427099003|261021135927099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	TTJf5SmVY7rSeM+q7j9PlRyPRHRLvJhpeae9sFJAGsvAnF8nwLKBI86/f1DKixrWsEJisxWfJXKHKSFsEaRqpIBmunUR/ydxqrv0sbRy4cQE7wt7hVGTPJrA+Vci/6FuY+b6tL3/pNuHPsaStEX6F/6ec8IBVDBTorOvTvJ5uvSj6uHpvPzQTBKgFUwyTTgUmMWpiIsrgTprXw8vHqOyQhnKM+u/ZmmIFCrLHlnNoV8AUT50A/3vwbnNT6jZ5nvyC07paTGwOd9lIa6b+lah7TIQubwPANdiOfGjzsIK8WClO118lmfSGIgU/KN263KOOQtVM9dJgLxgbqKh0LV4ODgRojCIFmRXtIP3G0iqHJCc3U+w+ZcG1rhXvH+ndAFgLSuQQtfJbMYUfcDscgQDAdhoY4SofE5g3JctYr/m5RwT8wwHQyb1qjRID/aH0YZG0QxgUtt5u5pNf4orjvlallcIUHj1pUbC9UXA9GGhZtPnCbxb5NVbQNYFPWSqHmUkL4ZQCqoERr8wUEVga5NBna/T5NjBuViVLNN+UL1F5AZnwoUyMK0aX2FXmaTpk9BYgcyH4hbr782A+/zRal9k6p6ypFrcRIX5lB/hgzgQcbgQknT3nXKNdYegH+mk0yGidlZvwg3s2alC6or+Rc0WnQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(376014)(4143699003)(18002099003)(6133799003)(261009223027099003)(22082099003)(3023799007)(13003099007)(10067099003)(56012099006)(11063799006)(261102123227099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021135927099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H0GA9IuB1Dvuku9h7sybaBQoms2+eA6aaf+vSbQgnJhDEhR3Fpzcbx1wdFIdWhalHE3lbmO/5k5/MJbI+ExQ+iJNi6uayaCF78hkVHu1KuDxQj67hCbe7YkvjyQzBjvwI2S5yVthFf6HQFYgiOdIhzoIVjFDCPzpf60ahbHESm4Q077FnBzf2amMKWIweFwgjTwqsoyBDoT/29E53+idjVjOx1BaG0HUNJH6qFNgCtO/5QGQ71U0Esycu6Hcs1ut9BtYDMoBFS7SYYRma7wE9pEtI+nWSCFdLdIe4exSS9MOVjpGA+EIgEmuIgqSZOrlCd/CFoanX3PHml135lr71VSsXWGjYJORkyp1BYn/Iwe15mAMLbaPhgrjYxNHoMt0nbdEmcGJQgiPD3z0FWxXFj/HMUL7Ycx+KDUj9+UXSBqeGCCBkmkKmLWx036mpBw5
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 15:58:26.7548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81cd9bf1-554a-4bd6-9fed-08df4b0cf138
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008AB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3759

Hi Conor,

On 11/23/26 18:30, Conor Dooley wrote:
> With an eye to accepting something of this nature, rather than a rework,
> I have some initial questions before suggesting some remodeling of what
> is here.
> 
> On Wed, Nov 18, 2026 at 04:17:46PM +0100, Olivier Moysan wrote:
>> Add bindings that describes STM32 MDF settings to support
>> digital filtering for Pulse Density Modulation (PDM) microphones
>> and analog sigma delta modulators, on STM32MP2 SoCs.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> ---
>>   .../bindings/iio/adc/st,stm32mp25-mdf.yaml         | 341 +++++++++++++++++++++
>>   1 file changed, 341 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32mp25-mdf.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32mp25-mdf.yaml
>> new file mode 100644
>> index 000000000000..e4925a38012d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32mp25-mdf.yaml
>> @@ -0,0 +1,341 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/st,stm32mp25-mdf.yaml#
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
>> +      - st,stm32mp23-mdf
>> +      - st,stm32mp25-mdf
>> +
>> +  reg:
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  "#clock-cells":
>> +    enum: [0, 1]
>> +
>> +  clock-output-names:
>> +    description: |
>> +      CCK0 and CCK1 are optional output clocks, which share the same clock frequency,
>> +      but can be gated independently to save power.
>> +    minItems: 1
>> +    items:
>> +      - enum: [cck0, cck1]
>> +      - const: cck1
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  ranges: true
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  access-controllers:
>> +    maxItems: 1
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  st,interleave:
>> +    description: |
>> +      Number of interleaved filters, starting from filter 0. For a value N,
>> +      filters 0 through N - 1 participate in interleaving. Their samples are
>> +      multiplexed into a single channel and retrieved through the device
>> +      associated with filter 0. Filters 1 through N - 1 must be enabled and
>> +      inherit their configuration from filter 0. If absent, interleaving is
>> +      disabled.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 2
>> +    maximum: 8
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - ranges
>> +  - clocks
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +
>> +additionalProperties: false
>> +
>> +patternProperties:
>> +  "^sitf@[0-9]+$":
>> +    type: object
>> +    description: |
>> +      Serial interface configuration, managed by the MDF core. Pin control
>> +      states for the serial interface pins belong to the MDF parent node.
>> +
>> +    properties:
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
> 
> These two compatibles don't represent different hardware, just different
> roles from the same hardware, right?
> 

Yes, both compatibles refer to the same MDF filter hardware. They 
distinguish two uses of that filter: IIO data acquisition and digital 
microphone audio capture through ASoC framework.

>> +
>> +      reg:
>> +        description: Specify the MDF filter instance
>> +        maxItems: 1
>> +
>> +      interrupts:
>> +        maxItems: 1
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
> 
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
> 
> Can this ever be more than a single phandle?
>

Each MDF filter selects a single bitstream from one serial interface. 
The property contains only one phandle plus one argument that selects 
the rising or falling clock edge.

>> +
>> +      mdf-dai:
>> +        type: object
>> +        description: Audio interface for the MDF filter
>> +
>> +        properties:
>> +          compatible:
>> +            const: st,stm32mp25-mdf-dai
>> +
>> +          "#sound-dai-cells":
>> +            const: 0
>> +
>> +          io-channels:
>> +            description:
>> +              From common IIO binding. Used to pipe external sigma delta
>> +              modulator or internal ADC output to MDF channel.
>> +
>> +          power-domains:
>> +            maxItems: 1
>> +
>> +          port:
>> +            $ref: /schemas/sound/audio-graph-port.yaml#
>> +            unevaluatedProperties: false
>> +
>> +        required:
>> +          - compatible
>> +          - "#sound-dai-cells"
>> +          - io-channels
>> +
>> +        additionalProperties: false
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
>> +          properties:
>> +            mdf-dai: false
>> +
>> +    unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    mdf1: filter@504d0000 {
>> +      compatible = "st,stm32mp25-mdf";
>> +      ranges = <0 0x504d0000 0x1000>;
>> +      reg = <0x504d0000 0x8>, <0x504d0ff0 0x10>;
>> +      #address-cells = <1>;
>> +      #size-cells = <1>;
>> +      clocks = <&rcc CK_KER_MDF1>;
>> +      #clock-cells = <1>;
>> +      clock-output-names = "cck0", "cck1";
>> +
>> +      sitf5: sitf@300 {
>> +        reg = <0x300 0x4>;
>> +        st,sitf-mode = "spi";
>> +        clocks = <&mdf1 0>;
>> +        assigned-clocks = <&mdf1 0>;
>> +        assigned-clock-rates = <2048000>;
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
>> +        mdf-dai {
>> +          compatible = "st,stm32mp25-mdf-dai";
>> +          #sound-dai-cells = <0>;
>> +          io-channels = <&filter0 0>;
>> +        };
>> +      };
>> +
>> +      filter@104 {
>> +        compatible = "st,stm32mp25-mdf-adc";
>> +        reg = <0x104 0x70>;
>> +        #io-channel-cells = <1>;
>> +        interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
>> +        dmas = <&hpdma 64 0x63 0x12 0>;
>> +        dma-names = "rx";
>> +        st,cic-mode = <2>;
>> +        st,sitf = <&sitf5 1>;
> 
> Is this a realistic example, with multiple devices connected to the same
> sitf? I assume it is technically possible, given what I have seen in the
> docs but would anyone do this in reality?
> 

Yes, sharing the same SITF clock and data line for stereo audio capture 
is a realistic use case. The microphones drive the data line on opposite 
clock edges, so two MDF filters can capture the two channels 
independently. This use case is documented here:
https://wiki.st.com/stm32mpu/wiki/MDF_device_tree_configuration#MDF_audio_example

What is probably not realistic in the example, is to mix audio and 
analog use cases (through st,stm32mp25-mdf-dmic and 
st,stm32mp25-mdf-adc). This was done to shorten the example. Maybe it 
would be worth splitting the audio and analog use cases.

Regards
Olivier

> Cheers,
> Conor.
> 
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
>>
>> -- 
>> 2.43.0
>>

