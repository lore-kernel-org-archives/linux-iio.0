Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF8E3101C0;
	Tue, 23 Jun 2026 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174450; cv=fail; b=pFVsivgvjOES+mq4NwheX1RMW78EJlAFsldOXVNBMl7DbHORacFgVPlhBdtaHDuN+lMWbbhcBfQ2Y6unwDY9/YtSzULOYEhAl3E01dIOj33igOH2OGD3XXJM9VKQCiDaJ7eVxKCDzGKWHFRzG6HP4cLt33144EqqRFIuSCNYvnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174450; c=relaxed/simple;
	bh=QvKBTATD2UGwB3HUUj4E2iwEkkDBLZw5F98JLnCpfRc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VWeOapCZkjdqZ5OlV+Z+BUgT/kFhi7IYXjjskYHQNDLEAljdSeIyiGAQSVACDyMWdbjG0WAcFyRacX5Pkrx4aOMOWDqBJdNvZTuS4Lxw6dOtL47hmfBvgfn4jz0sMMcm8HssFYc9nw6f9Ljf0aEsXhmct0MFWzRI1vMj/v/xMcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hg0y4h+7; arc=fail smtp.client-ip=52.101.56.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hg0y4h+7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoosygRkbYBjvE+hhKzR7V8YL0D62xCF7Qf8Y8ADjsFIUakAUxYIbQ3HjeH+a3f/OT4WMUVwdWsFM23RrSeOi4u7+Tick6odNIAQAHWJy7MTX2w/lxFq/356Yuvb+54piJJCUMgKK8xcaVOoKZ+vMFPk1rf8ckIwyxlK7LuAToHe1ypeHRL4tZLWi7wIPrcP5y7OFtyEgY6aT8P7ukb3NdPWunMVYdGQATjZJBIC1PZm/nW9MePJwehdPb8EYidNjLxCteekBsCDaNAk1cttds8Ua3gNhPX9AX3TC+SkdvgpFR6YPPT/NFv3JJ5hZn5yrq3Jdetpoxoyuocztjon0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLTioV8XtWn87GltMvHFtlPSzB+cIaExQVIpMkL7lxY=;
 b=h+ClGmr2lTtXwSlCBYUBoGJlpXuPcI18RmOWOmvcAZAb/eN+e+NegpX5oVvxKmbQjD0sP9Pzcb//MinAuHDPnLnAeVFFwEXiolKtwLP6OohvHbog8Qx0iDVqQ+tJvnu116oacyLf9tNw7if571B7jKDHuyv5/quKRZw/Z0L2sx9t4gn6gPnnUVrYclAdTabIteBixNp0G3nhqOS7tvKCfNnUBAygCAWX+Wlf4eXYm3hrCB8y6dM1jPDwJFDSnPtl27Crcn71uFTL1EFub072UBuKkgpowC6+KYNZGdjN91GrB9aszpCWhZii8ZbGJMixhGoJ7M1yaGvO5lRfiQivCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLTioV8XtWn87GltMvHFtlPSzB+cIaExQVIpMkL7lxY=;
 b=hg0y4h+75Vkx8F17kpWLIleB4iUpk1SMIsRdJrgW0vet/j+TgtbupJiEE+rdgEmazN4aJ8+U3hj8l6Be5WFVqjIE76AZV0Q8ZOT8zxEPWxZcl6g3UALcyzPJUfY4nmKbRqYfVzEDrmFVZ6slf6urtOIWqplJ21y+WF0zhPJUs7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 00:26:54 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 00:26:54 +0000
