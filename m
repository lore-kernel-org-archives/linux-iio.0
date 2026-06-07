Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275728727D;
	Sun,  7 Jun 2026 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780866178; cv=fail; b=cVqwe3Ktjf64Lf8OgOoG2JWtvYJnJreAXtAzdBq8/5xnW7UEOnYlPDLmvNBiXovQocvtc3DrE09Zgqp2F0oZAz8SPs5TQl11n1sKAFRkS8oahnUZvMx+L72y4vVGiPkv2Swov5YyvpSJXteS0Pwhgo6QcD5FzVmvcfX7i+sxQWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780866178; c=relaxed/simple;
	bh=leI7plT44IPfxY6pidHAAdw0tnwi6+mww3LNrHjd9FU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hSOic3Pccig8MCqebLvcw3bfhAegaoQyxQ4jmJyxXoy6+9bKVX9wbFHQpGptNoos47LNixMobk5JzneSFhBNU1O0c1LBOK5QLJ4pRJzLg8jT0+sNRcz9fK6kO6GeYKL0cKDUjhws+BUaMfBMd++nI3hcyiBvd9zxvYPwpVDapBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5gYjOmym; arc=fail smtp.client-ip=52.101.46.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5gYjOmym"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFl9OjwTBMD2cSGYb5K73XEDy+nH2PzXfE1d+RSDf4i4anokwrvTK4Sx9eftUM9GUx5nHw1XK0gdMqEx3I52E66dTQVvCuQxiNUELKZLJrJZbZBMay3t7DAtuTGw1kYDi9gijTOQdwbWki9i9nNhSEbnrtuYgJ62FgkULXiMvrTqteoXfbzpO+W6BdetzQGRKkcYrNQyByPWcaHdDJeZoKFKCal089RyKZWIFrMWHP0y+JxXJERBVmgGunGDZMEtNdZ7/2/OjJl/kSdhg7hbOjtlnrCrdmR6tcuTzbSZSMu0XjUBIFNX2hzZUY15mKYbeTCBdeuzve3zO0UtrA1K8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVfxmPAufXSZrllgk4stfNuBXs7Cbl0Bhfom0DGXgSs=;
 b=zFh41PHYwvdBRFsoEtb2L0d49gn/lre5MSzWH+TEcWmRIjdXuGuxJ0TYubIgAt4pP4Cq1yuHibBuzFgWNO8+kdS4UAsFhJgEO8RsobLDH6bckh82tA4ai5ppkjEJUuO8WKI1UYAkU8MHRduPkGioVNA/Y1JcFwA/kwf63A0RDPixpcvbW+2QKesOB05DIKBSZOdVqdO5x4/Z+lA45LDaK69ebRvLQaHSxsbwVVfROmeb+/7jKc65ZGQY6Ryi2SETjj4lFsPANp4rqp67xtfZiUFo/ZOY6BJuxYNSNaVb3KNrhINFEl23aMW9jqjAXRJBFqlmAgpvja5DV5Lx75F4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVfxmPAufXSZrllgk4stfNuBXs7Cbl0Bhfom0DGXgSs=;
 b=5gYjOmymPlwwPcrMa+xpnqGN693nLaio8RsVxoRYklkT9FpJhpXw658Rbuhx4W1aCTIB/WOFGciTAi63gVrRezSwI16f5yttOLt6VyUuZMftUwKkAA1BTjxkWISgO8YTTmQMX7QcaI3Sfb81SplHcGmGkJEH9zrhCBhekOVK9Oc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 21:02:52 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 21:02:51 +0000
