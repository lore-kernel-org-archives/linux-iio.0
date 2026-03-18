Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AA8259CA9;
	Wed, 18 Mar 2026 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825235; cv=fail; b=Y1JqL1Q0+gZAyz+s5gAtzJETqptPnJqBAGfcrD7DLw5928MPShE4HgcR7AGiRQM5Qo6DOul+4+vUEg11GbZN3J8es46jxlB6mZ0rlG50usiKUw8J5VFVZpRTZxx5q6/pCNqGWrGfJsAdhei7YDVYekYZSVt6i4bGnrl+SrL55lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825235; c=relaxed/simple;
	bh=N5woUYQu4Ljto65spN08Tl98ML1VsNeGcxCaxMRDuWE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sC3D0xMlPDFlDpfWRf9LYc7xFd16+TTivJQQpPfnjnThk0A/B6HEFXv9NCsNGY40OVqrxZglXaSv7OBq0Rr8Q2VUah2UyIToGrRIntvHqHQWl7HJecqkVcU0xLyZ7qxFYMt91Tdjr4rsppuQDOvuU6+fgjWkZdWenkgVF5pdhDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D3SRrJp2; arc=fail smtp.client-ip=52.101.62.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D3SRrJp2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LX1Pt4Ppv1X5n86oCR6OpJ+nAiYARplUsVQ9XfUvy7lZfS8PKPxskJuLmZgEum69Ks/WQqMG4ooHgm2MZ+KGnmSQJwPbMfPCdbkjvIy9DBtbSgyPAY9dohCDeyUj6LOMv18UaeK949K2oEc0gAH1woTRP1jGqCAjLIgUCYKDAWfrpEGwDXVDXephGpnHMO5GkQ40tAbjnRuWFP7uCZUoD4yPX5+vfqjMOrujQDGpEuh7VmMkq9UwpHJ1p9n4m9BoxByRWhDKFAvYDMWnN3V5CaTY4amDwVxkeAKOmKrI8DInmYvEEwd6Jj4dr/VZpOUZ3/k3lON24d+Pxjio0lNOvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tn4K6d7lKnCC+A9D8h/ak4y3ZsBsVPyhs7seFIv5Sg=;
 b=ipCHww6Aya8PKDakwDYBIteJSVzcaUWFb45bNwvvcGEyEB+OmU9aD4X5MUFVCbUQ4jVy6jNnUz4q0d3/l5nJh9W+EwYqwvzCxWCqkyL/xmz4Nyp9UtkxIbIb++jxKIl5F7RGIKlah184NONsAzMz/DUjiTqZZI10dwsgOivo7ZcGqZMjBbb5V/mIiLqEyOaTl500lXJJRAm9dOYK3j04kOoaJvKV7klfjHOt/5Z20SAR7ARil7D2yCtxhBQ9IFOPfjHFzwY/GEdO4qjOaqKOgGIXpaHmzHJrXQ1KNakPxyF8GX+QZ1N15/UHxCTfkLJWz6OqJOSyC/aqQGFQes8h8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tn4K6d7lKnCC+A9D8h/ak4y3ZsBsVPyhs7seFIv5Sg=;
 b=D3SRrJp2NRYVNCAjk/JEwwtjD76QN6WQG4waCwSGWQ9R4ycUi+Kit8crfDaAPGgS8STia8Nv+667aiIKDSkaVFTQ7FE/V0R+92lheCbRJ8pK53gIG4QJYMIh6YpsE2aDi6mPqy1UhQ6qPWLrbHnQPfe+vej/NXtSjO/suynPsOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 09:13:50 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 09:13:50 +0000
Message-ID: <ca6050a2-72a5-4d13-b89c-10e78364e5fc@amd.com>
Date: Wed, 18 Mar 2026 14:43:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] iio: adc: xilinx-xadc: Replace module macro with
 custom init/exit functions
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, saikrishna12468@gmail.com, git@amd.com
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
 <20260220053941.611415-4-sai.krishna.potthuri@amd.com>
 <aZgS2c45nGTozHkv@smile.fi.intel.com>
 <fab2599c-e749-4aa1-8157-c7ac358c6f36@amd.com>
 <aZgWvjWBusT_JQgE@smile.fi.intel.com>
