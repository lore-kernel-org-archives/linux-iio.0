Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBBA2D0292;
	Thu, 19 Mar 2026 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935360; cv=fail; b=P9XLFUeLCB2YEipB5WbrxecZYorOKJro2wcO5cDUDa0+C2jMyIbWQJBdmuGqaQfAkXi4Zvkg9M9LBjT0mIm7hvnHwnYIqEjp4HazxEGaoM7HT/8+1Qwe0L8Nowq0GMLNzxp0Jk3UKeVdPOp/rV2DdVg2AUrc8PeK+cRmHaXNNvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935360; c=relaxed/simple;
	bh=UwSdT0LUL+I5ti+VWKig+QJZFlb210jtGyOqZCR/lx4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cd9gTeWAOctXNr52Tko22imDCpnu56KubhOicxeq/RXRP4AaXrOZa6+aZgVfHrjJNy8DqPMaOHBW5cOR/i5ySCp5pBc2PcrtwNs46UuUYHh68p5ExjiPGlp+83ZDOf/06cE/5wxUQI4pKmyV2HoJe31KPMpfjh2hj7MutHzDy6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XkaaKk3Y; arc=fail smtp.client-ip=52.101.85.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XkaaKk3Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/dt/RUMGBjUGiFKcnih8eg09flMVsRAHS26qXi4gchJVnw6+/LmAjNb2XTiE8e431nT4jErgvuPyfTqOpluLfN1gSDvUxntmUIdMmkIMjkAHH2G+2ezw7+cc1XcRUZ6YBwxY46Lrv5tPAgPtM7r/X3L9jtEvnY+Yxp2uez7EVsXnvnrmeWUM53po7W+HdoH+B7CFTOPDrtV5TrjbdLr0sknMXeBrvK4FLiZIG6XqwLh6pqzKHthnbUEdWx5rVZeAUHltF0sLl0yv84MIhloOPi35mnHo9r229EKR7KrElpNEZGAEBJtk+7J3Z8XHOhMsv+pBUsC5Dvh7Hac1ix0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VxYwupRo5GtP0Y7MW89+U95NgLNWmjyvGJ6Hl+jx0A=;
 b=sa7lie9u00lyLzD/FC4qDK7jSsAITEbDZo3w3CMvlav626hWe2Rqvcv0b53IvCSXbdF+iIEbSwCMvhWCWUMIvciAJP9XRXFjTVjFq1jr8ADCXMQKyb0GaBKXO1NOzaOzsj8JwZYU3HeL3LBeXDPqAOuP0IHQYlwE3j2cKMpHn80XMooALS11G70Y1Q3xDG1z2Jl3sNlXs+76yJcd1kch9FjPObbsYqIxVcwYuvv2AIEK/3ynstrS0ohVqBE9vS3KQCXq8jtBOFi7seIKYLPJ/yeP7hbXM2Rw/zPmVWBeYpYv2NhGHYpHqiA7dHVLCOEt04SJhFGI8EVUy6SAWN1ctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VxYwupRo5GtP0Y7MW89+U95NgLNWmjyvGJ6Hl+jx0A=;
 b=XkaaKk3YJ94xGiMkfoPOo3dtVLJmP69H+3GRPFG9IUCUrjRudxn+iz/f2nVc5wFieZUzM9HT3Vgia013zOhoIwVb5S+VSNPQTZ2lEI4Oe/A1xvBwl6PL1btI+5cP6DqoCPUqAcdI7pfX0G60f/2G3l5Z/vCKOa4Uyty4pcCzyok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Thu, 19 Mar 2026 15:49:11 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 15:49:10 +0000
Message-ID: <6a4e3d95-875f-4c2b-8443-c2f2b19ff166@amd.com>
Date: Thu, 19 Mar 2026 21:19:02 +0530
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
 <05bcc5b7-b3e8-40fb-be70-413c74afcfb1@amd.com>
 <cf749e8c-f141-4367-81ad-827e02273ec5@baylibre.com>
