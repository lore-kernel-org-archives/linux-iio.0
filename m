Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B103F23A6;
	Wed, 10 Jun 2026 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092035; cv=fail; b=hIbaP3o9TOCCdop7OHhRybFa5iA7oQTRyGz+twOjWdhc3WADOLgxWgvAUxEA/J66Ase6K0K3bCSZ+ZwwwJwsnA8BrbdFL42ub56FBPtYBp9E9gPXc0gjRWpzJRbmBY+qI4SVIhRrv920ScMoFFqI6eBWhnLckPhc3oJLv+5DyM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092035; c=relaxed/simple;
	bh=yWIkWComVd9cjKBG30/VxocoVj+J7Ia+YtDy7577lOc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HJokGROYYE4Sss65ezexohs6J0pQWdzi9hS4xdHVNrMqGAGetYk8uFShRsh30Ip5zsQ8lCqGitOp6HyAoVRBP1f0B5PiNdjQba+3Phiq5zlZkrYFDLtVW0O+YGvUiHQ8ob2Yjsro4IHoI8/N7miCAX6wUEao6VMUDzaAj13zTbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rcFTZ3Xf; arc=fail smtp.client-ip=40.93.195.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rcFTZ3Xf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFqay82S69tW8obZcDXxXIH1Ax7onw01sCfXVAULtWVvh5hMCqDjmEbcWbGWtCUNI+vT+lbxhbOW1/Oy3WIiKct/w+OOmuGQS2p9Es0vAeESfnKbWIueH+Oz+YCZg465InCmvxFYxxEThPzFrfxePAEmsZise0lviHQHQns+OwcA1enlo/8teSDUGWMiS1OIg1mlrtk9qsKNe8P5rF6nVmFzP3SZY6UKgo1ktIKnsMEeHYZZc1w8bvJKBCBSlyx9/ujJ2xg7ujF6FNcpJFkiRqnWCec/eq1trgWWGCeVZFvPLvp57+NuP0ACqJLCpDSM4K4MjOhRp/9w2xviRXReuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1Uhtgeef7bqqrkTRXVGWYhPxWcpehLhu5u5WAGp514=;
 b=Afg6pBHaorXVl2RCKz/FU0k3gmB4JapqF8L5rVJL8SKjfLGDwJyyvzU9lFEU8PJAUIX3luhOr6kjmmdiDnV2NX6XR9psfRFAmOQOSLQ9rR9/UWjq3e9wOSrabYxaN2fxq+k1EpSDkxZb0ISfDgxeoCO77t1Xnpv4lnv4Gugrlzw6DRp3A+rUYc/iHABArVvm/aH5ensy56a33HOyzxyEtAPjSmXQ3LFmmyHKVeKZQVhXY4FCNewCx6a3EzXeXKlpWZ2MLSL4FRWjHDT+S97KE5nGIOC9WfYS/NT1qi8IhnLhnK3HhWLkNysgBtbir/l+td9pxsIriSnEm/b9brzdEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1Uhtgeef7bqqrkTRXVGWYhPxWcpehLhu5u5WAGp514=;
 b=rcFTZ3Xf7APUrktWC0tnpkhVaw2CaqwcCKd9zff8PDm8kD7zKtmXLtRqc7yJg0BPZMBGWOMpjhiShCANUW350Y/5huxHJsSrshkQdDMPYqc25i8GeRB+VW15Re9mwLvBKnOJh+/WCzm/bnM+K91N2Xw0r10t12lZFfOFeYJSA0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 11:47:09 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 11:47:09 +0000
