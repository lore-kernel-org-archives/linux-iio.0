Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6A21E8320;
	Tue, 16 Jun 2026 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612264; cv=fail; b=G0+0SBFo+5+Eu5dVb7OThIwXV4jo3sL6hAAR1/vmpdxKeLltrlklk+Dn+X+PzmOjbzni5dHPsDukjIRWVf9S1N9T958pVwQ8O0iJMv0VTH8JQE/kpcB5A/YE5Ge1Zxg5UnCtD1toRralF3Xac+9Z9DfWRnKsofplgYA7WXvMk2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612264; c=relaxed/simple;
	bh=otlClG/0otOAui9zW4x8QVUagMcLwxsrIvW36UJr5cg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JG+BfHw0ZzWcBVZJ7XvsqHyU1Ky/QeDSmvKEn+gk5+6X9AD1BHgya+zdhpGZjgypLufiLJb9S+HzAmdMpyND2WflJPTplmOea5OlFujnsekg99J516Jt8blIl+1S/OY1rRcu03crBhCUtgev3CMppknwnXYci2PYB8bLu3DzpA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xat12CxW; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xat12CxW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f29+Ay8b8x7kK9WiXvN5L6z2t8TtVj8hRW64DXMZQL3g7BroqkSkDODPaJcWkCDoEuX6NbQrpAwFwRVZJ0FCLeRmLcBUT6TAUPSrks2Mvmcw5Vqkd4yDe/GWwnRi/OqoM3LXEcyhQ9le0NAIQQvGVjtjShpQnIk9immHsUnG8BE6882DEhF7Fz/xr46oNpYkpUyWLJpgc7wAvfUQjI8fQFaAkB5h350h0TOuK91+TN+XtRIj/IR2ZbK8Z/hhDueVoWKJDh/9QGiQPzqZbTk5ownuCL6xhoIXYHjsLPZJezzy16Sr8gvDMcD0ifw5V8II6DgiKMFZtUK8v0mjgSfN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg9nJw+jZBkk5kTAn9rrfmsvl+BNBbFpmuFxEgDpY6A=;
 b=eNm5MCYHNgjUuDsY9lYYn0a9rb7m2aeVt9hzykiLymfCtwddec1Z0iiAHeEP+YiX1JWdcE95zml5oVa0urYFz8ELUoFJ5vegOZej92keWu9O6I3EjEqyhGA2rPqcwvy2ZTWWkHUeMUl/sfnW7Sg5n4xXQfJOjGeTwM3pvYvoOG4ZA1kLDUOtP4N9TCdxLO8LYQ55OIMxXSktrHT+uxgOSfamlw14FuE8O9zt9pcBDE+EggO8F9Jio6tZOz4gUXCdBojpSTj4BNqIRqtXlhJnehTDgg4actdXHnEdsghynswHy6Hi4/iw5WKTssKod0VN7mlHhmrDnuB9IGhIFJanLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg9nJw+jZBkk5kTAn9rrfmsvl+BNBbFpmuFxEgDpY6A=;
 b=xat12CxWwPl4yCeF0DQ0nweo7eWuIpe49YjCN3m2Xw3aBfouGZSHMUtIHcvPZqRZQIvC3WXrNuf5kGXen/yqIYH3zz1ewrSP8EjoLmr9xkxjpBQsNI7XYIZYaXr3UfkRhv+cbIJCiJMQuXpRINsmM2wZVUcczShXeO9esJPR14E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:17:38 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 12:17:38 +0000
