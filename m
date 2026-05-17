Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFAA30BBB9;
	Sun, 17 May 2026 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779059506; cv=fail; b=ARKYlnzUoaoU0zm79Qm3BsaVOfBWUVAnhGHAfG9tUqGtQXutgn35awgAkJOnVPYw3bcRay9rNaQHsmyiNEPAZuRWVlx8jHbxxlOx7gxVvR2f0G/RnC7dfgxq/QW4WDVomxy35CQ19Or9mlBDh/jPBpMvVt/oMY3Jey5Iwj7Fm7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779059506; c=relaxed/simple;
	bh=AdPEOjFMbrdflJwyU43XqKsISu/K68WR8KCyA24W/WA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F5RWNc6BlmChOirsu34NkhJQP9cZpwSJ/zudCJkSxWjHJ1hm/l+F8N/t77FUjLtVkUJcqcMlWep2XfViP0rTmvvNKUEsDlLHf6dXXBG9Wttuf/s9NNwaPyf4u7aXclx9itNHZdubbdbGpJSkJIOGEbQhC2c3Lkco76oWYQZodIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BWQVV/K1; arc=fail smtp.client-ip=52.101.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BWQVV/K1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqJpnrP8eKI+7yH8UzftfZMjXpjF6rvqSV/zQjemg4P0chx1mECxeXhzOUFIXUuqz/tRtWU4pNFkowI/eCShCNytuBT8fl1dlMEYIaOoInJPQteRiZHYV/TJcGfMWYPMAmTKebD5DiSMhY6pl2D0dpkHpFLHY+wfGPjABQ8+u6VSHCuCDaFsv/5QOVIlAxwmxfnLLvDSm6L3Hx95cydvs84QwqkiL+mABPfA61s9neA/7j6fFdGL/xyy54AkhHGylhrEOY1TIpU5lTC9SqvBSAuhe0GEOWwlueDkODQJZ9qgpisw3oGWYqKhf5PSpBFqqTQZFMVlym1WQ38s3FQtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YywG79X2TlhjtMjD8hSXFINiqVyHskoi99S1AcJ92qg=;
 b=fBoGaplj5w8X8NWiBiJp5vPgUVH2rXUfgdV2khG19Qh9FtcUvgojKQtEm70QgPRwkSlDrUmDr1XhH3fMLkYWer3JvYQZZ0yl+3noekDblmGTQRKOyPv0AUj8sVkIHdjgQ5VR7U1bbbCu4AgPPfX4A63oRqXT3nN5++kXzU7jX3feI2+EKzor6owE/4PEafHh4i1Dt8g3fXnpI6xNFmzl0ZZYDYp++Unx5Q1R9c3YmRG+xVFE6q6GuUN4JWEpjZf//sccmNnEl4SG2ldm048Zbs352cCSXlQuUhJ2HlYsRDWwkFlwNwRUrqXIHz5RpTY1OnvjP2L/TW7xuPAXHEiytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YywG79X2TlhjtMjD8hSXFINiqVyHskoi99S1AcJ92qg=;
 b=BWQVV/K1xA/SiQoUO+CsUVKdc0dj6eYniQfDru2kiUozzJovSLwyLJnBOxExSdRMg13uqebRvT1sA1T6gDVzkeAeJRXWsHmWIXHnWX2nIGgNS8QxJsTWrYiGuCa0/6cfDAZuNwUlzQftV4+OuzLFo2O8Sxd4tLuVxrWGudKQJLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Sun, 17 May
 2026 23:11:40 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0025.016; Sun, 17 May 2026
 23:11:40 +0000
