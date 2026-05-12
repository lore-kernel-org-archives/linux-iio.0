Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF531395AC6;
	Tue, 12 May 2026 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585732; cv=fail; b=CTkWhzTElUc4p2wsM0GI/yMcNAa/txdCE8YPbX90KGNFYuqDEu3gULFwxlxRcvSky+6VX/y0w1NkEGPkFQ6f51hM+PyTnIrZXUhu/ST5Zd/tpuaPJjY76lY3bTDG+r9Cu16AmJLmW0BEx8uvVLEyPBXUJTGL2R3L8/m3pTh8ufk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585732; c=relaxed/simple;
	bh=TknMzeREQ/l8HJL8wJDwbMIhRzF8jX0s0BFD4lk8wWg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i2lyoXOtsn94YsqPwfxf0LABc79V0EDcbdHJfnnOpavix5URaRyzCD1gkrakp2W8ikrvO9rIjubZdyYEhh8tyujnTbp6C5xvhtB3lohHYg9NbL2V2ZoqV6+AUbqyG8m1a2QWnK60uRn4HvcjDdiC9933tGgvR0aKWv07KIhV/8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pt7Bl1QB; arc=fail smtp.client-ip=52.101.61.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pt7Bl1QB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h96MYrhGKYI7M+C1gr5rVmbhgFlaM0O4EL0UKXoSq9n8fmjEVmW2Nck1FfPCuwe/265LdMlFScxeHBKs1YRzjI21lWmLJ4h83K5AWD2U8ps763kz1wyIkiXiEmy7WpCmO/nYWXj/Wl216iMto/LmQzTdY74T8UVaXZF5ljTIh2Vm3e2UOnENkhLewrLBN3A98q11de6YaGqrsBRa9xe06N63fy7SKMcu6j2MvQfmbIjapyVgeJVK6BkLA88VuqZmpNjRxVDT+WFivoPiPCxc9DWhdukUu41PUiLA/kbREc0xDtbNlu7GUWORs3Rbjff4IbhfMfgnZKqyhq8ZZkc5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rE8sZaYo/iYhAsvs5Qna6D6hYEc0XCHal9Cr/dbNV2U=;
 b=FWi3hVxxL+sVxKTSAxs9bnycdvs+kfrLkzBCQZ6VvVtLjoRndpeLVK8YMLlxJS5B+Q4WpY6bfZlHfXpUqy4MQ7JhSNmjaS8xm+QTUvdAjWGT9CL6dWWrsgYiBJ9vOnZAm/90INPrtWWngfxWPqkb/DvFqmq8ZTf3L0vqbMlm63ySh0n5BDGRKbMJjdTUnRQSN/8mHq2n77XnX/R50hyhJnCJoLXfun0Qzv2OBrF9TKwaE+NPcyMXosmoVcCgEGRgliEHJh/SJS1gxz9Jkvv/IAiAz/C97AmtzNveEqS+BDa97yCIOoSz9iyhfUMFPBgnFTG7Np632XgZzWK13pnzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rE8sZaYo/iYhAsvs5Qna6D6hYEc0XCHal9Cr/dbNV2U=;
 b=Pt7Bl1QBt2+5Knh5QHG+ldz6mM8Ugu71USlbCNtbGIIx8OUdpeu9/nWQASBnj1WpDouxZTb80Jzqo1Y3Fmt5YuvOX7cVPYmOG01UaMANxJoRA5rituuHHOiXLmXlyl/p+5Vsucx6aKBBmCQMt+cVE67W7rCDerF1sZlabxEVqNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 11:35:26 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 11:35:26 +0000