Message-ID: <2b5db94b-beb0-478a-b3af-35f355ba6b55@amd.com>
Date: Tue, 16 Jun 2026 13:17:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] iio: adc: versal-sysmon: add I2C driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
 linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260614233722.2603459-1-salih.erim@amd.com>
 <20260614233722.2603459-4-salih.erim@amd.com>
 <ajAMjZzfTqplts_B@ashevche-desk.local>
 <15d14eee-8384-4605-ad83-5aad774541ac@amd.com>
 <ajD_MMpiVQIwtbV3@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <ajD_MMpiVQIwtbV3@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0488.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::13) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 60540ccd-ec61-48b8-b200-08decba1411f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	ZsN73ETfd44EanWKJJO7bdRmVgEQyafieTS6K81/0EO53Eo8wipb3nym/Y4gMuDqOrZMc2obg6SY6AJxIfabSwZ2mYy2I0fnN951WzmWdd1/Jrj2yRN+fOWvQKqik3j+AkXUwlhR0z84VM0kccagnCcgZqddy0CK4wEDjlculE8nkD3WcImMnJn2hcAcG5GgrLiblNPzPdyggiB6hWmPEpPs57Tj8z9qBd8eS65ASjbBGLJVpkR/2XWcbnHLOhQjMS5ckJPPMkPPmNHP/UtTKtDUOgrnRJv3/W4vpBDReWOlBOhjMS+P2nxhy0bADPaC24jbaQhAK57hFIrc3BEt8s2FxvajjIghXY35rcgNAzbSqc+xgZg3aeqtAC9zDNtyp7FkLLPCIjxLWmvbm23q6kqkwjPsrWC3e3Dn+WCyYt2QVcQHD7vG4b9RPGylgIZMOL3wROEE5aRLVZoBup4CwRykoeYWvc0TLCD2hu8EOmSO0sQQVpcBntFKbiOAMLUdFRjwFSrbZlMoyVZHFX2y0+aH/R5vulNCqemKYepnFhhFxe13hMJPtuObV2eF95TIaUPOONDtdeYVlY3ccYuFdy8TQryvCuFGBvYGac3BFMPZY2PQ1iPmeSRmZfxF9g/NasGdtbe6FDXB3owiIcyqrF6wnC9H9SFCW6BiKHLl3rCdNPfIwaFtYTWhj1kKhOnm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU5FUnBiR203OVhraC9lT2tPaEJDNDZHRHdDMk9yaWdPdjhYdlJCKzc1RHox?=
 =?utf-8?B?dE15SWNadDRXOWpzU3UwOCtNYkJNTzZjenRmTi9CV2lzVUN5VTRDRWh2OTc0?=
 =?utf-8?B?OE0rQXRwZHNQcnQ5WE14YitXUi9QMXF4Mkg4eVhlNWR4T1ZSSU5IV1pFRXVo?=
 =?utf-8?B?UG51cnZlMTBSMjk4ODRXL3BQNE1mWWJROEY4Zk9FVm40ejNsRDl0b29LZml6?=
 =?utf-8?B?SWM0TEFDQ1JlLzJ5cHYzZE0vbTBySjF0cFBLYVBJdUIzTGUyWlRscEE4RDNl?=
 =?utf-8?B?aHB4Nmo0VW5ydHB1bURSN0Q2MnRpODBCVFEwSm1SZUFuQ0VvR2lObXk3bFdT?=
 =?utf-8?B?Vm5FODdIMVYyRlBYWVBFWWNIVGN1L0lKWm1lcC9wZnJuUk40Yk52Y0cvbUIy?=
 =?utf-8?B?Unl1QkFVckVuNmtTNkozcnNjYitqM0kzK1c1cHN0Y0Z2WENIcldWQkpFTW5o?=
 =?utf-8?B?ZTBJSEhLWkFlRExKVFZ0TkVqVEFYMnpja2lpUk1KZ0EyUjRGNmZyQ1ZzZktv?=
 =?utf-8?B?M0RlRHB6cDZpbk9IUXV3bU9pejdrUnlqTzRrS1I0K2xnMXJqQXB3TEs3bUpK?=
 =?utf-8?B?dXhTd2VOVW9MNlRUNVN4dy9vTHVGeHRlWmd3V2krbjRuRzdRUSt2TjJZZ3Ey?=
 =?utf-8?B?QVhMVG1ndkY2VUNIWi8ra0NxTm9COGZiaFZaR0p0RkNPU3B1NkJMQUsyWkZR?=
 =?utf-8?B?bEtjL0xiZTB3Q0FZNXdlL2lHakRtUFZyUXFqVXhvdVlrT05KQ0ZWU3lqV0FI?=
 =?utf-8?B?cGp3QUpCYXNZejdCcWNjVnE4ZVB4c2FoU3EyZzhidWNDcXdwWDQrS0hPeUlx?=
 =?utf-8?B?NnRrWlRnMjN2SUlvSzZ3emV3M2FhTU5zcUp0WFB6TnZGWUQ2bmhQZ0FCclFq?=
 =?utf-8?B?WTVUTDRlS01ENVo1RmNBdkhTUEhQNXBSZ1gwTVArV3BaMUIyVnBiOCtCZEo1?=
 =?utf-8?B?QXo3NzEwQy9neDUyODJwb3Jjc0FhNGoxcThTdUg1eXE5Q1JPTmxXd2JwVTFC?=
 =?utf-8?B?U0dGelByZkFnbGpCOGJENVllZFVacHFKR0cvVldPWFBqTDBuNExrdTRMOHlx?=
 =?utf-8?B?VjhmWWpZblFYRnNyTzhFaGE3NE9DYU1Eb283cDF5K0Z1REJ0NDdwKzZvS0wv?=
 =?utf-8?B?REYzODZHc0t0Y29FVE9FSUVHT3Fvd3ZlSHFkYU02YmE0eUxRSmhMeDhYNjZz?=
 =?utf-8?B?SzNzZ2UzWjRieVhKaEVrSnlHaXFkVGtOekY3Z2piRjI5a0VoTzdaNWQxODl1?=
 =?utf-8?B?aVprV0s0TGpLMFlmekZiL3lZUXZmcFJRV2tTaGRxVGg1RnFkU2lwbTRYMUM1?=
 =?utf-8?B?c0xLcHh6M3VrZzRXajBZQW1kbVg3YkxON2hob1VEemdoSENGM0VzRktaelhD?=
 =?utf-8?B?bC9GckJkWVI3UllrNHhFTENyeEtSd0hjWWVqS0pSdWN5Y2JvK0xJcUZ5bzFv?=
 =?utf-8?B?Uks2L2FmVVNJbHBlSzlWaW5ZdHEwbWMza3hMN1J0b250R2dmQ0szekNYZ1VM?=
 =?utf-8?B?Q3YyMWVrM1ZTKytlaDJOSHBKRWh1blVJQTFGaXVSSnF5M290NHpYbHArVURp?=
 =?utf-8?B?M2xHM09hQnpjNzNrdWUzMDNONTZ0VnRTVUxOSC9xN2hSQk5peUtIRlpzUFZ5?=
 =?utf-8?B?bmZYb2lDZFovUzZJa2pFSzdrS1hTVUxiMm1HZG0ydzhkc3QyZVprUUxtcFJ6?=
 =?utf-8?B?dVNFR3JoK1JGUCtuSkxBOGMweW82ck9DYm1WUll2SmUrU2NyNUIrR1RIdmRC?=
 =?utf-8?B?c21tOUphSTVqTkU3amRxTzFNaWZIUE9sOHUvaXYrNHVnYUxjR1JXQ2pvVnUr?=
 =?utf-8?B?UlRnQS9TdzZqQmJ6RnlHVGxHSlMza09IYUxQM2JSREZuSHpuYnVKWTB0RUhj?=
 =?utf-8?B?ei9sSnlraHRvWFZDSGY0b1JEUEFvOVNySUJIN0ZWNktDZ1NpaWQ1VG96bktr?=
 =?utf-8?B?a09qNlRIbG9VcHVYNzBOdU11M2I2VFMwNGltYXNmS0RhUEtHellUaXg0MHVB?=
 =?utf-8?B?d1hYZ2dobjZRakpJRTBpQUdmUldmOVJ4R3lQT05XOVJFQ1ppQVBNQkdvTnJa?=
 =?utf-8?B?bDVpaDNaUFlWL0hvNHdLQXBsR1FUdW03ZlhobzVLcjZvblhnb042ZzN3eTFS?=
 =?utf-8?B?QXYxd3FCazFzbW5JOUZFeGVYNVo4NlpFSDQvTXBTK3dPZ0tNY0FOdklKSjNZ?=
 =?utf-8?B?OFFFd09Mc0YvVTNXWEZ0SW4wQmlRdDRxNVZmU2cxN21jbXA5cVdzdzhrZXlL?=
 =?utf-8?B?bUVvejJzUmVIdDM1TGdPbHhqMU12VWZ4MlFoQTBPZzM5RzRLTTRteDJmYUlJ?=
 =?utf-8?Q?Xdgobj309oXs1FqH2w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60540ccd-ec61-48b8-b200-08decba1411f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:17:37.8681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/dHtWARtjDC29esBbPr/JBCGM7CCSl08fbdh2jVmn7Z2lq1OIq8jzD+cah2atdk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189

