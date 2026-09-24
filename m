Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8E404BC4;
	Thu, 24 Sep 2026 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238211; cv=fail; b=L404/BvSt/DuPdkgBtQLKc3Ytq1kVKi8S5L1iGIh12hdlrfi1Sp5WDcEEAuk3aWOvzLO+GlpyQSs9c0UpipFrAwsavAtPmTtnuOAXY7fF70nOBnDuDdRceU+ZcX3GYp8YJFOnumb+xIa7Z2ht3VbOwXOFHkQmzPniqFklrIPTM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238211; c=relaxed/simple;
	bh=UJ1RmfJA3+/MX7tadNlBDlHoimExAYrYwH/DJjaZTZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QlCNZe3dwQjz8uVeb3EwLq+kYRGyF7xxVcihXlJUKVY+/3N3yy4xQEvFYwI8fzymWxNtJe1hjZG19aH3D5Cdi+876TMxaU5ZOi/gxCD2OgKeHy9PkWD6SwMIv8vyvkFCqkVV/X6qPmhhWYkvl1ObzK+Ei83fy3vwPRaMjUI76bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DI8qR/+2; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DI8qR/+2"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5e48J3875472;
	Thu, 24 Sep 2026 04:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=X9UCI
	aVHy7n4H/pCziPfapMNrQOyx0c9jnAJXwVqSI0=; b=DI8qR/+2nkX6SX+/2Httu
	UkIApBEa3BUiC7ZASxpeOs8RgwMnnQqNI8lJAT4OONjyN8iVf6GzEdp8lq5ANXL7
	UNaszdVJB4QSGYKcJUIpMpP+HVoKo3d4NE3FMyVUYwfC0muC05ItQKgCBJMcLr2m
	nN/uQwrv2zH0y01jHUsOkMVR7TBs/nT/S5JArEAKHMQ8raojoLgzDm4m5a2sBkE1
	FA1/xHeC9hkbr5dTEnqUH+NLDku9XkafQwENidGv9Hn8O7o0I8RDAWFgqv+dMPry
	4yWxNtXsBxM0Zu/Tm9F8UF8wHKOsmifXWIBwWwcdJNnWmi8mEGe+PRK3bchimHnh
	w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gvmpk3qgt-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 04:23:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnzUQ+rBWLgf5954DGnXOaD4AxL82Oc6p5yJ9CV3qLQ0SvxaXf/8hd7uuJC6mJntwQM2RJTSF3ajFHLfA8DfkvMRyrvIxaZouQsET5QfiPPh5NCsMHrsXcfjiitO+MPL3bkV7INBdZUM/CU5gDuoIgD/SAOfyLYzdudxZwE4Hae04Juaw/HAB8smMjwbLzMFAZVGqe/zN+hU9tifirQ3tC9ADHIgzoW0e8cyhlY+Ej4gcDOv2Aavp7fJUj0EMAUpWNzNzMTpL8RMClNjdRF2XT10uDsucWinlv2sxAHwDfxhlrhnHzkD/9eA07UTf1vZCNvV52Mj4JupAx1/G+4eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9UCIaVHy7n4H/pCziPfapMNrQOyx0c9jnAJXwVqSI0=;
 b=JziECCgzr+/mXiVd5JSu5c0S/2gzL5Hcz3MLeGwv64ax6/HNFBaVol3f/N8Ri6M3elaLt5oiEgjpPNrtA8CM45D6y0Dqie6JW4/FNUoD8yZME7BCeYB4WzVCpHflJlZm1IeV+s0n+cMHTmD7TuYZAgmV/MC7ll/OGXntZgi6zpW9A9xlNlqEGljJ1GQENZVZGOk0Mr7EE2aUJbP3qhfczYAvecGr+BtOkq2+EeLNbd/kiFj5ZkwxyDzGHsPF9S6Gr599pKEi5GOfT3RydOjpJ1MeT3dGHifD3rS4LuA5eVMQF323/4fMBKFd9ITn8zAI5eAeNEuYVzQOYQ+mLRgP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ2PR03MB7041.namprd03.prod.outlook.com (2603:10b6:a03:4f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:23:23 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:23:23 +0000
Date: Thu, 24 Sep 2026 09:24:33 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: serialize buffer teardown with mode claims
Message-ID: <arTeK0QadzWkI6jH@nsa>
References: <20260921062421.64647-1-kimjinseob88@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921062421.64647-1-kimjinseob88@gmail.com>
X-ClientProxiedBy: MR1P264CA0132.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::7) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ2PR03MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e065b8a-a42f-45dc-a428-08df1a1518e9
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 8CQgAl1+tOKfCcJnT3dFocba83kZkIq75VWwtKZUw5UARvmVb0yj85CJxyrKg3+JTuh0HvxvWK4e06rom6ng14tB7nOk0fP242u8KIyEq7vX1EbeKORjyvYERuHjZtP8eWAcGSG/ueFUcuZZuhQewMVcC4u8S2WAmXJgFBehC1EEhnSpit02EkgQpLOJzO0V+yB4j8X1hEOVfb5Wyk8dWYTgNT4V1DhqWNRK0g6S56rbgKUJahy1RQ+2N9I2k/6nASWLSRmkRIYcwYXuSoCRkoJykPudZtmyXeUz6DqCM19cyYgKfjAM2EUAgBxasPpxFrUEEVcZ45eHv3ZE64PB9aA9x6vmBwfYyVIB6/U0bO1Ev4Rh4KeH/1P/K+wWyosN8sWqVeZUEox2sirCDQWGg+rl+82dWI/gsbfS/pk3kBtvCsntdfljEZZhJs/BqPDJ8OGMX7xMgLVJHTL4lIrKeUUaVTT5F9v6EQVTmARBJb3uOpMTA1HvAYFn75FXvvvlRmbRH0SoeGcFL4CcSPij9NklkYqgT9G+Eurcz74iNRpVR1ecIncNfGseZSS8Y1GNpT3/5SMp941TH3stha2vl/TEj/TivPyivqO7gsHy7XvhLxn5sjN4fWUCSzhGNBLcS/xnBDw6Kp4WGRKopxARwNy1GuPfX+onsvfUT1PaLSI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QUVyMlowZnZyVldCUm9BcUdTZzhZeTZnYTF4VnRnRlhMWlBVcWszT09YQ21i?=
 =?utf-8?B?T1pDaEdMUWtuV2xVN08zaXk5UytWZGNiMmM1U2IvZ1AwdmoxdHdIaGM4bXVz?=
 =?utf-8?B?MWhSU1V3S2xpZlRUWjRBMVZjd3ZMNUsxNkJDQ3BiUVN3OTVPblB6dTBBM2RG?=
 =?utf-8?B?MlRoMWxsQW5UTFN0cmNlMmdmaW5KVjZuRFlyTUkwbUNoSjY4VWx3dFpWdHdR?=
 =?utf-8?B?WHhINmsxY0o2cy9JdzU3WkNPdndBdjVkcDRsSHJBMlRzYnR1UmhTb3NvNlY5?=
 =?utf-8?B?bHdYN0VsTnN0Z1NVSVFhaEMzREF1a2kxRHN3b2NBK1h1bnlJZlpXeFE2bGdU?=
 =?utf-8?B?NkZOVG1OWDdNR2RWcnQ0K0ZzU01pQXZ1bVBZMDR3eC9HUE5XT3FkVGdWQzF0?=
 =?utf-8?B?Z0xXbFRQRWc3ZlNMcHdXeXR4M2Z6Z25hVUlvcnlLNEM5MTVDcVA4VHV6ZWR6?=
 =?utf-8?B?ZHJ6ci90VE1MNHNhMWFQK0hlcXVZMUEwTkEzL2RrTXAvcmVPL3cwbWVlWURE?=
 =?utf-8?B?Tm02MVZJaU1aNmZtYjJ3ajFwa2hTdmN0dzVlbkx6STJzcjFXNnZkWWI3Ry91?=
 =?utf-8?B?c093QXhrZlhjQTFKT0ttSnYzWk8zNGlBU08rRFhlODlCT3BWYitsV0NpMURP?=
 =?utf-8?B?dFJqc2dvR2kzdngwaTBKci9Ed0VGUmFlaXRzcm9IcG5ORVBrV0NycUtOVWha?=
 =?utf-8?B?aXdCZEJHOWNDRXQ0N2w5c1dLVWZnT3EzTGdmY3dsUXZsd0lyZVVFdGRydVhF?=
 =?utf-8?B?a3BBd1hTaWhoVlZFdFhDbWhuUEZ2NmppTXhKNVlpOWVuWnlrYytEWis3YTFJ?=
 =?utf-8?B?d2VTNUFzNjd0aWxtdVphUDNDOC9ickl4ZmJuNUgyQTVPUXNPUkZDbTdTTTUz?=
 =?utf-8?B?cjdSaWNsbmRQOGVZYzM3eFNqcDYwaWROanNGVkxpT0xTOWd1Mkozcmtzem1u?=
 =?utf-8?B?dk80K0JJdm1SdWNqVGRzL1cwbk0rMERycmVweTcrdnRLVDE3dkVYR0U4RHNN?=
 =?utf-8?B?d3FUb1N4MnpJd2x4bkFsdXFvejcyYjZSU0FPK1ArRnp1OVI2bEZNNjA5bk5x?=
 =?utf-8?B?K2lML2ZIR0lSZDZIczRVTmlWVkNTc2hvd0Ezd1FBbllKUUhualVJTktRMHZU?=
 =?utf-8?B?WHlKS0cwRkRjcDFFUUl5VzVWUGNVWTVkRFczZmc0M3JxQXBVSVdlVjVXT3ZJ?=
 =?utf-8?B?MVg4QmR5Nk05TitISmRONExMT2MvdkRHdlBoOTRTQk5LL0s0SnFEV05SRmtw?=
 =?utf-8?B?and0UGp0dklIRkRoOWNrOHJCNTJnSW5OMjR1TERQWUp0cWFVRnNRSVhHRWhV?=
 =?utf-8?B?WXRWUjdEb091ckpMNG53ZlFDQ1ViMDdFU1o2MzljVmJwb1d4aHl0empIODh4?=
 =?utf-8?B?UmlJS2NYckJDaDlTU3Urb2lKSktBbkNsVzVFVGdYRTl1a1oraC9qWnlWUmNW?=
 =?utf-8?B?MldIK1RRaER3aDA2YVEvMWZiWWcxMStkTCtQZ1dzYlVsUytUNHZRMkhOdXpV?=
 =?utf-8?B?bTJMdkZmR1cvcmMvZWNVUUNWQTdKbi91V0hqOWNlZFZwa3d3R0FjWVdIamdI?=
 =?utf-8?B?b2tVSThsb1ozWkI5M1JHUnplZXFmU2JzZVl6UVVLa01qM2FmcS9UUDBOQi9q?=
 =?utf-8?B?eVJpN2ZqQVp0Wko3MGxIRU9SQjIrRjZXdjVnVWVUOHVtci9ER1B4SjdDeCs5?=
 =?utf-8?B?N2dnUkg1WTcxSHJPS1NrdkNTUVZmSi95ckpkYm40Q0NsUDArVjNZZXVqS0Rw?=
 =?utf-8?B?NE5vL3MzbjNEZGpVdTMxL3lyZDNzUWh6UGNjWENwM0hhSGVUb3YySElFMEZN?=
 =?utf-8?B?Z0NkSURvbGRNUnhYbm1GN3hjRnRqMVdMZ1EyVTA1M1piVmRHNmUrc082em0y?=
 =?utf-8?B?UDZyTzE4NFMxdVV4NDJmQ0hmSnB6WkYyek81MGduK01RQVlTZkxnemVxTGMw?=
 =?utf-8?B?a3FQUlNqbFMvbmVIbXd2YzlQcmZjR094aDNKUFQ3eWxUbUtNR0MzTGJSVG1M?=
 =?utf-8?B?SFdYajhuZmRWWTdLS3dwK1BEQXlzR3ZzR0xUSG12VWRiUVhqdmxGY2dEbThu?=
 =?utf-8?B?S21wejhHMENIbFUySXQ1M1RVZ3V6VW1vakZZZnZlZzV1ZmU2K1NJWXk0b3pO?=
 =?utf-8?B?YmtHWUpLTE8rallmU0RxNytOLzBnc1RNSWx0R1lWcXBqejNrM2lLemZMNnJ3?=
 =?utf-8?B?S3NVOVBLYS8wanFOVmtHRFpQc29RVlk5dU1QTFRYM2x2U2tLcXY1VHBYUWJs?=
 =?utf-8?B?eEhjaHFjYXNmQ2hNZEVWYW04aGNyQWdub0pEVDJ4b29YMURuakJUM1MzUEdJ?=
 =?utf-8?B?Z2NlakczNk0wWlVpcnpFWjVPMjljMkovYXNDN0RCQ0REaHRZakRsdz09?=
