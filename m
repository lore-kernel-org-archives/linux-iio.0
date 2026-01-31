Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD0835BDD5;
	Sat, 31 Jan 2026 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769881973; cv=fail; b=tL57nnNOa0iB2InVSIiItcBEcLtTGRUuxSmG/eNxdCmSW7qStj+DuhLNDLwTuFW4MRR1oU0PVnnTyINRwpzls7FnqWhID5+zqyD3MHHqQzFe0IruW57nScQGk0zed7BlAS7Sit9vWqDaDM7jy+1nQWfbMxegUrGUNfzFU1CoqwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769881973; c=relaxed/simple;
	bh=g4r4KNsdpRzXmXiYUaVVsFSfum4rfQXBOMrAJITMpsc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LgYOtG+G/i6oYYErsaU+CrSXuVYWdlqptE/ir3jrG4/ukzTNJyhYpwNKhRW+UYy9YolKzdSNr5UJtcnBpSNM0/vmYgGI1oMf+aPDGgtkGapBeXW1hMmOhK+Zp1TmuNCFqbQ1QEPbjC8Zm0XMCm3sDllwmhGmhGqMBPrUV9bm9U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dIMGUqxs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JbaOH70D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dIMGUqxs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JbaOH70D"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60VGcVgw1801896;
	Sat, 31 Jan 2026 17:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tAYjqe+tY/Ltbf17ej+vWQcdem8P8MsBdlSlr+n4uws=; b=
	dIMGUqxs3xgqq48F5kf2jvw46BU4JT8hMYVGypE8ZjZxCk344l3rkmE6k1bK8vfW
	96iEpVCtzx9GIoL1yZderc0SXZWJj8XDZUVsdutvT4KJVkjNIHnZmXFbuDXL/Qdg
	pTWDxBjfzxCww0AqaSB389e0nrp6BDyol5xXrTUUtJ2B3j3KbwZxofW9PPO0U2qL
	/aJGxAORTtAPPny4Rh6UZtbeYSJt94BuGBbueZGi1cqIBvG7NmL4ntkYEdDAiFzy
	jy1OC9p1fDYgs7RDnJyoXVcNhY93M4zSdMDEG6WypTxsd8MDS5IywO4LWFebwa2F
	PJW+B8CwE2DjJcz5ZY8yHQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1au609en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 Jan 2026 17:52:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60VDFwxS001225;
	Sat, 31 Jan 2026 17:52:37 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013066.outbound.protection.outlook.com [40.107.201.66])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c1866xh6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 Jan 2026 17:52:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyqr42i30/GARabAgZ5eZnB5ycTecFtlWIh4MkpKrm/DmlhKAaszlBICxolF+JWpcKI/2l8ScI+eSfBLv2VkiINQbGkYncckPIfXxdFBNLoF85ty68itRfjDAyrWLwij/tN1ACGSMGMPZqc2lJLEW1pjPchfy9PuvunLqx++ZWWujwjJ4CRfdsYxKM1lWRHGT7Sk68uu0jjNiIbzLIpUCD1ZDzokMfY+Rj2d/SfjISp4iNOcW1tr3zqKxWhZzEgfRIIF/PNiKcaXeeiQBO1X6iTwGFG12vJxFu2K6A7S/q0vAHY9wr1qe9J9O02Feke2oGilBBlmR4Db/J3o8C8zYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAYjqe+tY/Ltbf17ej+vWQcdem8P8MsBdlSlr+n4uws=;
 b=d2eEDmRCkaa8TySDEM4NSeOd4XuEbTXvWgiNe8nkUZO+OFpFdN4IYnRMG3h9JqCiCY86+UULr+NcEYc8Hnn6hX9Zpjnpkb3lw3FhD4XBNg8WPlyx7k5Y2yrhRy7AIZSBHkb3ShXeW7bYOm04qJNzUfZ4lOV4JZ+S0GckQ1bqnKDxwnl3vSxoCMiHxxgB2XZffPEynMwg6inhknB7qHv4DQt2YICzYnr1Ix89SR+CvGHYC+aHLEDCiOsHWXZrW0Q5CeiBqG4YuIGmarkY1efBs7KJIgeKPYRuZGqpc16jzj2UNxcWZYnvFWuYF/4YYNE90KsKOCLoik2mz5/I14LutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAYjqe+tY/Ltbf17ej+vWQcdem8P8MsBdlSlr+n4uws=;
 b=JbaOH70Dhrbwff/aYtoZvwFdIyv5dRDCp8zj7mGQNeQt7aUGUxj0C5PxNUWTAZvmTgokmhy+njOt2IUk0avdU8rVc2+D0d7oZVtn3g4aRwkSYPCNe5OoUzWsVOXLBy6kwLb9aSfhrP0v24r0oVf02fWgbBgN5xyn/tkWGmV+uMg=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by DS4PR10MB997770.namprd10.prod.outlook.com (2603:10b6:8:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 17:52:31 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9564.014; Sat, 31 Jan 2026
 17:52:31 +0000
Message-ID: <464ec1bb-858d-4ff5-8fa0-1c9af9b9945e@oracle.com>
Date: Sat, 31 Jan 2026 23:22:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 4/4] iio: sca3000: stop interrupts via
 devm_add_action_or_reset()
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Gustavo Bastos <gustavobastos@usp.br>,
        Andrew Ijano
 <andrew.ijano@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260130214323.236389-1-harshit.m.mogalapalli@oracle.com>
 <20260130214323.236389-5-harshit.m.mogalapalli@oracle.com>
 <20260131163909.7c90c9d7@jic23-huawei>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260131163909.7c90c9d7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::18) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|DS4PR10MB997770:EE_
