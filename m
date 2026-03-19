Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0543D5221;
	Thu, 19 Mar 2026 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933068; cv=fail; b=eXD9NN6l+RgGKWiyjVtsDYjF9hwq+x16R2zj//q3wu6xuJBll7MzQH/1q31wxlIxI/rSkh2V+NJQnXqZZIIVAekHYHG3s0Meb8zvQV0VzjYgyRG18Z70x3VByFnKfs6jGvk5qD7i2TIdkalghriRxHKTuRfCScuL3QaLWb/FOcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933068; c=relaxed/simple;
	bh=o6NS3bmVXoSmHNJKBUwEplZsd56f1EG+BErLz3hVBhg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PqG/XeOu/wPAIAs/AHVwCWGUtvWZ8yQkSYAj7SYPYIR52vjNZ9uzP2dQ7wjDkDhdtRM0UC1URUcm+Kiuobsw5rRH0ZN8sO46JPmXYPAfglkk/sJcfwvdqBQJHmDEfzeNfMLngycm0gEAHpuidg1ulU5Y9bCIDKf6J8aZKY6+M4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jp1w4o+a; arc=fail smtp.client-ip=52.101.61.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jp1w4o+a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iv0meF1xaoKNdZIj2q4pZCpzQDubINJFAxJCQNFUknHmmNZPF2htGsmQkNMV5FohU8dH+9v8iV6odo2BtHHcZB3ycaWl+EL+KAdjIARQ6yeuNKatuvSeuwHnicLrC8O7MHVXauJBu+x/PtHoM+JwyK7br6shAOr3kM1sdZE2b35Znj3ZcvvTerl0+G8Kxr7m0Ufc0J2TYcD+9G19gB6j8N4yAIaq4zfgAPpI+4djlEaCvscw96pryiNeol77dZTHYQiKTiDKBy6EZTV4Raosa8RdEfgIN9BqYySzchhGyGwnWibYzSywrw5mjgUc1WxcqabpHN4RhhptmByhcKS7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAEFPxZo/uezL5tbahsMlA+S9w8X0vhXyC985x5Nhzo=;
 b=Ar9KT20gSFHH2ucwiaZE8H/acBW9KDJENU4lgNGVnZfS0BKAE5NRLk9WtKGOeBsFVLzJHXraC40WEOwlRu9ThsTXf3VL+r4fUPPz9A4HkXUn4TR51SppUvdsgEIwDKG8JpSQ7FEgn8DHTuCiLySUsATN7X433psga56zOH2Qe2//+/EYvf/qzjZGW/UIZFvqpe/g+SERfjQ8gFGLBx87ULNE8QvU6qxmrn0auNsE2IthvTW37x9F9qoC3nODwycPdXzJYC1E08HjnmpyIi5jwGZtXgIHAtDTmWv6h6oqwgmK4DdUnWhvbxeN+UuJBBetC52fxjLbDkScQZxHsglgQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAEFPxZo/uezL5tbahsMlA+S9w8X0vhXyC985x5Nhzo=;
 b=Jp1w4o+afgTYptsg38OvKkYtNFAyMl/4h21q7+dj5Js705apZxH+elg6CYqa1JLz12I2cGYrzs4dvOSP87rcdqVCBXg+q4OloiXlAYvDxAjhj8QKNjNeVrKyL87rPX6zphRGLg4k5r51qK7bLGF3DSlPuF1X23YodYRq8MVRDWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 15:11:02 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 15:11:02 +0000
Message-ID: <05bcc5b7-b3e8-40fb-be70-413c74afcfb1@amd.com>
Date: Thu, 19 Mar 2026 20:40:53 +0530
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
 <e4c9729f-1785-4d10-a337-37b0d26fe30b@amd.com>
 <f1706ec0-3995-4fdf-a9fb-8e1e688438a7@baylibre.com>
