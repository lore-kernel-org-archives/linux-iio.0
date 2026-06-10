Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9899240D57E;
	Wed, 10 Jun 2026 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092420; cv=fail; b=VZ0JhmTUI11lBnYhyUUdf7CPmMxEv2KzEux1Ha6fJOmCfw0m3DkARZ92T6nRx2xWvSklQYRLA9RyH3G6b6QWodKNwEQScC0+p9RwreMBm1rNIPVBrd+jRpVsyB4TU3giWuCP/e1OHxp4wsxOaQUUq5RmVZnV1himeZu+8eKt8os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092420; c=relaxed/simple;
	bh=GJfBDOlAfBeJ60EoHfIszmxObmb3jokk6+adw8tzCbA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ivzdA2KCZ4BE71YVVm7pH/VvCrJjWkWosZMCnmEH17WBUYL1aS5/3176jQERndet1tWq3oZCUV0SIDXN1LwUwrtRSm5sntUUOECzj+BONCvJhdtkpJT9s0G/zoAoUFTkMki6k6ebHwHfNpPGWmRYU7iH8fwAivi7nA4xhelKvjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GDQKLx48; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GDQKLx48"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9gVkv1aLanHqCxH3GDVbHeefgRHYBVUP4GIaBOv+0oztDtPCnII4sKj1cgRrxIk34cIIUNM1iSRt2bPvOJHwf4q6tT0JeN1dh1JPu1JGSuq80gc2s8cJjFA3+fNpQ0Kj+1oR3/DHPrWRX/qy/P9GyEWV6jHMHOW90NxvFknPLpyu/nvfRBPwyj/nZgi7i+hZePtrpF0A06rlepjQqadhiYanHIcK71oZByEZF00RfXkaBo3IK8isXfpiLKw01hbE84M+3nunMx08byAv+JYPjcj1JRiGHhjxrAq39Z9t77Vv04av+TxIBtNAVcK0H3KNcMHVoeQ+SLsRyvXwKYRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmo1J6VMIKyeDjIkDg7ycxDAtzUiVfaNIWIDPsetQJM=;
 b=IFVqueTQSoo9qaiySFkafLcsGv8SGZezoN8qWvdwEys+0RGsXSENOgkUNNuwIFkdKORk4FQ6acuqMPOuj/ChgSMUobP3M/1Ic5DKmIJNxeAoJ0R0+l3sBtP7RspXAEyfi5zkp43kHOckTSleiyEjdzusDOGglkDT1q2SsaxEwsZ+FjU0DG6LB6pt7uFd3Tc5fAJ6zZ7T457aNL3ACiU4sXYtH8zq/xndm2nns4+YXtaBnOeq3jrLhVz2BbRGQpQGbB8ki77Xvdu/GjReeOWLiRwUgFJk9SlpCKAuGlMRqKB0qUk1/0fQ4NivDWHefe3O+5c/sB48N6Uo8RX+wrJjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmo1J6VMIKyeDjIkDg7ycxDAtzUiVfaNIWIDPsetQJM=;
 b=GDQKLx48e0PjdEqH5iLHOUfxmXk9FBUYIFYRmWK9yAO4hXChuGtVpi9oGcvpIMULt6X6BYxEjRvTWu5bPj+znvDdrdyYWI9NZqblkB0Sr4d1+MFt2XvVsrBLJtMj/qlUbyu6deshqYzc6woQjfs67AoybC+W5uy5eSEhWDTxvqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 11:53:33 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 11:53:33 +0000
