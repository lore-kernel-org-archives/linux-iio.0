Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93121406281;
	Mon, 15 Jun 2026 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538083; cv=fail; b=Mp0jCJmxj5cTZyuwuXZLBTxOt0QhoedJxNln8jtpGHYuabCIqDjZ7jY+8s9NWGqFt29XdSnE2cm+CZcxyOz6Ffx3U9cDA3wLx3VQ3SIAmyOX0/YpW7lwNSyoyQh2iquJOA9CjiGzUzYxjq3pOFDKVf81vE7ArA+byFyt4e1xgk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538083; c=relaxed/simple;
	bh=FiwTSftOC8j/PPfBQdN0nUQb5xvxidTVLbaXSdczKn4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ArBZ1GZ3+dHEv+C2CVcQagL/+IocFN+5Rv+d8XnB4a8wvkpKJeV+W7kG1LYA0m8KTm6dFG4XbN17EmG2H6CBL6nIVG63jFR1vuq8KjJLWkFFyKds+uUYE8Cqi+16rmEiQNBkdLWtmWURBPU0S2aC6JfgSH6KBaeTA/H1DvW8qDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sKawbtup; arc=fail smtp.client-ip=40.107.209.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sKawbtup"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dm3sG9zBpi5PwVtXI0bwiTat66TjGa5yYFE/UkvXvmEMovIpil7+fWDVBVW5d2IbVDNQoF+0xuKu156GMp90AVUDkJBdwwwqjNEHj1JnOFS1yNlSrQ643agb5gzK+kRCQA11tWX6EJiJlN/jXe7Y59zhuh9v1aK6zTz+Z0bF7DZRlDBVUraZh3sr+1cV0H9hvNBvnaItJbbf087CvA/5sKcUG0GhRiqCY+g0VoSTWMn4kfxW6Fd/9KmzAm0KP1AoqmF0LgUJm0QLMv0IMW+qg1uE+ccR/CsXuE4g38pgmJ3XG+u0n+pu8QEj+e31tLfIehwNQY/3d804cw0ixcohPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/Mkeab5tkDLLmdEbbzRY2CBZdPgQEMBImictorD/FE=;
 b=oQ5XmpZ1zLXd0mhU43D9HT++WPRtzHcAEAIPcDO/jwL1mSrdKv3tGN2bKTxB8IWV6DC67ZBhlEK6+nwp/3YTooMrC4n4Dijb3QraWQ2yUu6I7/MD+4t55B68+ZriW2oDuaIAyKb0mrQi3qCxEbqeHQRVmGjRMCqu4jd5nRbfTPgTQVneH8XUpIftqJyptma1bwcMMml3K4rGGFHSg+ztl9JiI6XxmLoggFrnYFsuAySeIGjunVh+4ZVaipOPtmlwokcanxVkjYGOAEsAse9gknT85oGJ2/fJ4Txow9PkEQXpaWk8D7dndaghs469nvKiPlAMg0FEU0C4invxKo/90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/Mkeab5tkDLLmdEbbzRY2CBZdPgQEMBImictorD/FE=;
 b=sKawbtup88qMVeGWDkdpWAEOgdmDsXZyoD+zi+1nHTFtYKg4fYE/EGuXifAPOFIw4J/SVNvQBXsOXa0eKpfqaWuezfaDNI+AlTdUf6712kYzvkXPGGzGsmPBEyHndZHz7NliQB77wzvx54DLqLOWneoPTbYjDZmgVaLe0XptN9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:16 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:16 +0000
