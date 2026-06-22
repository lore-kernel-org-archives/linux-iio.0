Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273A29CB24;
	Mon, 22 Jun 2026 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782172757; cv=fail; b=CqLnAnrLhYL5PO9Ue4f3QdidBlGu/eEqORbUb/bIO9dpraYTtUpXiWp527CrelEhQyKkNcm8av8gSmcNpvOm7t4oenpZWwYKNx+TxkV1gqCqrhaW2NRHWnP9K1gt+Piv5r0WKs9Bvt5a2tLb560k0mfQ0C5S6VaqtWCg5+6FWPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782172757; c=relaxed/simple;
	bh=+fCPaTj8kcqfg7+6RzxK5aYy1nGKn/9Fs/wANdls9SU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kyrLCHpXP0phPpo2K2vf+COjgThIQSxWBpYU0y8nOaSOqcnQseAcxumgSfgKtE2fntrET5unEryr2z13n9xo9wvqEtiCFKFIBpbRvByTIacW9olUmeWHx4QqKuqC8Y+loaxWpVvvIF6Y23y+x9+ffz1VvTqfglwERrSUvHkQX2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TyktGr97; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TyktGr97"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSR/7mdHNyhBsbqqasznwycZ9AAyYyYLMLJQLBiCvjrWk+FJk5MJwMfpwExFbd397z8qNV+xz7G5v/ztQ9p6cpbLNJ2WYbdu/jS8aCefkh2OHPHi6mAp3QC+Om7Wb/AWWevFthVGjngwrtBmVbUGIqWlQzlQ/O5/CeVs0WerqKy/3OOQcJR9aBfBpZMmYhu5Il8zCFMykqeaxnSpqsMAT3AZKmlK5wT5CA/chlZP4ApmUovx0tU/S1m4378F1TGE2oyoBrEDAESJ2CqyZBmew2z9bkHJfuIgSxm1hCai2fSJRG9Vaul2UeJNJDo+H4lzqPzX/STDix0zxtRluCaAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+y8d20+APeWZYnDn1BzdyAPWT6i7Qu4FHCdIJTp9Xc=;
 b=DcIk4qn6iNojkUfoQEciJ+ClEoheKTkMFP3KCgNLQxd/jAZJj8QzVPuHIo/ue2+sp5ROH3rwN9ba/Jz0pbvCMB4FggFPXJAeJdR8JjWAw4ImqGfDOiVsKZ3UeiRMqcpqVQ2DhKHy2zpP44Vbs134nc1tl1QBhemKJPme1uILz2zRBDvFLoe8+jGzyfxLePu4NteEvBGtqRhUyVORoTJBiXGOCwzdyr00+/F8VeaJ1GkuXbgTOsUmBlk1lSu8NQdNWCG7M3cXeBWy2d5uS9E9jT55uUrLKTjPBt/IHE3Wn+txegTAEurBbOTi+7DaLuHx5y6vjo4pzzFqKnFjVFyN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+y8d20+APeWZYnDn1BzdyAPWT6i7Qu4FHCdIJTp9Xc=;
 b=TyktGr97FBlSXAXJN9P+DsrFbrn2QFS0+iYtYRgZy2mo9FTH8Gekw24Bf0K6tkUUy6FbDYV19YyIYEtr8yUb0wVI2MKo56ZTcREaRUTMpFw5D2myuHil5j9uc7dzTs/yi7V96/E7WEF5GerHZ693DXHj5mUBjy098eqRoX7OVF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 23:59:08 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 23:59:08 +0000