X-Exchange-RoutingPolicyChecked:
	NHiis1Ioe1bUWMByv+KkhyTAFgzo8cxyjsBXA0SUp+2Qp5tp44eBcKlNIBbgOSd2ZO2bjML2ehUCGpLNXmMUeS7mCA2PkmKwz3wM53b4lx1TZMWrMVeyXqKbaFj1k6SWdYyBimIUcmnlJI7NY4HdnWooJk6DA2J71cZXOb4ociF8KmDtEpgztVB0x0H+VFXvOUcouz0eTlWNUmpVsqbJZEz808GPKZysaT/Ztet/MWx4KLh5pXh8F2RFHShYvmHN1kgACKkzQIwjTzibYN4Ar06YeH1bMMa7Cx1w0t6GVCK1+3HVVoxaWuR9OqCQuMsj93oW8vH+ednqwH/JdPxY/A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e065b8a-a42f-45dc-a428-08df1a1518e9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:23:22.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmDv6wofecMj0OywegqPgTRiSeBmz8CHbhk4C6NPKUUoG9R7qEuPjK0gGoAuSI1XFWDQmNERDtJOVrCAkgw3nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7041
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzNSBTYWx0ZWRfX2/2N1sGgzcZh
 PFGd/TfDjSJ0uLF9n7TSXERbbtq5CrSP9FSblPs9kNeZnByqR2DgS29J1zPj89Km4pDycDiMHmg
 U7lcmgewQ2ZahF6BrTSGHUuAzZs3OvlzJIWZnLdovYygu6gwfnua
