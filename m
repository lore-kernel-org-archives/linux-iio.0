Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C950F35975;
	Thu,  5 Feb 2026 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770322234; cv=fail; b=kIQCo5+mNKXLK3bKrKDnGZeWqDJ4b2GtGPcRSe5OYDsw0HKgzZkorq+qzAChmrUyfx7Dwzr3JZIosr7y6fX1T4+9aMnQ31UeC5m9trGJ46U73udBNo6SIgOiuQCpAaUsh4hRgq/2poVsCX6We8Qb8ESm5Um0V9hN0e0cI77q79s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770322234; c=relaxed/simple;
	bh=I8jPCqCVuZZYBtyBCxF38fkaK4gAJv8yERBzDgiMJwE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YjowQ/x/I5IvurZl+I+aYX1YxvzvZAM7ycv9X76mYmvsaSbmmiYKVlszYQvx7RV+58gcfQRo34gQTa8G0NAphPNSQxmtyXnQyy37cur8pdPq/EfbRebARwB0CsaZXPyFK+WkcxkZD+NHHtwL6K8+Mmq5WqoaoEOvDF0mRuNyXeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hfO90bmS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RtSME0Z7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hfO90bmS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RtSME0Z7"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615IkYkf1183201;
	Thu, 5 Feb 2026 20:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3YPXw5ODpsjTyQONWL9UlK0Z1e04cfHE4RIoTBsB4C0=; b=
	hfO90bmSyv38iAFEozfyzGV/89rGojd8wQG5GNrLjdTv4H5BRZoPvIh1AKX4uoOx
	YqualjaST55/tmLUeeDOO4XlSwagVKE8qvTuT9edrq+ejZyiUlQwjwXWSarWB/4M
	PdU6+BPAMJx/dZLm54Fz5jH8JTlOU5APjkQ1YR/GW1noBdizuRINE9T1pSH7VqKy
	Fofdf/NQ4YXgV2+XPqNcSMjaWn/2/LmSSSJ/S/0emU/DZfCQXdgPwVhb0u00QHXU
	C1r/23znQCdj20ykq4i0Kt06vkCZ0DsFZ3SCih5IXHAlgSJdwlUVLC5WU7G1iu62
	PbBKUTGtfEszZKMYV9Yofg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c50sg85k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 20:10:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615IHx3F005684;
	Thu, 5 Feb 2026 20:10:20 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c257cbae3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 20:10:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMIkvSTVOFa4f2Zn9vSenrcdwpN5nalmsb/ToDtR/NPbnYgmfaJ+UUoF9ZGIvazeB3jp1wKR0Q9JXPOBqSjoNVnOziQZ9eIsrs6vj09qxZRwmDDMTNK5Se6KI1uhhMkjUxDG27IXp9BJGP7SfpfJi+3Mkqy/hfQ6S6vxz7DoI9NmbEX7B5mDmVIzFd1Y/DALYtBLzgUk375yHdTDOGXYo1J2KCevbfNgHLqUo2V54D+oDFBm9Evy5/dy6npygtGrEB1fmQ75MlnxNJ1fFRKP4elg5ByCvP/40EoSNyd/ujrKjlecBhXsVMcLZgfsmUMkZmUN75puHpbUXbj1hIoaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YPXw5ODpsjTyQONWL9UlK0Z1e04cfHE4RIoTBsB4C0=;
 b=L+iUoOivpIQJQWsqQuI6esGBxYNwUEzArAnyU8jt3qZc8ckgX5KwJKa3w6hAvuYt+Hh/IWAlyRQJYLFBQBV7Mh08aarosVN5kNDvRnPjy1Spbk4oUUhX22Eav0PyA14Deaq/CrH5UuAtdCYfCmwt86CDQNfvUa4lKR8/EP0sBm8SZQsidaAniO3wu32w23lOstV90DC5mD7E2B4iFlv6MymMJgr9TO0YKOS3ElWV1UWGDnS57JypTyyp1HoMLf7kFstP/Wsz7wkg+wtPhpcgIk7SQsjhGcHe4fU+lU/1ksX0TSkHhyeuFfXVliSGyN+Ju2PaMTDUaT55O8nw38Vaig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YPXw5ODpsjTyQONWL9UlK0Z1e04cfHE4RIoTBsB4C0=;
 b=RtSME0Z7rk8E++nFdrYKdS0MsEl2dIbAm5L7mvUI64JajBCeNjsJYQ+fN1tVAK7SsEGUKqdPf3SogM5L4nELTT6GSPfS4sU4VYjLnhEp6YFGi+GdJWT3xsJwYlbUztggE/tdnerAwpelQPAqFgzlsh+g5n1kwJ3wfPVF/U9KiwY=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by BLAPR10MB4963.namprd10.prod.outlook.com (2603:10b6:208:326::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 20:10:16 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 20:10:16 +0000
Message-ID: <4cde9a0b-96d5-4420-b50f-bc4e58425241@oracle.com>
Date: Fri, 6 Feb 2026 01:40:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 next 7/7] iio: sca3000: manage device registration with
 devm helper
