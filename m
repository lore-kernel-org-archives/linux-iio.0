Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62552848BE;
	Tue, 12 May 2026 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595913; cv=fail; b=SaRfZMrhn1gYUd7TzMIbSonYubBClIL5WWWCUncJXUT8aWIehHZuMmZaSPWsaG5gzM+acamfGTMUp+6l4rHfMGjONoqwDEnqdDfiacRID0xEb5ZujlfX0LIxSIlkn6gxG3Jn5orjl4+T7g0YGFz0mOiibFoV+MH/MuWP3XV+DyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595913; c=relaxed/simple;
	bh=0wsvA+Z9MedfiSpxGDh+LTXeTyjKodaezGDbgAbeF3c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e2Bc/5aT1c94BiAWjgvp93Kyfmx9yR57znqUf8+KzsxCgJd2gIsc7tt3YDppwOIMhf36qX0r4V1Ns460ppJkQKwasSULUWUy5zgmVmZAdLXr7tOO+uyP/GRDLtOSPzP3kquvlPslh8JLi0IGIoTEeCtPIbzqI8sJDaQSKhOrBL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2hEFa7Me; arc=fail smtp.client-ip=52.101.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2hEFa7Me"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maOC1ZdAhJLq9NizlmwB8h269MB2filRZaCGUgIpRE7FYjwPcJXCnorvCb20qks5lMmHyV7KkbV2aE8gTgEHx/kPAU0lk4eXZtuNiOohRxIg6ubRfKaViwsV+YxMhIAkqDi4ZfCeHR/3JsL6cQ6xk8I4ZwafYsxulOfhK3BYsXz00AlSDIgzywKTO6+GCuKi3YwPmeeTagusUaFcqinT9brLZ9jGGhVOwpvEBwdotPz4IC4ZUKkCmJzZ+pU+YQEaql6NZSH02ffJB3el0G7ZRex9z4DM+UuoyWgpXaf7YmGpOkwOQ9AMLM4IXXwyaarOEtSyQau0KOmJG4EUlTH92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nv/s3JGwdaVoEwZ6HeV6M3lLqapj0ZAu62VClmSSXw=;
 b=wqlNsX2vIC+J9ug/4XkhWqnFuxk3hFcfoYZ2hknV63dAhYgf08MdUrsh52vn1zpZsoh2BdyKErHD1ieAXo4eL5D7vm0Gkzi8ie8BZRP52nEWYzJJc87MIzCUVYqOiDFMP0U7sc6ib+h75jMHYH1CY1N5vuIINiuQ6dRVuD6yBkpg7oVaMFIpFAZ3elK5w4t8YC+ZFf9gUkAZN82hV1U0Gxfsrft6PvjZdYkULpVmcInPEztcj93tQxOrylLceJ8GHQS6M7UIMwaYAew0G7Zsj8+3IKc7JVA9yfJfG0lua1Vh45EiLPnHCRnFFFjAQ31rzq0u6zFe7m8SKparfsTJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nv/s3JGwdaVoEwZ6HeV6M3lLqapj0ZAu62VClmSSXw=;
 b=2hEFa7MeU25ToTPWnKVYP5te1sSM00MtTuN30lCuZ7dy47eh0sF5IFgh03YUgqmfEfEfyNNk2LyDt2babTbWWn+pynsGMjY9cd8C4zN6mALOIbvfI4bd0LyKQ7tmjjEbxRppQptJ0QQv01lJUBTKjGgiRCWlVrkVBq7Mk1qED/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 14:25:07 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 14:25:07 +0000
Message-ID: <02ae12fd-2a70-40fb-9c29-6b9b572e5119@amd.com>
Date: Tue, 12 May 2026 15:25:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iio: adc: xilinx-ams: use guard(mutex) for
 automatic locking
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>,
 Conall O'Griofa <conall.ogriofa@amd.com>, Jonathan Cameron
 <jic23@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260414224245.8493-1-guilherme.bozi@usp.br>
 <20260414224245.8493-3-guilherme.bozi@usp.br>
