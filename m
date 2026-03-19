Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1013D6488;
	Thu, 19 Mar 2026 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931838; cv=fail; b=dU157euuWceK8p6goxYSZ99IM5vkq4F8GLK/irRGi1huxuvsnryUKSpnOwYCmDjUY7yDvLxj8SOz2rFLNFrXbB2WMkGbap2jEI3Uolypx4LclHgrjZPgHgVtPE83Jy5mUR8iCU335SltN5fiumCUuuQyYFFyu/rydwGpsAJm+IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931838; c=relaxed/simple;
	bh=IzmAukYuyfApotkRZUQzbZfxx8Cas4dXv/nw0YlWB38=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ildMth+7f3lEG6i68W6naHX8Ot1oOMUT9r4UFdDgiwX8SeKPMdiIZTZz/EINgbzq8yIqmxwVUR9SwcNesPbEUxPGVxiEp8obKnRb61pDFFfC0W0lVuA3NJ5UT+vXzWyXm7EwCblwMhiIQl50cWs9moQQ27cFZb6H57JmW1M7hRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qjk8ONny; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qjk8ONny"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yibvGYTnD5jjNujxAgEqx1yHmBW4/22dENN/QmyIRCz0GiDKIYhGfzI6OoOjJy8JDsa2uMDVftwH76QoCbaC/xvZru5QOlB3pXg7ByCbYCtCOfGvPBmh03K82KOW5Rz48m8v/Ogv8e5na2MH/jiu5ilgKkmIvkBVzeieQQflQuCIenzfX6wO7dvpPsKp5NDLzBp489j2MokIH4xyIOJ3773M0l2BB2cYzAP+UG1tkKnbAQ4/dIXzkdEgareH2WhKaJNvs64USCjpxlUcT3s0qv/zIPzPFXeRWu7HiJv0mYGFvCkqCp2dH7W0dYxz3XvGwbgp09nOfDpp4P5d1QrfNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIK5Dp3aLkFZSu9Izq1UyMVjo7v9uF8aj7roSrV8NoQ=;
 b=Vl4+GtZyQQvHtpa7erQLrcmFe6vON90YwUBdO3v2j/ODL1tcVSoWC27SQgCmM/EexcPIwO3uoRQA3jhc3W9M3U10fKFkqVZD+DCX3Wfq/6YnEOOgE/OV4WFYkfSGEtYRQcqmCIjQ1u/xVRVl5sXzrMd7hDXZLfpwECw7ivTsLeSmSgq9e0UNHH25LXJFPUSOoLkaYPZUmXWRE4A9A6yR1HB6heggh9wlLsxhV/ED+bXAYR6a2tY43ne4GmvgMnXUki0dyCBqevBNKaecMJgEVYZSThyHLn3y3oRXLF3ojkWWk1dWKR5wgDz4SMUVVasEgx9aPdk6EP9In5sH+GR9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIK5Dp3aLkFZSu9Izq1UyMVjo7v9uF8aj7roSrV8NoQ=;
 b=qjk8ONnyLuZv/zkZX535Bx7d/aZcJwa0SQcglCs9eywm9yfZDjaN0HVDpQQQzbhc4UNKQtSp+Kgt5FE3oY0K6psbTROWUm//zsAPtBFuFMsbt/9ho/JyHEyDr+VuJLiyvwlpgYYC2UP7lFG/v1hXsXpOOCC/RVXEr0haRnNVjrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 14:49:18 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 14:49:18 +0000
Message-ID: <e4c9729f-1785-4d10-a337-37b0d26fe30b@amd.com>
Date: Thu, 19 Mar 2026 20:19:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] dt-bindings: iio: adc: xilinx-xadc: convert to YAML
 format
To: David Lechner <dlechner@baylibre.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, saikrishna12468@gmail.com, git@amd.com
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
 <20260220053941.611415-6-sai.krishna.potthuri@amd.com>
 <20260221-dancing-papaya-wolverine-db8afd@quoll>
 <b89933a3-5f25-466c-a2f5-6e231aa12749@amd.com>
 <21d425bc-9406-401b-9817-7255ba3d31fc@baylibre.com>
