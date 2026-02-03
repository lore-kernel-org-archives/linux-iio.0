Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25931AA80;
	Tue,  3 Feb 2026 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121818; cv=fail; b=eWGJq8eoQhvYTRDeBAOoqqJdbDCFDShs8tA+loDVM1V2AjI5jmS7nWlG+eBFmOA2oesUxYMlHJmvBB+e2Uaq3++LU8AqyMcm2Fo0r+dd9zD0O0eANmUgxWOn8kiaRQGOCjAJZn6y4Ii4eF5Ivli+2gRC3eVp8HCpYuupfWjnn+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121818; c=relaxed/simple;
	bh=Ab3k/CfhmKYzkRqXudPH0Hg1mjhfXTDufjHZhEdaKXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L7Cd7Uqr5NRARa+wnXHQCrxbENkC7LxYRyi9RknLpfcc/HTgJ5BP9JviYuvRX409tuagIo9/gtgffFlgv4zhGEpjjoWKgHvkG4C3egvaMgzCvfTNisx+BaMvLap+Vsm4YtbfGE/cheUCIBSkeJyWK3qBQJNl0uSyC/BTDAc5jgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mhGDbVc1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jioyQ85W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mhGDbVc1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jioyQ85W"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vFcj406471;
	Tue, 3 Feb 2026 12:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kU1x4ED8hwLCu0AwylEfYLJGuM9cx1CTjWYJ2lVGdis=; b=
	mhGDbVc1MT73LVacZrg1CaOtRSNPt0BiZxVZxK3YJtfJbUOxXKm9Ce30qzgkOH/Y
	sZad/N5CNfScMUeQR2E2dmMH+Hh/u+1t6yzsbEKOYOEeNNJvyLtRQqTiO9jOaBhB
	GBHs5huOEhZwN/e69lzdS1pNG+9wFcWxOwVnSrzB2l8IPjlIfFY/ksDcPziPAULz
	Nn2DTa+FUcSrzcBmV7LJzsQA9/jAMlYy3Cqbgj4K0/6+QJzRGpJ1AeIEx+NtYMv5
	Y43Mzvof73KBBYIYOG9AFDbhgTIizgaeK2QgrwtjZdYK0i1twDTD6DdzQyNOPJFF
	Y87MHbgmXjYBgom5pSV4Bw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1atmc030-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:30:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 613ARP9n025931;
	Tue, 3 Feb 2026 12:30:09 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c2578cf78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:30:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFhjMxeHXQB0OoNJzYbribLOuwXhW5ZgVpNKV9FntjMpUR6yfEYl2ILEMP8X4Ywsh/TR+jqFn6iMBo+wf8lULMJ/lrM1axtT50GBXr+OH6lSXHuSAz64zQbv/IqLqKcNOGi+3/Q8OyniSCt8FTdrZdHtZo6uMrxqtnWEunOl2Lvbiw71ryVkl/zOUxtdROhnmfhrUYUHZLY8G3XOMbUe1qMQ7/oGySOd3/U92KBkijug95YRv/WX8APYE4GSs3Oc9kjxFLZiWKWLmY6fqZXTHaXIX4/1LYABh6RBqGR+Q89WdnJBP/rk+loSr4Q/zBefYMRWU3V0I5suqWTtbRyPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kU1x4ED8hwLCu0AwylEfYLJGuM9cx1CTjWYJ2lVGdis=;
 b=tidItnILPo+04eHUefK7C/lgUHfMQv23kX5LBMV+7/PXFYLDb4Zv/sl1Vo4TyDLfo73p+t07D0UVYbI4GOs1lFt4R8i1iGFr/UVvH+PMTZ703XMyJukPBzgJ9LUMizckr8aaxdKgeHftdH0zVIX3bExEoCC2ChpMYUqpkcHSJTlb/kU0kj+r7O5XNiKPTFb3qJ4YsPrMyI6K79ZWYAnp98rycTh86j3y8aSN3BazT8par7LDHFcnvNzbemvEyF8JBrJL2RQkYQ6OxPhsXMxuKcnUjVptJoxxsSdQP2XpaRJjSu1cB9asR4xXmv5mLYhwvBaOurjjsi3UXxPLTXxazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kU1x4ED8hwLCu0AwylEfYLJGuM9cx1CTjWYJ2lVGdis=;
 b=jioyQ85WXK5cI4HSpTGjvAavnu+agrypEFXUHhx6gg2TV/y01aNDLru9g8EONZMVGpY5Vl+WlTedcbEJTgVf/hvdA60pcIsxIHpx7Wps+3u0AJFHpf+GaflZAY8ZldOXCljw/+MoKQlQtWbOOkmppXE4arLaKbnNT4n0OOEHxEA=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by PH3PPF077CE0592.namprd10.prod.outlook.com (2603:10b6:518:1::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 12:30:04 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 12:30:04 +0000
Message-ID: <f0618efd-4577-4082-b1f5-76d77dbb62eb@oracle.com>
Date: Tue, 3 Feb 2026 17:59:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 next 4/5] iio: sca3000: manage device registration with
 devm helper