Message-ID: <0f8f431f-af21-4bad-bff2-e6cde078bd41@amd.com>
Date: Sun, 7 Jun 2026 22:02:47 +0100
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
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <aiUeVs_FoI9vV1Hd@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0243.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::8) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ff6592-cb16-4932-bd25-08dec4d82319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|6133799003|18002099003|18092099006|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	SkdPapOGiTp26p1X1bS3faL1jW52c6LJtqqYegHkLDRLEuoRiCYh2vxHhfsGVn53N6kofZiulOnWlXlvcp4Uy3Rb4k/CzIAJ7MMSDQexCzNNcutZ+J+rdS3OlTNrV7T+oFz+TIyY4PlbemvazMDXLLJSnjqrI/loKu7dixH/CcMnlosTRyflUx4oG8JpRaJt3eV5kBA92Y1tttWV7EcrLY6CAHuIo1r5mfUpcu0Zdzp74gd7jKMYbYjfBTV9Ky/UTFKiFAPkPp8r3dPvL+qkzByOO5hYJ5x0FNP9d4jKNOWHu+kdXv/dg3hGTCQyqdvJJI25/v+Z5iQSppWrxFcBx+Yi+TmlwaOLsX0aL2rF+dZbpU1kPa6xsCi4EdLQLlmVJys07bYwwmcmGKHRhFumMQjM+v4siJqI3A7l4pAbhthD5ocwVCgY5FVxd6AmAx1fV/E4/I4GYheIf5+j0C9LWdbPSxvEhNCXJ/Qsez/oxxGjI0KvbYzKYFCY1xvrJCoCNDolyHlPxaW5NpUjttg3H9WtNQbbnK4WfnVSbciUYOt85EGJcTsijh4wtHm+lYamuy4A/9kPO+dZftBycR0Lg8dBe1UOeyzJG/tVMHEK1//R6nOWrN7db1qPgisVqq4+4Ruk5U/Fkuuc10F52fwtIo7DaRdbKfhSrg5qTzwfUI/FfhmXr5i1Q4BUf8fy8nbu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(6133799003)(18002099003)(18092099006)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTRIWDc3a05STVFNeG1DU1ZNQ0QxMitUSXBYOUZjdkpQNVB6WWEyNXo4eTJU?=
 =?utf-8?B?b3Z6U1pHL0REVW02cDFaWkhSQVdlb1FPYkxMTFp3dEtETjBSNWlWN2U4QmNL?=
 =?utf-8?B?TEdGZHJteldSOVp4T242REFuWEVGMUJUb3REOGVtOHdNUDNYM2NhaTk4UHM0?=
 =?utf-8?B?R252K3lmR3pkaE9yQ2l3eExBc2E5a3V3RXVlZzNzVW1LTFh2OXg1Y05Xd2Q0?=
 =?utf-8?B?QlU0cDVUaVdNeEdHOWhNL0NBVTRTSWRhdEJTVktqc3ZkUDBnWnl1QUdZeUp1?=
 =?utf-8?B?VUF4MjR5Y0JYUm1xODdaYjZPcGFCTjE0MVBjdENyMTBURldBOEh0RExJVEt5?=
 =?utf-8?B?WGxNYVFoOEpBb29FVmVEVVBXaUh6SlpucjVOVXhDSk1qS2JXNGZBcHFoMWpY?=
 =?utf-8?B?dnlGUW1IbVpiNnpiWWVoOVVYT0hKTDBZR3hpR0FzT0hMNzYrWVhGZ0EwbUlq?=
 =?utf-8?B?RkdvOWZQNDhob3hUbS9kMFVyOWJMNEdSS3VMNGUzQldQQTRwZkErSzZyOWdz?=
 =?utf-8?B?WWtZVFhWRDZDemM4ZWV2b0dJbFg3UmJXZXU0TmxhaWlmVUtodGRpT0Z3dkhU?=
 =?utf-8?B?dDlNdExVdGVhaUd4YUVWcDk1YkdXYjNRM0RDcksyME9KbXl5VDFYWEIzVTdo?=
 =?utf-8?B?Y2xRK1hPSkpZQTBiTXhaR0RzYzVtVjU2eFNjelJoUnJvbXBsWm1rZVYvUDky?=
 =?utf-8?B?N25TbytnN2dKQ2hVSjVtWXdWTUpZL3g2UVVCRDByTjBlR1BhRWZVOUh6c0k2?=
 =?utf-8?B?bE10WUs5aE53dHdOQmxWZW1OVDdKZGEvNndSa2xWWGZocVh0YlVwVjREalVL?=
 =?utf-8?B?Rjl2OXRkUEdDTUZBWC9iSTZWRGRsRGcwRmNEYXZHNGVRcFVRR0FpTXJFUHNT?=
 =?utf-8?B?SjRpc08wdm0yVUkxQVE1TUsrdzJRVlBqRFErWjBIS1p3QjhkR0UzVjhGWGJ4?=
 =?utf-8?B?YmJHNUxMcWdSbkZwZkczN0ZLa29xMnk2MVY4aXFrUEgzWmIyMEdkNlZsR0dj?=
 =?utf-8?B?L1hOejEyeGhicDFlWUcyMGJxOG9jOGZZVzNZc1JqRmxnZG4vOXY5TGpvMGM5?=
 =?utf-8?B?TUNDMmRXd0tmMkV3WlJhMkVRYy9IR0JCejRjNnk1U096aUNDSnN0Z0ZhWmQw?=
 =?utf-8?B?UExGcHZpMStuMGJJY2ZuY1lIT1VwMFhjUkpBcklyc2ZrTEI5SVh2ZS8xMjMy?=
 =?utf-8?B?d1Jnek01bG43R3JMNFh2Z1RiZDlHSzNPRWVISFQyTksrODRYaWxKcWoxVU1m?=
 =?utf-8?B?b2dKSGkxaHNyNnlrdFo5aS9zN0djL0xkMUhSZTlyUU9Vb2tEVEZoRHNoZDFj?=
 =?utf-8?B?Z0l3aTN6bGN5ZmJEN2tUZUxyYlhCRk4yMlZQclRoNWxXekVhUTlGOHFEaEt5?=
 =?utf-8?B?eEVETDQvemxoUVU0blNxSlROS2JRZnRRaDhVdzA5czRUYTJGMTluaW9jeDZz?=
 =?utf-8?B?UURpaUVUTldnb1BMcytmS0lPdlZOUEZxaU5HUnpWenpwelN1WkpSODJhMDA2?=
 =?utf-8?B?LzJ4REs1UTJoYW1BbVpQc3hZWWx0R3NUTVpIRmIzaEQyS1lhVE82VWIrdUJ6?=
 =?utf-8?B?cnZOcGVlc0laMVlpalA4b1djcW9rLzdqUExmY0k2NEkrb0xFR0M5STVLNEJi?=
 =?utf-8?B?YmlFaWxlaFlnbnRsVXdGV0NoMnBHZnhrY3RzNURJTDF6MGROVERpc21qd2hS?=
 =?utf-8?B?Z3YrR2pKOUNYY1NSVndEeDFUTEtwTG52R01nSnd5a1UwMWYrQ0RVcHVteXBx?=
 =?utf-8?B?b3NkZzBPYkhrL2FOUWNETTJUSnNvWC9scE5pRUY3Y3B5SElCekEvVC9JcTlh?=
 =?utf-8?B?TzlOelJpQkwzMEplSFNWeTVFWHFaYjNTbDVMM3EwdlFQWVpLTnNwLy9Ja1Bl?=
 =?utf-8?B?WVdiTDEvTEowTHZOWFhWem9admFaY1pqQVloVlJvZ0xKQWVsb3gxVjhVWkJC?=
 =?utf-8?B?UmM3VXF3RVNrb1lSNHZYT0pyYjQ4N0xuQzlEOWJmQzNUZFFVSEo5bzgwcXdU?=
 =?utf-8?B?cHZMdmZFOVRod1Q0UTh3ckVtUmZ2My9LbVFmMkpGRkdCVFc3eVJFS1kxZS9n?=
 =?utf-8?B?b1VkMFcvV0NlRjdlcjUrZjhndThnUHlmY0JvT1hxSFdTR3FBMXJ5Mm82OXN6?=
 =?utf-8?B?bi9zNlVKRnZLSDNVR0lYaUNUT09mZnNYUEY5eTl3aWoyRW5Hd01xc3B6YzQy?=
 =?utf-8?B?WmUxaUdldFVEa0pYK20rNXcrdldxRmlFeDV5RTkyN0RXYkxDUHZvQW9JSHVV?=
 =?utf-8?B?VDJXVThhbnQ2ZlZFZk1YU1JiZ3VqbmNKMDZFa0pSdkhvam1ZT3dhQi81RHgr?=
 =?utf-8?Q?48XSdSd2SRzAOy98kv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ff6592-cb16-4932-bd25-08dec4d82319
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 21:02:51.6075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svR3TFlj5t9WWVIo9tGgh+hXFP6ar5VlhG6FAJpgdmerP864tiZM49AthAQ0KjIR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