Hi Andy,

On 16/06/2026 08:45, Andy Shevchenko wrote:
> On Mon, Jun 15, 2026 at 04:42:43PM +0100, Erim, Salih wrote:
>> On 15/06/2026 15:30, Andy Shevchenko wrote:
>>> On Mon, Jun 15, 2026 at 12:37:20AM +0100, Salih Erim wrote:
> 
> ...
> 
>>>> +static const struct regmap_config sysmon_i2c_regmap_config = {
>>>> +     .reg_bits = 32,
>>>> +     .val_bits = 32,
>>>> +     .reg_stride = SYSMON_REG_STRIDE,
>>>> +     .max_register = SYSMON_MAX_REG,
>>>> +     .reg_read = sysmon_i2c_reg_read,
>>>> +     .reg_write = sysmon_i2c_reg_write,
>>>> +};
>>>
>>> No cache?
>>
>> No, the registers are live ADC readings and interrupt status.
>> Caching would return stale voltage and temperature data.
> 
> So, basically what you are saying is this:
>    "All registers are volatile in this HW."
> Or alternatively:
>    "Almost all registers are volatile in this HW. The rest is not being accessed
>     too often to cache."
> 
> Choose the one that fits and add on top of this regmap_config initialiser.

The second one fits. Will add a comment in v8:

   /*
    * Almost all registers are volatile (live ADC readings, interrupt
    * status). The rest are not accessed often enough to benefit from
    * caching.
    */

Thanks,
Salih

> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