Content-Language: en-US
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
In-Reply-To: <cf749e8c-f141-4367-81ad-827e02273ec5@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0062.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::15) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec3375c-a012-4ddd-0747-08de85cf0fe4
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	P0LD76JgZGCyo6PowijQGudQjRLkK0vhfHe1LN+1XvLqGnIuEqM4OFt/ipSrzX/ijW+6Kyf7IA3TbcSzjcp80P8JR3UnSrY5WxhP4vPO6fSxpIWQbFiqKS4XvHnbFKu34n9NOiZJ3tuehzvj9rvy2mUzO3Vaks3noZLy5dfJbXPypN9fwewoZn3+eqzfjGyAk2vNFBqiuxwRDTRZTK/DZg4i2Emk8bbNQ5/BzPqrTv3jAoVmOaMybZnGUoU1X/HBjXaFjYq8c6KOFjeIUDjq0LKYjOor/+brJjPghVv5+u5Q4zlamRQy7Xadj4Dp/OfnFC5TGoRYTo5nQa+hVhUVXWjLY1IyLyZQMTtWQNFrmnlmQkaGOhAs/OOM6nTP+y4KBgoaf2JilIali3FXVhVjToyca8GK6CFHssckybh7H/uBzw4Vq4l28kpVT00+ZUuYOSdEBf0o9Me7BnMdtExkx8lQaXyzQWFC0fK4rLsTlmAF3hFekrTq6L+CyS3qXDb1zhX6PWuGPYrpgsS6KXdOe8Z7G9np1aWKzpbkCfEDyiIe1l5zarxn1x0d+mQQupDqa7zl2fLO6lXVxI7noxuwwUW0/m6xRrjJQVhGsvIMvL0VHu2CB/ZDRJfm94osVuPMZP7gXWgkVKwL/fbLwEBu+u+upz++t2S1rBEPR2kgPdtRcud5eYiE757Zq4V7oWvk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVZGeTM2MmFBdENRVWtQMEFhOWdkSmdCOEtlZ0ExdjFGZ3M2ZUhMS2luRUxh?=
 =?utf-8?B?KzBXOUJiaGU0MURLZjZqb09lN0JtT1BqQkQrMDU5akhyYndZR01nMTBXRFpv?=
 =?utf-8?B?WWQ4aG5GL3JBeU5pOGRqS1F5NDNyUnlUUTJRRzNTUGFtWDFKenlCWktKOWZy?=
 =?utf-8?B?UnQ0amdDWlRHTEM3QkUvYmVQQk9BNzVFREZOaGNMZFg5ZDJBT3lyNmdoMDVV?=
 =?utf-8?B?bFl3S05rWWFKN1NLUnlINnZmcTl1ck9HUTdKTy9PY083eHVNSGozVC9zY0Vt?=
 =?utf-8?B?OTFTNjh3OHNlM3hxK3NkcFNNTW45YnNveE1pTldyYkZkMHhvajRVQkpEYkNm?=
 =?utf-8?B?d3phUnliUUdnSjhwSG5VUzR2Q2JURU9IZHpMOE5Ea20yNGdtZVYxYVRCYmU0?=
 =?utf-8?B?WHlLR1Y0c1MzdC9XS0RuWDRtaE1wZDVUWXdSdkVqTE9hS2gwK2NCcUtoOFRB?=
 =?utf-8?B?MzAyTzJCamdyRjJUZzhMVjNMSWhYWFZkUUlsQ3FMcWVvQVd4QmRnQzhwai9M?=
 =?utf-8?B?cWU2a3pMczhlb1MwNUl6aXhDNVBWbm0vT2hVODRLQU9ZbHJiL215N0x3cWkr?=
 =?utf-8?B?SitFenkyeFlEYlR0VXk1dzRxT3RsbXVPd01ZcjYrNUR2RjZpc1JHMzZxVmZT?=
 =?utf-8?B?VTNDeUEwa2ZSZmt1cFVNbmtWRlozSTdHcXAxSzNneHdUVmY1NVhPRDNaT0t2?=
 =?utf-8?B?TUEwUFVWdHR6VkJ0SjY1ZGZiek9aK2VENGNKa1BEMEFCbzYvTkUxak9HVDYz?=
 =?utf-8?B?Vk9DeTlWNjJhZFNlRzFNbFJjVTMzMFY3eEFIVHRNeDlCS0NVZkowalpmdXJk?=
 =?utf-8?B?OTlyQ1FUNzFKV1k0U3dWZ0grNlpMVGlDcFJpTm4yQ0x4ZWlLNWdFUjIvYjZj?=
 =?utf-8?B?K0tLQzlvSTdtTndiV1pTSE8vc29JMGpGUms1d2NaZDJSZjJGSWlGbGhVKzZt?=
 =?utf-8?B?ZW5ITGg2T0czWlFMdTk2aWVHL212NkxWSTY4SDNpT25jMDl1YllQZEd0K0hN?=
 =?utf-8?B?T1k0aEdZcndOZ1RTT0t0RFVpMU1qWW1WeVJsS3ExdE05UFpFMXFYMmgra05k?=
 =?utf-8?B?QkRiZkxkd3RObERjOXZWUEhXNjc2cnVzUk82M3E0S0pycmkzb2tHeDJGME9G?=
 =?utf-8?B?NXdpY1NuaFJ0bzJZTTVpV0kxL0duai9TaHFwTDBiMlpSUkwzN2VRL0VkdCsr?=
 =?utf-8?B?UEZEVnozbXJhZGZrNXd1aDVuYXd6Z2xsTFdSbkxEUFh0bnUxT2xNQ1IxYWRE?=
 =?utf-8?B?d3lCL0ZIa0tpc0ZLTFplZ1hXUDN0VHNxWUo1Q2l2eW43MzZZQy9NNThuQi9E?=
 =?utf-8?B?eEpPV2tpc3BQbmkyVjR0MXgza3M5cWFFUmI0dWlCV0hmRkdRaTlwR04zaFJQ?=
 =?utf-8?B?S1ZkWm0vdDJGTWF0Tjhselg2V0IrUUd3MjZLbjNpWE41WmViZ3FsTmlkcHN3?=
 =?utf-8?B?TmI1SThlZUw1RTVsd0I5aExlMURRdlhPdnhLK1ZYaGthTjJWVTB5b3lrMTFw?=
 =?utf-8?B?blZxZGZHaXFidnVabjNzRDhFcDc5c2t1Wk9GVi95T1pQeG9Pb0x1NWlDa1RR?=
 =?utf-8?B?MWhXQWswY1pkSlkySVJEdTc3Q0twcXZpVEJtMElHZ1k1dEFWb1k1Z2NhVzhi?=
 =?utf-8?B?bkZNQjBZcTlVTE5BRUxMUUtGQ3NBU0FqK0RPaUt4VkxvNno0TEFmQ3M1bDlp?=
 =?utf-8?B?WVJ2VmxaZkhTdStQbTk3ei80bTRCcVNtY2dKVHhoTUFVVVoreVdFYVltUnFy?=
 =?utf-8?B?Yjhxc0RwV0c0NWxPL0pvTGZ3bXlLQ1lYQUVnYWsrVXZDdXJhS2NHVldFR0hM?=
 =?utf-8?B?MmliY045eWE2emR5MzFZM2JUWkhiRWJSWFlnWW5UckhMMGh1RnRkNW1xQWpN?=
 =?utf-8?B?ZVUwRVRJQXJGdDg3QTJFVmdyWDR1Rm1DMnc4R3YxUXl4UnppNllNOCtPa1Uv?=
 =?utf-8?B?TWNaRHZMTlB0S1FmcUxXQXNOS2tkWlNkUDFJc1hSVVFMcnVLZmtiV20rN0sr?=
 =?utf-8?B?amUwZTM5NFVCL3U3dG1nVGl0ZmlGNGlBL1BZdWp6LzF5bHlxa0dHZmo2dWdN?=
 =?utf-8?B?b2pnTkNDS0RjcSttaTZDMk9jT1RaLzluZmdDY3JsSG9ScEZaTTdpSmUycllS?=
 =?utf-8?B?Q05HcWhxbGlkcUV6cUJlc0N1MElieU9aOW5kc1o1dW9iWHVGdURvVVV6NUpR?=
 =?utf-8?B?NmVjVFRDenBaL1crSmN0eVdkdDdPWG84ZHZaaE5TdjRSbE1RNlJxRHJROEtt?=
 =?utf-8?B?OUw5RGcxRlluYU5NVEJUcnMzODArVWttU2ZqcFFsbHpCa3V3T0hoZnNzeWlp?=
 =?utf-8?B?YW8rYW51RkdSa3V5c2p3VDNrTzJnbmRyZ2wwYlMyd3dCWGRtOEZmdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec3375c-a012-4ddd-0747-08de85cf0fe4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 15:49:10.7686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTd3OY8Y7t27cKWJq6lQXYSZUecVdu1ekKxgQY8BX79OH2rmuRh6rJUBdwXi+sGFwg/bHHhk6Vulx381MuZ6SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022