Content-Language: en-US
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
In-Reply-To: <f1706ec0-3995-4fdf-a9fb-8e1e688438a7@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::14) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: a99dc636-42fb-4839-62d5-08de85c9bba1
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	r77ifrdtanyOujJH8OaO/SOJlqMuXp/iyFnM0pTgGCeZERzpJhyVepUm0y5sPlR9RC1mHXzDB3NZoSJ/+41qhAo4mejayeGLQUUm8A8zs7OoBUhjPCZa7t0ac4+757RkMzTJCv5YZoo38azFR7Wn6GXA2KZoGl6/8nzMzEIE0muGwRQ53kBASS6sfqpub7KfxIZF+7p+SuU3gV/k08OXbtswBgr3CQFKL8+PS7TRcdVj4ws1I1RIg7LXUtVKsv1qMRLObDJ4JdsOAI4RRqc6TIl7vj+VQrCL52si1+IeUXWV/PXa0ST61immwv0DDyvuIzltVzmd2rHh3EOm5q9ylKF/qsGV8pqst2lotTsbRA5BgJ+pXssy2c5iqNxCR5IzJQ/L1M2ug16j3SERxvtcfmtL9ezDpUyeteknUnv7yWtcrgOImDc0TfVbLBA2+/BrT/yvUv1dwjgGKCl3sICuDPi6wRmsl9l7mX5es3OQzSB/Czw1NShuYr4bOPo0zwIR9/IV+ESfqrifY5y5Q2tEgq7LkSvWdTfnN1F0OdCZJ79BwqnsDI1AOTtP28QYhI3S8o6Nr4blqantS/7km9g6FnHA0sWwyfnY0Bk17ZL48wFtIb8YN7Qn+p6jjHeW/yPqN/2kgcFNsE0MB8F9tXSM+rZsq6RNmHmOd7lSD1Ewr6Tc36PyzxiT6WeoQdpos+9f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk95cWFIYSt0ZjhxbldVVDl4YXBmQUNoOW9SeGRRRStnblJSS0pRSExFTXdy?=
 =?utf-8?B?UlBvZ1MzWVRFL3ErYzhWVStNSTdFRktIMTVTQmdFMEx3alhKNUdiWm44dm1Q?=
 =?utf-8?B?aElNeW55elRwSWdCVWpoMkM2dnJpZ3lKYkpJUmd5Tk1pYm5IeDQ4TmxEQ3pm?=
 =?utf-8?B?ajFvRXEyTTYrcG8vU2VTNmJMbVFhUnM2bFhrcjRiMGZ6SUtrK2dlUlhHWDMy?=
 =?utf-8?B?YmhvVm8wc29BVEMweTN5b2VWSnVzY2kzUUdCN2srUkQ1M3NJVzlOT2FzSFlN?=
 =?utf-8?B?M0JSOHUvQ1VoeTFLeERtQzMzNVJUU2FIR0d0TFpIakZJdkIyRnBRWUFza3Zi?=
 =?utf-8?B?bnZyTHVXcjhFL3hjWjJJalIzZHJUTm04UlJEemJLY3JOWDVTaHBQNWUvYkNI?=
 =?utf-8?B?VlBGZXRHelVQWXNBd1paUGcxQ3dTLzZSbk5HUGJoenVhM3g3WjR5dklzUk5x?=
 =?utf-8?B?VjZ1RmRlV3F1Tm1nSkNYK1lIZ0VHWllRR1NvL1o4L3BsYkZrRHdQU2srSXFx?=
 =?utf-8?B?VWo0elA0MUdWeGozNEtKVC90NzRCMWsvYS9hbTFEM3c2UkxpdTZMRXFGcVU4?=
 =?utf-8?B?MXhaTktMYWtxOWlUUjFFeWJURERsNlFhQVYwNC91QlRXakNOckp1b25QbmhL?=
 =?utf-8?B?MzU4aExiV3A0dzEybWRtOXhIWjUzeTk1MFhHSnhXTEZtMUVFK2d0VzNsS1BT?=
 =?utf-8?B?MFBPQzhsSXBBdmo1cE52T1VBVzdsU3VmcVdHNGRRWko1ZGtGZjVpYStTazNH?=
 =?utf-8?B?VXc5akVXeHAyT0JwMUR0UFhnOEN4VjlITFl5Z0NQZmtTNGdOb2M1aTRDUldy?=
 =?utf-8?B?T3Q5MXA4c1g1RjNqcEI5U2dTZDNPWWFDanlDbkFLSDFkTHREUEhTU3owaDM5?=
 =?utf-8?B?TWtZNjNZMDEvdkh4OXpSNWN4SHdpeVBPNzUydk55QUw0K3l2RjlpMFh6enp1?=
 =?utf-8?B?N08zRlNmVjRkOGFCTU1FODVaNUNuRzYzaVp0RjJpYUtjUHBoTGFuaXpGcm9X?=
 =?utf-8?B?ZnJCNUFuWk9TcVpYelliVFY2aVdZSFc0WXloeTlGbktoN09ienFFaVMvNTgz?=
 =?utf-8?B?UTgwWEhLM25RUmV4MkJuQmlqWkdhZGkwc3BmVXBJb0pyTUF1cE10aFN2NHpG?=
 =?utf-8?B?d0ZudGVIZWRyLzBVb0ZtTUQzZklaWm9pOTJrOVZrRTRQMEI1aHlaYWJUZ3NV?=
 =?utf-8?B?VVpTU3VoTlpNNUQwTTdnOG1TYnQ5YjZKK2x2VjdGRVJVSGVHVDgxRUM1T1do?=
 =?utf-8?B?d0tGNnhkMXZhaUpycDBYNDBaY0xIbFdEYTlYMEptZ2tsK1lMT05wZXIyOG5M?=
 =?utf-8?B?WDlGZWNrejZ3ZXp5MjFvZ3FsL3VtMTlmZ2o4akdPdnRubm15Q3podGVUUnQv?=
 =?utf-8?B?UEFMT0tiZFZOUzJyZ0ticmphQS9kem9UeGcvWjI2ejV3SHFFRXRvSWxxdXJi?=
 =?utf-8?B?N1VMUmpVdG40VmNUVU9NWk43QkczdVZ6S0pnWVZIRVNpWVlGcmM3REorM1RQ?=
 =?utf-8?B?clQ5MHRoL3lCWFlDaDFZVEFodzc1OFhDMUlYRUpUYldEeEV3RVFxTjlXaTJk?=
 =?utf-8?B?emp3TXdjVlRSdDVoTXliT1ZmS1FVUHVmUHhTMHFDbjFVYzBjM2F1NjJjczhT?=
 =?utf-8?B?YnhwalpDbWVTZk5YN1d2cnB6QUtkZTliK2tEQzB1bzNCd2YvKzNJOHp3V2lZ?=
 =?utf-8?B?VUNTQWVYdU02UVJDeTFDaGJSUUVjbG9leGhINGNzSENLV3F4dTZOUWZ0YkE2?=
 =?utf-8?B?TTVvazd1OWowWGdTVEh4amJqY0J5TUMwTGYvd25OLzk3VHhnYzRGQXVDN1dM?=
 =?utf-8?B?NGpnN2p6c0I1Q2gxQ3ZUNFpzeGlocTFia1hnK1BmQ3FkRVFzUllIQmNDd0xV?=
 =?utf-8?B?SWkyNlFKWjluMXN4WG95cjM0Mk1Wa0NwZmJYSldkOXRRV3RjcUxlek96ZHRy?=
 =?utf-8?B?WE1oclcwWEd3bVg2NGhyQWIvRlAvZzVMS3NIWXRQUEV2NGZxUDQ4M3hHUk1H?=
 =?utf-8?B?bzVNeU1tV3Z4ZU14dmE1MENidGhKZjJOVmRJODA1cEN5TnRwWDVDUldCZW1Q?=
 =?utf-8?B?WC9GSy9kT1c4ZjdZdXJwQmNkMGsyMlFLMXJGcTYrQjJxU1Q1RHA0R3BtRzB0?=
 =?utf-8?B?ZHMzUWp5UlBrNisxbTVKb09jR1dkdWN0M0g2T2QwUlFuTUVPelkzUllLUlBR?=
 =?utf-8?B?TkJrdkNJVWNLNTRuRTZpNWwzaVNvbzFjdHRSOXJqWEtiaVRyREpPaStjOUJi?=
 =?utf-8?B?cTEwbTNQSi92TnlxbmlGWGdGWDNpd2I5NEJsMWtKcTY3OFp3eHVoVXFJZE5E?=
 =?utf-8?B?cWh2VHdVYVhpbG5WSnRLZzBaMGdKNmRhejBtOWJEd2M2V1JYaHp0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99dc636-42fb-4839-62d5-08de85c9bba1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 15:11:01.8992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uauYvTTO9vV1b6J+PuuQEvb7ALoT47fcliAA1RlCRmVM/gxs3ZxRTZoIFWAO+X8JXGrPClNe0rGS4UGD6D3YoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863

