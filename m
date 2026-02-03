Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8986314D3C;
	Tue,  3 Feb 2026 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114461; cv=fail; b=rAjuY8ut2I2j51R2WxNRgp/gNdqW+5MUmC4OJAUVsmuF8pyu52QrpbxPW51WJ4NiKPvIxgCh4EohXYL0throRuyG6Pqsd787WEIH/gfrQQHGEmyUWX8C+Cth19iQG7Oi5OIr+xO5lD9LGZU9iVl8gNOSTbrssl3eFe69kKPwJwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114461; c=relaxed/simple;
	bh=/ErICFd9/lGzXc3S/Pdo3Od910AZbaT0z2hHIl5kdTk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tKRHbm+8txHSC6OXn3vFDA118CZXO2IdFj1qwtW88J6xE5MALYswyDAj56K/zVVRrkjSjKYMoilYPYRElrjmgD7KLuLRyqJocZi4tPHPbCEncfrIEuIBAIbZG2w+WOZcncXCnNSWDHwEhY6IDkmGd05G2L4HnCf+UmVVqu09IB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QGUd+TlU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LQoSVhZX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QGUd+TlU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LQoSVhZX"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vPn23766049;
	Tue, 3 Feb 2026 10:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MgNj3diPv/BNssSGQpwMga6OtwHgwFSDYfB+S4OY4Jc=; b=
	QGUd+TlUhtlPoY69U5vjGPx7p/pCfPm2yxX41IYFrNPTvvh5qA8GgsfGWOgKc+9N
	6ywXfKorUh7P6QFU1ZF4afGWTUlcDShZd/G9+UYIGerpQVr8ifcy6Z1jAO2F26aX
	TsMBtM6gxjcUwp9/S8bwVMwC1UdbL/KO9erwSLi2/hc07wG+H143FekXKOKfMkY4
	waQXRaEQ/vW6boUrDvcO5T1fIRR2hG2tJvmlm6p74EfbT46mwUKFTd//RYb6is55
	6ZxrVokIqHutNCOShdoen0Sn01ScRgm+cwiUtPnQjOHUwY4b50OT0KLdfK/lMjgk
	9h9GZ9Wep715RCinH352gA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1arhks9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 10:27:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6139lA7W025817;
	Tue, 3 Feb 2026 10:27:31 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c25788rtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 10:27:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xab4MkC3lKIv4cN/IovWBhD6bPW01LlIQQjlo72Qa3yZ9rHAn5Imk5f8oOVVG/g9cCYO+UYQvQ8a2E7n/JaCGB0rcJ+j1QZhgHa12Ag4SB9J+pDNYC4KRqBYuqrbTYXMEjWqs/s0SPuqB0eT5ZYO/qzTrJ9ZYCzU0KVKBZSXc5+d3vBBD+9tt5YnGyRlev0dE2sbDWaqh4A5D8tGbW27IX8votOzJAiQWo8UDTA3bXS87xDTop2d7ACsreR7eIcX0qVtgYZU9PjkS8YIqkqqbBLh0ewbcg/Ojvfoox86dv6rDdMtORjke5coSHVf1Lw+D4lExB1ruTCqF+oLL2/7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgNj3diPv/BNssSGQpwMga6OtwHgwFSDYfB+S4OY4Jc=;
 b=uyILDeUku6yhpNE7PyRz1bmncl6vzyL8mbAvnBLpHUZpl8B0ZfuBSE40FPH7SydVFor+Gab4JyC86Ld1oUqM/GqLpCwTabtDrq/2iOGtDva6gFTkmXv+/wrNH8j5NGjSTVjiSR91Zn57QLqjprRLsgUyutZUQafXAwoYmUa6XVF/jiDwW+3oBDDu/Cwu+Ohi/tCW6MZ0Gu2lnBgHZgpBF8ygVlcsjTQW2BweLSGuaqjFn3wf7T6OyS9jYkXatLgUp6SIEYYXrjtrJC5mTlky7G3da2H3uHJb22pPzKj8HZziOO5zuDF6iu+70atC0+PcVzhtR/4iBMZx6ytt5GCAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgNj3diPv/BNssSGQpwMga6OtwHgwFSDYfB+S4OY4Jc=;
 b=LQoSVhZXswGX8RrzbHXWJ97rcl84cBLqDyMUkquSBqPFWt5DMAVRe/GnJy5Cx3KMzmx4K9xEEadrU6pBBc8IWc1cDNby+635yrQeh0KZLUGfmmdGycsRb1w23vY20V0yuYC2gpRb+VkJda28Zy3dR4d4XBGAWuTGFNXTpsFEJck=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by MN6PR10MB8191.namprd10.prod.outlook.com (2603:10b6:208:4f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:27:28 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 10:27:28 +0000
Message-ID: <2c106b65-7fae-433f-9a44-4b295a43e2f0@oracle.com>
Date: Tue, 3 Feb 2026 15:57:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 next 3/5] iio: sca3000: stop interrupts via
 devm_add_action_or_reset()