Message-ID: <c90f29e0-7c9b-44be-b991-a107ae4c52d4@amd.com>
Date: Tue, 23 Jun 2026 00:59:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/5] iio: adc: versal-sysmon: add threshold event
 support
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 conall.ogriofa@amd.com, michal.simek@amd.com, linux@roeck-us.net,
 erimsalih@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260618101414.3462934-1-salih.erim@amd.com>
 <20260618101414.3462934-5-salih.erim@amd.com>
 <20260621172247.3499cab0@jic23-huawei>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260621172247.3499cab0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::9) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 9861faad-e651-4fd4-6c63-08ded0ba3f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|6133799003|3023799007|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	8MVLJU8suuT4BHStoyigMgW4xLqRX0Y7iPs6nZbz7NeXU+FpKs3WdUu3CmmhudWqtLRd5W7g/Bnbh+UGugpdXzmtBRu03Oy5EwOCopv4Y1JHStCwm7HeGovIVzLDNRrNyFkFKbZbsR97foIcuBk1+KvQ4T/fMYMDzE2BvCHxZ6bFSzWOoZrt2xx1RPihDzjBUalBdqzsPkCZkMFKrH2Z3I9VkZiiIsQ1e2uoQSEfI7pHSgDpPzJYSOTS/tLoFS5GqJDgE9OfjznFRuK6LpILkaS+8qsQ77V8RAcpqxRyLQ3yRgVN8TiI7SBhIZ1e+ihOflMaJKquEtciXV0j+kviuD1tmqF9CvDzNHXkV43a741lDUfAPqo3m3bebUHBzWdkerfC2c7ns6LpxNMq0faeV4A/Sl3fPkC2DpV16PJUKldUG/ezCdkM+P1Ce7ITjcjzf8DJGZB3hkxHZzOc2cTdCRSlnx9hM4cfe3b8gxwtlVtnijtr75gPtjXhlcr0UBQGTfhLyCsgojO5I66OFH5yoPxzxhUkaqleY0DnumY+LbuZq2InxSBpybAwtCGjuL3bTJtjSY2uwxpXoA4y/pcT5kd3vlNCHe1aV45rj1mpsAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnROcmFXYWtrT3lkRzZjRFhia3huMlB3WUVLYS9nMk0zSVI2ZVY1L3paMFFL?=
 =?utf-8?B?dnRmL1NqdlB5ZzRKcWpPeG5mWTRwNXhDMlhyeTZCRUFSeXRPeTNGcmpNY1J0?=
 =?utf-8?B?N2I1cmpnMHZ1anBYMlZkWGR3aUE3VGduSVdFZWplb2Vmbjk3empEeXJ0eDhK?=
 =?utf-8?B?akpoUHhKN1VCM2N3SHJXV242bmx4WEFWRzk4UUpqM2Z6M2txbjRPdHNFNWsr?=
 =?utf-8?B?LzZZUFhJbUNnUHZ2REJXeTI0WllSS2JjeXU3eWphWW9YeCt2SjVBRnJUa29R?=
 =?utf-8?B?cGwrVVZHYTU0dnZSVVJnSEJYVDBaWXdQTVE0Qk9QWVlpUWhHNWY3RjBIaGZK?=
 =?utf-8?B?UUxiYVdwUHpOd0htdEZYd2N0VkZBQnFDaUZPcFVSVGxCcVN2aTVKYXhqRWJP?=
 =?utf-8?B?MHExQlV5RHMwUmM4dy81MUFNMG1MbHY0eWdmb3FkYllWUXlkNGFkRTJQSVI2?=
 =?utf-8?B?eTBpY2hnVjZWbTd1M2NHR0VKR1AzY3pPa21IMm1GZVJWZmh0cnN0emJ5OVkw?=
 =?utf-8?B?OG12UXMzOVVCR0QyK0c0Rkx5bmdqSCt2KzlHVEJTRW1xOGJvRGlkcndUTlVu?=
 =?utf-8?B?czJkRm9RTlhQL2ZER2RpZzFYR1NXbjZldVBnUUNlK3VIMTFtSkhVQndacExo?=
 =?utf-8?B?cUQxakZ5MEhMK0U5bjB3WnA2RGtVUlNvK2tJeXRZQmloRDQxdzN6d2ltUXNl?=
 =?utf-8?B?TDJCcTJaWEIxSXdqeVhmNUJiWTJJcFoxck56azBJb2VMeUpiL3NpNFBPQ0FK?=
 =?utf-8?B?aVdVa1RER2FibkVnamdLRlVSU2x5MUtnMnBPdkpEUitZTmhRU1B5T2JldE5o?=
 =?utf-8?B?NGNsZGJ4U2UyVXVtSzltazF0eEpaV2xlay9FOGlUQmp6ZkVad3c4eXROeDZK?=
 =?utf-8?B?VysxZWFqQVoySUJoWUxFQ2Q5aXhraXE0TjFtVzVpczd3ajJ3bmtZL1dkOXlv?=
 =?utf-8?B?YjdQWTdnQUs4UE1xbVlUcUZpU2JtbDNZcDk1L1E2M3RKbXZRR2EySDRQVGFH?=
 =?utf-8?B?T3hHR3VqVC8yNVFHUzRiODZRdytSbm9UVWY2Mk5sWnVLV3hITDRrZTU1WThq?=
 =?utf-8?B?TEN4cFZDUjJsS3h5N0J1d0xsVHErRC9pclhHcjdNbXNQK1VtV1Y2akViYTFW?=
 =?utf-8?B?SzNRSUVZd3BkZCtKYkkvSWJ4RWkwQ3RCRFNkVGFueUp6cHo0QU9oK1pnREZP?=
 =?utf-8?B?R2x0QUtGYkQ1alRQR2FxN0dMenRKb0JwNEdxZVN3aGpsWkdPMlNJUGkrdUZj?=
 =?utf-8?B?VkgySkxZNVJIMDBWZHlaOXF1Uy8rWTQ2dGVwbXdrVk1JanlvMDU5Q3RKTzBI?=
 =?utf-8?B?Q3lBdTFrR2RHL0U1bkpkZjRNSlI2dnVqSXBTYkpQMDhJSGJNQmVSNWYzYVZ5?=
 =?utf-8?B?N2RBS3FNZGtuQ2txcVVzNFlkZDhiRjdpek1RZ01sanBKMGJYWU1HYmJhWEpG?=
 =?utf-8?B?bDJqWkJjQ0V6WTBWTnMyZ1YreHlTckJwS3JOVVJvOVJwRjQ2UXJyMUJWUXhW?=
 =?utf-8?B?eUtuM1lpVG9FWWdoREpNcnNLNk5Fbmg3MDZTYXcwR2pBTS8zaXFzQ29kQk1R?=
 =?utf-8?B?VyszbGdSNndGbE9jQUkxTndWbHMzSXhDY09IY0RQK1hjeGN0VHFFMXU5ZmxD?=
 =?utf-8?B?amtRYVFKbWJCRXo3dDNORXlkRGRNUDZ5cmJLMDNybTh0ejFhT204bVlnZUpZ?=
 =?utf-8?B?VTVFcElpWHl3OTNMd2ZmaTFFL0VsVzNxTUtncEZSM0htbG9OdlE2MnBmUDFk?=
 =?utf-8?B?MDNvKzJoMDRUVnhzQlBCNzR6ZnRlOVR5SnNzQ1VBMno3RHdLV3R0ZUVyaFBu?=
 =?utf-8?B?KzNpTE81ZmMxa3JGYUxOenZERlFrbjZYYk1ncUR4dHBaeDFmSTRqRGZOMmFU?=
 =?utf-8?B?eW9PdklldE9yMzd5MmVwWkxNcXI0THplOExlUTF0M0FxazgzMGhmc0FsdmVE?=
 =?utf-8?B?a2NxcXhPK3RUV3pnRGlvVVdObWtGMUdIYU9MN0cwdFZTdzBsQWJMVWpaY25u?=
 =?utf-8?B?QWhyRi9IUCtVVlBxUllTY2phWU9LU0RybzJySkNIZ3M3Z0NPd3p4NzQ4b0N1?=
 =?utf-8?B?N3d0bTlnQkZwOXQ5V0Q1aWxFK2JscFFpOGlMZHNtaEkvWlZqb3BJVVhUZCtC?=
 =?utf-8?B?d1A2QTlKTmlGRkdOTVBwRGo3VFovL1dKUE9lZm9WZDV4bSt3SHhRUkRSa1Yv?=
 =?utf-8?B?dVhLZVJMaUkxUkNqOHNCYkNGcXBLWjNrWUFQS2RObm12ajNPYVo3ZDFuYXIz?=
 =?utf-8?B?SUpJSWREQTRUWWhTZCt4V1ZFMk5BdU1hTFRmU0FpcFd5dElsZnRJUzBxR0tE?=
 =?utf-8?Q?5/9uOaZDWyeYO1IgWR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9861faad-e651-4fd4-6c63-08ded0ba3f6c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 23:59:08.1113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hj6A8MJBcCG9GEOC0wJrZP4Y5WYFFUvSZxRdEvui9DIpKl+sK1y4vtqGfaX6aL5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422