Content-Language: en-US
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
In-Reply-To: <aZgWvjWBusT_JQgE@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::14) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: 214f5245-0a91-427d-97e1-08de84ceaae3
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zKbht8Ln5z+e2yzaJ6c4Q9u37yySRRik+/kg2aEg+pRvvmdhT/ojRqScZsOF6PVBX7g1XwIsEzccdJRYs+HmbTcHAxIlR6q9S6gzBPTH6/c2t/DkSgXVJtke3x8Je7BGVQTieXdzlu6dBjJrIJWs9jV9x68v1i+m+MN1BVFp5dVkt2vNJyPTO1G/bIEzsHTCCDEEXG5w155O0iPKTeeloNQ4Qmtv0ypE9SThMOaXBcpMhH5hc/HqvySwILpov0NpCTYn66y7+RiIj/IDsSS2hZpuwOTIuhw9vsEvdOJiRXrtdjpHMBHS2clxX3nCMuIDi+wEyWsPxHzyLDu+U/IgMiNOHf2Ihuwc/hMGlfWjzp3ecYRzsS0KQcgHYH1UdvPLzbXF0A/O8K6d6OA20kQGYDMaG3p2wz+YV9I/jShgXMhJ5crxpiiZCxPN1wgREDPiHnCqqBYJDVM/paDFWciWo3HkJSg2Q4oDW6AffKJHGynFttNfluE+hgLbb+7ZjaEM6+bMiaarWyeuwfvH6wlG/QqryFbJvP6vjzxJBy9mJA0dV1n/d99tYORPV3wWkPfhNkdx7Wv8TivFt1etCoeSLz/MPIJN5G53qzqAhw80DIvIWPIj2ko0jk3PHzmasHUHwD5eQwyqHWN+iuQSRUjV15XVFV4m1NOhG2IbH3yZASF9RBL+GtIyPIJfjQGqF8+pUNoKHs/HGEEj659KxNIMIN3zR7+/cMEB1McisDS7D0w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnJ6bmc0LzFNVjF0R1Y2SzBkeFVDbTJuS05hTy9uUVE4VDdHOHF3eS92YXJn?=
 =?utf-8?B?ZGZMa2xPaVNEU1RHM2RuVStXZWc0QU1LbFRkWlMrZ3R5U25vQkp0UUJtRi9p?=
 =?utf-8?B?SUJSbnl0eEpDaG5vZ05NcHJHRTdpSGVLZCtZMTVjMC80N2pPTmI2eVZCRW1l?=
 =?utf-8?B?U2hBamlIajRkdDJNb3VlbmxqSk9LNUw5RWttNlBHZndFWWRvMlRUSkhrMXRC?=
 =?utf-8?B?QXhFeHhDUEFYejVQc2JYdis2K2hUOUJ6Q1F3c2pnUVJBcjNZTEVpRWpPWUZL?=
 =?utf-8?B?OUVrc0hCU08xQWxMWWxuV3habmsxNUNZNk41bVlEcHp0QTk4bGc5YXZFSEVP?=
 =?utf-8?B?TGJkKzU3ZWtneG5YOXZpMFNidVRvRDdsUkZGOTBLSEtrM1pyNGdPYWY5NDll?=
 =?utf-8?B?TW5ZZ1JXRnVycWhaTHk2SWJlWThKSytjMXBUcVlpb2FaQ1BUdkpGOU9ac1ZQ?=
 =?utf-8?B?ZEhWNXVrd0pENG1BQVA4Y2xNVU5pNVZSZWczQUllemRhZ2t1S2dDMkZYY3Ir?=
 =?utf-8?B?QXd4aXlWWHU3cFZnOGxmckkrNUNKTTNweVo1QU5aeGlSbmU3cFhkVzlVN2Rp?=
 =?utf-8?B?UGFhUGR3SkVSZlVqY0lsbmxpeW9vSnhGTCt6TGFnQjNQK1pTbGZYNlg1ZkIx?=
 =?utf-8?B?TEVubm91YWZ6U3JDYklwNm1yc1EvSUZteXltZTFlRHZLbEhseUxiUElBR0dw?=
 =?utf-8?B?N1BtNytWZnF6ZkUxOWsvVkhWUlFnNGlCU3NyaG5rS1Urb3JjdktZNnR5M29y?=
 =?utf-8?B?YkhOT0NKZm5DR2w5WjdadkRmRDRkNlhNem8vMjByU3plYVJTb3A0dEVwbDB4?=
 =?utf-8?B?YWNjV2xBejRsVlFOcTE3Nk9FUUEydEo0aTV2SHpuckNHQmZRbnNBZThMbWNw?=
 =?utf-8?B?a3lwOFdXbjVvb1RxSFpxQS9zcm5jUWI2OFVsUlBYVGJDK1VJZHN2d010Qmx3?=
 =?utf-8?B?YUt6aitoWlNMTGdyYWR3WjZ4cEUvc3hBb1p1aU9VbjY1SVpvdngzK2tEZUpZ?=
 =?utf-8?B?NC9OdW1PbmRXMUlPL2kvbU5xZjE1ZUV5U3hwVWlJSlRIVWdOK3JzRTd0UDJZ?=
 =?utf-8?B?UDBoTi94Y0l0Z2JWeFJxcUVaRHhvbUdVeElqVmNZVmEyQXBFQTlnSTlzaGh6?=
 =?utf-8?B?eGo4eWM5MUJEZDExMUZWbmlod0wxRU9MeFpQa1VTNEcva0VtVXUvNjVEZndB?=
 =?utf-8?B?Z2VVdk5Od1U0cDhLb3ZTRnZkVUJyRlpJclBzTWZTb1B3czJMOUlOLzRYQUpZ?=
 =?utf-8?B?OFVUUFpWWnBZdlQwdUdIaWw1VVRWUEtQZVowVUxCNE9EN05YRWd6aDRsWjBZ?=
 =?utf-8?B?QUEzTmdBNU5LTi9BRmwrRE9mRzk3L0tyb2h3YTZCWEVaSWNqUFlVNXpyZ0hZ?=
 =?utf-8?B?MXpqcnFaVVpTU1lwUkZ0MU50VG9YSjRST0FYNURSKzNoOWt6ajFmTVZHaEdP?=
 =?utf-8?B?Y3ZwYmtTdXIzd3kzQTVuWUNyS3UwVXRYTFRyVFh6VHQrVHVnamdnajQ1Ty9i?=
 =?utf-8?B?RktTOHZLOTJ1Z3lVZTVGUGdXVU5RZFdzTkNhR1RRMjRqM3hyUU9YQ2RYR0to?=
 =?utf-8?B?cXNocE5tdDl6UVZ0VXh4TFJpRWN5dEtQaENNZ3h2cFZZak1yNjdtbG9XQ0o0?=
 =?utf-8?B?cGNQTHQxTUZ3OXRvckIwTW03RTM1bFU3dnVGOTN5eUhHUHozRmlvdXV2ekVo?=
 =?utf-8?B?N2xacEJ5SmJjeFBqd21PSkk4Z3ZFc29NdDVPQzhNak5YS3hIeUI1V3cxTC82?=
 =?utf-8?B?YVFVSDNiOXJhd3A2MFdjYXpDQUxXRlJtTlBYUXF1Z09wUFNtdW53WXF2ZHVq?=
 =?utf-8?B?STJra2ZBdzlHUWtQMHVBWTRBS3Jyemt3bkJVdWgwaEZFTTE5U2U0aFkvTngx?=
 =?utf-8?B?ZTduQm9EUWVBUFZxMWxaaW1iRHgyMk4vZk9NSlBicGlpcklMdnMvcFVvQ092?=
 =?utf-8?B?YVZ1TXArQWE3Rk51OTY2SEFPL3RldUx5a0FiOXdDbHRmREZjbGFZN2YzUUtI?=
 =?utf-8?B?YkZ1YUZjMWM2K3llWEMzMWRJTEIvWWh5bzg3cUVybGh6dWRkbXFMR0ZZWURp?=
 =?utf-8?B?MWdISWE1MXFZMGhBcjVVNGVOU3dVTkllcWVoMDBzQ3V2OHRUMTVoTDhUU0lu?=
 =?utf-8?B?ZDBTdzVybmthcm02ZExzSk5pSS9GVHdLT09MMGlMUWFLT2VLc3I5dTRRT0N5?=
 =?utf-8?B?STU3MDFXcDdFWFQwNVJwaW43MHk0T0NFalhId3lKWDhjTXkwQWhuNFE0NmhV?=
 =?utf-8?B?VU1GeFlHUVJ1bi8zNWtGZTlqdnBIYVlXaERTVW5ycHFUTy9EVmdqVVpQZzAw?=
 =?utf-8?B?NVFCV2htZ0hQaUZ5YWdwcDdaMmtZRlluS1hRWU9nWDZsL2FGREE1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214f5245-0a91-427d-97e1-08de84ceaae3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:13:50.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCQ5fqEFF1mMSIctwoQuD7+op1No0Lz/6LKjqHJSbWKxZQ3mHqoZm5xgwaSyTpYCgu8CEDnfr9Yn1b501AfFig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068

