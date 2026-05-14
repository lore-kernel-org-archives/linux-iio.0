Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6DA23741;
	Thu, 14 May 2026 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722432; cv=fail; b=NP3PAQZ5R+nFOEz1VDJRkeIOyDsUO6UOIzyB3ThjwPZ4viGtbVjcL5wPLIp5oTtaBgCfsO8Wv7daCfVS1uyybas8bCH4JHjqwuj5CnWUTmSFGoH3G+a6sJYqHMDTcI0Ohv+tYhknFJOtytOk3+eKL85BvD/NAvOUSfjUS/qT3wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722432; c=relaxed/simple;
	bh=Beck2EbIiGrQNwPoaDgbZsNe/tEqUwj/IfYRv7ip/qs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hm/N5a+/LWSwbtrbbV71ppSUkXpGIbO6oxeqNXg/R8oQrbDngajNOUoDjx3tQoj0eruOtZNsQqSy4MkyWx/YdvrPebc6w3rKdLDL4aXh4xgs42ScWyuKxh2C390JEzl/RdP1qvkQ59WRzGCr5uit7iS5fvToum442+ttgvccH/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J40IFsLJ; arc=fail smtp.client-ip=40.93.195.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J40IFsLJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHMYlB0V9IVt8nQMlEE9D25t7TAKA/SKjG8QOQi/KX0nXz4xE5Nvxxn7HKurIpFbStcbuyV9JSdrMlzMbpu8924tW6MDIm14JwosZcROlc0s1/r12qOUR+UuKURiT+xl1lppesnKq5p8FRILyBlLZ5muc17u8/5SRIARA1AFvEGHF2Rr1fDlAmnMs00vqOxKWDfkxgTnUgBFZ1571Pw9RwXFzBXbiECon++fAJC4hEITeVMTGeD5Em/gzOuP5N57H/JwyGDyQy1aZ6+kqgOSsAV/p63mk/9+m/nsug0OlH4CsgA2UZ1kKEmX+bSThocvly+68v+WutEC/JcyU36YaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQM/980RpJr9JTSWcUW4/3EE3Jl+Mwo3N+M39ozRInw=;
 b=IYc/6od5mPqX0DPuaioJoY0Xo0vMI5ss4IRwm9+Eu1dbha7uBxf67mT5JSQLP6fP993rHW/ar2J6TwtZSlHocQHk25QLbs9pUBYGVMZRUFA1LyTptqMfN5Eysa2dcDzxO1mL7QLOpk20na0H5831nZf2cIDFj1EomH3GViw0S+Wj378H5Tk5+3L9XJzuxBnoiEBj3NptArQIv7175o5VQtV4A3i5FZetley8Fd4zxCeHqvxCdQD3uF1rvrmYq5KaLpdqVZIZmg+RryiPmwpEAvJCkGR1O6+Pxc3X/ShuMTCi37I8bZSuzhIyOKbB+4WG/t7xlSh64hfFBYTkj1a0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQM/980RpJr9JTSWcUW4/3EE3Jl+Mwo3N+M39ozRInw=;
 b=J40IFsLJeMo3gA37OvhJX+AX37SMqxLuQq5843fk0qVn7OxUMx7sll6pH59eql7MK+Icdzv3wzKdkffGf591m/W469Icko7e1KJZA7VUuRytWPlqDbI42IythPQYp4vjnoM8w6L+xHgwJ0MsNgU8mHjD/b0C6/65vIqkBwfpWrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Thu, 14 May 2026 01:33:42 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 01:33:42 +0000
Message-ID: <4a2042ae-a2f5-4557-bcfb-8be56d7f1e90@amd.com>
Date: Thu, 14 May 2026 02:33:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: xilinx-ams: Replace spin_lock() and unlock()
 calls with guard(spinlock*)()
