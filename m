Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EEE3932C0;
	Tue,  3 Mar 2026 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574287; cv=fail; b=K8PEi8wLHz0Xg/WKb660G5j+8Yb8ztLXZhwZbOePCFr2KbocHEBwmtNBbDHhpq3O5sdS6v4waQ3XqC4dme3qGkA4i23ZOE5OZ/C/rPTARca+pJ8Tt7rijgEYwcP6Roucct7rD02msNvcNAN71Db98MASHar0+lpaJe4SFmFX3/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574287; c=relaxed/simple;
	bh=/nW+VppnHuazGVMcQVEJgoQ2+4Te9ath+zoeZDn9JGE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zi8ozUnbuPYRm3NBqEvYRNMMjp8UwqoUSTCKjPt72kLnqo6LPnUtszGXTKGR14wv26AcAtQZTEdAStXSDGOy77NZxBrKrOloohHaLY61bHXEKIYY0uzluruROVtl61Qy0rsWdWUQ6Tdk3MAH5/BwjXoijmIrgcjRAyiXChM9lOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iCmUOk/Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vVe4HICB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iCmUOk/Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vVe4HICB"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623Je8D51124667;
	Tue, 3 Mar 2026 21:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NokUzqv32mm6BDWYIz0JzWfK1xhaDTQ7AirSl4R39sE=; b=
	iCmUOk/YexsiHYxcdyr7VyBNThJ97WNTy5DKRzTTpZrBG83ElBiRH8/+wwxyrvdq
	GxRd4jT3eY7qHnsPT4t0kx68WSGcG3WI0DYiQ2yWIRpB5CHNVqOSnowBn9UNcmaK
	0le9H9KOyh51Yw/P+b5nIQY7AH2sUoonRrasJ1sCr0n4Huq2iJKNDyJ01UnncBKc
	0w+HtyT9Vf0Q8/IZRryzg1AoOqyuNeUwE9tBsEeu7sd25fSZ74Mt3RI5wjSeKMBk
	CiBpp9BuInp3nEyQ4pkCFsVA5idwqIcRGehJAqigETCeVuRTh+XYW1UNMpb0fYfE
	+yhoSMzYvS2HqXWuN4meLg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp60m081x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 21:44:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623K2N3I036944;
	Tue, 3 Mar 2026 21:44:39 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptancuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 21:44:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfMpj0985BMw6HYv0AtTMT/M6IC5/LvCOAo21yIV0FUv47DMpH8Tl8ayCXq3FIHwGLb/PONftT0SjkOynbqRavErAL/6KEpQoxhM/PmhKhE6D5Y4t/r/b3Kg+trEN27OtXqmia0zkZCLczp9zRJO+/WAT/YcaJxuEd13Zqz5uiKCDfr9EibqbdmYfrXPYoQG85UHsJ5epKZvp3symPUTzzEVwnbje/rNtWkqz2/AON4QWVBH5k4ZNhqZSNtfZrDYxW/lPBQNi0QAk3nUiRU0AHDePhF/78WTonDIkzgRP7t3AB1RL5q4DfbeO8l5lJDk6/DMplxfxgR9JfSHrcB/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NokUzqv32mm6BDWYIz0JzWfK1xhaDTQ7AirSl4R39sE=;
 b=vc6msSa/8S7SH4LizBcqI7u5exX3q7jjRBRGDhBbm6tFx4dc9C8xi1Z9sZbCYEofZcJA1lEwEq9uQ0p+voTf/e1MS/SsClzFE9uzBl3QtemHf9jn8gPExJDYtgLXhgrpfzyQwWdDG3XvZTc72Gv7VCM/su209bn98tVJW5YRvwsTUd8FsiR0YgfQOa+aRy0sca9aoR1NYUUvE3zcLiSt9HOLy49z19q0dIdTS3k9iayi079kTxXEgG7nteqT1I2cbIgLxgbY8rvskACrMbtwMesboBfCazk/bjJv44BD+OHiLCm0s+F8IF9DHiyIyIyW6v/Aa0Yll7M+IvHCBihB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NokUzqv32mm6BDWYIz0JzWfK1xhaDTQ7AirSl4R39sE=;
 b=vVe4HICB9xm+gtYzzMXJkiG95nd7razp4TAUNUu9B8Gn6/3Rz4jzaHHFSHTsirx7V9+TWwdQm5VZYg9TsWBPuRVOBrVyjBCHKbPTXBWGZRZjnVi0c+3H0QJYv3A/hoanjeDsK+A6us9PxbFvxORhRE6z9PeUNZTtcC+AI7+c59U=