Hi David Lechner,

On 3/19/2026 8:28 PM, David Lechner wrote:
> On 3/19/26 9:49 AM, Sai Krishna Potthuri wrote:
>> Hi David Lechner,
>>
>> On 3/19/2026 7:53 PM, David Lechner wrote:
>>> On 3/19/26 8:52 AM, Sai Krishna Potthuri wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 2/21/2026 4:08 PM, Krzysztof Kozlowski wrote:
>>>>> On Fri, Feb 20, 2026 at 11:09:41AM +0530, Sai Krishna Potthuri wrote:
>>>>>> Convert the xilinx-xadc.txt Devicetree binding to a YAML schema format
>>>>>> and remove the old text binding.
>>>>>>
>>>>>> +
>>>>>> +  xlnx,channels:
>>>>>> +    $ref: '#/$defs/channels'
>>>>>> +
>>>>>> +allOf:
>>>>>
>>>>> Missing ref since you use unevaluatedProperties...
>>>>>
>>>>>> +  - if:
>>>>>> +      required:
>>>>>> +        - xlnx,external-mux
>>>>>> +      properties:
>>>>>> +        xlnx,external-mux:
>>>>>> +          enum:
>>>>>> +            - single
>>>>>> +            - dual
>>>>>> +    then:
>>>>>> +      required:
>>>>>> +        - xlnx,external-mux-channel
>>>>>> +
>>>>>> +required:
>>>>>> +  - compatible
>>>>>> +  - reg
>>>>>> +
>>>>>> +unevaluatedProperties: false
>>>>>
>>>>> or you meant additionalProperties?
>>>>>
>>>>>> +
>>>>>> +$defs:
>>>>>
>>>>> Why this is a def, not used directly? I see only one usage of this def.
>>>>
>>>> I am getting the below error if i define the patternProperties directly.
>>>> Seems like complex vendor peroperties should be referenced via $ref.
>>>> Please suggest if there is any better way to deal this.
>>>
>>> It is hard to say without seeing the new version of what you wrote.
>>
>> In v1 series, i created $def and referenced this in xlnx,channels to avoid the error that i mentioned.
> 
> Is the code below the code that causes the error?