X-MS-Office365-Filtering-Correlation-Id: e37ff7cd-9cef-4d20-e421-08de60f18190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlAxWmZZYVhuS2dTdVFYWHRpR2x6TjdEV0R0OEErWDcvaUZ3bkUydU81YUtk?=
 =?utf-8?B?YVIxM2RXNGowNkd0Q3FHVm1aS0E0ZVlkOGwwTjZZTG5SYnVuQ1p6UzFpR2ZJ?=
 =?utf-8?B?SVlSbEUxVDYvak9WK1dwRENOVi9lRlpSWHE0eTRPZUY5bXZSUDNydytpM1Vm?=
 =?utf-8?B?SzRMcFZkZzlwNndMM1JBbEhPYTVTZGVSRkdTQ2QwZ2RjQzYzM2QzK2dMSDRM?=
 =?utf-8?B?dlRaRTNVQW5uVzNKbUtvUlphSGJEN1pYMEJsTEtWMXhlSmZ3dDhjMCtUSTVG?=
 =?utf-8?B?SXpYcWtldEdubWhrNE1MRERiWXlvM24rMzlFclA4N2dFV3RjRURYdHB5UTJY?=
 =?utf-8?B?MnlQU3IvM2lLOU5obm9sNm80RGM5VER1ZTd2Mi9iTlhNekRMUURCTlg3K3Mr?=
 =?utf-8?B?dHRIZWpRbEtMU3NiREZ0ZHFDZkZuV2R0ZEZLY21nS3kxQ2Rnb2hkWGZVOFJr?=
 =?utf-8?B?ZThydVJzSXA1eXJCdDk5Y1hJRFhVWVdYbUZqWVhZTUNZWHUybkVBNng3RXBF?=
 =?utf-8?B?QUxhYzFhWUZPa0pUdVFtLzFpTUFwK3BlVkZKbVEvK2hLODc4RUcwTkR1NmZk?=
 =?utf-8?B?TVg3dHEwRWhJSGtFaDIvSWQvWnVKOWM2Mlp2am9wS2o5MEVwallUbzA4UUJD?=
 =?utf-8?B?RVJTTWcrb3p0YmhtR1E2RFk5Vm42Q0hUM3FiVTFNOW9qSFVxZ1FZaTNzMUg4?=
 =?utf-8?B?R0FkNzBQd2JjY29uWGtJTVd1S2kwZk92VnN3NHJtU1J2aC9PeWJxM3JhZXZW?=
 =?utf-8?B?bjBjQUoyaGtNeTlPdHpwNDVmZzhuckRhcGpjWThHREk0TEZtNkpKUm5tOUhk?=
 =?utf-8?B?c2pMb2xsMTRUM3hWMXZXSkhKUGdSY0VjL2FLTlRxOG9qZkpKcnB3OHpKdHNh?=
 =?utf-8?B?NFVaRWlMdFpsNUltVWtleVJJeUYxS29KdFVYSnc2Y29saUlvb2syQ2RjUjkz?=
 =?utf-8?B?dmdwdXhKdEdpRUpUODE2SUhhSnF1YWpMQ0tqVDc0SS9CQ09QbFRTRVFVTUUw?=
 =?utf-8?B?STV6Ym5ZVDZISGlQZm1zdnFQZkhJcDlCVlFaU2JxQ0UrWUlOT2g4Wmg4VXlZ?=
 =?utf-8?B?WGMvTDc3Vm5iaW5DRGZ3MTJrYnA3U1dtZTBJUnhHWnJSUERuRDZ6MTFONXZh?=
 =?utf-8?B?dUhFMTJSUXUxQjU2MXlMdHAxSGNCV2dyellGb0t4b0NXNzZsT1hZc2hZYkRs?=
 =?utf-8?B?MnpISVBobnBCUmRvakZ4ZVZqamtxU2xwdWRaS0kwVURUTTQyUUUwWFVtVWlv?=
 =?utf-8?B?Zm9VOHY1N2pXd0x6cGg2UThSV0lyb1B2SzgyL2dmcldmTlZSSXVpOUs4elRp?=
 =?utf-8?B?eWpJNy9HWVBCK1BBKzk4cVIvR0FmUnJha0t1bC9KakZJcGxQdGpBcE9jZ3lL?=
 =?utf-8?B?MlMxWGpYaXFzRVRESDJ0dFJhbWNYcEY4SGtZbUxNY2pkd0tEcmt4bmtIaDZa?=
 =?utf-8?B?Tk43ZkxJUnFmb25lbW5QbGZuMC9nNkpoTGorbkdwU1k3OGpkRDB3NlE5OTlR?=
 =?utf-8?B?TUt0TGtTaXZiN28rMWtzQkZRWllTcUtCYU5pS0lNeTJuTnV4VElXTkxkUGtY?=
 =?utf-8?B?UFlpMVdyNGhKSnNtYXlES0dtSWY0eHM1ajJqRmJlYjhGdnZXL01IQ1FaeXJQ?=
 =?utf-8?B?WVNnSGdGekxzSXVmTWlxV0tKS1REYzV6WnZsNkFENW5FdGdRNDdYWXgyd05L?=
 =?utf-8?B?YXN1VlZ5bURSS1U5M0lZbFdSWnpvK3hKSFJhVzhxay9iNzk3VEtVN2RGblFo?=
 =?utf-8?B?QUxubEtrQ2E2VG1kSnB4M2QxMkpsR082U3JYV0xuL0dRd0h6WThYODlnQ2Uz?=
 =?utf-8?B?eC9yMU9kVDVrd2YxcmlxbC96ZU0wWlNHRHd0SnhEdzZjSXdHMW9wWkNpc2RJ?=
 =?utf-8?B?UzV2dDVZZmVtKzVEQ1dFbVFkYm9MS1BoK2kxcmJuT2padWlScUlKcElEVmxU?=
 =?utf-8?B?Q2VHVVU5bTNwOEFEaHlkNFlMQmNRQndpZkE1VHRZdWVLNUtOOURiem1GSzYv?=
 =?utf-8?B?TDhLUlNaUzRLSXlCMVJVL0cwaDJ4elVwY3Bhamp2TmNYWUNVK3JFaVNSWDJj?=
 =?utf-8?B?dG9VaG1aN29GSmdya2NhY1hjeTBTYlFHcDQ0cW9HMWx2YXpUQUowWTloYzgw?=
 =?utf-8?Q?j19I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjlOVlNvWk1FNkVWa3FLUTJONWk5KzExTGs0dFppMWVFVVNqUHY3aENwc29r?=
 =?utf-8?B?Vit5R2I3bmlVK2dvb2FkVXphOGtPVGZmNXVSMlhKSW1JSVpxS2F4Ykw0cjQ3?=
 =?utf-8?B?WHVXUnlIUElpRkFwZjBkL1ZHS1c0QngzckdISmNYTTdCeWtXakk1WnA2VUlp?=
 =?utf-8?B?emMvVisyMEM1Sys0V1F1bGlKOXQ0WXhjQ1VLOGJhdGhUYUFFZGl6R25uTHhp?=
 =?utf-8?B?bk1kTmQ0Ylc2dFMrVGNFRmhTc2xnNVhPeU9odTZ4TmQvN2xCUFFYdEthTXNm?=
 =?utf-8?B?Y0M3cDRUdDdwbWJZM1RBSTV2QWMyOWZmUzJEdnFCMGNiZDQ5V1V3QUNSQlRE?=
 =?utf-8?B?UDg5NVVHTlhXbmI5TmN1emI5ZDl5ODM5QXhzS2JuVzNLbnk5eWdwRUVFSGxp?=
 =?utf-8?B?eGZLcUVmWFRPSFVUK1ZQVW5tdDVuMFpadG1pdGJYWm4rTnJWdXhQNTJubXJP?=
 =?utf-8?B?UDM5aUJ5b1g0NGtNdHlBbWxkR2RuZ0xSczZZSUFpb1RJVGV2U29EWHJPZHh1?=
 =?utf-8?B?QVFTejB3TzNieXlUWWdPYVJ1LzV2d1E3U1BJRVdvcThUK3o2WFR5dVN4ajB4?=
 =?utf-8?B?UWJsWDlzWWFPRUpwb1lMbUduU0p6bG95VXFPSklQYllKK0J5NGQvcGk4VXh5?=
 =?utf-8?B?cUpTaHoxNkJ0ODJZZnU1d0w2QkhSbFNwdVFJYzZJZU1ER3VTY0xMQTEwdE1E?=
 =?utf-8?B?YkNHOHQ0N2NwUGkxaUhIUm0ybGpQd3Mzaktua0lablluN3pjTkw2VjRpTGpO?=
 =?utf-8?B?NENDVlpSVlJQMDNTV2FNY0YvS0xVMFJwK2IxQ3NwVnhWZm1oaTZ4RHJ5Tjdy?=
 =?utf-8?B?WjZUbHJVMjlBeGpzRlVPTHVjTzhIQUFCMnZlUlFXSHFyK3Q4TlJVamZpZmhX?=
 =?utf-8?B?Y2FBakpMQkJiYlMzaC96UTcvL1UrMURpU1l4Z29mRXVoSWxsQ0gwK2NPWFA4?=
 =?utf-8?B?SXBSMnlyVFdaTkphMEdCRWtoaU5TQXB5cFNyVjd4ay92S1RBZEM3VlNGZUtk?=
 =?utf-8?B?WHdjYkVJbzQzNlUwQ0c3SE15b0REaDBGQnpVbDN2cEJraFFpU3poSmNQQTZy?=
 =?utf-8?B?OGYxVERUU1hGTHFxbHZsQWdXQ241KzIvS3hCaEsybWd4a2taQW9tNjNBNzhB?=
 =?utf-8?B?dDBUNGxlOENuUkRRVmh4aG5tcC9pS1dlb3JDT1BONWtjN0hVUDY5SXFnN2dI?=
 =?utf-8?B?SjZyUE9zQkFHODFLb2NNd2NZa3ZabXpneXBERFR4MlljeXpKNTRLMWlaYjNE?=
 =?utf-8?B?S2xaSUh3dVBXK1FUQS8yMXZ6cGoxTzBaZ2txSldZa1B3T0szVFYvMEpVNG9Z?=
 =?utf-8?B?M1BNL3JYdWdkTFVpYUhVRlFXQ3Rlby8xeFl2Z2Z5SWRLOGdpTWtKa2VwSEd0?=
 =?utf-8?B?Ym1sOXZnTEVsQkhJMHBiRU91cmR4QTF0c2hjSHpYOEZ4UTdUdzliSnlTdTJC?=
 =?utf-8?B?YUN0eENoYys3WWppRVVLR0hMV1gzR3hxWGlvMXEzbkFSZXorcVROc1pjaFBN?=
 =?utf-8?B?OE1tSFpGc2tnMnZ1Yk9PR1JCYTFlRGRLb3oyT2ZmQTBjTjh2Z1ZrYUwwK1hm?=
 =?utf-8?B?bUluR1Bpa1pLRUlzckdYUFpZN1UvMWwzRWdnUjRnYVVYaGRYRE1aenM5Q2Fq?=
 =?utf-8?B?TlNnVjJGazZORUgyN0k5cm00TElxRlFyYlVaYVN5cm55aVZ3RThwYlpsLzl3?=
 =?utf-8?B?bG13WWtnV2NOcTMzdHpqTUMrQWNMTEJEUys3dkVrOW5ycHd3eTJUV21Hamwx?=
 =?utf-8?B?YjRlcEFFandjbzhRV2FXaVFLdGJRQlhxS1BEL3JqcDlqTlR1eFVCMUZQMUl4?=
 =?utf-8?B?TEVXNFJmeDZLaWZRNHByRkxSZVh1ZEM5RE8xM3pxSjRpM1JhRit0WUZWTHZZ?=
 =?utf-8?B?dFhxOWl2bHhJR1I3WkNhZnJ3ejhac2pvem8zbHBiOXlVTFE4SjdzNDNmK0Vp?=
 =?utf-8?B?WEhYdlhhbW9LQVJJNFVQNWxMakNSTVExS3lyVG5QSFQ4aGM5dmo0ekdmRld6?=
 =?utf-8?B?WXBPT28wYkErWWgxSnhxN2Jmb2htcVFja1ZmSEs2Qy9YMDZsaFZKY3R4MUVS?=
 =?utf-8?B?NG96N1Z5eUh1RFhiUlZQc09lRXZ3TzhVL0d5bHpZM1kzYjBHTkQ3VzlKS1Zn?=
 =?utf-8?B?TzlRM0NJb3M4dUI0Zk9MRDdISlhsamV5THBHbmhsRDVwcTR0L24zaWxHd2ls?=
 =?utf-8?B?WXNIV3E0WWZHNUJyaGZYRzJPUXU0bzRWNno3YnY3VGFoZkxJNTlDTXVFR0dZ?=
 =?utf-8?B?OVcvL2J2RktWc09yTTVEZkpUT1BGQk5OOG1ESVE5VklNUzJhK3RUWERpUGlF?=
 =?utf-8?B?Umo2eHRtQzJOWjQ1Sy9CWTJsdWxlVFpTVDJvZXJDNjVJVSt1RUREY2thb0x2?=
 =?utf-8?Q?YdwkV0cK5oyS7/2cO2QaXpoWUseqtxV3RoGHs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	72ACgWH6BQw/oSvqGTv/BoEBZSWnhaNrqx4Pv1KvMF5+o3ivLnCWj6WH38pA4osR8BmIit20smWnyHR8UlV8x2kcMReK/pgKHHGmzMByUtSzEhrvf8lJCJI3BFyDOBXqcEV0IOd2F2Hugyd41kj1h9/4UsvJ3l1aZdwEkRi54KdmAxdzExxuQw+Gs4yd2uE0hkAeN6FwDXw6XVqNeK6C+F+Hs/dx/xCnQFde8Jlrtf9KLBPhKub5DUPtFqg2e8cvwBOLCyTumll0APqjW0hRpizK4otDFH90SvYZYuj0kk5J0gltzAs88gSo8l6st3OdBDut5AYfXZp1oGENcdtLALMf4Z7wGwBT85XdsI6Vz9MPAZcstj3ET2f1EPnqQzixhKusj4v5MxRuB4NqjloEd8w2xn35ARtT9ySSUnRMAw99I01Z34RZxhFmiUFn7wTVUfIsqY+kmkR8ggu3M+n1wu4R4YK6ULUd8zqQ2e5brKyzcVV253cIgYk9r2ISo9cAk33riuLckCb8sE5GaMjePcw5MVkbR6mNZKdF93q0BPSsVEow/K0Z2zijQvK16weZtZKJIfl8xbRqEAuLvbHasotiIhnjOZLCvgfuD8qPzIw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37ff7cd-9cef-4d20-e421-08de60f18190
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 17:52:31.3286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gIKkGwVMr+CVU7yTe8yJvafjKUDfWIo/A8eLjm2bWiY96vQD/A19J0b/Ig9o2F5w08+nbfS99zJ4Zi0Esaxt9/IEjFQ51d0ST2CF+YLc2maegu7mg8rg5Db8nt8f5Ck
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601310150
X-Proofpoint-GUID: vBrPikIaVyR-wHSZ-2EPEJWDDU_mwbYM
X-Proofpoint-ORIG-GUID: vBrPikIaVyR-wHSZ-2EPEJWDDU_mwbYM
X-Authority-Analysis: v=2.4 cv=Nf7rFmD4 c=1 sm=1 tr=0 ts=697e4166 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=XM6rsVSvGdV2B5CaEioA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDE1MCBTYWx0ZWRfX4quAadAlHjns
 u2IpLiYLmErdO8LHXy7KWflG3h5PZNETNBK9QSlFfSMwaCMUrlLXn3xQnsJbnZ45778Xb15CxLV
 R8QE5dIbTYgix5xly/nH8MMTz37bxIWxtUm/woSsvVc6+7xiZrS/emd3GKOjHEO1rldGXK91LmR
 bodjOPhtkf6NWAhrLmjC25YufyJ4vFvlXsANmE+FDlDtnLI4PM0L4+Up0rii8ef68NxMGwzhBwh
 /OJ0/POd8yGFPND5E72zAWs9D4SMERD2vVKgdB1rqFsyYjIUDifsaQWNJjny0NI9yz07H285An+
 IIn1LDc7alSOd/w1zbFqYW8p4C2tOiUBJLSoUx0KXR7lWceWIt4+AwKl8r6EfjPWKdXxHlqje0x
 NTzr01NX+sS3h9b/q2kuTmzDt2ghkBLq9CF0Y5ya4BLgdBdbBx+jPZH6w0lO7Rp3WiITSEtOJ2x
 IAwk0RAs/z7A+Uj117Q==

