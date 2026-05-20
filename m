Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731B329BD95;
	Wed, 20 May 2026 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779318925; cv=fail; b=Rh5RXiUWk83WSQTAN7cntPjJCdRvMs3b9khqXvxmSGF8/DoJ0k7WMB3haoZu1RON4bteUQ6euRu0S1pQF3FQiPef8ybwqvwtqNODDDiETmq2G6+ytR2L+RzWEfO2crJ1zvDgFJ/TIl63B6V80QyTSJmw2/LRVoIutT3I348X3cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779318925; c=relaxed/simple;
	bh=DSzXC1bmBJ4kjk1Ohgg9jAXzH56WvZp8gnQhu5L93JU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mc+SSYZ6JmqoRJo1cG7eY7eLp0s7Tj9TVbkqrgweIgX3v1cMV9xfHcJZgu3QBuPpWne8LbRv2JUAJimJvxMzyNLAQ78uhvPgMUgUhY48ETEwZji2xx4HFoJcphKhRDAKJPWCUy7RygqN9HMgRLpH55CHo8oZKl4ToruuJS7V9ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iHNkkm3O; arc=fail smtp.client-ip=40.107.208.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iHNkkm3O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YagvyaAAeCordrT00jTHd70aKabFL1nh/bV2GlEQGC91tylPPuq7JctYbVwOr1M6by4qQgd9JGyQ4EBqC9oMQGqbQ4eqYNx7qI1rKd7pVeZG6mxHwwncssPfUMEX7Ix3sPPPA4Er39tCjDF4fWhi5zyHQcQDUS+nGHXbwGCK3fR/Kb++nfzoV7R2AdDrDRxGi6VZHMXRk0rNqkzHmc0X3kwfo4D9IS1rPT+gWz2SKYg09dw8ArST6cYepyZg4sEdBA1CCcyR31Hy6OLYBNRxsgtNvmQNub7vJ+D5hSbr5sj8HGwSp/lIUZM0J8K/H+IKGwbxkneXOKo2eGpSNvF9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dckk0Az9UL2L8ubPOaAxN6ICFxXfgkyv0Xf9wlcjLVc=;
 b=gP4xp8v/jtdd3XvYgcpc0K6kwuor+PFOJpdPpvLnR0b1ftP3V1+JUL9mj0dR/0lOIkgRt044FpOFDRmoOYWg4pUZ3YaRg7IxX4/mcFpq43sNVBYx89AW9xahLWU+zHX3m0W5PYgiBhmIgYXVPSOFWB8nDmoSK8zPAAqCZccgzZK7HNI9nsMaE+XSa8MazBr23eqlbW8ROBS4leympQnBonC7x2v0SXcvfs5hwWPLW/KzK3GAoqMQrI/g9VC5fjbxy8KajvKg5JoopOTmQxwZiQiMF3nP4WmiT1y2b6zzbZoO2tCsSjsdhcjTm8zxLDgMtT5+NblS/a9MVU5jZWV8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dckk0Az9UL2L8ubPOaAxN6ICFxXfgkyv0Xf9wlcjLVc=;
 b=iHNkkm3OrFM+mmsCTBIZuwziVivIg0lVPCKjCac74zHh3YtYjhOlQ5fnN7jm69eyTCMHtmLbSVxnlAvZBHQ2FJVrqpxhDoLYOswOkjg9LSpI5D/y3GwlpuSZsJll6qc5DaIuky88GJ6TEPBf1PM+zcxLeadhyp/ZddZ4OdaEhkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by IA1PR12MB8465.namprd12.prod.outlook.com (2603:10b6:208:457::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Wed, 20 May
 2026 23:15:16 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 23:15:16 +0000
Message-ID: <85c06df0-7cdf-4273-b033-9ec9dcd5781c@amd.com>
Date: Thu, 21 May 2026 00:15:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] iio: adc: versal-sysmon: add threshold event
 support
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, git@amd.com,
 nuno.sa@analog.com, andy@kernel.org, dlechner@baylibre.com,
 michal.simek@amd.com, conall.ogriofa@amd.com, erimsalih@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260502111951.538488-1-salih.erim@amd.com>
 <20260502111951.538488-5-salih.erim@amd.com>
 <20260504184415.7b6688f5@jic23-huawei>
 <59884fdc-a9d0-49c6-8167-11d56a21dd11@amd.com>
 <20260520103708.24d59b6b@jic23-huawei>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260520103708.24d59b6b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::11) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|IA1PR12MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 646b5207-7e2d-4932-0887-08deb6c5a6c8
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|3023799007|18002099003|22082099003|56012099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QQNC8D/A3nWGBXmueR/ovCsKGZM7TuqC6R0/OPGQAipW2c1eKohj1F3p1KVIDBcoj4yZV7T+yJRZZNMYk4QN2pZ0RfJxTFbEVzrMTrsC0e8DwJwexiJIoXQth2M2pZF4DOVo5jYIAkgTZD/XC/zL9VBZploKtp5581HdNB/InbF2p8fJ4IhrfvbUpNf3TzCQxvuoTztP1iYZDi0PD2L6hI9yw+18OhOpzCpI0kbRsJCBu/eJXAtnjMpIUOfeFQkYAXrbBCAKaOMgxMmR0+iqofWagsr3EDZ795auQmL2KJ8tr24w4o0Famb/KyAM1SAfyp7w/xsJMvtT32a6JSAFvVSEfgz1ryNqRII0Gz2f3OJqbiEfF6DjetFDdANRzzEk4tCngD0YvpfFJpME+1OcDzmVFHjIVHdJ2Mury3dIGrUDkK8EINvi10vlX43NzIe9StLLzEW6pPeWG+UKTTJYbji6E4cACOAPCMFGf0ZFbBGg42f3tvheHzTHdVqksuTk1ztCUFr1rF60aVUQ88IlyWicZKJ3RhoTIxmoFSmz41kAqzMuPOAi4GkNO7Fc/y6n3tGPUkdIBB4Go038dNtSNobBKigKs6IRfsPQLVg5yBlJUY06voNXe6xFKQ6BJRiR+BaYy6Rhnko/x3ShVDHkwQ/Yw+/Fhxl8rr+GTVHKx0KvTjj/egQIL2I9RJuWz3FH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(3023799007)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVZHMm1hWHpHVEV2RzF5ZHlhc3hkczRqbFV3RWtXN1lxeTNKVkowT2pxTXh2?=
 =?utf-8?B?N3MwVE5LNzQwbTU3eGM4allpQjBCb3NIT1hXUzEyYTNiaFNkZ09IYWxNOTYz?=
 =?utf-8?B?T1Bla3hTTjBBc1VnbHExODh1bWN5dzZUc1FnSTBySGYvb3hnL3ptN1VGTGdT?=
 =?utf-8?B?emZMOGtCK2c2QUh2RzhJMmxvbWxMSTMyOEVYSkRkeldNYmZoMU9vdExjRzVi?=
 =?utf-8?B?WEI3RGljczFRNWhCN251SHdJUGY3N1VaU1AwMUJqSjAvVjJLanc3OGtaUVBi?=
 =?utf-8?B?V2FXTG4vYkxGNSs4RHBTSFRvKzgzWWp6ckczSVo1RlJTQTZsNkE0blFQazNz?=
 =?utf-8?B?UGZqWnFtMmFIZ2tEdHgwbHNzYlBBWFhyLy9PV2trZnJ0TWtCclBHUVBrQ3VT?=
 =?utf-8?B?VFpVK3cvbkFFOVpMSHhVbjhCOXp0bm9BdzZ0NnlGMmh2NlVzbktQbXo3MTNI?=
 =?utf-8?B?c2tKbDRGMG5CYU41MUJ4RForK3l5OWZYVGk0YXc0Y1VLQUFkR0hkNklWZ0RD?=
 =?utf-8?B?RTF2RVBHNWVDRXZWaXpKemZlVDlCelh3VzJib211TnQrUXNOd09yc05IN1g4?=
 =?utf-8?B?UTJHa3NPSE5LMjFrWlZXZFNQSHhRK000c2tTdzVDSkUxdzJJZmJ5NmdYUnZE?=
 =?utf-8?B?R1pUM0lPa2NITWYrdHFwZUhDZitGbktaWG81MTFlN2duVkFIMDNKdlRyam0y?=
 =?utf-8?B?UkpUS09RWDlMNFRxUXBYay8vZlh2N2dTNEZtOFU4N3QxL293eUE3SzkvY0Zt?=
 =?utf-8?B?OFB6WlB0NTVyWWtNMElQdi9adzA4RXFQQTN1Z242UzJGTWxtajhMY1FCd2RF?=
 =?utf-8?B?MmF3d2NtV0FBMEExM1RrY1dYcW1taTBHRWRjM3o4dDhkUEE1Znd4WnRqbk00?=
 =?utf-8?B?SUlOcmtibUdyT2JVNi9mZ2F4cUl2bzBFVlkxb2pwWUFWNjhKOU5SWFAveVVU?=
 =?utf-8?B?UGpBUjYyNXZtOFRJcnhOc0hqNUFBK0w4VkZBaXdwK0pMSm9pM2VqNlljdCtK?=
 =?utf-8?B?eWVmZlhuWG5qdzVvUjgxN0ZUUVJ2SC8rU0R3aTJSVFZ4ME5YV3NEZEw4Q2hO?=
 =?utf-8?B?bjIyY2ZlNzhDQks0M1JVOXZrL3ZWMFoxWFoxdHMwTXVWRXcrRzZVSjl3M0Fp?=
 =?utf-8?B?d25iSkg0czZYV0NaQ0x5a0k5M05KOWxWTjQ3Vmg2OFNHU1Rxb2VaRUdkallI?=
 =?utf-8?B?TldzdGNLeHdHUHlqSU9iblJ1MHFXSnB2RWxzOWF3czlsS2licnFDQlBLMEFW?=
 =?utf-8?B?bXNUbjN5S05CdWpXb1RNZTkwcmNiQ01LY0pOS1ZHVHRaWHUwVUJWam90amNm?=
 =?utf-8?B?Yk1KVFk5RUttaGd2VzRBbUVtVTRFQ0szNGZKOHdHSk94STlaQmNCQXpDVnlY?=
 =?utf-8?B?WWpWSnFOSElJTjgvL0tFcW50eWlKc0NBa214RlpkVkFpOXZsVTdVcGs3czd0?=
 =?utf-8?B?OEdiZHVWMjBnSFd2U0JiOWJ6TFpFYzQ0MmRQbFZSYnFFb2RzV242WC80V2th?=
 =?utf-8?B?UzZXWDhmOUJRYjZqa1hDMHZZYndQdWtuSmZNcFF6U1BCcklMQTZvc3BOZ2dD?=
 =?utf-8?B?eUlBUlFucDRvZFYvd1dsVVpzMWlNN2V0enFNL2x5NWRaaGVkTVRSRnBacFJk?=
 =?utf-8?B?T0FjWUttSzlVOTBidUJWM29HUUxlVFlOcWVMeFgzbzZoalZkemVWdm1tQ2Mr?=
 =?utf-8?B?MmNBYXYwR00zMEQ1VzJXYVAxaTNQMDc2SlRySUlrbS9PNmdOdDQyNmRSeTJv?=
 =?utf-8?B?UjZXUWl6eXlmOU9QVTNBS0I3VllzbDBxQjBLT3ErV0tyWGdkMmhLSGtDQ1NE?=
 =?utf-8?B?NG01ZDV5TmM1M0ZZd2owc0p2ZUVqKzNtclNMOFhlVkhiQ2FaaGFJSkhVd0tv?=
 =?utf-8?B?T0p2OU85WXNpRXlEUmFZa01vZXBTbjNQbE16MnI0WHl0NlZ1YTlnbXFRU3N4?=
 =?utf-8?B?Zmt4cUhMVGtPN1dIY093MmNzN2hCdkI5RDJQRmR0SVh6Q3pGOEZnNk1pcEpJ?=
 =?utf-8?B?emR2TytiRTlzQ3dQRTlHMi9NRnNnK3pXVHIwSHZZc1kzQ3RGODZxR28xMmdh?=
 =?utf-8?B?bzlEMUczcW1veVVNc0N3bSt1N2VKWlpqMzY1T3N6SXlaYjdGVzM2cW5YWnp2?=
 =?utf-8?B?cWpRTVpyZEVvcU8xZ3NxYmZzaC9mdkZ6RE1HdGVGdlpHd2VLY2ZQd3hlRzBq?=
 =?utf-8?B?RG5sNmRrNXZ1eVZPMkkyNlJpbklaRGg0bUJVZ1B3TkNkbnVUcmo0ZnYvTjBQ?=
 =?utf-8?B?QzQvL05uYmZMUHNPeDRHeXh1cHBDTmc1WFRMbHFkM0pRd3NUYU5BTjJucG5J?=
 =?utf-8?Q?YdXqD04HGXCIlFU40n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646b5207-7e2d-4932-0887-08deb6c5a6c8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 23:15:15.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoM424HW/rZSDuylLl/99lDojviNzU2KevFPkbNKTBBfjDFja8gwK8aC5RxTw2ij
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8465