Message-ID: <2b3b6577-d850-4102-a77c-8e0f82082a3b@amd.com>
Date: Wed, 10 Jun 2026 12:46:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] iio: adc: versal-sysmon: add threshold event
 support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Conall O'Griofa <conall.ogriofa@amd.com>,
 Michal Simek <michal.simek@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Salih Erim <erimsalih@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260606051707.535281-1-salih.erim@amd.com>
 <20260606051707.535281-5-salih.erim@amd.com>
 <aiUeVs_FoI9vV1Hd@ashevche-desk.local>
 <0f8f431f-af21-4bad-bff2-e6cde078bd41@amd.com>
 <aihN7O9noqEa5PlA@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <aihN7O9noqEa5PlA@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0072.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::23) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: e88e81de-0604-41bc-1070-08dec6e600cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|11063799006|4143699003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	tvu70NbgocJsirqNdenqvxud7aYOqpL5rZbwfjav+ezGI7bPnrjm1Pq7y1TvR6cSJ5gdQYzYxTSuNewk68lO1lufqkFslP48I3uW0FVTOp8pkIn6V8kXS2LKWHWtelkw9734uQAxrDM5v7KVyAmGg1qJGYpR6RtZeLy+YLXea5cO6GBvgsvqfJA/ZLEqM4i1qi4bvHtz0Arc9/0hkR2qnR+OCw0cZcDSBNHF9wSD3wAtYCUBeaQlXhUY8Nij1/LuIck5tpeAipaSKffeXLbL5zzI+OWnTmUAE+DDW9mUFkARe+/JN1UEtcb4lG7sLA+rTceutccg09qM7Mr/qsSFW9brP55FMte/p6AOUgK//O2VY3dnUQjFSnCpBaz3Px3NVG+Wv9aAltxCIoiHIbejtb4DwGNrFCi/hpWTFyYN6a+I8ZH+xTCSHxE73wLurawHDUGiyLYNbji1XyXQrW7svHP7XuBB7bx+hhI5w95n2rgaAIY/TDHQxVTtIigpopsDA6/yYm6ChBIBT93vysN3qha8Ag0QvPEs0sQGLumqlhivN1XjNeSMSYnWGE3jM+uqNEdzIhblJMDlLvKkpvetGo1xkQ9Ob6syMjp/K7ci9Js6wFEA8FwneNdiAuKpifNv05ubEOsdlpMLp2cspVSKLWwsWy+0+dhgH2dBfPG+C3c1NCF0iLccCR9sn32pU3hQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2kzNlJGbDJOUE5wRGdMN0w1cXlwMCtucmpTbUFLTDRiM3dLNGF6S3hPZmh4?=
 =?utf-8?B?STF5eU5kYWFsSG5iQVBsYnRnL2xXR0ljVm9sYUYrbCtNdWR5T2JUT1lUOUdq?=
 =?utf-8?B?S2J5UHNSYnhvaDBDN0dnUzJJVjkzblNhaDVYMUlJakJtRkhheDNRdldoWDNS?=
 =?utf-8?B?QXRRMTYvelBXSzQrQ3FadU1aQXVNc1hEc2NCNkNDbW8rdjBqNEN1ZDM0cTJa?=
 =?utf-8?B?U2ozbzMyWUJoUE1PV2pxU3NRT2dKZEpQOXNZSk1yeldqN2c1SmJEWEdQMTJ1?=
 =?utf-8?B?ckhkRmp2WFl4RnJhMldQWTRvQ2txcGFaK2ZNbU1uQjJ4Q0VuaG9oMmpvSm1a?=
 =?utf-8?B?WEo5WTZldFliajdVQXBjMEFQNEc5UHpDUnB0QzMwOTlqYnk0cGFzQXMvd21F?=
 =?utf-8?B?QklpMHdEYVVXWHRrMkU3RkdEMWpiYytBN2ZmTzBUY0pMVTI3NDc1WC91TkYy?=
 =?utf-8?B?OHhDcjdkWXh0S1RXTWJUVld6MGlJWnA4R2pIa2x4dkdEcFkzLzZyY2lOYnI1?=
 =?utf-8?B?UUR5bmJKM3lmcTU0aEFPQzE0dzFOcWZyWEZneVNObjEwMnNCSkFQMGlTeGYw?=
 =?utf-8?B?RHRVS2wvdjVuNzJEWXlmdVZoekd6TXNnSWlqcFppUFg5MWZrZjF4ZUswSkli?=
 =?utf-8?B?REdKMG1SK3JUNEMwaGFHS0duVGRUVTNhemRkSk9MRGt4WlpnRTNUNWFPQnJ1?=
 =?utf-8?B?OHZMOW1lSHR4TE02SG9LRjBIdUlCb29jY0tGQWJlZVAwZkVnbUQrbngydnIz?=
 =?utf-8?B?aUdTc0d5am4vQWlxNm90cXVSQ1NNK0JIK0xkVFhmNUJuUFBtYzhvOXJmZmhW?=
 =?utf-8?B?Q1dwak1UaEZGcXVSK0VEb3lTSWtIWDJMdlhmcnJIMEtUN0xBR3FOWWZoWnp1?=
 =?utf-8?B?anBCMDk0VXdpNnpRbXpibTdzYW44cFFCSVpRWWpoOWwvVk5xSUNvOHRQSW0r?=
 =?utf-8?B?ejZ0RnhEeUVscE9xRFN1QVg1QlVGSVQrTGZ3aklwbEYxOXd0YUg4ME9MUXZF?=
 =?utf-8?B?anE2d2NpV3NHRUhyRzNvajE3dEZhaGpYQzFpSWU1OU1Xb1hmVkprVTUzaE9h?=
 =?utf-8?B?OVhrQUcxT3FsODdvWVA0cENuTVlmTTVtS1hYNkxnRm9MckRSdDVCYkgwRmM2?=
 =?utf-8?B?bGxkVGxRaHpTVHZibGNDeGxiN1pOOFUvM010bHp2Nzk4c09oR1VUdmxPOWhv?=
 =?utf-8?B?a0IyUDJxc0RwcDlvSlcrY0RQTnl5TDVXaStxdUNpYWlaZzRjakRlOGVKUkVB?=
 =?utf-8?B?TG9tcE10U1JBUzBra0JvbkNHcU13cGNXZlVvTTVBdEZJUDV4NlFKalJuS2xO?=
 =?utf-8?B?ZVdyaElSeVpTTFBRQUxGeWtoczR0WVd1b0g3Tm8rZC9PRHVrbEpFN1paaTY3?=
 =?utf-8?B?L3lUd21lajdzaGE3MFpnZ2lNSURpeUhlN054LytyY21XWDVKRnBRQU5zcDFV?=
 =?utf-8?B?dkRRY1VKSXpaOXVMSW9TM2E3dERIOWcxT3IxcklFZXhhVnlGSzRyTjdySGMv?=
 =?utf-8?B?bExHakZGOWs3QmRQYkh5aFJnWWRlMDN6YWZZejdmekxzVmtSRFhQSHhRNWgy?=
 =?utf-8?B?SkU0VTFPQS9KMEZYK083Z2pzK2xCdjduUlhQYnliNk54Z3dQUENzMzl4a3BB?=
 =?utf-8?B?dTZXcS9NOVZrWk1QeTVnaXpXSWhBYkVRc0RFaEdVV2ZiV0orRnVCSmhvVUhJ?=
 =?utf-8?B?R1ppWnVtL05IOVI0VERQQTVLSFRpZFFGZVZOZlVmUk5hNkhNdXpnV3NUd3Vs?=
 =?utf-8?B?NnkrZmlIeGI4ZGVzWEU5ZjZ1U1N5dEtFWTlJSmZmQ3lTaXlnLytyVHJ3cXhw?=
 =?utf-8?B?UXZGZjZVYzF0eUwwQ1pNbWUxT2xYWlNXdG1xL3VKWmJyaWUvbk1rWTBjcWRO?=
 =?utf-8?B?dFVSU04vVlZ4WWJLUXZOSGpqVTEzZEkyL3RnWExyOG1WNW1MMHZHTUZkMDdG?=
 =?utf-8?B?aWxCMzIzeWZmUzR5NTIzTkNEQ3hDL3c5UmVSa3pKaGtFU0thcGROZHAzdzl1?=
 =?utf-8?B?RW9haVp6RDFUcXh4T1ZUYTczRWZ0RE5hbVFENUVVclFKUTN6U2Eyam1NbFNB?=
 =?utf-8?B?MkVyU1ZQMk5QRnpmWTFPbzFoaWREYmNtUmJNK3BmUitzVFhBb1VDaUZvOFlj?=
 =?utf-8?B?WGg5aUx6cnFMNWJqcm55STlBSjd2RmQ5QzJrdDlLdnBpQTlLRHFQRzFScTZU?=
 =?utf-8?B?MURReGY3Z1B4R3VUMlcvakdrdFhGR3Q1YWlhcWVLNTJpNlJxRUhWM1JCSGpa?=
 =?utf-8?B?bEI1bFlEZmc0SHpnQk1UakZyTnRaMWNvNUZPSHhia3dJNExpTVpuZGVyWjFM?=
 =?utf-8?Q?j7yqi1yWdzD+yOaNRZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88e81de-0604-41bc-1070-08dec6e600cd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 11:47:09.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++xRFHq0koABAn9WAkBTCbnxB+NjLTyKA6NhgctT9MYYb6wu1R0WVtzCxOLQshgC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470

Hi Andy,

On 09/06/2026 18:31, Andy Shevchenko wrote:
> On Sun, Jun 07, 2026 at 10:02:47PM +0100, Erim, Salih wrote:
>> On 07/06/2026 08:31, Andy Shevchenko wrote:
>>> On Sat, Jun 06, 2026 at 06:17:06AM +0100, Salih Erim wrote:
> 
> ...
> 
>>>> +     ret = regmap_read(sysmon->regmap, upper_off, &upper_reg);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     ret = regmap_read(sysmon->regmap, lower_off, &lower_reg);
>>>> +     if (ret)
>>>> +             return ret;
>>>
>>> Half of the IO accessors have no error checks, these do.
>>> Why is this inconsistency?
>>
>> The regmap calls in sysmon_unmask_worker and sysmon_iio_irq
>> have no error checks because they run in contexts where errors
>> cannot be propagated (workqueue, hardirq). The init path checks
>> errors because it can return them to the caller. Will add a
>> comment explaining this.
> 
> But the error checks may be used to modify flow inside the respective functions.

Accepted. Will add error checks in sysmon_unmask_worker and
sysmon_iio_irq to bail out early on regmap failure instead of
operating on undefined data.

Thanks,
Salih

> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

