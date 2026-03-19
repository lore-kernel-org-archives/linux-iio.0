Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10FC2D481F;
	Thu, 19 Mar 2026 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928449; cv=fail; b=VWv06g34KxAIk+uJ4qaYk6tac9BnxUwoWt/PGFcoRhQVkCMcCuu0Xa4gSAfWNwF0nmd3hpowvP0gMzdAY3sjdz8cJY7GdRirIroWZshKIUqMM7hPKoYOxaP8TS7nu0bDle4BuE83162WRCSIUtV9f9VxoMnun7ziLtrzAEq2Ss4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928449; c=relaxed/simple;
	bh=mFd41q6xEqBzFLFmxs496Y+SphNi2PrQ+d7r+6Ec3RY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lWsTsy1TS9w/LiZKZ0Vucejoltkxe74JGlD/BA71uYy7NYJdJMwpJN1Ct4n3E7Q2STV4ZLeHTdzjduAsQ8ncO3GZuAfBGvIbCSNckTI2iY321F0X/lG2mZoU/wpr+mCx6pCk7wPcuNiz0PSd/QiW/mt06fNPvPdM/drsILN0bFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0oOfWUdr; arc=fail smtp.client-ip=52.101.48.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0oOfWUdr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdL/NyfwIH+f/dU2do2gcW5FxP8lndJhg8cXEEa2OW0Z1iuxuXHmtrbLbRaQYNtzblC/tJj/X5+J2NsAtL7u2vJrcn4v4a8gZDnOxbaP36vWlcFTBENvpHxCwUvxJZIdMBo2cXai2GyF4Ax9pDEdJmS3WQKFqbjWMPvHEaSIzZ5kNqJLFTKpjCxhkeLhw66iZiiAYuhGFSxkX5OHqg53S2H+Z4LQY2AZxKNf9wa+oToANCZzQhXVRy4iz/jMBJHWgAJOKLmdWCvjaP1U2yzfreWI7xG8RpqP4Y2qCoROQrEUQfvKirVbFRNYxW4IvhmONIXQbRl4JmWVNFio0eOocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqgCaN5xmSIO7tvX501awYktn75nJNemcg+IWq5w1EI=;
 b=qTfghgksRJ50nPvzheaB/HaVVX/hZYkonWV1KKobwmDIiiSzW0ekHmYblNgp2YwW9CWub8V28/CU+5PanOOu4OJsqC1x4G4MRTlKOOZDSR0eZEHU11P6nFq6SN4Iu6czO5Mdk4gHcU3GUVKgl1vRwOieHUU4Qjl5Xg8P8Nxrr3WpGB1sHIx3pGVQdejXg9XrcEiWUZ2OBnRHcDv8Nt+urqhbdLX0/mGF0XAUqh0KhJYrh4rGrDcYnPbCZEsN8JnaGBo64rK5fkXyI36wTWg9DBSSOLGZPhoP+CyBIvELWx9auf+LTwSTnH55hRdMuelzG3OkMTGv1ef78Scr5AvnZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqgCaN5xmSIO7tvX501awYktn75nJNemcg+IWq5w1EI=;
 b=0oOfWUdrITv4gC7FbYLmXkSadDzu0QudNCShLeA9/XSdTGVN4Ao8nOFvSvJllNNWNuxAlxe/i/w7b4pF98XBW/GnoP3zju6wIdlaOla4JrakLOblfbug6NFi1ORMgBNtpBm3ZnFO/oA7Q84Zub7Z9z2z6nm/H9nVtN/Sz3ejvRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 13:54:03 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 13:54:03 +0000
Message-ID: <b89933a3-5f25-466c-a2f5-6e231aa12749@amd.com>
Date: Thu, 19 Mar 2026 19:22:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] dt-bindings: iio: adc: xilinx-xadc: convert to YAML
 format
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, saikrishna12468@gmail.com, git@amd.com
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
 <20260220053941.611415-6-sai.krishna.potthuri@amd.com>
 <20260221-dancing-papaya-wolverine-db8afd@quoll>
