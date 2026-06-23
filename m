Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF7136404D;
	Tue, 23 Jun 2026 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214436; cv=fail; b=XxI4pLau5e4Rh+kqdJU5kZ03qMpq+tINceuC+WgVotGTCPECprfmYqZsGxbcC5XRX+bynvzrKoU4tk2SO6vcGDxc0YxpciM9MKRrEGfvZ1b3cm3xTl/2dHEqfZQedyMdcbt+j3rxpCT7MRtIDEcO6RLXRSWZGZ2j7FAySgbUzr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214436; c=relaxed/simple;
	bh=RjRa8sTixxd5r0SRWxNbMpNkXaNEGYf+UZScOdlNwBg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OkPZXVx3dKwK2y+YBQrDd/HlSHcQNX8S2CeYDxnVh0xhYrhKfx7gmqfpHNejisXetsvZXPwNSUbD8J0EJDFQhhWOAFQ9OUJBZRZ1b08sAczXmr+jvuxSsS40dqUubYjk3cLrdZ5bQQ6SEsBY/4ZPYxpCxobDffmr538AlnASSmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IMAwr9if; arc=fail smtp.client-ip=52.101.46.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IMAwr9if"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcvTLByiHJ6X1cYKFIdO0YYaKiCQQ838XAO4HX6UJCzG5emuLqi7wu0v6bKffdMaq4k1kgm24Ij/6otBqSylLwTyRcFsZhv4yo8/nfLpm/m1ITr3iSbSc8Shf4L7+4/hvhUyLVU2yoliFwo23US370ktAyM8pRPqFY9cZWAYr0pe+Pxy9g2BTWGvs3hlJJMtkKsld0nkQ/v9a13RtE09SB3n2ObgdXdu66qGq5Gbm8Fw3rj4bM4dMYBz7qsWitldHolAQLDrzkdKMrkmi0XSbZ9CBR932cYnLMx9k9KffBVIGOSQavzYfqoYzbvr/ad68p3mHo3GNzfhCUbkVHDclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmvkwU7QlSsZ6NLkRmPWwMepyxcGjcPWZDSY5u3hJgQ=;
 b=VmAw+nQ+XLlZrogeI18EzLexioBUNrWYxO1ICNv2kPBKFnu9i86xMKWULZKzDTIDPx3n7AXUQ+TNWzAcQgBhADiXt34f5160uKktoyQcCKHmOJqXcL2oH1APt31G5Pqvfn0rDQcJ1Q0zK0dYu3OjLYVwgR5GnIAQW+YNECq54AjuJG0pyoXlwSg/foYg0LobV+ojOcr9P7lyQsp50ZN9Idbmukvn8pHugqoO5Psdyf4FvauJHrJ2ClFdFX77Gtih1Ir+5N/yxR0CD6Jk2Q+cwvdRfuUEJ9ix4zfg1prj+vMmkQnCNHkkP7tXbuLTWnZ3fzfr0NLCIsTpWcYGkHbruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmvkwU7QlSsZ6NLkRmPWwMepyxcGjcPWZDSY5u3hJgQ=;
 b=IMAwr9ifi/Pd8OlPIo+g5orC1pIjiDodwYczdvqgzEhUPx3Cg4erA9DH/Q9qljmECw8AF4GdA6D44cVOpHuyWAoF6dKAxKsklSI7KtQT1GvqsPG7Uk/b/WEbuP+d4XaI1Va983L1ei5mbX/LRLB6k88gflZH/dLL5Xo+ZeJC4r0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 11:33:52 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 11:33:46 +0000