No, the below code is not creating the error but Krzysztof asked the 
question on this code,
"Why this is a def, not used directly? I see only one usage of this def."

I am saying if i don't use the def and use it directly i am seeing the 
error that i mentioned. So, asking is there any better way to handle 
this case other than using def.

Regards
Sai Krishna

> 
>>
>> v1 code:
>>    xlnx,channels:
>>      $ref: '#/$defs/channels'
>>
>>    $defs:
>>    channels:
> 
> Is this indent bug just from copying to email or does it exist in
> the source that is causing the error?
> 
>>      type: object
>>      description: List of external channels that are connected to the ADC
>>      properties:
>>        '#address-cells':
>>          const: 1
>>        '#size-cells':
>>          const: 0
>>
>>      patternProperties:
>>        "^channel@([0-9]|1[0-6])$":
>>          type: object
>>          properties:
>>            reg:
>>              minimum: 0
>>              maximum: 16
>>              description: |
>>                Pair of pins the channel is connected to:
>>                  0: VP/VN
>>                  1-16: VAUXP[0-15]/VAUXN[0-15]
>>                Note each channel number should only be used at most once.
>>
>>            xlnx,bipolar:
>>              type: boolean
>>              description: If set, the channel is used in bipolar mode
>>
>>          required:
>>            - reg
>>
>>          unevaluatedProperties: false
>>
>>      required:
>>        - '#address-cells'
>>        - '#size-cells'
>>
>>      unevaluatedProperties: false
>>
>>
>> Regards
>> Sai krishna
>>
>>
>>>
>>>
>>>
>>>>
>>>> linux-xlnx/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml: properties:xlnx,channels:type: 'boolean' was expected
>>>>       hint: A vendor boolean property can use "type: boolean"
>>>>       from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>>     LINT    ../Documentation/devicetree/bindings
>>>>     DTEX    Documentation/devicetree/bindings/iio/adc/xilinx-xadc.example.dts
>>>>     DTC [C] Documentation/devicetree/bindings/iio/adc/xilinx-xadc.example.dtb
>>>>
>>>>
>>>> Regards
>>>> Sai Krishna
>>>>
>>>>>
>>>>>> +  channels:
>>>>>> +    type: object
>>>>>> +    description: List of external channels that are connected to the ADC
>>>>>> +    properties:
>>>>>> +      '#address-cells':
>>>>>> +        const: 1
>>>>>> +      '#size-cells':
>>>>>> +        const: 0
>>>>>> +
>>>>>> +    patternProperties:
>>>>>> +      "^channel@([0-9]|1[0-6])$":
>>>>>> +        type: object
>>>>>> +        properties:
>>>>>> +          reg:
>>>>>> +            minimum: 0
>>>>>> +            maximum: 16
>>>>>> +            description: |
>>>>>> +              Pair of pins the channel is connected to:
>>>>>> +                0: VP/VN
>>>>>> +                1-16: VAUXP[0-15]/VAUXN[0-15]
>>>>>> +              Note each channel number should only be used at most once.
>>>>>> +
>>>>>> +          xlnx,bipolar:
>>>>>> +            type: boolean
>>>>>> +            description: If set, the channel is used in bipolar mode
>>>>>> +
>>>>>> +        required:
>>>>>> +          - reg
>>>>>> +
>>>>>> +        unevaluatedProperties: false
>>>>>
>>
> 