Hi David Lechner,

On 3/19/2026 9:05 PM, David Lechner wrote:
> On 3/19/26 10:10 AM, Sai Krishna Potthuri wrote:
>> Hi David Lechner,
>>
>> On 3/19/2026 8:28 PM, David Lechner wrote:
>>> On 3/19/26 9:49 AM, Sai Krishna Potthuri wrote:
>>>> Hi David Lechner,
>>>>
>>>> On 3/19/2026 7:53 PM, David Lechner wrote:
>>>>> On 3/19/26 8:52 AM, Sai Krishna Potthuri wrote:
>>>>>> Hi Krzysztof,
>>>>>>
>>>>>> On 2/21/2026 4:08 PM, Krzysztof Kozlowski wrote:
>>>>>>> On Fri, Feb 20, 2026 at 11:09:41AM +0530, Sai Krishna Potthuri wrote:
>>>>>>>> Convert the xilinx-xadc.txt Devicetree binding to a YAML schema format
>>>>>>>> and remove the old text binding.
>>>>>>>>
>>>>>>>> +
>>>>>>>> +  xlnx,channels:
>>>>>>>> +    $ref: '#/$defs/channels'
>>>>>>>> +
>>>>>>>> +allOf:
>>>>>>>
>>>>>>> Missing ref since you use unevaluatedProperties...
>>>>>>>
>>>>>>>> +  - if:
>>>>>>>> +      required:
>>>>>>>> +        - xlnx,external-mux
>>>>>>>> +      properties:
>>>>>>>> +        xlnx,external-mux:
>>>>>>>> +          enum:
>>>>>>>> +            - single
>>>>>>>> +            - dual
>>>>>>>> +    then:
>>>>>>>> +      required:
>>>>>>>> +        - xlnx,external-mux-channel
>>>>>>>> +
>>>>>>>> +required:
>>>>>>>> +  - compatible
>>>>>>>> +  - reg
>>>>>>>> +
>>>>>>>> +unevaluatedProperties: false
>>>>>>>
>>>>>>> or you meant additionalProperties?
>>>>>>>
>>>>>>>> +
>>>>>>>> +$defs:
>>>>>>>
>>>>>>> Why this is a def, not used directly? I see only one usage of this def.
>>>>>>
>>>>>> I am getting the below error if i define the patternProperties directly.
>>>>>> Seems like complex vendor peroperties should be referenced via $ref.
>>>>>> Please suggest if there is any better way to deal this.
>>>>>
>>>>> It is hard to say without seeing the new version of what you wrote.
>>>>
>>>> In v1 series, i created $def and referenced this in xlnx,channels to avoid the error that i mentioned.
>>>
>>> Is the code below the code that causes the error?
>>
>> No, the below code is not creating the error but Krzysztof asked the question on this code,
>> "Why this is a def, not used directly? I see only one usage of this def."
>>
>> I am saying if i don't use the def and use it directly i am seeing the error that i mentioned. So, asking is there any better way to handle this case other than using def.
> 
> If you could show us the actual code that is causing the error, then
> we could perhaps spot a mistake or suggest an alternative.

