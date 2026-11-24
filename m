Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795539313;
	b=KE9oIpDWyO8AB9qphFk2M48EFkpl166WDrmDXBT3Pg/7W36SgcEtGU0+PKI0lr16BwSB
	 3k4dRWj/ImcvcxKCWD6epbHRcP456hAEjREoOq+K2jN1iDjRqVtwqgM0dbC2+EDfWVM9n
	 9Zig7RhNBYF1c/Od51vy6Wmkt0ianrhkJQD4T2mZp/p3M1Wx564GrN05RbF5CwX/PPXqu
	 0BjZfVC8lRx39MnGBN9aPQYiiY+Cd5V3qOPT2M4dQuEEfJu/IJr3X8Qm6YPLo9SzqO6jy
	 wesFv6vqchyWQf5tTHdm+KW0tqLVBY7C9lHz9gEQDX6EDVrVR42GshY9GZWPHjx/Znw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539313;
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
	bh=lWcttLjKGdCCJ6xgq0ctD1iWvbtlIYhf1zx+oCS2Q9w=;
	b=hc/Kgl5CvJg86ts1XdXPgB7g4a0UpDconVzcY6zcHCOn93MkFTFvLfoQwsLzjRJjYPGC
	 z9TG7+5Qjk+b3Z1nAuhntL3y1B+BWqoP7Bt/kQKe97L0ZpZktKOMnsEABF8+MdsG/IB+8
	 kxzt5LyJNKb4WlOTAaou+cr03iYBRb7ewnNoc3DLKLxmBqm49L/cV7i+3Sj+eTbaUpjQR
	 HDnoN4SCKTLHuRRrUXYh9JvvmxpQ4nnsG/oOr8jdmgzUVfvKlZa2XRU4AmwSqAYRW9X/t
	 urnGGjomrz8/WDSFbYt5TSobhiJeXxXqCOu0O0QlRXvt3fe+kD8PzTpLCfvkhMPfscg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PYiMLYh+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.19
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE1606A32C;
	Tue, 24 Nov 2026 16:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4BE1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PYiMLYh+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKkTvyYkNMV0ST8WpG+ObezxW6CnDdsZGg6odytCY42Dnrs1iNTtamWJGc84ofLx6VQAA1cIuJ+kqoIFK9GDr5MZCOHudATVKgYGzZcE0qE4ud1YrEb+9avhxtJIMjBaHKs/lj3bleG2TH8ufTdKDszdYy6tE2v+Xj/FlGO0kDSgeen1e4Xotf7c3kPbRW01739lSiVrwWx1RJuhjMqgLD+R4gvZZbX9nAObJRbC0mLBq3zu1Kl0heDuDg086jBhe1rTAU61/MA08fHA+iHdWdtPbF06uvpw2IsiEwMvuj2IcHLJrNyNLp/DxvjoVy1oUgUhhahUmVqkN3SxJbHsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWcttLjKGdCCJ6xgq0ctD1iWvbtlIYhf1zx+oCS2Q9w=;
 b=vpkdlmO/nZmOk4KXkBWlkL2sSI5Q5PP+g5gqe7NQxSkEMeEScj9GEvRFpsMbZb0PBbN643Rco54Ew6rxOfvjr01EZpHGWc4izr142NPNr04JIymFAEwNywv5H9/tRtvgf+nF8cLWV83V0aTvO/ooaRj9ItOOxP0k3AkuIR4w2bYhP0TMJdk5WG7uK+lswhDYCTEfJPg4Yizmm+EI+0Uqw3wkE9z6vWrloBIiNwhs5E5mdRG/wRVyRywa289O09Y/B0iO/GWoE1STvfDu3YGsSpldDIHacsP65km/uvEZ0PO5bzPrGmdknlQ9sxnAXhRFUCOqWwdv7M3JM2ZPXlKmyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWcttLjKGdCCJ6xgq0ctD1iWvbtlIYhf1zx+oCS2Q9w=;
 b=PYiMLYh+3r/caSunYiwjx15A+iKI017yAPdfjf/M0CH+TcTbRqWi6LNtYWPspIZtJPCO3SUuLmgR9P/A2+mW4gJj94rMocKOWjKV8a9B1WDVkU9IfMwSlUhOjE55Ok2FOm4IH52AGmYRYApi0oNGbv9xFZbAhIByaIIcUvc+FvY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9559.namprd12.prod.outlook.com (2603:10b6:930:fd::14)
 by CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 16:55:07 +0000
