Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E535481253;
	Wed, 17 Jun 2026 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713402; cv=fail; b=hL6MzM7ORVJx1MDzZHgv0sf+wZb1O9jFxXRImygZQxfhi19pPAB9/eEL3zH8XB52hZeswwJswdjU4Dh63+HzV4+ztKnhLNaPK1amkzIhO9FK00RWp7uBB2LmNE88A1x0446MRciu+7Cdg+If1iPY/vUkX8Lbmt+glLVJMH37qDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713402; c=relaxed/simple;
	bh=EEq2XPFeqVh6JJPmkX+STKTBTV9qZMfEXiJC2xW5ThI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wn5ig0wd06tyQT33Rqzwoy28dNpMFvrhMNbpiewXb/Xly4prUFlglNRWNyoNmTRAbMFdX+LDb7TEGlxAEqaiVBpcvGisu7xE2njMyATkwFPSPQCz4lenBBrD+Ffcprfq5c3ASCnGuIP6cN5xowP0lnCXJMThn3ywM4uUY44RZQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B6juE4O1; arc=fail smtp.client-ip=40.93.195.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B6juE4O1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWArnLE0UV0M25bAl+HQCKNW+9Eqli9cBiXAzxNqZxk+6ylFgGWJjuvbojH08pmHRglyR3e5UfjR+1gRKt3aq1XzkrpubeigfapqQBjNRpE67+ZllPFZmbq4X77Ak/AIH9x5h7/nVotz0DBON8LtVoKfwW1V3tAKFSL8pd5myrcPU3xduaA9flzXgopZNlgweNsWBoDHdkpZe065BhQ3dZJ6lpHWpSSScjmx8rYGipMETEfdfKXfd9mLeM9PubPDmo9AouyYJGqoOOiXeadJVLCuaDc9+f2rR1QNQA1FQF0qaBblA7JXDYqjL8cKtDtEVbrKT6V0XvUhvDYZ9eNC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esxh389dRPmaWu2oReTEGfdrGYSw1MvmyZmwL+YPHE0=;
 b=aKDF3jpeWb9UX81arFKO6Fd/VgdXzO1vHUU/KB2i3zYo2XzEHua3wAKftR2YrR79jBVIVi/reQvji/w75Jt0THHgtSyK5pruLRGvFY2LQ4Q+wnIQNQIZR3AO8AFZAFW+HabALIqRtzEfe1dAHPA0/+ML6w9isTr4+CDfjAPDRAW1Af6V+8fOQuC6PIjmLbv5mB6tKR5Zv0ZZtxOIW21loF/CNap6r+m5wIIbya/02T5bXSzpjcmIefNrM6b+3GL88yUCTuceECTtG6EFOfhI5HrwtH58ZtbQyjTU5/kIMcwYbrC7tAlXu5oGBTB3HZbRXAz39hglWgzlLKRcljbl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esxh389dRPmaWu2oReTEGfdrGYSw1MvmyZmwL+YPHE0=;
 b=B6juE4O1m9pVFGSqo4b1/8oDh/VKGnHeWRRg+bxiKd7/oS9vWe4MitGPZW9Gt+e6vYrounNqWMZl7AjYDTpjUpu/vzQia7LI3nWyenzmiH9fDnIFFZmprhLJfkUzGFqaN+/aLNTJmU3mS4wanXAxoHvWHtNTuktXKdprrMBnEis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Wed, 17 Jun
 2026 16:23:13 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 16:23:13 +0000