Message-ID: <154b86ad-052b-477d-ab76-1c91d8089ec1@amd.com>
Date: Wed, 10 Jun 2026 12:53:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] iio: adc: add Versal SysMon driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
 linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260608183801.1257051-1-salih.erim@amd.com>
 <20260608183801.1257051-3-salih.erim@amd.com>
 <aigsBk5pj0w8rfFZ@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <aigsBk5pj0w8rfFZ@ashevche-desk.local>
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
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: d8564a0b-ba10-4d78-bbac-08dec6e6e5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|3023799007|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f0BDjwpi6y+DlaeJFlYoxdDGi5YGg59jfkyRTk4ZWV/+367EChsFvNYsgp6ntVOo8tSKPGbzZn0PmSapwkQ0NCkjAbaw8EauFucWHtsLBb00FPu6loeIbcMx5HqRogcYCfOTLT6gLRImX709h4jMEaKOBrg3SrZ2k25yViXBvCzcf/BZYBON//ndUoI8F1DBjWFUiP5QNABTyMiWSszOl97h1Al9Kbov/YujaVPl5+jkDIqJQK7um170qnZ84TQEnfgDT8bWJH/3EoDN/towyVgJAzfns3nTzowku+9Lk815SzsA83MIpfIUdU+XkXbm2N89iZ084QLtxPGcf+6AvLib3ByXTcEdsae2X93fDFqR7XdGyPisxh9jlPqhY5g/BipE2DD07WO45mrQuhY+sVv8O57ms9GKKnvGPhGDwlTICuw4O5k09Czdl90lnAGwzASUSd8PR9GCBP7kJMuFLGys8bHOg8SRY1HAiiu6KnnBaT9x6D0HYgj7BPr0BLYSGrC2lL/xlJgcwqMCtBTMS+K4LBJdAWLKP/BEhRKeVLqW2QgKUAZmFcyXf6QytYv5/x4vZJFH/ENyTVZTVL2FLShjS21Lk8sXtIsnt9Fq3CD75OLs7oHuSg1lkmYiiRYaiVXgas2+Ise9Eih53dOtQsBUtMfQT0LkmF2MyMeJlOCdTWDjnO83cTmGx3LU1iq0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(3023799007)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW4vYTZWMmZPM1QzS2taS1lwaDhvU09PZDJsNTc1bkxPQUEzNUdkN2JjdnJQ?=
 =?utf-8?B?M3VvcmQ1UkV2VmVWbHR1Y1hnTURGbVRxWFJTUzl0UDBuQkU5RldSMjQyUkF2?=
 =?utf-8?B?WlpjU2VvNVVZRHMyeWJTSHFHaW5UN2V3YklrL1ZCTS9DYm14aExCbDB3blpx?=
 =?utf-8?B?NENzcllSWEhmL2tmUC9WOURmeVQ1K21PTkR5Rk5WZDl2RUZSTEZDS2tCUE5W?=
 =?utf-8?B?TnV2dURleVhJMWVibGRiOGZQTS83bEQzSDVZN3UwbTd2a0NVdDhhZGNDMFVY?=
 =?utf-8?B?S2hNWTZ1bHFYYUVoL1AvZTN4WW9MOHpIai9SZ2xtVXUvaFdYMGtUbWlZejJV?=
 =?utf-8?B?UThycHhzS24rZGVuQlZLdDFGcExIOTIzbm0zOVNISEMxaGtUcDN4eEhudGc2?=
 =?utf-8?B?N2NhdURIdWVuUGZLZTBVU1F3cFAwQXhEMm1oYlRKRThId0FxYnhWNDBXaHVq?=
 =?utf-8?B?NlMzdkpFZ1M4VnExaUpIT1Z5dGY2ellITGZYcENycG5LNUVnb2w5djlIZ1Rn?=
 =?utf-8?B?N3VpaHdIN3k4WDdBcmY5b1RyVFkvbDJ3cTFncWZ6QlFBQWNjMVNrcHJZdDRP?=
 =?utf-8?B?RVUyblRpNWd4ZEJSZXl5OHNsakRsOE1HUVlaNC9XQVNtUHdNTlMwajdoVVRp?=
 =?utf-8?B?dlloVlN2dGZFcWxmcVpWTldiT2E5TDE3K05CWTBZOEo3SlQ5eWxXRTNrRyt3?=
 =?utf-8?B?MHp5WFVqMlpKUmRRNEVJSmJ6dlhDQnM5b3djK1czSm9SNUozZHhNQzYySUsw?=
 =?utf-8?B?MzQ5a3JPdEF6dWRWUUo0YkR2enZRSTJWNHVJQVhkL20vcVgvQXEvUVJyWjdY?=
 =?utf-8?B?MDJkeWVkZSsxTjJUL0dsK2dPU2ZveGIzSVBVK0J0Ulo4a1RFVHl1UTRxdHVS?=
 =?utf-8?B?SStIek4xWGRlVzhDdnNsdi9NOUp5RXllSnpzWnZWUDQ4WHpBU01kazRxeXJq?=
 =?utf-8?B?YkRWWUg5SG5hb0cwWVNNWmI0N1ljVDhpZnZTQmMxZXNxV0E4cWFOL25YOElF?=
 =?utf-8?B?OG00RjZDdFJIWnBTb0doVXJESU02Rm02ZmZabnpsQnVmc0RaaENXM1JXclVV?=
 =?utf-8?B?RVNsWVdjNzFQKzUxU3lIWkVGKy9pOXRZNE1jOVdEZG9LaXlxblY4Mi9TK2s2?=
 =?utf-8?B?WGlXVE1Ea3pUTE9vL0gzNytIZzcrS3diRDdYTjhsSjEyVk1sZ01pcjdhZVFv?=
 =?utf-8?B?cW01QW9nbXZmRnJoY1lIbncrQnR0cUlsVnF0V2Jlbk5xRGhkRmdvRWdZQkEr?=
 =?utf-8?B?cDNFYXpqL0JEcm5hR3lBSktNSVQ3cGZIY081Z2ZZU3R2emtoMld5WEdQSkYx?=
 =?utf-8?B?c294enZXMDJGY3RyR3lVaElKQmthL2JjcUdWc3hmQ2NmdFNvMzJXWjJkQ3Br?=
 =?utf-8?B?eWJ2Q3lVdXhoNVF4NS9QZVZDbTVzd2paNlVSbHdiVS9JY1NxY2lUZHBLMEl1?=
 =?utf-8?B?eXh3elNSUU16OGw1RjFmY2UwVU85U0hoUjBUVTZYR2JOUzA0TUFneUROWWF0?=
 =?utf-8?B?ZURoRU5JdXQ1dGJ5MjhUb0FLQzdPc2VhM21jVmVoR0t1bUFEdHdmckxkdVNy?=
 =?utf-8?B?TjdMMy9PcDRxdDA5RU55UWhtWURMbENGN0dZUG52RWhWRjloN3ZEWWFoQlEw?=
 =?utf-8?B?YWVpVE40bU1TazU0U2JlZXVTWkVGTWUzRGNGekVGaUFrbnpzWHd1Z0dxSzk1?=
 =?utf-8?B?dTlOdnJZd3B2MGdzdTJkWFhrdWxuWitLMVovWFhjb016QjNLZnQyVTJQR280?=
 =?utf-8?B?RjVWUXZEbUJTajViR1owc0w2ZVdjRnN4VmsrcjRLaWdQUTFNQkRBVWM3a2VO?=
 =?utf-8?B?eU5NcWlEZmUxcmZiL0I4R1BYTHJYVXkwaVErbzZjaXNScmVySkc5UlY2TmtF?=
 =?utf-8?B?Y2s0a2pmQXRvNUI5bzFSay9WQlJwcnhuVnNvYzhVekJtaXZUSm00QWNCajRP?=
 =?utf-8?B?YW8rclNpTzdZRTUwTy9EUmZmWlJjQ1hDcWhGeURVaDJGNkp3TmppOUthQisv?=
 =?utf-8?B?NGVXTUdmYW5qWEhKM0taVjZOazZKTGZ0ZkdNcFdmUFpubXZDeEZSajdqOVRr?=
 =?utf-8?B?Z3B5TlBLdHV0YlJLM0h1bmpwK3NFOEVKTUk3RUtOek05b2dtMTZwdHJ2TXFY?=
 =?utf-8?B?MlgrdWVVODR0cjA1cDdFTFQvblliZWlMTG1LVkR2QjV5VEMxcmc5ZVdOTlpG?=
 =?utf-8?B?bXdsczE1dDZ2TGxvZHFpUGtQKzNRTmhqQlhhZjVXZm50VFR2Qk0xelJzYUxU?=
 =?utf-8?B?bkxXLzVvb3hNbFhJVWQvMTVkZStSZkNtdkVmekZkSXhxMDcvUGdsZnl1d1BY?=
 =?utf-8?Q?zRwiPJJxPfe/mmVGrM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8564a0b-ba10-4d78-bbac-08dec6e6e5bb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 11:53:33.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LHuifCjm2lafIejff1RvV4+q7z/zEmE4t3bRkmFhyivQ0FTc/q3z/lCVRqlbbms
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427

