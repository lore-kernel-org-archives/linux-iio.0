Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8960036920D;
	Mon, 18 May 2026 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113232; cv=fail; b=ZeNG5eWBbeCQ1CBY4KYQMcnAg4k+mIUeeJZYXcr3rv/RvaKLcwQO+bkgDnm2oafRSdS91mfbMX0Rw1JsYStN3fdrEr+EaAHnwYHf5YrRdB3sItVE+0ZlyOme1YqmqTNkkMF0t9evqjJLS/dyH7m8EXH+TtcgQfnNmqcW/WwimdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113232; c=relaxed/simple;
	bh=xu4hWulz234d67IyIypiXxwwjugvVy64WDvQtd+daXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lp5k2BuXLhLntMmuXz5QUp5HoXEPWRE25+JkziVXI/NJrZEOsEwQce1XN2mZGeMDQyEBEfR4dnXrYB826gpjTXkPGKGqSKhALY+bEYKmBJK3t2HiazDchxh9tdqvvbFCeC5/2bTpoOOHM2fzebUZQEBftBgTNtieZbX+2qkIu9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eL3jJvdk; arc=fail smtp.client-ip=52.101.57.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eL3jJvdk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8cH7FZLDEq0p8UEdSLo/TTjhShgEscaeMt+NsndkMGq0WoAZN9ygqhjARAQRdS3Z9zTk08Ns+MlVcYARDBWriPofz1dJfuZXGTdl9tueJIMFtLewsU5wdu2zFWV4LcTONRoa/3uOYl3lzxWyLJkJeP+ZTTC2CE2/UOz/L/XbN4vDW4JA7fNwqW6cQD1Zf3lM8Ib0C3LYXnZR+aw932i+nuS/z4efu51M7Jon1y8rC4/Xl0+OsV/yZIUwqX982f9n0iOuEWoqtKiCpkF3neHMMQR6go2+iVrzBABWqj43K1RvaiuckNyBfDF0FlSP5hYcbp7i0bCKzxyeMFypL/jwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPUVSxXGDfK1oydVRK7t5rlzqrkdDqo4IZUCC81GrjY=;
 b=s5PJDzk4HfXhTL7OUHzfyjhPRkjj6qZxm9MKMUuwEW46TsSi2Ziv6lA+QqxG/o5AGXvG6wd6T97q8sAIIHaY0gJPf+nR5sexrPjGMaJ30WnOI1XlXnMND2gbvKzBjFpNLjSWxEdfYk5cOFX/+t1dYvjCmzBSnXgTRyS97+WwkHQigXlfEtH75h5HwXcv6hZOuHPqcv8z8vWR6EaqXeH0JZbbYfsTO0NgtSuPQLcJdfQWC0S8Uc4BwYcdvFqfa4MpRpwRth2eT48sRP2xtk5hay9e6Q9h8rsB1VqgW59uHRWwIEwZM5QS3sFMbbZEnM9ingcD9BU6Jn1a6SJPvQeXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPUVSxXGDfK1oydVRK7t5rlzqrkdDqo4IZUCC81GrjY=;
 b=eL3jJvdkIw/HN+ABNp6vW79LtRUKL4o8FoLyoeTsXbql9MAsRJVgQBXJGrnO75asHHWVXgeVnFouu4HDlT9od+aRvKD/tAKtkuYx7vwkZIPhOpGX8Hgi9ktnvr8cclN6eMYRnIz3Yo6+rerEceXMHo5lLS/47ou0nWiW7o4110I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 14:06:40 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 14:06:40 +0000