Content-Language: en-US
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
In-Reply-To: <21d425bc-9406-401b-9817-7255ba3d31fc@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::10) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dacd126-348a-47ea-0d39-08de85c6b280
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 AP/Mb1M/7/rcxkzZUOBg8h4I7eHvBf12V2A2wK1HdBKI3qWj0QjkGf1izLepwfCwcY1W0nlfymWyuH0oS3tpYkC08gYwcfOSEjuZFbuYiLhWjb6OI77dh+dyGrh5ifLHl2EtEnUVoEVtFI5kSADpN4mmjZscO/WG9sjC25AK0p1b1GQ67CJjkRd04PxfeGCyD5Bx5QKQvdADnJBeLk1Zc5mJDAUtmXe5yAvqLFlViMeNwrKz4C0oeoZBJANAn7I4lthZDWFVqVDejA8Nz1Pa3Oe0k2x3n8ACRGavmve3eRjLZK3TGCyGr1AVxJlcQrAQ1ALd+LAgI/r0/GV1nTIM7C4xcl7GTypjL7aWy43reIDhIr5VX46jyxP2NTt89Md+6Ku9Q8C5ESp4s5mTwi8Oj7/SRqDEbOdoChQFUD2w6xAVH6bne7q9mPIn7/qM4Ywms2VN8r6qZnhApAaCKeYLyFUAuhsx2KFIROCFvbMDmiwIfFyXXMKdb3pcRnlvD/AjtTdvXkjmXu3wBfbixELKBJ99CCxNii3umQHm7wIcZDmsLKmYrZRatfG+MAG5Ky6jtGeb8TqXBvbCYaOcFQY1UyPahtUnpi8OY3gpr54PvlMZu7r47CAymYqhcPEZ2GAT8WmwNngvT4jOpP6kYF/hrbZF1MMUkyypSjW/Hw7iPw8UbsQC5l+l8JB+GzCJlA4T
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dUxCbktldHlLZFJRQ3ZZdTl6bW4yb3k3MXMrbDlHNE1Ea3V2Q3RTSUtEaWl0?=
 =?utf-8?B?OXVHbFB2RFVCeXdPVXVDd0VOZ3o5Ry8xdFZYZG9INkRiY3lNOEVtdFVhelBx?=
 =?utf-8?B?SlIvWGM5MjJtSDQvQ0NWSXJTWVkxN29wdGxPNERES0pGVkk1eWlJMzZNZ296?=
 =?utf-8?B?aVNGcWRpYTNMT0VKeDNJbS9VVFdpZ1l4Q0ZnZGsrSUhJMUI1WUVKaTA3THlw?=
 =?utf-8?B?VDZkdUtCYXd3eUxPVEE0N1FSN3lFSitoU2RGQW00TEJ0cHFoRXpKazNNNGhG?=
 =?utf-8?B?bnNyVmdMUkpNRnYxOGt1SGpZUlVkeXJNSUZQNWIwTTUrc1VKNDZ0Wkk1T3pF?=
 =?utf-8?B?VmprcnZETVVFVENxRk1JelFGWWZPRWx2Z01QU2w0R3p3b3N1ajBCaTdqWTdo?=
 =?utf-8?B?aXllYlVZV2dPdG5GQVFuM2IzZ3lMMGFQanFjVTlpWmh5ZFgzaStldWNqbm5u?=
 =?utf-8?B?M0JTeVJxcTNpWldubkQvSTRRc1lmcTFSOTY0U1ZnVTdtbk4xcGs3ZHpSY3VO?=
 =?utf-8?B?YnNpMkZ1WFFrVUdDdXUvR2JRd2Z1Z1JqcFc3Z0V1ZGo3dWg3VmsrWk5XdHli?=
 =?utf-8?B?QWtZT1JSeWhRaW9WNHY0TUY1SGRuMmdIcmpEZlIwRUpPMVNwVEpsOThLRTNk?=
 =?utf-8?B?bmVRbmpvRHpkeFRpNWpxKzdkTE1GYURkZXRzU1k4WEk2VVk5UEJpZzFhREwv?=
 =?utf-8?B?amwycXg4V09hS3hlVThRTlc0MkpIczkwaE5sVHdQL0Zmb2ViU2VmWnBPYmor?=
 =?utf-8?B?WmxiUTZBemVjWjJLWFNaZXZhQ2NVOUZmQ0R0KzYxdGNDSFBROGt5UjZXU2Qz?=
 =?utf-8?B?SWU2TDhYejJONTZHMUxPeTMxckFhWXJPL1lzcWZzRVJGOXpraWVPenk0WW45?=
 =?utf-8?B?OE5lVTNneWpmQ0ExQ093MkpSSURtd3RROWkrWmlNYkNoeWNGWHliYlVnVElj?=
 =?utf-8?B?S1NiN0dnQ2xYM0lXUHpSK2pHYUZTWmowNktKcTZFdmM1ZFhDYmJVam9BNEQz?=
 =?utf-8?B?STRlWkdta2t1NDIyYTR1a090U3FwdnFxL0VPbmplRjRqSndsMXlZa2VPeVlK?=
 =?utf-8?B?VGV1cENIY3Z3YnUzUTMwY1dzNUZjaFV4WVpYWlZkSXA3bFVEV1oxNFFSS3NW?=
 =?utf-8?B?RVFTaUcyTUhTQkJZdXdwS3hYR2xSdVR4eDlETUR0WGVnbjllKzVIQ0xqNFUz?=
 =?utf-8?B?KzBGWFF0L3pkRWllSzdzNXMwWWx5Ui9ZYzFsdUNiYzUzdE92YStqem9xQnBK?=
 =?utf-8?B?NTlGWnJtdFJPVFFZNExDR09FQ2Y2Y3hVS0JaWGZRS0VnclNUdWROTTlhV3h2?=
 =?utf-8?B?UG5VTDlZTUhiNnc0Nnl3b0VPeXhmM0tmNVBPY0ptYUxPMG9ZREdLQ1R1dnYy?=
 =?utf-8?B?WWkvdXNBK2ZUQmVqaHlHK3hrNjNreFVOQ0dQUmQrR2I1N05jbmlVRzk4S3o1?=
 =?utf-8?B?bXlqQktGb1RxZGMrRFdwUm1abXNKR3BrYTBLclRnZ1FHODNiYzhGaWNNZllI?=
 =?utf-8?B?VUJTNXU5Uk5qd3hneVJRNU04aXczcnpIdTFBeG1FNFVNWnRHejNZdlhvSmxw?=
 =?utf-8?B?WWNTUk9iZm16Yi94UmJhdjhPVTF3U2F2MmVneUdQeUJ4TzlUMHBNMjM4Uk5Y?=
 =?utf-8?B?UDRoRHNOaWY5bGtQeUVLd3ZncERyeVlDUkIvSVo1alV2clRTbEk2bHR0enFO?=
 =?utf-8?B?UCtqb3ZGVlg4ZTZxNVBIUmdCYklXOFQ4aGhoS2RVTExRUGROb2EzbFRNNGdm?=
 =?utf-8?B?MGJSR1l5Y3ZzbHY5b09vK1hVZnlOdVVsUDdIUjBxNUxkZ3pndDhVUWxmTTZu?=
 =?utf-8?B?RlhXNzBPMkF1Q1dBTm8zazJsM2FYSTlWakdTRFFHYTFxY1RHOVNITG1wQnlR?=
 =?utf-8?B?OWZCSml4U0hTVjdtWG9wRVBDcjk4eUFCZ1d6eGtlKzBGNzBhZVEwMTUyeTFh?=
 =?utf-8?B?ZEF6QUQ2UUIyZlpSTHBIY3F3QzJGTVpGc3B5SXkwNU1EbStIM2EvTWhtWkth?=
 =?utf-8?B?ZWdpRDFwUFRGQS96aHJhOCs3L3VGczI5cWpLRFA2SkNXa0FkR1lwYkp5T0Rw?=
 =?utf-8?B?SzE3L2s0SmtxQjgvWHpSdUJ3eG16MldzNVMreWQvSi9lTFVSM0ZDU2ErNUs4?=
 =?utf-8?B?OC8xdlVjdnRZQ0FETkc1YUdjOGZtOWIwZU1RV1FtaHhFdFVwb0RxN2RqcENi?=
 =?utf-8?B?aTRFeE9tZ0wyZkFvcTNzR2hnNDBKRWRFQXYwZHJ1SWFsMWo0d3FvRllhRElB?=
 =?utf-8?B?NzUzOGdxK3ZlNFpqcUJNeXlzdXJIdVlWamowRlFMaWQwSjB2WmpzSTZHZ1pn?=
 =?utf-8?B?YWpVLzNlSHQwb3J6bEt1WW5rNVlsTEtHRGgzRmh3dzlQSERZcUhKQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dacd126-348a-47ea-0d39-08de85c6b280
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 14:49:17.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9jHBMBZq1UCAhp9sEaR3fSj6b/zVUQ7BkCu3pzlbwaHCPsyU4OWcbsin6u+bPbd949mlndWHtH0BXSfPsdyjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113

