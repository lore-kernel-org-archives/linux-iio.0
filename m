Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792645561;
	b=1gZ7T+POSzhwZ4671iBA5tSGEv2jIu0pYIVfJbp+yiILggf0ITAiypA8Ua9axljPJQC1
	 6fNVg5L3buCPioQ8KPb+fx2da6WhrCcCkAUPQMbD0mkRrO5CobNZv7Z1a7NOQvIlkv7gH
	 iPdyUYgSh6qS/LQxYc/TAEvdkA9P3gpgT4Kkwha6XMNK/uxVtPbBvegGirRAQbQoL2BQE
	 Pg7umNq9JwYN5YDoZDpm3Zct/k96ierPPjjJlOs5dnXLhsF7rUK9JATg42ANQSFugs9X3
	 R59/kNCJn5Rt/aR/mBc9a9JOHd0UVYf2DSbd26Ky97+ERVpnACgYMwVial3BC5hJfIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645561;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=LKu2Bd1j3pB3RxaUq4wlhFKCN3SSegoMZruWuarvMBE=;
	b=OE4hJVeh6dv4LYwbdiRFaArcyEBfwg+qOrwz4igTpfyJfNhFAqL/xo8o9vvSDSJ0WetZ
	 sQrSVlAS7oxS7MVuqY5d6UV8ehOT1rsd9Va7xclY/yGlffGWFel+xDdZh3e5BP7TsiD8N
	 e4u3eKqw4nvZP76nubfK68KadDNtBzjl8EvqPbz+h3rl73Vd7vqPg7Eu601XJcGtGF/TV
	 60p+XaPcJ1Uf26HsTyE3z9e3lSvZUbop9hxkuKV24yBm2aXGUJxGJ5eimGEi7hJ1X9W8V
	 4o3VhpeuHjovMTbYvnHkmHn8g16AAXOPtpGSn0B+buDYWkZlDvzrZE2CjuzVr3P/n1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eIb5eX7I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.12
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003AB606A31A;
	Thu, 22 Oct 2026 05:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 003AB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eIb5eX7I
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjISaySKzjDysTbrlzT24jbUGwYo51w7OwiVX/4a5SZWFT4aWMwrbJaUDvlL6HDqOGdY2zFV6+Lsv2M6PwACCbHSNoA0D/VdZFDhCeP8W1/YNDkG4ae1Ywp1CK4vU05hK0yvqB5ml/SBwUSRMrPn5d+Xr2Ie8NnzdYtCPqfyZUuVImFb6DCzHuEPstDz5WYl/bff8aiYC72ifXeYzYw8UJYvcx185PI0EoCGMLBHkmgsULYeFi7ZDuSFOyuU4Yt7syCY6ZeRyzeDBMsFU2WinSvpqu5McIC7bg0eXXme+PCg6Mtw5X/AB1w1dcyR3IR0Sn9vP/bjjo6ZNE55l1Ic7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKu2Bd1j3pB3RxaUq4wlhFKCN3SSegoMZruWuarvMBE=;
 b=qHlhk6S7aMb7EWrSE2GgwAIWzMuqAr6dlD9YLIvkY2w3m6iH7h5YaIdUz4bUPjQxQV9NBMzD7D9nmMlfT6XNYdnqfker9Kx7vxDuCIsQNjk1E5d5Ji6LXV810SPc7n5/diBOzJWo/V5ZE+eyU7UilR0tVitb6SYl5W3UUUqPUEmLHoG4ZsTMNOuUyPpw2FfYApdZzhYf/H0J6rR9VxVvtsBEjsqGtmrKqY6bzny9bWiVmODzsWEhreYpITIEKxs8UYi3iY44W1+9t3cQsPbuxAD7sUaulPWzEfh//SjBjZ7BUQ7uUmiI2tfolcz8Uv1I+SdbxEO4Uv7SejJhu9SBUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKu2Bd1j3pB3RxaUq4wlhFKCN3SSegoMZruWuarvMBE=;
 b=eIb5eX7IfMAtTQ7ExX6+sMTTD5LXnHRuW3N+SQUzN5k+OVirymPPG6By3wuYajQYRt3mDZvK71ZgqK5cCjnbJW5rtghpTYrKtd5S/7lYXcyzvYANVSON41WYyfyOw4WVzr1tIoe0/u7pKYxr9mwb5MC7sxUdFUxBlPVZDHMxJoc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20)
 by LVUPR12MB999185.namprd12.prod.outlook.com (2603:10b6:408:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 05:05:56 +0000
Received: from DS2PR12MB9568.namprd12.prod.outlook.com
 ([fe80::d13e:ae33:dff:b2]) by DS2PR12MB9568.namprd12.prod.outlook.com
 ([fe80::d13e:ae33:dff:b2%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 05:05:56 +0000
Message-ID: <b01a603b-5e9f-4fb2-955d-48efb57d3f0b@amd.com>
Date: Thu, 22 Oct 2026 10:35:48 +0530
User-Agent: Mozilla Thunderbird
From: "Nagavarapu, Dileep Kumar" <dnagavar@amd.com>
Subject: Re: [PATCH v4 04/15] iio: adc: xilinx-xadc: Drop unnecessary masking
 and dead code
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Conall O'Griofa
 <conall.ogriofa@amd.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
 <20261005094205.1045874-5-dileepkumar.nagavarapu@amd.com>
 <20261019000523.1d43a8d1@jic23-hlaptop>
Content-Language: en-US
In-Reply-To: <20261019000523.1d43a8d1@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::7) To DS2PR12MB9568.namprd12.prod.outlook.com
 (2603:10b6:8:27c::20)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9568:EE_|LVUPR12MB999185:EE_
X-MS-Office365-Filtering-Correlation-Id: b5be0e7e-0909-47e2-05b6-08df2ffa273b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|18002099003|22082099003|4143699003|5023799004|11063799006|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QYvbhftVCuRKAMwKHgMVtjhu4zV/3oWiR30JFk8e8EvZJ2pZT/i7HC037mWYW9LggDDR+0e5UtZAUrVM5JtaYMJvp+B87De5CJIwBMfvUUQQN0qsvcRrjl+sclnbJbe4qRns4RUK1SXuLY7poEmCM0+fy4BoHhpmVGdjvb2sx8lNj1pTSsXANqBVBZSwlBzEJ7adaVJSH7PI00Kx9M374SK8N2NQbprBBb5KG/zlLnFA5d0TBtiE4tzHtcq+0CMhWnTAhk45svM59obLPC9VtNzddIFlIPWjLWJZsSX0pQbNz52dLzkNDpwzhjGhxEcaUpkpWOarSH124nkhJpYwU6P3sAWf8cdrOR7afDIK0pfUVwYV6D90qx49t4X/xwNX/3wd8ynw+BiJWadj3JBeGhiHtdZql6ta6VoGJhaxr27UFfBPSGADW0uyqaUfDJXljnlKCbGEH5cJRN9yc4D2BJ+e1hDgIdPee6KRcZ6/4hpgj4J1z6qCetJW3IcPSrOkEn4tP/kQg3sf/g2inU7/QQy9TBakiGFXTU6zPV117m0FVywVNjuc+17ooeBuWTvxpWOxWYWCuERzjukNHWD1y/hmruSVhzwraUGu9bDbX0RrC52ObJ5iNzxQGxqv1q8SG2ipMMKlvDLiv1w0BSFWf0mpi7VpTSuUtzYURc9g7ps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9568.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVY5R0pvejhkT0FlQnZiaE1TZmpOMklyWHhyTFRkMTNFcWUvNldva3N5U1BO?=
 =?utf-8?B?ajBuMEd4S1puV2N1bWoyaHFEbE5pejZGT3lUSXZDcFkyOW54eGZVRm5WQUsy?=
 =?utf-8?B?cWhUVW03SDYvakRnamJXZEdCb2hmNUZXM2x5dzd1NG9CcUxYSEFsc2ZmZFU5?=
 =?utf-8?B?T0kySEVsWFplTHJYSWxQMDZrZ0pISkhxdDBqdnFyWjVDSjhobWZYZUZJbGhQ?=
 =?utf-8?B?aVlIQVpVZnVrUTlxaitvTEZ4ZFo3eGhudWR5S3ZlVEd4dVc5aWVtajNMM3JV?=
 =?utf-8?B?YXBYLzk0Y0dhTDIybG1LSVhmUkN1NHZ4VXRLZmJ5eFF5K0NVaUphWGkyQWpu?=
 =?utf-8?B?L2o1T21XbFQ4VVFmYlQ0UlBiWGhUMHUvNlNOTHNDUWp5d2lMT1U1NDVHK2N3?=
 =?utf-8?B?bm9qRGhGMjZQbms4dW1MTW5hYUdkb2c3NkdJME45OGlTUmNtcWFxRkVXNXA4?=
 =?utf-8?B?OHo3b2h0cisvVDY4Nk1IZ0dLdVJxcm5xZGpha1RaVUt2UnVHNlE2ajdlOEZU?=
 =?utf-8?B?QTBiMFJ4L2Y3anZmZlpHVXo0VXpKUDN4MGF3QjVOVVVCdnZ3SUFMKzd2ZExH?=
 =?utf-8?B?V2dUR0Y3UFBEUEZERGh1SG0xRG9HNnRhMnpuWVVVajJHV2ZTVE9aeXE0b3RT?=
 =?utf-8?B?WUI4OFJ1bkhRSmVYNUZHUjFuaGYzeSt3aW4vN1hPZHF0NVlMQitBV3FlSGo1?=
 =?utf-8?B?eDVGcm9kNzZjS3lXRXFFY3p2ZW56RHV4R2FRUmJYeXNHUEcvL3E2ZjJFc01v?=
 =?utf-8?B?SmZ5Q3Q1RzV4TnZnbFkvTHZtbU94LzhVR3NJZ1R1SWpDTEphUGE1VWZIamM3?=
 =?utf-8?B?ZWtPVkFCbm5ScnowOTJvdGpkandOS1pSWUNzUGh2MUhjSWR4T1RmSHBKUnpP?=
 =?utf-8?B?eTczdkZVTm5vZUQ4QUpjd1NvbFc0MDRiU1ViT2Jzb2tRTFJPekR2SkdpakFh?=
 =?utf-8?B?OSs0SXVqcG1SbmZ4UC9uWWRzOVlBV2xFSzdMRWlWSStma3NZeDBSay9aSDVP?=
 =?utf-8?B?Mm9xTjFHRVdTam4rRjhEUEZURFRuZEJTcnh6Skl3eVBOOUNaY2JrOHRITUg5?=
 =?utf-8?B?dlA5U1IwUUdkWkRCRDNITEozc0tMYWxkbzV1Y2NIOHgwMC9uREo0akpKOHFa?=
 =?utf-8?B?VHZuODR6NmR3Y3NmcTJEcGRieFhCRFZNclN4ek9CN2Q5RDZkMHRUQ3BiKzA4?=
 =?utf-8?B?QS9TbWRETlZGQWh2TG5HUFBQT0NRNzhuSTZKc3Fia2M1bHpadUdRcS9Cajcy?=
 =?utf-8?B?VnZqSzMwaE5keUQ3K2RzRE1iNHVvMGI2R20vYklDOGdhaWdrNHhvUTQzblpn?=
 =?utf-8?B?KzFIcWEwR3ZEUFZwdE91U0l1dm1nOWdpM0dJOXlmYUNvOUd2eFJtUDl6Wjda?=
 =?utf-8?B?d1kxQThVcFRhbXNyZkVJU0ZhUkNCSVZVZVk2K1RjWTNnZEpmbjJZOEVZaEtE?=
 =?utf-8?B?YitXNlVVZTlyQ2ZCZmY1OFBEc1c0VmVjazVlelpUcDRGVGhMcGdTb3pFeHBV?=
 =?utf-8?B?YUk0SzlDWThBNGZPMDE0YW1IeXEwOTBDVUJuc25uQXFHTnFDYXJpNzlHVmV5?=
 =?utf-8?B?dWNUWFlwc2xSMDdicVUyLzRnTTE3VFV4d3FHbHpDSWxLWklXbjBEVTU5MlZx?=
 =?utf-8?B?MnU3djdFTjg3ekJkYUdNbCtmcnFmaWxhdTVnc1pleEl2K20waHlWWVZrdlQ4?=
 =?utf-8?B?YktITjRZLzVscm5pNE90NGJOY3J4dlphMnNwS20wS01nR21WcEVwQW5TaTB0?=
 =?utf-8?B?VkgzbC9CQy9ZUjQyU1BabVFyME9BOStuSnFSU29WcUxEaS9oS0FEc29OK0Yz?=
 =?utf-8?B?MFExdkg1dW5kaEZzT1QyaTMzWUl0V202Vi9zQ3hXeHJaMzN5VHFEaFJGTGFF?=
 =?utf-8?B?Sk1ZZURhOEpQQktUTGV2UXNpazVGUng5ZGExZkdFTmNWOS9pVmd6cTN3MXlt?=
 =?utf-8?B?UjdyY2cxS0ptSmI0K3FDekRCMXhWSnlCbmZWUlVKc2grVXVic0ZIUGY1UUJ1?=
 =?utf-8?B?UE5mMk1hbTJGak5UeTZBL3BBQXM0UWJqdnNtSVBpQnpBWVZwZFJ1ZEtxQVNR?=
 =?utf-8?B?dGFyVyszWjFIVlR4bzdFQk1Dbk1IMmp4WVd6NGszNVpZMlFnV243Y3pleDI5?=
 =?utf-8?B?NTRSYWFKZ1JXNncxWk9TZHFiZm51Q3M3LzNCMEw2N2RYd0hZZitHTzYxOWxR?=
 =?utf-8?B?aldMMit1eFNXaDdUb1NvOGdvOVhmODB3aUhjek53OTJTR2tYR0p3L3RleVNJ?=
 =?utf-8?B?VHFsM3RRa0hkdWp6cGJLS0VxNEhKT25tR09WQ1JYWXpMUjVuU29hVmJ0L0x1?=
 =?utf-8?B?RjlRT3o4RHdCUkhOTlZ4ZGduQng3bXFwTHBOQ3NuWko5U1dJRVhvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5be0e7e-0909-47e2-05b6-08df2ffa273b
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9568.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 05:05:55.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OW+QR3R5+YiqtXQLGD48KIB23m2vMxRHGqgzG7C/dS9qmSCI4onrXD2kK+0IvOdgRpwnIRp9yOhg9OLaTehKtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999185



On 10/19/2026 4:35 AM, Jonathan Cameron wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 

Hi Jonathan,

> 
> On Mon, 5 Oct 2026 15:11:54 +0530
> Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:
> 
>> Remove a no-operation bitwise-OR with zero (dead code) and the redundant
>> 16-bit masking when storing values into u16 destinations, where the
>> mask has no effect. Also remove the unused macros.
> 
> Hi Dileep,
> 
> Why?  If they are expressing the rest of the fields in a register
> simply knowing there is stuff there an be useful even if not
> explicitly used. There are three approaches I tend to accept to
> such defines.

Thanks for the review. I removed these macros as they are currently 
unused by the driver.

I agree that they are useful for documenting the relevant register 
fields, so I’ll retain them.
> 
> 1) Comprehensive.  Sometimes it is just easier to define anything -
>     particularly if codegen involved.
> 2) Comprehensive for a subset of registers + nothing for the contents
>     of other registers - fits the above definition of useful by defining
>     what the bits we are leaving alone do.
> 3) Exactly what is used.  I actually don't particularly like this and
>     prefer option (2) but I don't tend to consider it a reason to not
>     merge a driver.
> 
> Now, if the stuff you are dropping is inconsistent across IPs or similar
> then that is fine, but say so here.
> 
> Jonathan
> 
> 
>>
>> No functional change intended.
>>
>> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> 

Thanks,
Dileep

