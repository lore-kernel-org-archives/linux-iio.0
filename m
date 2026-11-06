Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793965581;
	b=R/7sw6KMeFZVPEpIcpeqdcPZY7CETSqo2GYCcQew5jyBL79YDIOdysr2rVKDO/p1Us2M
	 PZkrC3S2ujl/hszM6578jcUhbXsv+SzRJxU4xfDwHXQ3arx5ZQY/G68FVkYJJw+F6dD7D
	 hCyHeE1gHBYT0JMvNa25OlsdrQpNd3+zweiYQ4fE2AJ+VhRjj1rUjwPFz9sk6usrT/q0y
	 36vAEgo8Ei+5c8qAUrYftbC9JLqzaRTDyOV+XOneDFgTTafsM1KR9iGxvw2N4ybb4ghMR
	 0LoobkjWNJ3ZmBf2GQlHespJ/TUAtHEmiCFQEAfpmrUCjPLKgnF4nYreqyCAuZ6SLJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965581;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UNOTQoDRVvucRLyVzGHIuQM10gzVmg7iWt0sLXkN5tQ=;
	b=iOqyeSDrU30pnsO6HmvhCEvpUmmy1Z813w0ARlZ9RhAPoCdL3zxV2/DHPfxa6gLJd9+P
	 egeYSpQChESd9nDb0bgBy+EwU2jY/auicEw99U4tL73bop1n4bTgaoDEfqb6EmibXwEhf
	 Vrv1/iy9zSZ2eJmQ+uFMgtJ+q167qzEDOOwSYX6xPrguM2Lu+lzhrTbvCzqqkqJWXW2uu
	 RZEx73VrpKSxL73+c8tOFJ05ybbJUuRwR92+gCaGyYjCZSgTXHHtf1iAL/B+ScR7wBXoX
	 m1qeZ+BoSiivtsyRp/80meVdufXOgMNnZAkuTMuamGRDkjNuWQvq0/nLEXWqDqemzNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="xh/o1+CR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.35
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011035.outbound.protection.outlook.com [52.101.57.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467D606A90F;
	Fri,  6 Nov 2026 11:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4467D606A90F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xh/o1+CR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucieGN9zEBZk+WkEC7lwlVOuLKlEzDG+geQZWlJ2Z42x4pjCMTYkfsC8l5C4OCRLImXKSObvzXoBfeGChQ8a5wojwTWYoe+ozqDhzgulDE4SBZ/V5IfWdwGybb2YvO+0ZVWtHwkWMHejnRUNScjiAtbhRVf+22/Cvrf1S4b0SlWSz4+rQ2Q9c6VvmhMB2pDBo1fiE58VKdeV5k57C8sQSjnP2px0C5RKyfT/EnitEMFEczP/IxKvdpNO2ZF9X57P+XU98OVOwQjhuK1nNqxYYvn0ijNSjfVokReJ/b0o3TJfUNjC/uZTwf5AgjpJYSKkZTT//U+ZhL7O3rwKlJleHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNOTQoDRVvucRLyVzGHIuQM10gzVmg7iWt0sLXkN5tQ=;
 b=DIXFHPPmzLfod4KOKyBEYQEwOrZEHMQVXc01S2DqPbw1J5sF+oc2YU1ZqeU5XztiifX3gbo31Vj09pTIxQuyavrPeDb26xHPyRLhMxjmJOA6t2OXWdjo8jQg76qBAnPWS/ST10+jO6kYsbN5UCfq3IC5qdp9Zj1eCARQShLclx85iXjv5sElKSAfVSDQeenlxJIYv0cofKkpSYzNj0KET+iEAmQ9ugT5MfVVo3bu6kMuqFLjE/pSrp+jd+lSB2fFf8VTxaX2FlZQJRwpw0D5gx4lVr4bXHvBbdVN5jY40cbHLpNx1bVaQ7E/lyeydUq/KwDIgxRlZIYJHYDNTYbv2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNOTQoDRVvucRLyVzGHIuQM10gzVmg7iWt0sLXkN5tQ=;
 b=xh/o1+CR1Le1M7aF4ZNOvR5nKAn4RqbGdMeEzYtG3AYuv3J+4ntB8EJX7iV+md/wOGgZX0W8JZrEtedsHrnJgnlDvTJmTLhNb8TTUW5rdP+0styDExUTMH49YJNgQ0qib1PML+AMmsFLxOw1H8CSdiCANpmZWQLHz4bbraVqJxk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) by
 CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.11; Fri, 6 Nov 2026 11:46:18 +0000