Hi Andy Shevchenko,

On 2/20/2026 1:39 PM, Andy Shevchenko wrote:
> On Fri, Feb 20, 2026 at 08:54:26AM +0100, Michal Simek wrote:
>> On 2/20/26 08:52, Andy Shevchenko wrote:
>>> On Fri, Feb 20, 2026 at 11:09:39AM +0530, Sai Krishna Potthuri wrote:
>>>> Replace module_platform_driver() macro with custom init and exit functions
>>>> to prepare for supporting multiple bus interfaces (platform + I2C).
>>>
>>> No, this is not how it should be done.
>>
>> And how should it be done? separate file?
> 
> I answered somewhere else, but I can elaborate here as well.
> 
> The idea, yes, to have the driver in the parts:
>   _core.c
>   _platform.c
>   _i2c.c
> 
> To achieve that, it needs first to split the driver followed by likely
> conversion to regmap. With that done it may be used in i2c with a little
> code added into _i2c.c.
> 
> We have examples in kernel for that.
> 
> 0daede80f870 ("i2c: designware: Convert driver to using regmap API")
> fcb82a939df8 ("i2c: designware: Add Baikal-T1 System I2C support")

Sorry for the delayed response. I have gone through regmap 
implementation to understand the approach and started converting the 
XADC driver accordingly. During the implementation, I see few challenges 
with using the standard regmap MMIO and I2C interfaces, which requires 
defining custom regmap read/write hooks for both MMIO and I2C.

For the platform/MMIO case,
Zynq platform has its own FIFO-based mechanism for hardware reads and 
writes, whereas the AXI variants require additional offset manipulation 
before accessing the registers. These platform-specific requirements 
force us to use custom read/write implementations rather than the 
standard regmap MMIO helpers.

For the I2C case,
32-bit DRP packet needs to be framed before issuing any I2C 
transactions. Since this packet framing logic is specific to the XADC 
DRP interface, it again requires a custom read/write implementations.

Considering all these, regmap may end up as a wrapper on top of these 
custom xadc_ops read/write functions, which may not add any additional 
value. Since the XADC driver already has the xadc_ops to support custom 
read/write implementations, can we continue using the existing xadc_ops 
read/write paths and skip the regmap conversion?
Please let me know if I am missing anything in my understanding.

I will still proceed with splitting the driver into three files (core,
platform, and I2C), as you suggested.

Regards
Sai Krishna

