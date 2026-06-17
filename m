Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC534ADDA5;
	Wed, 17 Jun 2026 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713485; cv=fail; b=uWXFSr2HcfWc/QH/5NCJaYKhAcbHf0PqsqhgpAPr9MLDoQxDivIiYVBao/x2TdNwuZKuuw74s6OFOpI2pHaS6EQi+xtJCMo5Kpi5UAj5FANO2AD+l8E7YBw1c58m8X42XknBGnUUxOSqomZ76fjVpz8O97MIW2kecMi91n3eaIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713485; c=relaxed/simple;
	bh=5FdCGCVjy7/4H6XFuResQkZbLliACE/0K7RiXyD/J+U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=prPFgI/YKbv6pQXiRcvKaQZqW2bRgB7HH6nidox9TOZuziT6AnVAwbh8JqkXz+K60yrZZmS3iOK0nHgqnxBEPvPnUvAGejRNwqiaBlanp6XBYTeY7y2CC2I4dCyR982H2chxNM664G+sAvtiO1fJQzQunPnOdikfSfkOuxYxuRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eEpY/x1p; arc=fail smtp.client-ip=40.107.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eEpY/x1p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b61U/BNf467QaJXhBXo+8EfPtmSSCCv6jGeGUdDJ21dMh2sPKQ/biRsDHF9VpXfUZbvlxvoiqu1RtOG1tc243vGgC//HxkDTf8SVJ4yGnoRhip7QcyFyf6HRxcV5yJzgLL+6j5HTKQRUyJYrVzMe4VnZByF6HNUqWzXQgeD90HhpT0synPXp+ZcJqUiL96iegykRKUsdV1esDauuOWcjx+KJOLPPY1LFSSlC8XDP0HjxSL7ryW8KJpW5SAHJ/HPEeuA83fL8tf9qXHkIbdZsdI/hR/7JUSx6WY0RYINsh8kYWkOCyVqHtPskCGfYgNH5ev7VLaVwvr1gn+PID3O/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfV0C/0f6DnUmyf2q0BqR7zdD+Hfl2/6donVf+tACpU=;
 b=L6ePRVOWIMzaPrixQpaCaTLnkw4wux3S1UcK+Ey7uIFhGkuIErkock0RZ6X9bDc/7E8dz2V4uR/GwU38guqAoXf4w40ctz1ElhSdNTHq+k8crySAyDZalTSNPICPa7FP36A/PmoyMchBQNVrz7iVpchfSGpsLPLhzuX+u9WiLc55gYRg/r1PqHPTNcnVkDWJOjBCRQUBUyQ+BdYOPlV5kDvkM2ZAUPfOwMNDMEe+zF43iHAehOvLJbrA18G3EIW1gfzL9HIFrWWFsNQFMCxV13byfr8xche4TzWOgUKrpDnjH3ffhRxeZ3SBjLtbIRPCXcV3pYb27q8uN3FwAwWK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfV0C/0f6DnUmyf2q0BqR7zdD+Hfl2/6donVf+tACpU=;
 b=eEpY/x1poCjZ1dKRWyGWK7NnkXUnyEcyUIycjVq3ZFEYvVgiXoEca6CHWSW3BhgfY8EATqpgMdWJq3TvPYUNA4aOXw45+wf8Y1E0ZZBs640aRK/3+oWfFcavALTKycMM8SBpEQJWB4AeCaqVY3PB73QdIqyvrErFdtuNOU/APB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 16:24:32 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 16:24:32 +0000