Message-ID: <59884fdc-a9d0-49c6-8167-11d56a21dd11@amd.com>
Date: Mon, 18 May 2026 14:56:21 +0100
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
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260504184415.7b6688f5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0288.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::16) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: c0427298-4f69-43d6-3970-08deb4e6ae7e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|4143699003|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	H0GOxCpbURVOS5l2HsfK5DVl9gkOHNipGgee/k2qSWf+vGeM52te89yWLT8wZKtzThXHaLi3o7nbt+dKEyRjyhz/p+YwyG9i3V5kbv3gVd5/EbSPuOks9jrqubY4YIb0zMdowmOUMqCqdRZqbvGiu2tfPWOXgp21PZHhR9tbDO7Oo93ziCGMhCc2kGUhTRXamyrlfxUw6eNpyXLrk2Y+f4zU4yiWkmj7edPIoXcPGRIp7FhXl80W7IvU58vSTK1B29cQuw3tYXxeX8Lj0W5SXiFFW92U1LTkRJNGa19jHIyfm+dsqKAJwBlkYbxQf4zqiNTgd0d12oW/w60A0h8AOKYlAp5KRZI4x5SzD5IkiXDIIhuKxYW1ElhYcxk//QEb8xMJwNuohscfCe5BUJZThAbBOM0O7Kg6XauaPiFOVd/UnvGBlKrsyHdpASClMqoZHaO6Obeog5M38Lm8Z1QD+QWV23xBq6jkQg75AQMxodv3Pd9kyL9LWfbEZNh+lT7R+W6UQq1wNAFaNWxLfULiw1VxdHipx9ERXjnwGawiYVoZ+rcrAcnFGjBfnaTDH6bWclEF5o73ILE+7Kh8a83P4eq1i8dU6obaSTpTVz6hj5zSRMzEKMAFJ7kasoK5N9Zt0L8ht+HONLf894DdB/w77hyhfg4D2YOZI0/gFsDg9Ypz8I/7OUM6ql2mvrHruGml
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(4143699003)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTNKVzliK3RDbDBWVW1wdnFlQkIycGxWWVBpZ0k2WGRvS1ROL09RSUV2d2pE?=
 =?utf-8?B?NEd6ZU51RU14ZklOL2ZrOFhpREdQMnptTitQTzdnTW5iYUE2a0E5dWpjbUNk?=
 =?utf-8?B?OXVaSHo3UXptQ1JTMHJ3Q2laNzZLZW5XOG1qaUpic3ZZYjdYWldtbTBKWVRT?=
 =?utf-8?B?bEJ6Q2JDamFvTHJnZHlnVTlpa0Rkd0ZmRU5yZXVGN0IzYmNyN0Ewb2lDbEFE?=
 =?utf-8?B?WG9WOXVoVDRnL1RibCt2MDZjeVlmTWQ1aUg1d0pJbWhIZFZrV0l5TExmWXhE?=
 =?utf-8?B?WEJoSVR0TGxoeXh6NW9HOTllZlJnZTh4WWVaRFVhRy9IWS8xaHVXWGhhQTlH?=
 =?utf-8?B?cTEvcjVMRXFrakZ4NytFNzRSejUyVDhTQkZ2QkZGdFZOT2tZdXpBclVyTTlC?=
 =?utf-8?B?SFM4T1h1ZEh4Qkx4c1hTVU9hK1cxNnV1RlJpOCsvMUUrRzB6V3A1RFVmQWVv?=
 =?utf-8?B?aFRkbzFTRjVLdXE2NHRsREVHZjNBTDNpck10QWVhZldPSGpCcVByTUkxbUxk?=
 =?utf-8?B?K2x1SjY3clBQOFdBd3VSTTBoYXRxUVM1VGR6bEdFUlYxRGlNb2YzcWdSbVd2?=
 =?utf-8?B?dUxHeVNnVkdEclNzekFHMTdYUi9VSlVGRWlZZlU0RmdLOXFNQnROV3JFeDdV?=
 =?utf-8?B?UytGQkU4a3pGQ2lqcXBhL0w0N3hkUEJRbU9JcHdIaG5mbDZlYjk1Y0JFWG9n?=
 =?utf-8?B?OXRPTXpHTDhQMGtxR2JheERqZi9Ua1R3Z3kzYW55aENsNEZlTHJqMENsL3k4?=
 =?utf-8?B?b3J4dnNSYkdHeXVCdnQ1T3k5cGt0czFTb3ozV2g4N3o3bE9EcjByOU1lbDFo?=
 =?utf-8?B?Z0FOYmFRVFNJV1FZY1R0UHllSTRQNGFXYTdVTFZ5SGVKZG1zdXlBMlk1YXdY?=
 =?utf-8?B?cy9uRUM2WmRHakZ0aFZ3QXU0VzRvWG0ySStxSEtjT29TbGtocXYyU01EL1Ri?=
 =?utf-8?B?aGh2NTF0SW5tWDc3WDNJVVVnKzFCemcxUXVsN0hFb2RXTUpGOEtuZjdkVzdF?=
 =?utf-8?B?bGljZkJvQWk4SVh1Yi80NUU0emwxMGtNU2k1WWNDUXkyZklUODNvblZKYWY5?=
 =?utf-8?B?MDd5b1h3cS9ubndkUUZobHpMSUxoYllLMEt3MUFHTlMrMHRXV1hXZFZjeW5Z?=
 =?utf-8?B?WUdaWHZaYW9LL2tIVGZwYUpjL0RyZnJ3dTR3SHN2U0g3R3FZdGl1QWhuU3Az?=
 =?utf-8?B?OUpDMU9ST1JMZzlZVUtmU1BpYUlwV3dnQ0psbFpGcG1QWlJhNEFJRzhTbWVQ?=
 =?utf-8?B?cFowL1BrY0NtbThObDZ4K2tsOUk0b0I2ZHZKRE1FeU9GMmI4NlU5TDA1MStS?=
 =?utf-8?B?NjNYU25uMmpaZ3EyVFBZTVpGL2lLcnhieW8yMlJaVEdBdkpFR04wK3YzN3Vt?=
 =?utf-8?B?c0diaXU2d0cyTUR1NGowWWJGeElCWDM5SGZrc0FTRFp0bzhBdXZVYjQveEhm?=
 =?utf-8?B?dXFEaWxpOWc2YlFpV3lpOE5memN2ZkdGU1lZZEpFWmR0bkRwRVBrUk5jdEFr?=
 =?utf-8?B?SXEvOEtmQ0x6ZE9wWWprSHhJV1o2RnRHdDFKcWpZZ0VWWkpKZkxvOW5tSmtQ?=
 =?utf-8?B?UlVIanc2dzNmQVFzSDl5VytIMUZnZUJla1JMVVlmTkpNa0RuSUJ5TFZwMHc1?=
 =?utf-8?B?cXN1OUpZV1FIcWQxVnhIdWFscXlDL3crSkd4dk9LY1lwMW1QQ1FKaldiRHhr?=
 =?utf-8?B?aU5xVzdoYUxqSzY2c2wwZk9hd3RBRDNKZTYrWWduQW5wMERQdlA4SGtkNTdQ?=
 =?utf-8?B?UjJrbVZjU0RmV3dCWFNqQkwyWFB4K0FFcnNnZ2ZtVms2eUk3TnBvaEpZUmxF?=
 =?utf-8?B?ai8wRk1lZ0Q2UE5yeTJQSUQzMU5QWFNkWDU1OXU2dTJhT3hMZi9LbnVHdmFV?=
 =?utf-8?B?NlkrSjVrRXlEMWp2aG5lWVJCbFdCRTZOekJGdkZTTzUvQW1TZDN4MjA4c0hL?=
 =?utf-8?B?MDlrZTgvMmtTV0g4a1htaVY2YWQ3ZVFyZm9mQzNvSzhFQW91ZHU0WUQ4ZmI5?=
 =?utf-8?B?eGtRVk1hTkhhM2pSVno5eDhKc3UvU1M3cWpQZzNLU2loMmxjMkNoTGNzbmlN?=
 =?utf-8?B?V2x1ZE0rWUNsYlUzOUtDL0hiakhiQzFtYjhlaFdUQ1pvQ2VFSW82YVlrNjJG?=
 =?utf-8?B?ZVBVaFJ3eFBuZjNvN056cUM0ampHdytobHJrb1lkcG5SMkR4OHNRR2drWkdG?=
 =?utf-8?B?VzBGQkV3eDJLa1dHY0V3TDNXakY0MStOQzc0QjdDYXU3WDJYZzRmZTFveWpO?=
 =?utf-8?B?cnBqM0tQV2RFKzFHVE5uS3Nyd2pvaHJDMVR1THB3MzVqdXRZNHpUdjhwZUxN?=
 =?utf-8?Q?NRFK8E8CK2lMrNf22n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0427298-4f69-43d6-3970-08deb4e6ae7e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:06:39.8433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Apv++tg7HMVGihgk8ep/mt1tNacn8/MGDmv9l2BUGGJHX3emi9fc5JZX4V9tTqoE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655