X-Authority-Analysis: v=2.4 cv=HIlWhYtv c=1 sm=1 tr=0 ts=6ab4ddfe cx=c_pps
 a=mbkJAKHg+hX/fqCzz7NXWQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=OlHv5hcoteOcDT8xsDcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gLUIsmlM7g3xrvpTZSn7VSVq_ZLJ0WRs
X-Proofpoint-GUID: gLUIsmlM7g3xrvpTZSn7VSVq_ZLJ0WRs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzNSBTYWx0ZWRfXzCZ/XwyYxeW0
 J57G8HEf6Zmpf6l5nc5wtDP2qF2JJAKlNwn14Hz9Wt5GrBi2Ti9qOahd47OfmC4v+CiiJVpF/b6
 LTp87GdH8pXILCYGfIx2RRcDhTmALoL4/oILZVRmyXtESGtsFzZINGrABY6XcM+CXjCSfsyJAeG
 yUOxVjvvnjd/F/iKQW9mxTJnjwU616uOiqbXoHdh0FyKlx0lH96QRQvTVpnz5d/Yc4AqDeYvBvA
 cSo/XXuyWb0nFkdZc0ViVLJlIhXfSxDsC9ah+pkeWmO+yBICS2Y6ZvyHXcRbT+oSG/Fp3stu+Un
 v5rIigmlro1AstwfpM7Uko/69feOVMsiTxILJ3nbhe/Zp1D6weeAzfAdBuOOg7znAV2kG9lYgEJ
 JdZ5PP7pHje/JlH4k+H1AniKhTbAn7TczhGntcvX1WV6OTDo6djMJQOnie72qNViDdvHXkxEYKV
 gwkSQ4NC7JIr0k8gdqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240035