To: Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        David Lechner <dlechner@baylibe.com>
References: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
 <20260205131234.3244467-8-harshit.m.mogalapalli@oracle.com>
 <aYTFUMe3jUO_bGCr@smile.fi.intel.com>
 <34bac81e-6a6c-4cf6-b370-beead4f705c1@oracle.com>
 <CAHp75VfSYGoNUTqDb9WLYNYeChkB4mM+LEBpyRVnLOEKkr==WQ@mail.gmail.com>
 <437592e6-460d-435d-bd83-7ff8222a6130@oracle.com>
 <aYTPkt5jKoX3X_4i@smile.fi.intel.com> <20260205195845.4e108117@jic23-huawei>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260205195845.4e108117@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::35) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|BLAPR10MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f95121-d34b-455b-101a-08de64f2945d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y09YeUdSWEsyM25oYXhrTzBFZnRDWnFlQldZOHlTR1JoSVArSlNOR1V3YVQy?=
 =?utf-8?B?Z21VRlRwa0ZXWW1ZdWN6cG50cUs0UHl0NUxSVnZPK3I3OXV0VHpyNzgrVmFH?=
 =?utf-8?B?ZThqQSsvQ0dxZ2JsYzVYUThVbkFXNElPRDN3anR2VGFHZERXaC9rRGpXdGxo?=
 =?utf-8?B?S2lsWGtpOVZHSkdlN3B0R0krcHBzZHBkbjN3TURrVkhaVjYzTlJVckx3SWhZ?=
 =?utf-8?B?eWFtQ0ZCZ05XdmU4NUpIWllFMXBaQTdidDRlZGRGR3VPdm0zTzNkL1lDL2tP?=
 =?utf-8?B?Ri9JUFZZVURiRE9sVXBqRmtESmIySmxQL2dJN1Z5bkxjcXAvV1NTU1MzbUlv?=
 =?utf-8?B?VFVIT2NpQTUyWmpla3RDbS9Nemx5eEhIMDdxSkt3V3o3a3NYWFBYQlowVE8x?=
 =?utf-8?B?MnZpTXN5ekF1T1FBVldVY1FiRTkraDdMZzQxalRzU1NwZjhHTUJmbDBibVZn?=
 =?utf-8?B?RjN5bWZzYjdPSGcxVGpocEdXT0MxaUNqcXd3VzkrVWR5NzJYUmxlb2tKSGtU?=
 =?utf-8?B?cCszSUVwU2F3ckMyN0IxYkFDeGJrdVdhcU9HVmh6ZlJ5K1FJb0kxSzdYVVdP?=
 =?utf-8?B?NXF1K0hVN2w2bFMzYUVlbUZoYTg1N3oreVAyRnR1cngvRVhHYXdnaW5ja2Q5?=
 =?utf-8?B?cUhmWmdBK2VWSHRndmprOW0wYVVyZmJLZktzYnNZMFRlZlVUUSsyNmNRT1Ry?=
 =?utf-8?B?NDJFM3ROS29GdWVqbk5XRThObXV0eENzM05XOUVsK2FhM3Fzbmk0Z0RDdzdF?=
 =?utf-8?B?SFg4R0doQ2dHSEFoai8rWmpkRUhhMFFlMlBlK3R6aHF1MFhHQUY2d3ViaDJh?=
 =?utf-8?B?RUdaZCtXSkoyaHprQ3NmekthN1lOK0Vja2NzWjdYK0syWW1BYnpVN1BYSmtU?=
 =?utf-8?B?OVdOWnNJSzZkOFdldkRUU05ZTW54RDZ1ZEwvcG1uRW40REVLcHVwR0p2OG1v?=
 =?utf-8?B?THpOQk80bGdsZkxlYVVnNklET25uRmRQbHFwK3ZmQnF6dkVMa05NZHh5eG5R?=
 =?utf-8?B?YXdzTndPK1oyclQ2YnhYSFRnOGh6YWRFdlRISi9ZRDZkK3lCRUJLL2FsWGhn?=
 =?utf-8?B?Z1JSRHBxM2JocWtjbjd2cVhrNXV4ZE02RmdOSTBjemdvQWxWTTZQQ0ZlY2g1?=
 =?utf-8?B?Q1J3elR3TTg0NVNPaTF5TXdwWUcyaUFtUnRvQW5QWlJGek5iOVdrbVFOY2pP?=
 =?utf-8?B?cFVHTFlsQUhhYlozRm13V2RuRllNUkpLeFBRNGVZcVFLL2FlNzJpbWxvTUgx?=
 =?utf-8?B?QlhwTEgvUXZ0RXcxRDZTOHB5b2dOcXUyc2pQcFJIMEd5R1haUFF6cXVoMkE3?=
 =?utf-8?B?cE5YUGYrOU96UXdIWEpXZ2ZPODQ4M2VmUDdIbFp4NTIxZUZUcmlndlByS2Mw?=
 =?utf-8?B?eVdhdTlLNmJvL1FrS2Y3dHkzQnRjYm9RMHcreVRCckJGNFRSdUVOY2xtVXlW?=
 =?utf-8?B?MjUyYnRtUTZOV2MrckFMSUNIMlBaRzlHUCtwbVo2c24wWm84QUhqV0RKN1NV?=
 =?utf-8?B?eE05Skg0MmdhVzQvK3NURmJZanR6VEdjK1ZkZ2J0TXdadVZNKzBBS1pWcmhT?=
 =?utf-8?B?NHBRbEZLNTJXMXpwMk1vOGtNYVQ4OThFMlZQL3JLcE1wK1JVa244TUNTeW9r?=
 =?utf-8?B?eURBcG9YcXpCcllvWEtpZWdIV3h1c1Y0QlFLblZpVThzS29Wbk5rM3ZMQ1Rk?=
 =?utf-8?B?TTVzcmlaenpObEtBNlFNOEptM3M2dCt3UHBsZk52dXptaUEyMGh1TWRQS1Nx?=
 =?utf-8?B?SHdkcmliTnNKT29mbUorVkpwY3ZwQUFid1lLZ1ZjQjJsRlBzK0xaZkJIRmdr?=
 =?utf-8?B?Qi9GdHQrSjdXMmJ4K3FVdVhtMHo5Q3BrWElPT2xPNlhGRjR5K2xkMTF0SU0x?=
 =?utf-8?B?Y0h2REhzdE5GMy9zTUlUOVNidUorTDVCUXNwU0RLMDYrSmJrbDFlUDRCVmoz?=
 =?utf-8?B?YTBJcDVHWW1kektkYUpmUnlRaCtINjYzYStkTlBhWkJMdzBKN3dDRitIWlVK?=
 =?utf-8?B?M1VMM0xOZjE0azdHODI3aEE4dzIvNDVHM2NsdHJaRmFkQlBTSEc5OEFieUtV?=
 =?utf-8?B?OGo1Q013eVo3R1JVdDUwS1hNOUhQSmRwZTFlb3pWNjRPeFNvaU5yVHNJRk5x?=
 =?utf-8?Q?OKEs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGlvUkljUlV0Nk1sV21VYWdGTnljQXJkTEVwM3pMQSszY2xTWExadG50Qmdi?=
 =?utf-8?B?cDg5djg2MUZHSnRYdkkyd2pDanF0eUMrQ0YrWjdkNi90dW8xVmU5ZHpKdzZQ?=
 =?utf-8?B?Wis4em8zYU9Oa2Rxd0JLdmRpcmVZOW1ldEJObTBmbEVWUWs1aUlva3lZeTFF?=
 =?utf-8?B?d2twUWxwNEVxNm9qTDV5MUNJTm01ZVYwWGJ3dXphdkNJSTFyaWp2UHl6Wk1i?=
 =?utf-8?B?K0VyVnhkU1RNVGRBZVdpUjZJOGdHUEVFNDFGWkJTWFR2ZXdocGhRbzU2Rzdr?=
 =?utf-8?B?aTg5TDRtM3lSSmFwcnYzOHFjdFZoQnV1VWtKaUpXVGVUSkxyMkI0R3F4TEgr?=
 =?utf-8?B?RjVkekJUUVlxcVhYVmR6TnRwUHM0cEFvem9oWDdTUTFCai9xNmVnVCtQMGJV?=
 =?utf-8?B?Z0hLYnJkRnpiU2FJcnlCdVd6TXlJZE9MemZOWkVHbUFYeDNtbElURmsrY0Mr?=
 =?utf-8?B?U1NNTGJjL3Z2N0U2SXFpOFFrVWpXVWxZWmUrTTZSM3JKNEVYcGFtZmRUazVp?=
 =?utf-8?B?VTZkY1UvNGlITkNaZmpTV3lvV2lHUk5GRVlCMFpmYllSMlQvSG41a1ZQdXZV?=
 =?utf-8?B?N3FuQUpGV0Y5Y3ZzaEhpYzRPL2p5NHZhMnUvd3Y5MHIxaVFoZWhhZXAxd1pz?=
 =?utf-8?B?M3VhblVwMVRCaHd2blo4ZS9UaG1ndmttUElTZFdjdTl4cXI1cXlmSUNhazhT?=
 =?utf-8?B?ckVNS082SDBFcXZEV1RhcDdLTzhCTElwREd0bkNBOGpqWVRYZWVMWERRRzlP?=
 =?utf-8?B?ZmswSkwrWU9vZ0UxaUJINitsR2I0MGQzUnVyVHl0ODlXSXJIaGN4cjVPV2l2?=
 =?utf-8?B?Y1dscjZUQzU3TERxeEwvVkFDcHpPNXJOVThNSWlSUjg2Z0dIeVk3MWtJeXFs?=
 =?utf-8?B?TGFjVENhWVBYMW1SbEtNeXRaNmZEeFhNOVhGQktxUUZUTnFGZGI0ZDBUbTBD?=
 =?utf-8?B?VVFTVW9TV0RpQXRIK1B2NXBOYm5reEE0T2hsVEpYQnBxYW1ZMFZOTjJ1MkFQ?=
 =?utf-8?B?NGwrcTBQenYrUUNCQnRvYzlzK2ZvQ1dWWDNHeDd4V3VyMS9TZGVmYmpYZnRk?=
 =?utf-8?B?MXpsUEJUOUpBUU9WQ2RFZDhITHpyR0ljbXlVZ1pmRTg0SGNBVmNkUXFCcVVo?=
 =?utf-8?B?MFFOUFlyT0ozTnRNTGtpVStnSkhDMUtIZ0plU2F3RGxnVjRKUHRuOVRnYk9l?=
 =?utf-8?B?dGwzUHZjN3psVzMxaVlmT2hTQm5TZzJWbmd5RDV6Ukdack9xelhrN2QrRThQ?=
 =?utf-8?B?aGVqTTFrUkV3bmlYNEFNVzlDb3c4dW9veklvN1EzZ2JXTnlSVUI2alNaTmZ4?=
 =?utf-8?B?UXZEODlsa1pKL010NTU3WUtybGlvZ3F3TGszMTVpVlR4MlJuNlVnYmt0bjJH?=
 =?utf-8?B?eWhNR1FUMnd1eW5yQkV5RWx0K2xXcGNvN2dpVzloSWVuMlkvcTdmMWVuZnBQ?=
 =?utf-8?B?UlNHMlNCVHg2MS90b3hYM1VlaXpENG0wZUpkKzFVa3d0UDNEYWRFck9BN21U?=
 =?utf-8?B?b1Bpek1TNXY2WmJBYmliL3lSVkNFbWtWTm1wSk95WkR6dk5QY0tDTXBkRHpG?=
 =?utf-8?B?NXFFeGpkOU1MdXRKeHFsK1dzWlk0QUYyZ1F5Zkg1Mm5JZEFZQi9aS2htaS9W?=
 =?utf-8?B?UFlRTWtUYUxiTWgyQVlreWp0RFlQWjZDUGRUMUZqMWVRWU9DVzcwV3BmQXZI?=
 =?utf-8?B?K29qMy80TkJpMDY0VlBOQUR0SmlCRUNFOCtNZFE0cTdmTDBWbTNMNmFGcFRU?=
 =?utf-8?B?aC9tMFNMb3g2RGkxQ05GVVBKY0VNVWxpYXVFZUEvaHdJd2ZVM2dmc1Fza2ZM?=
 =?utf-8?B?cjkzN0NLNVNMbi9HNWtlZDRSci9OeUcwSXpnM1VFakl0djRERGFXbzFsekl6?=
 =?utf-8?B?TkZoL3I1OHdLU2dlQVRJcmU4Rk1McDExTklJRVM4cjZkbDRMcS9VRmo5SzVq?=
 =?utf-8?B?MWZUb04zODJnN2QrWEhEM3pmTHNnMjJ4bHlLWUx6SUJkTzFJTTh6azMzVUdo?=
 =?utf-8?B?RmxDSGhMNnpIR0g2UG1RdW1kRHdVaHJEcVpGaFI2cnJQN25IVXZoNzJ6bWZk?=
 =?utf-8?B?S0hJTk5EQUpsSjZFMEQxU0s0aURGU0E0V3dPMTMrSnVmREtxbnNuMmd6emdh?=
 =?utf-8?B?NzVMZEE5RWZqZENVY2dObTJmTU5wZjV4VURJQXVxSWRVNUpiY3V0c1QzVVY3?=
 =?utf-8?B?a2ZOZ3RqQXBwd3l3UnhxMnkyWmxFeXNvMXdFcTlsd2J0ZVNEMmZZb2Z4aVcz?=
 =?utf-8?B?NDEzRzBnbmNwbkVSbWV4NnZEVytneGkwaUMyemlianp3bTV1RHU4c1NsZWhL?=
 =?utf-8?B?TkVWRGttSFF1VnBWc0dpRXYrajh1Yk5HdWJuVDJQQUNjb0RPSmNOQ2QzSTY1?=
 =?utf-8?Q?K9olA+dUFPNmJM8dKg3iHnr9to96b+KnKHjxu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3b3A7rz10lutQ6qjqmev/viuA0G10PlzTyVghSKoOI+XhGrS0O3ozmrbpPEwXHtgbnLhn6URqX+9NoYUfZ7H8NmSAdgE3kSy9xKTbCWhM4h3cZg5Iq4DITONlu8/4Aec003f06lIEl/ruk1lNF5A0+BkIjmoyIKpPz/4hEkjobGDtoXcGupV/9yCdQA+Mo+L2n90Uz0g+ZUhDCoDkHAo6h2drVR5gyLe3ZvoR0n1TzLTUEMK9bW8yWUn8cKndqOHHLgVRdbWHwp3TepBLykwpG6E1tqIFZpt35mk0OD6rva70oia+zyWGSHWajEhTtXTJ1SNn+01JYMGAqNCBa4C0qXkCHkznuaBAUycUxx90RL0+ZvEGxvL3nYp81EW1EKXJqpSzHTizKyjh6YHVEXuMFUmjSYJ1FW+5ifHrX6sQBFut5qtLN801XVOL2ZnnixWhCHVu4een1tjt2IaZjm/mtVgeyO9ZcTelhCezWT1tVU3gd1gXrnUXoEDJbxv/RzuoxEFUFnAJnYvaFQeDrFQtBLelJeiwRx2xuU1AfpyAdPHFKq6E3EA5lgv41KcrgZ7wnrDn+wEhpfXRtKF+HvugzFMEkOjcrBS5A4CtcaiIiw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f95121-d34b-455b-101a-08de64f2945d
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 20:10:16.8022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTVhRQMQ02NJS5GRpOWvK7qfh9pa/1F91OvaYsViv2zDG+dbvzrKPEJrEln3qBDV13b1EN2ZxH/aFpLa1sKJLuuihKrUaALmE0Kkd6Q+i97mUGf0vGh/5a4YH8N5xvAI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602050152
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE1MyBTYWx0ZWRfX5zStkRAqjE5+
 3xH8XABvEMSKXU2pO+LFs7BOdMIK/G6Z/plipj+Mw3MgWfwACGRy+8R3hT3GpinH8tEpVeND7SQ
 kWhY1Zy/DgVHXfwGMdDwSjoyzxvqca/G94B1Veck/UqDEPkIzSp2w1yG8aSYww4Fz07l5BFzo1v
 kM1sw4A5iIkpEJH3Oou/0VLx4cQmFnEJNrltLfxVlVgVhO8IrffXAIW7l7+5kgnKtqGtSwzlR7A
 QyXqVHqb5/rit83bB+xQoq5hOAaNuUNquFYWGXhG6/ACV479Xv0d7gzUFIAAAvqqfWL722HAP+/
 2A0xdObupTLngUPAGIO8Tz+wHXCJLeTokLQo63hmllvD/Oo9Pe/KazMqaRwyklns1mdsXmtaov0
 8uHaJrQzQneFknzDK8+uH4ZaTcMYWSnurl/JN8JwMAQDD4DTYUs448NFcAoyhaqvqbbzoBy00gE
 D/ErpgdlUuSgijaxAJAFGFoRAf7HWw4nfH1pzW1A=
X-Authority-Analysis: v=2.4 cv=VdH6/Vp9 c=1 sm=1 tr=0 ts=6984f92c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=oTZe3UBAmsgAI4OB8fkA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13644
X-Proofpoint-ORIG-GUID: Wu88g7Ip4Ams25eVObTqHT-4X-eDdgMl
X-Proofpoint-GUID: Wu88g7Ip4Ams25eVObTqHT-4X-eDdgMl

Hi Jonathan,

On 06/02/26 01:28, Jonathan Cameron wrote:
> And applied to the testing branch of iio.git.  Note this will be
> rebased after rc1 is out before I push it out as a branch linux-next picks
> up.
> 

Thanks a lot !


Regards,
Harshit
> thanks,
> 
> Jonathan

