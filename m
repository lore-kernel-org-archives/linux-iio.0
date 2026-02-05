Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E729A9FA;
	Thu,  5 Feb 2026 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309605; cv=fail; b=NdDgQWaKPIsop93kWwLis0UMhoIQLPn5YRI3YYoHGuP54WcpsBxUe5mWEHBVeKnSlRGAp5+RS4s9DKbSi5WBra6qkHod8KB3M3+j5yFFtI4bf7d8u/73jV6OXcslwyyNwSvKVI4iP0mYwgPTmIGzLV5uaaIqxrP2ZpBe9HblttU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309605; c=relaxed/simple;
	bh=Vn8EKZrA6B6is7aW6vsP4wbhUERq0szKThJxL2AAeBg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YBHhd8vSAuJjMOMsHGzm8kMz3Fw4e65x8XOMHAepOvJ/CbPwRAWqrGaJFK20kInWgwFvDOFqg1AZAVBEKXt5BLE1RBhiRr7UYrz4hay2Sp9pornFtnhXgw0WQ55Xvkew8jZcTUR5TLM+bnqeASEl/cWwBCCQFwzZEdJHwPC0OaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O5y1aSO7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gZlW7K90; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O5y1aSO7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gZlW7K90"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615Fu3fA560047;
	Thu, 5 Feb 2026 16:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kz1xHbyjeI52PrdqNh/+2Wt5JjB/r0LviS3BIujc+Ds=; b=
	O5y1aSO79RM4R4gyICVLo5cVFnXpl/3HDukIjCuwOaC9Cj4Wif/dQzbSSXS/tbp9
	J7PhU1SmA5fowP8I3bPmfQHKvuIcZ7cNnkUhSaDuduQw2hJ2xSHqNnJIFx++OBDJ
	tnnIUZKdWsUXd80OHpwQgugb9Lq2lmAwOfRdSHMvRqJmKcTf7qDIlm+1CAmihBvL
	MkD81LhKAeDvD0bnLW4wNpESpIOXMamyqmOXTITvBWgwRqB/mDIEPuv2jLVKr+xs
	WGoZk2kNBwCG8t4dZ/MbRmwWNDDyx3XJCpJ5iZJ+ZUoyxlRcloEcZQ92PQc+FdF7
	W1OQeIcAvlZ0acxQ1RFXIw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3j8um3my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 16:39:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615G1x3w001199;
	Thu, 5 Feb 2026 16:39:57 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c257c1nk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 16:39:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPrRN5QcgXjtw7S5NRNaiStNyfPZEWulovfCBFFBdw1AJ+FU6qfBKjnBrO/P/bdFOl6gcSZImz0otk089snEgEfGQeVY323EzszqDA7MOH4RFED1P0A4Y5VB2dvdVlWFUXh6nBQFekXgjJkifDBnNCeAA6C+ZSqNlqfq+X8izF2Dc3T2hhaBLVCfyzG6SpzdVg5b7aQum5lA8LfoQOMFNbFpE4dSKboAUGsobGOlAxiRtqE4SyAL32ww0jxdLv7FDE9kv0fBP11SqVEcLBCJj+6Xl7XF4GuYTD1tvadRB2aFKIiqtqwMFmO3sHCVBmTBtET+/1cWXpKoKRHHzO7Zjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz1xHbyjeI52PrdqNh/+2Wt5JjB/r0LviS3BIujc+Ds=;
 b=R1P7vmVUkBfmZQuJsnlCiOy/s8oNAVO/MdAcJNlXrhxaOvnzt4SltdkfK5n06+6r7+trFGmdAQRqkNGLr7/FwEXOhOgskEyB4EsFXSGugwkel6u3QgjvZkJbIJLQ4KHH5s6yrdMb3YnC+vsw4bmGwJoSfHSoMg8cl2NugMkQsOVuH9h26gZ6HoqJ4TyW4nnQp+KglXGOyebb6doChtRQyhcpxdacQz+TVhK3LkuS9GnfxCZ3QowEPWh2Msl8f9cqt0QW++3v+y92bWxC92Wp+ZRY5CERbETZMBFi84pssGE3pZ1XRo5+wECTK3QFNE92M6zFNg7AsfiaJgfCnz5QTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz1xHbyjeI52PrdqNh/+2Wt5JjB/r0LviS3BIujc+Ds=;
 b=gZlW7K90JrY+n1y4pn1YhgEFlJfB02zpAXq1U/PuKCABpf32lWokhGbpXeVrG50b1J3EagPpfrDSi1D1JE1b485rwWg+VuirZOVTFzi/wdgx+j8NX2zllx7guLTi74z6sFCKmDGtTWmv5eHaJHL1oezG9S8TWk25/86VKkb9s9c=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by SA1PR10MB997631.namprd10.prod.outlook.com (2603:10b6:806:4b5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 16:39:50 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 16:39:50 +0000
Message-ID: <88524db5-cda6-4529-83db-54ff3b3d5819@oracle.com>
Date: Thu, 5 Feb 2026 22:09:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 next 2/7] iio: sca3000: switch IRQ handling to devm
 helpers
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
 <20260205131234.3244467-3-harshit.m.mogalapalli@oracle.com>
 <aYTD96nmDAEZd-a8@smile.fi.intel.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <aYTD96nmDAEZd-a8@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::11) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|SA1PR10MB997631:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b1bd7d2-a0bc-4e38-6ae3-08de64d52e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0x4RUk5RXdHbFRJNWpteFRzVk91WkN1TWhTeVZqejRxbVJoZVI3azA5dHVl?=
 =?utf-8?B?RUJCNlRFOEN1RDJBNkFLK3g2OGF2V3h0NGg1SVc3SmI4VDY4b2JqWndTdlBy?=
 =?utf-8?B?Y0x0OEZYajZ3R3BGc2dCalVBK2JId0pDbkNoamRVb3FraTVmbFd4K28zYy9M?=
 =?utf-8?B?NmcrL09CbGRZU041NHNlOForYWwxdmJvdHFYcXNlY251OVUrOG9kMEFrRlRC?=
 =?utf-8?B?Q2hKZ0dtV3RGa0JqWUw4MnBzd0hNOEdRcU5lczk0dmllRUtFMTBHRlg2SDh2?=
 =?utf-8?B?ZmM2VDNyTnEwbGI4S0thVk10aVk4ZVFtM2FveWJZQ0NyYWNvL3ZsanlYRVhz?=
 =?utf-8?B?cW9lNi9nc2hONUZTbUNUYWZYL0NXV2lvQ1dhTHZlblk3eHRqeVZWU29kWTkw?=
 =?utf-8?B?dlM0RTU3K3A2U3NVNXZWRXF3SktZTEhZenZrajBCb29YNWp0ZXRQaE9ZRS8z?=
 =?utf-8?B?TUR4ejIxR0huY250d25BcHhTeWcvc2JrU0N3WmhiektYWGFrUTk0UVk2a3ll?=
 =?utf-8?B?OWdYTGhydWRDVzdDWFl2QVNSbS9obVpacTE0VDZ1SGphM0h2bHVhOGtRK3h5?=
 =?utf-8?B?WlFHMlBNWDRBL1BwOXRVMUI4L2ZTbUowQ0FOenB6UUlUT1hEbkI2Z0lEMEh5?=
 =?utf-8?B?Ri9tQ3RDUXJwMS9wd0FJNW5FVzlOaGJmclZHWWNwRHQ1VlIvUzZMYlhvOXJC?=
 =?utf-8?B?d2hIQWkvZktwOFZpdkFUUllxTXAwNlZIMFVyemdKVVZqQUxUdlNSMXo4UXRs?=
 =?utf-8?B?U3VsRm9LRGtXNGcvOWlEdHNlK2lzUnhoWFZLT2lPcWMyQzJRWVQrZ1JGYk02?=
 =?utf-8?B?MFhVVlgvS0NyWTYwOHFMNVZoSUJjdk8yOGR2RnVJSTdjNVdrK3hqQW5vOHlG?=
 =?utf-8?B?dU5CNGRJY1EzMDE3Y3hhS1ZCbjM1Z2NyRE5HM0FvNXl5LzY5cGl2dGJKQ1Vu?=
 =?utf-8?B?NEFETjdiNEhDeVRuaGhYTzJ6aDBIUDNWb1l1SDYyakFWT1dTUmVTMmVZUHd2?=
 =?utf-8?B?UmtsTFdicGtsMjkvRHB4WXhVYVp5ZmNKWFc2VHJEWW9uM0xKTGd5VXZqUTFO?=
 =?utf-8?B?RXdNRWpGL29UKzhKRnVZYmFpdmxOSnZKc1lVT094S0libk9mZzNIanI4MUZw?=
 =?utf-8?B?VlRWckNiZkNNajJyVlNDWEgyc2d3L1dyR0F5ODh1VWE4Nzk5bEdTRHZEdWZi?=
 =?utf-8?B?Z0NNMXZZMTJFOXZUREJQYW03ZDAyb0MwVWpnemdZbDd0N0V3RDROMnZBZ1hH?=
 =?utf-8?B?VGlpN2d1NjU2V29Way9NZHJTeUQrRHArTDU5YStsdXpvRXlyL0NhZ3RPZTBi?=
 =?utf-8?B?TWdPVHNod3k3M2luNUcxQmYxQkdmWGI3UXJMR1VVcVV2ZHBQYzdCalRDSXpi?=
 =?utf-8?B?dmdTNWtHS1BDZ1Y4b05rUXE1M1hEVTNRU0VOdExrYXE2TU8xdkcvY0VQdEhx?=
 =?utf-8?B?RnhZcFE1Z3ZTZk9KUkF2VHFpbFZCWGRRNWJaSDQvVUoyemFqaDkxai9jUG5o?=
 =?utf-8?B?VjBMR05VMVZ1cFBpWjl4ekF3NEVsVm1URExSM09mV3pUa0o3UUFpMUh1Sjdu?=
 =?utf-8?B?LzhOYUYwS24zSFFkK2dsblVtZUZuSjJqazlwZDM2dk1pUEtKZkFlNEdSMGk0?=
 =?utf-8?B?M2hoM2JQSEgxbDIzbWs0eDlUcE5VQm1ZSUU5TFBqVFVjekdZRjBRTiszTVJG?=
 =?utf-8?B?ZW50WDU4VmNlUGhaL0czeVM4QnF6RzNQL29veituRDZoK0FnQzRPSDNVUFd5?=
 =?utf-8?B?dHJQdnRBV0xmQkR4WEo4NGNabXc4dWsyZkpSb1NSSTd2ZEtOUkFOS3BlKzEy?=
 =?utf-8?B?azFEWEZTcFFmaVlzWkV1YXRuSHBDOXRVVmFtSDV1Z01qcTVVc1AxYjVRcjNj?=
 =?utf-8?B?MWxDZ056RWxJNXBKU0xyWktGYXRvdUVkeTByY1l1TzZNRS9TVFVPcE5qa3FV?=
 =?utf-8?B?T1R2dWxoaUk5Y1c3WlhZaGRHQThkQ3BKWnNXUk83djlLUjhCNFBWNWRZOEVq?=
 =?utf-8?B?cWxFeG54OW1aL0xyclBYRHRuTXNRalcyMW40YWVxeFFKcmhkL2hvMjhaQUti?=
 =?utf-8?B?TjJEb0lkQXJ2Zk4yL1krRlNNVjlCNEdSVUVobkw2QWJ0blJyTFU4c0dqMnJh?=
 =?utf-8?Q?CqHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzBGcVFaNms4N1FPQWNnbVhIaDFYNEZqUGtuVGV2RkxudkxaK2phUmhLTktV?=
 =?utf-8?B?R1BhaWlMNjNtbWlxYjFYZlE4L1lCc3NJcmE3U0FOazJWOWE4V2JJRjFqMXlN?=
 =?utf-8?B?UDJoZVhWUHFjOU1hREs4K1R0Yzg3RGNiaEJDUmFTWFRNM1VTcnh1Q1NNQ2tE?=
 =?utf-8?B?U1dPZzhwVVo0bWRESXliaEtYR21sV0JBWHoxQ1RTOG5yeDJIbVAvMTY4M1Nq?=
 =?utf-8?B?VDE1OGZ4UEdEejM2NFZlbnVFczNQanhhUzM3YkV3c2MzQko4dzFLazBxQWxp?=
 =?utf-8?B?SXNaTk80VEFueS84MXdwdVh4VGRTc2RlaURnaVBWdWR3YXV1MHFINzJVN0NV?=
 =?utf-8?B?c2IvNThVc0RUWW5NM25VTlN2bXVWc1RpaDdsMHlua1FHS3V2a0phd1k5Vkdu?=
 =?utf-8?B?dDlZNE9oemVOc1VWTWlwSThqcEpkS1BuaVFON3M3aU13Y3VjWG8xVmpMcis0?=
 =?utf-8?B?VVowYXdDb29oRG5GZ25RT0dkQ0VjNndZYXhoY2llTGlDWEY0dkFHQU5LNXRX?=
 =?utf-8?B?aHdadGJ3VERqekh1WVlqYnpQU2w0Q2kvNWRSenZvVTFNa3duTmxCeTAvMlJx?=
 =?utf-8?B?Nzcxc1ZBR3dqUU1Nc1ArM3hncFJBSWlXVjB1TEF4ZWZrRS9ibmtEY0Y2andT?=
 =?utf-8?B?enExSnhVckZNVW04VVNsYzR0d0E4QkdsUExqeE1kVWtNY1pYamNUNFZ2T2Jp?=
 =?utf-8?B?ZmhpeXBNZ2VKQTZlak9OWm9ZbWxDa0RQakZFTmE4YkpDL0trZ09IOUtCdU5s?=
 =?utf-8?B?R09pTStic1hLTktTNnNyYmtvNzJmR2g2SWFLN0wyS1dSNkVuM1lZbUFMa2dh?=
 =?utf-8?B?THJYZncwNGtNNTNaVC9lUzJKS09DN2RTa0xrQXFTbE5MZmtzci9MNXB5NkJr?=
 =?utf-8?B?NzcwcXJOKzFQSDhTWG9oR25DWGlPY1Q4MnNGeXNRWEdhRSswRFZHZHJ2Qkx3?=
 =?utf-8?B?VVJMdklWWGZIcitIRk85eGNVY0gvaGMzb1U1TlF4R3RWQUN2TnpZR2QvZkNF?=
 =?utf-8?B?ODNpUDBiMFZVUm9pNzVIak55MFgyR1Q1NU85Q2JWWlpZZ0p6b1BvNlZvbE5U?=
 =?utf-8?B?NTFFNWlvVkVpVEFyV25Oby92QlBGbElYUUttMGN4b3RzYit4a2RzSEJJMkxp?=
 =?utf-8?B?d29Za2drNExwUFM3aTU0TDNkQS9PVVd5ekhjWUZIWllJdmFyeWhxcGJsalkw?=
 =?utf-8?B?aHJoa1ZrUVlDWFFMZVhTcTlvZGZ0R2ZYL0xnL2NScUJETnpMamd4NEJVVmxB?=
 =?utf-8?B?L3MySnhTazUxUHdlbW5PUkcvSE1qZ05DaHlSckpzNGQrMmE1TW9uSDRPTUVF?=
 =?utf-8?B?cmQ4RVc5WnBaRGhuNWxQL1RnVkdCbjUxTmlpUWpicFBqb0NmckIxQzgvQWxM?=
 =?utf-8?B?STNPZnZHTHVTQkxxSTNnTkdrR0dnN05FdnNRTzluQWhaYXZJOXQ1QWw2VXIw?=
 =?utf-8?B?WUlTRlU1c011UEdFd1paOUJhbExsb2tYa2Y4QlRJY1RwVnUvR2EvQnpZQ1Ar?=
 =?utf-8?B?WVdxMnIzanhmMFVYNklqRmtZWjNNdFcvRldDVmxCWXVGeVRaWGdKWjJoVTNT?=
 =?utf-8?B?L1J3alZTRUdZYnZpNGtidVhsM3FOVWtDc0lCcmQ3c1R5TnNJUEk5M3dxUWZE?=
 =?utf-8?B?MzVIN0d1RmYvQ3BPZWg3TG04eEZJaklHZWpDT0Y1YUpqTllBUE05djF4S2w2?=
 =?utf-8?B?VXFGRi9wdXQyalpEOEZ6Z0NuQnBNQVgrNHQzSzRHR0hLbEFCdko0U01oSG10?=
 =?utf-8?B?NWhRcW5qRjhsM1JLT3d1ZVg5MjRlbUVqdnY0cVREOGxyaklpbjk0bEF3c1l5?=
 =?utf-8?B?TE84ZG9Qa1hEMzhOSmk2V3VSajdSN2N1d1BVTWJtRjVGK00rdEtLQXhhVkU1?=
 =?utf-8?B?TC9yR3cxZDlvdGs3S0hOU3JRTm9jZzN2dXVYSitOQzNUSjgyTHI4dTVrU3Rw?=
 =?utf-8?B?UzVFYlRJeTVWc3RwMkNTOTNMWWtjUlZqRXJNRkZjNlVYU1EwMXREbjZJaVMy?=
 =?utf-8?B?UllRQnhUVU14MFhzQ2U4aGowSG9mZ3dkN0Eva1ZEZkdYNXk0Kzc3bVYyOFZt?=
 =?utf-8?B?VzJIMXVidHkvNTcycGtORFQ4WitoZUNkeGJlRVJpWnZNOVRsS1B1OWJkb2Q1?=
 =?utf-8?B?eDBuempsa1pKVXBrZ29NMVorditpVlhCdFk1ZXNMVXVWNlJXM0dJYkRJNGZB?=
 =?utf-8?B?NVduYWFxYmhnbE9pZ0VFeGlrK28vMk1jSGMzbVhvcEhERVhhemJwcVFudDZF?=
 =?utf-8?B?RjkxUWZjUnNIK1BBSHJSWklMTk0ybk9pUEZGd0F1Q1MvbEY1KzJXVXZqRGRB?=
 =?utf-8?B?VHdrOXdhanIxYnhnOXlvQ1JuWklkbEFRSCtZSmJCM0xxcWQ5LzFRdTJxdGdL?=
 =?utf-8?Q?ckoizwK5rXT0/Dtag/zb7h0huUKGNndm7lWzp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yQ88zw4KJMRCBE6xIu85+x6vQQ4nivrlGF8zkExNgWElXpSZkA1KULqRKT4kk0IxiFz3TtFuDkLUvjuh7+O3uo9gSLYge9oQE4yptRsQzZ9GvLgC7dUooIWkuPQJ56VDsHysqKKXGgCoF0xPVQoZmQm2bKWXkfBNw8nlyXJZWHNkghELea1KXFM24k90w+J6muidklFpuNmRA1cUnjChtq4G9bmfKdOuqIB1+d3qmlIsaAZHVvCPGNB3UMuysVmtH0Y45hrZTk5KMRVFT0LOcaFHjBJaHsnwuyr4VOvKsrlcC7TLsuicC6WUr/aH+El4xEJ5dwVT70uMsqCWpdu/yZdL0cE6HHZ7x5cuzD/IPbjrCLpIujY3LqjeLQQesW4sUbeLBFs22rcqGzNt7NeNsX4T1XAjxdIySfAsQiAZd+bQv6G8dklA1pw6hisTsYUA9emDNkVlU04CgCqNxFu1f4p6OA8/WtZdDdqPxHV7fOhvkeJMLBZvxPnMQ/vDUCdCLQ2gGBIQMStqlb6iN9PUBFikrE0dR7Z8wChHByuRKgYARJw93jQ/r5YH2ZipOqvf/q3/sy60Xy/o4tOWbi2V+cKonQasRzsFCOSKobzxhHg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1bd7d2-a0bc-4e38-6ae3-08de64d52e41
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:39:50.2125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJXw5gWv9dNvqan3aw0Rmp61EQnDX1Rpa183O8L2M6Q2j+IE+lsi9e6rTTNuFYQ3aWE688oFd13mdZs85RJtsdJkExpTg43k4Ykg/7wgabaF1d5GZleD3KqDdj9+PxEr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=732 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602050126
X-Proofpoint-GUID: JR3k4D3YVsiti_wy6tiWiKzcIwayB0PO
X-Proofpoint-ORIG-GUID: JR3k4D3YVsiti_wy6tiWiKzcIwayB0PO
X-Authority-Analysis: v=2.4 cv=BJS+bVQG c=1 sm=1 tr=0 ts=6984c7de b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_a2ae-DXM7SRogq16d0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNSBTYWx0ZWRfXyk/Eu+rQVerC
 OubtCwzvYYqvsrpIYoTITuRP3zyGSlREE37biNslDPxzMKcXv0N7XKmyWbPjDYTifDwZsmXxs4+
 /EVymNt45QvGWdbC2IpdJ7Va9V6B5CTa8s5tkw0dzAKe+5nzo1afhhMXgk4ZwoPKiCc06FgRYg5
 NmiMEoDf31UMP9tF9iHar74H6udYXwlf2MOXeTEJfkm7ie/X2r7SkFGR2wDB43rDiSoeSxuk2bW
 8a0/T5kgPo6pFJH2JkH8VGjqFU9a5li7hWNmdjPqs5/LW1nXTpDdQex+Gn8dzF6hl1lSPePjFga
 SUvgtC4Fj3q05P8olmjsjPrHLVr0/ELt9ZZZEYOkEID8l5M0EpIBpZgn1Czjt7j5Gpb+7t7Vb4c
 nPUXpxpmxDTs7qKUC7LNhqblJ/cSod6YdvaoDsYWsb039GsAhpaw2rh8UCJ6FZPx12/gX63o03r
 09NvNiRyTG7EJr6IBXg7UUL5gau6h9Xf0h2gIWyU=

Hi Andy,

On 05/02/26 21:53, Andy Shevchenko wrote:
> On Thu, Feb 05, 2026 at 05:12:08AM -0800, Harshit Mogalapalli wrote:
>> Convert the threaded IRQ registration to devm_request_threaded_irq() so
>> that the probe and remove paths can drop manual freeing of irqs.
>>
>> No functionality change.
> 
> ...
> 

Thanks for the reviews!

>> -error_free_irq:
>> -	if (spi->irq)
>> -		free_irq(spi->irq, indio_dev);
>> -
>> -	return ret;
> 
> ...
> 
>> -	if (spi->irq)
>> -		free_irq(spi->irq, indio_dev);
> 
> Do we need an irq member to be in the struct after this patch?

I probably didn't understand that question fully.

﻿﻿we still have a call to ret = devm_request_threaded_irq(dev, spi->irq, 
NULL,...) so we can't relaly get rid of the irq member I think, did I 
understand your question right ?

Thanks,
Harshit
> 