Message-ID: <bcbd202e-7d43-4f59-9ff3-59b564e4a3f4@amd.com>
Date: Tue, 23 Jun 2026 12:33:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/5] iio: adc: versal-sysmon: add I2C driver
To: jic23@kernel.org, andy@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, conall.ogriofa@amd.com,
 michal.simek@amd.com, linux@roeck-us.net, erimsalih@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260623014036.3865402-1-salih.erim@amd.com>
 <20260623014036.3865402-4-salih.erim@amd.com>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260623014036.3865402-4-salih.erim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::13) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8afd2a-9103-4e90-0c22-08ded11b4971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|18002099003|22082099003|56012099006|11063799006|3023799007|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	0rXhMYHVK2PREnf7RgrzEcnl43C1N02uoTrblitANyKSr6qYhYHiO95cSiVBv0FIEH21p4tpr8YJ+YEGqULOKaXLZqbRx5Mtv/vEG+wcB5v2zZFUInOWupxwa50QVxlBbRmXM2oNEiRJjSex2g4glk8mfvO7WGgHZQu3vV1UfJng7mjwMADNGpUrf8vZUzAHGz186Zut9tcFQNCfDQKrIRUGKQNwKp9DF0NgRpq0bMUdjORLZdEml3QVmLn3ik1oIn1t+4udK7dVCBlidPAaRV3/Cqc2NOu/Iy0JZXaJXIqmB49tAVNDQmDejxTmt5jNca5YixI8KcRDKNXwDrOOesADsaBgHrvCSEtLn5+rcUrvvEEwb745Gqk6TB0INJi8v03bExWqvBAcc7EGj8bO6YJNjy8BQrFxorynT+85lqNXOQredP+ko3G7RHhDQTyRNpwjGXwaKrJHBPxRXd5uTjck8KKICWEijG23cjb7/6+Bj2filOPaIHUF7kiFVWTsBqjkElyYMnqYM2okarIY0I6WI4PvKsehAXzKWDjOY5uFS9V5R088RSY9Dv2LEW444kx5y/9y1s847GqcneLwXzcuBYqfmr2tI17UopRlggK4emGLf6AegOKggWstVnPSw91Qj4nfA6bIDNUrdxkYEnsU9qH8mPF+pAoEwJ0LWZ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2U2NmluWmNLeHRPeHVkU0tuTUtRYTdTQzlxYmxJZGNXbjNJMWs3QkxMV05I?=
 =?utf-8?B?eURaVWFMV2NrZ3pOZVFTYmNtWFNCZTM2VTNzc25ORzBzVG04anppRk01dWF0?=
 =?utf-8?B?QkNoNjV5MHhyN2tleVdmK2p3ejZwMFdQUzViSWwwSFVhUldrVVpBRCsxWnhp?=
 =?utf-8?B?WVdMdUdKdGRhS1VsWFMzZGtSeUgraTQrYjQ0Y0wxMkk3ZnVXL0xGVVFQMlNO?=
 =?utf-8?B?dkxESERxZ3Y5NlRXMEpNb0grMHR5WTBYdFp1ZzYvODRTVWJYejZKMVc1azNn?=
 =?utf-8?B?T0RVWlJqZFBBYWd6ZUFVOUh5czQ0Qncyc0JCUHBGNmd5RUkrcDM2Zm8rbHRL?=
 =?utf-8?B?THBiUWRNWEJjQ1Z5YkZRSXJGcC9BVnFTL3F5Lyt1THRCRWhCTVNwelNwUDVZ?=
 =?utf-8?B?R3BNdVpIaDUxd2JuZEs5WER2VWd1UFlQZDVMR2tBclR0UVVkWmlLN3ZtblNu?=
 =?utf-8?B?alVnS3ZmR3Y2cmJGdUxmKzVGdmhRYW9FOXNmWnRFZmdDUG9iS1BYRmtqcmo5?=
 =?utf-8?B?K28xQUc3emdBcXRrL3BMZHYvWGpEYTFVUTlheEFTYVdWSGhFaFBaZ1h0UFFk?=
 =?utf-8?B?eGNCeW0xZlFFNU9OclhaMFZKZDhMNDZ3bE1Wa0Q0R1A2UnZISjl3MnQxMCtC?=
 =?utf-8?B?WmowOXorZi9IeG9TMnNRQzBiMEJIZTJwdUF6V0U4c0JCbHMwZ3h3cW5EbDRp?=
 =?utf-8?B?VEZTT2RCd0xWd05FalNmdjZGUHZkc0xYMlpCOWhWeTZmZkVSd001TGtuLzNw?=
 =?utf-8?B?WWQ2N0d3dUU0dlJzVFpoaW8zdmJhOGQxS01uMytUWVFnc1hSWW9DV2s4Nktq?=
 =?utf-8?B?bUcwRkxsVStZenQrbG5FdVJPRjhOWkkxSHE4VFB6ZXQyUWRZTkduajF2Vlhy?=
 =?utf-8?B?ODhDYWx1OGtFSUE2ZkVmK1RuYTY4czNScitpdWE4QU8zaTRNYjB4OWFkYkNS?=
 =?utf-8?B?amdKRjQ5RjljbEFjN0p6YzF3ek5jdUJxSGU1V2RYTVVYWWFlQmUzNXdJek9j?=
 =?utf-8?B?Sy9Hd29LaEtEYksvVnJ3c3pMKzdkeDNmUTIzWE9CRmVzVGZCNGRSZ00zS3M4?=
 =?utf-8?B?SXVETmtMdHlZV2huREpVZmxybFRiNFQyNFdQUzY4RkZoWnFuUHpjNndoNkxX?=
 =?utf-8?B?eHMraWhIR2hnQUp5bjhkVFdtOEdqS2RKTjZpRXg3a0tydU5Hem9WSjFBaHJz?=
 =?utf-8?B?WU9OMFhMaXRmMkZlVVBaMVNRYzd3V1BaTWRkejA3akxheDVLWjVJNUh4MDlz?=
 =?utf-8?B?bHFIeDcyTitmOTFVMVg5UEpsT2dJN213WnBZSlFDMUU0NnlOQTE1blNnSEJJ?=
 =?utf-8?B?d3ArK2lOamJhZzlwQ3pjazY4OEZGaENiRUZra0NRNEJUUzFuUi9sTVRGaCtU?=
 =?utf-8?B?VzRkL2lRWGVDcEZsSHorcGp2aHl5ZElwek9ySTVGS1ZqNUVtd1lZQ1JqcTc3?=
 =?utf-8?B?SnVScXRxblhGR2xKWHVsbkpGb1NZT1N0Q21wL1RieFdtVkRsVFdNTmlkcWtk?=
 =?utf-8?B?U0puaUwwVHpzM1JzS3JLSVRHL0puZzBzNWR1UzZqc1hQK1NVRXhVeDNSaUxK?=
 =?utf-8?B?K041SnNMTGd4dDhaVDR6Q0xkT2xQR3dFbU5xZnpCaXUrZ1ZkMGtLNkdhenhE?=
 =?utf-8?B?dkk3SENPVVhsL3R5QStpZTJ5OFV4NUpqRy9YSTR1VUx6V2IvQlc0SXpBanlN?=
 =?utf-8?B?WnN6RXVvM3RVTTk4cGhlQXFZT1FubDRQR1RSK1hHVmMzeEFua0tZWDRaM3RI?=
 =?utf-8?B?NDRET2NGeWNzanBmRnFtV3hkZVJBRGsvQWxqYzJ1b04rdE1hKzNCZm1OZ0Jt?=
 =?utf-8?B?VEpYdCtoMjBFYlMrRm5xakhOT3ZBKytCUnQxUGVJdGFUb1JRMkhwVnJ2WlQy?=
 =?utf-8?B?eUozTENUeGx2NnNuc0tQVmo0NjFuRUl3Q1V2QkJBeUxDOWJxcncrRmRKUkov?=
 =?utf-8?B?K25IbUJnTVNwVXV6K0YzUlFiNk9xdUJ5MDdIOHRacERETzZkUi9xNU4yLzhO?=
 =?utf-8?B?WGl1VEt3c1JZVHVXUDVRdk5XUU5YYTZXVUROVjRQZHNtUG9BWWNwVEViem5m?=
 =?utf-8?B?dXIyS3pZSWhmOWExeFpwdVZjd3pQYnhON28vUHdiZjV5TzJua1hyZzQ1ZVUr?=
 =?utf-8?B?NkNGWnpCcndnalI1MlJtQ2RGWUsrMlM5azVqbVZoK3V6NlBwMG9pQ0xTWTc4?=
 =?utf-8?B?eWpIa0Q3U2NoOVAyd0R0L0tGckJkbkx0M3psN2g5cVF0eXl1R2NFMnpFVzVM?=
 =?utf-8?B?STgrVC9LYVlUeHhyS3orSEhlVkcwdWhGNGhoYTJXSUQ4aUlidE15blFKTGpF?=
 =?utf-8?Q?YL8O/eVBoUUUY+r9Nd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8afd2a-9103-4e90-0c22-08ded11b4971
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:33:46.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikIQ3umywmq4DFskzy/yARaH7ZKXX/PvtLWzMaZaWVwLQRGsHAiKFb24Y+xpGFH7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049

Addressing Sashiko findings on this patch:

- [High] Non-atomic I2C read transaction releases the bus lock,
   making it vulnerable to bus interleaving.

   The SysMon I2C interface is typically on a dedicated bus with
   no other devices. The current implementation works correctly
   in all tested configurations. Switching to i2c_transfer() with
   Repeated Start would match the TRM protocol diagram but would
   require hardware testing on a board with I2C-accessible SysMon.
   No change for now.

Thanks,
Salih

On 23/06/2026 02:40, Salih Erim wrote:
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
> Changes in v11:
>    - No code changes
> 
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

