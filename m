Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FD93905F0;
	Tue, 12 May 2026 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595527; cv=fail; b=pugw59TXQdtW9jby1QSPfMKe1xCZdF/jcjpuuKbksxVfmoQ1IEjrXci42lRALu71XDvk3RA9u3x6dBxbwMjBZ1nTER097o+fJorcAe37RkiZ2Gld3RD9s/RsYw/7w2zZyKQ5NT+l2xFXIu9zjKHOqM+xhiK9+IvHd2fRX4em6yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595527; c=relaxed/simple;
	bh=gwXVwZxmi23cTS6YwwtFs5jWZWfJxy+DoWnbpET6Bmg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H26l7XmIFLSBCNQ8mXlThAF4819gDWYFgy1el1caDl9e7elwirNLC9c18KfVYh9jQ1chexRJAnb2qhDdKzH1qLMkc8AFXlNJFwrQmWMcMlcPBjwINAi4RC3lZai3osfixcTkhPLegGMQvpDV83f0/O+z+gxa9Yk6LDkybrth/aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=suzaAISG; arc=fail smtp.client-ip=40.107.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="suzaAISG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPxghKCrDEDJ9tQsU6SqpM6FnUTqluUs0EXOezceTWwgkqBq951zKO7UukoPkH8Nb4Hsoc1wJ0eeOqji15auqyz9FY0NUzuRI/29/7HVnhh6OIaPevrKpcmeRBNgjQep4HfBf4mhPFyNY2VdrHgyob2frb598XXQiOI2sNL6kVLCFBcvBZkk9Pbl3EoEfBw7AGoJvXkTpGmJVFRVr7PygNvkzKWfzOGcu7WTiXt94dcU4/lcEEWFlEu2vulx9fGcjdiq+7UdYsByGXhgfMI2S2uJDM+6ANXeocsChULmhxlSjY84jJPUlx/+S1MY1KjgDR6upTKcJcGc+sExFOku2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5mrlUS4DoMF5wuEH/J0vX9pXShFce7b6olpfb10kwE=;
 b=YvtrxzEBTbDfCTvUzcEU/HBHHzxb/m1H1Se+iHnQg7QH+T34ubqsZQGVttFZAKh/6gyIqAMtVdk6dTGyzrH6XODSveVFMnQ2XvpGa8A1aczukAV7O36MC7ADL+ksl/k8SVEj8jCO03t8lMzShkqPc65kHmv0P3JhCv3/46UvD5JTvyggAFI4R0W/DBf8K+VnxQcqFtOGX5Km4KHD6YI4SrF+Kg4i3L0c8zi9mKhuTT/o1RHHfaatHfsvrxcTQhjH01pgf0EWTpNQ6MLXbA04sd88ku8LoNPId+xC3etzu9UcXbMJ3I5D3TF8+vftT+vCn7/oRQj/YFg762iZOW6Wvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5mrlUS4DoMF5wuEH/J0vX9pXShFce7b6olpfb10kwE=;
 b=suzaAISGemawamJBwa/KH8hjSI4ppoaOLFJVpGy7opqWZkzQSb77iW7/hrT3FN/m/06R0ibyRm447+w8uOuKgX2M83bsRijpHiNpZmVlC/Dj1X7IMZWK2K/96lNWTF+RzaxVXu+LkIryxlos3uKSHZpyLIE+knFpG1tCpYrs54g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by SJ5PPFF62310189.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Tue, 12 May
 2026 14:18:42 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 14:18:41 +0000
Message-ID: <20d5fa24-5341-4e31-8895-614523fc9384@amd.com>
Date: Tue, 12 May 2026 15:18:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] iio: adc: xilinx-ams: refactor alarm handling to
 table-driven design
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>,
 Conall O'Griofa <conall.ogriofa@amd.com>, Jonathan Cameron
 <jic23@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260414224245.8493-1-guilherme.bozi@usp.br>