Hi Andy,

Thanks, replies are inline.
On 07/06/2026 08:31, Andy Shevchenko wrote:
> 
> On Sat, Jun 06, 2026 at 06:17:06AM +0100, Salih Erim wrote:
>> Add threshold event support for temperature and supply voltage
>> channels.
>>
>> Temperature events:
>>    - Rising threshold with configurable value
>>    - Over-temperature (OT) alarm with separate threshold
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
>> The interrupt handler masks active threshold interrupts (which are
>> level-sensitive) and schedules a delayed worker to poll for condition
>> clear before unmasking. When no hardware IRQ is available, event
>> channels are not created and interrupt init is skipped, since the
>> I2C regmap backend cannot be called from atomic context.
>>
>> When disabling a supply channel alarm, the group interrupt remains
>> active if any other channel in the same alarm group still has an
>> alarm enabled.
> 
> ...
> 
>> +static void sysmon_supply_processedtoraw(int val, u32 reg_val, u32 *raw_data)
>> +{
>> +     int exponent = FIELD_GET(SYSMON_MODE_MASK, reg_val);
>> +     int format = FIELD_GET(SYSMON_FMT_MASK, reg_val);
>> +     int scale, tmp;
>> +
>> +     scale = BIT(SYSMON_SUPPLY_MANTISSA_BITS - exponent);
>> +     tmp = (val * scale) / (int)MILLI;
>> +
>> +     if (format)
>> +             tmp = clamp_t(int, tmp, S16_MIN, S16_MAX);
>> +     else
>> +             tmp = clamp_t(int, tmp, 0, U16_MAX);
> 
> No, please, use clamp().

Accepted.

> 
>> +     *raw_data = (u16)tmp;
>> +}
> 
> ...
> 
>> +static int sysmon_write_alarm_config(struct sysmon *sysmon,
>> +                                  unsigned long address, bool enable)
>> +{
>> +     u32 shift = address % SYSMON_ALARM_BITS_PER_REG;
>> +     u32 offset = SYSMON_ALARM_OFFSET(address);
>> +
>> +     if (enable)
>> +             return regmap_set_bits(sysmon->regmap, offset, BIT(shift));
>> +
>> +     return regmap_clear_bits(sysmon->regmap, offset, BIT(shift));
> 
> regmap_assign_bits()

Accepted.
> 
>> +}
> 
> ...
> 
>> +     u32 alarm_reg_offset = SYSMON_ALARM_REG + (event * SYSMON_REG_STRIDE);
> 
> Unneeded parentheses.