Hi Jonathan,


On 31/01/26 22:09, Jonathan Cameron wrote:
> On Fri, 30 Jan 2026 13:43:11 -0800
> Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:
> 
>> sca3000_stop_all_interrupts() is moved above the probe routine so the
>> new function sca3000_disable_interrupts() used in probe can directly
>> call it without additional declaration.
>>
>> Used devm_add_action_or_reset() for shutting doing the interrupts. After
>> this there is no need to have a remove call back, so got rid of the
>> remove callback.
>>
>> No functional change intended.
>>
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> 
> Will need an update if you indeed didn't intend to change order in previous
> patch.  

Yes, I didn't intend that change in Patch 3.

> devm_iio_device_register() is last in vast majority of probe
> functions because it opens us up to userspace interaction. We almost
> always want to cut that off on remove before doing anything else.
> 

Sure, thanks a lot!

I have checked in other drivers while thinking about it, but my code 
base changed due to incorrect ordering in PATCH 3 :(

Maybe the best idea is to do squash PATCH3 and PATCH 4 ?

>> ---
>>   drivers/iio/accel/sca3000.c | 58 ++++++++++++++++++++-----------------
>>   1 file changed, 32 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
>> index bf1957c7bc77..7f7d29688a81 100644
>> --- a/drivers/iio/accel/sca3000.c
>> +++ b/drivers/iio/accel/sca3000.c
>> @@ -1437,6 +1437,34 @@ static const struct iio_info sca3000_info = {
>>   	.write_event_config = &sca3000_write_event_config,
>>   };
>>   
>> +static int sca3000_stop_all_interrupts(struct sca3000_state *st)
>> +{
>> +	int ret;
>> +
>> +	mutex_lock(&st->lock);
> 
> Use guard(mutex)(&st->lock); to simplify this. Remember to include cleanup.h
> A future patch could then make use of guard() more widely in this driver.
> 
>> +	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
>> +	if (ret)
>> +		goto error_ret;
> 
> Blank line here.  Keeps each group of action / error check clearly delineated
> if we have a blank line between them. Note this is a case of do as I say
> not as I did nearly 17 years back when I wrote this (younger me did many
> things wrong ;)
> 
> With guard() above, you can just do
> 	if (ret)
> 		return ret;
> 
> here.
>> +	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
>> +				(st->rx[0] &
>> +				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
>> +				   SCA3000_REG_INT_MASK_RING_HALF |
>> +				   SCA3000_REG_INT_MASK_ALL_INTS)));
> 
> With guard() above, this becomes
> 	return sca3000_write_reg();
> 
> 
>> +error_ret:
>> +	mutex_unlock(&st->lock);
>> +	return ret;
>> +}
>> +