Received: from CY1PR12MB9559.namprd12.prod.outlook.com
 ([fe80::1761:23a3:6ab5:fbb8]) by CY1PR12MB9559.namprd12.prod.outlook.com
 ([fe80::1761:23a3:6ab5:fbb8%7]) with mapi id 15.21.0639.010; Tue, 24 Nov 2026
 16:55:07 +0000
Message-ID: <c3a7df9c-e337-47ac-9a6d-6bb81177affa@amd.com>
Date: Tue, 24 Nov 2026 22:24:59 +0530
User-Agent: Mozilla Thunderbird
From: "Nagavarapu, Dileep Kumar" <dnagavar@amd.com>
Subject: Re: [PATCH v5 12/16] iio: adc: xilinx-xadc: Refine Zynq read/write
 error handling on timeout/interrupt
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Conall O'Griofa <conall.ogriofa@amd.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
 <20261110050201.1850399-13-dileepkumar.nagavarapu@amd.com>
 <avNEpH6KGJkeI7dX@ashevche-desk.local>
Content-Language: en-US
In-Reply-To: <avNEpH6KGJkeI7dX@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::10) To CY1PR12MB9559.namprd12.prod.outlook.com
 (2603:10b6:930:fd::14)
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
X-MS-TrafficTypeDiagnostic: CY1PR12MB9559:EE_|CY1PR12MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: 8941f3d0-2501-42b7-c484-08df4a4bb16c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|4143699003|261022105027099003|261026140227099003|11063799006|56012099006|261021121427099003|10067099003|261102123227099003|261009223027099003|261028144727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QqKNfV/4pMYe56537dtogGhirx9ci+EEQKxJUmPXnrJu2rdu3aHWNGMe1vOkVJ+0YA6qLfW23Zq4hTiprW0Syapdf+c7S59auUzB/qVai6KYdSRIftqORXPKOxm06kF37LavKVl6oeMm8F0YX7s/Ae8s5+i5ljHfchWPdbxhnnwBf92FqJaHOmdyqeqJwl7umX6HWnUZ8WfkuOPI5GtWZ6yWOxhK/l2cj9Eg1teFbPTFZfhebdzk1TiDVBhohf27l1+fLqTTO35vLveeUO7fWwF3uYYbMrchIx3CqUiPSE553yaDoEswLw9/qIaM2VJo/HVOnctwQ1gYo6MwOL2zSc3PDwicKjNFG/4WPkYhk0IkkltclK9I6q6n6q52FFG7aUzZAfyazh21CgEEcl6McrQqgBNk0yKy6mz5ohsb3bXIZitOmQpPdebb0j+BINAk/pbCdky2Ovyxs3EUtjIk3wX5be8GtzrBfCjZzE+8YJM0EXIM3IG9I3Zm+UOQjwjPwJVcIXiaptNFje1JcmGligpfRyMhgRMOxAUjrus7eohnJ4F7Lb+kIktBwFgI4U2WP8RKgPzFqO4eM9kypXY0ahrCU044J8ACMrYkIyvdLMshwOTJRBxnYbWqm1uevjciPWSQqIaRrmISrXgwuqebk3v4h5rQWZD2y/agyleu4nY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(261022105027099003)(261026140227099003)(11063799006)(56012099006)(261021121427099003)(10067099003)(261102123227099003)(261009223027099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amx5TUY0UmpwdUR6dHE2YWxlYzlqbFlYTDdIeVVNL21xKzNpajVUSXFLOFdl?=
 =?utf-8?B?bUVsejQzSWMwUkYzb09vU3BGdzJ6MTVoUHZtVEJtRVVFT09ydFoyWkNuMlVs?=
 =?utf-8?B?NnVQL000UmVURVozc3ZocUljbG5kOHNjYlFmeUoxQVVndkdrSzhxTGh1T1A4?=
 =?utf-8?B?UUh5VXByalkrbVBUS2ZybHliKzcyVGlaMWkrZysxOVc4UUpHSGdzZlNMYlVI?=
 =?utf-8?B?NDlhQ0RvQ3lhSnFUOWprSGxPZDRreitmc1ZmSzNTdWJja0FLbUQvL1kyT21I?=
 =?utf-8?B?RUpjNXdBbHZOSWFxRVhZUWdNM1hHZko1QVlTWTlvZlBVMXgyUjZYempJcXNw?=
 =?utf-8?B?dWpNdytBa0VscHJSakxVUzlqaGJWT0Z3MDJuaTQvWkdqZDRnOTFuR2Y3eGFO?=
 =?utf-8?B?VjY5UENYdGlidmtIWkJoWEV5ZkdoSDVaUmpZRmN2cTNXcjBWQmhjRkw4bFhU?=
 =?utf-8?B?YkpKZGNmQzNuWlowWFpiOUhLakFheTJyMHBOTXo3M0ZlY0tnOFQ0UEZqM0Vn?=
 =?utf-8?B?MGdPVnVZOU4zcXQ4TW5hVHN2c2pkMStwUVZ2b210d3RvT1FzcVRiRCtzVU5I?=
 =?utf-8?B?RXl1MmdkMmxkd1lQVFY5SnpnRVV0Y09Ib2gyZWZTZTVHc3NIWDNtQXJuT056?=
 =?utf-8?B?aFQ5NXIyWU5GOUVnU3hwSDhFempOYXMwajZOYk9ZeFF6Rnk3aVYyR0N0WkhE?=
 =?utf-8?B?T0hhWTVNSm0rUFVzM3F1c0dqS1JRK3JVVjhyWFB0dlFETU9NcG84SkpmdXFU?=
 =?utf-8?B?VW12MmoyKzFJSW5MVVhEcXdPSEtZVm9PRUF1RHdnY2RhUkZyWWhyQlRpWEhC?=
 =?utf-8?B?YjF2Z1RoU01ueENHNlUyMVhKbmJGYjNrRGp1VUV6WXkwS1hZQm4rQ0ZoMURJ?=
 =?utf-8?B?UU5LOFRHSUltQnB4QjRhSG93UXg0VnN6VUJhUVV5Y1lQajVUSFNjajJHNlFW?=
 =?utf-8?B?Y2hlaWl3dkV5b1cwZnNYbFJzaWsxYUlPaHdSM01qWTRGVVBLQnNRZ2RaaTVq?=
 =?utf-8?B?NDZpZFhGNEFPMS9XcFJ1L0dPZk9XczVDazJaWEV0ZGxmQ0pZajZLVVE3Z2Rv?=
 =?utf-8?B?NnlZUkxUQUM0bnY5YTFnbkRFQVZ3cVlhWjltL3JQdzJTaEQ2UXBjd3Rwd2tx?=
 =?utf-8?B?NEZIWjNFRHV0TjFNdytRRXU2dS93Sk9sRVVCSGFjQVJBS0dCK2Z5bHp2OVNa?=
 =?utf-8?B?aVJUaVR0SUZCQ2xHM2ttN2Y1Qm9hd0ZYbmk3VU1tWTNGSUpLVHI2Z3BjcExw?=
 =?utf-8?B?Y2p2TW9XcWsxS2YxdnlkZXdxdnJBeW5XZjVRUXB6cUdFZXJNeEwrR0N3b0hq?=
 =?utf-8?B?Z0dDVk0rVWtnMzBLUG5iT2V0VnBlNXpuRWdZcDVLM0VPbGlZUm1RQjFERmhv?=
 =?utf-8?B?cDUraUFvQXk4Z2t2ekorcWRlM3M5aXlWV2JpUGtHSnBaU2xNODNkQW9HWHNT?=
 =?utf-8?B?TFIyMndjSWxhNzU0azFWbUZESDcvSFhnWnROY1hESjFLZTVhU3VhbEhGa241?=
 =?utf-8?B?M3l4WWZiaHhYcElpUlRTQ1JIcWJqN3pQd1lpejJMTVNLeHk3K1BCN2gzYnBG?=
 =?utf-8?B?RmovVnhFRUpTZ09adXdqVTIyTlV0d1ZwdndDTUFVZGtiaW94bGFZQjN6SUtH?=
 =?utf-8?B?ZFdLZXRQclM1TVFRMmszLzhaRXB6eUJYYS9kdWhlN1duVnFPODBVbitENS9p?=
 =?utf-8?B?dDVGeG9ROWJTR09VUkRCUzZFWi9FUzRzR2gwZ2prbXFZNno2ZWxWa1lqQ0dD?=
 =?utf-8?B?aTJScm9PdUYvb1hMT05OY2tTS20xdUYwM3pORGZuVUpnRlBjcEJXMHN6bm4v?=
 =?utf-8?B?RlZNaUFmck1lVXpNZGczQk1GbFlhZFNLZ3A4RXVrb2Q3eTdPTjJqZ0RmUzFQ?=
 =?utf-8?B?ZWRvaEt4WVBGaFB5K1lmRUF2cmhLaE9GN0k1SlEzTDNvWGFMZndzL3hwVDY5?=
 =?utf-8?B?bEhkeTNNOTZBQzd2ek9hekwwRE1Cd3hJS0wyem53RW93NStrNXptY0NqUzdu?=
 =?utf-8?B?U2Nha0V1YlRQN1VUdDlsUUR1MkJlSi9ibXBYZ2pER0RsRHhGaW8rRWJoS1VW?=
 =?utf-8?B?QUc4S0FCdnVwTUY1b0RwcFZ3cjFOV1NCdGpkRHBjRHhvbVhwU0pTdXI1d0lK?=
 =?utf-8?B?Zk8zUnY0cDNuMDF5a2FXZnZPanZBcXBmcDhBQU41UWo1ME0zdFZkUjRHTzdh?=
 =?utf-8?B?Rm5jNnlCWk5ESmFDL1RvMW5vL2MvNmNkQWppMFRVTnlPa2F4OFdtTjVqQThE?=
 =?utf-8?B?Q2ZxNUZ2RVU1N0U5YXkwbXA0Y2ZXRmtHOEtmWmJyZTNLWW5qWDBEUjRlNXJQ?=
 =?utf-8?Q?UqUHXxZFJIETxD9fFY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8941f3d0-2501-42b7-c484-08df4a4bb16c
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 16:55:07.3310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxtYZwKhx53v3Uo4JUqaczhJC82EbZFIOF+ZkMQm0qiLU8nKRNCzu4SjLttZUKGSVj7UU+YhT1zPgodmbkK/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626



On 11/10/2026 9:51 PM, Andy Shevchenko wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, Nov 10, 2026 at 10:31:57AM +0530, Dileep Kumar Nagavarapu wrote:
>> Refine the error codes returned from the wait, the same way in both
>> xadc_zynq_write_adc_reg() and xadc_zynq_read_adc_reg(): a timeout
>> (ret == 0) now returns -ETIMEDOUT instead of the previous -EIO,
>> giving a more precise errno for this condition. An interrupted wait
>> (ret < 0) now propagates that error to the caller instead of being
>> silently treated as success.
>>
>> xadc_zynq_write_adc_reg() waits on xadc->completion after issuing the
>> Zynq DRP write command, then drains the response word from
>> XADC_ZYNQ_REG_DFIFO. The DFIFO read already ran unconditionally after
>> the wait, regardless of outcome.
> 
> ...
> 
>>        ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
>> -     if (ret == 0)
>> -             ret = -EIO;
>> -     else
>> -             ret = 0;
>>
>>        xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
>>
>> -     return ret;
>> +     if (ret == 0)
>> +             return -ETIMEDOUT;
>> +
>> +     if (ret < 0)
>> +             return ret;
> 
> First check for generic errors, then for exclusive conditions ( == 0).
> 
>> +     return 0;
> 
> ...
> 
>>        ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
>>        if (ret == 0)
>> -             ret = -EIO;
>> +             return -ETIMEDOUT;
>> +
>>        if (ret < 0)
>>                return ret;
> 
> Ditto.
> 

This patch does not fix any behavioural issue; it only changes the
error codes. Sashiko suggested adding a Fixes tag. Is it OK to ignore
this comment, or do you have any other suggestions?

> --
> With Best Regards,
> Andy Shevchenko