Thanks. Here is the code that is causing the error
("properties:xlnx,channels:type: 'boolean' was expected").

xlnx,channels:
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

         additionalProperties: false

     required:
       - '#address-cells'
       - '#size-cells'

     additionalProperties: false


Regards
Sai Krishna

> 
>>
>> Regards
>> Sai Krishna
>>
>>>
>>>>
>>>> v1 code:
>>>>     xlnx,channels:
>>>>       $ref: '#/$defs/channels'
>>>>
>>>>     $defs:
>>>>     channels:
>>>
>>> Is this indent bug just from copying to email or does it exist in
>>> the source that is causing the error?
>>>
>>>>       type: object
>>>>       description: List of external channels that are connected to the ADC
>>>>       properties:
>>>>         '#address-cells':
>>>>           const: 1
>>>>         '#size-cells':
>>>>           const: 0
>>>>
>>>>       patternProperties:
>>>>         "^channel@([0-9]|1[0-6])$":
>>>>           type: object
>>>>           properties:
>>>>             reg:
>>>>               minimum: 0
>>>>               maximum: 16
>>>>               description: |
>>>>                 Pair of pins the channel is connected to:
>>>>                   0: VP/VN
>>>>                   1-16: VAUXP[0-15]/VAUXN[0-15]
>>>>                 Note each channel number should only be used at most once.
>>>>
>>>>             xlnx,bipolar:
>>>>               type: boolean
>>>>               description: If set, the channel is used in bipolar mode
>>>>
>>>>           required:
>>>>             - reg
>>>>
>>>>           unevaluatedProperties: false
>>>>
>>>>       required:
>>>>         - '#address-cells'
>>>>         - '#size-cells'
>>>>
>>>>       unevaluatedProperties: false
>>>>
>>>>
>>>> Regards
>>>> Sai krishna
>>>>
>>>>
>>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> linux-xlnx/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml: properties:xlnx,channels:type: 'boolean' was expected
>>>>>>        hint: A vendor boolean property can use "type: boolean"
>>>>>>        from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>>>>      LINT    ../Documentation/devicetree/bindings
>>>>>>      DTEX    Documentation/devicetree/bindings/iio/adc/xilinx-xadc.example.dts
>>>>>>      DTC [C] Documentation/devicetree/bindings/iio/adc/xilinx-xadc.example.dtb
>>>>>>
>>>>>>
>>>>>> Regards
>>>>>> Sai Krishna
>>>>>>
>>>>>>>
>>>>>>>> +  channels:
>>>>>>>> +    type: object
>>>>>>>> +    description: List of external channels that are connected to the ADC
>>>>>>>> +    properties:
>>>>>>>> +      '#address-cells':
>>>>>>>> +        const: 1
>>>>>>>> +      '#size-cells':
>>>>>>>> +        const: 0
>>>>>>>> +
>>>>>>>> +    patternProperties:
>>>>>>>> +      "^channel@([0-9]|1[0-6])$":
>>>>>>>> +        type: object
>>>>>>>> +        properties:
>>>>>>>> +          reg:
>>>>>>>> +            minimum: 0
>>>>>>>> +            maximum: 16
>>>>>>>> +            description: |
>>>>>>>> +              Pair of pins the channel is connected to:
>>>>>>>> +                0: VP/VN
>>>>>>>> +                1-16: VAUXP[0-15]/VAUXN[0-15]
>>>>>>>> +              Note each channel number should only be used at most once.
>>>>>>>> +
>>>>>>>> +          xlnx,bipolar:
>>>>>>>> +            type: boolean
>>>>>>>> +            description: If set, the channel is used in bipolar mode
>>>>>>>> +
>>>>>>>> +        required:
>>>>>>>> +          - reg
>>>>>>>> +
>>>>>>>> +        unevaluatedProperties: false
>>>>>>>
>>>>
>>>
>>
> 

