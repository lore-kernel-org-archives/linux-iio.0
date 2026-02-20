Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F4F21D3D2;
	Fri, 20 Feb 2026 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574086; cv=fail; b=lN7UPr+kZMEhfK1NvSqOJuit6CVRLfzDvf6CaMdvpeTB3ZsthlBa714CrasmzRmxHg6kX6DQs3suK6QB8uLY7Z3lhlOLhWX3rQn2mn3Iee7XJxysfb+wDIBcYGeIzW3FwVyrlglH7jk4KvNF3axDvaQ8aEK0THAApwcvnHG2RTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574086; c=relaxed/simple;
	bh=Fhnn2zuz1rm6XBHtzxwoLxsuhYpLcKUiblGcsm4kjYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QJpfk+3r1IZj8i1zovBzPAk1r3caBNdjRH10g4NIiK5AAQKrd70DlSxPa2APOI9O/GDp4TBcUptcySs4dwS3kXFXBdRTQ+z7RM78ob15b3pWzIlE19Ldhr95HhMHHWb/JraZf5LhP/Upk87W/mCyveCDOVVNczTGu2aR6jbIp2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cnNoRq0k; arc=fail smtp.client-ip=52.101.62.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cnNoRq0k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zp9wFViCdIeA8tFha6TN1Xy0BmpwgLOBinp0O9AlmyFMKS/Nw7+WixIUXlVMb7+qadu/6TDbSmOdPhatumw5DJCbTnSlFi0aucqc6I/Yf58+Lu5wBNrpOgTjPUMYjVN6CqomkMp3CfvFTrx0Z4E88VT14ufFr00uCSSAuReS1gu7mifm4jRPm07evT8qG8zOMdKC2/J6ksruM4WVXb1m5pbIKN5JJKsQFfGijsslI/dqOlaTwM9WtUxaRynFAhZo5nDrYVsR8xD/3x6G9zo0fjbjG5tlF/BFFqQp5L78hBuNvaQKn+pCZju8mBBuWdbwHRwh7+0iRxkeDnZDUiselw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoNXfWgc3Mr3CLPUjVGLJZzj6b+rZjFe8ow4WXBx0u0=;
 b=ReI4dznc/WPonDi+OOaypFPmJuqRm7UR9eXsy3bppWbUA6KfwOQ8NCaj94501nZfPS2kahVqwD25ApKyzgpOMUqvNAepnWVncnfRlxWBk1arMsB6M8yVxNI/QgvAwy6RCY/4Zio1Kg2/Q9rTkhpd2osZbRZQdbWXdDh3VKHYw2cP4F9v6FiZw7FtWFdk7I/xtxHq175hHf+5LmEWV06DdyWg/ip8hy1Xtlmyk6W+ZUYEIbOtjbs9nVQNBUQJaW27KGuyRqOvqNnAdE7nzop53j63WGEG/svW4XlnQUYsKr2tKVv8azXp+3D0RMHu8amHK6pX6JaO+xcd30iBFR2zrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoNXfWgc3Mr3CLPUjVGLJZzj6b+rZjFe8ow4WXBx0u0=;
 b=cnNoRq0ksdfafiwl2wcMyjnT8Akq8UcLpcZO4dz3lsJBhu+RqpreP9Ypq7eu2vDd2+dTos5FnZXqjYjOOAY9TRSPlj4ILemsN2Z8ILqcruTcIKVgFJtYFEIpAEGMIcF3EbXZtn6MfG34tW+iEpSO8Coa/KNOKQVv2s7lTIUpXoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 07:54:40 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 07:54:40 +0000