On Mon, Sep 21, 2026 at 03:24:21PM +0900, Jinseob Kim wrote:
> Buffer-mode claims hold mlock to guarantee that the device remains in
> buffer mode until the claim is released. Normal buffer updates take
> info_exist_lock followed by mlock in iio_update_buffers().
> 
> However, iio_device_unregister() disables and deactivates all buffers
> without taking mlock. This can invalidate buffer state, including
> active_scan_mask, while a buffer-mode claim is held.
> 
> Take mlock in iio_disable_all_buffers() so that unregister honors the
> mode-claim lifetime guarantee. The info_exist_lock -> mlock ordering
> matches iio_update_buffers().
> 
> Fixes: 0a8565425afd ("iio: core: introduce iio_device_{claim|release}_buffer_mode() APIs")
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/industrialio-buffer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 2c9ec93dff47..d60bad5492e7 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1377,6 +1377,10 @@ EXPORT_SYMBOL_GPL(iio_update_buffers);
>  
>  void iio_disable_all_buffers(struct iio_dev *indio_dev)
>  {
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +
> +	guard(mutex)(&iio_dev_opaque->mlock);
> +
>  	iio_disable_buffers(indio_dev);
>  	iio_buffer_deactivate_all(indio_dev);
>  }
> 
> base-commit: dceba8e581e3e8f475da0efbd7a73f3d9524ddd2
> -- 
> 2.43.0
> 