Received: from PH5PR10MB997711.namprd10.prod.outlook.com
 (2603:10b6:510:39d::23) by CH0PR10MB4859.namprd10.prod.outlook.com
 (2603:10b6:610:da::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 21:44:35 +0000
Received: from PH5PR10MB997711.namprd10.prod.outlook.com
 ([fe80::be1e:6a43:6b56:32f6]) by PH5PR10MB997711.namprd10.prod.outlook.com
 ([fe80::be1e:6a43:6b56:32f6%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 21:44:35 +0000
Message-ID: <ebb66676-4ce9-4852-bbd3-951563463564@oracle.com>
Date: Wed, 4 Mar 2026 03:14:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 next 7/7] iio: sca3000: manage device registration with
 devm helper
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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
 <51ca89f5-6db7-408e-8590-774286d544ae@oracle.com>
 <20260303214115.4a74b396@jic23-huawei>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260303214115.4a74b396@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::16) To PH5PR10MB997711.namprd10.prod.outlook.com
 (2603:10b6:510:39d::23)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PR10MB997711:EE_|CH0PR10MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f284db-679e-4575-6f6b-08de796e0fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	MJEOCBd5TVesEYiCHbwY/JFMRx8t6W0duwUhXL5JRNn5hNRoreWePdvUqIexLfmuuaGMivWf44Q/MypsQ1SZx8oJvILYi0O6jz/2uWSkjLyILEV6OUiYqjJ0W0LZbqZtUPidQsrsbqq5+dd6cotWt3JsRxObE+T0YRpI5Aqai8kls8r4zBEEeZ254XxCOGMznVDEQHQiw1zQg/S5xbQCHunDneT+KQQIq/d2rpkfbNkK/SRuMvgIUJI0kyy2dShHpQFBAOPh6uKbq84r0vkv6ATjCA4QE4EJdFmiSdyRSB4wmLpJwgSnwYKlPXESree8bhdkw/dLOg5fuTLHLNO39WxF6TUfAo3gtq3FuzCvF7hZlyjni1Oe7xgEESBIKXMsZJ+PBA/95rrObrf7EjHo4CddwQWvPI1opSZo3TwoDbRJ+HM2Da8lwXQH7YEvsc0QlU4pmUD/MoFN2NYXWQR/YaBT7yhnvGC9v308w7vJ9t7djJIRCPdWPjbCfcBLBWKHD744sX6+ZUCZtkaH3pQqkaaUguoDqAw4NwyLUnjhDzhVccuwQtFuNZ4F1sTlIJoUThBaadvqKYjTv148HE18nbhZ46MycdZ0TxNjqL0zWqArR9C+t/oEWXRcMWtYTXokto3OXeuWDukqrcxDWogNUP9VJf+2kG+0LrB1kDg/YnlOohilT1jKV0ZX9ipED2wEhiqzbVMhK/7J9nmd8Mf1kdfqSA35s5QI4mwgWzVPqGM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH5PR10MB997711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0dXZE94emlpODAwRVlZeHh1a2hLUmtVbWlhNWRDbmtQMnRUUWV5SDJjR0VH?=
 =?utf-8?B?N00xdVFiTUFLL0hyWm1EMm9GbTlKdDNWemMvSXhZNW4zSDRKWUIzcGpwUDRL?=
 =?utf-8?B?VUhIRFRLeVVuVHJRcnM3MXcydDZQUnF4QTc1U0puQjd5NnFDM25UYkhoQ2ox?=
 =?utf-8?B?dGJTallQUnZmdklCTXd1ZXZINnFjVVBXSm03S2N3Vzh2dGNqY3V4WlB4VE9E?=
 =?utf-8?B?M0JRdVhhUS9HNm16YjBQL2x4V3REZlFNOE9HTDVpcGJ2dUhEN1A0UUhSQldq?=
 =?utf-8?B?U2Q1Y2xyZUJmL0tPS1BtS2NJUHk2UTNEUE96K3VwWGZ5M0lIZGo1eG9ISDlF?=
 =?utf-8?B?MjhaOGZubU5UdnZXRXdTbmp6MVdqQUI5RmplaXdqZFEyN3diVTl6ZWlWMHJC?=
 =?utf-8?B?c1NzaEZOUjY1a2xGQkltWFhsOUswam5CWWV3V29IQ01meXBVM2RNLzBZT1FR?=
 =?utf-8?B?QU16bGgzMVZ5WWJ2YmxHWkR1RlBCeUF0Um5FWjJPdktMb2E4cU9ZVVpScFlI?=
 =?utf-8?B?bm5RKy9FTGthRzRjMTZCQ25pTE9ZQWMreG5nMkh1REQxZnpHWHp3a0hJdGY4?=
 =?utf-8?B?dGJ5d3lPQUtJV2JnVlJPcUEvaWJYcURoQStaK3Avb1ZUcW1IWHMraUlIckpS?=
 =?utf-8?B?U2FVUW9kVHN0ZzNXZXo3c2p4RXNUeWo1YytFQVBmSkJNWVdMNEMxRnBlZnM1?=
 =?utf-8?B?VElKbCtCMDg5SnNiTkNSOEFjai9tcTZYL2VJN0k3bXlxOStGSTliUURBY1lE?=
 =?utf-8?B?RUNpTHdRWDJiNkFxNTV6TDVadWU4SER1cEVTYmpTTTNlc0tVODN6NmJiNzZQ?=
 =?utf-8?B?bVBzYURmRWFSdmN0bXpyMnZ1R09ZamFZMTQ3U2d4d0ZQZkhVanIrQ2ZsenIx?=
 =?utf-8?B?VXJVbnRCYnFWblhhUXE4akhpVEhXRnlnT0pZdnVyempnM0N3djFLbGs5Y3g2?=
 =?utf-8?B?Uy9qRzBJL2R4VGs5eGNDNTUybzRLZ0cxaGxodTlpNml3VGhqaGpEM3BoS0dR?=
 =?utf-8?B?L0t0QW5pZnJxTS9VODBMclUzYjRwNmI4V0NaUlRmRVZtbjB5eUVYcU5XYTRP?=
 =?utf-8?B?ZStGUVpLOG1ES1NWd3FDUjZHK0RFZnl1U2VSb2VxRmROZkFydlI2Q3pzckJy?=
 =?utf-8?B?VTd6Z0JCT25wb21IRzd1V29jcDQwTVhRWVpnamlEL3JXaWlBeGwrNElxMm1h?=
 =?utf-8?B?d3NJZGJJOGw0R3RhYlZGc0lDK3d2Y1pMQzF4SWpWTmNuYnhiNzNJUkUrT0FC?=
 =?utf-8?B?ckxpTU1rSmk0Smh2Y0tuRGp2RWxKeUNmL0Vab01HdmpqeFk0SE9jQ1VNZzkz?=
 =?utf-8?B?U0twTFRhbFJBVU1ub1BYdWR3T1dTOVZMWTJacm00WUNwVjhwdHZmVUNNMHNv?=
 =?utf-8?B?SWtici8wcW5JRC83dmJkVU5FQ0xoQ2NyN1V4VG45VGxSdVZDbkhKcFc0alYr?=
 =?utf-8?B?TGJxYjkvVTd4bzJJeWkvSDFVMDFxSTlrUU5FbTYrOGhNaFJCdFFnbjFFZEtL?=
 =?utf-8?B?SUZLUkUrMjNRWGpqOTJKMHhJOEJuYS9DWVdoanNFMkJ1UThDelpTb0xHZkRi?=
 =?utf-8?B?cjdMMnlZdUxIdVpIRTlVTUpsbmREUUZSdTRsY2k5Q1dUa3lLZzJxZExGUjQw?=
 =?utf-8?B?OU40YUcreUREeU9sNGxZbGtsNVFZTStxM3hWQTFWZ3JBNjBaRGY2UFJldWov?=
 =?utf-8?B?aHJwS1ZLSVJGbUxoR3JSdzNMYTNiU1lTV29EclFkM1NJRmNvMDc3RHl5aVNi?=
 =?utf-8?B?VkticVF2d3hFb2UxNWhybGpaZm1KemNsTXRoaW0rMUt1WXVEcVVKZlVVUGRK?=
 =?utf-8?B?dnZJdkZZeHBkRzFxanM1U3VKc2lzeVVPVXdINk5rZFVwblJZSS9qUzAwMmxQ?=
 =?utf-8?B?ek8vRUhQQ0ZyOHJYUWRWakNFTGVNUjBpdzM4QTEvcThPK3NZL1lVY3ppZTBL?=
 =?utf-8?B?UkEzMzVjUy9IZ0Z1QWg4VkcxenRGcmlzaVFUZlFkbStlbjQrTVVIMGZpbmlS?=
 =?utf-8?B?RE1uL0t5THcwc1BuVVpseWdKZjVDQzVCV0RGeGJ3L3BhZTNCa0p6bU5kRjdC?=
 =?utf-8?B?UGpLVko1dXZaeGVJNFZWSEJBK045eis2aFZPSE5EbzV4d0tUK3Y3dktQTDlD?=
 =?utf-8?B?K2lVOSsrSEQ5NnlnVVZ5dzZ5YkNhV1N5WVJKR0pnQWZBenpiKyt2UnVCRThT?=
 =?utf-8?B?U3ZkQ0dVU2pROHlpQVpxZ2UyNlhlU1RBWDB4MktNR01TekVwWUp1Z1Q3bXpK?=
 =?utf-8?B?c1l6aU5OenhvNzBPWTlmelU2VEszSWxMb21Sc1BWUHZGYmpTQ2IxVnluS0Rp?=
 =?utf-8?B?MmEzTzIrYld2bEd6WGZFMDFONHE2T0hZU3VFS09MWE80dVF3OXpuZmZRYUtV?=
 =?utf-8?Q?kfP5jhifdbbyxtIVOVDLiXGdiYbQDLV0v0VFs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F2583Rgi8PIkTpM9qulZ2d7f7q2S87NiF6XCPCgHyy53obqlit0ws2CeoLqVwHJIG7ZIaBOHICsrsII77Lkf7sThYqrwY2pGf2ZilHYn5iTKfR5NC9eFujf+sgr5cs47q7NXwdsNIJkvuhd2mZxxklVM/I20JIlkXmeq+t9kZRicE8494N3wY43JMVNpA9LZlxnLN/Khdr2AxNPR7cg2tIahL0tEVbTIwpNJbRT6T3cPecbMuXx88DazRNn6OZ6FOo/dkfXeLodUprigAVxEBToJkOm37Xd812BlmBa2ErWbaFP0sNS80iRCD/ht8QxPpwUIXVpiU8/yoM+Z3xARhLdmzAMvuIzhvgtgCT5snwytvCNFgw4f1j2OOF4ATvXt6R0WD4d+E3M6KC3ZpYNO697WAkHWnSPlcjFzdZy4gSHz8DztI3fnd/zecd+DFJg8m2U+I1EqFx74qJKuSODS2+QCdSE0pLmAOLfTJxk8APF5gl+VdXYf1jM0CnYyxvOlxP5ctPku2ppB5YsjMuzvhTVBuKKMiGL4LDDFUEb7gwcpTQWW5NtaOQxjskGVwS+M6L0NoypJldUttvmXStyr29X7JEtsS4P6xEISYWyfttk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f284db-679e-4575-6f6b-08de796e0fdf
X-MS-Exchange-CrossTenant-AuthSource: PH5PR10MB997711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 21:44:35.4798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Frt+1glB4VPdF+uNgWIKu68rFc54wk1tjlH/x7517N5xeij+req5S2XNhxCT3XOjGmkfr7RmWAAs5h7sZTUuTpgri0lSCGGQNZlhoeomGs1CK1bGSZuDicPYrSVChV1I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030178
X-Proofpoint-GUID: ohQNR12P7_W7TqRk_5wABqMHEEULzSmO
X-Authority-Analysis: v=2.4 cv=G9MR0tk5 c=1 sm=1 tr=0 ts=69a75647 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=85jHPHdYfmTfrkLtP94A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ohQNR12P7_W7TqRk_5wABqMHEEULzSmO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3OCBTYWx0ZWRfXxbKp2MJqrvYV
 ml409X8pPsPmknfXCy7vVDCC5gPxxyMoTEC2zax7fSUxSbCmZET1Wb0nvRv2pOSJf1NrW7VG3q1
 MRH4L7SaIeOhcXeF6T0cEIdBKOZuEKuuKtCSqMNvB4PZtXz+KTeC22A8CsdZDHCqych+8jLkSXJ
 1q8y662jk0h1l2zAEtpxHAlBpjx1ZUOMggGFgs+5uQ4H/biSBAvxJXbKRHDRLSusJIVwMZ2cLkm
 20nlDNOnxJN6tCCNNO3a7oM0aCx4BABlczzF1qXz6PXM+997opPBBWQrJoPDNqYvBkPWkbyLeCF
 sYHTXGA6Cdod92ysREwYPWO2sJsUXgu5TyuM06V7UtKuF19deRDYK/g0KPR0loFHlfsr/sWY7qn
 901vkYuSYYmrg2AHZZdBzZuK78hCdyNqOMWoZBD9A0GG5mTGHf1fjJBES7coRaOmaxMnVtLC4Jh
 Mx7j5q+NH9XHWIw0xAw==

Hi Jonathan,

On 04/03/26 03:11, Jonathan Cameron wrote:
> Gah.  I managed to eat the temporary branch i was using due to the odd timing.
> 
> Good thing you raised this as it had quite a few patches on it 🙁
> Someone else reported a missing patch the other day but only the
> second report made me wonder if I was going crazy and spot what I'd done.
> 
> I've cherry-picked everything off that branch onto the one I accidentally
> switched to.  So 'now' testing should have the lot.
> 

Thanks a lot!

> If there are additional changes, please send them on top of the testing
> branch.  Thanks again for raising this!
> 

Glad to know the ping was useful.


Regards,
Harshit
> Jonathan