Message-ID: <6dddc1ce-fe78-4883-940f-56589149980c@amd.com>
Date: Wed, 17 Jun 2026 17:24:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] iio: adc: versal-sysmon: add I2C driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
 linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260616131559.3029543-1-salih.erim@amd.com>
 <20260616131559.3029543-4-salih.erim@amd.com>
 <ajK0-KmjxDPW_g4M@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <ajK0-KmjxDPW_g4M@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::17) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: 630ef501-aab1-475a-21a2-08decc8ce9e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|3023799007|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	no7IHB+2te4j1Zm4SvGX96snzoHZA/5PGIX3rpHvgVuHxLWmIo4xOwmxBHiaDwJH0T5dKRuaJ8lf+bNu3PXLiakaxH5gOJB14gNkXMcOlTIIDIVu3JnvOJUsJfIY/5cT02ovLnqMWWumgYilonLl4pD0A60kxuuF8JHftt5sTNHxCGoGGrnzKNA2nVLRtSSHkqwW8kIu6UnbIbtdt9VUXDvqBGOg0om5juvZg8FMwgqzq2wGwrBzuB7lApyW6JcO7XqjYqt6WDJhRVfttj1VNnnuO7rpHK4qdOu4HaAQ5oPjCwJBbHjJEDBSN9pBzooalcOpAxsHyu9GYeua6TyYUQ5RbbG0gWBVH7n4r7FG6MGi/YgHW6SIyggRQcQ7vYAkdcWuUq+4otX+ekzKLv1GNlz1efOiypJBK/T3V5OkO/weGgQ53lS3Co00VTSdS2wR/AA4mpbGsJaK5SbY3JMrr/sKTJ35Zwg6WNuwwDMdjD/nuvj3QoBTP0d16QUOI5OiD7IVL2xWoOqzvoZ5Pv2GVNfeGc8Gf4hYFu3YSI6UheOYjmV9SAN/u8uVcuUARdIg7+RP07bk+IQYP8d90WWtUtBZCwuFujy5atsbv2bxZM6piLQn1XokgIx1KlxpMCqsj7RTlqOUXi2mKdeyIF+Viy9fVRVUkAR3LywWW/y8/MSG1XcC7SiGRkkmeV+Cqq4k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXE2dVIxUys0Z1VYYnp2M1lOMks0cUR1a0Y3VXVYSFY5QTcrS1FRSkMzVjZm?=
 =?utf-8?B?UEZMK1pRMjJGRTRaZ2lXWFI3b3I0dW9KRjBhK1F4Y1dmbmlFMkVmaW5TQ3pq?=
 =?utf-8?B?NnJ6N0pDQkZCRkt6YncrcG1NSGRMYmdEc0RjaUFENVpjd3U5VEJTdG9LMFVX?=
 =?utf-8?B?TzhQZU4ydXNxdXpBSFM1dE9YOVJaeTJDbWVWU0ZIYlZ1RUM0UW12S3FmMlNo?=
 =?utf-8?B?d3pVZmZmb0xpQnNhemtpQS80Z3NUaENaR04rQTV1Q25GY25vTWk3RXg3UUJY?=
 =?utf-8?B?WXlIMXBPTkwxWnJMUjRDbnNIempIclNiUTlpcG1ESGoxbWozZTRyMUZUNWM4?=
 =?utf-8?B?WEFQd0wwcXlFdUdFa1N3NmhTQVBjU0FseEZ2VFlWRlZCVDAvL2ErdGRUUVZB?=
 =?utf-8?B?Y3VxdHRsUlpka2x4VXYxaTJuSG1TNFVMRDdqL1QrWGlPd1VqL0hLUE85RzBF?=
 =?utf-8?B?V3F6UUVCQVJsUTJpOGpjdFN6VDBpNjllai9oUWRydHZyTXdiWDVTUC9EYzd6?=
 =?utf-8?B?SUZhSTNzZkdMaS9IY1RBTWpTM1d4ZVVOMi9DeVJ1SmVTNkI5aUxhaysrU0pP?=
 =?utf-8?B?ZnZmUkpETTRiQzA3cGl4Zys5NUF3S3pQU0ZKSjh3bThiQ0h6OWczZ2hSaXla?=
 =?utf-8?B?UXZjSTlWdEdodTlHSWF5U2FqTU9ocDNmcUVLbXdaTUwweTNHZzFzZVoya3VM?=
 =?utf-8?B?MFdIZnVrWlluQzhVMFh6ckgwb2kzNmVOcnpPTk1QWjYyNkNRR1F5cGRpOUxo?=
 =?utf-8?B?b1dnQWxQdXF4QkhleWJhbVdadmRvWWpNTklzL1Bsbkg1Vk9pZmVLYkx5ejc5?=
 =?utf-8?B?K0IvL0RSWW9Ndm5jMWpRZDdNMDhDeWNpbEQ5RjlrWHBuTVpYUGdpbWVpYzdO?=
 =?utf-8?B?UVE0cWNTWjd1UWh6ZFlvTDhhR0VpOTRRSFcxenFxVDZpTVlpSE5zMnVzbGkv?=
 =?utf-8?B?YlZHOHpSWW5SYVFOWG85N3U2NFpaODkvUjFqNVFCdnloYmM5YkNxbEpLbFMz?=
 =?utf-8?B?SHVWMHA3ZG9FekRkNkpTZnZsSklTUm1uK3ZWeTEweGljMDBzc2t6RlI2aUNt?=
 =?utf-8?B?NkFQdkhpUmJ1RHZ3MHEvVVpUbDVYVHhzdXVpNzliTHFIc1BnUDh1SS9yMkdn?=
 =?utf-8?B?RDhWZWJOL25WZCs1Y0l2UjVpVWNhSGdhcWlIdXA5bUx0V0l0c21RRi9vYTk5?=
 =?utf-8?B?MVVycjJ4TE1iN21IY3B4bGpYcHM3N0NxSkdZejRjVk5OaTRBbTJPMHA2S2pM?=
 =?utf-8?B?NkVaNktxdTcwd1orQ2FRSDk3OUQ5VzJlUWQrNXVWMStrK2dMVnd2VEtqSExi?=
 =?utf-8?B?a3ZkdWttOVFIWWMwc2w5U0hKdXBmVG5VcWYzaUZzUWFpWjBBbmhmM2szbVdh?=
 =?utf-8?B?b1lBbXpFWjg5SW9xUGlzQjJmS1k1M3F5NGNiUGRneW9XZG9OcWRyRi9hUTU3?=
 =?utf-8?B?eWpJMzh5TmVLNXpSQm9FVzFvNW1KOWwyanlhSDVONkYyc1hYdEtqeTNDTXZM?=
 =?utf-8?B?RUh5Q3BJUnRnQTJIeUlXL0NXQ1l6N0k5ZzZsMWdMUFM4NG9PYVlUaGJnajVD?=
 =?utf-8?B?djU4b3RZS0lqUHFvQUhHUXpaSzRIeFgycFh4eDY0dHhIOVJaekticmdQV3VM?=
 =?utf-8?B?enIzWnRIaDBWS0xVZ0tMamlrQWF2T0JFYXQrTEY5czE0Y2pDdW1reXcrbVN6?=
 =?utf-8?B?TWZpVzcyWnU2YTZJbDNOVDJsaUVIaDZrand5Z09mc3R6ekdNZTVqTlFBSk9S?=
 =?utf-8?B?eUo2aE85NWt4TTlBbThsa1pHVXkydG95UWU2WUxWK3hZVyt6ZFg4b0FrRjJM?=
 =?utf-8?B?RHprVWwxRncrSkRsS0RQVS9xUDJYN0ZlQkFuOCtXYXhYaW9JVG1od2FRcXFV?=
 =?utf-8?B?dStLa1p4S3VZRjQxd2dIYTNWRitWMC81OVp2WG1GRzE3VW9xZEJzTVdVOWUv?=
 =?utf-8?B?am1rT2VYbzJRZjlkbVJvM0dkRDlnTWFKUjlwUXlaY0Fhekkwd01KczMxMGdN?=
 =?utf-8?B?RHBBNkVFb2xXNGNUMjVWL3dGcTFjb1liZVdkT2ZIMDlZZUNUUkd4dmg2YXJ0?=
 =?utf-8?B?ZGppRlphd0k2OEhENHVkNXoxT3dEcm4xUkE5YyszT2t4Y241MFRTMmp5UDg4?=
 =?utf-8?B?QUxKZEFYaml3Qit2bG4vam1oMkpCdWFzVGxZc3NjSGpTNWEyTUd3T1BCcSty?=
 =?utf-8?B?UEdla3BMbmI2UDNhRG1KL1k0ajgrQ2RJemkvWEl5MlM5UHM0OXpvSTd2b1NJ?=
 =?utf-8?B?c2VLcEZraU91RC9DOTRSYkI2a2VmbU5aL29JUGFZaEhQdnFnTFBpWW5PSWxm?=
 =?utf-8?Q?k0O8KIMS6fvN7S+60B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630ef501-aab1-475a-21a2-08decc8ce9e7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 16:24:32.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7ysA6Bp9b+TI1G/Mcoihz6LJj23SWCF64QiU+Ml72FwZVseduRO0LR3ahXtlmre
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162

Hi,

On 17/06/2026 15:53, Andy Shevchenko wrote:
> On Tue, Jun 16, 2026 at 02:15:57PM +0100, Salih Erim wrote:
>> Add an I2C transport driver for the Versal SysMon block. The SysMon
>> provides an I2C slave interface that allows an external master to
>> read voltage and temperature measurements through the same register
>> map used by the MMIO path.
>>
>> The I2C command frame is an 8-byte structure containing a 4-byte data
>> payload, a 2-byte register offset, and a 1-byte instruction field.
>> Read operations send the frame with a read instruction, then receive
>> a 4-byte response containing the register value.
>>
>> Events are not supported on the I2C path because there is no
>> interrupt line and the I2C regmap backend cannot be called from
>> atomic context.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thank you!

> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