Hi David Lechner,

On 3/19/2026 7:53 PM, David Lechner wrote:
> On 3/19/26 8:52 AM, Sai Krishna Potthuri wrote:
>> Hi Krzysztof,
>>
>> On 2/21/2026 4:08 PM, Krzysztof Kozlowski wrote:
>>> On Fri, Feb 20, 2026 at 11:09:41AM +0530, Sai Krishna Potthuri wrote:
>>>> Convert the xilinx-xadc.txt Devicetree binding to a YAML schema format
>>>> and remove the old text binding.
>>>>
>>>> +
>>>> +  xlnx,channels:
>>>> +    $ref: '#/$defs/channels'
>>>> +
>>>> +allOf:
>>>
>>> Missing ref since you use unevaluatedProperties...
>>>
>>>> +  - if:
>>>> +      required:
>>>> +        - xlnx,external-mux
>>>> +      properties:
>>>> +        xlnx,external-mux:
>>>> +          enum:
>>>> +            - single
>>>> +            - dual
>>>> +    then:
>>>> +      required:
>>>> +        - xlnx,external-mux-channel
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +
>>>> +unevaluatedProperties: false
>>>
>>> or you meant additionalProperties?
>>>
>>>> +
>>>> +$defs:
>>>
>>> Why this is a def, not used directly? I see only one usage of this def.
>>
>> I am getting the below error if i define the patternProperties directly.
>> Seems like complex vendor peroperties should be referenced via $ref.
>> Please suggest if there is any better way to deal this.
> 
> It is hard to say without seeing the new version of what you wrote.

