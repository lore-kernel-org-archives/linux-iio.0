Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F84A23E356;
	Tue, 12 May 2026 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609153; cv=fail; b=qXBUZsGhQxahF1QC9iuzFK9OOYq99el+tWU0lBjLeT0QZcdyN8vDgAgFHFvPiO7VYPb+7zhafjJQ0iN6+4NeqRHA7lw7ZGQnIvkaXjeGyj1mD185GGYVs0eRBAShtnGcOgu5HqGMr/UkJJOe+UngM4S3aSAavFU0MPbb3vd8FIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609153; c=relaxed/simple;
	bh=2oQ8Ob9J52TAx4XWyWLGHyKOISLx2vfck4nO+/ZFeqA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hfk3bIvJw4iqBiIi2V3lyftQmAjEPVGZztNMhggZN2HOLbo5KlujsfbdiqrmXK32ag+XhWbx3FV1vwKyYGFveL6y8p4hhbirZ25HmBDMmb5UY14gtKOjqFkLzVWs6P9acAFhHW4kSf6lh0LeazjFkVdK19Ns8Je/Jp6DiC31/Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FjCTt5d0; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FjCTt5d0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzItTUrbh7aEwAQUJ7jf7tJoHrwkav4M0p+HKYmfZ2yb04SfGGz/eLCacL9c6Btwx6TPJwB7Obkce+YO0sAm8Gv27CHVeRUvvWAlVeUEbpdVz+OOivg0tbkrUhpJQR3QIpMBdLItPUTikWLijUBAa3OHKghXxTDlH5BrcdzIb10dciz8rdDlW2aFwEJzJegJbZqSWSb4BJhFye7ZMWOBlL4+H7sc3M7ksMD3xhR/g1+YPgvdrqVpve3BELAMzc/MhYlpCLJXGzA2DuJmxaoyF/QMdONDBn71c+QtXl6Fc9yFtsOgFcJMoD+HzA8LU3o4d9e4ZVOz7FeHA2Ci2qRAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ueo7uGsbZwhfJ0bT2SssVM4TJM+C11TJB3GgdvB1MWc=;
 b=egbxwqfEv4eyTF51O2KGUR2HCnAQaLiprf1i3VWBQPeO3pYQp30eejb59xBJbPqR/0CorkvnSFpe82bW8fiyH1Gn0KYDRz4SxwbRi5PvikeyvRrFSldVQW/G8yturGrKbbkHE4GuycElyr1l9Nj989do067zqy0ywGyrEWZH8Yq9MOihunJl/5/jOz4UNPbK7oCyZP5tQga+sQtSbMH9k2IRr5Qpj6njR1fKlCZ2AO8JyDQ7yZMlgpwUTb9Xr0r2kZgqri9DeFOqECNM4j9uzrQPQ1V1yyaSYF8VsaDlIOd69olYi4bKBA2gFKgHOTDdg9OkJV3TAe1zqH79NR63yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ueo7uGsbZwhfJ0bT2SssVM4TJM+C11TJB3GgdvB1MWc=;
 b=FjCTt5d0mPhX6TG25/f7uMkoNpTfkuoJbh0CcNx5+QXkxkmuMfUt7OCuLTSO+2zaKCESNj7IGXtyBOE0/gBV4pC5IdxpOIx+zmBLwu/vdHnAJ4ZCyyzrcdZY10C9ts571q+hoPzqaW7SpRUxiMN3MwfrzpnGqWZgCvVsD/rvDWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DS2PR12MB9662.namprd12.prod.outlook.com (2603:10b6:8:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 18:05:48 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 18:05:48 +0000
Message-ID: <223817b7-8f6a-47d2-8362-19669815f48e@amd.com>
Date: Tue, 12 May 2026 19:05:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] iio: adc: xilinx-ams: fix out-of-bounds channel
 lookup in event handling
To: Jonathan Cameron <jic23@kernel.org>,
 Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Cc: Conall O'Griofa <conall.ogriofa@amd.com>,
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260414224245.8493-1-guilherme.bozi@usp.br>
 <20260414224245.8493-2-guilherme.bozi@usp.br>
 <46bcd2ce-bfb4-4fc3-b840-dba657f39a7f@amd.com>
 <CAJgF-xum3OQ36keRW5gCnTTbnUhsHZUzL41xKn0hjJ3GqgyOZg@mail.gmail.com>
 <20260512165444.4ae39d90@jic23-huawei>