Hi Andy,

Thanks for all reviews.
On 09/06/2026 16:06, Andy Shevchenko wrote:
> On Mon, Jun 08, 2026 at 07:37:58PM +0100, Salih Erim wrote:
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
>> The driver is split into three compilation units:
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
> Almost there.
> 
> ...
> 
>> +static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
>> +{
>> +     unsigned int num_supply = 0, num_temp = 0;
> 
> Unneeded assignments.

Accepted.
> 
>> +     unsigned int idx, temp_chan_idx, volt_chan_idx;
>> +     struct iio_chan_spec *sysmon_channels;
>> +     const char *label;
>> +     u32 reg;
>> +     int ret;
>> +
>> +     struct fwnode_handle *supply_node __free(fwnode_handle) =
>> +             device_get_named_child_node(dev, "voltage-channels");
>> +     num_supply = fwnode_get_child_node_count(supply_node);
>> +
>> +     struct fwnode_handle *temp_node __free(fwnode_handle) =
>> +             device_get_named_child_node(dev, "temperature-channels");
>> +     num_temp = fwnode_get_child_node_count(temp_node);
>> +
>> +     sysmon_channels = devm_kcalloc(dev,
>> +                                    size_add(size_add(ARRAY_SIZE(temp_channels),
>> +                                               num_supply), num_temp),
>> +                                    sizeof(*sysmon_channels), GFP_KERNEL);
> 
> Something happened to indentation of the third line (out of four). Taking into
> account nested size_add(), I would rewrite the whole thing as

Accepted. Will use a temporary variable for the channel count.

> 
>          sysmon_channels = devm_kcalloc(dev,
>                                         size_add(num_temp,
>                                                  size_add(ARRAY_SIZE(temp_channels), num_supply)),
>                                         sizeof(*sysmon_channels), GFP_KERNEL);
> 
> Or even use temporary variable
> 
>          unsigned int num_chan;
> 
>          num_chan = size_add(num_temp, size_add(ARRAY_SIZE(temp_channels), num_supply)),
>          sysmon_channels = devm_kcalloc(dev, num_chan, sizeof(*sysmon_channels), GFP_KERNEL);
> 
> still over 80, but a bit shorter.
> 
>> +     if (!sysmon_channels)
>> +             return -ENOMEM;
>> +
>> +     /* Static temperature channels first (fixed indices) */
> 
>> +     idx = 0;
> 
> Why?
> 
>> +     memcpy(sysmon_channels, temp_channels, sizeof(temp_channels));
>> +     idx += ARRAY_SIZE(temp_channels);
> 
> Just

Accepted. Will initialize idx directly.

> 
>          idx = ARRAY_SIZE(temp_channels);
> 
>> +     /* Supply channels from DT */
>> +     fwnode_for_each_child_node_scoped(supply_node, child) {
>> +             ret = fwnode_property_read_u32(child, "reg", &reg);
>> +             if (ret)
>> +                     return dev_err_probe(dev, ret,
>> +                                          "missing reg for supply channel\n");
>> +
>> +             if (reg > SYSMON_SUPPLY_IDX_MAX)
>> +                     return dev_err_probe(dev, -EINVAL,
>> +                                          "supply reg %u exceeds max %u\n",
>> +                                          reg, SYSMON_SUPPLY_IDX_MAX);
>> +
>> +             ret = fwnode_property_read_string(child, "label", &label);
>> +             if (ret)
>> +                     return dev_err_probe(dev, ret,
>> +                                          "missing label for supply channel\n");
>> +
>> +             sysmon_channels[idx++] = (struct iio_chan_spec) {
>> +                     .type = IIO_VOLTAGE,
>> +                     .indexed = 1,
>> +                     .address = reg,
> 
>> +                     .info_mask_separate =
>> +                             BIT(IIO_CHAN_INFO_PROCESSED),
> 
> Perfectly one line. Is it going to be expanded in the next changes?
> If not, join.

Not expanded. Will join on one line.

> 
>> +                     .datasheet_name = label,
>> +             };
>> +     }
>> +
>> +     /* Temperature satellite channels from DT */
>> +     fwnode_for_each_child_node_scoped(temp_node, child) {
>> +             ret = fwnode_property_read_u32(child, "reg", &reg);
>> +             if (ret)
>> +                     return dev_err_probe(dev, ret,
>> +                                          "missing reg for temp channel\n");
>> +
>> +             if (reg < 1 || reg > SYSMON_TEMP_SAT_MAX)
>> +                     return dev_err_probe(dev, -EINVAL,
>> +                                          "temp reg %u out of range [1..%u]\n",
>> +                                          reg, SYSMON_TEMP_SAT_MAX);
>> +
>> +             ret = fwnode_property_read_string(child, "label", &label);
>> +             if (ret)
>> +                     return dev_err_probe(dev, ret,
>> +                                          "missing label for temp channel\n");
>> +
>> +             sysmon_channels[idx++] = (struct iio_chan_spec) {
>> +                     .type = IIO_TEMP,
>> +                     .indexed = 1,
>> +                     .address = SYSMON_TEMP_SAT_BASE +
>> +                                (reg - 1) * SYSMON_REG_STRIDE,
>> +                     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +                     .info_mask_shared_by_type =
>> +                             BIT(IIO_CHAN_INFO_SCALE),
> 
> Ditto.

Not expanded. Will join on one line.

Regards,
Salih
> 
>> +                     .datasheet_name = label,
>> +             };
>> +     }
>> +
>> +     indio_dev->num_channels = idx;
>> +     indio_dev->info = &sysmon_iio_info;
>> +
>> +     /*
>> +      * Assign per-type sequential channel numbers.
>> +      * IIO sysfs uses type prefix (in_tempN, in_voltageN)
>> +      * so numbers only need to be unique within each type.
>> +      */
>> +     temp_chan_idx = 0;
>> +     volt_chan_idx = 0;
>> +     for (unsigned int idx = 0; idx < indio_dev->num_channels; idx++) {
>> +             if (sysmon_channels[idx].type == IIO_TEMP)
>> +                     sysmon_channels[idx].channel = temp_chan_idx++;
>> +             else
>> +                     sysmon_channels[idx].channel = volt_chan_idx++;
>> +     }
>> +
>> +     indio_dev->channels = sysmon_channels;
>> +
>> +     return 0;
>> +}
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