Content-Language: en-US
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
In-Reply-To: <20260221-dancing-papaya-wolverine-db8afd@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::23) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c6d53d-5788-4222-eea4-08de85befaab
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JiO/xylo37HjW9lS2OFxYkLeCFnXVRQILKUILZxScQbtzAHfXxeBcfIOEDwchXHU/nhPaiwkoqycjm/7h1ILzhFHkqz9mdx9LbkY0Ivv4SR2Gea7iwgk8XpjTRdNGVC641vA8nnCyxR+14qwNWTEikuBZUM5ebJyCNvB84D8h7CMCMZQoN6tegj8qHktgEOGlwG4lyClBVfziW6Ov7p2jWdauY18jneYdOJN+3IywzxHAGBF80bHtHGmmLg8mA53XVdsmKFjaMZsNq2OvWTIkravvNWTSZgakzksAqFRQxCFcHsxlXO7LcQYXE4rTYq/6k0p7COoX/dt673svn/HzIuKOUAOt2JdW4p8/OBxSs+2vvLbhjMt98a8QMrAZ2g3Oce7k9SzKZk1gyVqrvdsdRP15ERgut7KWP4k2O5l3lTnsDvRQUP3F79njtSYL1Ny9SijRDFbt7U5vOhq5LB4UF9rG2dIaRYPR1xzNb9R7YLiaZC3jovnH0KcQMcm0J9e6CYBCGdynYs0oA5wBAOeUo8E2YmHRTTopSXTAKBcib6fI6j3x+JrTesY4hzsG4Dtncind7CySyEbXz9kxWJxMuTP66OLs9oKHByAb2vAzj2dKjUT5lXucoCssLl9z9e2Aa8nXvEHDITfq3t20l7D5getiNpe0j/P6tNMZBdgu9R2boMJ9H/WQmrvCB3rYN1u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXVFclZrK2Y2RnBpdnhtVk8wUmpYRDJWVmpPb2dWS2ZneUQ4MXNFc0RKLy9C?=
 =?utf-8?B?emIxckRvb2FOMTFNME1mT0R5aDNqcG1STm5xblh4c29MR0U1bjdBbjhIdERJ?=
 =?utf-8?B?eUtqNGp6MXF1VlRsRE9xdnRNQ09HVXFYYjFBZnc0SlVrQjF4QzJzVDcwRXZw?=
 =?utf-8?B?RnpCRkF2TUd2NGt1UjRzbXdiaGxnK0RNcU94U1BhK0lZZkVzdjJpQlNBK1BR?=
 =?utf-8?B?d1lHUmtlbUZGN2syYWFCM3ZqeDd2cEoyNkdLUVpvL3RJM1I3aWdodzVVQmg4?=
 =?utf-8?B?MStOSi9vOWRUbTBNYWJ3WW45S1NITWRTN1NlS0JweXo2SU1ReUZmLytZOVVo?=
 =?utf-8?B?S05aeFlxcDVNczRWd0ZhMitodTBleEkrNHFpSjhsVEtDcitnQmR2RG53WGZO?=
 =?utf-8?B?emtsZ0tJWTUwbjgxdHJUeDlDczlYZGhDRnE3Q29Tbm00b3ZKcFZleDlWVmNK?=
 =?utf-8?B?RFA3MTNya3d4VHBId09PMDhTYSs5WVVjTUhVcTRCMUtIQ2lNSDJtVGhCdGpD?=
 =?utf-8?B?U3F2TUZ5T3cyYjh3bVE2R2M5MDlNMEdxWm9FdFFNT2FVeVlOenZMUnpxY2ts?=
 =?utf-8?B?NzlqNmJkczZCTFVYWWxQaXFYd0RGSGtqOHZzNHJnTmtHV2NUSUM5WndBYkh3?=
 =?utf-8?B?QlNLd3hwSkU0MWdib2tmcmJLYW1UUXdLL0VEQzVlU0dXd2FkSWhWSkQyTjNU?=
 =?utf-8?B?aUowbVd0d1RodFVyUnVJYUdsSlYvZTEycEtuR1lGMWNML1U3RlA5OFVtWVd4?=
 =?utf-8?B?dkRCZkdyWklGQWg0QnpYQnZBVVU4UVYrNjlkbnZaZzQzWXp5TmdjdEl1UlEy?=
 =?utf-8?B?OWRRWmNlWUdOMitXQWV6SlJ6OXhXakRMbGFJT2RRS3h6UjNlekp0YzU5Vzcz?=
 =?utf-8?B?QkZKclJaMys4YnUwaVU3enFvZVFBUkI1ZEJENWp0ZTA4dnR4QjFtMSt2dzNB?=
 =?utf-8?B?TWNFMThyUXplMDZVRGNNMGJpZ1lLTjNDaDBOTUdJSmNKS3dGaTVzMmxpanFk?=
 =?utf-8?B?WlhxZUU4dCtMcEhoNVBHZldML2VyRXltWC9hakR4LzAvMWVHWGtSZ29KUzhS?=
 =?utf-8?B?T2pUMXFOTnhWU3daTGU1S0dScGVYQU1hUE1tUW8rTUdxU05EdTZKQXhQQmFF?=
 =?utf-8?B?OWF6cGU1VFIvWE9zL1VQWFA4aUhTSmJQMExrb1MxM0Q5aWxRZ3dab3JCNTJm?=
 =?utf-8?B?blNNaERXUUwwQVlYVjVNN2VjYmFMQ2tuR28vRU1MRmhXU1BnTjd3MFN0WU1V?=
 =?utf-8?B?MGpkYVBtbW43V0FLOUl2SVhucEZ4dzZQMlY5SEFpb1NtcEdKTmhVTGVhSSsv?=
 =?utf-8?B?WFVoeWxCVHArSENFcHQxWXMwRG5DVmI4VmZQVXJTSUl3MGE1NUU5aG9CU1VR?=
 =?utf-8?B?dnA2Q0dOOUVzRVFlMnJnMmdQK3dCRkN5VDNraG9SZG91YzhNa3VyVzNMbWFp?=
 =?utf-8?B?YTRsK1l3TFI2cnhFSDF5OTZnNllnVGtJRHl5bHNoOTBCQXFNdnpFaG9pS1lw?=
 =?utf-8?B?NHRMYUFWemVEcFVXVkFHUTN4Z1lkNm5ZQ1pNVnVycm9Vd0pFcytqU09YOXJR?=
 =?utf-8?B?aHJnWWhVdHhpUVRySjRYREhMRXlRRXY2S3NjMjBydnhDSUZnS1R0SHY1MzJ6?=
 =?utf-8?B?QjR0UkpLYm1NRVFVYmtwc3RsdlRiamd0cDkrK2gxelYvMWZJZGlrdnhUeUZJ?=
 =?utf-8?B?ZUgxOVNuK3JqdmdHWTV4b1h4dTI4bDNvbVlDME0vdjRVMktRbmNPSXlzbURL?=
 =?utf-8?B?S3BXNEFBS1BvbGd2UFMvcmY2TkpTTExZVEJEdmVpYzlCMll2MWhTSEVZWUVm?=
 =?utf-8?B?RmR0emhzV2h3VkwwT21GdVFzVEU1dnVnMGxZTVhHYlk5U2J2S1ljTjc5MjFR?=
 =?utf-8?B?d3ROVlptNXdTcUszQkJmTUx3QUhQdit5OCsxYzh2UFRDbEVvNzNicWpEUHI0?=
 =?utf-8?B?Qks3cVNQb1hJeDluYVcwTzQxV3lJTU1wWnc2d1F5VHRzZHBtMDhMZXJ0c3Vs?=
 =?utf-8?B?STljeUZGeFZSeDF5dVVqOGp4SzczcEEzYnkzT25TTjUrT3JpNkRNUzVrYk1D?=
 =?utf-8?B?ZTB1aE1adWhWOXY5TVRlMUl2OEs4ZUFvRE1wSlB2cm1KbDB3SWFGMENYbEpB?=
 =?utf-8?B?UXl1a3VmNWphdXlxUUE4V1ZVcnhSWkhUc1FXOHI2dXdpWXM4QUxkbGJpaHVU?=
 =?utf-8?B?SDRZU1VkMkVZNTNTR1Q5NFVLSlJ5cE5ic0JhTDRWV3VSd3FmVTJUYWxiRUZl?=
 =?utf-8?B?UzJESTJVTWpyVVB3QWRYSkFxZlhld0YzRk9YdVBob1VOYURIMVE2U05sUllX?=
 =?utf-8?B?aVAzUWZYMmRRVC96MUxzMC9TUmp6M05lVzlwN1FNYXdxb2JtNTJzZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c6d53d-5788-4222-eea4-08de85befaab
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 13:54:03.1383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAavk+f8Mdqf7alGP1lHlC62vWzdmPG1BCa/SjL1tRZvDupEP9ygNHp26jhpLLwOFtoIvVdjBtYtTqWqUyvifg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070

