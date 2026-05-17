Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA65C3161A1;
	Sun, 17 May 2026 23:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779059210; cv=fail; b=pJZ7DQ8R9+XDicORnpSFp1kt9S3HuGBgsHsThl7jwDdKPXez3OAj+zAlYebxJTAzp0yOAPzpc0V04BSUVcYoNuJ5Ig9/zBmBNEt+JJvfoYjKBQdi1BLIqOXA8Py2yyXAfD8jteh8qeBvu3LqNWNG4HmgyUMvlPIDQzibX5c+d6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779059210; c=relaxed/simple;
	bh=TCym0PiYfy4SERlKRj/1vetnMq48SjmtZ+bwgWuwDho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wj1/qAxa7n/1Ay9PcD39SpCJbOQ1QjdJ6/CnqGEjfxmqwW9lR9hWGuq1iVxbmrF1bJDwBVZcBfzd2STEeiXuxW2J8tWSrery6zSI+79eROcGeqx2u7NhpXM0mHTkXQs4Qn8ww4mk4dkrzgtIUAO0SymCwXY5sq18Lar/rWLvY88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AnnsdWsF; arc=fail smtp.client-ip=40.93.194.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AnnsdWsF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhth3Q0lAlynfVXjKkSNLLSjSDM8wC4WiqIlWzJPjDzaavHQ+qLEyIR7y9S5lXlHqAiFFl+BmVwLgOBcSZbr23xUk2AYdp9xZ2b8PoFSWXks0ecfQlMM2YlrHwJ/MQIcddVEbpbq21iiCF2S2CK8ceHymkb0Eq0kF4lefABGcNqa+isy7eFlo1KESbU+rh4f2TMD7XBamsfGs3nydeL6kQHNrgLwekLX4CIIsEW2x6Re4oBXBNLizMc4Ss842FfUmtBKDSezxa/3PAjDszHX+lMI7FoPwSs5a3G/TP51wfVVzajWL/CKll/Q5qstFZotZWP5jIp7buwI8bnAk/9u9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WC4aSTohD8vbbJsCh6LFmBa/EN3hOzKGqOrQa63lDV4=;
 b=efOOgYG9K4qTT5V9Ep1N+QtyAVCsV2gujMU32DOTPzzOnA2E3tMvChRegLuxvUjb+jAv2B+ucX5K1M3is/sKHbwme9lmyN0xbLjK1NmNpak1kH6kqTEdzBYEHoW2f3KMg2zXLJ9DEYQU2lLCwEIDMb1p/XBtV+cbPOK9/tAanDFyhGwmcRzTtB3DkjY+kfhHl8mdNXGlhVhlShKS0+/4UEMlUgKSokF5rTmurTH6EpciiRkfXXIatL3zP4xOREKtm41yBEr1JTPHy3pXa8j2uTbSfhBwzqly4QmXNUcoPYqbJogwuMK3fXz7p0B9uKw3Cl0xz89oqLnWIx6/gV21GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC4aSTohD8vbbJsCh6LFmBa/EN3hOzKGqOrQa63lDV4=;
 b=AnnsdWsF6lnPF2K4mR1WnW15wB8KqnKyil9NLQY11/IrP+Ih14I7zlEZjRjbYWGxgGWymMDyn/8AymXvvcYhWk6H6j96zRSU2g4nim5a7WW/GKA4ewix0A6gsVlO9TlvldaFk3iOUh4pqDhYI2yXBOWtI2uOLsqvUg+yE4l3+FA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Sun, 17 May
 2026 23:06:41 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0025.016; Sun, 17 May 2026
 23:06:41 +0000