Hi Jonathan,

Thank you for the review.

On 21/06/2026 17:22, Jonathan Cameron wrote:
> On Thu, 18 Jun 2026 11:14:13 +0100
> Salih Erim <salih.erim@amd.com> wrote:
> 
>> Add threshold event support for temperature and supply voltage
>> channels.
>>
>> Temperature events:
>>    - Rising threshold with configurable value on the device
>>      temperature channel (current max across all satellites)
>>    - Per-channel hysteresis as a millicelsius value
>>    - Event direction is IIO_EV_DIR_RISING (hysteresis mode)
>>
>> Supply voltage events:
>>    - Rising/falling threshold per supply channel
>>    - Per-channel alarm enable via alarm configuration registers
>>
>> The hardware supports both window and hysteresis alarm modes for
>> temperature. This driver uses hysteresis mode, where the upper
>> threshold triggers the alarm and the lower threshold clears it
>> (re-arm point). The hardware has a single ISR bit per temperature
>> channel with no indication of which threshold was crossed, so
>> hysteresis mode is the natural fit. The lower threshold register
>> is computed internally as (upper - hysteresis).
>>
>> Hysteresis is stored in the driver as a millicelsius value,
>> initialized from the hardware registers at probe. Writing the
>> rising threshold or hysteresis recomputes the lower register.
>> ALARM_CONFIG is hard-coded to hysteresis mode during init.
>>
>> The hardware also provides a separate over-temperature (OT)
>> threshold, but it is not exposed through IIO as it serves as a
>> hardware safety mechanism for platform shutdown. OT will be
>> exposed through the thermal framework in a follow-up series.
>>
>> The interrupt handler masks active threshold interrupts (which are
>> level-sensitive) and schedules a delayed worker to poll for condition
>> clear before unmasking. When no hardware IRQ is available, event
>> specs are not attached and interrupt init is skipped, since the
>> I2C regmap backend cannot be called from atomic context.
>>
>> When disabling a supply channel alarm, the group interrupt remains
>> active if any other channel in the same alarm group still has an
>> alarm enabled.
>>
>> A devm cleanup action masks all interrupts on driver unbind to
>> prevent unhandled interrupt storms after the IRQ handler is freed.
>>
>> Signed-off-by: Salih Erim <salih.erim@amd.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> There is some stuff from Sashiko that looks plausible.
> https://sashiko.dev/#/patchset/20260618101414.3462934-1-salih.erim%40amd.com
> 
> Whilst the out of range temp thresholds might not be a bug
> that causes anything particular bad to happen it would be nice
> to report an error to userspace if a write is for something we
> can't support.
> 
> There are some things that I can't figure out without data sheet
> diving so I'll leave those for you to sanity check + some I think
> we addressed in earlier discussions.
> For a few of the things it raises I talk about them inline.