Content-Language: en-US
From: Salih Erim <salih.erim@amd.com>
In-Reply-To: <20260414224245.8493-1-guilherme.bozi@usp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::8) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|SJ5PPFF62310189:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a56af9-204f-482a-7eb5-08deb0315e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	e7nVPel6cmsrZV6vkiC/DFjQ4NF+3VB24kNfBgum1FnEVALujwyvRKDg1J0/AJ+55o4F0YRI+v35JrHE53zqRnvAwEtZH5WuoAyvvObqQXq9J9pr264AU+kyL2t+crRa/q+JGub7DKO8B2m1XZephn1LfYWhRVanZUDUSf4v4slYDN5IV25aLR8wx9tEgIsQnnlNQdFedY0Sy+pzZDhqnNxn+4XpeKXKyi03Kzqp4aWc/Se40X/are0jPpZE71dURpzegVUYmqxYlo7tazmUIV4GNVxtcsbFXRvagGHKPekly92Pg00jl10UykCqqO8tcgnWYpV/S5sL1+E6hkaqY0rvx2EM8L04gUaXYZo+7NGjVin5AvoxU9H7hyoB5vqKiHmv2BHpUPozpd42z4CBhv6rA7MtOKc9TSRtAhSdCLQWeG0W/uXzO943FoDtEnqpmyvQeVs5PwrftCzbSIlPSJ6zKPGFa/SjUn/Zj2kgq9FiLRQ0+v/GYp47UootZ57fOMDud2aWIG4wNHzU8JZt1R7ANHxSZpt90bny1MbQ9zeuY1+PeT9PFRztSInJ6Dxmb3OSDDVlCbxX14fCckUAUzg1jtJwcQUkwEuIoFdKLaMeoMQVHN6IIQ9vuHDZ3qQ3aAYX5dce47G9VOoYsGtB/ecmnu/SgA5B5FP7FGV4CUn7MjnMICVq4jtdBjpfNRrr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTFiR25pZDk2TnRMOFJrSUxkUERkcTVWdWxycUJiY0RWNHRTRFdwN1Rwc3Nr?=
 =?utf-8?B?Tys1WDR4bjR0eUlFckFIRkpaUHB5YWYwdlN1T1B2aG5SSlFvbW5rU255cDAw?=
 =?utf-8?B?SmpCUXZwaVM0Z1E1R09zOGMyNzJGa3FCcWpPeEFFSERDZnpWQThkWGFmMmlu?=
 =?utf-8?B?Szc4OFY4VEp1eXd3MHhzaVBsV1lpNzZoOTBsVFhhT1V6cUMzeTFxMWl3MGdP?=
 =?utf-8?B?R0laRHdUQ0o1bDBMSFhrOWZJcS9qMzlUeUZkdStZcVJoQjVCa0pudXNXSjRp?=
 =?utf-8?B?QkJtSTlzdmpnN3VpcTNINXhURG1LUldJUmdubmVpQXJDWGVQNUR0K2RNUUEw?=
 =?utf-8?B?UUZ6VjlZd2ZpR3dpbnZHaTFibjVKYWxJeTViaFZjU0Z5Yk14bHJaQ2dMTlBs?=
 =?utf-8?B?UGFGWUkrNUErZ1ZxcDBoMWluMUdyOUdNcEMxazZ1SGNmbm5EdE5XSU1VNTNC?=
 =?utf-8?B?UVIwSWttRFNzTWx3R0xhK1FsT2NGYzFFUzZ5LzhNemo5eG96d2F1UXdhd3A5?=
 =?utf-8?B?Wk1wREErcTZhY25tSWJ6bklQQUV1bUphK0JBVEZlSDdTNkNLVXBsTmJjVDNQ?=
 =?utf-8?B?aWhSYXZycHRwcnV2UTljZlJzQ3h0allKajFFVGlCU0xObzZ0R0RkT2dYMG5w?=
 =?utf-8?B?TjMvMU5sV1pEMVB0blJFQ1ZXZ3FiRFRZeFdWREU1bTZoaVNWSWhKYWxEVDhp?=
 =?utf-8?B?Z0RCby9SZDZPUnhlcUtuTkhzeXc2ei9GUjY4VzJPSGxnWU1yZUcvYnBNSXJY?=
 =?utf-8?B?Nmlaajd2WkhtVUlwNzVzK2hGYkxBdm1TVWpLVkVvTklFZGlnYlVhbjZpOUQw?=
 =?utf-8?B?VzB1OEErRmQ2YmdvSTFUQnRpUmJnUUViSXM1NDhaTXlYMGpDV1JXZzJyeThx?=
 =?utf-8?B?Mmx3eG1CbXF3S1RMN0p6WHhFUTU0QlhkL2Q5bGdKRHpmQnlPYzl4RER5VHgz?=
 =?utf-8?B?TU1uNE5FVE5weFNQRkVRemR0SUZYU0N0ZHBvL1hSMG9jb1NIcUNBZXladWc0?=
 =?utf-8?B?Y1RGdWlVcUFUYlVXSFI4UFdxR2JEeWMzdmlERjltTmVYSDMvTkxISVlmYmRw?=
 =?utf-8?B?MlU1M1NINHZUVWJMSUhBbTB2cnBlVjRua2QvaEMxeXN0US9HNGMrVFZzUlVT?=
 =?utf-8?B?cHRaOTR3NW9SSyt3M2NaQmVFUW5rMWlqY3hFdTBUeFEwWnBCelVtV05RRjI2?=
 =?utf-8?B?OGI5bnpUdW9MelFrNkxqRUNhdmlvcEJ3OWcrMGhJUGU1OWdpbmJOaEZWQmVW?=
 =?utf-8?B?SUkrNjVTMFFPcmJqQnEzUkZIVkNpSEM1K0tneTlZcGFOd21tYVlKLzFmekNa?=
 =?utf-8?B?SW5VS1V6bEw0ODloK1NSWUhsWkREdWwzNEV2dE5UdjNVVHkyZXRjd2RYdmxS?=
 =?utf-8?B?RFhFUUxwbmdidmZmdDY5TFZlSXNXdUlRK3o1THRON0xTU3VhbFFCZlViSVF3?=
 =?utf-8?B?c2toVnNoMnZGcU45bjBQN1c1dk9lYzZPZkxtcWdCMlBXY2pETlMwSTdkOHV2?=
 =?utf-8?B?c2NyMEhIb3c4OHQ0TGU4VVBRa3VLcE5OT0RWWHBPTkd2NmV6dHhhSW5qalg1?=
 =?utf-8?B?d3ZLMW4xUlhncjYvNDNablVrc0NOaGFtUWdEbEc0ZkRkSkVMQkt2NTJWV1FE?=
 =?utf-8?B?czFXNm5nRmpqY2xoRmorUFlkcHNBWVVXZmR2RGtjTUJEOGZPTUplYjZNOVhS?=
 =?utf-8?B?VEk3NW9mTUVOUFZVSEo0YU1aa2ZFU09VRWJZR0pQVWlTV2FtaXB0d05aa213?=
 =?utf-8?B?MVFrNjRMQ0hWVGs0aXloT1hud1czRXBFNitabWJJTHNTTEo5MzFzUExhMnlu?=
 =?utf-8?B?WE5RMlNWNitMVXAvK1A4cjJLMnNXMUt2U2tuTklsWWdRanR6a2lZbmxUMXg4?=
 =?utf-8?B?Q0ZJZTFoZ1ZIYjZOaFlqMlVxNEJTcHdiMFhMWEpPK2RLcXlwNUJqUlk5Q1Vh?=
 =?utf-8?B?WW10Z3M1TmZVMFQ0ckVKaUQwazdKeXF1REMrQ1RvZ0VpYUtlbVdhSmxPYlFk?=
 =?utf-8?B?ZjUvangrUHhTOFhBOG5HajBxZDlKMjNyWWxaTlRlTEgvVkZIaU5hM2JuNVZB?=
 =?utf-8?B?TUNLY3loZmZRRlRDeG84OHEvazBuQjkyV29GYngweHA1enFKeVJCYytmNmdi?=
 =?utf-8?B?UUlKVTg1SVYreEwybURDQ2p4RVJqTmtWOWdoaVJQaXRmQUJURENGb3JaTHVQ?=
 =?utf-8?B?Mk5DT2cyeGFyc2hHNmlRanJaRDQxWFNCZkxJU0JGSVVVa21PMU54Z3dETjRI?=
 =?utf-8?B?L3V6L20zR1E3bkRnVWdpck5sZHhjT3BQcXAxZk95ZkZNdEk2UklDUXZDRVY5?=
 =?utf-8?Q?vc3480g+C2y3XpxcxL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a56af9-204f-482a-7eb5-08deb0315e19
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:18:41.5499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7hIv+CujpOrJpuvwCbQridwoP9Ml4T0EVZ4t8Alrx2/BZGJ3o1kuLlBpiPl2qBJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF62310189