Hi Jonathan,

Thanks for the review.

On 04/05/2026 18:44, Jonathan Cameron wrote:

> 
> 
> On Sat, 2 May 2026 12:19:50 +0100
> Salih Erim <salih.erim@amd.com> wrote:
> 
>> Add threshold event support for temperature and supply voltage
>> channels.
>>
>> Temperature events:
>>    - Rising/falling threshold with configurable values
>>    - Over-temperature (OT) alarm with separate thresholds
>>    - Per-channel hysteresis configuration
>>
>> Supply voltage events:
>>    - Rising/falling threshold per supply channel
>>    - Per-channel alarm enable via alarm configuration registers
>>
>> The interrupt handler masks active threshold interrupts (which are
>> level-sensitive) and schedules a delayed worker to poll for condition
>> clear before unmasking. When no hardware IRQ is available (irq <= 0),
>> event channels are not created and interrupt init is skipped, since
>> the I2C regmap backend cannot be called from atomic context.
>>
>> When disabling a supply channel alarm, the group interrupt remains
>> active if any other channel in the same alarm group still has an
>> alarm enabled.
>>
>> Named constants replace magic numbers for hysteresis bit positions
>> (SYSMON_OT_HYST_BIT, SYSMON_TEMP_HYST_BIT) and alarm register width
>> (SYSMON_ALARM_BITS_PER_REG).
>>
>> Hysteresis values are validated to single-bit range (0 or 1) before
>> writing to the hardware register.
>>
>> Signed-off-by: Salih Erim <salih.erim@amd.com>
> A few minor comments inline to add to what Andy found.
> 
>>   drivers/iio/adc/versal-sysmon-core.c | 539 ++++++++++++++++++++++++++-
>>   drivers/iio/adc/versal-sysmon.h      |  36 ++
>>   2 files changed, 574 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
>> index 37736c2900b..857fe21db7a 100644
>> --- a/drivers/iio/adc/versal-sysmon-core.c
>> +++ b/drivers/iio/adc/versal-sysmon-core.c
> 
>>
>> +/* OT and TEMP hysteresis bit positions in SYSMON_TEMP_EV_CFG */
>> +#define SYSMON_OT_HYST_BIT           BIT(0)
>> +#define SYSMON_TEMP_HYST_BIT         BIT(1)
> 
> You use a mix of these defines and manual shift.  Use FIELD_GET()
> /FIELD_PREP() to avoid that.