Sure will simplify this function with scoped guards. Thanks for the 
suggestion.

>> +static void sca3000_disable_interrupts(void *data)
>> +{
>> +	struct iio_dev *indio_dev = data;
>> +	struct sca3000_state *st = iio_priv(indio_dev);
>> +
>> +	/* Must ensure no interrupts can be generated after this! */
>> +	sca3000_stop_all_interrupts(st);
>> +}
>> +
>> +
>>   static int sca3000_probe(struct spi_device *spi)
>>   {
>>   	const struct spi_device_id *id = spi_get_device_id(spi);
>> @@ -1481,6 +1509,7 @@ static int sca3000_probe(struct spi_device *spi)
>>   		if (ret)
>>   			return ret;
>>   	}
>> +
> 
> Unrelated change.  Make sure to check for these in patches before
> you send them out.  It adds noise and typically means you'll end
> up doing another version even if everything else is good.
> 

sure, I was actually aware of this new line addition while sending, 
wasn't sure if I had to do it in this or do it in a separate patch. But 
I understood that now to not mix unrelated changes.


>>   	ret = sca3000_clean_setup(st);
>>   	if (ret)
>>   		return ret;
...
>> +		return ret;
>>   
>> -static void sca3000_remove(struct spi_device *spi)
>> -{
>> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>> -	struct sca3000_state *st = iio_priv(indio_dev);
>> +	return devm_add_action_or_reset(dev, sca3000_disable_interrupts, indio_dev);
> As mentioned above. This looks unlikely to be a good idea as a reorder of code.
> 
> I'd expect interfaces to go away and then interrupts to be stopped. In general
> that should always be safe unless we have some racey bug somewhere in the IIO
> core or the driver is doing something unusual.
> 

Sure, so iio_device_unregister() is the first thing to happen. Will do a 
v2 trying to address all comments.


Thanks a lot for detailed review and guidance with this! I really
appreciate it.

> Thanks,
> 
> Jonathan
> 

Regards,
Harshit