To: David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron
 <jic23@kernel.org>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
        andriy.shevchenko@intel.com
References: <20260202194033.627967-1-harshit.m.mogalapalli@oracle.com>
 <20260202194033.627967-5-harshit.m.mogalapalli@oracle.com>
 <a5fa2f97-9ba3-4085-bfaf-a255d24a81f0@baylibre.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <a5fa2f97-9ba3-4085-bfaf-a255d24a81f0@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0254.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::9) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|PH3PPF077CE0592:EE_
X-MS-Office365-Filtering-Correlation-Id: 549a84dc-6bcb-4dcb-298f-08de631ff507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUFXVzM4ei9XclV6MkxEa0I1SmpIRmlxQStKUXI2TVNTVy94VEZNM3BJellB?=
 =?utf-8?B?VzN3bTkrS2xBc0ZFeFNIOUlYWWx5Q2NPcVNWUUdHYmF2bEdoU1grTEtSRVRu?=
 =?utf-8?B?ZzVTN1U5TVBOMVpweUNzMDNBSlZlWWhEYzdNSnhaSjdEcXg1c3lGRUtNcjN4?=
 =?utf-8?B?U0ROc2VlcFhTOVBpUFQyYXhyTnVwZVVxcXpQRWtWV3RodWV1aDVZMVAweEkz?=
 =?utf-8?B?V0RZeTJ4ZVVPVFNVNWZkN2NFeTR0Q0QwN3FEQ0FEUmduSVg0MThlcm9TR3VQ?=
 =?utf-8?B?a0hWUzdiR3IyamdubzIvTUQrclJ6aENydkF4YitHeGsrRk5iVHdmUWtZUmZu?=
 =?utf-8?B?RnF5aExMZVc5Q1JBcndzc3VtZkRoSy84UTNvV2UyZ3pkcUtQMngxbDIwSHQ5?=
 =?utf-8?B?YzU4MlZhYmFJQWV3NXp2alFpYjRzZFVTeTBxNHgrNTUrbTFDZU9Oa0VUS2pj?=
 =?utf-8?B?QzFNNE0zQWxyVU5DMUZPQkt1azJ1dVZQTHBoNFJHVTVuN08zR0c2Q01DZlFF?=
 =?utf-8?B?UjRKdktXOXZORFVDTzlpVEpwMndmSzNPMk9FT2FpeGZWdDlYOW43dTlnamwy?=
 =?utf-8?B?RU5IWmxwOVFIaVRPUjhuTmF2SGMrQjRPOWE5ZnBpTkxLS25SZkJuQ0k5OWk2?=
 =?utf-8?B?YmFsZU5KU0NNTjNncnFoR0lBQ21KTkJWODhXNCtaQWNCY1lxeitOendnNDdQ?=
 =?utf-8?B?V2ludjRRTmxhVDN3c0JvZ0Vhd2x3cEdaRHNGNS9QMEIxbVVVbllRZGdFWnFs?=
 =?utf-8?B?ZG9TZFdBSjRhRjdRWUxYMEFUbXh4WU1hQmUzb2ZETGNkQmx2RVpWcm9Yd1RP?=
 =?utf-8?B?VnFXb0tGN2I3TXBGTHpGUHcxOHVMZTA5S21ONXpULzhENWVUd2xVb1NTVmQ0?=
 =?utf-8?B?c3dPTlN6UEJxSDBTZFVqVmZTZXhlcVBDUmYycG1JbSs0ZzlJYmNFbzcyOTJ3?=
 =?utf-8?B?ZHduU0NvbWtObmlnZTE1S29rY3FBU1B6MDJ2V1U2d3FJNnRqT0pmVy9kUkE2?=
 =?utf-8?B?RnZFaWJvNHZxQy96WmVLRW55WXNDN3h5NXNQVkVxSzZqZTV5cC9HOWFhMUFV?=
 =?utf-8?B?WE5mODBHeVBRLy9vS0NiY2ZadDgxYlBLRk9ndXRtK2Z2MmpxblFKRjNuYTZr?=
 =?utf-8?B?Q1Rmc0RyTkxjMko1RFpHR3JoOFhkME41L1hBTW0yNWxCaTExZ001d3BXR1hP?=
 =?utf-8?B?UXZQbk4zdTF3emJrYVdVOUZvcW9QdE1rbjd1RHQ5VDltZVBuamhnbWtyUG9k?=
 =?utf-8?B?Qkp3Y2U3M2VTYTRkRjRnd3hua0tPcXJzaXBscTJCMXNFT21jc1FjU3BmOEhl?=
 =?utf-8?B?SEFNTkZLZUlxMzlzNWZSYnhFdUU5bjQvbFVBMktzd3RVRzc0U2Q4RWFpSmxs?=
 =?utf-8?B?OVp4N05FYmEyMS9DQ0FPQzg5QUowTUhYc0ZWam9GQk0ya3JqUzFKYmQ1K3Bm?=
 =?utf-8?B?QlpMcVp0U0pJcGdCSWRZK2EvbTJqeHFuOHZXTU1QSnNFZk5SUFJoaGtJTjJD?=
 =?utf-8?B?cFhPeWMvVWhHMnBzblJIbFdNc0pobThRaVNWbmR4KzBab2tXSXFlNFVyNTB6?=
 =?utf-8?B?WURqRU80TVhnUy82RnF0SGg0WC9DbEtiUFhaUTlqa05ZdVJYcU0xR2t0MDZC?=
 =?utf-8?B?cnFUajZGQ2swcHB2NDFlU2tLOGtZYmtTa3REWEkreGs4aHBLbDMrY0ZTcGpY?=
 =?utf-8?B?cDh3K2dCZUcrazFoUVlSOFlLajN4OWc2OUFMOTF5TllZdEorZ2JBLzR6UTIw?=
 =?utf-8?B?YW5uRFREZVY4WGFaZjA5M1hWcVF0cFpTeVhWY1U4OUZOYjY4WE9JVTRpYkFU?=
 =?utf-8?B?SVVvUS9WYUxUdmVEOU5VUGtCSVpHSi9waTNXTWZvRUlNMFZZUUs0WjAvZklw?=
 =?utf-8?B?ektIRXRPRDJjUzNhL0JxQ1Y5bVdwOEFaVlpxamRreVFTWFMxUGRuQU5FcHJy?=
 =?utf-8?B?czdZRWhpbTdOc2hNbVFWd0ZPbzM3ZGNqQnlUTUQ5VGFmMzd2bnBzWGhyMTRh?=
 =?utf-8?B?R1NRUHNnS2R3UHFCSEpJN2dtWG8xWGc2STVtNGxRcFNteWNtVXI4cXBHNEkw?=
 =?utf-8?B?TUxVc254a3dYekFreXJidzFHK0xGd0ZtVTM4K1BCUHNpY1F5aDk0TmtMSnFS?=
 =?utf-8?Q?ssx4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q21qNGNiL3hqSjdqMWE5UDhZN2FlTkwzL0dtdHEyL3FJeGxlNm9YNkd6UHgv?=
 =?utf-8?B?RlVwTFg2UEp1L0E0V2p0ZHhRS1RCSEd6UHE5YmorU1VVRUViOFdFcjhmT0VL?=
 =?utf-8?B?eVNON2d2alRpVlN2b1FZUXJlSVZHYnA5RHF0Wmo5RTRQLzI4TytQMkx1YUFK?=
 =?utf-8?B?VzZTRGlZNWE2TFVWRFZXNkZRbUwybHh2R0VUMGZVVFVKTjYxb29xQnZscE5N?=
 =?utf-8?B?THo2eGZXdmlobjg0Rklaay9ja1NBNFdJSWpEUmlrVXF2c2lCS0FMKzFGOGxo?=
 =?utf-8?B?K3gwb1ZKVzdPMDEwVVN5UWw1cTBLQmZmM2w0QTV3ZlZjWjNDVFJrUDdtNjBJ?=
 =?utf-8?B?RDZTWnV1cFBrSE1Kby8xQzhyRjhOaG9jdUVuVmZrUWxEOXRKbFIrb09OYkhh?=
 =?utf-8?B?OFhaV0huN054RkFhY0Zwa3BLNy9ZRVZYZDBERk5oSVNxMnFYNUtwSkJDQnpS?=
 =?utf-8?B?RkFVUWswZ00zZ3RQZmhmcjRIS0VpUHI4eGp5WDBVaHJ4UTJWeGZMYkZtd0s2?=
 =?utf-8?B?cGxsTTVHbDBqblYyMVhHdkRTZ011RFdYd1RkZFhqQUlQbEorM2tJL29lcVpx?=
 =?utf-8?B?dG9heE0zc04wZVJ1MG84WjBVVmpmaVFXNmIyMExjeTJTN0RMNTByak9sYXZO?=
 =?utf-8?B?SWRNZTduajR6K3ZHaWkyZmRQNmhLMW1RVUtzbVlvenFLTWlSODVveGtGVVVG?=
 =?utf-8?B?UTBkSEdiQ0JWNjFYN2xjaGoxbGxXYUU1ak9UQWJVdkVCQS9BeDlGNURvYVBs?=
 =?utf-8?B?YTROZ0RzeFg5MWFkdGYyMmJyT1dBKzdBbGpBRVozVkV2TlNROVdiQ21wL3FW?=
 =?utf-8?B?VnBtMi9WU3RlSDE2bjE4Q09IeVlKRjNCajJGUks0MHRBbHBzSzVXZklBWS8y?=
 =?utf-8?B?L2s2TjNTVlpYeDQ5Qmh3dy9tYzl2S0xiRTJlNzRJZFNnL0YrZXRzdFlNNVF1?=
 =?utf-8?B?dVp2NmhjNWNjeG5WZExHKzdyZWFkMmRTMlJxUkRUa2thNlpTTlRoWXBlNWpY?=
 =?utf-8?B?WmZHVEVmOVZvQ3ZFK3JjK01PQjlKM3VBZ3NLdmdjWDZBQ2VmSE12OERLdUN4?=
 =?utf-8?B?THhuSXhaa0QvU3YyRTQwM1lQMUtuQWgvM29JWlAxZG1lNm82VktDeDlGT1Vs?=
 =?utf-8?B?d3NnYkNkUGl2d3ZDckpqRk1Hd0tORHVCejc4dFpDMjRwcnFBaitVeXpSYWRG?=
 =?utf-8?B?MllrSGpUYWh4OXJmSy8vUHRscUdiMzRFQ3BxK0pBaXpyNzNRenA0SVFrbU55?=
 =?utf-8?B?ekxSV1JBcFpKenAyb0dSSXlsTTl5MGlJMnFnVVA2SE5pVGFSbkRHZVhpVktp?=
 =?utf-8?B?MzV4V3Y5NGZJVFpsaTVsV3BSS0FreWxpT1I4aVRKVmk2cHpoTTR5cldZUzZn?=
 =?utf-8?B?R3QzSS9HWjNjSk9vZjVBNjhYL1ZRQTFmbk1DZld0K0NkRGczTnlzZ09VTzJT?=
 =?utf-8?B?cU5EbTFMNTV2RlRxSGZraHF0T1Q1cTY1L1NuOUsrdDEvMmI1VmsrVUJJYkpl?=
 =?utf-8?B?R2h2L2dia2hOd0M2dVpTM3ppdEhIZEZiTTFBcEFlQW0yR2NHYTFLY213b2x2?=
 =?utf-8?B?TllxUHU1eDltcGtHMlJNR2o5K04xWldqbGszdElsRjBEQkVyMnk5dFJqWVNz?=
 =?utf-8?B?UkV3OWlxeWtDeGJVN1ppVmhTYjdxSXh3MXdjQXExblEvSloxTmpKdStNWnNI?=
 =?utf-8?B?OGNndEhWRXNOWVFRMlVMOXZyY0o4MjQzNVo0b1c2TmRVSkRVajZ2Sjc5a3dk?=
 =?utf-8?B?NDRZQnl4OWRUUUIreVgxYVlTVlgyVXk4OHVyeklvQmhKOXVZcHNXaVdzNTBP?=
 =?utf-8?B?elkyOEFpQ3F3RitWdGtHQlllVVhZdks0YVk0MVB0dE5KeEY3UDVGYjFRTmZz?=
 =?utf-8?B?dHZzLzFRT0R4bWxPVmZ0SHdzcVVZenlXc1NtV2VwRGpWQ3YzNkR1UVI3b0ll?=
 =?utf-8?B?VHRaRTBtd0x1TGdDMlhaOGNjbjZ3djAxMTJzYmlYdkN2YXZuSUJYOTF6RnU0?=
 =?utf-8?B?cGJMSDU1Um9OUGZ4QXZEclB0cVZJSTA1Z2g0THF4Q2w3cXB2M2l6bXZiNGJV?=
 =?utf-8?B?MUIvekJyWGovd2JDVXNHUUVOVTlhMXpBWU1aUUVTNE4zVDNmOE1ZYVRob1Zi?=
 =?utf-8?B?aXh0UVpmR2t5dGp5WUcvaEJuUC9jOXpoV3VFZlU4dGtSaVpvRm5lUVN4dnZJ?=
 =?utf-8?B?NEJHcCtGZEllZTFBa1ozdUMvMk9ZVjZ0WXV0QkcvNXdNSmFjbDBYVlQ4eHFY?=
 =?utf-8?B?WTNHbmtseTlUTG1Cd1JSb0JvVElGalM3UnVEcFJKbGg2NUVzdHVMMGVEc0lp?=
 =?utf-8?B?VFFYclF4TlpBbi9HRDl3V3BRSlZKdlA3MzFlMXFkVDRMN1l5ZlZrQW5mVFNP?=
 =?utf-8?Q?Qa1IhjjfPHZW6vpxkANFfzJhNvbFReJIglWsm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RLwa3HKktzKL9LtpmLFCpv5S1vpPUWmqo141B8Xaj73GfkoCxsAbDV8o2CLehk7hx1jF3FG6gRNjVp6Wj8ioT6fzwyVgjKobrq8UM4tzIYmbXt8VoNIbwd/JbqvtXV/d+OJhIN0gMbBXzic0jaf4qpBAhsvMZ3oRXGgt8Sx74n4Amim9H92jTP5nM1OlhqhutdHS6UAxDkp9qdaC4bxykCxbXn0dUlyQ7k7gAzz5Lj5HJOL0icm9qsAkWmgPT4vySn2aXI7phvHfMVLPzdXZBNWKr8Ja99HybNwHAHs6vvDSWHp1K2wG5/PvyLNHhJPVXfWN/Lr/Cx0hNaIblCMgyugeWtjMC8Fc2d0colzYxT2mftSXUsSyaKF/EuEiVuYgkf9jm9265O4xw26AhT1OJ41UTTZfiv5EPNt7KHacJ2SqQF5ox2RTZ2OgQK570nWAKjuGHvm42sfDO6t49rluD1z9+UpIWgr3aXwkVxc+klMrLlfzyb4APPU6POEQKBv8xCjisHwZn8QFERcUlNatAwF8D3eh9xkrsJsuRJEHEfW5DHJcz67SHZYwSIkYRxuEtn1Bj782YKInFiD0+i4e6aN2v0mvr/vwkL5gXtNPJ6M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549a84dc-6bcb-4dcb-298f-08de631ff507
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 12:30:04.1116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcBILLUuVvgRL0YFIRMJE9O85Gyo0nVfQlGCJvAntQGXiggDZzVB9jxpcbaFoTw4cLidWGzsG2DvBVNi9+j+ZvNPF9EJk4i3/kVEByHj53MHdcyYsgamEAbZxcHfPrxt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF077CE0592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=936 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030099
X-Proofpoint-ORIG-GUID: e2OxNKkn2E_Zs9xU0IQ5z8Mkhgdblrcf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5OSBTYWx0ZWRfXyXtbiyJN4HVY
 mnlRwu6lRcXPF34nnZdlJ0jre5EJHzdUO1ZaVbn+NVmPshKOIIri5ms6GtfsEe97U1MaOgP8w54
 BXIJdtTKSza1tB3qKguzz2T5wm7OMux7ES3KRRZ/l5cHo+SoJL32R8Mhf1M/P2iUckGubkhC3i8
 uqHSW+PTGHvTC7vt42Bp06rsrojUyfCbunei2R2nhAZ27XroWQo03lEAf06viAPSMPYFI9qzLlq
 eya7ibyhEePLetCJI/YC58HZkxo15LJ2sdiIVI5NY1ZTL/7CaMXfjpGn05GyH2w3+mLM+l3c5tU
 GTqr27udVyfeOY0DuW87gql+kaQxc++9nJ3yf6CCLW2g9oLIAgpns8mzkgfdj3XPP6FE8gaCN7B
 I6k7Ut833o3RYa9uDjcjMgVwWgZ+9NW+i65q6XV/BM/Ff64Wc6JwHYQBvFRwG9IGokv+QpqCSQD
 LdTcH57Zi/G0R3zqa1g7IsSLsAZTYddiwtn2F0aY=
X-Proofpoint-GUID: e2OxNKkn2E_Zs9xU0IQ5z8Mkhgdblrcf
X-Authority-Analysis: v=2.4 cv=E+nAZKdl c=1 sm=1 tr=0 ts=6981ea51 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=AKfxoly6AAAA:8 a=CXczhl0Hp333_9DZdrwA:9
 a=QEXdDO2ut3YA:10 a=4Q71d_afUUiBcdzZNBSr:22 cc=ntf awl=host:13644

Hi David,

On 03/02/26 04:37, David Lechner wrote:
> On 2/2/26 1:40 PM, Harshit Mogalapalli wrote:
>> Convert the iio registration to use devm_* helpers so the probe no
>> longer needs a separate cleanup path and remove callback can also drop
>> the unregister. After this there is no need for having a remove
>> callback, so remote it.
>>
>> No functional change intended.
>>
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
> Reviewed-by: David Lechner <dlechner@baylibe.com>

While sending v3 with this RB tag added, I found that there is a missing 
r in baylibre in this and another patch.

I will wait for the comments on v3 first before fixing this.

Thanks,
Harshit