Agreed. Will use FIELD_GET()/FIELD_PREP() consistently with the
existing BIT() defines as masks.

>>
>> +#define SYSMON_CHAN_TEMP_EVENT(_chan, _address, _ext, _events) {     \
>> +     .type = IIO_TEMP,                                       \
>> +     .indexed = 1,                                           \
>> +     .address = _address,                                    \
>> +     .channel = _chan,                                       \
>> +     .event_spec = _events,                                  \
>> +     .num_event_specs = ARRAY_SIZE(_events),                 \
>> +     .scan_type = {                                          \
>> +             .sign = 's',                                    \
>> +             .realbits = 15,                                 \
>> +             .storagebits = 16,                              \
>> +             .endianness = IIO_CPU,                          \
>> +     },                                                      \
>> +     .datasheet_name = _ext,                                 \
> 
> As before - consider renaming this.

Will rename _ext to _name, same as P2.

> 
>> +}
> 
>> +
>> +static int sysmon_read_event_value(struct iio_dev *indio_dev,
>> +                                const struct iio_chan_spec *chan,
>> +                                enum iio_event_type type,
>> +                                enum iio_event_direction dir,
>> +                                enum iio_event_info info, int *val,
>> +                                int *val2)
>> +{
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int reg_val;
>> +     u32 mask, shift;
>> +     int offset;
>> +     int ret;
>> +
>> +     guard(mutex)(&sysmon->lock);
>> +
>> +     if (chan->type == IIO_TEMP) {
>> +             if (info == IIO_EV_INFO_VALUE) {
>> +                     offset = sysmon_temp_thresh_offset(chan->address, dir);
>> +                     if (offset < 0)
>> +                             return offset;
>> +                     ret = regmap_read(sysmon->regmap, offset, &reg_val);
>> +                     if (ret)
>> +                             return ret;
>> +                     sysmon_q8p7_to_millicelsius(reg_val, val);
>> +                     return IIO_VAL_INT;
>> +             }
>> +             if (info == IIO_EV_INFO_HYSTERESIS) {
>> +                     mask = (chan->address == SYSMON_ADDR_OT_EVENT) ?
>> +                             SYSMON_OT_HYST_BIT : SYSMON_TEMP_HYST_BIT;
> 
> Not a massive amount of sharing for OT_EVENT vs others. Maybe just split it
> and then you can use FIELD_GET() and get shift handling included via the mask.

Agreed, the if/else with FIELD_GET() is cleaner than the ternary.
Will apply to both read and write paths.

> 
>                          ret = regmap_read(sysmon->regmap, SYSMON_TEMP_EV_CFG,
>                                            &reg_val);
>                          if (ret)
>                                  return ret;
>                          if (chan->addres == SYSMBO_ADDR_OT_EVENT) {
>                                  *val = FIELD_GET(SYSMON_OT_HYST_BIT, reg_val);
>                          else
>                                  *val = FIELD_GET(YSMON_TEMP_HYST_BIT, reg_val);
> 
> 
> 
>> +                     *val = (reg_val & mask) >> shift;
>                          }
>> +                     shift = (chan->address == SYSMON_ADDR_OT_EVENT) ? 0 : 1;
>> +                     ret = regmap_read(sysmon->regmap, SYSMON_TEMP_EV_CFG,
>> +                                       &reg_val);
>> +                     if (ret)
>> +                             return ret;
>> +                     *val = (reg_val & mask) >> shift;
>> +                     return IIO_VAL_INT;
>> +             }
> 
>> +
>> +static int sysmon_write_event_value(struct iio_dev *indio_dev,
>> +                                 const struct iio_chan_spec *chan,
>> +                                 enum iio_event_type type,
>> +                                 enum iio_event_direction dir,
>> +                                 enum iio_event_info info, int val, int val2)
>> +{
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int reg_val;
>> +     u32 mask, shift;
>> +     u32 raw_val;
>> +     int offset;
>> +     int ret;
>> +
>> +     guard(mutex)(&sysmon->lock);
>> +
>> +     if (chan->type == IIO_TEMP) {
>> +             if (info == IIO_EV_INFO_VALUE) {
>> +                     offset = sysmon_temp_thresh_offset(chan->address, dir);
>> +                     if (offset < 0)
>> +                             return offset;
>> +                     sysmon_millicelsius_to_q8p7(&raw_val, val);
>> +                     return regmap_write(sysmon->regmap, offset, raw_val);
>> +             }
>> +             if (info == IIO_EV_INFO_HYSTERESIS) {
>> +                     mask = (chan->address == SYSMON_ADDR_OT_EVENT) ?
>> +                             SYSMON_OT_HYST_BIT : SYSMON_TEMP_HYST_BIT;
>> +                     shift = (chan->address == SYSMON_ADDR_OT_EVENT) ? 0 : 1;
>> +                     if (val & ~1)
> 
> Just to confirm - this only has hysteresis values of 0 or 1?  That's unusually
> small given hysteresis should be in same units as _raw.

You're right, this is wrong. The current code exposes a mode-select
bit from ALARM_CONFIG (0 = window mode, 1 = hysteresis mode), not an
actual hysteresis value.

The hardware has independent upper and lower threshold registers for
each temperature alarm (DEVICE_TEMP and OT), plus a mode bit in
ALARM_CONFIG that selects between window mode (alarm on crossing
either threshold) and hysteresis mode (upper triggers, lower clears).
Since the hardware has a single alarm bit per temperature channel,
even in window mode you can't distinguish which threshold was
crossed. Hysteresis mode maps naturally to the IIO event model.

I'll rework this as follows:
- Hard-code ALARM_CONFIG to hysteresis mode during init (both
   DEVICE_TEMP and OT)
- Expose hysteresis as a writable value in millicelsius, stored in
   the driver
- Keep both rising (upper) and falling (lower) thresholds writable
- Couple the three attributes:
     Write rising    -> recompute lower = upper - stored_hysteresis
     Write falling   -> update stored_hysteresis = upper - lower
     Write hysteresis -> recompute lower = upper - new_hysteresis
- Read hysteresis returns the stored value

This keeps full user control over both thresholds while exposing
hysteresis as a proper temperature value, matching IIO semantics.
Window mode support could be added later if needed without ABI
changes.

> 
> Also similar to above, I'd split the two cases and use FIELD_PREP()

This block will be replaced by the hysteresis rework described above.

Best regards,
Salih


> 
>> +                             return -EINVAL;
>> +                     return regmap_update_bits(sysmon->regmap,
>> +                                               SYSMON_TEMP_EV_CFG,
>> +                                               mask, val << shift);
>> +             }
>> +     } else if (chan->type == IIO_VOLTAGE) {
>> +             offset = sysmon_supply_thresh_offset(chan->address, dir);
>> +             if (offset < 0)
>> +                     return offset;
>> +             ret = regmap_read(sysmon->regmap, offset, &reg_val);
>> +             if (ret)
>> +                     return ret;
>> +             sysmon_supply_processedtoraw(val, reg_val, &raw_val);
>> +             return regmap_write(sysmon->regmap, offset, raw_val);
>> +     }
>> +
>> +     return -EINVAL;
>> +}
> 
> 



