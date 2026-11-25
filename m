Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795605278;
	b=e3YWLZMPhUdWVhzhHMLfu8n2g5K8YH8hS/9tRoiAPHxo3XpOD3By5U+RX8OMctzhrzgf
	 gZyxU+PJX1bFjvcgY+nkOz/xBPDaxuhmmjxioIoQXLXkqqZdjHZrHsfwvL7rLGP0xgpQ0
	 6OjqbB4mtjecYkeqJg2zrCq35PjhwHfkJHQu0TTqrLW6UdJuEh7pivV1N52AES6KT+nXt
	 9C7nicj6A/80udt6Q8ZyssbYZDcMkQjhhMd8PnsU5gXKfJagbDHWMOz52wx1RGenthwTn
	 YER5tLpzZBuzMIUHKH9Gn3mqPRHhEZHacUaVJdFa+9l8myDmidYEqLEkbvV09ebN+pQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605278;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fIrLM2UKd+DxjGy+d8j8eJrOlKHDk0nDe4x0rHd8yjw=;
	b=QCI9sbBDf1KEkoqF21y62w6E9gsIRQpeAesSbqd0aVud9zSVjundhOo6kdOThIiql8oC
	 FkxVTD0CBZje9AHqLQ+n0Ys7YQhZzsSKV7Dbm8xDk64F2X9KYzQ/ckm1sN4lIWXVJMRtE
	 o0B+qoL1kVg6efAUexd7Dq8O/gi7Osf1hMVNfvqdClNLvIUgiRqBXd/DtSFAKNOoP4yax
	 5tlzl5qLuaA9StzTDWus7P2CbMP+/4M8SiJHjzXankrue0GwwQA239doOWlGuyuRIxDb9
	 H5xCVOsVIAFFMNR1EpSetgeXthEYXphJO7xK3u3Q9Xp21XcRt2xCa44AG7df+hIhsCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pUyra3Dx;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=tf7xaEO2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96592606A321;
	Wed, 25 Nov 2026 11:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96592606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pUyra3Dx;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=tf7xaEO2
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9obIh4131509;
	Wed, 25 Nov 2026 06:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=fIrLM2UKd+DxjGy+d8j8eJrOlKHDk0nDe4x0rHd8yjw=; b=pUyra3D
	xiRule7lJ5ZqIaWEZpyKUo5jMXkil03sGJo2Q0ihGlrjOVT6eooVZqzfnUGK8m7G
	zviD4wDuIWfS2IyTPpnncIKMgU5tpUpVlyqQRTFBQDJUB9W3rTBU1HjLBu4i7gSI
	w3XeJkZH/06jqHn1O3fyAAeU6dAxMri1IIgYhTf0sc5ZFyBcjVnBkFbpgnHvTbVO
	6801aiBOySNpegN4Y8Blxj0woU5LZKm7zl9KDPggbxaQKQLbF3hyXW8W+qbd7CgM
	/yyYnC1ExpKWxFuMPZXGsOM7IXxOzCH2ifE8d/XyTqJCtgvlEwJ5sAi13fyAHQ84
	ElG+T+CJAHk+Xug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fIrLM
	2UKd+DxjGy+d8j8eJrOlKHDk0nDe4x0rHd8yjw=; b=tf7xaEO2+w6ejPHS/53rK
	h8ca63Q869Xp/FFF/In03PuaYHRM+ursEjg8Yts5xYrzxol4Nj/0exraXE7qwjut
	z4Lt2+Ngq32JTzfUq2paFZ6suti5t30XPp6mxo46Zt2GWXFlPWsgNjdfUGyBw/1q
	Qpmurl6l248upnt4HcKX7wUWl2k/wFWf1CS2/YKBcJe6FJ4J9R99gM4SD4mrjhKK
	PJF19NVPjxDlQpCgt0a2diBZQOOwtLFrAYxuLqzIF9DP98KU2keNdNcCNF2QFrhc
	95p58vdf3ZLKnGml15OFr2ryxReFOnP59Jyc3TP+OYu1ObUwPkgxgqlpi0MRrmYm
	Q==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j56d6qth3-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 06:14:26 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omkYudt7ruXZR6pQ3Z2aaiHhXcIB4AE6VF4n7XmzrhEDBj2CsALVJiIsYY4seBn9W9MeDGMcb+fUws0CohGnBL72eimQKXE+7pRhtT/0lcnZwPJZ0GhwMe6rqLSL5ekpKdlaiw8LNLA80/vtNof7+Du3WKY38YdlNwCWuI3Ig31Hg3063zlC0BusE0bEDI9mbjVxXtRPe7NplirDhIT72p8Th/gleO0Up5ljaf0HLK2lYg9PEWuEIf9vhmsXndAhZPmD6akJCtTgKdBCr6r9v0QFmU+sqSsNOtGVxtl9a2gMtFtVb3F1ladOUmjWDL70gwvYMrzPF4nr11y6QvPlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIrLM2UKd+DxjGy+d8j8eJrOlKHDk0nDe4x0rHd8yjw=;
 b=JbAVCYyDmcAUzZa0+R6+NFMuDu/OA3sPbK5pOreN6AAQ1I1ZNzvIPIitF3j+x3HiiwdwgCDwSinhyKZSpWAAKpjE79KXkox3dajiMet750ZSgmohz+TFimaJG1+S+3gyidg2bMWdeCHdy1kRUTADDfECwxKscHl/PPSaiIKAJ6MtBfCRc4CGuImNynO/biKswlibDlGkDtTC5zb1HJxnxou1nMG3CBV/d6VlJijanC2U3Uer8wE657nWGiVWiDvsGhDKGaJgM8wuWkil5Vimg9XAWDA68mGOrd/rWAI/IBXkljcgBSh1jQpTuAFSYLiftQJBLdoNQUkLBpmZTU4bEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH0PR03MB5750.namprd03.prod.outlook.com (2603:10b6:510:31::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 11:14:23 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 11:14:23 +0000
Date: Wed, 25 Nov 2026 11:14:19 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: jic23@kernel.org, Michael.Hennerich@analog.com, dlechner@baylibre.com,
        andy@kernel.org, linux@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iio: adis_buffer: fix buffer ordering for IIO core
 demultiplexing
Message-ID: <awbCr2uksnL2X6tM@nsa>
References: <20260925110239.59320-1-shehryar.amd@gmail.com>
 <atCoXDKG3XNYvP07@nsa>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atCoXDKG3XNYvP07@nsa>
X-ClientProxiedBy: ZR2P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::17) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH0PR03MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b89e524-9ba7-4903-767d-08df4ae5427d
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|4143699003|261009223027099003|22082099003|18002099003|10067099003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
 Ic/6Gg4ic3coEbaq9mDnRHEmSHWe4OE5Xr9vm5yqcgHcEx4CW1Xfv2vMVQv59qKynEO+uK28UEBtdBt7QyciunFx8zBUvuxVd+ZFACC5xXcWLKmBxfCtUy2zYsfUR5jXwfbirvIfSgwai3y+3LrAD1a4pwEbSn9Xd7mUtshed53W1ZkGaWvfTLuLVy2Ex2GGNMxuZ6g7LKPGxqLDE7p1/aGImtWeZnV0OnkeMp31Tjq1iwCV1fk0zwmZmG3/VA/+i/sH0NMnxpabqs6rnF2bUyTpoSpDiytpuTC/I0YTInPnCTGxmExBVA0Or413546QWsOjtx1kRndExOih9hYzgsSb93duI/uLs5P5KwZ/8ICwtT2weOnoudYbHpCS3Xf5z6qwDOHCQLwquEQ3W/SqO24iOJR9+diPts9I+fv0KOK2umSU0iGm7344APBuGeXu5POz3+MgiRVpTIC1aZOmOa3wOZgUNsCtAa5Cuh9Wfig0K4i4EshLNtIKtbGN8ufubMgucRA0gGHqJGC/NUtxkhapMHgPSjqYBdNpbvoJeljwU06/cvb4KqnctHdZTptaNx6qLw5W3W9snCUwc1FcxiAShp83ESLL4cBwH6ifAzbC2bMwwEz9WvGD/w6BeBAI
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(4143699003)(261009223027099003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?THB2UWFZKzBQR3VpY2oxdG1IVDBmS3RhelYxN1U0SjJoN3JKVExRK2FuTG9k?=
 =?utf-8?B?VXV4eDBSMk9OQkdBUnF6T1cxQ0x1eVR0WC9PbXV4eHJFMkc3a2lvNHQ2dnFk?=
 =?utf-8?B?bmo0bWRtZWdrNWFDb1RkRDlGZ0lmL1ZUTVpMeEFJeDk5Q2p5SDczTWVmdVBN?=
 =?utf-8?B?c3hCNlB5V3VrbzRodkVQVm5vKzltZEFHV1EycEI4ZWtBNjlQeDZPMUFwbFM5?=
 =?utf-8?B?a1RkVHROZktWOVM5ZTd6Nm55dElzQlJYbm5QVElIWWNWaTZ5NHdUdFJWQVVH?=
 =?utf-8?B?VWhLWmkySGFlQTFvbFlrS2RzcDFWbzFTQm02d0NoK1QyaXFhSHJRcFNmZjFn?=
 =?utf-8?B?eXF0b2ZqOUluaFlpaGFiMkRDV1Y4V25pQnhDK0RORFhVMEFyNERsSFhZbWpT?=
 =?utf-8?B?ZVM5eDN2TVhiaU04YWV0Y0xjTmxQTnVZQzlZRkxqNHBGY1FBcTd3alBLNEFu?=
 =?utf-8?B?YnJkSFk3elRzdDQ3TURxbEFjWnkvSG1QbTBxOE9LVFdrdWIwaGJNczZhMXZa?=
 =?utf-8?B?eE0rRHN6MFFVcGZsakkzMHBERDVXWitFSTdnYllSSm9GbElRakdCOW1PUXEx?=
 =?utf-8?B?WWhITzh5dVkydzN1TDZ6dWh3REU5UUJXOTk2eCtvN0xMMFdhbld4VHdXSEtq?=
 =?utf-8?B?R05qRmdEcERJWW15OXVjWDRYajZnRU1WSC9JN0Vxck9sQVN3WDlXakRsN3V6?=
 =?utf-8?B?YVJPUVdDQUl5VDRwRkF1QkZGSTlObUFOSldQdFdWblNYNTBLcWo2MkJZYmU3?=
 =?utf-8?B?cnEzbHU3TUZ0OHJUd1IzSEhYUjNnWndYVkc2VkJMQkgwTFZjTzVpSXVQWWN4?=
 =?utf-8?B?cTR4ekhZTFhiakNDWklYVk1JU252VG1sdVBRZm5JUGlPSGxNaHpEUmxKWGNE?=
 =?utf-8?B?U1ZZcHFJc3YxZkw5YWJneUJFWUEvQ1BmbGtEeDlJSC82UmUwZnQzNzF3QVdo?=
 =?utf-8?B?WGR4d0lGbnYydHVYYTJ1MzZUSDc3NnBGa2U1ajZ5WU9GN0FOc2gvYnorNEFE?=
 =?utf-8?B?UHM4V0d6ZnFBZEFzQVR6YkxDZ3pJUTc2VXJveFJxdTZnU0FFanp0ZmZ4NjR3?=
 =?utf-8?B?bXp0OE1KSHlleXNnVVVKS0J0VGxDaEtEbTZxNlgvbVA2blJNeDRSUU1iaWNW?=
 =?utf-8?B?cWUvWi9XYngwbHJPdEgydXBJcnN4Zm94RVlybWJvYWplMjVBUjhMSHM1cW1H?=
 =?utf-8?B?b2FDU2s3MXRjb2NVSWU5YlYvYmo5QVA0Y0l3d3J1NXNQV0tqZkt1ZkVoVE1D?=
 =?utf-8?B?OHk1am1RVlA3dmNLU1lZY0ZodHRMUVo0Z2E4MTlmZndpbS9POGg3dDFaay9Z?=
 =?utf-8?B?TkhUL0p5T1dKdDlQb2kyOG9hb2pkUEcvSnd0QTZsejljWjRiazdzY1hsQ2My?=
 =?utf-8?B?Ylc2MGU5SHlJNjlsckp5RisvalhFMDB3N0dBMytWcGQ5WXNEOXM1Y3VZblBT?=
 =?utf-8?B?U0N3N09lR3hBNzZBZ0owSjdaM3g1U296QkZZaS84eVkrdHRMeGRmdTA2d0Iw?=
 =?utf-8?B?Q3Z2RmJ1dk9vN2kzb21ITTBXL28rZ0NnZXk3b2JhK3lIejFLSDJnTzRaaGVu?=
 =?utf-8?B?VUpnbm1FSVg0QkV6ditmWjZnSzhiMUYzdyszRTJxamR1RW1rUU9qNHhWNWNs?=
 =?utf-8?B?MkNocU5pOUVvVXE1bDFCTkJWQ3pFSEQwNmFLYWsxMUg5Q3VhYVJCMDF0bFdh?=
 =?utf-8?B?akV3dS80b3FtaHBteER4TGVKOCtIWFRNVkgyOXpjcEpyelZkL29lVW16dlZp?=
 =?utf-8?B?S3lNRGpWVHlCTU16dVg2Sjl1UEZPMWk3emcvYXRJTFBUcWpoSERETy94dnBy?=
 =?utf-8?B?TktFcGdLTi96YkFvNnQyd2ZSL3VBV2wvbERlYXpBTkJFK1diS084NWd3WUJX?=
 =?utf-8?B?blAyQ3JpYnVoS0Iybnc4WUZyZGozMVdpL3JqbUZVdWZ5Z3EvdGEyeERRUnQw?=
 =?utf-8?B?TmJtZ3B5MUZRZHdNSisySlVtR25Ea2RCY0lvQUc2MTVMVHYwYkQxdWpWSHAv?=
 =?utf-8?B?QTFvakFTZ1VDV25CQ1JFRndxemVZWlF6cGZwVUVZK3FTeEsvejl3STRuRnFr?=
 =?utf-8?B?eEc1c2VyelN5ZDNMem96RkhGZjVIUFpxZlhRL3M1RjU3alZVU01rclRwSGgx?=
 =?utf-8?B?TStWNW43YXNENGxWcFpyS2V3KzVVcWFmWXJCNi8xeXVaQ0sxZ0JUbHk2M3Ni?=
 =?utf-8?B?eGpmVHpTRGhsU1Z2WEwvT2p3RkRMRGwwZWRGRHNhTHpxMEU4WDRVbi9ldmhB?=
 =?utf-8?B?RXpkM1pKRkk4emNxWitJcWhSZnEyV3lqOWFYSmdON2VUdHdvZEFYMG1TSkNp?=
 =?utf-8?B?UVVqbWxyVlRtQ2JEM2tqSkJrcHBYazBSTmxaQnhwa2ttaWtIb3d6dz09?=
X-Exchange-RoutingPolicyChecked:
	Yhe9OaSZHAY8/9vz6byhN0mTnFQmI5GxEe6dGKMiIxT3tnIZdEXRTvw5+IFBLt2EK5zGRPQ+dCGX+Pqjfq6RA7NfD3A2FD84Q7QYQB6FPneb4+H+mnxnAvK5+fo9OYRt0YBZ9ddtv9Owp5fUOCr7SWFxYKtpmrY0emQ91POK/VFg2GHW6EzWkk95WiTlIruCbFGuiHQfjR6FN6Wa4XmkaIBMGZ5Z7ByzpUtKbd2FVjKLcQZPcuVXQnf1YCYnEhPbGZTxTMjlEET3J+TP6igy0IfVLTSeS2QTHQV5iczOsdpDRqUH9rb/RiH7QkY9D70Q+xe1PrmkK3rpS6ek/BhN8g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b89e524-9ba7-4903-767d-08df4ae5427d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 11:14:23.5939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LabX3ezCmzfi4y1vCc/DdtaRtlNuadWCJ/zqpyPkmj3wbH1OzNvYXO3CCnbayB3m3Ihj5MtKjpQdOyzYm2451Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5750
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NCBTYWx0ZWRfXz68Z016hHGLr
 XO8nIOizd8XY23+PJAo4rWLtWskFq3vbuyC7Y0FlideiMBf0AkTTsaHMwgxcTIm6OPvPvqAvTqg
 Bs3+S1VZR0Vzm16cTCEpIPM6VAPwLL1PpxVm6e7/vzq50J5/IUy0LhieQLgiGfcVjuBLRtl3ouV
 geUDNDF4iNVdo6zwZRGW7Ini5bKTT3a2R54rmfYmf0QY6/iW/I9YLYuibCP8vfCdjEQ6V6yGHNT
 CnRLEnodOwsME1e5zqx2OdnLhxd6qk4NuJW8i27xMdPm8nIBTC6cxTiwvSIbtJJNMs1mgAAcev5
 jyMIU1Nakttxr8QE2Xw85VdJ2BwTjq4s1UpfMRZ/mhNuB8P45nqz/3iu2kvvmXX1tRVNCYEkbP7
 DaGbsa8H+35d2GQUDin02T2KCXV0nVSxjdxl4lPLtOGA1PF08tE+TAwOcMkdL5xQAiQnJYpjaQx
 vaqMxcxDlB3p6gWQGFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NCBTYWx0ZWRfXxXlRrDiV8l4c
 3I0Ka7uBPUFNZ/g4lUzCvqs1sA352FF9oXiwLifF+9EV2yJxyztuN2dIcSHQliIw8+1ce16582r
 WJCk3QHqMyQ2DfadZyVapjdbCW6JDbTHW/yLJvY7Bh0kXw102jTf
X-Authority-Analysis: v=2.4 cv=bv3Zl0ai c=1 sm=1 tr=0 ts=6b06c312 cx=c_pps
 a=TKURuYQIacZDyiG+Utq8vw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=tkBr6JfORJmkDv7lqS0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HSmXg4VyUFgIjkvDa1FotAicavpCoQTb
X-Proofpoint-GUID: HSmXg4VyUFgIjkvDa1FotAicavpCoQTb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250044

On Thu, Oct 15, 2026 at 11:21:07AM +0100, Nuno Sá wrote:
> On Fri, Sep 25, 2026 at 04:02:39PM +0500, Shehryar Ahmad wrote:
> > Hi Jonathan,
> > 
> > After issue raised by Sashiko in adis16203 graduation series [1], looking at
> > other drivers if they might have same issue. It appears that the root
> > cause is in adis_buffer.c itself. The library constructs the SPI
> > transaction in channel array order while IIO core demultiplexes in
> > scan_index order.
> > 
> > adis16209 and adis16260 have the same mismatched ordering that
> > adis16201/16203 had.
> > 
> > Rather than reordering channel arrays in affected driver,
> > would it be sensible to make adis_update_scan_mode() iterate
> > in scan_index order instead of channel array order?
> > 
> > Would this be the right approach, or is there something I'm missing?
> > 
> > [1]: https://lore.kernel.org/all/20260914015321.7a660ab5@jic23-hlaptop/
> > 
> > Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
> > ---
> >  drivers/iio/imu/adis_buffer.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> > index 501da4eae..45200b753 100644
> > --- a/drivers/iio/imu/adis_buffer.c
> > +++ b/drivers/iio/imu/adis_buffer.c
> > @@ -110,10 +110,10 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
> >  		spi_message_add_tail(&adis->xfer[j], &adis->msg);
> >  	}
> >  
> > -	chan = indio_dev->channels;
> > -	for (i = 0; i < indio_dev->num_channels; i++, chan++) {
> > -		if (!test_bit(chan->scan_index, scan_mask))
> > -			continue;
> > +	for_each_set_bit(i, scan_mask, iio_get_masklength(indio_dev)) {
> 
> I guess it can be iio_for_each_active_channel()

So given that we confirmed and got this tested and with the above
change:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> 
> - Nuno Sá
> 
> > +		chan = iio_find_channel_from_si(indio_dev, i);
> > +		if (!chan)
> > +			return -EINVAL;
> >  		if (chan->scan_type.storagebits == 32)
> >  			*tx++ = cpu_to_be16((chan->address + 2) << 8);
> >  		*tx++ = cpu_to_be16(chan->address << 8);
> > -- 
> > 2.55.0
> > 