To: Maxwell Doose <m32285159@gmail.com>, conall.ogriofa@amd.com,
 jic23@kernel.org, michal.simek@amd.com
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 "open list:XILINX AMS DRIVER" <linux-iio@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>, git@amd.com
References: <20260508124513.17752-1-m32285159@gmail.com>
Content-Language: en-US
From: Salih Erim <salih.erim@amd.com>
In-Reply-To: <20260508124513.17752-1-m32285159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P195CA0009.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::14) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|DM4PR12MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3dc5f6-8aa2-4771-d69a-08deb158d4da
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	PMgc1lHyfFwqhIYEE9+hVkfcjxr4ovgPA2fOMh/tdTmvSDW+7NjuQdScVxVBKhGFK04SEZ0dERpjUAHTHsHZdZGVRww979R2BgEOJZ3LrUZZZVtN+dU0iQED+gTIFM9DDqyg3OZ5qve9uDICsFBp6RYh05rx3zKZTrHhlMPDL7Wxc5ckBOMRfzjAVmNIJvwbTea89KTDJqdhR5l6JuUVsChPD3L9GUSjENIq/ghnD9ZuzP7wR6jSRLiFu1TYqzPRNg3AkCUjpVpiJgQ2CMlT6DNdh75+Qgyc+Ee3laHoJaIqMoICDtYmZfxO9eUNgA/Td0Xbt3iWhA3SXsXKE7c2M4/UrmFokX0nTzrigyeIIikxSPWtqkr+pkq9vk4ZhiXn1LGZlwW1uNIIewcxj385l6nx1oIhSuCCaOEcSvqbKmi4T9CrRPgIfkBBKpWUD4HA5//Nlumsd3xwJDfpm+t96dFpXQTUZvs2G8Rr5GmMLfO+vXaRmecDD+L2zhr0zEpMggZT41qEAhEDl4ANZDG7HcZYHTHeUJlYvjPbDV4KoshZSWBhnRqo6WZCrfxLup7C663c4G94x5veASrTtAprPHtzbfQdERRap51uxtvDJQpEeWo6PUtoZ9hlOzebjc4O9jdLKs4zvqNoqD5Au61O83v6rP/mEVNCNJZnx7rW1B2dgPXCsJ7RgEv6jtVhFE1n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzVpRjIrd0pHQ2tFMU50QkxWTXBEWXB2M2JTbmRhdFJUK3YyY0YzSm5hWkdW?=
 =?utf-8?B?ZldjU0U5NnFaSGoxbzkvY1ZQNlliQ3crQ1JCdkRHd0lVeUJxQkF6RktOMXdU?=
 =?utf-8?B?MFl5dmhDOE82SDI3Vk8xUVQ5d1Q2bHRrbzcwSVluWDFXWmJvcnNRMlh2eDJ0?=
 =?utf-8?B?dDNEQVpXOGMzZnhUM00wSFVDb3ZrMkxSM1FTYjR2MDQzYjMwNVF0NHJUQW5D?=
 =?utf-8?B?V0R3MFJpMmNrMEphYmtvNER1RkxMYWk3am9MbHRRTG9YMi9mQzM4S25OS0Y2?=
 =?utf-8?B?bDltL0tFTUk1Wm5XcERUK1U2NXF6QVNCaDRlRlAwZlRtUGN1MFJUWE4xTWlK?=
 =?utf-8?B?T3FFMXRZUXhUbnNBaWF6RkFaNFZPVXBtTzFSSFZLOGdURGt2eWRBNjN6UTAw?=
 =?utf-8?B?NEtENUtVSGRxVFY4L29SVmpUYlIzZnpMNUpIdWVVU2RGTXJ0V29BWVRENGZO?=
 =?utf-8?B?UGpmYTRDTmRUMyszTzRsNFVGN3lweTJxZDdGYko1alYveE5wNDJWNitYeUNt?=
 =?utf-8?B?aHVvZ2Nra0NyWVA1MWVoa0Q1VXN6dk5qbENYQjRaQkRTN2YyekZtZnNvTjZR?=
 =?utf-8?B?Qy9MeEVCM2lCTHlWbnVUbmgxelBSemJQVVVBcnhMNVU4RnBiaFM1NGNaQkx2?=
 =?utf-8?B?UFRZVTJIVnR5RkhvS2Y0TjhFelhmTnBRQmYrclVqWDZBQi9kSDlpeXdHRC8y?=
 =?utf-8?B?cFMxN1FrZDArL1d6azFMbnR1U29sdHA4bmZib295KzNZakk3ZGZ0RDU2QzFT?=
 =?utf-8?B?RXcycW9qVVp6VEhiaVhIYXVIOG4vRlJSU29ocWZHWTRuSDZRNUgvTnlRYUZk?=
 =?utf-8?B?WW13azhlR0VBVEVJM3dLbGQwQitZM2tlOFYvSlZTUTEvMnkvT1ppck5obHAr?=
 =?utf-8?B?enZiZGZnZXdyZ2N1c1E0Tmt4a3Vrd1pveTdQanZxNVU0YVhWL2lzdjB2NVVr?=
 =?utf-8?B?Q1E2ZHg2RGJzdXdyeEVEMWpjL1VmTkhScW1vSTJRWlV1Q0Fub1dPVU1UV1F5?=
 =?utf-8?B?dk5RYWphV3BvQVYyczFtT1R3TzRwMEtHNEZrWGRYazBqRElnQ0xxbVNrZnJV?=
 =?utf-8?B?MzYwaEs0VFpxeFA0MHE2M0pGMFNDREw3RUc4dkRaeGo2dUd1d0xHeEF1UWNP?=
 =?utf-8?B?Q0kxVmtZbFZTNEtORGlIejRiUHY5VWcwTXNmdTBRa3JndDEwa0ZCQW5rakxG?=
 =?utf-8?B?cFVJUm0rdU1NaUxIZ29yeEoya0V0d0lIZXE1Z1lLYnl4Z0JScnY4T3VZS1d3?=
 =?utf-8?B?eW9rU1NtdXp3NkplWllvSm9oczc5MFU4NjVyZW9kZ0NrSHU4NFlUdUkwUFgr?=
 =?utf-8?B?d3VDMHJONEIydmF5OXNIQ3N3bUJja0hHMUZnRURBcDlaVGFMNFpYTjdESjV5?=
 =?utf-8?B?M09lYkZyd0ZWSTRUa0FXTTA2Wm1vV21iK0N5c2ZpRTFPVHdRWVo5RnVvTkk5?=
 =?utf-8?B?OS9MYmROWHJOY2Z3UitZcERxbnEvTHJVU2srOTJ4dzJqd3ZMTjNlL1JkUzJC?=
 =?utf-8?B?eDdqWVYyRDYwbzR4YmtjQmRrVDB1dTU2OWlrV1ZQVTU4cmEyUzRXcnBZMzJl?=
 =?utf-8?B?S0tXMlhwV1hwNXJrUkJwbFpON1lrY09LUy9tVTVIbE1EQ3dGWDEzNEllTmwz?=
 =?utf-8?B?ZHIrWmc4d1NWc2hJQzV1dC9QRnRlTTlRd3AwdmwwK0lYdnNQUXpnb28rWUIv?=
 =?utf-8?B?R09vUk5JM2FGakJ5OWhoOWJzUm5MK2o4VVZ3a09rRkRvTENTYnRUR3lqZ0gv?=
 =?utf-8?B?Q2RJR2Frc1ZvWkh4UHd1c1o4ejBmQjdxSDdTVVFYcDNQVFg4WG13ZEdQVmJp?=
 =?utf-8?B?aXFwV1o2SFhuNGdBUTJkN21KUG9IdDJuTlpkTDdxQWhJaGNUQjMvYkV2V0JL?=
 =?utf-8?B?eHEvUnVFNHlJVTVBY1kyMXRKU3l1ZVc0TFhPeUF4Rkh5UmE0MnRXbnNEaEc2?=
 =?utf-8?B?SWRLTkRrdTRoZnFGRzBZcmZwejlmYSthZmFqSkVXSHNBb2FURkRPZmNQOUFY?=
 =?utf-8?B?YjZkSlptVDVmb2JmUmVabjFXU0tGZVdFd3BhV1BlQTZmQnZ0THp1WENIREsw?=
 =?utf-8?B?bERRM2poSmZvWUN5K0lUTXJQaXd4eXdsOWY1ZlBncVRoRHk0cGxWY25UamlB?=
 =?utf-8?B?VzdxL0ZJSXh3R1ZBYWsvVnZ5eSt1NkxlMnVCeW8yRGtVNVlPUnRHQlZwbkpZ?=
 =?utf-8?B?bGlrVU1hbTNPanU4ZHdsenFrVGU3OTJPall1NDRFWDl4RkVYSVBEbm4yQW1l?=
 =?utf-8?B?VFhObUFRbmR2M3VUNTdBK0wzWkhJdUF0ZUNxazZ2TEZhc2FTbzM1OVI1SnRE?=
 =?utf-8?Q?uK5aFK6g4Fkh0hzuCu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3dc5f6-8aa2-4771-d69a-08deb158d4da
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 01:33:42.2346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cR6xpgWQB+MPYlDo07+yqQ/oNzKGJt6+ovCXFPBfInrh6ZZOJVpjEfmJgX5x3pum
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938

Hi Maxwell,

On 5/8/2026 1:45 PM, Maxwell Doose wrote:

> Include linux/cleanup.h to take advantage of RAII macros.
> 
> Replace spin_lock() and unlock() calls with their RAII macro
> counterparts, which modernizes the code and increases readability.
> 
> Remove "flags" variables where spin_lock_irqsave() has been replaced
> with guard(spinlock_irqsave)().
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>   v2:
>   - Replace guard(spinlock_irq)() in ams_unmask_worker() with
>     scoped_guard() per Jonathan's suggestion.

Nice cleanup, thanks for taking care of this.

Reviewed-by: Salih Erim <salih.erim@amd.com>

Salih.