To: David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron
 <jic23@kernel.org>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
        andriy.shevchenko@intel.com
References: <20260202194033.627967-1-harshit.m.mogalapalli@oracle.com>
 <20260202194033.627967-4-harshit.m.mogalapalli@oracle.com>
 <59105c6f-67b1-435c-aa08-5f440745b1b4@baylibre.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <59105c6f-67b1-435c-aa08-5f440745b1b4@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::13) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|MN6PR10MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 7778ad70-e5bf-47b0-8300-08de630ed488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVV6SkRVR2loTXNnalJhZ0dIdW5ERXROVFF6dEZwbDZTR3F6WnNjeWJTeitX?=
 =?utf-8?B?RVFpU0RBU2RsaFBJSnZCeVBEL1J0ODdEWmhVeTI0REpYU2srN09zR20zVTBM?=
 =?utf-8?B?dzlZRGtVVlVmWTFQSytUWmJPK0RBeDJQSy9jNjdQc21naCt0QVZiYXpuT3JR?=
 =?utf-8?B?NS8vK2FVdG1hOHRBTHFpMGZtTTd0TXdkalkyQmdiT1hXU2didkVibDBkZUd0?=
 =?utf-8?B?WVRVWHFGZTFjWU9kMzh2TTdMWjNYbjFkKzUxZURXempLWVpKN0QyRkxGeEdt?=
 =?utf-8?B?clY0cFQ0OEc5a0VQTENzT2Q4bEt1allBVEJwU3hxTDBIMDdQNWNwVm9PUTNB?=
 =?utf-8?B?WndwMkQ2MDdjRUlpbEhrY2ZKQWdIandUWUtSNDB6T2hTQmVxUkVvbDh3SHFa?=
 =?utf-8?B?SjRmWG1kL3AwR1FCVlNQWHZHSGJrMXpmeHBqc0szY3g4Y3VOd3hOVEFXMStT?=
 =?utf-8?B?amhCbE54TjBPMUtSN2dBZklqbGFHMGVBVGI2Z3BNbkF2bGhtbjV0aUFZSkRW?=
 =?utf-8?B?emk5TGhnbUUydWRMdUtyclNpdU45aHgyc0xEOVpNUEpndkhZLzMxUWJFcjhm?=
 =?utf-8?B?M2srYnhuWm5NUnJMNC9hQnl0ZitVV0RSOTNoWmI1Y3hrU0lzcm5PY1RPOERU?=
 =?utf-8?B?NHdKb3JtZ2JqU2gzUWROUHZFeWlTT1Q4TzFkTXVkeXZDSHVuajFyb2lEanox?=
 =?utf-8?B?OVBNRklJVWFZcm9NeW9ab2t3NDZZOEZJZHo1VkJDeWdqSVBMUnJlVmJQYm5q?=
 =?utf-8?B?WEhUdWNVSXpVOHRjc2FlbXhsMHNtL21RcVgwbkZiSXhGRkNCNytjQ3lSd2Zt?=
 =?utf-8?B?SUFsblh0bE0rZ2VYczJLTE52ZVcxNlpVNXBlK1VxakNkN0tGQlExR1RGUHQ3?=
 =?utf-8?B?TXdEako2OWpDQmx4WEZOZHBCbnhYTXhEUzBtSURFdFJxUXNUZzNXd1lXVyt5?=
 =?utf-8?B?U0pHVDlCVWt6S2NxaGZnbElydHFFNUE3R0p3Wno0MTV5MnZ4dUd3ZEZiWUsx?=
 =?utf-8?B?TjlRYUlXRENzeEhLL2lJN2JUQ25Jck5qK1Q1STJTMVNibVRyT1RWenh5bENz?=
 =?utf-8?B?OGZrMUc3M21ZOUtDNTBGdTNCakhuU1ZSRzhveVQ1ZXZKemtscVV1bHJ1OEFw?=
 =?utf-8?B?RXNYY2F3ZFV1TThPT2NnbWpnUmFKemZEcGVPbkpFYU5YN3ExdUQ2aWlnWjQ3?=
 =?utf-8?B?alVDK0RaaEhrNC9yc3p0TEd5TDZtK2NaVzBjUk1jZ1YwY0NRWStLMXdlQzkr?=
 =?utf-8?B?cTBVVGVUZ2NnQ1BFTnoyUkc0dVNHaVRDQ1ZVMm9ud2xIay9IVUxvRWxZVEtC?=
 =?utf-8?B?SkQzN21TaWNOblBCWjFxeVBaaGJGc3ZXaCsraCtRaUdDTEE0RXQrNFVRaHo0?=
 =?utf-8?B?OHgzVFdnRnMxaEQrYmtiUzBKU0xPTDl6VklKZ21HSGs5N3F3ZWx2eHo5ME01?=
 =?utf-8?B?VThCVldHZHVWZUZFVlJ1MGpDM01GaUVPZ0M1QnB4ME92dlE2SHQrZWhIT0h5?=
 =?utf-8?B?bWFIRzFrdmFVdStJREFWTW52MEdITkVJOXBkSkdqeUI0U21VN0ttcWVJVlVD?=
 =?utf-8?B?aC91cmM5RVBCV085elJWM29vaXI1eC94ckNJNVR4dnNsa1p4S0Iza0M0VU83?=
 =?utf-8?B?c1FCT3pHZ3E3NU1KOWU3eElLVnRoTjA5OTg2SWZGcEJZM2NHN1NQRFFZV1pR?=
 =?utf-8?B?UHNEUjdpWmVSdnhiejcwNjV4MURoNldKRk5XTkFCdTBDZWlGZnZURlN6ZXFM?=
 =?utf-8?B?ZVl1MVh3Mkw3K2dSRGFXYXhSbDBBeGg4UkNkRnRHOGQ5SFdqUUdkRldYZEFZ?=
 =?utf-8?B?Z3VYem9Gbk5zZFd2UTU3QklQZ2srMHk0eEZucDBpaUd1NW5sU2JsYXg2K2gz?=
 =?utf-8?B?TUVIWXl1M0VCa2pLUnVUaDJ3bElVeGZTdGdyVFNxMkdUeXdBYTdYaXZpcjV2?=
 =?utf-8?B?MUhBTW52cmhsZlRFRTJ1Y1VXNzl3Und5SlpSK0RBMzlvOXA0V21XK1hwakdk?=
 =?utf-8?B?MDJURk9ZQlVpcE1nZzJudUxmNG9rNTdjYmNpMGhacFNhc2lnbGhrdjV3VVlW?=
 =?utf-8?B?L3R1UVdrTkZFTlNOZHk1eFp6aTFxUFJNbnR2dXQ1dVZiVEh3c1VnMXoya0lI?=
 =?utf-8?Q?19vo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk43YjdndXFqT2c3MjV0NnNQeC95TFhLL3J0dUZrWEl6UjMzMkY2UjYwcUI2?=
 =?utf-8?B?WExtdlgvb0Q5SWlYc1BQY3VjU2NXaHRpUkphM0FDN0JKVFl3YUdUMkRtcHVC?=
 =?utf-8?B?bWRhcVBwblJlbFJXU2VnWXNkcmppaHhzYVl1RDA2eTZVcTJxM2xUbFVzQUIz?=
 =?utf-8?B?cG5GUnRwUTBlOVVVNTZidktUcXA2R0M3bEhuUkloYmNaY01xbkJwK3BWWDdW?=
 =?utf-8?B?WDcyYnh1NkRUZ1gvaFM5blhzaCtiS1lhZFppTmMxaXNoaVhUUlFpeFlwTFgx?=
 =?utf-8?B?anU3bzAvTFhORFh3VHRIb3NKTnoyNEFTT2N1K0E5NW4ydllrMmVPQit1Vzdp?=
 =?utf-8?B?aXVKQVR1b1RkRHdTaytOQ1ErYzdBZDc1NWJKa080R1ZQVWkyVTNwdUM2ai9y?=
 =?utf-8?B?ZkppWFYxcnh6WVVlczMzQTdUZHQyR2ozaG9PT0dtNmZ2OUl0cGdvZnNlVjU3?=
 =?utf-8?B?M1NGbHNPN0ppZDdQT0loRlNJWitIZVZDZTdlSVFyR0g0b1o2WUpZT285WkRG?=
 =?utf-8?B?S0Z3UUtrYmFjZUZVYkRPU3VJcUcyaHp1WnNYWkhiMFZrOVhaZnJScGVVTS9D?=
 =?utf-8?B?dzFSSUpNQnhSWGxXWm0rUEZIQkpjTGUyejBRL3J6b0lMS29XZUpJQUhXd0hE?=
 =?utf-8?B?U1E3a2xCaE9wS1Yyb0xJVTJzZEdEbElqTUpBSTc4eTZWTGxwd0RJa2tTcTBa?=
 =?utf-8?B?Zm1iMVBWZHBLb2owRENHSUw1M0NqK2NRK0RNY1QrOUgwYVV5dDhWeVlCV043?=
 =?utf-8?B?N1FiZEVnMDNKRm9oem8ybkp1cDE5Ylh5dDV4M3pvNE0rRk9PVHFlaXBCNzBH?=
 =?utf-8?B?d1dsRFlDWDFNbWMzSUllVDFXT281MlRQUU5rejdoU3RyZWI2aGE4Nklrajgv?=
 =?utf-8?B?QzFKZGVYbHFFSUM3QXF1SWgxRnpuZ2dBSVBWNXNQZWlSdUQ1K2pPTGZ2aWRK?=
 =?utf-8?B?ODdwRUE0eE1xU3JFLytMOEsvMEhhcWVubGFtUDFnb1ZKcUtRWG1pY25RWDhR?=
 =?utf-8?B?VythZUZvV3VwSUQ1Sk1EaXlsTDZxMjY4N1U0bGdIaVAwMnRIRGZidnRITlN5?=
 =?utf-8?B?ZStlUit4RDRkUjNsbE9MTjh6TTIyY1FwZ3ZaVUxoekJLdkVTUUllK2J2MGdR?=
 =?utf-8?B?ZWJCUWFWeUQzUjB2amw3Q21GT0dldXYwMXM4RnNwSkNWdXFZRTlPaEJCaitJ?=
 =?utf-8?B?ZnFxbFVKQ2ZLTHQxTlpxTlRBRSs5NXJzTWwvNkJ3RU5rQXhGaDRXT1VtcFNL?=
 =?utf-8?B?TDM2YS9icUZzSEVsU1NwYjJVSlREN3hzOHVSQ2FTNHBaS2Z4a3lXMXN3L2Q3?=
 =?utf-8?B?OHp2N25xdHJBMXZ0TDRsMzFZZENaS1dTLzI3d2p0Z2lIWjRkbWIvWFZVaVRU?=
 =?utf-8?B?RU1hbGV5VzQyVzVvL2JnVVByUHgyVHpTMlQ1R0d4eDArZlR2NDIxK2lVY0tD?=
 =?utf-8?B?T0NpYlBPYk9TQkx2TlhINWl1bHhnUmNFbjRpSE9GL2dZTEI3aXd4Nkw4Y2tW?=
 =?utf-8?B?VTM4S3BOK0o1WDQ4SjlrU2lYRXljelhRcjRla0dmcnF2WGRlWEQrSk1tNlRq?=
 =?utf-8?B?RFZ2cHl4cGV2SHBqS1NCQmdGejBGdlNMbVdHcm81a1p3b3R4UDhZVkJHdXor?=
 =?utf-8?B?QUV6dUlHMGQrWHo2aytBcVBTK3BTTDQzY3Y5VGNIK3BoZXRpdkVXQkx1dEFn?=
 =?utf-8?B?QktFQStyM1BsNXN4NWg2VkNrcjFoMVdQV3M4azBuVzgxSllOa2tvMUZlSE1q?=
 =?utf-8?B?ckh0WDF4SVVSUi94dkg5dXFmYW5Dc3I0TC8rYXdwTDA4LzJzVTFNbHBnSUMv?=
 =?utf-8?B?Qk1pTzZHRGIvbERYMDlrTG95cTZYbzdrbjhGMUJwNUNNcG1XQlBOUHV4c2Zj?=
 =?utf-8?B?SE5QZTlQV0Z1SHlLLzZBUmlQNzlhdy83ZjBtTUh3RGxOck91cnhySjFIaGN5?=
 =?utf-8?B?N0Z6djFtbUNKMEdMNURCa1k0ckNuZ1JMVmlZVkxxaVFzVXFqdVlVZEI5ay9k?=
 =?utf-8?B?ZlJHMnB2M3pUUDl6RmhNSENvM09FeDJGeW5ReE5VSS9TY2xkL2NEREVpYi9Q?=
 =?utf-8?B?bU1kQ3hic1U5dzVZdi9aK0tYYWF5OUU0VWNiR3B6ZXdqZ3JqM2NCZStXRUtW?=
 =?utf-8?B?RmdhdDVidG1FSjJzWE54L1I3bDJGVXF1NDdod0U0eFN2Q2poRHlBVkZ1QmhC?=
 =?utf-8?B?SWNUT0VNaXN0MmJTV1M0TFF0a05hYjFLNUdBaURPL2sxSyt0dHBtSzlaQWZs?=
 =?utf-8?B?ejBMTEdzSTlBMVNQMkFGMXg3cGt3cVdHVVUyR2dhMkxjWkZwSVd2V2k2T29u?=
 =?utf-8?B?Z2pKbjJtQ2ZsWFYzTDRnTEhESXhVaHgyMXVJRStKVVBEaG43a0ZPZkRtNGds?=
 =?utf-8?Q?FrWJ2trKdfE3j9SXv6+YcGEHC6zw1Gl8lfN9y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1q5kWSbeftkI9aRIS4u4IP1DP4bcY6c1hYjU+6tv9aZEw6CvkJdZYMDtbHTBqkMAQlkPXUhW9QRDDjpVyvmTqY0UMt0qMZ20rOYmRvKpJ525JJbyK2hZbYmR1KXpnpEZAQKTSeh3EfbC3orqbYcGoln7uJu5LGoYonYnBQ67LUi9sfxSyzzp7WfOOsDXreUZdCgcp5JoW+YBIH34ZwPzXY13KsF8Bo/1U908mFy/S9G4GP6uE9gvKAN3PD0WnN8Z5AHVfi3nOpXfEEf+hqqp1DD/He8byAmsbfGsqCMikK97rSjBklc2astseuQ+VdRTibfz7n9uK0fXQYl/nI6o4CXwOvCmchiG2ZatWcqMHi3HlmD2KJ0Hkz2AUw0BXiIGQxHY0YLFS6b1FQ4mfCcxYLiFKkNmcqHrwCOtyFym6iINqvBRgfBrSjq8dpi/7Oo9r9r3kmUqi7nMJixlay6+VZwKtlZuIvQ8W4GaK5oQXb2JUG4nfmtQB2Dtb+3ex9n5tTd6Bj4Ze9oRSwHjOcfLm8MTexol+TwFTXHLXfizY2R/UDdYnbHTso2BbPLN8oQTfM2ZfduodzUsBFLkDV2wkYsE8aFgZTtqLW0CjspdJ9E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7778ad70-e5bf-47b0-8300-08de630ed488
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:27:28.0472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RjxcXuIowd2UUGF7KgeWcpdt6Ro5++5MLtZMcfZtQf19O9hhiPjQKQqXnkjPsH59U4TlWw6IwQrrV3DM9+F69Z6Z1F5/N9DhE6AM+Pej51mQsWI/UBEOa/yY75Aym+T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030082
X-Proofpoint-ORIG-GUID: OoHPwyIDBBfpRzUgnc8RWIYZ9G_rMyeS
X-Proofpoint-GUID: OoHPwyIDBBfpRzUgnc8RWIYZ9G_rMyeS
X-Authority-Analysis: v=2.4 cv=fdmgCkQF c=1 sm=1 tr=0 ts=6981cd94 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=3R_MupTH1cvRR5ra-58A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA4MyBTYWx0ZWRfXwVncF1APjP31
 vSeY9zHC8s52VdattebboJ0cf05XSeCuA4878aigULJZQ/T8m5sdaferxHdRmdKn+oi44Te5m+/
 qck7nF1IJfqTY+0GlltsrnLXfAyFXdRZCj0MaDsA//LB3nH0ciM7MSdYImag55XocmFlFb1zN8S
 5bwwOaddVVQgd2xUMWsxJHg6eeACFpmkYbhTdkZ++gBVn2zlPikEryN1IOYcY1sEc+DqBvkwG4m
 V7PogW2VPP8T4cu2h0StEQ7C7DK/EhAzbalmzmraB5eM2mhqqxvAC5uQE6qDVAXyTzF8m2rSvEB
 nW7hE3JPNIYKnAeEHyrM5fvznv7VsUhLxqWlK7op5BB7VSA+wzoxX20xht1JfMzXUYBi5EazHH+
 WVu8GgJAeiPPD1prrNtCF2WzGSzo4rn5K8hENkhWlD3lcSJr4dBNkEWToOYcfq8iF+NZrcwdvfV
 u7iNAHS42ia6q0/lGl8c7BqOVVlbvLgJrY+etT9s=

