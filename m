Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99CE438FF3;
	Tue, 16 Jun 2026 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611962; cv=fail; b=VvN3sWTAd997POmy+sUVy0H3t2zTQFJ3hiknmrJf/sQHNyeYSLaObOLdqYRVckgAFGfHYgXVXinQZy/nAbUDXyVz8aQdk1mzqroGFQ9g0uaQHN25UiNQTRlUm4pSBMKumeDPLyzPAwrDM4YK+ijxxEMOvoLOosubH5JuTKIcm2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611962; c=relaxed/simple;
	bh=P5hcl0bp8GvsNHBsedI+6CcSf/Wn3tLzCYZqe8vQuQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rHkN9a731QyjU70ocKfXPsS98ZrTNUI97cB6aM5tPkDTtu/8JpYRADaXMAa3JSV+QzD0g7ocSF3usvHpaOFRDs9N4bfj35UNyva+SQQBmS5uWBrkB8R11BcezITT2QOVM6WaO1BD3mcDRJQBjr5hBQY7OtvEjoqd7Uh13dLR4Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jvmHKzHy; arc=fail smtp.client-ip=52.101.56.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jvmHKzHy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3FSYXEVT0Snjv7GGAO9B2joWioK5xLzSRsM9JTO2hMqrvdseU/a2v3+XlXE5W9c+UfLQh2si8OHc/AmhTZZ6RjltK6SMBDaN9DDTsuDJNLejq9gloh6XhmcVekOCj8NkdRoHPNqWVkkgATLVnXbF8/A328L7vKqjyKr9xWdtqNKlc4sYYIzw5knpAzIbaGPCyueJVQ8mjaenM+ZPfVOA2ThmYHZ7MiZJBZR3w56Xtb1qM96tg3riH5kvhUZfFkz5g3uNWUx4q2p51AEWpOpcTZzG3P/VBbB+9UfzawNLu6mKnt6H2jA14mCfUboHRugsAARu+s1nPaOn/7c9/A6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0Fbvv3+lZ2wPeCVG3dVuCzMpp8sXBrFkG9ADMLH4Nc=;
 b=GCi+FnYpTsQQErqV2mVHXYeJenajUHv14kKK55IhY+Zg3UckPWZVAtzUX3oVt8Y8sGlOuQ2QGENXEYwpAv1mOclDuWYFDtQPlgMVPUdm2nYFKkS0Vrt9e0eh3eDsUsjhMlmaZQ0JObqwGXK+t9+qMD8+Ah1O8RxaetCYR8xyDDtHLmnRGV3k6dkcibk6cRJds+ggGNmbsk63OebcxeCWbDhN+k2ahyl1q+g+77PuonOT8pbguzyo4hNUzRtf1WmdlqbaNlB/5LcQZjXV/dAy1qeicXhKn6EuwFMgjwkZrG4iJBPRS42aJL2dvHjfe2Hhoq//7iZJzW21LuXMVOd5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0Fbvv3+lZ2wPeCVG3dVuCzMpp8sXBrFkG9ADMLH4Nc=;
 b=jvmHKzHy9mU9BkRKh2wTFWxcYKDzbIGpvH2B6Oti42URqZj6U0HJPLjkED9HmHSaCDTg1pxO7CZbc0SEKbH7W0atat4fLP2PzcLHdrneENTKsvh4OvpliGm3rpHa9xHvMVBGQqoqvKQQznVydp7VrCi/0NQ+DQ5n6/3LptaOH+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:12:34 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 12:12:34 +0000