Accepted. Will remove in both places.
> 
> ...
> 
>> +             for_each_set_bit(bit, &alarm_flag_reg,
>> +                              SYSMON_ALARM_BITS_PER_REG) {
> 
> I would leave this on a single (83 characters) line.

Accepted.

> 
>> +                     address = bit + (SYSMON_ALARM_BITS_PER_REG * event);
> 
> Unneeded parentheses.

Accepted.

> 
>> +                     sysmon_push_event(indio_dev, address);
>> +                     ret = regmap_update_bits(sysmon->regmap, alarm_reg_offset, BIT(bit), 0);
> 
> Why not _clear_bits()

Accepted.

> 
>> +                     if (ret)
>> +                             return ret;
>> +             }
> 
> ...
> 
>> +static void sysmon_unmask_temp(struct sysmon *sysmon, unsigned int isr)
>> +{
>> +     unsigned int unmask, status;
>> +
>> +     status = isr & SYSMON_TEMP_INTR_MASK;
>> +
>> +     unmask = (sysmon->masked_temp ^ status) & sysmon->masked_temp;
> 
> Is this the same as
> 
>          unmask =  ~status & sysmon->masked_temp;
> 
> ?

Yes, that's equivalent, Will simplify.
> 
>> +     sysmon->masked_temp &= status;
>> +
>> +     unmask &= ~sysmon->temp_mask;
> 
> The above needs a comment explaining the logic.

Accepted. Will add a comment explaining that we only unmask
interrupts that have cleared in hardware and are not
administratively disabled by userspace (via temp_mask).

> 
>> +}
> 
> ...
> 
>> +static void sysmon_unmask_worker(struct work_struct *work)
>> +{
>> +     struct sysmon *sysmon = container_of(work, struct sysmon,
>> +                                          sysmon_unmask_work.work);
> 
> Better to split as
> 
>          struct sysmon *sysmon =
>                  container_of(work, struct sysmon, sysmon_unmask_work.work);

Accepted.

> 
>> +     unsigned int isr;
>> +
>> +     spin_lock_irq(&sysmon->irq_lock);
>> +     regmap_read(sysmon->regmap, SYSMON_ISR, &isr);
>> +     regmap_write(sysmon->regmap, SYSMON_ISR, isr);
>> +     sysmon_unmask_temp(sysmon, isr);
>> +     spin_unlock_irq(&sysmon->irq_lock);
>> +
>> +     if (sysmon->masked_temp)
>> +             schedule_delayed_work(&sysmon->sysmon_unmask_work,
>> +                                   msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
>> +     else
>> +             regmap_write(sysmon->regmap, SYSMON_STATUS_RESET, 1);
>> +}
>> +
>> +static irqreturn_t sysmon_iio_irq(int irq, void *data)
>> +{
>> +     struct iio_dev *indio_dev = data;
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int isr, imr;
>> +
>> +     guard(spinlock)(&sysmon->irq_lock);
>> +
>> +     regmap_read(sysmon->regmap, SYSMON_ISR, &isr);
>> +     regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
>> +
>> +     isr &= ~imr;
> 
>> +     regmap_write(sysmon->regmap, SYSMON_ISR, isr);
> 
> Is writing 0 necessary?

No. Will move the ISR write after the if (!isr) early return.

> 
>> +     if (!isr)
>> +             return IRQ_NONE;
>> +
>> +     sysmon_handle_events(indio_dev, isr);
>> +     schedule_delayed_work(&sysmon->sysmon_unmask_work,
>> +                           msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static int sysmon_init_interrupt(struct sysmon *sysmon,
>> +                              struct device *dev,
>> +                              struct iio_dev *indio_dev,
>> +                              int irq)
>> +{
>> +     unsigned int imr;
>> +     int ret;
>> +
>> +     /* Events not supported without IRQ (e.g. I2C path) */
>> +     if (!irq)
>> +             return 0;
>> +
>> +     ret = devm_delayed_work_autocancel(dev, &sysmon->sysmon_unmask_work,
>> +                                        sysmon_unmask_worker);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
>> +     if (ret)
>> +             return ret;
>> +     sysmon->temp_mask = imr & SYSMON_TEMP_INTR_MASK;
>> +
>> +     return devm_request_irq(dev, irq, sysmon_iio_irq, 0,
>> +                             "sysmon-irq", indio_dev);
> 
> 
> 
>> +}
> 
> ...
> 
>> +static int sysmon_init_hysteresis(struct sysmon *sysmon, int address,
> 
> Can address be negative?

No. Will change to unsigned int.

> 
>> +                               int *hysteresis)
> 
> ...
> 
>> +     ret = regmap_read(sysmon->regmap, upper_off, &upper_reg);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = regmap_read(sysmon->regmap, lower_off, &lower_reg);
>> +     if (ret)
>> +             return ret;
> 
> Half of the IO accessors have no error checks, these do.
> Why is this inconsistency?

The regmap calls in sysmon_unmask_worker and sysmon_iio_irq
have no error checks because they run in contexts where errors
cannot be propagated (workqueue, hardirq). The init path checks
errors because it can return them to the caller. Will add a
comment explaining this.

> 
> ...
> 
>> +     if (has_irq) {
>> +             temp_chans = temp_channels_with_events;
>> +             num_static = ARRAY_SIZE(temp_channels_with_events);
>> +     } else {
>> +             temp_chans = temp_channels_no_events;
>> +             num_static = ARRAY_SIZE(temp_channels_no_events);
>> +     }
>> +
>>        sysmon_channels = devm_kcalloc(dev,
>> -                                    size_add(ARRAY_SIZE(temp_channels),
>> +                                    size_add(num_static,
>>                                                num_supply + num_temp),
> 
> It makes inconsistency. Even originally. It should be two calls to size_add().

Accepted.

> 
>>                                       sizeof(*sysmon_channels), GFP_KERNEL);
>>        if (!sysmon_channels)
>>                return -ENOMEM;
> 
> 
> ...
> 
>> +     irq = fwnode_irq_get(dev_fwnode(dev), 0);
>> +     has_irq = irq > 0;
> 
> This misses deferred probe.

Accepted. Will check for negative return and propagate.

> 
> ...
> 
>> -     ret = sysmon_parse_fw(indio_dev, dev);
>> +     ret = sysmon_parse_fw(indio_dev, dev, has_irq);
> 
> Why do we need has_irq? You can supply irq there as well and check it against 0.

Accepted. Will pass irq directly and check > 0 inside
sysmon_parse_fw.

Regards,
Salih

> 
>>        if (ret)
>>                return ret;
>>
>> +     if (has_irq) {
>> +             /* Set hysteresis mode for both temperature channels */
>> +             ret = regmap_set_bits(sysmon->regmap, SYSMON_TEMP_EV_CFG,
>> +                                   SYSMON_OT_HYST_MASK |
>> +                                   SYSMON_TEMP_HYST_MASK);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             /* Initialize cached hysteresis from hardware registers */
>> +             ret = sysmon_init_hysteresis(sysmon, SYSMON_ADDR_TEMP_EVENT,
>> +                                          &sysmon->temp_hysteresis);
>> +             if (ret)
>> +                     return ret;
>> +             ret = sysmon_init_hysteresis(sysmon, SYSMON_ADDR_OT_EVENT,
>> +                                          &sysmon->ot_hysteresis);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             ret = sysmon_init_interrupt(sysmon, dev, indio_dev, irq);
>> +             if (ret)
>> +                     return ret;
>> +     }
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