Message-ID: <2998a9fc-4b9f-49bd-8020-697081401f85@amd.com>
Date: Mon, 15 Jun 2026 16:41:12 +0100
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
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <ajAKkqMO5jdQjKgS@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0045.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::7) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f20a4ab-f16f-49ba-fc9a-08decaf4898f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|22082099003|18002099003|4143699003|6133799003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	7uONAtXIw9CP/ljh5zeMAAcgSnXrZsaHHuXNHH0YWi4BLVoMooiRcfGBE+UZQknHOdUgTyR1JA19fPvFgeF5NKG2N9plzz55sksM3WATUhB4dT0iTkH83DDaTy6Bqm/h72O0jc5b+3IhiLOvdaxpyMF9eoMdvwb1mvjpdleDkN/ABfWE51b8wWbueGHHNb5Lu06H8L+vF1zwok4C5RVr2DAimTo7lRSzmWR24CcYSPyFQW3I6jX6lhrbJWguCgvdsKulPM/83/8Sxdzhi1RCYAMQgv/1mjN/lM6YRJEVKvHWw3kmN5bKkpsPp2VsTO1/a2MkmWbQEU2AVWixGg92oFuI/bwBxO+fPPKkyZ/tI3uIG6ZghfvaZYE8CkyXaitP1Ob/hz2ywlHQcwzZZje0bNW87NUT9PCiEaW6E92wqJa0UVHB73PWdSir7Lg1x8wNfsc5G5IIOg1KlIL3+jtbduH6qTBhYvlMHckHEKoPhuaWOiq4Fmezy4uK9s+pmVZaP8OQYBZMjLQvAr5aBBA4q3vJpQ/lqunpAD2bR8BLcEWsEjvkkPWcUZo316S+uvRvOqRYTvegTFBdKsDE4qSWO1o8QnPMyZUmH0euQWkXXDbJrMKlN5ZH9HpxwNk+5KS5PNBP1LfTzdPqSrG48LlVK0kt/pQyKZv2y8w7HvRVe+aTAxJh6FESibDEhdR+ij8/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(4143699003)(6133799003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1Bnam9yQVV6LzBHWVNGcm9USU5uMG9pOFVVWWxreGVaeFVLbHRnZnVEd1pS?=
 =?utf-8?B?TnBERzU4dXBzN3E1dUlFU3NmN1hHN2JnVGRqeTNEK2ZnK3BuTEEwanQ2d1dU?=
 =?utf-8?B?UnZMMUNIeDhxSkRmY2N1bEdKT2tWKy9rd3hKaHBoN2ZtNGRXbjJJUnVLSWls?=
 =?utf-8?B?dmlpQS91bGJlWDJSTmZRc25yVEdyalkyeUxvZTZ4dktDTjBzTW5iS1FZZXY1?=
 =?utf-8?B?djNEQWZaS0JXbTJGUGlLUDg0d1NpcmhGNUJVSHZCSW4vMGxWTGh3R3VwRWR5?=
 =?utf-8?B?TURSUjBpRnVUUXJpc2dQU3lVdlVaSmZKaHEyYnRmcGhyNHo0aVBYdVVTKy9M?=
 =?utf-8?B?K3RaanhFc1VqS0xTTDdHQjRkdlhSYmpsM0xRMU94a0d3SlR6dllsVHBOazEv?=
 =?utf-8?B?T1Q4UnZkaDk0TFo1NHRaQnZkbzhFZ1FtMWFUVWpWN1BxYWwrTjgwS3lqeG9O?=
 =?utf-8?B?NHgwRitzdVFsQ1VoMG1RWTZqQlFhbHAxM3dTZ3IvbWlmYldOcEM0VkRNc2xU?=
 =?utf-8?B?RUZaa3QxeU5PUm5vOHI1Z0FGNys1UGhQNXNGMExhK3o5SjZpL0ZvZG9hSCtl?=
 =?utf-8?B?S0E4bHpocmdTemE0QVlNTzhPSncrdWxvbEhsQURDdVA1d1ROUkJUWE9kYUtB?=
 =?utf-8?B?SXpVRjczS2Nma08zWVdmV3VJQUc5SS9NZmRpamMvMUxEd2g4L1lidTN3RjdH?=
 =?utf-8?B?MzgrL0xIV0V3ckp5UXFHcDhHWXVoVEJyeCtRcGpYOG94SDhGNWxtK1g2T0NI?=
 =?utf-8?B?UXJOS3MvMGltWFA0R1pkQTVwY1JzQUpPckR2TzNuM3lUckZFT3U4UmxpYnZa?=
 =?utf-8?B?WUI5NnlFc0dVZUozVDU4K2k2Q2t5NXZUdDN5ZG5vdU1jRFZTZmJtS1E2VW9h?=
 =?utf-8?B?eUJvU29INDU2dEpsSjZPVDdYd3BsUWgrMU01SWJMWFd1QytiOWtlSW82cnFQ?=
 =?utf-8?B?TFQ0SlpEbUUwR0dYMjlGbEpPRXhmQ3hndVQva0YzRmlubldxT24vanhnaWpH?=
 =?utf-8?B?ZnNua1Exd1A0cUkvWmFwSkdBZlAwa2o2bUlHbEZwMzFrRnhseG45eW9TY3Zi?=
 =?utf-8?B?eHY1SVVaTW1zSFRQcXNMQkNwT3lmaG96TW5GbWlrL1B6TGUrUG1hdHVWdkpy?=
 =?utf-8?B?VnBWeWVJclFaVVgxWklkVG9Pei81SFlyMHdoTU9kMDIraGxsbkFmL084dlV2?=
 =?utf-8?B?b2FCSmh0ZEJDU0tjVlNUK2ttZzAybDRpYnpmQmlYQlVNWjRhUnJpdWJ1RkFK?=
 =?utf-8?B?VFMwL2d2RXBXZEZMTWd0dkc1YWRwNUhqZ3RUNm9zQ0ZMV2RPeU1xNzVLZFBX?=
 =?utf-8?B?UnhVNWlQc3JaZ2NqUDI3K0N6VHlhTFlNaUtvUitaMXZLVFZ1ZHdFYUliamRG?=
 =?utf-8?B?SjdBNHdyZUtWRmI2NGoxRDQveU5XYnlCeGdXQzV0VXFLZklFbGIzS0FXWkhP?=
 =?utf-8?B?ODNKdUtuODZUSGZuWUNTYVhNZ2RaOGEzdFNFaVlId3JjcDNtVUJEa3hCOHVH?=
 =?utf-8?B?MDlvcTB5azZLcEpzemlZQ285SEp0b2pIbDgwcng3WEpHb0NzQlpSSUxJWmtW?=
 =?utf-8?B?WlI5MDhuYUVOc1V0dEpQSzhpbjZvRjhoTjZ2czcvMW5SOFQ5aWl6RlQzUk1F?=
 =?utf-8?B?SWtTaVBPK3pEdXBVbmZLMmQ0dWdQTGZKYlU0TUtGZDdvUU1kMXN5NDRSZVhO?=
 =?utf-8?B?RXZpWEVlN2JQVUVzQ1Y4bmFBbGhPeDhhVGd5MFpJS290SnlCckpaYW9ORXpm?=
 =?utf-8?B?eXZhQU8xc3daUWd0SXVnSlZBZnJKMkJSbnBlOENiSEpMWXhMeWR5LzlISVQz?=
 =?utf-8?B?ZXBIR0tqVWs4ZFRLcGhOK0tRQVpBc1VkY3Vjc29rOGNaWmc4R0hpenArTGFs?=
 =?utf-8?B?ZE8xbk9pdmJhNVJOTXlQckp5ZEU1YUdkcWtLU2VrTDF3cGxZNjJlTnZQME5a?=
 =?utf-8?B?YVNNMldzVjZ5VlVMRHpsRDZNWm5URURnb3dUUWJWcWNhQSs0N2VjdTcyNndm?=
 =?utf-8?B?QkxtbkZKd1JVd0tTVko1UXkzRWFqeTUwZmRDREMwWjE1WjNlejRVSHFCZUFw?=
 =?utf-8?B?RHUrbHBFZEJqMHB5ang5V2ZKOWluaTEzRUhrUnlZaWNFVnJ4WVo0UFJ2OEJn?=
 =?utf-8?B?UXZPcGg1SisxUVN6SGxnY01XYnpmYVhUNFY3Qkx5U1NvSzR5YWpUYzBZRDMr?=
 =?utf-8?B?NXN3UXc3bGZBT01yUHZkTDlrRnNLSEtrTyt5YVIxYnMzNGJ6WXZ2WW1uZGZ3?=
 =?utf-8?B?L09xL24xWVFkVE9uRWFVQm1ZbnRodEZVU3FnQkRRcXhaNmRubE1DQ21aU3A2?=
 =?utf-8?Q?h2bQotLvDOtzjezYgV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f20a4ab-f16f-49ba-fc9a-08decaf4898f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:16.4288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +14tzdTlFjVdVgTYG/kOkzd//J8682Hf2AuTgdOTwPkcNwVPvqXzLXvw88eeOlR1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551

Hi Andy,

Thanks for the review, replies inline.

On 15/06/2026 15:22, Andy Shevchenko wrote:
> On Mon, Jun 15, 2026 at 12:37:19AM +0100, Salih Erim wrote:
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
> ...
> 
>> +static int sysmon_read_raw(struct iio_dev *indio_dev,
>> +                        struct iio_chan_spec const *chan,
>> +                        int *val, int *val2, long mask)
>> +{
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int regval;
>> +     int ret;
>> +
>> +     guard(mutex)(&sysmon->lock);
>> +
>> +     switch (chan->type) {
>> +     case IIO_TEMP:
>> +             if (mask == IIO_CHAN_INFO_SCALE) {
>> +                     /* Q8.7 to millicelsius: raw * 1000 / 128 */
>> +                     *val = MILLI;
> 
> Since this is about temperature, wouldn't be better to use
> 
>          MILLIDEGREE_PER_DEGREE
> 
> here?

Agreed, MILLIDEGREE_PER_DEGREE is semantically correct here.
Will change in v8.

> 
>> +                     *val2 = BIT(SYSMON_FRACTIONAL_SHIFT);
>> +                     return IIO_VAL_FRACTIONAL;
>> +             }
>> +             if (mask != IIO_CHAN_INFO_RAW)
>> +                     return -EINVAL;
>> +
>> +             ret = regmap_read(sysmon->regmap, chan->address, &regval);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             *val = sign_extend32(regval, 15);
>> +             return IIO_VAL_INT;
>> +
>> +     case IIO_VOLTAGE:
>> +             if (mask != IIO_CHAN_INFO_PROCESSED)
>> +                     return -EINVAL;
>> +
>> +             ret = regmap_read(sysmon->regmap,
>> +                               chan->address * SYSMON_REG_STRIDE +
>> +                               SYSMON_SUPPLY_BASE, &regval);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             sysmon_supply_rawtoprocessed(regval, val);
>> +             return IIO_VAL_INT;
>> +
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +}
> 
> ...
> 
>> +static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
>> +{
>> +     unsigned int num_chan, idx, temp_chan_idx, volt_chan_idx;
>> +     unsigned int num_supply, num_temp;
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
>> +     num_chan = size_add(num_temp, size_add(ARRAY_SIZE(temp_channels), num_supply));
> 
> + overflow.h

Accepted, Will add.
> 
>> +     sysmon_channels = devm_kcalloc(dev, num_chan, sizeof(*sysmon_channels), GFP_KERNEL);
>> +     if (!sysmon_channels)
>> +             return -ENOMEM;
>> +
>> +     /* Static temperature channels first */
>> +     memcpy(sysmon_channels, temp_channels, sizeof(temp_channels));
>> +     idx = ARRAY_SIZE(temp_channels);
>> +
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
>> +                     .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
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
>> +                     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
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
> ...
> 
>> +/**
>> + * sysmon_core_probe() - Initialize Versal SysMon core
> 
> It is managed, please name it accordingly: devm_sysmon_core_probe().

Will rename to devm_sysmon_core_probe() and update callers.

Thanks,
Salih

> 
>> + * @dev: Parent device
>> + * @regmap: Register map for hardware access
>> + *
>> + * Return: 0 on success, negative errno on failure.
>> + */
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

