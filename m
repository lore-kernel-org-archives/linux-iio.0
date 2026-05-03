Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010058.outbound.protection.outlook.com [40.93.198.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993C2147E5;
	Sun,  3 May 2026 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777848774; cv=fail; b=bAgoFYS0TBJ/M97hEc7qoeQAQ54LXNEHnUiGW5rSF+NPCTwNF1MAVu+K9Ahtbd/l0YqjvclJGhj5UhDQj3v7m9M5i/0lU5lXXDLtgWWFUONYMAnqN40ASdlm5tMw1ajbNpmc/siKun+9qUYX+R5SjzsTRX3gMWIu4IZ21jxl4wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777848774; c=relaxed/simple;
	bh=VtNTqkHjzw79+FNuTqvJtkTKtp7imDGAZ3enmU4S55Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qK8Zsez8kxuMhi9vUOZgRqVbBlhWzz6nuzjh0+MMEYEThsA5lt3EacBxKcOyFyMc0zWMmqFqecWG/d5KfYfeRzv0E/6GDHBcEYnWF64B3tvO51NKm6jyIY4lLwm08Jf8gXcSwKQ/7UsJ4KmvNVHTs6iZwbNVU3eUbVl0ehSRkDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lee8eZN4; arc=fail smtp.client-ip=40.93.198.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lee8eZN4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcMVGv5ylDsYihmajkljrWrYXN8ap1vLu6ToK7G8gdDmNSOlosIHASxw/hz7RiASPY9pzTY24JzbAeth1Mp0brYAzZn/gAG/QJoCFIAHRA096OYNAiCT90qDfuvWJCdriV0d+65iJ1EPJtAr78n9JBeNJyySlWXX13MmadI4V7ziCg5tRb7c1jWcsIlwf7ULz1oSgQTbuXcQukGGa1nBPqHSiWAVFpN9lkIReVaPhSfAcMuol+5trD1BkzP2SxAP+GDdu+2BdWTulF+4Wf6Pc97D/tk9SdUf9dXiwKJTMOG9+MICA8umiEclKpZSlRRK78Vk2nYnRor19fIdJBP/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inD4nesiHcqDEdP00TfZD8kaAeJNbLNFBsqbyteKa90=;
 b=HlslU5qrwRT9rC4Os4TzvjnBAsCUIhAE3kjFgH12vXNpcaf2SbOodycNYNIXzQfFvQUfDbRYsiFHHZh5kL0OHssfI9X6dGXiU/74mlrh2HeQcYWPnuJYdT2a/gmtTgrysIITFkewG0pIMKcRzKPpseL5AYiMDP94kIceFZaXUWcdckgKLomn+z+0vr3uA/IzNdwu+X16woEmj1AF6CGmxpWMAbu21sPpgZJQdpk9XaECKJVe2aJB6cOx2FB0yqrmyL5JTe3HrIdmcOH2+jfH3Gu0r7br7ygZUYJ87BXO9b9ggqt0DWBcydLPVqHR8UX1KozMXBCoUNKlCqpVq8sV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inD4nesiHcqDEdP00TfZD8kaAeJNbLNFBsqbyteKa90=;
 b=Lee8eZN4fuQYpgAubnf8CQjL/7z5LKlKRCiMKQhKurXLA0y3wlEc+FSI4sOynvQYw3G/Lauo0LW3FKsGqR5HybZ81TgIRtfoewcnvhL6LlcwfF4zK1SYBLFwRMRHZvEy3DOwSyby5r9Sk9/y2rh0AWnO5wu661LsYp62kcn9RgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 22:52:45 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.20.9870.023; Sun, 3 May 2026
 22:52:44 +0000
Message-ID: <28c65ef6-a777-47ba-875b-5a75ac457815@amd.com>
Date: Sun, 3 May 2026 23:52:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: adc: add xlnx,versal-sysmon
 binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, git@amd.com, nuno.sa@analog.com, andy@kernel.org,
 dlechner@baylibre.com, michal.simek@amd.com, conall.ogriofa@amd.com,
 erimsalih@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260502111951.538488-1-salih.erim@amd.com>
 <20260502111951.538488-2-salih.erim@amd.com>
 <20260503-rebel-sassy-weasel-ed26ee@quoll>
Content-Language: en-US
From: Salih Erim <salih.erim@amd.com>
In-Reply-To: <20260503-rebel-sassy-weasel-ed26ee@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0508.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::15) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: d13ca11d-2dd4-49fe-7e12-08dea966b05f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vln3oK733j8siSqQUBOPNfP+5QBL4buXnWKHVO29rPIBpLcvx8KebRDbpBV458GxbJBNw9kER1TSrbRCoS5g9ZNA1i8CI3QeKv7nsC4uOeL64U+CxXobfqha+c8EmpbDqpIDLrSwWOz4SEy0S/lmi94i/D47BzjnDEtAU5Sm0DpoPAAAM98k7ltoIaDbLqkwgn9iEupnkDzAL/3WiLeUqhGxixrhMtEMymfCrsDOqy+IsX76CGl3pco/09S8GNfqND78o3KaP7MHFl+vwJ0hsBV+ldmbrhoR3Vky57RT4j29Vhx4cBukJ8SaVgh01Ei+hnyd+qRAZydQNiGaS/gyVkBPO+AIja0NsKG30SkUwbmoGKCKuXA4Z/YT1e85+FMc/r2uLIatMYMFfqEsN+1tMn9izcpCBEhu4nfbWBNnlfCDJ4DyKcOvtxhdZ1tiwMYQJ/R1HWOzRBBMyw6gnOLnrw2RHrNF9crhk4d2u9BQBZS4Sw5xHLma769HliOFwMRYqV6VHfM3qdehUGrYkLDakedZalNwBCnELWjLddqjoVl9H/ZWrieGeQS0qDzBvyrOSMQCvVD9laP6Qd0OGwTCwd6kxXQS3UFqWBA1hX/hFCcCWJDqk7HUmhPQQtsGdPgrOfMBILksbNnsHwv1yk+rRwyzXk00NaBrcC1G3Smsl3s4n/VmNo9Gg+4nb8QBhi39
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVZUYTdoUjNIZEJ1VkcvdFlERkFLc1B1bWcrU0ZvUGMydTVBWkJhSGt6U0tO?=
 =?utf-8?B?WVJoeHUxbWRiREUxeFhab0hXNDVYRUdzbU04cWRWNmhWUmZ6YTBZTWxxanZw?=
 =?utf-8?B?RTkybVN2ZS9jYkdsNGJyRTJBMldjK2lHZGFOZ0JTbzI2Y05Ic3YrK0tnNXV1?=
 =?utf-8?B?eFI3YTJzNCtDU2U4Mm50T0Q5NFdoRWhSWTRFWThiN0N4cWdxSGVEKzdGVk5y?=
 =?utf-8?B?ZGRRb0Uvb1Roa1V3OXp2d3ZEUjdEL1BZTS84c1lubUMvZVNkMnBjOWRsT05Y?=
 =?utf-8?B?MHJRSnRkQVVnSEhXSHNMNVZMbTV5M2IxbFk4QVpZZWczMnRlK1YyWVJFb25O?=
 =?utf-8?B?cHI0T2NJcHp1cEVtaDlPTmluanlrZ3YwZDNaWURjOFAzNTdQYUgrQTNrdjNm?=
 =?utf-8?B?bWs4SmhQazZRNGpPUkFYVXgrUXhEREtlM3JmOEIzUXR2OWhtbmZHZWZPSEd6?=
 =?utf-8?B?YnVCKzRRam8xdGRMc3k0bVpHSGZTOHhUNXZqdzgzbVJ5Zks3QmZqNkhSNE1R?=
 =?utf-8?B?QWpUVGF6K3lKa0VkUkplL2Z3Z0Frc3FHektjRStuOFFaQ28vREtmMmdFMFA0?=
 =?utf-8?B?SmQ4TXZ0S2Vuc29DSmpMbm5QUHE5eWJGQzA0OWRSZ3dtZnorRmRFUFNwNUR4?=
 =?utf-8?B?Rk9JTTRabmx0K0hRYlRoS2ZxQUlPK21uT2FmM2tGUWt1RUUyUEd5TEIzQVBr?=
 =?utf-8?B?cWN3ZC8wVGdGaFhkTTk1cUNZNXk1U0lJeERPTlpGS3J4bklMdWZ1clhvWTJs?=
 =?utf-8?B?TjZsSDlzajdmMTVJUGFYNmo0OS80Uy8wcWwvTnVnTVhCZXF5bUdSQ0grYTBl?=
 =?utf-8?B?eUZoRVk4Q1RNVTZiYk1SWGU3REpDRVlSRUFlQ0txUkJDeVI3TlhMUUhyQ0ty?=
 =?utf-8?B?L1Q0WE9zRmdMRGtvSkhrUFNVSEhvaWJuR3VTbmZXeTJObGdMNFBpQVJUa0F1?=
 =?utf-8?B?MEExbVlqODljOUtwZzUrVHVDSVMrbWZ3K1pQN2NPS0ljQWZSV1NLdW9lN2Zy?=
 =?utf-8?B?ekpnTDd5YW90R1ByZjJXY2ptWnNmVWxGcFlIU0JXdUE1M24yTVBTZUlhTXlk?=
 =?utf-8?B?aEQ5bzZJRFh5K25DME9tbmdZb1dKSWNsYWRzbWJoNlZibmZXMUx6WVpGZHZJ?=
 =?utf-8?B?TXMrL1Z5bnB4Qk1aYjQzb282QUwvblFBbzc1Zy9xcTRKeEUvdW9vVko0dkRT?=
 =?utf-8?B?UlNMT3A5bDlQSmRQZXJqWFNYc0lsUzl5NGJ4UkE5aGdHYktWdGVjYzhMN0xr?=
 =?utf-8?B?ejBkclZsVWY3Y3ZWb2xRRXBBdGlBNWNsZllWZlFpRXJJOXRLUFJQbytOYXpE?=
 =?utf-8?B?ODNiQkNJWUF5UFhTRm1hREtIMnIwazhxd1U2bWhlWVh1SkVNdTZadWVXSjB1?=
 =?utf-8?B?U3RqYUg2WmdDNmZVTjNUbUlSanVNdi8xOXJGNXdNUk0zem5vdWNraHp4Rk5v?=
 =?utf-8?B?Vkl6RDcraTlsWTBKbjIyLzJmVkxPTWozKzFWWlFMRThsWlFkOElhWFdyeVV5?=
 =?utf-8?B?RkUyYTBvb2xzWlZoRlR4QTl4RmlCUHpldXpDNkVjblI3SmZScnhGUXBXZlRV?=
 =?utf-8?B?NHlBU1RFaWZsK1J0SzZVZ1ZtaDAwd3BWVFNDQUl5SlZaalhQay8weFdxWjVW?=
 =?utf-8?B?QTVnSmszVHQ3RzBXSXFDcFFmYWdrMytBV3RSaTNyQUhsY08xMVdZWU9YdW9z?=
 =?utf-8?B?WjdObDVrOXo4Q3FtbTN4VWFrWktkbzJtL0NDLys5MWhrUWZkR3hIMW1BU2wy?=
 =?utf-8?B?cExFU3QzWm5GUml2ak5EbnlWajUrZjlxaTBtOFdLaXZZdEFHVzVNVUxsTWhs?=
 =?utf-8?B?Um93dGhFWnlkWTF2TWM0KzRtczhBMTFjRWN5UUJNOGxjak9LdHJzRjMydkd0?=
 =?utf-8?B?NXhnd1AyYTlvbkF4L21mU3E0blBubTBnS2ZVYWlML0RtbzlCYVdjRFBaeDlq?=
 =?utf-8?B?bTVNeEhuT1RMWFVER0R3TzE4MGR3Tkx6ZVh2dC9nakxKdmMvWFA1eHZWdHhq?=
 =?utf-8?B?V0dOK2pTWTI1VHR1ZW0yTVh0dTJweGduYjBMK0R0d3dNdEltV2JXbnphMGk5?=
 =?utf-8?B?MG9SVXVFZzNKREt4N0VaWGxXazYwaUFWYzNPU0praXJ6VStqTE5vU2pnY0h6?=
 =?utf-8?B?TDI0OEd2SzhpNnUxN25kQ0t0bjl4MXRsNHZ4Y1MzWStHdGNwMUw1bDZJanNP?=
 =?utf-8?B?NE5wdEt1aG9kTmczYVQvc0dlTTZ5M0src3hZZndjR3NpdTlNd2JQbEE4L0Jm?=
 =?utf-8?B?SDk3S2pJZVJQaEU2aFVFMklJTVpaUE5FR01yNFlqdU9PbE8rS2c0NG1qc1F4?=
 =?utf-8?Q?7Fmgari0fNGm5yz4O7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13ca11d-2dd4-49fe-7e12-08dea966b05f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 22:52:44.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNs0KL9C7zLGWoPeHfIeE4vtTvVCWnl+2QC68d2upby7guL4FxJ3qOXoUrRM0jcD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835