Message-ID: <ec5634b3-2f17-42b6-8bfb-124ac0c7cde8@amd.com>
Date: Tue, 12 May 2026 12:35:21 +0100
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
Content-Language: en-US
From: Salih Erim <salih.erim@amd.com>
In-Reply-To: <66268e35-4897-4c40-b358-1c973b70426b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0091.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::6) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: e96ccca3-6971-45c0-2329-08deb01a8f7f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	lIpkOvQMoJApmuo37bexl6VPKptgdjNGE6g53Io/O7h9nhG6Y6Ijjd91IDRBSA6fvmt9cgIF4hpLJtZjk5H653GXStZAeKBjmzcYWe3Zq7hFOXdsvoAr/ol6bvSwy2SBnP1CCtwF2zxasNyEOmUy4F8M1oWGxJ5Xaw83JPxt3bjK90DrDW/IuaEkJ/6mBBlhZwDg4BKsLtMLFJTlUr4fuA9aCId9DwbclnovVt+pMpvqFyhg4HeD5IcY5x2qUfPhZyzHtSjJuk1BQdi6YPXlH6fhUu5FInqPb84/B7ys5e9IfR3AJS0eiZQ8aAgnE1OERvvisbqYKBR+3LdssU7nRNpJc2jfKKJdTrjWKgvNXvXE6V4vsNLHqbyrDrItNIielmH1PhElNSgz9hK5S9Em0xYZNNakv29GK9fzLRgiN14av/Ish0uYA0XWCZ69VCu5aGX/8dOw5H2m+KZ5AgfWpmmQKX1yrBXeJYw0orJHdxiKPPG+6m0baHveSyrwtxezlpDoK9grBJzUz3P+i0YjmTNfP9D9l/FsfwYVopt8//ySvWIIoNZ37VUWLeTwAoD+C+dwwn68f50dCccGKw9imcksq1kmFnOCUYVFUbIOXtejUbAo7Ayn6eDuscOFAP2OVNRsTGBsXEEaubHn9Hs2Btp/l/E6x0K0LsU+VKtmX4E2mE5a0Vs6N+CEi8TyleYm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blhsMlZ3MHpUSm5DTnYzUUVDMlFESnVqQW1GV2hvUG9FUzhkM3dtRGpGY1Np?=
 =?utf-8?B?Y0dvZ1RTMHJTVzFNSS9PUWZxSTZiOVNmOTAzaWxSaDRubVBUV3QrRGhvakhm?=
 =?utf-8?B?VTlqVWVCMlpUQkJNdSt6VnFtdytVQ21vUHhlOFZ0Tm40SzR5b2Y2bFM0T21h?=
 =?utf-8?B?QkVSOVhFdWd0ZHppd1ZDWTdza2tjY3NSTitOSVk3TzNMUk9xQkhnT3BzSTBx?=
 =?utf-8?B?VFFRL0s5WDY1YzZoN0FMTVp1VFpRY0Q0NTlDZWdScFdPV0hXMnp6bDZ2WkpS?=
 =?utf-8?B?NlU0WU9DOG5LbnJxSHo1d1M3MkVXZW9uMU0wWGFOUEw1ZkhGeUZub0xiNWxB?=
 =?utf-8?B?WitGYmlpVUkzQ2FtQ0lMVUNBMXB3YjZucG5QdjR5MUdTZndRczNiTkRCdCtQ?=
 =?utf-8?B?dERqd3g5aDI0UmV3VlBiMXRCeWpVT1lFMTFzT2FmWldFSU9zb0xQSThMQXlV?=
 =?utf-8?B?Y0ZHcUZHb1dOUTB1YmV5MXRFcDZwM3A2d0lWUnVqMjdXdGdsWXlPbjRBdzdI?=
 =?utf-8?B?NzdoVis0a1liZlJXbEJXczJaOGYrQ0haelM2N1BQSUNyV2ZrVEtWREtLTm5m?=
 =?utf-8?B?MXdpR2c2NldMczcyMjBkdXQ1NDE5VU5Kd3VkSnlzOEl6cDZHeno4eVlCSTRt?=
 =?utf-8?B?dXJMQkVuU1Q5NmxwbGEyUHBFRmhmUDdCRUx5eWxDVVN2ejFEOTJkSnloU25O?=
 =?utf-8?B?dkNYNm52U2xRSzNJcVRuSUx4ZFhJYUpYVzJZcXRmYVJmcTg1VjgyQnEwcnF5?=
 =?utf-8?B?V2VhbXByU21nRXJjYWhYT3hCb1Y1dytpNlhlUm5yelpMUUxZM0lYN0VFc1B1?=
 =?utf-8?B?d2orLzlJOHliSFgwRGwvdHRyb3BiN1NwMFFuV2oxSWtscGxoZU5tUFBNaEQ5?=
 =?utf-8?B?R0xaNVVrNWRyeHQ4U3k1WHk3dWJURzdXTEtEWXJGMlIweW94UjFJaW5tMXVH?=
 =?utf-8?B?bjVOQXBSL0NoTzhTYjlERDduUTYyY0hVU3ZqWEk1ckhoWFpXbHlSZnIrWEVk?=
 =?utf-8?B?WkhyNmNUbTZsZU96emxvcDgrR1VndHpORE1rcUk5dlBoZzNqd29TMk1ZaXhs?=
 =?utf-8?B?eGtmSkNkY005cW1MSnhJL083aytQZHJGQU9VYnNQbU1LOU9JOCtOdUhCZUpm?=
 =?utf-8?B?K1ZaMkhZS2RKdURvRTJMb3hSSWQyQlY4Q29Ta1E5aTRhb2FSVTA0QzhoY0xP?=
 =?utf-8?B?UEZYb0c3bHExaWhrenNHVWE2alk0YkJEVlIrSndYUkhpS0ZoNnE5V2tDRG5v?=
 =?utf-8?B?YnAvRVBmL1Z1RVc4UndBaXlqcHpsYTcvNFNDam9TbjYvQzhzc1I0VFJ1MHdw?=
 =?utf-8?B?Ti9mWWl0RkFiM2tpWjBBd0ZFWG9BeEJJOFQ2a3hPK2JCWlE2Sm8rb3JVTXQw?=
 =?utf-8?B?N3hGYzB6bnhQU0Q5R2RaaW9RVS9VY1N4ODNiV2Z5ck1YNU5sMTJERnZZQU5W?=
 =?utf-8?B?U2VkYm5MS05Va0NvZ0dnT1FKdEJlNWtUYWNQVjVET2Z5MkI5c0dLTFFqVHUv?=
 =?utf-8?B?ZGpKL3BMQWlQVWxuM2JYejJOWEJhTjNpTjd3L3laUCs5czNkQWNzcHBuQ1pR?=
 =?utf-8?B?Y0h2Zkg3Zmd6bzhZbm9TT2MxbkFxUkdhQllWRk1rR2FabW1Dc0s5WU81Y3hM?=
 =?utf-8?B?TkNqMTFwUndaUnpmcW42Z0ZBMDRMWUl5MFBDY0JOVXZCa0lkVHFua0hTRFpm?=
 =?utf-8?B?eHV5dmJDT2sxQ0pNVXJrVEhSSUs0WlJTTHFETGFjRXMzV1RGNkhub0srZTQx?=
 =?utf-8?B?YmlLWHJ3UGRDQTZlYUs5NFNYWEJWK1FSRnlaQ3Y2OWV0NWFQWFVPU2lzWml3?=
 =?utf-8?B?RUJ0Z0pTMEpqaDdKZm1xcmZQdU5DT2hVYU1YZmlaclZKcW9Tdjc4cjBkYnlD?=
 =?utf-8?B?VDNoMXRhVU1mUHB1R0diME5Ea1pzQThscTNtZVkxcW0yaDE4U3JOa3FHMHNX?=
 =?utf-8?B?NWx6T01UeTlUdER3MTZkZmFXZEMzMkJnOTdnYzJQbmVPTkswVlh6ZWhxVGRC?=
 =?utf-8?B?Wm05WGNyZ2kwL0pVeGNyRGdDNkd1Mm52Q3BzTWlOL0N6aW5QZWUvNEFPbm1i?=
 =?utf-8?B?eHB3RjRuMWtFQlB2QlM2YUJBNWN0ZDBhZmVidmtHU3RneFlWRXl1Y0ptQko5?=
 =?utf-8?B?d1lOeFRNSlFkSDdvOXN3WjdUNUZoaWY0SytUcmtPUzdsTk1OTXpidGEzeUlu?=
 =?utf-8?B?MWxNbE9COFpZcnVTK2tCYzAzMWJxcnJHdTEvZzZ6M0FjOTJyWWpNODR0ZW9T?=
 =?utf-8?B?RUdJSFlzK0JSSnpwWXFPVkRoTDEva1N2QUxXVUlDTDhUM21XRGNDbEdxdE9D?=
 =?utf-8?Q?0EztZ2yo+eD6NeSmA8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96ccca3-6971-45c0-2329-08deb01a8f7f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 11:35:25.9510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zrqoq2lq0Tq/yi4aj9pmQoDQNZ9ik37Vze6ywJDDI5Xa6M4eSWBnqKP5qZjHVjFg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809