Message-ID: <49cb8cf8-0aa2-4255-860e-536ea4a29cef@amd.com>
Date: Tue, 23 Jun 2026 01:26:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/5] iio: adc: versal-sysmon: add I2C driver
To: jic23@kernel.org, andy@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, conall.ogriofa@amd.com,
 michal.simek@amd.com, linux@roeck-us.net, erimsalih@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260618101414.3462934-1-salih.erim@amd.com>
 <20260618101414.3462934-4-salih.erim@amd.com>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260618101414.3462934-4-salih.erim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::16) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 410f4676-f7f5-4ba8-7a53-08ded0be205c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|6133799003|22082099003|18002099003|4143699003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	/ZOTaihNFblJhBkkplC97USD8ZOT5YpS/sGh9OsusewApQfJ2nRxU9aFITet/4Rrj2/xzAB2qCywabEXbftE7EhOvq1fUA5YDKn79QcR092uSzOawYFBelW1ctl8UDuSwsIHEGYt7dUMkhHvfd3xGzE0lKi/BA5bn+M+ghYGq/z1NPCN4dwH7K1FRltkhGnIEUurkSPjjBkrM8IgbhO0Mpnt/y5M9wz7x7lTW3MhycI7/h2MiDxid0tc52oE5PCUF+GPMDDQyGOgeLwOJmppauX5x7cZsV8Ev+bfd8YGIvk0XYmxj48pEsDkOvqdndQ8DcJTkJMq2B6mcW7MgD1iTVZIN/JFyMGu17dcRuVfmZjNf3pAV98LbK1vXVLDmrEMm6pDHYekmY8/7cNP034bGNT6IFaMOkLPT0UgopjwA2jsFJ+4gm5rP6uIVSvpFNrAlLHNrroSmorzhnxsuZLATXiMsiHDDFbcCdvNkBL4glSDkot5JFt5bSmMIslm56SKY19zTHj4krc5kzd+I4wjtxKCbZsY8QLD8jvNLarlZBiCkejPgUnRoL1Tacwe9cVn/UT7vPcIueXTsRTrtXPRNj8Ua2QNXGm/2CB5xpn4mB4emALiTSwjmqse8Gv3V3WR3ySQ7voZvP52YLKxqcrJqu+hq/wnrnE22/Sxqu4XOvM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUJqMWxheHN4WWdKbkZxVTBFVVZqendpaHdndVN5MnpXbThTeXRxNUJLcUtL?=
 =?utf-8?B?S1gwTXVvczhrK1pGbzJmM3lBS2x6T0s0L1BTOEpOdEtPMWlxcTZyNjdiK2Fm?=
 =?utf-8?B?SXNMZGYwdUM1cFp5RFpzRzhZdVk4cXZGVXFEVXg0UEdnVCsxY0h3OXVmTlo3?=
 =?utf-8?B?MWxzazIwcTNvMEQ0Q1lhRFhZaDVSUGhhMWxOd0M4K1pmQmw4K0YxalBaN0d3?=
 =?utf-8?B?SktkUEdUL1F0YXlrK2g0K2F4OUd2aHMvREhLM2hMazBhRk5NMGFJYkMvNHhB?=
 =?utf-8?B?b1hpQUlObXVrb2Yvd01LNU1iT1QrWTRBemNaK05qd0tyNkhmRlRZdnZyQTly?=
 =?utf-8?B?VHV1Nml6bUtxWHdFYndGQzRQNmMyYThaYnQ4dXZ5Q2paK1YyYXJBbkFoeVdZ?=
 =?utf-8?B?aEc3M2FaOExUM3VlRGlVczhxaytVZmhOWWgzM1pXQ2Fpa0x6K3daRkZuRERx?=
 =?utf-8?B?WUl2UkhieXZYR3FHZG1rMi9zRFR4Q1orYXgzNi9BM1Z5S3VFdnRabVBOelFW?=
 =?utf-8?B?TlVFZzYreHorNHdMczIvbS9wbTU2TjJKY2NickNCSzBWSFQ5L29xM0hRdFlz?=
 =?utf-8?B?OVpWMnZLRVFRQWdNbEVydXVkcW9LMXBVcElPWWxqUXFKa0xQVnAzaW93Q2RY?=
 =?utf-8?B?OWRMd1cyUERQYloxTjdmcjFjUEhpSnJVemNwQVJvUE0xTkd3QWZWQ2cvNTk2?=
 =?utf-8?B?c3RYS0g0RmZiWk9QbnBaNDJuWEV0TXQ2R1pFN2tVMEtOVCtPS0ZyQlNYRGVq?=
 =?utf-8?B?Vi9yL3BiLytNemZiWkxqbkhUTUFPcXdMVzJqdW5heC94WDdQWmJuVE15YXdE?=
 =?utf-8?B?ODNDYkhQNXRnbitiQ3hBc3FuVXdqQWRZSk1HWXY1QVgwZFpIOWRQL3RuVjhy?=
 =?utf-8?B?UmVZSTBmVFU0NEgwRWJMbUlzclM2b1F0ZlVuUjRnMDRsVEVEWVB5UVdhZVlw?=
 =?utf-8?B?YjJhYVBzOGRJd1NpcDlTeHd5TjJlTE13YituMXZyS2JNdXlEWkhjR3VQa2FM?=
 =?utf-8?B?bzB2UjlYRWlVOTgyU3Q3a3RxNWpET0RaRWh5MmlnOXVDUkFSU0U0eS9wWlZ1?=
 =?utf-8?B?ZTU1MHFQdGVHWnpOQ1FuNVp0aXpmSzdhYXd6UEY4eXp2N1NtRzk1VmF3aGFZ?=
 =?utf-8?B?eEVzZlRzMUd0TFZ3aUppVlpHSkRWc3hRQ0wvMENKQ24rYkg0M1VmOVM4aTF0?=
 =?utf-8?B?OGVGa09JM2crOTd1QUUzY2pBVEc2amR3Y0YrbC9zMjhNRmlueG5WNFdwZnh2?=
 =?utf-8?B?TkJNR2FyZlhodGYzK05zaDhEcHdodi9ZNmRHRzlyMldydEthbVBkNUdaT2tz?=
 =?utf-8?B?aDBZMFR1eXIvcW95Wk8wUHo0dkhNWXVMSkh5VzAveGNGeFNIYUNRUkUwOXY3?=
 =?utf-8?B?cjltUEdubW9hTFp4WEVtMUlFUCtZaU5wb01iMk0xVHNzY0dEcmloV0huNGEx?=
 =?utf-8?B?bXlMaFhBeFZaMXczMktKclJRNzVqN2NXUkt3cVZnR2pHSHpUUUo5SC95NFB1?=
 =?utf-8?B?bWJQdG1iV3NzakRUbHNldEt4ZnNEMS9KMVNxdHFVZkt1Q09MNW1ITHBkN0tj?=
 =?utf-8?B?RUVrRUYwNm5LUzhOQ2RnVXE5aHBZNk5hNHRvODI4cGFmSmR4M2V0akdMSXdD?=
 =?utf-8?B?T1RQTFB3VGp3ajNCYUZIY3JSU0lSS2liWXdyNXBaeFhQL2k4VnNVVDVRamNM?=
 =?utf-8?B?TkcyN05sU1FVWXppK3NnUzJYNE84bitRUnlJMnpqN3VYZFNoSkZkZ3FXR3hs?=
 =?utf-8?B?QnN5citTaGF6aHgraitRMk40Q2F2aHQxaGNkWmVXSWFnTW10S1lraHc4d1Ny?=
 =?utf-8?B?MGFwdlkrb3RSQXdvcFZPc0NrbHpzSGczeG9jVEhsSjVjOGpBK29BNG52QnFV?=
 =?utf-8?B?cWozeGlvU0ZzYmlsRHRxUEtIV0tqRTYwK0tSRjRQSlkrYWRraldzbjJhYnpQ?=
 =?utf-8?B?dklkb09RUEFLek1NMjlsdnZ1akJQZFBUUlFFMjE3VTBoRk52LytEVHRjV0Uz?=
 =?utf-8?B?WEYycUVBYnRqbUtXZDU0YmN6TE1vMWhSQmJSWnJZRWRtMmxGTVZYM0FmWW9D?=
 =?utf-8?B?UVYyNTE2eHh0VkdQTFB0MjlsZmE0UDRNa2ZyaStONDVtUkRmZndFdGFiQWd5?=
 =?utf-8?B?Q29zUjU4bllGVnY0QS9lYnlhUE94RmRWL3lNbmdFMTh2OGtkbXJFdzNtck1a?=
 =?utf-8?B?cy9ENXZtVGhXeElZM0o4dFpKc2tBbzlnUWJTS3dZU1JFc3UxSkQvSG1PeSt4?=
 =?utf-8?B?bzVDdDFJcjdRVUp2Zk5qOWQwdDJRYk5KYVpnR1NidmRDQmM4MjJXaW1CRmRX?=
 =?utf-8?Q?6fUjTSLlgrlZLMXytI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410f4676-f7f5-4ba8-7a53-08ded0be205c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 00:26:54.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcHIH9zmz1RoaQmPT1eDSj8kX9OfuyjH4lhJNBlZN7Z3X01Qrmzga2FLJZFakNg3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291