Hi Krzysztof,

Thanks for the review, Replies inline.

On 5/3/2026 3:20 PM, Krzysztof Kozlowski wrote:

>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - xlnx,versal-sysmon
>> +      - xlnx,versal-sysmon-i2c
> 
> This is explicitly mentioned in writing bindings. One device, one
> compatible (not two, not three, not four compatibles).

Accepted. Will use single "xlnx,versal-sysmon" compatible. The I2C 
driver will match via the I2C bus, so the bus type provides the 
differentiation.

> 
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  '#io-channel-cells':
>> +    const: 1
>> +
>> +  supply-channels:
>> +    type: object
>> +    description:
>> +      Container for supply voltage measurement channels.
> 
> voltage, not supply. Supply is the source of energy coming to this
> device. But are you measuring that source?

Accepted. Will rename to "voltage-channels".

> 
>> +
>> +    properties:
>> +      '#address-cells':
>> +        const: 1
>> +
>> +      '#size-cells':
>> +        const: 0
>> +
>> +    patternProperties:
>> +      "^channel@([0-9a-f]|[1-9][0-9a-f])$":
> 
> Keep consistent quotes, either ' or "

Will use single quotes throughout.

> 
>> +        $ref: adc.yaml
>> +
>> +        description:
>> +          Measures a supply rail voltage. The register index and rail
>> +          name are assigned by the hardware design tool (Vivado).
>> +
>> +        properties:
>> +          reg:
>> +            minimum: 0
>> +            maximum: 159
>> +            description:
>> +              Supply measurement register index assigned by the hardware
>> +              design tool.
>> +
>> +          label:
>> +            description:
>> +              Name of the supply rail being monitored.
> 
> Drop property, it's already in adc.yaml.