Hi Guilherme,

Thanks for working on this. The refactoring approach looks good overall,
but all three patches have indentation issues and patch 3 has one
semantic issue. Please see my comments on each patch.

On 4/14/2026 11:40 PM, Guilherme Ivo Bozi wrote:
> This series addresses significant code duplication in alarm handling
> logic across the Xilinx AMS IIO driver.
> 
> To address this, the series introduces a centralized table-driven
> mapping (alarm_map) that replaces multiple switch statements spread
> across the driver.
> 
> This improves:
> - maintainability (single source of truth for mappings)
> - readability (removes repeated switch logic)
> - extensibility (new alarms require only table updates)
> 
> No functional changes are intended.
> 
> Series overview:
> - Patch 1: fix out-of-bounds channel lookup
> - Patch 2: convert mutex handling to guard(mutex)
> - Patch 3: introduce table-driven alarm mapping
> 
> v1 -> v2:
> - Fixed Fixes tag format
> - Replaced AMS_ALARM_INVALID with AMS_ALARM_NONE
> - Changed alarm_map base_offset type
> 
> v2 -> v3:
> - Replace 'i >= num_channels' with 'i == num_channels'
> - Add missing trailing comma in alarm_map array initializer
> 
> Guilherme Ivo Bozi (3):
>    iio: adc: xilinx-ams: fix out-of-bounds channel lookup in event
>      handling
>    iio: adc: xilinx-ams: use guard(mutex) for automatic locking
>    iio: adc: xilinx-ams: refactor alarm mapping to table-driven approach
> 
>   drivers/iio/adc/xilinx-ams.c | 190 +++++++++++++----------------------
>   1 file changed, 71 insertions(+), 119 deletions(-)
> 
> --
> 2.47.3
> 

Salih