Thanks for the guidance on handling Sashiko findings. I have
reviewed all of them and will reply on-list with my assessment.

> 
> Note I didn't spot anything else (and probably wouldn't have
> spotted these :(
> 
> Jonathan
> 
> 
>> ---
>> Changes in v10:
>>    - Add Reviewed-by tag from Andy Shevchenko
>>    - Add limits.h include for U16_MAX, S16_MIN, S16_MAX (Andy)
>>
>> Changes in v9:
>>    - Add minmax.h include for clamp() (Andy)
>>    - Join sysmon_supply_thresh_offset to one line, change address
>>      parameter to unsigned long for consistency (Andy)
>>    - Combine mask declaration with initialization in
>>      sysmon_read_event_config (Andy)
>>    - Rename ier to mask in sysmon_write_event_config for
>>      consistency with sysmon_read_event_config (Andy)
>>    - Remove blank line in sysmon_update_temp_lower between
>>      semantically coupled lines (Andy)
>>    - Rename unmask to ier (u32) in sysmon_unmask_temp (Andy)
>>    - Variable name and type consistency audit across all
>>      event functions (Andy)
>>
>> Changes in v8:
>>    - Use MILLIDEGREE_PER_DEGREE in q8p7 conversion functions (Andy)
>>    - Use regmap_test_bits() in sysmon_read_alarm_config (Andy)
>>    - Join sysmon_parse_fw signature onto one line (Andy)
>>    - Fix devm teardown race: replace devm_delayed_work_autocancel
>>      with INIT_DELAYED_WORK; fold cancel_delayed_work_sync into
>>      sysmon_disable_interrupts to prevent the worker from
>>      re-enabling interrupts after the IRQ handler is freed (Sashiko)
>>    - Drop devm-helpers.h include (no longer needed)
>>
>> Changes in v7:
>>    - Move TEMP threshold event onto channel 0; drop OT as
>>      separate IIO channel -- OT is a hardware safety mechanism
>>      better suited for the thermal framework follow-up (Jonathan)
>>    - Use single temp_channels array; attach event spec to
>>      channel 0 at runtime when IRQ is available, matching the
>>      pattern used for supply channels (Jonathan)
>>    - Remove sysmon_temp_thresh_offset; use SYSMON_TEMP_TH_UP
>>      and SYSMON_TEMP_TH_LOW defines directly at call sites
>>    - Return administrative state from temp_mask in
>>      read_event_config instead of transient hardware IMR
>>      (Jonathan, Sashiko)
>>    - Add devm_add_action_or_reset to mask all HW interrupts
>>      on driver unbind (Sashiko)
>>    - Remove SYSMON_CHAN_TEMP_EVENT macro, SYSMON_ADDR_TEMP_EVENT,
>>      SYSMON_ADDR_OT_EVENT, SYSMON_BIT_OT, SYSMON_OT_HYST_MASK,
>>      OT_TH_LOW/UP registers, ot_hysteresis from struct
>>    - Simplify sysmon_get_event_mask, sysmon_update_temp_lower,
>>      sysmon_init_hysteresis -- all now operate on single TEMP
>>      channel only
>>
>>
>> Changes in v6:
>>    - Remove types.h from header (not needed at any stage) (Andy)
>>    - Macro brace on separate line for SYSMON_CHAN_TEMP_EVENT (Andy)
>>    - switch(chan->type) in all event functions instead of cascading
>>      if statements (Andy)
>>    - switch(info) in read/write_event_value for nested
>>      dispatch (Andy)
>>    - Reversed xmas tree in sysmon_update_temp_lower and
>>      sysmon_init_hysteresis (Andy)
>>    - scoped_guard(spinlock_irq) with error check in
>>      sysmon_unmask_worker (Andy)
>>    - Combined regmap_read error check with || in
>>      sysmon_iio_irq (Andy)
>>    - Join devm_request_irq on one line (Andy)
>>    - Fix fwnode_irq_get() to propagate only -EPROBE_DEFER;
>>      treating all negatives as fatal broke probe on I2C nodes
>>      without interrupts property
>>
>> Changes in v5:
>>    - clamp() instead of clamp_t() (Andy)
>>    - regmap_assign_bits() instead of separate set/clear (Andy)
>>    - Remove unneeded parentheses (2 places) (Andy)
>>    - for_each_set_bit on single line (Andy)
>>    - regmap_clear_bits() instead of regmap_update_bits() (Andy)
>>    - Simplify unmask XOR to ~status & masked_temp (Andy)
>>    - Add comment explaining unmask &= ~temp_mask logic (Andy)
>>    - Split container_of across two lines (Andy)
>>    - Move ISR write after !isr check to avoid writing 0 (Andy)
>>    - unsigned int for init_hysteresis address param (Andy)
>>    - Add comment explaining error check policy in worker/IRQ (Andy)
>>    - Nested size_add() for overflow-safe allocation (Andy)
>>    - Propagate negative from fwnode_irq_get() for
>>      EPROBE_DEFER (Andy)
>>    - Pass irq instead of has_irq to sysmon_parse_fw (Andy)
>>
>> Changes in v4:
>>    - Merge event channels into static temp array; two arrays
>>      (with/without events) selected by has_irq (Jonathan)
>>    - Event-only channels have no info_mask; their addresses are
>>      logical identifiers, not readable registers
>>    - Drop RAW for voltage events, keep PROCESSED only (Jonathan)
>>    - Drop scan_type from event channel macro (Jonathan)
>>    - Blank lines between call+error-check blocks (Jonathan)
>>    - Fit under 80 chars on one line where possible (Jonathan)
>>    - default case returns -EINVAL instead of break (Jonathan)
>>    - sysmon_handle_event: return early in each case (Jonathan)
>>    - guard(spinlock) in sysmon_iio_irq, return IRQ_NONE/IRQ_HANDLED
>>      directly (Jonathan)
>>    - Take irq_lock in write_event_config for temp_mask updates to
>>      synchronize with unmask worker (Sashiko)
>>
>> Changes in v3:
>>    - IWYU: add new includes, group iio headers with blank line (Andy)
>>    - Reduce casts in millicelsius_to_q8p7, consistent style with
>>      q8p7_to_millicelsius (Andy)
>>    - Use clamp_t with typed constants, remove tmp & U16_MAX (Andy)
>>    - Use !! to return 0/1 from read_alarm_config (Andy)
>>    - Use regmap_set_bits/clear_bits in write_alarm_config (Andy)
>>    - Add comment explaining spinlock is safe (I2C never reaches
>>      event code path) (Andy)
>>    - Add comment explaining IMR negation logic (Andy)
>>    - Split read_event_value/write_event_value parameters logically
>>      across lines (Andy)
>>    - Move mask/shift after regmap_read error check (Andy)
>>    - Remove redundant else in read_event_value and
>>      write_event_value (Andy)
>>    - Use named constant for hysteresis bit, if-else not ternary
>>      (Andy)
>>    - Loop variable declared in for() scope (Andy)
>>    - Add error checks in sysmon_handle_event (Andy)
>>    - Use IRQ_RETVAL() macro (Andy)
>>    - Use devm_delayed_work_autocancel instead of manual INIT +
>>      devm_add_action (Andy)
>>    - Use FIELD_GET/FIELD_PREP for hysteresis register bits
>>      (Jonathan)
>>    - Split OT vs TEMP handling with FIELD_GET (Jonathan)
>>    - Rework hysteresis: store as millicelsius value, hardcode
>>      ALARM_CONFIG to hysteresis mode, compute lower threshold
>>      from (upper - hysteresis), initialize from HW at probe
>>      (Jonathan)
>>    - Remove falling threshold for temperature; single event
>>      spec per channel with IIO_EV_DIR_RISING (Jonathan)
>>    - Push IIO_EV_DIR_RISING events for temperature,
>>      IIO_EV_DIR_EITHER for voltage (Jonathan)
>>
>> Changes in v2:
>>    - Reverse Christmas Tree variable ordering in all functions
>>    - Named constants for hysteresis bits: SYSMON_OT_HYST_BIT,
>>      SYSMON_TEMP_HYST_BIT instead of magic 0x1/0x2
>>    - SYSMON_ALARM_BITS_PER_REG replaces magic number 32
>>    - SYSMON_ALARM_OFFSET() helper macro deduplicates alarm register
>>      offset computation
>>    - BIT() macro for shift expressions in conversion functions
>>    - Hysteresis input validated to single-bit range (0 or 1)
>>    - Event channels only created when irq > 0 (I2C safety)
>>    - Group alarm interrupt stays active while any channel in the
>>      group has an alarm enabled
>>    - write_event_value returns -EINVAL for unhandled types
>>    - IRQ_NONE returned for spurious interrupts
>>    - Q8.7 write path uses multiplication instead of left-shift
>>      to avoid undefined behavior with negative temperatures
>>    - (u16) mask prevents garbage in reserved register bits
>>    - regmap_write return values checked for IER/IDR writes
>>    - devm cleanup ordering: cancel_work before request_irq
>>   drivers/iio/adc/versal-sysmon-core.c | 600 ++++++++++++++++++++++++++-
>>   drivers/iio/adc/versal-sysmon.h      |  36 ++
>>   2 files changed, 632 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
>> index 03a745d3fb4..50b5228aa22 100644
>> --- a/drivers/iio/adc/versal-sysmon-core.c
>> +++ b/drivers/iio/adc/versal-sysmon-core.c
> 
> 
>>   /*
>>    * Static temperature channels (always present).
>>    *
>> @@ -52,6 +102,16 @@ static const struct iio_chan_spec temp_channels[] = {
>>        SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
>>   };
>>
>> +static void sysmon_q8p7_to_millicelsius(s16 raw_data, int *val)
>> +{
>> +     *val = (raw_data * MILLIDEGREE_PER_DEGREE) >> SYSMON_FRACTIONAL_SHIFT;
>> +}
>> +
>> +static void sysmon_millicelsius_to_q8p7(u32 *raw_data, int val)
>> +{
>> +     *raw_data = (val << SYSMON_FRACTIONAL_SHIFT) / MILLIDEGREE_PER_DEGREE;
>> +}
>> +
>>   static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
>>   {
>>        int mantissa, format, exponent;
>> @@ -69,6 +129,33 @@ static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
>>        *val = (mantissa * (int)MILLI) >> exponent;
>>   }
>>
>> +static void sysmon_supply_processedtoraw(int val, u32 reg_val, u32 *raw_data)
>> +{
>> +     int exponent = FIELD_GET(SYSMON_MODE_MASK, reg_val);
>> +     int format = FIELD_GET(SYSMON_FMT_MASK, reg_val);
>> +     int scale, tmp;
>> +
>> +     scale = BIT(SYSMON_SUPPLY_MANTISSA_BITS - exponent);
>> +     tmp = (val * scale) / (int)MILLI;
> 
> See below. Overflow issue is if val is large enough that this overflows
> before tmp is clamped, possibly giving unexpected values.

Agreed. Will add input validation to prevent the overflow
before the clamp.

> 
>> +
>> +     if (format)
>> +             tmp = clamp(tmp, S16_MIN, S16_MAX);
>> +     else
>> +             tmp = clamp(tmp, 0, U16_MAX);
>> +
>> +     *raw_data = (u16)tmp;
>> +}
> 
> ...
> 
>> +
>> +static int sysmon_read_event_value(struct iio_dev *indio_dev,
>> +                                const struct iio_chan_spec *chan,
>> +                                enum iio_event_type type,
>> +                                enum iio_event_direction dir,
>> +                                enum iio_event_info info,
>> +                                int *val, int *val2)
>> +{
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int reg_val;
>> +     int offset;
>> +     int ret;
>> +
>> +     guard(mutex)(&sysmon->lock);
>> +
>> +     switch (chan->type) {
>> +     case IIO_TEMP:
>> +             switch (info) {
>> +             case IIO_EV_INFO_VALUE:
>> +                     ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_UP, &reg_val);
>> +                     if (ret)
>> +                             return ret;
>> +
>> +                     sysmon_q8p7_to_millicelsius(reg_val, val);
>> +
>> +                     return IIO_VAL_INT;
>> +
>> +             case IIO_EV_INFO_HYSTERESIS:
>> +                     *val = sysmon->temp_hysteresis;
>> +                     return IIO_VAL_INT;
>> +
>> +             default:
>> +                     return -EINVAL;
>> +             }
>> +
>> +     case IIO_VOLTAGE:
>> +             offset = sysmon_supply_thresh_offset(chan->address, dir);
>> +             if (offset < 0)
>> +                     return offset;
>> +
>> +             ret = regmap_read(sysmon->regmap, offset, &reg_val);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             sysmon_supply_rawtoprocessed(reg_val, val);
>> +
>> +             return IIO_VAL_INT;
>> +
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +}
>> +
>> +static int sysmon_write_event_value(struct iio_dev *indio_dev,
>> +                                 const struct iio_chan_spec *chan,
>> +                                 enum iio_event_type type,
>> +                                 enum iio_event_direction dir,
>> +                                 enum iio_event_info info,
>> +                                 int val, int val2)
>> +{
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int reg_val;
>> +     u32 raw_val;
>> +     int offset;
>> +     int ret;
>> +
>> +     guard(mutex)(&sysmon->lock);
>> +
>> +     switch (chan->type) {
>> +     case IIO_TEMP:
>> +             switch (info) {
>> +             case IIO_EV_INFO_VALUE:
>> +                     sysmon_millicelsius_to_q8p7(&raw_val, val);
> In this path, sashiko is asking whether it is possible for val to be sufficiently large
> or negative that the calculation is going to given rather unexpected results.
> 
> Given in the read direction you assume it is suitable for passing in a U16, should we
> have a check here? + error out if it is out of range?

Agreed. Will add a bounds check on val before the Q8.7 conversion
and return -EINVAL if out of the representable range.

> 
>> +
>> +                     ret = regmap_write(sysmon->regmap, SYSMON_TEMP_TH_UP, raw_val);
>> +                     if (ret)
>> +                             return ret;
>> +
>> +                     /* Recompute lower = upper - hysteresis */
>> +                     return sysmon_update_temp_lower(sysmon);
>> +
>> +             case IIO_EV_INFO_HYSTERESIS:
>> +                     if (val < 0)
>> +                             return -EINVAL;
>> +
>> +                     sysmon->temp_hysteresis = val;
>> +
>> +                     return sysmon_update_temp_lower(sysmon);
>> +
>> +             default:
>> +                     return -EINVAL;
>> +             }
>> +
>> +     case IIO_VOLTAGE:
>> +             offset = sysmon_supply_thresh_offset(chan->address, dir);
>> +             if (offset < 0)
>> +                     return offset;
>> +
>> +             ret = regmap_read(sysmon->regmap, offset, &reg_val);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             sysmon_supply_processedtoraw(val, reg_val, &raw_val);
> 
> There is another sashiko report about potential out of range val
> here. Probably also want to check for that just as a way to improve
> useability.

Will add a bounds check before calling sysmon_supply_processedtoraw()
as well.

> 
>> +
>> +             return regmap_write(sysmon->regmap, offset, raw_val);
> There is also a comment on whether this is wiping out the fields in the
> upper bits of the register. If it isn't (maybe they are read only?)
> then a comment here would be good.

The threshold registers have separate read and write semantics,
the upper bits (FMT/MODE) are returned on read but ignored on
write; only the lower 16-bit mantissa is used. Will add a comment
to make this clear.

Regards,
Salih
> 
>> +
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +}
> 