In v1 series, i created $def and referenced this in xlnx,channels to 
avoid the error that i mentioned.

v1 code:
   xlnx,channels:
     $ref: '#/$defs/channels'

   $defs:
   channels:
     type: object
     description: List of external channels that are connected to the ADC
     properties:
       '#address-cells':
         const: 1
       '#size-cells':
         const: 0

     patternProperties:
       "^channel@([0-9]|1[0-6])$":
         type: object
         properties:
           reg:
             minimum: 0
             maximum: 16
             description: |
               Pair of pins the channel is connected to:
                 0: VP/VN
                 1-16: VAUXP[0-15]/VAUXN[0-15]
               Note each channel number should only be used at most once.

           xlnx,bipolar:
             type: boolean
             description: If set, the channel is used in bipolar mode

         required:
           - reg

         unevaluatedProperties: false

     required:
       - '#address-cells'
       - '#size-cells'

     unevaluatedProperties: false


Regards
Sai krishna


> 
> 
> 
>>
>> linux-xlnx/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml: properties:xlnx,channels:type: 'boolean' was expected
>>      hint: A vendor boolean property can use "type: boolean"
>>      from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>>    LINT    ../Documentation/devicetree/bindings
>>    DTEX    Documentation/devicetree/bindings/iio/adc/xilinx-xadc.example.dts
>>    DTC [C] Documentation/devicetree/bindings/iio/adc/xilinx-xadc.example.dtb
>>
>>
>> Regards
>> Sai Krishna
>>
>>>
>>>> +  channels:
>>>> +    type: object
>>>> +    description: List of external channels that are connected to the ADC
>>>> +    properties:
>>>> +      '#address-cells':
>>>> +        const: 1
>>>> +      '#size-cells':
>>>> +        const: 0
>>>> +
>>>> +    patternProperties:
>>>> +      "^channel@([0-9]|1[0-6])$":
>>>> +        type: object
>>>> +        properties:
>>>> +          reg:
>>>> +            minimum: 0
>>>> +            maximum: 16
>>>> +            description: |
>>>> +              Pair of pins the channel is connected to:
>>>> +                0: VP/VN
>>>> +                1-16: VAUXP[0-15]/VAUXN[0-15]
>>>> +              Note each channel number should only be used at most once.
>>>> +
>>>> +          xlnx,bipolar:
>>>> +            type: boolean
>>>> +            description: If set, the channel is used in bipolar mode
>>>> +
>>>> +        required:
>>>> +          - reg
>>>> +
>>>> +        unevaluatedProperties: false
>>>