Content-Language: en-US
From: Salih Erim <salih.erim@amd.com>
In-Reply-To: <20260512165444.4ae39d90@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::19) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|DS2PR12MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c8876b-4302-4980-10b7-08deb0511863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MZJ79YqkLFTAvnULtuQmVg2q9wMGoynUFzE7YgWxxfxBTxCpaw5eMCSeT0UBNjOesAkdpRs5aXhmItp3ZVbYHByniiguAduWB7bRdrkwJqLjJOq8yYHiOzkotbpx2Tx9hDhbU1CV8Wz+jLXqnCS3C12aYIg3waCIxboPAtLZVdnyLqighl/xjRAoi/UwhCvsDoFgrOQwdcOVO3jIB+dPNYB7hby8ynmLnLN462/OWR2DDYFiJYawVkUq5M/WCQ1nk6B5J+41A1gAKFtV7QxAoXtzsAlnzUdtomFssz3cZfxhaMNHx1+GUlkaGDyMif2Iy3e2wIFkCmokzai5B6/83r0m9mLAgjClopcPQRVRG5aK/n5h0UljynZf+I7aTOxUX1JWiH3TTMx2SrJa4dKhrClMvmcA+i9OLX6geUYAfeAc69GSUMpjygeyB3yGtZgATihyqfEcr6Fs2KrukKmYRfKbdF3jRbJnwgk+P4uXcShY9t8XftKmfA5DP3hzR3rtTBoUoe/FY+sAXaMnFwigFmm2kdExRhHJAYALGVSfpvbRdwm6OJSuC+HeXvtCvHXfJ91cF/9oc0GCMBprivsmU+sJf1uUoeDBHB1CeLfafGm07uT2DqdOa2oTe9326rzujmAWmYK+QZhdV453+Wcb5dY4foR943s6LFCjA2pu01H5FkKGFMTWnBpFTsTu/YHU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckIyTGNzMmpFMi91MzFpSkw0U1FaKzExU091SGlYRkt6WHREZUxpYmpySDlB?=
 =?utf-8?B?OENiS3l2V0lzOEhVNEkwZHdkUlpnS2FUTkZxTVhZb2ttWXRKMU9FNE9BRER3?=
 =?utf-8?B?ZDNhdXgySFJkRmhKZWYyTWpYWUhaeU9rV2ZGVEI1OGYwYzMxRklmRUpIMnlJ?=
 =?utf-8?B?V3F1cVgvdXdjMUNSeEZzUzJuZ1ovY2pFdU0rRDdkMzZqRFNCdDJraVhqTWtu?=
 =?utf-8?B?a2hXQllkcE9oRTBBV2xrWjUvaXgvSE40Wk04SS8wOXNkRmR2UVcrT3AwT3pa?=
 =?utf-8?B?S3dvOEVXa2ZXMTgzMDU4cE1QcTVwdnJ3NUNCcFh4NTVCbzZmcGNFc2dOb2F0?=
 =?utf-8?B?THpRYjZsOEdMU1lsQzlnNnRDb3Rwd1Q2QVdSR0FZamFjSnVnUzhSdFBURDYv?=
 =?utf-8?B?VlllODNBQXV4OFB2N282Qm1ub04rV1UrWmhnODJEeGFYR0RDamVnZXpoREsx?=
 =?utf-8?B?bFdXSC9VWVM3b0hLQjV0UkFQL2MwZm9jdTdyMmNjUDdQM2xqaWttRkE3aFE0?=
 =?utf-8?B?ZndXbjRHWEZFL1M1U1VWQjJ6UytRU3ZBZG5SU0wzNmZXc0JUUTg4aCt0ckNj?=
 =?utf-8?B?SDV2ZGdCNUpDZlN2UzRvYlBpR1VWQUYrM0dtdVYvQWhMMk03cDlLS2ZOY0pu?=
 =?utf-8?B?TXIzRGZJMzFyNDJuWG1YcTdobVJKcWo5dC9uNkxURk9OTjY3WWtEeXdVNkFG?=
 =?utf-8?B?UXZ2RGNYcjdySDBGOXR1dnE5TWVHMnBFOXJPbkx5cUNGby92S3MwcTY3UmFP?=
 =?utf-8?B?Um15WFU1aG5taFMweTFGTENPZ0dQejlQRU50b0xDUjVlSnllenIyZ1E5anI0?=
 =?utf-8?B?K0I5Uy9sbU85aDFyVDhDWXBhMXhtVlF0ZUZyVG9TSDFxY2wwanVXVkJhWE1v?=
 =?utf-8?B?aGlJUGFLQm0vbmowdEZxbWticTViaWpDTk82Q3JHVzUvOURiQ2xwMHU4ZGVq?=
 =?utf-8?B?cnpkaWZHS1BBbXNReDhXdmlTRmw4Z1MxMTBQbWlDVHhYd2NoMWNYRS9PYVFt?=
 =?utf-8?B?eXJHZ0Rzcnh3TGxNbCtoS0tTMGkzK3haaHk5M3lzVWUySFZOS0NqdExBa0tF?=
 =?utf-8?B?WmMvSjlMZldrTGx2N0c5Ni9pY2xwbHR4UlZXbm9PZHVCOWt0WEZYeWROZHdh?=
 =?utf-8?B?cWlseUJNL095UkdPY09VTWZobzhXN2huMDRhUXVBVEo5b29VRUt3bE13VzRJ?=
 =?utf-8?B?LzJYbjdLT2FPNy9sY2ZsWFZpZStyelF6dXZiMFpHYTIvdUV4UEYwcHI5eXJ2?=
 =?utf-8?B?VzZOdjhzNmtSQ0E3U3d1SEpxQzIvT3lMWkxaRlh4NmEzLzZLMFQvSW83V1ky?=
 =?utf-8?B?dDEzWjZPWG1Ec1ptRVp3L2JjOVBwK3Y3MnU3eXIzZVFvdElHWjlnZW1OQUkz?=
 =?utf-8?B?YXlRTnJvRGZPd2tzQVpMOXloV0M5SXJxUm1EcUQzOVNqQzl3b3BKeVp3azFK?=
 =?utf-8?B?YUdScUIxR0JMNHBVTUY1WDVXL2l1T0RpQnRRcCtYbUZSbjF0VXRUcFcxR2ht?=
 =?utf-8?B?cnByY0QwTnVuQ2hhS21MbnZjUFZEZjdnbVh0eU9FVnl3MTFJWDkrcHpJOHVX?=
 =?utf-8?B?V3E2Tm5JNU9pK1FEVXU0ckwrMlJsY2VKdUU1dVZoeFE3VVpFc1ptb2hlNVhK?=
 =?utf-8?B?enAzYTA2RG50NTVjVmZGTmQ5TGJJcFRJTFNqVEorVXA0RStndS8vMy8rcmoy?=
 =?utf-8?B?a2JPYTVQaWwvYklvNEpUS2t5STU3V2NMTGxSS1VpR2VYSjN3UWFZMDdrOVdk?=
 =?utf-8?B?RzROSDdxRjVQNG9ETGIvdnNiWVliR1hla2YvbW94WWtrTUhvZTlDc21uZ3pz?=
 =?utf-8?B?aStYeUtQV2w2cDNqQ3NFNGhpTDNjcWc0b3NldUdUQkJDWUZhYmZwblJydm0r?=
 =?utf-8?B?NEtYZ244OWM0a2haY1JYYmJ4TXpsOXJ6Z0cycFd5Y0NnSXRrdngwU2g5Tmph?=
 =?utf-8?B?K2w0MFhoeXZxeDZPK0RzOC85NEMrR2k2aWJWTzRSdDFUV01WS0tpaGhXemg5?=
 =?utf-8?B?L1FVYUhsTDI1UERFcktCbURKbzM3NVVPYmVDR2IrRmxhVVI2ZGJOZlR0b2k2?=
 =?utf-8?B?TTBTUWcyV0dxZGpqbkxuZnpkLzU0OTJKMCtUWi9LelRFMzlPMDQ3TS9xeTBD?=
 =?utf-8?B?VzJkVW90QW9LeDR1VXdQWkRPNUcrZjNwLzdRNEVJUmpDR2J2eVQ5N3RzUHF0?=
 =?utf-8?B?eFpINEhmRDA3VUxWdTBLV0tQQk5ZdTJmNVlyZms0TkNkTDd2UjlMQ2N2ektC?=
 =?utf-8?B?dmpBU0pqMUdHWWU2c2EwSFRlbkJFcS9Ic1R3SlZqN3NLTndxQ2tOcmpzUDdZ?=
 =?utf-8?Q?uEBXZOHYvU851Os+vc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c8876b-4302-4980-10b7-08deb0511863
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 18:05:48.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyKLGg4kd5fDIv4553B5WbtSMuyAg886FNkqK4Nz3+6Ozo8rdFPMH0FaSlo4kTbA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9662

Hi Jonathan,
>> I could not observe any indentation issues locally or from the raw mbox.
> FWIW they look good to me as well. Salih, I'd guess you have a local issue.
> b4 (on git.kernel.org) is really handy for ensuring none of those occur!

You are right, apologies for the noise. The tabs were converted to
spaces by my email client during export. I will use b4 for patch
retrieval going forward.

There is still the u32 dead code issue in patch 3/3
(event < 0 check on a u32 parameter in ams_event_to_channel()),
Guilherme has acknowledged.

I am currently testing the series on ZCU102 hardware. Will follow up
with my Reviewed-by and Tested-by tags on the v4.

Salih

> 
> Jonathan
> 
>>
>>>
>>> Salih
>>>
>>
>> --
>> Guilherme Ivo
> 