Message-ID: <2a87a404-9fc0-49b9-9ddb-f5a4b25b78ca@amd.com>
Date: Wed, 17 Jun 2026 17:23:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] iio: adc: add Versal SysMon driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
 linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260616131559.3029543-1-salih.erim@amd.com>
 <20260616131559.3029543-3-salih.erim@amd.com>
 <ajK0phP9-pt9njrb@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <ajK0phP9-pt9njrb@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0197.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::13) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 020dbce4-394e-411d-79ce-08decc8cba79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|3023799007|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	scN3MLt/SuEATq8uDxWX0YkcPipybOYHRuYGRlxoa3liTSpXVN1cVTkccK5JrvkeeC+buGjw8xgUxQ2gLPIpMWN48lX4FtvMTuy/zi6Bqm6xxc2sNe8nIorAeTAUxd7ysI3vSMKDOujVv1QUwwnvf/bUA/8GldQZHgTpazOh4YWGRfRkbHjsJtwg3Yth8ZEvg3OF3lK0mf0yVqW2qk2pnXtNmnJrTl0FQ41xFn0Vk5V69P6lNTLQ00Yw7JdePvYFfPGuNYFK17OKBd2S3k/7gbvCqS5UtoqdqDNlhAnahRPV2IXMRshfsON6HOUCInjHq2rGGc05vhsSciS/GMgzM2aEY/rP1ElQz9AwC1zWr1/OEHQj+rUc681gcs0wMNlpymoJnY5z1ljRbWST19sB45w6YyQ6P1jNjhaiIi9WNvwJ5vJBiCSxC9PmfzwEz31qoL5Pvu0NNOJ8HJe1O0b+RTtTjv1oB90AeGInJRdLme39vbcmbj5b8pVhqASougYd1hvtVkqSItMMBAfy701DNunzNvPF2T6TiDoj193tR1t3oQgm3+7LVffEvbRnpu4G9gMEkILnw+29PC6UPyec3jT6bRSc5Lz68QsIJuwSzOPCjF+2wgqQevlQNl4BSCU0Md+iGZ25ITdHRGxbogqOQKzQyUKT/Ms0LHD9kdQIoPWMNYAAiaA/igI9iDI9YO0f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkxZVmM2c1FpaG5SSVQxTnVySFJpWmxjOUpSd1VwVitEVDdZRFVXeXZJYSs1?=
 =?utf-8?B?Q25HYjhFVGxRaTN2YzI4eDluOEdJNjBQSURTSW52T29tZkRHWmdBdnVWTVpX?=
 =?utf-8?B?dE5NamYvUndnU21XSS9YVTQxeGtXZ2M5ZzdOSmQvdkdITHNrdEVJd055YWlW?=
 =?utf-8?B?djkwK0VrVWE2ZVlsdUs1MXVITmhKR2VUR2s0VnFJWjdYNnM1M2RyRC9Rajl0?=
 =?utf-8?B?clpPWTZxdjBabnhZM2E3UGpHam9wYVFiWEZHSGh5OXlYWURvWjlRUFgvR1Q1?=
 =?utf-8?B?NzBRa3pUWm00Q3ZzdUw4bkxlRE9mVmlicVF0VWNPbERQb1paUTcxQzI0VnpR?=
 =?utf-8?B?VnM4TFpoTmlUaTBiVmdwN2JXVVhUQ1hLQlo3UStXeDY4LzR3NVliV0V1ZFJi?=
 =?utf-8?B?QURuQUZwMmJ6akdiY1VzcFcvd2hMKzBpZE9nTWJFd3JWRXpXeVdxMFJMUFFP?=
 =?utf-8?B?NjV5QmZ3aWM1TkdRY1hFWXJnNGJRV1FUTGVCR3RIRldpRXRPUFF0a0E4ZzMx?=
 =?utf-8?B?VGcvVG43c3VWWlh5WmlXZmNUbWFlWFhFUVVCczF3M2gyRkQwL2FBSXloYmUx?=
 =?utf-8?B?bWZYbTI5RmM5TytYV1FWYXZ4VFhIZDN5ZzQ5VHMwNWRPSVdwUVJCTkJGRHJS?=
 =?utf-8?B?SGxVK3FFOGZZNjdNQk8xNzhlaHpwUDQrK2xiOUVTOFZ1MzdIWkpOYWk4T1dX?=
 =?utf-8?B?K1dPV2FtQjN6R2pIU05EM3VTd1NFSkhrUW1nY09KbUxJZldOOXVLaUg5SnZw?=
 =?utf-8?B?T3ZPSllzUGE5K3JyOEZNcFBUSjNxc1N6dEFIY05xOVRBY1VlWTVzTmpiV3FW?=
 =?utf-8?B?bml0OEhMWUFiWnFlbVByTEV6ZjU1MGFsTUEyL0gxR0RwNnZmSHc2RjlJeVNE?=
 =?utf-8?B?Y3c1SGlvaU9qeStoZXl5ajdXSm1DelpMMlRrSVo3RVFRZ2VXdlc5aXNaVS9W?=
 =?utf-8?B?K3MyUGdPSWIxMnZiZUl2bzRIUjY4YnpnZndaS0w3YjVvL3VLcSsyZmlHcUhY?=
 =?utf-8?B?M1lwTWE3MHRyY01qN2Y0cWNwRVd2Rit6UjlONzJJMjZ5WHc3SzhXaVBMdkVB?=
 =?utf-8?B?Ky9FRkpKQjFwYUlWMFlnOG1nUjh4alFjYnJRZHZYTy8yN3ZZZ1hrMFE4STRa?=
 =?utf-8?B?U2txM2NtbU9BU3lMcXVnQjVpSkxtSHB0alg1WE11Zk5JS3JjVllReDV4dy9B?=
 =?utf-8?B?eW1pUlpJR25uZUZkcTd1ZlBIRW9Nb2U0WitvaDBmLzhOTWMyK0JVV2dWUDk2?=
 =?utf-8?B?VG1PVnlqcWExZDVrWTdvd2dXVHZBL1BqQlgyeC9mWUlxbUJOVFpabzQrcHUv?=
 =?utf-8?B?VTRPYTl5aG15SmNTbVA3MGpmMTEyOHh0REJYZjE4TllEWjhwSkZWanA2dkhu?=
 =?utf-8?B?bXVyeUo0QkMvTHNyS3pmUmdFZGoyMHo2MHRiSVE3U1dsRW1jeGxEMXFuZitn?=
 =?utf-8?B?bTJFVGlPdW9Od21kNysrNElOd3MwQlRRNkI2Zm1iZFZIa3hJTEttQlFEZ1kx?=
 =?utf-8?B?Z2dkMDUxdWxweitReGhLV2pwZ3Jmc21iNWtKemVBRDlqVFR2WHUzYXdTS1hQ?=
 =?utf-8?B?UDVUeFVXUXRLbTQ1NkxIUGFuZ09yZXltRHR4UGNsVW0zVDdmc0JLTElJR0hL?=
 =?utf-8?B?bWVsaGpSbmZENTlzdVFRYzduUFRUZDlocTNrZHpKbml5elR3T1JRWTY2aUd4?=
 =?utf-8?B?S3lkVW5DbnpkK1RwaU16eDZxd3VyQXEwS2lLVFhBV29QbzRPazRYa2QvelRK?=
 =?utf-8?B?UFVxWVU2WER0Q0FTL0VwYUh2bHBvenVTc1hyTFBEL1QyRDR2ZG85ZmhiTDlj?=
 =?utf-8?B?d1lIU0Z5VDRJbG1wV094SDBQc0h1Ny9scGt1UkdWRXRJbDBhYjNtbndRL0Nz?=
 =?utf-8?B?L2xzUFlqcXliSjNMS213bEk2VlI4TEdSbDdBTjIwVDJGWnV1YW91eWJQeTBj?=
 =?utf-8?B?bnhRWDE2QWtHNTBuNUE1MW1nVG1Kd2x1RVNnZUtKdTJOYml5YzZqK0tmYk9F?=
 =?utf-8?B?elFibEducjlKM2VQdGx3VmRFZ2FzUHVxb25MQ0ZTNlBVQ1F6TnpEeW1hYnZo?=
 =?utf-8?B?Sk5wVFpsMys3bEVmY1BSMnBuN2grSHl4dXJXTVFudTlHZjM3WE9kMmVCZVpH?=
 =?utf-8?B?SHhYbUJMZ1lDSFlER0NRaU5hZXh4RnlEb09yUjNvdGNHcDhjTENBTnlDUkVx?=
 =?utf-8?B?ZUlhcDc2TUFFN0s1SjNWNDVxdEk1aEk5U05iOVFkV1R2OEk0ZlVUdXZrd0pS?=
 =?utf-8?B?T1R1VURaN1RYQWNGWEFGTVdjNmpnSE4xRWVaYTVRWWRjUER2RlphcWhvMUM4?=
 =?utf-8?Q?437H6rFhwiTFjqWdST?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020dbce4-394e-411d-79ce-08decc8cba79
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 16:23:13.1405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+HgtIofK2JpwTY4SW3brwagUx9c8Afe9abAlBR2VDp0GoKk0CeehwPK/6G8g7qR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080