Hi David,


On 03/02/26 04:34, David Lechner wrote:
> On 2/2/26 1:40 PM, Harshit Mogalapalli wrote:
>> sca3000_stop_all_interrupts() is moved above the probe routine so the
>> new function sca3000_disable_interrupts() used in probe can directly
>> call it without additional declaration.
>>
>> Used devm_add_action_or_reset() for shutting down the interrupts.
>>
>> No functional change intended.
>>
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>> v1->v2: Jonathan found a broken tear down sequence that was introduced
>> by my ptach 3 in v1: https://lore.kernel.org/all/20260131163218.2a4b93e5@jic23-huawei/
>>
>> So first converted the interrupt disabling task to devm based call,
>> order of tear down is as follows after this patch: iio_unregister_device
>> is called in the remove() callback, post which any interrupts will be
>> disabled with devm_add_action_or_reset() call.
>> ---
>>   drivers/iio/accel/sca3000.c | 53 ++++++++++++++++++++++---------------
>>   1 file changed, 31 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
>> index 37ef724d5dc5..4faffeea328c 100644
>> --- a/drivers/iio/accel/sca3000.c
>> +++ b/drivers/iio/accel/sca3000.c
>> @@ -1437,6 +1437,33 @@ static const struct iio_info sca3000_info = {
>>   	.write_event_config = &sca3000_write_event_config,
>>   };
>>   
>> +static int sca3000_stop_all_interrupts(struct sca3000_state *st)
> 
> Return value is ignored now, so we can make this void and not return.
> 
>> +{
>> +	int ret;
>> +
>> +	mutex_lock(&st->lock);
>> +	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
>> +	if (ret)
>> +		goto error_ret;
>> +	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
>> +				(st->rx[0] &
>> +				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
>> +				   SCA3000_REG_INT_MASK_RING_HALF |
>> +				   SCA3000_REG_INT_MASK_ALL_INTS)));
>> +error_ret:
>> +	mutex_unlock(&st->lock);
>> +	return ret;
>> +}
>> +
>> +static void sca3000_disable_interrupts(void *data)
>> +{
>> +	struct iio_dev *indio_dev = data;
>> +	struct sca3000_state *st = iio_priv(indio_dev);
>> +
>> +	/* Must ensure no interrupts can be generated after this! */
>> +	sca3000_stop_all_interrupts(st);
>> +}
> 
> This wrapper doesn't seem necessary. We can combine to two functions
> above into one.

Thanks for the review, Sure, will remove this extra wrapper and add the 
needed things in the same sca3000_stop_all_interrupts() function.

Regards,
Harshit
> 