Hi Krzysztof,

On 2/21/2026 4:08 PM, Krzysztof Kozlowski wrote:
> On Fri, Feb 20, 2026 at 11:09:41AM +0530, Sai Krishna Potthuri wrote:
>> Convert the xilinx-xadc.txt Devicetree binding to a YAML schema format
>> and remove the old text binding.
>>
>> +
>> +  xlnx,channels:
>> +    $ref: '#/$defs/channels'
>> +
>> +allOf:
> 
> Missing ref since you use unevaluatedProperties...
> 
>> +  - if:
>> +      required:
>> +        - xlnx,external-mux
>> +      properties:
>> +        xlnx,external-mux:
>> +          enum:
>> +            - single
>> +            - dual
>> +    then:
>> +      required:
>> +        - xlnx,external-mux-channel
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
> 
> or you meant additionalProperties?
> 
>> +
>> +$defs:
> 
> Why this is a def, not used directly? I see only one usage of this def.

I am getting the below error if i define the patternProperties directly.
Seems like complex vendor peroperties should be referenced via $ref.
Please suggest if there is any better way to deal this.

linux-xlnx/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml: 
properties:xlnx,channels:type: 'boolean' was expected
	hint: A vendor boolean property can use "type: boolean"
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
   LINT    ../Documentation/devicetree/bindings
   DTEX    Documentation/devicetree/bindings/iio/adc/xilinx-xadc.example.dts
   DTC [C] Documentation/devicetree/bindings/iio/adc/xilinx-xadc.example.dtb