Hi Andy,

On 17/06/2026 15:52, Andy Shevchenko wrote:
> On Tue, Jun 16, 2026 at 02:15:56PM +0100, Salih Erim wrote:
>> Add the core driver and MMIO platform driver for the AMD/Xilinx Versal
>> System Monitor (SysMon) block.
>>
>> The SysMon block resides in the platform management controller (PMC) and
>> provides on-chip voltage and temperature monitoring through a 10-bit,
>> 200 kSPS ADC. It can monitor up to 160 voltage channels and 64
>> temperature satellites distributed across the SoC, with a consistent
>> sample rate of 8 kSPS per channel regardless of how many channels are
>> enabled.
>>
>> The hardware also provides four aggregate temperature registers that
>> are always present regardless of the device tree configuration: the
>> current max and min across all active satellites, and the peak and
>> trough values recorded since the last hardware reset.
>>
>> The driver is split into two compilation units:
>>    - versal-sysmon-core: Channel parsing, IIO registration, read_raw
>>    - versal-sysmon: MMIO platform driver with custom regmap accessors
>>
>> Voltage results are stored in a 19-bit modified floating-point format
>> and converted to millivolts. Temperature results are stored in Q8.7
>> signed fixed-point Celsius format and converted to millicelsius.
>>
>> The MMIO regmap backend uses a custom reg_write accessor that
>> automatically unlocks the NPI (NoC programming interface) lock
>> register before each write, as required by the hardware. The regmap
>> is configured with fast_io since the underlying MMIO accessors are
>> safe to call from atomic context.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> with a caveat of using namespaced exports (see below).

Thank you for the review!

> 
> ...
> 
>> +EXPORT_SYMBOL_GPL(devm_versal_sysmon_core_probe);
> 
> Please, also use symbol namespace.

Will use EXPORT_SYMBOL_NS_GPL(devm_versal_sysmon_core_probe, 
"VERSAL_SYSMON") and add MODULE_IMPORT_NS("VERSAL_SYSMON") to both 
platform and I2C drivers.

> 
> ...
> 
>> +static int sysmon_mmio_reg_read(void *context, unsigned int reg,
>> +                             unsigned int *val)
> 
> Make it a single line. It will be more readable.
> 
> static int sysmon_mmio_reg_read(void *context, unsigned int reg, unsigned int *val)

Done.
> 
> ...
> 
>> +static int sysmon_mmio_reg_write(void *context, unsigned int reg,
>> +                              unsigned int val)
> 
> In the similar way.
> 
> static int sysmon_mmio_reg_write(void *context, unsigned int reg, unsigned int val)

Done.

Thanks,
Salih

> 
> In both cases it's only 83 characters.
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

