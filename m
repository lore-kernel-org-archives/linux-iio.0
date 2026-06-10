Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D0B3932F7;
	Wed, 10 Jun 2026 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092621; cv=fail; b=t1+k6HTAQaFb1J3I92MQeEiUzz84aDsW4XdXqmepEtQfcjnX+EkYUmJKwZxqv286O4MTX8qT2mLiyqypBeI93z+mNcVE1G304w9tH0s+qEgHJmOtDZUeTSBctokpWLKJXf6dp+iD2Ix1FEoK+YJSSp1gQPZsV7P7epYgruCV4wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092621; c=relaxed/simple;
	bh=GBUkSxra48CobRabLu5WReIvPyyIMK0K2dIBlYRcYAU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=njLXczkTog91ZAFIauFtvafCzLzmq05lAmWEWi2nJmSyq9IOb7Q0l1kgz8MryvRhW1g1cF5tPj2Yw/+NHdIvYBKlx1yI0VjjtQpwoBOvX+xu2/PquBfaHQBumPA3GK+1f975utAP1WxXYX6XzCLyCLPkgP0bNJLOEIpcBUGhOvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=avcxcumx; arc=fail smtp.client-ip=40.93.194.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="avcxcumx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVbYhR3jNBOWRrYVUmlL6eZkGysjiWxvTZNY8l/5ia9KB4K8hIc30zl0iHHKab93dM8Qsd2ojgfC4hr4IfrbkOsVS8hrEA9w7xhZBCHL6WitdbcKW38IMek9ogt1hEH0ImSPHzG4IHAR3wVnp+DWdhwHD2P60awlkUPUukIl9Md3RKOsBfwNPmNah3FrzJnIMZI7QYJqk8wTtl1RkMOKb2pxnang+89MEuPlzHcPItPtvhxUZe1OexGskVo7UZYChek5WetvVsyAUyZAuEaffasCkIJihbGUqKSu8TlAHQzT4QhRu5LGjfV9fh/L3qoflT5HkDYwpEi3nKKj1IPjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBg9uFwfE4or8TQrsajeNEKuEqcyGKpEWOhmI9bfJAM=;
 b=hGLkhR/hdfAW0lY5opu/4eUdUcmO3nFgP0t9Fws9ptvv0E6r9z71bHsXFQ5Xpel7ESWAO+fj4LNZV57ie4/hZIEBkWpRo3P+GKdNTWB71SdbvDer7gv8N0nFhG63HF91hEcSzEKqPCSLC3S7OSQZDIrKVg8M8Wd6Zzu8fzCTLmemkYP1BjIrctgTJ8UgYhP/1izw8hlbiIRrcuc8IKszOIbz+odV5Pyp7SSHOuJ7R5AJATrVZsX6RE/Oyw9Pb8GIBBnl0mXbYr/l/tXW0xkmWcKFd8w8qe2SjI3etCxGz2+fQTyqBZpGpmFpvFPiQ+2zRr15YnDoCc3JpWjfP/OOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBg9uFwfE4or8TQrsajeNEKuEqcyGKpEWOhmI9bfJAM=;
 b=avcxcumx+aP0PY9KUF1WUdEivaqgRH8OjAhZOWfPtMLJI2IAydFxXUckpRS4JaQnU691O4obykPlH7fIWm88ATReh6+faf/KqPpTLWKqGaUDv3lUm1NxNufWbKbUxodYOMnSVfHdfeFQ3zDD5P3wzKxQogsJjZ1nmZVJq3BpWzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 11:56:56 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 11:56:56 +0000