Regards
Sai Krishna

> 
>> +  channels:
>> +    type: object
>> +    description: List of external channels that are connected to the ADC
>> +    properties:
>> +      '#address-cells':
>> +        const: 1
>> +      '#size-cells':
>> +        const: 0
>> +
>> +    patternProperties:
>> +      "^channel@([0-9]|1[0-6])$":
>> +        type: object
>> +        properties:
>> +          reg:
>> +            minimum: 0
>> +            maximum: 16
>> +            description: |
>> +              Pair of pins the channel is connected to:
>> +                0: VP/VN
>> +                1-16: VAUXP[0-15]/VAUXN[0-15]
>> +              Note each channel number should only be used at most once.
>> +
>> +          xlnx,bipolar:
>> +            type: boolean
>> +            description: If set, the channel is used in bipolar mode
>> +
>> +        required:
>> +          - reg
>> +
>> +        unevaluatedProperties: false
> 
> Again, where is any $ref?
> 
>> +
>> +    required:
>> +      - '#address-cells'
>> +      - '#size-cells'
>> +
>> +    unevaluatedProperties: false
> 
> And here, please read writing schema and writing bindings docs.
> 
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    xadc@f8007100 {
> 
> adc
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> If you cannot find a name matching your device, please check in kernel
> sources for similar cases or you can grow the spec (via pull request to
> DT spec repo).
> 
>> +        compatible = "xlnx,zynq-xadc-1.00.a";
>> +        reg = <0xf8007100 0x20>;
>> +        interrupts = <0 7 4>;
> 
> Use proper defines.
> 
>> +        clocks = <&pcap_clk>;
>> +
>> +        xlnx,channels {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            channel@0 {
>> +                reg = <0>;
>> +            };
>> +            channel@1 {
>> +                reg = <1>;
>> +            };
>> +            channel@8 {
>> +                reg = <8>;
>> +            };
>> +        };
>> +    };
>> +
>> +  - |
>> +    xadc@43200000 {
> 
> One example is enough, I don't see differences here.
> 
>> +        compatible = "xlnx,axi-xadc-1.00.a";
>> +        reg = <0x43200000 0x1000>;
>> +        interrupts = <0 53 4>;
>> +        clocks = <&fpga1_clk>;
>> +
>> +        xlnx,channels {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            channel@0 {
>> +                reg = <0>;
>> +                xlnx,bipolar;
>> +            };
>> +        };
>> +    };
>> +
>> +  - |
>> +    adc@80000000 {
> 
> Again, one example is enough, unless you have multiple differences in
> properties.
> 
> Best regards,
> Krzysztof
> 