Message-ID: <d0e4b963-ef2d-431e-881b-3a2fdc2bb9e8@amd.com>
Date: Mon, 18 May 2026 00:06:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iio: adc: add Versal SysMon driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, git@amd.com, nuno.sa@analog.com, andy@kernel.org,
 dlechner@baylibre.com, michal.simek@amd.com, conall.ogriofa@amd.com,
 erimsalih@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20260502111951.538488-1-salih.erim@amd.com>
 <20260502111951.538488-3-salih.erim@amd.com>
 <20260504183215.37c8ae65@jic23-huawei>
 <66268e35-4897-4c40-b358-1c973b70426b@roeck-us.net>
 <ec5634b3-2f17-42b6-8bfb-124ac0c7cde8@amd.com>
 <20260516112057.381dc19c@jic23-huawei>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260516112057.381dc19c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 8908bd1b-834a-432f-6bc2-08deb468f4a6
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|4143699003|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Y8eZACrgUoOv43r7I6ncCBSXgeBc9p6OrO6kb3hF+8jjKtXx82pPX7DkvvZllVCn6I7ZLT56LwB09CQ4ZqZyXSGl+bzn6mmoctDtvf0Sp3nLeG50vpal2fv20iKhNEp+FnOD6x6uC4HHkbT7HTyUcpdiSM+9vPFdLvI9xzmFragScwSREnr56o80SAtrM3ZERExhyAvy9sbKq69Xx+M9TK0lwnNTw4nkZDzrmgB6V3bnTLpGZcbyiHPLb/ltK9nf8EgSTpNLaNRISoKxQQIDBmG6+oCz4AnDAkObmoH5L6CRttgCwK6KIp35SPzxzOk2ZDX46SOyZoN30vJTqcoCqHzqtz6dE1e5CdUbcWRVHJQBrG2BBskBYZFxiMq44gwf7ZCyD11UoYBZ2hsgJFc1zBSbSzVSfDE8Jz4Tt7A/QiRbiN9uYIpMVWSbphJ/01Uul9Vf92pldg4TWdeQwhgPrQS2/ojFkhTnuvlwKB6WvAGYpb/lC6ADF/5Nvhy6cFX/NsebAlqU+5y1aCrPwpaakU03N7fM4U420PQf3vX1mXAAcyg6xKapf6d3LHBtS1wQwJ61wYiTmZMoxa7DGG4w4hxUE4r+4vcM7ukjb56SG6ZT62Fhu0x9PsayM+mGRMpBe8jNtBiBnHUztYE37ofLUVa9u+fazxv7WjmzRhgBWRgQ95vGuDwfiChuMFtXNPDF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(4143699003)(11063799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmJ4UStabVRtc0xEMjE0UFdxUEY2ZS9EQStkR1RDWEV2NEVNMEVnSDl6cEhW?=
 =?utf-8?B?VDV3VlZuNXpWeStvOGVieXR4NEZ6c1ZyWGxTeUxlODErbzlQU0xtcXFJSDNQ?=
 =?utf-8?B?YzZtTUhkck0xYzVEZFVIelBvc3hoMnhkcDNjTmxKemRHeXNyV0E4UHh5N3ZE?=
 =?utf-8?B?bnVmQ1EzdStRTGxmbmgvVU9oQ0Y2T2NXd2dtbi8xM2tJQ1NvR1NIaDJDYWUr?=
 =?utf-8?B?RzVLZms1WUhlNnlLMEN0ZC9xaUFnYXpUOWo5UHY5SW1xSytnQXU2WkZNY2Nq?=
 =?utf-8?B?azI0c3NYLzJYLzV6dTBVT29tenVSQUo5VDRYM3RCcW0zMDUzYlBvRmc4N3hx?=
 =?utf-8?B?SHN3ZEU1eGJlLy9EMXllSXRMdDVjK3lqWnNoQkg0a1NPRFZKT3VsU2FDYVBM?=
 =?utf-8?B?cWYxQ0hFdmU4TjRUQklqMG54dU1OKy9yWlBXMTBkaVVGSFQ0aTNoZTgxck11?=
 =?utf-8?B?VG5PV2JIZ293YWx3MTkxU2JSYm5JTzNtK0haMTM0TkNUeGdoRDV4VFNhY296?=
 =?utf-8?B?TmlOTEl2bm5DcWFHZzhValZYMDExa3laNEc1Y1BFeDFkUVBRcTFMYmJBWUd6?=
 =?utf-8?B?b29FaE9rbU12d1ZNQ0pIMjhCckw4cUVsQUEwaU1yWEhFYnphUThLcFB2NTA2?=
 =?utf-8?B?aVpYOGtIQkhHU2owU0g1Q09mWCtUVmg5K3ZzTUNZdzg3TE8wcFB0Wi9RbXRj?=
 =?utf-8?B?Rkxwc3FRdVpDQ3FpVUIyRk9WVGJMeFZiWjRxdDA4YjFhTGdoazUzNnpUVFl2?=
 =?utf-8?B?V3Y1enFkUGdoRzFHejQ0a1ZURXd4RUxoU0lUVURlYms5UVdORGsvWnZsZ2g5?=
 =?utf-8?B?eHdNRjZZVnBPZmUrd2FvdG9XNkRKSVMvT2VnWno0aytVM3Zqb0FWSUQ5S3h3?=
 =?utf-8?B?d1JPQjE5ZXI2QTZ5WjU2L1VpTCszbmFhcXFwbERmT091aHFqeWZaempJQ0FE?=
 =?utf-8?B?Q0RITzZIMzhxd2hSNUx1WDV4aENQRVR0VTUybVBPSE5zRDRGVTZQUWwwUHky?=
 =?utf-8?B?bHc0UDNWMjJ0aEVXdnBPYnJxUkE4eEhaUG5IWUlrMWkrU1B3Y1J1SDBXa3hH?=
 =?utf-8?B?UUY2N1M4OGdWMUhucjMrMlVWSFBiVENzV2F4Wk1HU0ZkK0lvU2s0Z2d3N0NI?=
 =?utf-8?B?bzRLK2tVTk9YSy9xU1J2TVhINVNkdkhlYjFjS0VFVm5JQ0U0K2NHWDVxanNG?=
 =?utf-8?B?L0xqbmNId2MrNGEwb2hvaHc3d2FVTGpwKzZwZG1RYzlxcWgveFdyM1I4NTMy?=
 =?utf-8?B?VW0rc2RObC92S1Q5RFhuY2hXMlUvL28wNWxsNlRxZlZFK3pSS0Q3dGQxc1NK?=
 =?utf-8?B?RWJqSnJCYVpKL1hJbkFaZGxSNGNKZU10eC8vSVh2dGIrK0JsckZuZCtwK0ZR?=
 =?utf-8?B?dnBuNkVGY1psRGpWdGR6QXArVE96d0JFQWlPd284dlBWVitEWUQ4L2dTSUpw?=
 =?utf-8?B?SDlMcFI5cHVhVmNwWHZWM2VOYkJoVXdUZXZjay9DSjJKa0MxUkRvcXZKOWpa?=
 =?utf-8?B?RUY1ZTliRk90RkpKQjN4UVl1ZDJUZUtxRWgrdTV3dnQ5NkhFTDZRYmVDR1dU?=
 =?utf-8?B?b1I5Y0pjcXlGb05CcXNvTGs5WU5kNHZtUzhmNmFCTlp3a0xuVFpRaVBkZVNl?=
 =?utf-8?B?cVNmcFpXMDc3REEwL0pqT1FkSWpOSFlSVnZUZmJJUkNRNjY0NzJoVnl2TmFT?=
 =?utf-8?B?MlkycmZQdHN0bDBPYmFtZjBEOCs4NmYyenRtaVFBU2l4SEE4TVhSN2lqbTY0?=
 =?utf-8?B?dGFEMlYzanZxREQvUnB1dFhRUHJjZHhweGJkT0paNnYzSUd0ZHJPd2hwcGx5?=
 =?utf-8?B?UUpXTkhEOGw2Rk1HKzRiWkZkeDB3bHo3NFloYjFkWXhOdWN6VnBldkJVdlpP?=
 =?utf-8?B?K1Ywc1pZZXNTQkJtUG4wYjhtL0trUG9xRysxSlR1RXNDZGlUN2JQSjdyL0d1?=
 =?utf-8?B?N2xzS1NzWWJvL0N3QUdoQkVaNy82MWoyQ3VVeHZ0UnBBL0xyQW5rOTV0ZFhj?=
 =?utf-8?B?NUk5M0gwT0VuQm45SVIwQXpyeHBWa3diSDBHZnRrU25zZUYzdzhucDhUZkhJ?=
 =?utf-8?B?YnB5bEJxSkFST3JpTCt5QUQwdktmRFM0TWovUGZOeDJ2elF1Qk1wc01YbGlo?=
 =?utf-8?B?Y0NlKzViMVBQekVhWURURUxKZENCUjR4QzIzZFVjMDNkSmpMZU1KNFk4S1B3?=
 =?utf-8?B?ZlBsaUVuUkpuRmhmMlNjdlhJcUtxWUYwYmN0RG93K3lwZnNpUk9VTWFZMThn?=
 =?utf-8?B?VGgrcllKR2ZCaTNWek1Jbkw2MURBR0hVMkNkOU04UFF6YUNyQ2paMHI2WTFB?=
 =?utf-8?Q?8rpOkd4zFFu1UX+3NZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8908bd1b-834a-432f-6bc2-08deb468f4a6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 23:06:40.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDDkkx77cNh8HLkYGeExfZMn2JwGLeZRMrdwdAvZl4ZjXZOy6fKT3S1Kjmd2MVOC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739

Hi Jonathan,

On 16/05/2026 11:20, Jonathan Cameron wrote:
> 
> On Tue, 12 May 2026 12:35:21 +0100
> Salih Erim <salih.erim@amd.com> wrote:
> 
>> Hi Guenter and Jonathan,
>>
>> On 5/4/2026 8:26 PM, Guenter Roeck wrote:
>>>
>>>
>>> On 5/4/26 10:32, Jonathan Cameron wrote:
>>>> On Sat, 2 May 2026 12:19:48 +0100
>>>> Salih Erim <salih.erim@amd.com> wrote:
>>>>
>>>>> Add the AMD/Xilinx Versal System Monitor (SysMon) IIO driver.
>>>>>
>>>>> The driver is split into a bus-agnostic core module
>>>>> (versal-sysmon-core) and a memory-mapped I/O platform driver
>>>>> (versal-sysmon). The core uses the regmap API so that different
>>>>> bus implementations can share the same IIO logic.
>>>>>
>>>>> The core provides:
>>>>>     - Static temperature channels (current max/min, peak max/min)
>>>>>     - Supply voltage channels parsed from DT container nodes
>>>>>     - Temperature satellite channels parsed from DT container nodes
>>>>>     - read_raw for IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_PROCESSED
>>>>>     - read_label using the DT label property
>>>>
>>>> Various comments inline.  One thing to check.
>>>> Is this one strictly a hardware monitoring device? Or does it
>>>> get used for more general ADC purposes?  Did you consider an HWMON driver
>>>> for it? The above sounds a lot like hwmon. So why IIO for this one?
>>>>
>>>> I wasn't awake enough on v1 to raise this!  Sorry about that.
>>>> +CC Guenter and linux-hwmon for that discussion.
>>>>
>>>
>>> This very much sounds like a hardware monitoring device to me.
>>
>> The device is indeed used for hardware monitoring, but the hardware
>> characteristics push it towards IIO:
>>
>> - The predecessor (Zynq UltraScale+ AMS, xilinx-ams.c) is already
>>     in drivers/iio/adc/ upstream. This driver is the direct successor
>>     for the Versal generation.
> 
> Was a long time back but at the time I think it was argued that some
> usecases for that device were general purpose external ADC channels
> rather than just hardware monitoring. Is that true for the new IP?
> (might not have been true for the old one!)

Yes, Versal SysMon has a dedicated VP/VN differential analog
input pair on package pins plus up to 16 auxiliary analog inputs
(VAUXP[15:0]/VAUXN[15:0]) on MIO/HDIO pins. These 17 external
channels support unipolar and bipolar modes for measuring
arbitrary external voltages; bipolar in the binding exists for
these channels. Oversampling is also most relevant for external
inputs where signal noise matters.

> 
>>
>> - The supply voltage encoding is a modified floating-point format
>>     with per-register exponent and format bits. This non-linear
>>     encoding doesn't map well to hwmon's linear in*_input model.
> 
> Given IIO doesn't really do floating point either I assume that is
> getting converted to something fixed point which ever subsystem
> is used.

Correct, driver converts to millivolts. Both subsystems would
need the same conversion code.

> 
>>
>> - The device has configurable threshold events with per-channel
>>     alarm registers, hysteresis bits, and level-sensitive interrupt
>>     masking/unmasking -- which maps directly to the IIO event
>>     infrastructure.
> 
> What in that list doesn't map to hwmon events?

Comparable, agreed.

> 
>>
>> - Oversampling is hardware-configurable per channel type with
>>     per-channel averaging enable registers.
> 
> I think this is not present in hwmon (could be wrong!) but is there
> a 'right' configuration for a typical usecase?  I.e. would sensible
> defaults work?

Hardware default is no oversampling (ratio=1), which is fine for
supply monitoring. Configurable oversampling is mainly useful for
external analog inputs.

> 
>>
>> - Up to 160 voltage and 64 temperature channels are dynamically
>>     configured from DT, which fits IIO's dynamic channel model
>>     better than hwmon's compile-time attribute groups.
> 
> This used to be true, but hwmon has for some years supported a similar
> model for channel creation to that of IIO + you even for traditional
> attributes it is easy enough to create them dynamically (that's afterall
> what the IIO core does under the hood!)
> 
> Anyhow, take a look at struct hwmon_chip_info and the HWMON_CHANNEL_INFO()
> macro.  I couldn't immediately spot a dynamic user but maybe Guenter can
> point to one.

Looked at these and a few drivers using dynamic allocation
(hp-wmi-sensors, mr75203). Agreed, hwmon handles dynamic channels
well, not a differentiator.

> 
>>
>> - The follow-up thermal driver uses the IIO consumer API
>>     (iio_channel_read) to aggregate temperature data across
>>     multiple satellites into thermal zones. The iio-hwmon bridge
>>     then exposes the same data to hwmon userspace.
> 
> This might be a good reason for IIO. However what stops you just embedding
> all that in a single hwmon driver that also registers the thermal zones?

Nothing prevents it technically. IIO consumer API gives a clean
separation between measurement provider and thermal aggregation,
but hwmon can register thermal zones directly.

> 
>>
>> So the architecture is: IIO driver (provider) -> iio-hwmon bridge
>> (hwmon exposure) + IIO consumer (thermal zones). This gives both
>> hwmon and thermal framework access through a single IIO provider.
> 
> So overall there are some possible reasons in here for using IIO but
> I think a little more in depth analysis is needed.

With 17 external ADC channels in mind, do you think IIO remains
appropriate here, or would you prefer we move to hwmon?

Thanks,
Salih

> 
> Thanks,
> 
> Jonathan
> 
>>>
>>> Guenter
>>>
>>
>> Salih.
>>
> 