Received: from DS0PR12MB9060.namprd12.prod.outlook.com
 ([fe80::e096:864d:d60a:c83f]) by DS0PR12MB9060.namprd12.prod.outlook.com
 ([fe80::e096:864d:d60a:c83f%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 11:46:16 +0000
Message-ID: <34222d8e-ff97-444b-b668-c3050daf9720@amd.com>
Date: Fri, 6 Nov 2026 17:16:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] MAINTAINERS: update Versal SysMon maintainers
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, Michal Simek <michal.simek@amd.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 amitrkcian2002@gmail.com
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
 <20261102122112.1723130-7-amit.kumar-mahapatra@amd.com>
Content-Language: en-US
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
In-Reply-To: <20261102122112.1723130-7-amit.kumar-mahapatra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::6) To DS0PR12MB9060.namprd12.prod.outlook.com
 (2603:10b6:8:c4::12)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB9060:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 8589f753-efed-4c03-c925-08df3bfb90fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|261021121427099003|261022105027099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CNW00Y/+QL+1y2SdrKmLAKKv6r6bRXspX21zZWuo+IjXWS32NoFZGgXyvaiDqJ/bC72BCZn835BKIldmWwczd6DaSM2rtNbRSvG8j6AJYVemAplIGUmxgR0JbjNQiVkoxPJQSzr9XMrQvPWx7ddDMC/BCCRp9Md8MO0ADuf9lcbCnA5/YW2D8duLO6vwnrbxSmrGADnbbd7U2oTvk71+3SpZ+Xk/kir5bN+vUfkJfzoh77nJju6NpR3ZaiBvkaVJjAYMkoesd3iYX+FVLE9ClC6HX63OeyQ375/NvxX43X4Q80pq0HofHktI3J32uKn6E+sCVoARL7uiUERH7L8Bn2wdM6DIhnS4ZciOyAT3ZFSoeWeruqvCB4vLlB6s8dlJCya1fxlV3RjhfxbZHCWcMMyMG38Gk1Bcw5rDJD8rrIABrlboBsXLaOwIP4aZoD9WgeIK+JezFFbsXJiH0LZZJ6CWfOzyTtgS0S+GHpNO99V3hwNaNShunQUkegSZLAXS0iXScvywsT8L2Ofm8Wk58Jl6Oy/f/QFxYxGPSxGt4h0kUn5NbqzXVZfWe05YFkyV1QDFaML51rWuTeKQh39+2bvqLQKAQAZZ52E+1nOFyC2oi14jpH0dGbCjZ9vL/PxYWZSNOVWONMQ75d5CXBErsoTkRU+dBemQvuNv67BFPWw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9060.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkNUMlRWNGFMTGN2SDZtcjgrdXZhRnJjd1FJSVJ4dGx3aW85a0w0NGJhUGpL?=
 =?utf-8?B?dUEzZ2R2N2pEaUJDQmJYY1dxYzVJaVYyTXlIL25yQVRJOTJQVForRHNPeTlV?=
 =?utf-8?B?dHg0VHVyV2ZTVmwrU3BHdzB0TzhFSmxBTjEyV0l0UXdQTWNnL2NvdUt5VG45?=
 =?utf-8?B?M2I3QUliMlcrczhaS2FXbUd6QW5LdGkyTTFkZ0hmK2tNRTE2QkNhbWFNblR4?=
 =?utf-8?B?QUJZV01KeWZKaFZCcktYbVhKWFU1MU9NU0UzZG9xaWxQQXFSdzB1ODRoTHFB?=
 =?utf-8?B?bjRNT0hmeFo0NkowcGpmWjFPU2RvNkdhYUJMY1h3VDN3T005YnFBNVZGWmJy?=
 =?utf-8?B?dDlOdnE5UWtCNG01ZENlYXJsbi9ESW5ZS2JVemVqVTZLa3dRNStlb1U3ZHJI?=
 =?utf-8?B?aEZtcGRHQW12VFlMelJzRWNXYXI0eHk0eDB6ZDdPWWJYOHl1S3RBRENDaTZF?=
 =?utf-8?B?aGNZMFg3T2pIc0VETEFrcThWbkNYaDZOelFVZUxPWFZFZVA1SEJyWWFtdHRB?=
 =?utf-8?B?MzMzWVl1c0ZubWd5WVFHVTRVVlJLZnJ3L0RvODM4WXN3U3FydG5wMnBRdERJ?=
 =?utf-8?B?L2JXMkVxUEVKNW5sa2NTR1A1ek5tckQvVU5RZnYrak9tT3FDSk02ekNlM1Vu?=
 =?utf-8?B?R3YrVkdaNzU0QW55RXBKbE5zL2hqbWgwVGVFNGhwcis0L1Z2RHQ2ZVlQd2RV?=
 =?utf-8?B?ZEY4SVhPUEFMVVJvMG5EVTBwN2RYcjdUNGVaNUFRcGI4bXJlTFBvZy9pMXoy?=
 =?utf-8?B?ekJPSzdlelE3WGc3enVBSDRPWlBpczI4QXYrOUdGZFpSQUtkcXJkQXBUWXoy?=
 =?utf-8?B?Y1MxdGdSb25kcmEyUTd5dzdyL3FHRDdTTytZOHc1aThNR1ZxN29rMlBDQ0N1?=
 =?utf-8?B?cUxhZzRsN1lMVnJVSW5MZVB0cmE5Nnk4dXRUYmNaZHAyYTBqMWdNNk1Sa1RB?=
 =?utf-8?B?NFpyWVN3dzlLT0NncFFUMTRIM29JUEFJOG1ZUlJZTElBVWVDR01ZMGhGQTlj?=
 =?utf-8?B?Ri80K1lVU0V1bmxhNStOZW4xUUp5YklMbEdKcVZWSnduRitHeGJRYkRrYXJ4?=
 =?utf-8?B?VUxVaUI5Z2ZjYit5bHJoKzd1NXJnSDN6eVdBTm51b2RoYWorT0JQMVJGbmxK?=
 =?utf-8?B?L28zU3BidkR4aDdpczdSdVF5NHdlWUx2UncxSnk5anBDbDdpMmh3UjV0MVNk?=
 =?utf-8?B?Q0Q4OWE4SFV1VDI2NlVibWRQNUprekpTZkR5Sjh5bmdvRFh3c1RFMHRTUVd5?=
 =?utf-8?B?REthcWJQN2tPcmJFSVYvMWpGSThWUmhFNDV0UGF3QVFNcnFSV3kzdFV4TGVy?=
 =?utf-8?B?MXFjUmVkelBKdUorQ3RQOGtSbUwxc3RMTlpHMWNqTWxiQmdBQTQxL1VmOE05?=
 =?utf-8?B?SW1jRTZzVE5UR2Zwa2RiRXRQcWI1MzFuZnJ1djFWWVRqUDN3NUx4NWJTcTU5?=
 =?utf-8?B?L3I5Z2IrcEsySVppVFJJNGl2UlZ1dm1QTm1RYytUNlhRVjc2bWd6L2UvbXRr?=
 =?utf-8?B?ZU1MRkxzcGphVUlMN2RQZ3N3UUhhRVJtaWFleXFCOVphU0VqVFBWc2Ryd2sw?=
 =?utf-8?B?OFpvT2R1OHVBVnF3Y3I2L2hueEpUalJERFFTOEJwRUVMQUVHbXVmNnNBSDFw?=
 =?utf-8?B?MVNPWGVjbHhKbGxQKythbk5TTzZwNjlBSzhBUHVDT1YxLzFBR2Y1YVVkRnpo?=
 =?utf-8?B?aUNQQWN4R2o5TzR3ZitiSU5kOStLblo5Wk5wbEJGRktxYlFkell6SXRNUERq?=
 =?utf-8?B?ZHRnaERXbUVRcXJPTHY0WnZ6T1JHWGdRNURyUmVkZHcxa2VBdDJCamVEUTE1?=
 =?utf-8?B?SzJZQ0xvVmJxdHBwcjgxZ05FOFJaZWV6dFN0Ynd0a0YwOVBCcjI3UlFFczA5?=
 =?utf-8?B?Mnl4dkdDb0RWZWdaS2pDa216SmFhREdPSCt2cXNCUzNpdkVWdWVGMUtoTDlz?=
 =?utf-8?B?TEFwanZrTGgvOHl1K2dtTHFkMFFkMmNLbURSMGRUR2FlTjdONzJZSll4aXFl?=
 =?utf-8?B?ZFlVOER0cUFjRHVqRkFZVUFxRk9Yc0R5QmZWbHVONlpCMTNUNVNzbVkzcUE5?=
 =?utf-8?B?dkJnY0UzemNMNHFjbGFsaUs2a1JmZ2JKQVlGRkNvajROdURYVmJEdHFtWVlK?=
 =?utf-8?B?TWhtVEJ4UzhEQzlwZjBRbWpEVXdmNXUwSWhBT3FaOFVPc1FlSk9hSGtoNkpT?=
 =?utf-8?B?NXFpR291ME90ZlpxQ2lwSWV3N2w4d1Y0cm51Y1VmR2ttNDRRVEdOcUV0K0RQ?=
 =?utf-8?B?WjBoYjhEUnVkZkVuM0QxL25STUpWWlVTL3cwRGNoZUFqbS8wb082SXp1WTJw?=
 =?utf-8?B?RmFIRmhDbEZBcDJORmRqRkRPeFd0WFk0SGZxV1ZoMU9BV1p1eDNJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8589f753-efed-4c03-c925-08df3bfb90fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9060.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:46:16.8656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XS+seh8FvmeIaFrm9o21c7VSVnl1hDc0GLgvXbIV/mQNumviXwlq5Q0d8AU0AvcxINdZvaYErLgKrkza5fvE4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990



On 11/2/2026 5:51 PM, Amit Kumar Mahapatra wrote:
> Replace Salih Erim with myself as a maintainer of the Versal SysMon
> driver.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecc22d1149d1..e3aca3bee13a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -30023,8 +30023,8 @@ F:	drivers/edac/versalnet_edac.c
>   F:	include/linux/cdx/edac_cdx_pcol.h
>   
>   XILINX VERSAL SYSMON DRIVER
> -M:	Salih Erim <salih.erim@amd.com>
>   M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> +M:	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
>   L:	linux-iio@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml

Acked-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>

Regards
Sai Krishna