Message-ID: <0c51ed6b-1abb-45c7-ad5c-65605076dff3@amd.com>
Date: Mon, 18 May 2026 00:11:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iio: adc: add Versal SysMon driver
To: Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, git@amd.com,
 nuno.sa@analog.com, andy@kernel.org, dlechner@baylibre.com,
 michal.simek@amd.com, conall.ogriofa@amd.com, erimsalih@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20260502111951.538488-1-salih.erim@amd.com>
 <20260502111951.538488-3-salih.erim@amd.com>
 <20260504183215.37c8ae65@jic23-huawei>
 <66268e35-4897-4c40-b358-1c973b70426b@roeck-us.net>
 <ec5634b3-2f17-42b6-8bfb-124ac0c7cde8@amd.com>
 <20260516112057.381dc19c@jic23-huawei>
 <d5fe3740-bd49-4835-acf1-b8cc56543318@roeck-us.net>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <d5fe3740-bd49-4835-acf1-b8cc56543318@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::16) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af09f80-b34a-464d-87e7-08deb469a6ff
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|4143699003|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QiOcIfSPtDjWsPNHj4vXb2C//XKn33vpc6LbduEBv7pGo0RV4W+z9U1mnX5L71eQJ5juUX0yn3xeu+M+J39ye+hS1y4dG2mn5nIarNOZWszvMEZM1M4i5VNLBKr7HaTznTTQhxGFXFVqp8Ns16w7fvIbIL4sKARdPpZJwdtRbuOKTAZbmPNPuhzanTErrrXlMYeMv2uQsPm3U2H4z2wqVweV1fVBnWP5wGWUznDuNYxKEBsqVkwv2d8JfqacIaMMz3pmR4L8mMCDpjy+B3x7E1aoHbFgVW3z70JLIZthuUbdynNtLxa5wC7bdjbQUrmgp9yWPwr5Q5ewPXQc5kaUZtlLh5udhm72Wo7cMOMczEmdYwYKGhZE+bZIBEndg8pDKBiUOba27g+iDd+dHkJmqB4RkWMHQzgYfrdMxUz1RRJDDTt0dn/nwQEOc9stkbVzp5B4yislxjZKyIUhkCfTso2+Mdl91VxvZshFdkrtzrGpt7+aQsJfaYUkzXccLf+96R6O8/YExkCM5pNrSHIDg6vh3XgADlNYzWlSj4+9/PTOxBKhKAhnT/hUdVlZZ8awhcIOjF7YfbOUOtDtPC2fRjxILhcJ75/AWsCKpXZURJWQZMV2giaiX8rGwQ9LUGPgTA+dB06TE1rjS4zRmO/tANvMF38m9juCWJLXa1cvLKN57q4alQcM6vUSvYvrduom
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(4143699003)(11063799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eURQRDVUcmNHQmhJQ3c5Q1R2alpETXkwdDdOdC9mNUo4QkdEUzhZdllCc1lC?=
 =?utf-8?B?S0MrMUMrOFBsQWx4ZmEvMHYycDRCWk1yREI0R3l1NjZaeHdUTXRXbnBPYThF?=
 =?utf-8?B?ejBkQ1pJS2VVdVYxZVhaU1V2UXVTRzB6SDJ4amhLZXp6eHZUcFRpdVFvM0pn?=
 =?utf-8?B?ZGlHRTZuUStxN01LazUxQVNNMDAzN3FER1M2dmlsR2pMcU9KVkV2ZjlOQUJB?=
 =?utf-8?B?WHEzampaem1mNXpxbVFmYktEdHlQWFdqVlp5dFF4TzNVWW9KYlJpRkdKRjJt?=
 =?utf-8?B?QlkwZEFabnlOL05YckJMUmNjV3NER3M2VXpCa014YzE1STJiRTVHM2pZV3FJ?=
 =?utf-8?B?RHdQNEtSaTlUcHNIc09Bb1lmNCswMHFydjByTjIzNHJQeDdZbkN4dnFVYTlM?=
 =?utf-8?B?dVhESit5VXdrQXVMVDg4U3M0ek43Z042S3EzYWtBcmtzZmNkRjN3ODM2b2Vk?=
 =?utf-8?B?N1FvQ2lTS0Z4T01VRXlwa1dlOFVxN2tvZzdxbmEvam5JSDgycERUSmh4RTQv?=
 =?utf-8?B?ay9td2E2N09SMVdYTmtucFI1ZThvYWtabm1qbGFMcXNoMzEzWDdQSXAwT1BU?=
 =?utf-8?B?TzVPMzJIdkJ5NlQ0OFlWaEFTcGJXN2pqTWdxd0gzdjMyaHczdHMrZ2h2QVlY?=
 =?utf-8?B?UDRhOTg4dldMSi9TSysyMDlVRDU0YUtBYmNBdzZzUjhzQVhpRnAxYjdzN1Z3?=
 =?utf-8?B?eUs4dTNzbGh0cERIRkJZcUNHeW10djFhRjkvb01vbGxPOU5YSXJTZkpidlpY?=
 =?utf-8?B?bmJaSjZqaXhlcG90NjB0djR6U2RFcXZGRXJzMzlOM0tpdi9pS2RTOWdISFRh?=
 =?utf-8?B?NVRiRUJha3NDS2Q2RVNvcCtSenVqU2xSYlJEVWJGekpSc0tqT3JMTUxqRmVh?=
 =?utf-8?B?UVNnd2FSc1VXU3FoLy9pZERsNG1JdTFVaXgyWVpCVlFrajlvT2dTYnhic1Z2?=
 =?utf-8?B?M0NSTnFXYzZGS3V2UnV0OU1TMlM0b2dZVHRvcWU4MzBDazB0Z0lqR25RYWJn?=
 =?utf-8?B?Q0w5YzczUVVBUDFYbFdGSzJpbkNRSVRlbzRsVE51V1RoWm1veHFYQW03ZDRi?=
 =?utf-8?B?RFJUMlVFbCtaZml0ekFtOFFhSmxkSUkyN1FkN1pIbkdrNWl3am0zL0VncjFl?=
 =?utf-8?B?RFYrSERIa0Z4dXJUZmdIMmhLTEtaY09TRVJKeXM3L1J1S3BDcURXdVpTbFY0?=
 =?utf-8?B?RitqRmVYWXM2SGZOMERINEF6TTJGVCtKdUxNbWFDa0tFZjh2Z0pGVDNZSTUr?=
 =?utf-8?B?dW9RQWtrSlczOVVXMTJjc2RUVWdlU1lxL2E3NkNmUXBSMktTdC9GVFlOWTl6?=
 =?utf-8?B?alV1eW1aUkp2ZGcwdTdSbCt5dzRqR3gxUjY2NmN3eHZFdmt5ZWZtMWhMS0ta?=
 =?utf-8?B?Z3lRMk1UOERpdGowamYrTlNzbDBONGRLMzZzM3pMMDdyOElWaW5UUkNDWGZR?=
 =?utf-8?B?YU5yMkx3Y3QzZzJIRU1oOUYycFhLZzRZTWJrbm9aMlRqSFhZNSttM0k2V1FN?=
 =?utf-8?B?V3NPWTdjaE8xeHN1eFRwcVVNTnVoaHRreTJDWS9EN0hvZkJ4OG1ZOXpiYlNq?=
 =?utf-8?B?OEVpT2J5ODd0WUV3YkpoTWxvWVNyd3pvTENzZThLM1F2Y1grNFh0YktwK3g3?=
 =?utf-8?B?QUxtUm9EWjhXV2x3d210WnlXUDVXcjdEa3FXbDFxU1d6b3ZRcnVhTVNnZGZw?=
 =?utf-8?B?Z1BMZ0xRMHZLNTZLSTFrMFkvc3luUnkwTUlrZ3hwZ1pQaXlZODVoVHY5Nkl3?=
 =?utf-8?B?VEJlbC9SWWpZdkdlSnl0ZFBPd2ZHbHVEM3VZY3NnZk9kWHBRRGdpZHZKUXd5?=
 =?utf-8?B?TUdzNllnNkxTMTNPS0NVcGtFNmdqR0s1aXlVaTdVQXVHWWFydTFzTFl0cmxq?=
 =?utf-8?B?bmlXdVdtK0pDRyt2Qi91cVlrOWZTMkFDbUJtTFNsaXpnY2V3WHRIR2ZtTmRR?=
 =?utf-8?B?Ui96d3BVRHhCcmNCTjVjRTU2VFdQdm02NjlCNC9oUnc0UWc1OS92VE82MVE2?=
 =?utf-8?B?RGlGeG42bkhubmNSalJVNkttdmdPOW5lQzZGN1BpeUlWQVFOZkhDNjRMVVVF?=
 =?utf-8?B?S3k1aGN0YW5WR2ZpalI3ZE0xQURmNnI2L2xmWldxNUUvQno1ZUhzNU0yS2w4?=
 =?utf-8?B?bGhkcWZ2eENnakt3elVLUXI0MWdHQ3VocUw1RDFpTDRlQzhyTzJsaU8zMS9L?=
 =?utf-8?B?RnJJalF0T2hDM1owbHZhdHdwYXk1aktuVis1V2JTWUozYkFBRGNCd1RRYnFn?=
 =?utf-8?B?NG5KckxNYjVhNUV2MjZvQlZuOGtiZXNUbmE4YnNqdVlwdzU5QmcxeVF5S0pa?=
 =?utf-8?Q?bZ3aLGBAbntRtvYJ76?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af09f80-b34a-464d-87e7-08deb469a6ff
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 23:11:40.0895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCaxHQtY7QjjQXJYyVxLO5emoZ5bgNOVpmq5jN79WUl2I9/4utq2LfuF3jrKaptF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739

Hi Guenter,

On 16/05/2026 16:04, Guenter Roeck wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
> 
> 
> On 5/16/26 03:20, Jonathan Cameron wrote:
>> On Tue, 12 May 2026 12:35:21 +0100
>> Salih Erim <salih.erim@amd.com> wrote:
>>
>>> Hi Guenter and Jonathan,
>>>
>>> On 5/4/2026 8:26 PM, Guenter Roeck wrote:
>>>>
>>>>
>>>> On 5/4/26 10:32, Jonathan Cameron wrote:
>>>>> On Sat, 2 May 2026 12:19:48 +0100
>>>>> Salih Erim <salih.erim@amd.com> wrote:
>>>>>
>>>>>> Add the AMD/Xilinx Versal System Monitor (SysMon) IIO driver.
>>>>>>
>>>>>> The driver is split into a bus-agnostic core module
>>>>>> (versal-sysmon-core) and a memory-mapped I/O platform driver
>>>>>> (versal-sysmon). The core uses the regmap API so that different
>>>>>> bus implementations can share the same IIO logic.
>>>>>>
>>>>>> The core provides:
>>>>>>     - Static temperature channels (current max/min, peak max/min)
>>>>>>     - Supply voltage channels parsed from DT container nodes
>>>>>>     - Temperature satellite channels parsed from DT container nodes
>>>>>>     - read_raw for IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_PROCESSED
>>>>>>     - read_label using the DT label property
>>>>>
>>>>> Various comments inline.  One thing to check.
>>>>> Is this one strictly a hardware monitoring device? Or does it
>>>>> get used for more general ADC purposes?  Did you consider an HWMON 
>>>>> driver
>>>>> for it? The above sounds a lot like hwmon. So why IIO for this one?
>>>>>
>>>>> I wasn't awake enough on v1 to raise this!  Sorry about that.
>>>>> +CC Guenter and linux-hwmon for that discussion.
>>>>>
>>>>
>>>> This very much sounds like a hardware monitoring device to me.
>>>
>>> The device is indeed used for hardware monitoring, but the hardware
>>> characteristics push it towards IIO:
>>>
>>> - The predecessor (Zynq UltraScale+ AMS, xilinx-ams.c) is already
>>>     in drivers/iio/adc/ upstream. This driver is the direct successor
>>>     for the Versal generation.
>>
>> Was a long time back but at the time I think it was argued that some
>> usecases for that device were general purpose external ADC channels
>> rather than just hardware monitoring. Is that true for the new IP?
>> (might not have been true for the old one!)
>>
>>>
>>> - The supply voltage encoding is a modified floating-point format
>>>     with per-register exponent and format bits. This non-linear
>>>     encoding doesn't map well to hwmon's linear in*_input model.
>>
>> Given IIO doesn't really do floating point either I assume that is
>> getting converted to something fixed point which ever subsystem
>> is used.
>>
>>>
>>> - The device has configurable threshold events with per-channel
>>>     alarm registers, hysteresis bits, and level-sensitive interrupt
>>>     masking/unmasking -- which maps directly to the IIO event
>>>     infrastructure.
>>
>> What in that list doesn't map to hwmon events?
>>
>>>
>>> - Oversampling is hardware-configurable per channel type with
>>>     per-channel averaging enable registers.
>>
>> I think this is not present in hwmon (could be wrong!) but is there
>> a 'right' configuration for a typical usecase?  I.e. would sensible
>> defaults work?
>>
> 
> There is a per sensor type "samples" attribute. I don't recall a request
> or even a chip supporting per-channel oversampling, though such an 
> attribute
> could easily be added if there is a use case.

Good to know, thanks.

> 
>>>
>>> - Up to 160 voltage and 64 temperature channels are dynamically
>>>     configured from DT, which fits IIO's dynamic channel model
>>>     better than hwmon's compile-time attribute groups.
>>
>> This used to be true, but hwmon has for some years supported a similar
>> model for channel creation to that of IIO + you even for traditional
>> attributes it is easy enough to create them dynamically (that's afterall
>> what the IIO core does under the hood!)
>>
>> Anyhow, take a look at struct hwmon_chip_info and the 
>> HWMON_CHANNEL_INFO()
>> macro.  I couldn't immediately spot a dynamic user but maybe Guenter can
>> point to one.
>>
> 
> There are several hardware monitoring drivers with dynamic sensor 
> allocation.

Acknowledged, dynamic channels are not differentiator.

> 
>>>
>>> - The follow-up thermal driver uses the IIO consumer API
>>>     (iio_channel_read) to aggregate temperature data across
>>>     multiple satellites into thermal zones. The iio-hwmon bridge
>>>     then exposes the same data to hwmon userspace.
>>
>> This might be a good reason for IIO. However what stops you just 
>> embedding
>> all that in a single hwmon driver that also registers the thermal zones?
>>
> The hardware monitoring subsystem supports registering thermal sensors as
> thermal zones. It would be up to the thermal subsystem to aggregate them.

Understood.

To add some context from Jonathan's question about general-purpose
ADC use: the Versal SysMon has 17 external analog channels (1 dedicated 
VP/VN differential pair + 16 auxiliary inputs on MIO/HDIO pins) that 
support unipolar and bipolar modes for measuring arbitrary external 
voltages, in addition to the internal supply and temperature monitoring.

Thanks,
Salih.

> 
> Guenter
> 
>>>
>>> So the architecture is: IIO driver (provider) -> iio-hwmon bridge
>>> (hwmon exposure) + IIO consumer (thermal zones). This gives both
>>> hwmon and thermal framework access through a single IIO provider.
>>
>> So overall there are some possible reasons in here for using IIO but
>> I think a little more in depth analysis is needed.
>>
>> Thanks,
>>
>> Jonathan
>>
>>>>
>>>> Guenter
>>>>
>>>
>>> Salih.
>>>
>>
> 