Hi Jonathan,

Thanks for the detailed guidance on the ABI constraints.
I have studied a bit more and have a suggestion inline.

On 20/05/2026 10:37, Jonathan Cameron wrote:

> 
> 
>>>> +static int sysmon_write_event_value(struct iio_dev *indio_dev,
>>>> +                                 const struct iio_chan_spec *chan,
>>>> +                                 enum iio_event_type type,
>>>> +                                 enum iio_event_direction dir,
>>>> +                                 enum iio_event_info info, int val, int val2)
>>>> +{
>>>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>>>> +     unsigned int reg_val;
>>>> +     u32 mask, shift;
>>>> +     u32 raw_val;
>>>> +     int offset;
>>>> +     int ret;
>>>> +
>>>> +     guard(mutex)(&sysmon->lock);
>>>> +
>>>> +     if (chan->type == IIO_TEMP) {
>>>> +             if (info == IIO_EV_INFO_VALUE) {
>>>> +                     offset = sysmon_temp_thresh_offset(chan->address, dir);
>>>> +                     if (offset < 0)
>>>> +                             return offset;
>>>> +                     sysmon_millicelsius_to_q8p7(&raw_val, val);
>>>> +                     return regmap_write(sysmon->regmap, offset, raw_val);
>>>> +             }
>>>> +             if (info == IIO_EV_INFO_HYSTERESIS) {
>>>> +                     mask = (chan->address == SYSMON_ADDR_OT_EVENT) ?
>>>> +                             SYSMON_OT_HYST_BIT : SYSMON_TEMP_HYST_BIT;
>>>> +                     shift = (chan->address == SYSMON_ADDR_OT_EVENT) ? 0 : 1;
>>>> +                     if (val & ~1)
>>>
>>> Just to confirm - this only has hysteresis values of 0 or 1?  That's unusually
>>> small given hysteresis should be in same units as _raw.
>>
>> You're right, this is wrong. The current code exposes a mode-select
>> bit from ALARM_CONFIG (0 = window mode, 1 = hysteresis mode), not an
>> actual hysteresis value.
>>
>> The hardware has independent upper and lower threshold registers for
>> each temperature alarm (DEVICE_TEMP and OT), plus a mode bit in
>> ALARM_CONFIG that selects between window mode (alarm on crossing
>> either threshold) and hysteresis mode (upper triggers, lower clears).
>> Since the hardware has a single alarm bit per temperature channel,
>> even in window mode you can't distinguish which threshold was
>> crossed. Hysteresis mode maps naturally to the IIO event model.
>>
>> I'll rework this as follows:
>> - Hard-code ALARM_CONFIG to hysteresis mode during init (both
>>     DEVICE_TEMP and OT)
>> - Expose hysteresis as a writable value in millicelsius, stored in
>>     the driver
>> - Keep both rising (upper) and falling (lower) thresholds writable
> 
>> - Couple the three attributes:
>>       Write rising    -> recompute lower = upper - stored_hysteresis
>>       Write falling   -> update stored_hysteresis = upper - lower
>>       Write hysteresis -> recompute lower = upper - new_hysteresis
>> - Read hysteresis returns the stored value
>>
>> This keeps full user control over both thresholds while exposing
>> hysteresis as a proper temperature value, matching IIO semantics.
>> Window mode support could be added later if needed without ABI
>> changes.
>>
> Not quite because that falling attribute is not in line with the ABI.
> 
> This needs a little hammering to fit in the oddly shaped hole of our ABI.
> 
> If you are sticking to hystersis only (not window mode) then you need
> to expose it as rising threshold + hysteresis (not falling threshold as
> there is no even triggered in that direction - unless you are doing something
> nastier like triggering on both edges of the interrupt - in which case this
> is very similar to window mode and for both event directions you'd need
> to set the hysteresis to the difference between the threshold values).
> 
> If you do want to do window mode - that would be fine but you'd need
> to then do a falling event where the enable sets the hysteresis reported
> to 0.  Whether a write to hysteresis would then fail or we'd disable the
> falling direction would need some discussion - the ABI doesn't constrain
> that so it's a case of what is less likely to confuse a user.
> 
> Jonathan

Understood. I'll go with pure hysteresis mode - no falling threshold.

The hardware has a single ISR bit per temperature channel (REG_ISR
bits 8 and 9) that only tells us the temperature is "outside the
threshold(s)," with no indication of direction. In hysteresis mode
the alarm asserts when temperature exceeds the upper threshold and
clears when it drops below the lower, so the event is strictly
rising, and the lower threshold is just the re-arm point.

So the event spec becomes a single entry with everything on
IIO_EV_DIR_RISING:

     { IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING,
       ENABLE | VALUE | HYSTERESIS }

giving thresh_rising_value, thresh_rising_en and
thresh_rising_hysteresis. The pushed event will also use
IIO_EV_DIR_RISING.

Hysteresis will be stored in millicelsius and initialized from
the hardware registers at probe as (upper - lower). Writing the
rising threshold or hysteresis recomputes the lower register
internally. ALARM_CONFIG will be hard-coded to hysteresis mode
during init.

Window mode can be added later without ABI breakage by introducing
a IIO_EV_DIR_FALLING entry and enabling it would switch the hardware
mode.

Salih