Message-ID: <4416c930-73a1-43c2-a60a-852898c64f1a@amd.com>
Date: Wed, 10 Jun 2026 12:56:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] iio: adc: versal-sysmon: add I2C driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
 linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260608183801.1257051-1-salih.erim@amd.com>
 <20260608183801.1257051-4-salih.erim@amd.com>
 <aihPvR0u5Lo3xELX@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <aihPvR0u5Lo3xELX@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::13) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: ac379902-6e5d-4cbf-a81b-08dec6e75e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|3023799007|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IDVMzKqFoIHdAlMsdVoMotzmADSxHP15pVLrcO/cu6jmlzq+ZbyrVSgNeD3bpybWzf/XWbMoTbxPC88gjTJgk1Wqmk8QyUprHwHNrFD8ecmM6VFFJU+j4IqO2GTya4fEMu97Kz6vh8ARgEox4Gmjiu4wdNwF0oDAlfBn2iqaISWiz0dRjSXKLtalKQ8p+ikYjXcfFmPqF+PGhFvWPo63J6uMVh2DmmB70ObOFRU74B05ygKj8g+PKE3rdEPmowgqSp7LRjkbqpz7p2kYG9JmjYN4Q7EP6SM8+CAWORdXw8KcYYr6EeMRvP5fRhghHIWWUOXkkY+kYdrXmGaq9jV+agJw1zHGz3Wkal32uDf8T3xr5OBq33B5oDJDL23Y3VxLWQO2IFCUeFxn3kuhBtKZXayawp3bjYYvDAmTkJKCi8ew6D1pZkBtXThCBOur78RwzMBOKhnVN3xwODak8KGYieTNiXC/MUmH7VR4RkmUfmKpNy3itjN3+0Vr/7NOnOrFqbBbcgN4fqy/DC8zj6UGmyo4wCNJpoOF3hTZlINvwEooXxAR0uF7QCTc1VUbJTNzWSN1LlB9cDp4G6f8ou3N4D8AmesbjO5ZcTGGuYfzVLPyNcMmtmg6fXmRghWmNyoBSaZwgUiqCz3OdWVWWmfMBqY12i29bWW++UL8TlViVlAyB9xP87NOL6UIWfMFA567
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(3023799007)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFN3VU0rL3E1b2g0cjFKNUtSNWMvaDU4bHZFSlNkZTRtT2ZWbGlNd0c0WWk3?=
 =?utf-8?B?VXJBQjJhSDQ0R2wxNUtRK3BkTGlTSnZ3OEluQnU0cGdrQ3I5K0c0VThITlVM?=
 =?utf-8?B?ZHM3NHdVT0s0NnI1bUN3UnhqY0pTd0tNYkh1ZlVtOGZKdmxIYXZ6Q1AvV3lh?=
 =?utf-8?B?SWhFUVlLaVFlWTlneng0aDRMNzhiZ25DN0pPRm1FUFNyTjlheDdlancwWS9S?=
 =?utf-8?B?ckFFWERScjB6cndXL2xKL0VLcXp0YTkyUlJpN216Mi9LQTF0cEZrbGcxKzhQ?=
 =?utf-8?B?YXlQMC9FeWJrdHNxTlNGLzVnQnpTdG8xZGVjOFBhZGUwYVU1QVNVZHJteEVJ?=
 =?utf-8?B?RW0ra0lEdER3eVM0L3Jnb3RTV21KRXo4MFlMMUxIZ1RTYWVYTVBvSlAxSm1X?=
 =?utf-8?B?R2szZk9sZFA0ZjhPRGMrMHlFUVp0TjgrSmtvOVVFN2Rxem1CbjFOeFlXZmhK?=
 =?utf-8?B?a0tDWkdRNVlmWENYV21mWUkxVmJPMHR3WXA1eUs4YU1MOW5LVW15aGR2VXVO?=
 =?utf-8?B?TDloMzMyY1Jmb05lLytUZ1hZVEZTQWVZK2h2UEY0eDRIYU1PaTJGdkorUU5w?=
 =?utf-8?B?eGFvdW9JWWQxSzI4a09ZRXdJaUlVSFRURGx5UmdNZDE2cThFT2hGRHZ2T3ds?=
 =?utf-8?B?bXNKT0RIOUc0cU5zamkvYVBqbVJIem5UenRzWmM5cGY2YnNCbWNvTGZKaXli?=
 =?utf-8?B?TDZPMldrelpXU3hPelVFZkFjQlR0dzlDUEJBcWU2QkVuODNCaStEcXlEL00r?=
 =?utf-8?B?bXhRanp3S0ZSOXE0b1pzVSt1Z0lYYVQ5SGl6V3JaUlc2c3hwc0pxNTEwSVNV?=
 =?utf-8?B?U3B5MTVab0ZSYkxBemc0SlhGOG1OVGpHZHc5eTV5aUkyNksxMWdJU0lFNWM4?=
 =?utf-8?B?ZTNMczNZWmFld0F2NlVXcUZQSHJ3WHRWUFR4YjIvbVNMcVdGK2tHMFdHdDl6?=
 =?utf-8?B?NFJQeW1VLzNFMHRSc1VzcWFJSGQ5VTB1dkxLdkxQSW9oM3AvNFhDQ1FDMWhJ?=
 =?utf-8?B?azVWVUxRcHNiRFVuT3FzdXFWTjZjV2dNYjFsVXRBakFBWWtBRmorQ0ZjWnoz?=
 =?utf-8?B?UjY1eFN5ZmIyenJCRjJLb1lzRk5hZEdwekQ5WW12VzdjVjRDZUVWL2hxSGYy?=
 =?utf-8?B?cGc1MFFjM2pIZStYM1cxbW00V0dTNXpyQitIbDV3SkJQSTVXbzUyL1c3V3Vq?=
 =?utf-8?B?RHEzVUpYYVFUcUdrZjFJZUx6RHh0U0oxMUlkbkNrTlRsbzVwL2JieUJvb0FZ?=
 =?utf-8?B?aU9Ub2VvWWJVbnhVZm0xcytBSEM4M3pQY0NkWUJQNlc2TlJ1dFBhVHRVN05X?=
 =?utf-8?B?eXNzQkd3ZGdWcW54VVVZbUF2dHZlUXpQRmJ3K0lQVUZJYS9nc3A0UGwwaVNS?=
 =?utf-8?B?NTFWdTBuYTdMLytjQ1Q1eWt3UGFvMW1EaUlKWnNjZkcxVGwxWlRyZTZvWWJF?=
 =?utf-8?B?TmRZSHNJWnJtV3FRaHJOMXhQZXc2cUpKeVFnZWlSd2JJMGNkaTl6a1h1VlRO?=
 =?utf-8?B?QjNMMEtQK29OeHkyaDJOaEhDRzNWc2VKbUVlaCtodWtHbmdhYkcwUGxEejVY?=
 =?utf-8?B?RVVIRzdwYjlTY05sVWlRSU1jd1ZhSnlHMTZ5VzdOcU9MV1phYjFKRmhSTGJP?=
 =?utf-8?B?alpCMFNYQms5eDh5VHRNaWMyME5kRjROZ0VJNUxxclVmbGpadEJXTm85SW5x?=
 =?utf-8?B?SENOVHcvOVFLVWpjd3JKbHFQTUoveGVjYjdjVmlxbjRGc2JHT2ZqUS9yUG1u?=
 =?utf-8?B?ajRBOEY0VVJmRDU3U3JBSzhmN0xSWEhZVEtLZkxzbDdOL3dWMVJCTWhta2hD?=
 =?utf-8?B?dkJHRVgyYjJXdGgzNVUrVmVmV0tXWEFoaVN2MEYvRVA4VXMyVllFSVZha3k4?=
 =?utf-8?B?dlRNQUwyYW9ZM3liamJ4YW1yQlloWVMrb1hSdHpVR2VkZnNBWFFmN0VCOWg1?=
 =?utf-8?B?MVdDbXJoRlgzaERYeUNBdjNCQk1KVlVYano0Tjh0MUhMdlk4SUtLamFMSklJ?=
 =?utf-8?B?MVF0ZWVsend3bkRKUHVxcGlPa2l5dVZoVTlRelhEYVM1czlYbUFvQUVoWnhK?=
 =?utf-8?B?OGdEd0Yva29BQXdrSnA5aUNKaC9sa3lWOWxYaWFmTWR1S0lVdm1YZWZzalEw?=
 =?utf-8?B?TEd1alcyaEphU21Cc083Qk8vME5xZW0welQ0VldQR0VNTCtBY0lVeG5nN2po?=
 =?utf-8?B?K2lRNG15aVBOMGRNR1dRZG5yQXJFcGdGS1ZWR0dZYzYzbi9aeCtDY0ROSFZV?=
 =?utf-8?B?a3dWWVowZUxsYVcvUVNyZkJ2b3JPR1B0T0FYSy9ibGYvZmtONVlBRGJXWUgw?=
 =?utf-8?Q?FHCnA04utYHy2ZDWnp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac379902-6e5d-4cbf-a81b-08dec6e75e71
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 11:56:56.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6sqBE9LslJrMwtxdcf+pJbjKiudkG6tlPK/AjDfEEfSORAMWFef0ShIAyJlGNoH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427