Message-ID: <2b3d95ff-cd1d-4a1e-a9ac-66df9344cb5d@amd.com>
Date: Tue, 16 Jun 2026 13:12:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] iio: adc: add Versal SysMon driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
 linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260614233722.2603459-1-salih.erim@amd.com>
 <20260614233722.2603459-3-salih.erim@amd.com>
 <ajAKkqMO5jdQjKgS@ashevche-desk.local>
 <2998a9fc-4b9f-49bd-8020-697081401f85@amd.com>
 <ajD-iS3nANaXOZty@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <ajD-iS3nANaXOZty@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0493.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::18) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ea0a0c-06f8-48d1-8b2d-08decba08c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	ONAa0UOFuINgxrCG9j8nEVzWT3DUEUor/U12Kbtir0U/1voMH9h2KJG37jqnlEgBpGO/hDAm0Tdb8zNZRbpvpxFi1GhMtxocd1504fRbKTWMMFNW8Ke4w1kMHQVwT0JJ06tQdw9eQ0BYKD2zQBJqL/w1E/pZqEGHmrjtkd88i10d1Xm09EFCkZxuioa8SEqjs47tTfBmOnFKeQDRTPdRAtZuKDkjlITMm6NEMQKkmy7Dz+QU3Gdlf6MChHO0BjKRzlk4a8AHu83JC9tnRkM4O40H9Onpp7Trq5uJTcfYdz9yQJbLew9gi5v78hGuTO474VlnPf5SSws0xLqyWeLCwed7F8CRwly5XfPtbFtrPj6CHQx18U5dDZg7WNyThHg5LaF7ZGDBJvhVnIBygpUFbOaPZjPyz4U9jkWDR45c2Lmm33EZ/OQgbTvxCL6n0Yij6vMkSzGo/8xWYebxqivxSe9etrbCxgqRPCG6iefcKYlHP7n3YL+wyFqqg3mDw7lspsdTtoJaScfn02TUjYu94B/s7Tr8gLc6xo3WxNZSl9cMMKO1KCEepaWa0UMhI20PKtXXdfcbkDm1TigsL62AfhsTpFY2G/7xsEb/0l8Le6fSF10BIr8lT2mlmibMog3xXv4H1vrnBSt82B1/YZrDvJozrmjYwYVmra9UAV55IovYfGpat/oZgLZS0NmRrCh4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2dsSUZOeDAxQjZpMkM5Q3JKNWdjek1TTzh4bWFrOEdRNjU0ZVArOUZYdk5a?=
 =?utf-8?B?b3prUzB3K2dEcy83cHVBWWtSTmoyTi9hK1lKbVV3alFxMnBBeU1VejROeUc5?=
 =?utf-8?B?L3dCeXErb2g3bGJlNEFSdFR4bndLU2lQK2daUjBTNVM4Rjh6NGVteFl1eFda?=
 =?utf-8?B?YkZvNXBGVG1OYUlwclo4bktJcEFXQXpkUjduQVBHTDlnOWdOSlVlYk8rVzM3?=
 =?utf-8?B?RVptOFhpK0NpNlJwVDRURHZuenlrNXZHZDg3N3k3K3hzVm5PR2lvdFlDUkVR?=
 =?utf-8?B?UEhxdkVpM1BJT1NsbStXbE9wL3VGcktaTGowZDZqcld3VkRaL2ZIWEwzdDFs?=
 =?utf-8?B?Vi9ibUVRMHQ2QmJPaVVvQlpMOU5PTW1IMUxzL2E4Z1NRV0ZKeE9IWFRRRHdz?=
 =?utf-8?B?S21tK1J4cWo4dnF6SisrcWYwWGZLSjBaTmxOZ3hXMmQ1VWwvd1FqcEkxaDEv?=
 =?utf-8?B?VC94VEpvU1ZtN0xxaksydE5JMFA4K1J5RWszelN0S1ZsR09JYU4rTmgrU2VX?=
 =?utf-8?B?bTNiVHFta1Zwb3p4YllIdWJHdWhVZHp5OE80SW5vOTQzcDl4ekdFM2UyVG1O?=
 =?utf-8?B?SmQ4cTA2cVlxMjdNWGRFSXRBTTdqcFJ4Wk96c3JNcVFYemg0V2JmelNZUEYv?=
 =?utf-8?B?NlVnL25GRGorRlcxcUZkSHZ3V2dnU0VWS1NYM2MvT2dRU3d4a0JzeUIwRVcz?=
 =?utf-8?B?a28yU1pIWU0wMFFIRzd5YTRXeXZhTTM5Y0V6Tzc5Q1dFbzE2elQ1SGJONGY4?=
 =?utf-8?B?V0JBYlpMWmp5WmVoRTlldEdIUmVTZmM3VXBTWjhsYkJyZU1YRWY1UVVsYmRX?=
 =?utf-8?B?MEl0RCtoSWtsMVAyNlZhdzJwVlhDUE9MT01YRWZFMXd5RVJ4MkxJYTZYNmlk?=
 =?utf-8?B?OHlFcmdIazAxT3VidVNBY3c5bUhqdjBoZ1NwTXFQTFg1YmkwcWNkVWYvSmpL?=
 =?utf-8?B?TVZybGF2MVRjd1BZS1lPdEE2aGJ5RWt0Q0FMUk1rSVl6cm5oRjVNbVJKa2J1?=
 =?utf-8?B?YWJudWZGNFZPMzZQd0J4SDVWZUZFNXoyc0dkS014YUp2UFVXemM2VWhENU1I?=
 =?utf-8?B?blAwdHFSWTh6TGdEN0Z3N3JXdlNjMFZRSXJ2WFh6Y3BZVTJ3d3RQVFdJNHB6?=
 =?utf-8?B?cWhwZDZUVzNkMTJuSFpNVWVFUzIycjhCK3ZPZ0Zhd09WMW0vTHdlWEs5MjFT?=
 =?utf-8?B?ajMvZ3RCeFQzdGF1UG53U0hya3JNbTFFK1NwbXpMdnFzSTNmRDI0MmMxMnlw?=
 =?utf-8?B?RE5Pd3FDUThwRmQ5OUNETThoamhxOW94QUl2RCt4VnhrZm1FTnpjVVpCbUVp?=
 =?utf-8?B?SW1yL1RMbHA5RGd3WjB4OG0vbWxOR3VORjFoQXlnd0Q4R0psMms1SEI3c29L?=
 =?utf-8?B?ejdyQVhHWGVHSnhCcEVlR0lvM041S0FlOTZRUW03RndPK3ppMzZ2VFNtK0c4?=
 =?utf-8?B?eXU0SEpBemkwNVF6ZlA2R2Q5SkFMdnIxZFJNeXlpdFJ2aENHT0lBSzNSd3Jk?=
 =?utf-8?B?M0ZuTE5oRjJFN3JHd2srU0Z0a3VDRDNBc0NVYjVPMzVNSzVHTEt6aUN1YVBh?=
 =?utf-8?B?Wk5kanF0SS8wK2xlK0JBQzRDdE1UYll5MUJoZzY0TWpmaWV1Y29HQWlNVUp2?=
 =?utf-8?B?YURSR1l4dVJLTk0rUFRMRWZDbGR2NldSbUplYmVRdnEzZ2NMUGcxUDVEczZn?=
 =?utf-8?B?Z3dubitKRzNqbXBPaVVXaHhRMjFxTUpFM1hTTWVCRFlmQ2VWRGloY1JncFVm?=
 =?utf-8?B?ZUtXaTNTVkdybXVNeTFWZGtvYjFVVTdaeWwxSlNib1NPL1laVnRBOUpuazNR?=
 =?utf-8?B?eHp2VG4vd09VYnZkUXNnVUFWOHJ4QVpiZXEvZnBkMzFSbXgyWnRoSGtBQWRq?=
 =?utf-8?B?RlNqb3lRckVoRHRKTzJEdSs0YlM4RlVWTDRGeU1MU2pUallOTmlYbXhmV0pX?=
 =?utf-8?B?b2llclpPbXczditaK3k0K1FoQ1NYZXkxV1NSUWpWTEdPckgyS3pYbGNFVnJI?=
 =?utf-8?B?UlpCaE5idit5eG43YXkrT3g3OXhtYm5kcDcvMFZ1T2NlWVJSYmZ3bWpCU3Mx?=
 =?utf-8?B?SE5xWGN1YnFETXJVVlQyYzE4ekFlMVI4NHI0QVgrcWxSQllOL0YrWU1YZVRl?=
 =?utf-8?B?dlB3clA2QWgwRlh2ZHdBQm9URnBwZm93UkNDak9SWVV3T09rcnprb3JxV2Jv?=
 =?utf-8?B?UUFKdnEyRjlyZEM1MHlaWEt1MHhjMmNNT3hpNUNTb2JXZFRzeHNDZjg2Z2tU?=
 =?utf-8?B?bTBqYkpUeHhiUnBsa2ZaYXhESEcyUEFTTUVmaXRHOVpSNnpQK2pyRTBWR0M4?=
 =?utf-8?Q?ds8inkQbIM29MCjEZi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ea0a0c-06f8-48d1-8b2d-08decba08c64
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:12:34.6552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJBCwjm+FJ7BQCwDTR50gJ7Jdwm0dxb6r8QwQvuJmNQXn6TUjXNCQrLeiWbktTHI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189

Hi Andy,

On 16/06/2026 08:43, Andy Shevchenko wrote:
> On Mon, Jun 15, 2026 at 04:41:12PM +0100, Erim, Salih wrote:
>> On 15/06/2026 15:22, Andy Shevchenko wrote:
>>> On Mon, Jun 15, 2026 at 12:37:19AM +0100, Salih Erim wrote:
> 
> ...
> 
>>>> +/**
>>>> + * sysmon_core_probe() - Initialize Versal SysMon core
>>>
>>> It is managed, please name it accordingly: devm_sysmon_core_probe().
>>
>> Will rename to devm_sysmon_core_probe() and update callers.
> 
> I believe you also want to have a proper namespace. The sysmon is to broad.
> 
> The easiest solution is to name it as devm_versal_sysmon_core_probe().

Agreed, will use devm_versal_sysmon_core_probe() in v8.

Thanks,
Salih

> 
>>>> + * @dev: Parent device
>>>> + * @regmap: Register map for hardware access
>>>> + *
>>>> + * Return: 0 on success, negative errno on failure.
>>>> + */
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