Message-ID: <fab2599c-e749-4aa1-8157-c7ac358c6f36@amd.com>
Date: Fri, 20 Feb 2026 08:54:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] iio: adc: xilinx-xadc: Replace module macro with
 custom init/exit functions
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, saikrishna12468@gmail.com, git@amd.com
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
 <20260220053941.611415-4-sai.krishna.potthuri@amd.com>
 <aZgS2c45nGTozHkv@smile.fi.intel.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <aZgS2c45nGTozHkv@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0120.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::49) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f3b48a-7196-4688-4465-08de70554cfc
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M252czRLZFhzNzJGcmRjMU9MeXVVRVY4S1lVTnl0S2lCVEI5Y0kxdVBBZG1V?=
 =?utf-8?B?RmdVelEwNUNCUjBWcnh1SFl1UDZsR281OUJMWk1MK3RUcG92cU9aK3UrL0hS?=
 =?utf-8?B?OTVSdVQ5V1NhdmFVRDNiSUN2Nm1VR2x5UHFjcVQ3bldHV3UzUVllOTF6ZkRI?=
 =?utf-8?B?Q0Yra2NDM041OGdCTkZqaWVuakljQm1OWnc0ZmZQNno0OGRTZ3NUQ1RxR3JT?=
 =?utf-8?B?WVdjcmFKLzZ4bjVzRTg3NTZnbHoycldZcGgrcklYR2Y1bU95VzA0RitBeHZ2?=
 =?utf-8?B?S0YrWFlSTlc1TWlVR3FRNlUyZWM3ZDVNcTBWSlJyakVSNnRpUU96SDBYcjJO?=
 =?utf-8?B?WHhva2ZSQ3RjbkVTNExBV0t0cVNzOXBhVEozbjR5WWxoRmJtSndQcGN2UDBY?=
 =?utf-8?B?UEZhWXlGM1pxVm4rd1hDYmJqMTVsaUZmc2h0cG5jZUlTaFJ6WjhVTU9MQVRU?=
 =?utf-8?B?L2ZaSUtZWVNkZG4zVlh3M3RKYUYrZVZaL0UxdllrVkpORDN0a28zNkdkdkho?=
 =?utf-8?B?MzdFOGd0VzlGdTMxYzZ6cGxGWlhJRTYwWDdaOHRSbTBzNURwaE5XeEFXNy9i?=
 =?utf-8?B?UmF5aWgwNU5BS1RRZTJzeXA1WEEvaWlnVDY3L2Y5RnZZWnM1ZlRGQXZaNTR4?=
 =?utf-8?B?WEVEUzNEczlZNmRhN2xmRHI1QjdxL1o0TmIwcWpkZ0NsZHBSbnh1RytjMGFL?=
 =?utf-8?B?NkY5eDVXcWtwMDhiSVcyRTNNQytiaG5GZjVvRnEvS202TWFuVjV0S2xkOGZm?=
 =?utf-8?B?WW4rMkZoUGI1WUNQVFNrZlFnaENsYVFQVVlCNFdPRXB6aFVzUjIrY2xXd1I5?=
 =?utf-8?B?T1JqQzc5a1hoOEtQcUZiTTVEVGxnODd6YjVYRkZtSEJoV2Y1ak5jdTVPbytD?=
 =?utf-8?B?VFVYQXRIYSt2MFpLRWptNnd2Ni9aYmU4WGowVEZzeUlWcC8zbHVaVWtjQ1c1?=
 =?utf-8?B?NTNINUU4Mmh1ZHBUQXhyMXptVThWeFNXQ1liVmt3SzN6SEdRRXppR3JxWm04?=
 =?utf-8?B?YmMvTW05Z3E3RTdKNkk3azlSMjhmemkrVjczZGhMLzdwTTYxWnA4RS94ekNz?=
 =?utf-8?B?UVZxNGdGRHlRVGZYTUJnZFg1eldMSWRaVGtIM3psc1JOc01mTFBuaEtZTzRT?=
 =?utf-8?B?NjBXTkhJRTJIb1RrbFNIL2lPcURzWWgzSXIzcDFXYXQ0VXFoZG11alQwUWRB?=
 =?utf-8?B?SE5mN3hid1FFMW5odnhVYWQ0SmM3RVV2amVadGRsMmVzcU4yaHAzSjFybEFv?=
 =?utf-8?B?bDYzM2hiaGY4bTdIVmRPTFR0Nit6NUZSNlJDeW1sU2ZEVitWK2huM2IydEUw?=
 =?utf-8?B?aWdSZlNvbnQ1SFVUQ201aGw4ZVM3a0hTR1JzTG40a3M0NXNhYi91UjVnSHZt?=
 =?utf-8?B?UWJac1VSS3FZR1UwUHZvYWwzVTQvZDNYN3FWZzdLcGt4S3h3QWgxSU04SWJu?=
 =?utf-8?B?Z0xJQXJ1a0ZPUnB1N25QVkg5U2FBc3JXLy95Z0JHSHYwaFJBaXMwdmo1NmRD?=
 =?utf-8?B?djJ3MG5ZMWdDcS8vckN1bWYwb2x6QXNlK0tnSEJ6NFMwRmFQNUFMUVYxKy85?=
 =?utf-8?B?UVpXb2tWb25CWWg3cTEvbDJoVFdISHJ5N2F4YWpRNjB5cmh2UE5tK0VudzdK?=
 =?utf-8?B?YWVoWDNhenM1V1R1YW4ybi9DOHR2ejIxVVVYWDAxdHlFTVhmTlozSWV0eHMx?=
 =?utf-8?B?Rm5zWEkzQ3NJTy9oaW53Nk9qcDJHbXVtY1VIZ1NrVkZ6MlZ6aDl2YU1wR3c3?=
 =?utf-8?B?dnZ3NmZNYm85TDR0YkxxZS9lbE9VWkpIYlQ2eGNIR3ZYUi9PcFpRcHBYMHps?=
 =?utf-8?B?d2JCM0lTZlFOa2haQ28zWThZdGluMG9nMXROZU9oUDZIQmR6NEJ4SlFzWmd4?=
 =?utf-8?B?K1BNTktWbG5CQ21VcWFCRjk4YmkxcUZ3aGhBNjBadWVxWEszd3B3S3lPZ3RF?=
 =?utf-8?B?OFQyOUI2RGZkcXpWdmQ3dVo4U3NySTgyOURIcU1SQ3NyaXQxa1R2a0taWkor?=
 =?utf-8?B?VnhLYkhoZ0F6d3ZRekZLaWpEelBtUHdpakhKTlo0aUtWeTduaUV0Y0dQa2VC?=
 =?utf-8?B?MkdCb3g0R1JkZWhHZGVJeFN6b3hubEJScEJtTGFpWXJWL0hxa2twOEFXcEEz?=
 =?utf-8?Q?JDDY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6939.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmxSMk1pY3ZTZG96MHNPQ00yTitZNm1EazRRVFJuZExWanc1eG1ueFRvL0xJ?=
 =?utf-8?B?UnZBLzJ2bCtiVDlCZjFmc09mUlVzSnpWSUFTL2Y5bFAweXRKTDhkbXpsQUhh?=
 =?utf-8?B?V2ZHMzUrUUVGem5pRnZTcmdpaVprcytWYXhoU0hMOHN0U213WGlnUXNaSGNK?=
 =?utf-8?B?QmVGVENSTlFncVNMUmh2UVFwMEI2czdETFU3cnE1bktUdmZ1aWVtdWlwYkxM?=
 =?utf-8?B?Nnkva1VYMzdkbUllMEFCUmVDbFpKNXY3TzZPYm1Oa2M0eDBhSU0xK3NPQ2dr?=
 =?utf-8?B?TWJHK0loUVpWenI2RGhHZXd0d3JpTlRseHNqeGF6SmZCc0tkWVlFbURRTzRs?=
 =?utf-8?B?WlRtVml6SGNhdjJVMjlqbXVFRW14aHc3WUtuUmZjM2lNd01mVXJJZHNxdUtV?=
 =?utf-8?B?dFF6OG9rY00rS0VaVWQyYTVKR0hKMU1kc056RUhwSnBvb2FaTk4xR3EwY1NB?=
 =?utf-8?B?NXB2WHNjd3F3T1FmN01GTWhxdGdYZzJuSHJFZ1pNWi91RTVHUDFNMEtmNmEz?=
 =?utf-8?B?bHhWa0xqWXVPSVJiV1pkMHJyazU2N04reS9sT1lvU3p5clh1bGJQMmFqU2Z3?=
 =?utf-8?B?TWZoZUZMdlVTZWRUMzRHNGF4aitnS1hnMlhFNVU4cmZ5N0dTRFVJMDF0YmRC?=
 =?utf-8?B?ZldEYmI4REhxMGE1SEhaVEwwL0s3RHEyWjJSYlgyY1BhTHkyclpKN1BqY05J?=
 =?utf-8?B?N2o0RGIwVy9TOXF5OUxmWFRwTkg5L0VSMU5WTEVNRUVUUi9YUXg1NTFSNEh1?=
 =?utf-8?B?by94azBaV08zVUdMbDYvOEx1TkNPNm4wRkZtMmxCNkNjNHZSam9KR0RRRzVh?=
 =?utf-8?B?ak1vTDhRc1pxS0RMWjhlcTcyd2s1WHQ2OEFCUFBKcVVnREJxVlRqNVFnWFgy?=
 =?utf-8?B?bUw0T2xMOCtPcW1TWmJwTHYzMTgvcUFTSmVwcGRGbGgrUzMreU9USmFST20r?=
 =?utf-8?B?T2UvVDdwM1JXWEZJWjVNMktPKzNEOFN1RVpsbXFtZGxER3ZkTUVxcmxYNnM1?=
 =?utf-8?B?S1hrMHlzRHFHejh5SS93UGIyTFJ1U1pnZU9teXBqd3RlQ0UrREJlbFg4ZkJO?=
 =?utf-8?B?VzBCVS9NVVBQTjFtMVNJb0NVVnFQWG9VaEpKMjczMmpGUVk2K0dRY1poRkND?=
 =?utf-8?B?TXVRR2V6ZHNIZE1RWlVteHI3Ulp5dWtzODlDZkFHbE5FNzJoTnlmMklmVzNq?=
 =?utf-8?B?eGMwTnd6L2NZY2tFYzZJWDhUV1lUOEVhVHBLYmRHUE5JUzNTelNtOHgxSm9z?=
 =?utf-8?B?Y2o1UmtKTSttZWdQb3N6bXZEV2lvQi9yNzNoNitoVGNaZkx6bGs5dFJtT1Rs?=
 =?utf-8?B?SXJKb3JyT3N1UHRROVVNRG5vZjlWeGhVWGpKNzVqMUhFL2g3Ym8vcUhvc3o1?=
 =?utf-8?B?RHFZOVFTcEFNbDltSU52cDlCWEFBc3p4TFQ5L3JlTWRLY2gvN2ROZVJlL3Q4?=
 =?utf-8?B?TG9KU1EyUk5Fd0Z6M3NsUHdBTEc3SllaeThVNlNVU2lrOG1OWUwxZEMwRERw?=
 =?utf-8?B?TzNXMFZVWklNRzk2OFRBNjlBTmRtYnlXcHBXVWpiZUhaYjZCTjk1eElocHBl?=
 =?utf-8?B?dXZZMGJCUkczQ0N0V2NXdGNmZzZIRkt2dmFJTDV4TitUTTA5RkxxV1ZMVVIy?=
 =?utf-8?B?aldGeHJEVHpjQmgxNStiQVZLSlQxOWJCem9TNW5yWWRyM0dwaFg4dnhveitY?=
 =?utf-8?B?NG9tK3JzNGlQZDNyb1BLSkZBZDZTU0JhemRxdkpCMzlscTVpS25oQ0VDQWV3?=
 =?utf-8?B?MXc0Qkwwa0lLOHVSdkIyUzZIUStHNGdPSTU4MVRaZlpzS0ttV2VPbHdFMFJ2?=
 =?utf-8?B?YVdnWkpZdDdkR2toUjlvalYyVG9ZVjhCQXlJVVZmU2EzZ2dXSmlwUXNyeUNB?=
 =?utf-8?B?Uy9oTEovbmJyTG1iUy8yazZwaHRybmV0Y2xWNENtNWFNSzJ1aFEzOUE2TW9s?=
 =?utf-8?B?ZEplVzkzWWtDcWVmeDhNODFGaGRKbkxyUXlSMHVLQklyeDh4OEdjdnBVbjZC?=
 =?utf-8?B?MXZ2cnJQdmJ1U3l2bnVUanNDRXN5eDJBdjB4NENBTDE2SWxVazdiRG16bnFq?=
 =?utf-8?B?UnpIOEdGNUdabkhqa1lYbnhmbnRTREFRenlreEhkY0ZBQ3hLVGpCQkhXeUor?=
 =?utf-8?B?M2lDcmkrcVgyZGV0NzNiMy85REVRN3dUY3V6OTB0WWhJVEllM0tYM3Q1aEMr?=
 =?utf-8?B?VzgrQ3dNTEpmY3ErQ3UxQjh6enptdmlTY1AzSkdzcGVmNUNKZU41eExTU2pM?=
 =?utf-8?B?a2diRUpEeVhVSHZjOE92aG1GNGZRME5WMGdIMlBtOFJIUWZnSGgwWU9PSjIr?=
 =?utf-8?B?TzVjZWgyU2JlN2NUajdPWDhCbGFWVWN5ZVhBZFpDZmZjWXI0QnJ5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f3b48a-7196-4688-4465-08de70554cfc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 07:54:40.1921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNCQii0vqKRnSDyRpuhW55hrsB7alduJJkl5bhTWqATkWDtTkhPs25bLqPrZE1B5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282



On 2/20/26 08:52, Andy Shevchenko wrote:
> On Fri, Feb 20, 2026 at 11:09:39AM +0530, Sai Krishna Potthuri wrote:
>> Replace module_platform_driver() macro with custom init and exit functions
>> to prepare for supporting multiple bus interfaces (platform + I2C).
> 
> No, this is not how it should be done.

And how should it be done? separate file?
M