Hi Andy,

On 09/06/2026 18:39, Andy Shevchenko wrote:
> On Mon, Jun 08, 2026 at 07:37:59PM +0100, Salih Erim wrote:
>> Add an I2C transport driver for the Versal SysMon block. The SysMon
>> provides an I2C slave interface that allows an external master to
>> read voltage and temperature measurements through the same register
>> map used by the MMIO path.
>>
>> The I2C command frame is an 8-byte structure containing a 4-byte data
>> payload, a 2-byte register offset, and a 1-byte instruction field.
>> Read operations send the frame with a read instruction, then receive
>> a 4-byte response containing the register value.
>>
>> Events are not supported on the I2C path because there is no
>> interrupt line and the I2C regmap backend cannot be called from
>> atomic context.
> 
> ...
> 
>> +#include <linux/bits.h>
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
> 
> + types.h // uXX

Accepted. Needed for u8/u16/u32.

> 
>> +#include <linux/unaligned.h>
>> +
>> +#include "versal-sysmon.h"
> 
> ...
> 
>> +static int sysmon_i2c_probe(struct i2c_client *client)
>> +{
> 
>          struct device *dev = &client->dev;
> 
>> +     struct regmap *regmap;
>> +
>> +     regmap = devm_regmap_init(&client->dev, NULL, client,
>> +                               &sysmon_i2c_regmap_config);
> 
>          regmap = devm_regmap_init(dev, NULL, client, &sysmon_i2c_regmap_config);
> 
> (exactly 80 characters, so inside the limit).

Accepted.

Thanks,
Salih

> 
>> +     if (IS_ERR(regmap))
>> +             return PTR_ERR(regmap);
>> +
>> +     /* I2C has no IRQ connection; events are not supported */
>> +     return sysmon_core_probe(&client->dev, regmap);
>> +}
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