Hi Guenter and Jonathan,

On 5/4/2026 8:26 PM, Guenter Roeck wrote:
> 
> 
> On 5/4/26 10:32, Jonathan Cameron wrote:
>> On Sat, 2 May 2026 12:19:48 +0100
>> Salih Erim <salih.erim@amd.com> wrote:
>>
>>> Add the AMD/Xilinx Versal System Monitor (SysMon) IIO driver.
>>>
>>> The driver is split into a bus-agnostic core module
>>> (versal-sysmon-core) and a memory-mapped I/O platform driver
>>> (versal-sysmon). The core uses the regmap API so that different
>>> bus implementations can share the same IIO logic.
>>>
>>> The core provides:
>>>    - Static temperature channels (current max/min, peak max/min)
>>>    - Supply voltage channels parsed from DT container nodes
>>>    - Temperature satellite channels parsed from DT container nodes
>>>    - read_raw for IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_PROCESSED
>>>    - read_label using the DT label property
>>
>> Various comments inline.  One thing to check.
>> Is this one strictly a hardware monitoring device? Or does it
>> get used for more general ADC purposes?  Did you consider an HWMON driver
>> for it? The above sounds a lot like hwmon. So why IIO for this one?
>>
>> I wasn't awake enough on v1 to raise this!  Sorry about that.
>> +CC Guenter and linux-hwmon for that discussion.
>>
> 
> This very much sounds like a hardware monitoring device to me.