Addressing Sashiko findings on this patch:

- [High] I2C transfer buffers are allocated on the stack, which
   can cause a kernel panic if the underlying I2C adapter driver
   uses DMA.

   Not applicable for this hardware. The Versal SysMon I2C
   interface is accessed through Xilinx I2C controllers
   (xiic/cdns-i2c) which use PIO, not DMA. No change needed.

- [High] I2C regmap backend is executed in hardirq and spinlock
   context if an IRQ is erroneously specified in the device tree.

   The DT binding does not allow interrupts on the I2C node, and
   the I2C probe code explicitly documents this. The core driver
   only registers an IRQ handler if fwnode_irq_get() returns a
   valid IRQ, which it won't for a correctly configured I2C node.
   No change needed.

Thanks,
Salih

On 18/06/2026 11:14, Salih Erim wrote:
> Add an I2C transport driver for the Versal SysMon block. The SysMon
> provides an I2C slave interface that allows an external master to
> read voltage and temperature measurements through the same register
> map used by the MMIO path.
> 
> The I2C command frame is an 8-byte structure containing a 4-byte data
> payload, a 2-byte register offset, and a 1-byte instruction field.
> Read operations send the frame with a read instruction, then receive
> a 4-byte response containing the register value.
> 
> Events are not supported on the I2C path because there is no
> interrupt line and the I2C regmap backend cannot be called from
> atomic context.
> 
> Co-developed-by: Conall O'Griofa <conall.ogriofa@amd.com>
> Signed-off-by: Conall O'Griofa <conall.ogriofa@amd.com>
> Signed-off-by: Salih Erim <salih.erim@amd.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
> Changes in v10:
>    - No code changes
> 
> Changes in v9:
>    - Add Reviewed-by tag from Andy Shevchenko
>    - Add MODULE_IMPORT_NS("VERSAL_SYSMON") (Andy, from P2 namespace)
> 
> Changes in v8:
>    - Add volatile register comment for regmap cache (Andy)
>    - Update devm_versal_sysmon_core_probe call site (Andy, from P2 rename)
> 
> Changes in v7:
>    - No code changes
> 
> Changes in v6:
>    - Add types.h include (IWYU) (Andy)
>    - Add local struct device *dev, join devm_regmap_init on
>      one line (Andy)
> 
> Changes in v5:
>    - Add err.h, mod_devicetable.h includes (IWYU) (Andy)
> 
> Changes in v4:
>    - Replace enum with defines for I2C frame offsets (Jonathan)
>    - Use get_unaligned_le32() for read data reassembly (Jonathan)
>    - Use put_unaligned_le32/le16() for write data and register offset
>      packing (Jonathan)
>    - Named initializer in i2c_device_id (Jonathan)
>    - Drop bitfield.h, add unaligned.h (FIELD_GET/FIELD_PREP replaced
>      by unaligned accessors)
> 
> Changes in v3:
>    - IWYU: fix includes (Andy)
>    - Enum: assign all values explicitly for HW-mapped fields (Andy)
>    - Remove sysmon_i2c wrapper struct, pass i2c_client directly
>      (Andy)
>    - Use sizeof() for I2C buffer lengths instead of defines (Andy)
>    - Use = { } instead of = { 0 } for initializers (Andy)
>    - Use single compatible xlnx,versal-sysmon (Krzysztof)
>    - Adapt to core_probe interface change: irq moved to core,
>      remove irq parameter from bus driver (Jonathan)
> 
> Changes in v2:
>    - New patch (I2C was deferred to Series B in v1)
>    - Uses regmap API with custom I2C read/write callbacks
>    - Shares core module with MMIO driver via sysmon_core_probe()
>    - No event support (I2C has no interrupt line)
>    - Separate VERSAL_SYSMON_I2C Kconfig symbol
>    - Reverse Christmas Tree variable ordering in read/write functions
>   drivers/iio/adc/Kconfig             |  13 +++
>   drivers/iio/adc/Makefile            |   1 +
>   drivers/iio/adc/versal-sysmon-i2c.c | 134 ++++++++++++++++++++++++++++
>   3 files changed, 148 insertions(+)
>   create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index c7f19057484..8f9fc9de74a 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1963,6 +1963,19 @@ config VERSAL_SYSMON
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called versal-sysmon.
>   
> +config VERSAL_SYSMON_I2C
> +	tristate "AMD Versal SysMon I2C driver"
> +	depends on I2C
> +	select VERSAL_SYSMON_CORE
> +	help
> +	  Say yes here to have support for the AMD/Xilinx Versal System
> +	  Monitor (SysMon) via I2C interface. This driver enables voltage
> +	  and temperature monitoring when the Versal chip has SysMon
> +	  configured with I2C access.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called versal-sysmon-i2c.
> +
>   config VF610_ADC
>   	tristate "Freescale vf610 ADC driver"
>   	depends on HAS_IOMEM
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d7696b1b157..5abb611fe46 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -169,6 +169,7 @@ obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
>   obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
>   obj-$(CONFIG_VERSAL_SYSMON_CORE) += versal-sysmon-core.o
>   obj-$(CONFIG_VERSAL_SYSMON) += versal-sysmon.o
> +obj-$(CONFIG_VERSAL_SYSMON_I2C) += versal-sysmon-i2c.o
>   obj-$(CONFIG_VF610_ADC) += vf610_adc.o
>   obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
>   obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
> diff --git a/drivers/iio/adc/versal-sysmon-i2c.c b/drivers/iio/adc/versal-sysmon-i2c.c
> new file mode 100644
> index 00000000000..e9a7629159a
> --- /dev/null
> +++ b/drivers/iio/adc/versal-sysmon-i2c.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD Versal SysMon I2C driver
> + *
> + * Copyright (C) 2023 - 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +
> +#include "versal-sysmon.h"
> +
> +#define SYSMON_I2C_INSTR_READ	BIT(2)
> +#define SYSMON_I2C_INSTR_WRITE	BIT(3)
> +
> +/*
> + * I2C command frame layout (8 bytes):
> + *   [0..3] data payload (little-endian u32)
> + *   [4..5] register offset >> 2 (little-endian u16)
> + *   [6]    instruction (read/write)
> + *   [7]    reserved
> + */
> +#define SYSMON_I2C_DATA_OFS	0
> +#define SYSMON_I2C_REG_OFS	4
> +#define SYSMON_I2C_INSTR_OFS	6
> +
> +static int sysmon_i2c_reg_read(void *context, unsigned int reg,
> +			       unsigned int *val)
> +{
> +	struct i2c_client *client = context;
> +	u8 write_buf[8] = { };
> +	u8 read_buf[4];
> +	int ret;
> +
> +	put_unaligned_le16(reg >> 2, &write_buf[SYSMON_I2C_REG_OFS]);
> +	write_buf[SYSMON_I2C_INSTR_OFS] = SYSMON_I2C_INSTR_READ;
> +
> +	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(write_buf))
> +		return -EIO;
> +
> +	ret = i2c_master_recv(client, read_buf, sizeof(read_buf));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(read_buf))
> +		return -EIO;
> +
> +	*val = get_unaligned_le32(read_buf);
> +
> +	return 0;
> +}
> +
> +static int sysmon_i2c_reg_write(void *context, unsigned int reg,
> +				unsigned int val)
> +{
> +	struct i2c_client *client = context;
> +	u8 write_buf[8] = { };
> +	int ret;
> +
> +	put_unaligned_le32(val, &write_buf[SYSMON_I2C_DATA_OFS]);
> +	put_unaligned_le16(reg >> 2, &write_buf[SYSMON_I2C_REG_OFS]);
> +	write_buf[SYSMON_I2C_INSTR_OFS] = SYSMON_I2C_INSTR_WRITE;
> +
> +	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(write_buf))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +/*
> + * Almost all registers are volatile (live ADC readings, interrupt
> + * status). The rest are not accessed often enough to benefit from
> + * caching.
> + */
> +static const struct regmap_config sysmon_i2c_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = SYSMON_REG_STRIDE,
> +	.max_register = SYSMON_MAX_REG,
> +	.reg_read = sysmon_i2c_reg_read,
> +	.reg_write = sysmon_i2c_reg_write,
> +};
> +
> +static int sysmon_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init(dev, NULL, client, &sysmon_i2c_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	/* I2C has no IRQ connection; events are not supported */
> +	return devm_versal_sysmon_core_probe(dev, regmap);
> +}
> +
> +static const struct of_device_id sysmon_i2c_of_match_table[] = {
> +	{ .compatible = "xlnx,versal-sysmon" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sysmon_i2c_of_match_table);
> +
> +static const struct i2c_device_id sysmon_i2c_id_table[] = {
> +	{ .name = "versal-sysmon" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sysmon_i2c_id_table);
> +
> +static struct i2c_driver sysmon_i2c_driver = {
> +	.probe = sysmon_i2c_probe,
> +	.driver = {
> +		.name = "versal-sysmon-i2c",
> +		.of_match_table = sysmon_i2c_of_match_table,
> +	},
> +	.id_table = sysmon_i2c_id_table,
> +};
> +module_i2c_driver(sysmon_i2c_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("AMD Versal SysMon I2C Driver");
> +MODULE_IMPORT_NS("VERSAL_SYSMON");
> +MODULE_AUTHOR("Conall O'Griofa <conall.ogriofa@amd.com>");
> +MODULE_AUTHOR("Salih Erim <salih.erim@amd.com>");