Content-Language: en-US
From: Salih Erim <salih.erim@amd.com>
In-Reply-To: <20260414224245.8493-3-guilherme.bozi@usp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0068.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::22) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 024ddb9b-f68f-4161-3ab8-08deb0324462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jiOniOvjt23ktL1r061AaJRlnebkuoczkh03SU4JHlhvUaCqmdKkzURK2vGCQMkSQbpNlvArHsT/+D71aIuSRHGdc/uh+2C5bRMC0+TJyujbDbhFIUdJa9QFGdox+Iz4N4lAiGqDUBFGYeYDHhOSQoSoX3UFHaYZ2EjqLuo8BmwSnJkSwGMwLuS0qst6pgnFIZuOURweB/l6ntU9uKkEEn72gJu5gAFAUxCKkmgx0p4Pq34WaRrB+PEymbNuqbBj3AG8AXhvh3utu9kFs+yCSmyvUmV81aU+xVxK12eg+GXE5qELkWLd1B+kyerdkCxxaRCqwQYhL071v+y0A4ZDRltcYv3WG6V+m5lorrFMFrZot6HObAymG1EXfa5M9JE7c1bxg/LQFn4L4hfxVrIrQXS5kS4xADBHuqzqAFMcvHVKCHpuj8oZKlp5XiXkhWrTpdZPF9sDoiEPxXdF42PAf8qw6Nfh0l4zNRWpHhPKD/R3m0nKWRtO/VdE1sGMIo7dRuqoYwD7O/2zdEY9OfxtWqSHXn3g+CMoxrrV8dcr5BgjJjh1ajr/4jcrkqN/JKrqCbYJ/zCFLaCj41hPhM7qBJMKIt64xg7ndjYTcpfFbMFuzjnNPH8bu+ic4PZ0AUs7j3zC7RjKWsgxxGUpBP0/21Ge3W7cDihZ6O435y8k3ODh5JuqwtJ8aeLRLxePq8BF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlNDVE1mSkl0ZnJIdTN1d2psK040YVFRRFdIaVVhM0d2T2E1TSthTHFaWnpP?=
 =?utf-8?B?ZGlrOGhqWkw5a0o5d3NudEt0SHV4QjMza05zQXBVbTBvK3hFTW9iNEtZZEVT?=
 =?utf-8?B?WHZ0cUZVOERLWE45bkllU21VcGNIbmt2cUpmMGUvUnlDZCs2TTRUQWdOUm9l?=
 =?utf-8?B?Zi9IZFdYRTR1aUdZRldXc0NKaDUzZ2t4UGp3UlVQMm5NK2x4OUYrbzFsZjVC?=
 =?utf-8?B?YUJPWDZLOXBIVENob1EveW1kaFBERXRJMmdJdG8vakM5dDBBeWpNYnpZY2dy?=
 =?utf-8?B?UUpNbkhUWUZySjkxYXZUNGlWVDVFbzk4RCt1eHFGSnhMR0llNGk0VHl1N0NC?=
 =?utf-8?B?WkU4TzlZOCt5bzNvZzEvT1FvVVpMWVFDeUVsa0FIMFl4WWh1ZlBJb25MeFg3?=
 =?utf-8?B?VjlIOUFTc0RIUDBrTUViRllyemVUeFNOS3F6TTg3UHFGdWkrMWlrYm5ZR0ZI?=
 =?utf-8?B?ZWdNd2QwZFoxMnl6TmVlZXA4Y3hCb2NMM1I4dHRESmE5OXVBK256SVdJUGU5?=
 =?utf-8?B?bS8vcng3Um5HMGVGekxmR3JkUWFCR1gzT0VPNFlmRk4vd2Q5c1NBTzhYVGdI?=
 =?utf-8?B?MDluNjUrTy8zMGNKNjM2UkdaU3ArNlRnd2FmVUFRdW54SnVpUStrSUh1QUkr?=
 =?utf-8?B?TG9lM1ZlcXNnN1pPelgrcjJPTitya2hQS3hvVVVvNGo4ZG5vN0NLL2s4UlVM?=
 =?utf-8?B?UnRwaUQxcGdVUnRHRG16aTcvcWdDbmdITTdGR1c5aG5LWFQzU2RtT1UyV3A4?=
 =?utf-8?B?bEY0Rkl5TGZxZUFEVW43WDhOUjlwWmtzeThsWlJjVndJVVJURk9HK3RXZlp5?=
 =?utf-8?B?LzdWUzBSeWpFQmI4NDEydERQSHlPYnU2ZGhGcEw3ZmxRbHRHdm1RVms4dE5B?=
 =?utf-8?B?d1NwVTVSMVpSZXpuL2t0Mlg0SzVDSlVsaS9oWW9nRGE2dk9EMzNtbXBUSDFC?=
 =?utf-8?B?Rk9qUk9TbFR1Vi9ZUkRIQzRLN1FFQ3VheExGdXcwbWhkMmVTaThnTmQ0MFpB?=
 =?utf-8?B?U1pxbWdlUEhwSll3enoyRWw4NGtibFlYdU9oQy9YU05zNVhwellOTUN4aWFl?=
 =?utf-8?B?ZTZ4VUQwRndjQVd2TDBCSEtRSU5QTFpEZGk1UVhlWkNuYlVHVEhodUkwOVE3?=
 =?utf-8?B?TEZTTDQwT0J2OExNUWxFOHVIbGpwSkdiemlrMkl6YWpLK1BBa2xBM2FvcWhw?=
 =?utf-8?B?MWpFOVpPUEhTa1dsOHFGNnlZZHpJb0FwdjgyeUloYWVYYXpQZFBSVGRtOGw5?=
 =?utf-8?B?V1QrOTJHVUlQaVhwcDN6NTRhOEplNzYvTTZJM2RVUDkzSHZ5c2t4TjVQd3c4?=
 =?utf-8?B?cC9ITm13cnpXLytWNFkveGlPVkNnS29BU21zSWJ4L2MxSHdja0ZyalJ4eXox?=
 =?utf-8?B?ZDlrb1U5UklJK1BGVEhhZXFPM2RWYmFmUDVoUHRBbUhTVG5zTDA2ZCtVRCt3?=
 =?utf-8?B?NUlxNEFNd1YzeiszWWlKZkM4ZTNrRXFyb1UvbXNzazk2MkhPY2hTTmw4dUpN?=
 =?utf-8?B?ZUR2UFRpeWpWZmI0bCtnREkxZStmeTBXaFFWQmZqZmtrVlIrRzg0ZFlhRVA4?=
 =?utf-8?B?S1JSRTNBSUo0cGJQRzRWMFFWU2pHRU1pSGNkUGNtcDJzR3hTcjJFMzRac2Jz?=
 =?utf-8?B?WUJxLytqUDhXcFBBbzllZy9WdDg2aWJiak1vUWQwZzVLdVVER1lXYWZ6UlVW?=
 =?utf-8?B?MEpMeUJESUNGVHMzUnFFN0RFTDg2c1laU28wdlV4aVdRZHBUTi9qZm9BZzlk?=
 =?utf-8?B?UXdqMHBmVnBPT0t2U2R3QW1JU3RCM29SVWdhdm4va3ZTanZLM3lXRVA3Yllj?=
 =?utf-8?B?MC9xUStjRi9CUXFBRkVvYy9POWxJcDdlck02NkJWTVdZMGNBRUV3ZlZqNFhV?=
 =?utf-8?B?UFQ5bzNlZWpnWnJKY3FrN0wzZE1WY244blhtd2ZIdStUcTJlN3F5Y09JcVJo?=
 =?utf-8?B?dU5oajFjY2Q5Y3JleER6dWFjQnVlUHl6Q0JacmdmaTZacWZOSlJsUGlNMkFX?=
 =?utf-8?B?UFM4VnMxU1RMOWhJYVBzZ3RyQW1YTG1yUTJqVGMyMVkxUU9aVXNHS2Z4bUtL?=
 =?utf-8?B?UjFqZmkxbHhDdWg0WWY1dkNKLzBPblNwOGRBYUhqblc2WDUwL3NhMTNEMzFr?=
 =?utf-8?B?OG03QWtOVk9iUzIybVNUZDBjRUlvSlVtaHkwVHpqK3pSZGJDTjhxaERGc0F0?=
 =?utf-8?B?L05JUERwTEw5UWlud0cxZkx0QVplQUVqNHptNE42WEpjNTZiay9rNml2WDFs?=
 =?utf-8?B?SUF5WCtjOE1jNkhJRFI4bitvaVI5S0p4aG5UQU9UMGl3dFA5Q0VWOFN2U2t3?=
 =?utf-8?Q?peE73bZ5qNSJ+723Fg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024ddb9b-f68f-4161-3ab8-08deb0324462
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:25:07.7515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQbLcw57LDRBIIxnIDd51AmzCaTnRfXwFS4CScU2+GxBIlPvu2F6JRmt51sPYGyW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486

Hi,

On 4/14/2026 11:40 PM, Guilherme Ivo Bozi wrote:
> Replace open-coded mutex_lock()/mutex_unlock() pairs with
> guard(mutex) to simplify locking and ensure proper unlock on
> all control flow paths.
> 
> This removes explicit unlock handling, reduces boilerplate,
> and avoids potential mistakes in error paths while keeping
> the behavior unchanged.
> 
> Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>   drivers/iio/adc/xilinx-ams.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)

Same indentation issue -- spaces instead of tabs on all new lines.

Salih