The device is indeed used for hardware monitoring, but the hardware
characteristics push it towards IIO:

- The predecessor (Zynq UltraScale+ AMS, xilinx-ams.c) is already
   in drivers/iio/adc/ upstream. This driver is the direct successor
   for the Versal generation.

- The supply voltage encoding is a modified floating-point format
   with per-register exponent and format bits. This non-linear
   encoding doesn't map well to hwmon's linear in*_input model.

- The device has configurable threshold events with per-channel
   alarm registers, hysteresis bits, and level-sensitive interrupt
   masking/unmasking -- which maps directly to the IIO event
   infrastructure.

- Oversampling is hardware-configurable per channel type with
   per-channel averaging enable registers.

- Up to 160 voltage and 64 temperature channels are dynamically
   configured from DT, which fits IIO's dynamic channel model
   better than hwmon's compile-time attribute groups.

- The follow-up thermal driver uses the IIO consumer API
   (iio_channel_read) to aggregate temperature data across
   multiple satellites into thermal zones. The iio-hwmon bridge
   then exposes the same data to hwmon userspace.

So the architecture is: IIO driver (provider) -> iio-hwmon bridge
(hwmon exposure) + IIO consumer (thermal zones). This gives both
hwmon and thermal framework access through a single IIO provider.
> 
> Guenter
> 

Salih.