Accepted, will drop from both voltage and temperature channel blocks.

> 
>> +
>> +          bipolar: true
> 
> Drop

Accepted, already defined in adc.yaml.

> 
>> +
>> +        required:
>> +          - reg
>> +          - label
>> +
>> +        unevaluatedProperties: false
>> +
>> +    required:
>> +      - '#address-cells'
>> +      - '#size-cells'
>> +
>> +    additionalProperties: false
>> +
>> +  temperature-channels:
>> +    type: object
>> +    description:
>> +      Container for temperature satellite measurement channels.
>> +
>> +    properties:
>> +      '#address-cells':
>> +        const: 1
>> +
>> +      '#size-cells':
>> +        const: 0
>> +
>> +    patternProperties:
>> +      "^channel@([1-9a-f]|[1-3][0-9a-f]|40)$":
>> +        $ref: adc.yaml
>> +
>> +        description:
>> +          Reads a temperature satellite sensor. Each satellite monitors
>> +          a specific region of the SoC die.
>> +
>> +        properties:
>> +          reg:
>> +            minimum: 1
>> +            maximum: 64
>> +            description:
>> +              Temperature satellite number (1-based hardware index).
>> +
>> +          label:
>> +            description:
>> +              Name identifying this temperature satellite.
> 
> Drop property
> 
>> +
>> +          xlnx,aie-temp:
>> +            type: boolean
>> +            description:
>> +              Indicates this satellite monitors an AI Engine tile.
> 
> What for? What is on the other side of the channel is not really
> relevant to this device, but rather to that other side (consumer).

Agreed. The driver does not use this property. Will remove.

> 
>> +
>> +        required:
>> +          - reg
>> +          - label
>> +
>> +        unevaluatedProperties: false
>> +
>> +    required:
>> +      - '#address-cells'
>> +      - '#size-cells'
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
> 
> Best regards,
> Krzysztof
> 

I will address all items in v3.

Salih.
