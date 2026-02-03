Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81391190462;
	Tue,  3 Feb 2026 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134130; cv=fail; b=S/AaOzOgNCsMmA9TJOuMH0WNedC/Ty+/GozNi4maniCo9bwdxRHwwGTyFhanHrTlY9G+DAYNk6CwDGJWMFvGIZ/XTgm2SJ+zCR8CYGoa7NcBU+Y/T0X/Hp4i6lXxaMXAMVsb/dsUqMfzwzpvFpJiWqCTuZKq3Q3hzPvObAZE4no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134130; c=relaxed/simple;
	bh=t2zKkKRwEslTq5I6w8sA6WAey95KlGqigRKdIOKT5Mc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CzX3ZkR6Iu++jZnwxSIcp5SKmNyio/OOmlA8BHooSY1t93UG73Rw2MMBZ7ocEZ9dfFoWbRgTJ+rSbn7lXayiD/RNlAPAtD65JIIPXuSmVR++mjDliDBFyP9bXKRumS4dgs8Sv//7206A3dxg/T1iV3YuWtvqxPgQO5HAb1Q9BD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=foDQ4OuI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ITXnyKNF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="foDQ4OuI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ITXnyKNF"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vYbZ3817730;
	Tue, 3 Feb 2026 15:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gN2ubmjVAk1wE390Z61QJC8lxqosCvgrf+bjBacXI1o=; b=
	foDQ4OuIvwGq4ZOuXj/S6nKOs/+2Dl5IunqD188t7OkENXXLpaNbY6swwgQ8DK0p
	5yNtOGtU+mIaHKWIkdxbFQHHXIemirKmtFXSTSbMD/pvIIzhA4KVmOMfKVWptMWR
	6V6eK+QSmPhITqBsSalgp9FxBIH9u8V4tYQ9px8HkJEEy/ocbJJUeKYQgT8ul/nt
	UurtI9sqK48GTAwbOdPuGKt8IVRwI49Ok10Zac4kGxIzstUy5ANYOj23vmfwFwvW
	p9f/90N6ZgGnJ7VTZB+WXotTDJ64t6MKM8d6FN6vv/Wa3TPx8uPQHYfeCOPnCZC9
	woqmivzIzRf1453K4OhfaA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1au64aj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 15:55:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 613EOScB018820;
	Tue, 3 Feb 2026 15:55:21 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186mhscv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 15:55:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+Q3acJQbPd7nqO00nHgKcsxOKv5l2Y+wKpNrFjcMQDJj7VSCrHcgdFw3t+rhIiKZglxIm7g0cEo7rpUkpVVtQXcmNKIpaK4IHhUaTg+6s5deyW4dIEOJYaL24vTe0+2KIxLKWlZAug8dygo2frSzL5JqfoWhEVgrenp3i3fxrZgzMFVAfNTaQvt2K3gd3M15GJ9rj4FvkWd2EQq1p+opf1ITPBVPZURIr/LkbM6pu2QbUMu4w1ZSvN9enKclQ3f6J1chULN7IR5Eq82daITBUof8LgjXZxzFsJ6/ldU0kAIzDXinpwqL3R/MrtzCZE7LYH0zv/L7pNPCHeXE+C/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN2ubmjVAk1wE390Z61QJC8lxqosCvgrf+bjBacXI1o=;
 b=zFRg3uEktmeugKcHNcho3BEFj2/CA3q4FWk1BMKEZnHRfAkvtXTsCKqqh9zqgL2uGkdrZqrnyN/ms/Crq2ooyZRClPABKd0tyT2Cj6kVorNuLfvRyc32o5B6VhkF3+E0Q3Q8ZHUVLVI4/sCSergm5+szsaF2KLf1KLP1OLmZU6YjILLMBN4m0oo45RerRZ+YVhAUa+23VbRzRpe1G2iqGpS5DsJpD2epSDdfOd48HSVBBmaR3kgVVii04x9J0NkSC/bXeKojPvMFFqYZFMCWJ3XZUIrl6ae8Cqst17uTgJjO/HI3mLhHhvBUbhaN9glYQLRM1NSCTtnUZlKb0TQgWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN2ubmjVAk1wE390Z61QJC8lxqosCvgrf+bjBacXI1o=;
 b=ITXnyKNFPuXvvGvFBVRuA9A1PSSVRo6OqixHwfiawjV77XT3+0LrPgEse2dL2j1OT2ThAR8Ig0vZ/fiCpu9+BA55vaghSOqcxNzliQVn0RGEwYOLRrW0R/CRmXmI7vlObvI6Js86e4clHT/MH64qOjpqaorg9ACoXJKtMMEqlmg=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by SJ0PR10MB4640.namprd10.prod.outlook.com (2603:10b6:a03:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 15:55:17 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:55:17 +0000
Message-ID: <a8eed14b-2baf-46f8-85c1-067481c02d7c@oracle.com>
Date: Tue, 3 Feb 2026 21:25:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 next 1/6] iio: sca3000: cache SPI device ID in probe
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
        David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20260203122109.689669-1-harshit.m.mogalapalli@oracle.com>
 <20260203122109.689669-2-harshit.m.mogalapalli@oracle.com>
 <aYIR-LAq9iJETwjK@smile.fi.intel.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <aYIR-LAq9iJETwjK@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::15) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|SJ0PR10MB4640:EE_
X-MS-Office365-Filtering-Correlation-Id: 8648084b-4d7b-40ee-3547-08de633ca054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG5iMCtoNDlqS0RUK2Z4UlA3eHRKWEpLSlAzYlQyN2xpdlVmUytZc2ZyZTZQ?=
 =?utf-8?B?Yk41QUNWT2VVaXU1NVVBVEZkY1J0clJxSDA3L0RlSTJYZGVnYURYZHFiWncx?=
 =?utf-8?B?TEVVaG90YkNENDRXK290WnRvNVZ1dzBGUWc5RWNlZjhyQ1JMeE5nZjNzaW1Q?=
 =?utf-8?B?bDhqajdsdEpUNjRKOHJIY0pmakd4QkNWVFJIcG11NlF0NmIxcTNUMkMrY3RI?=
 =?utf-8?B?SHkvcFZkVWtZMGx6TWx4MXBBaXVWZktqeGtXMlo4d3doSVROYnBaQmNvVWNO?=
 =?utf-8?B?LzBxcFpxc0QrQzQzdmRkMUo1WkZTbGV6YVB6VDcwZElaTWpNRnZHSEx6Rnc1?=
 =?utf-8?B?L1VUeG1RNFpLMEZMZFNNVlZjSDAvTzQwc2VzN1FBRDM1TStMdS83V0FObThk?=
 =?utf-8?B?MjRrYmpyQ3M5b0RqMjdoUy9EUUFtWjlXMEIvc3pBYkhlNnduZEs3ZFhQV1hO?=
 =?utf-8?B?RjhHZHlTRVM3dzdpU3owbWtKQml1SzZSVHpKS2MwNm1ySzFJQmp1QmRxZENn?=
 =?utf-8?B?Yzd1ZzRaM1VWbWl1bFJyNTNOTUdOcjI1cjVVeHQ4ZDhxUVMyWVZQcGMzdkNk?=
 =?utf-8?B?ZG9pbkhyTjZmdVorcnFvVXhyQTdMTmlIUCs1c0Zyd2ZlR0E5SDhCYTFNNExn?=
 =?utf-8?B?S3B3K0NqeWZkQXNyT0Zzb1c0N0dRTFZpMFJBQ0FqektHVGRMekNvUG5IR2xn?=
 =?utf-8?B?NVBUSEc1WVR0ekZQMDJNa0JTRDFSSzU3cFE4TU1nWXhRa3lMaFM5MVQ1RVI4?=
 =?utf-8?B?c2lQU0pwNy9BS25PR2JhY3BPQVdSK01vODc4YjFIbFE5WktjR29uL3RKZmhm?=
 =?utf-8?B?dS8yUkhEYWF6eEZGZHIwbEtmK2F2aHNFZjdwRkFkNS91M1FzbHZ5QThMaEll?=
 =?utf-8?B?YkxycDZtUFBDZnRYRnZFRHFFSlJ0NWg5ZWpaSS9HQ0ZUVm5Rb2k2Z3VmOWEw?=
 =?utf-8?B?b1dtK25lRXRENlRKWXhQUjlsSG9Ucnk0RGpxSHRmb1hmOXZYbk4wcVdMZmtm?=
 =?utf-8?B?bUpBRTQ0eGEyZjV4Mm9GZENjTy85cjFCRFF2d2l6OGgvMWpNUTNnTUpXRkVQ?=
 =?utf-8?B?LzhTZUtsTjlDdVNjYjRRdWhqV2t4Z3IxT1dJZFNTeXh2SUQ2VldZeFgvMmZE?=
 =?utf-8?B?OHJWQnZORmFlQU9pV1lUM1hURlEvdVM4UTVSR29HdmxEUEV1TFJoN1hEU09h?=
 =?utf-8?B?eWpsaTYvNTBlU3J3d3hoRXNQZ3c3NkdKbFNCTUtlaXg2ZEgwVUJOUlVlQm5C?=
 =?utf-8?B?Yk5FT25Fcm5GcDdaMWVKVCthaEFPdURIOVdsWDJqMlNlNUN5enhIbFUweUlY?=
 =?utf-8?B?MXpScTFkQmhxRGpOaFB2M0RIaFNkQjg2eVpLVmdmV2wwVUpVTHlYTStoUWxr?=
 =?utf-8?B?bkJ6OVVEUS9kMUs5OFMzU21qbVpOdUh3cXpYNEZnb3N5N1cyUUNZY2pscERV?=
 =?utf-8?B?VUVpKy9pam02a2Q0ZDFVM1dhckFtTlY2YzdOeGJLQm1uRDZSamhBQVJWd3p0?=
 =?utf-8?B?cXpIWHpaeEhCZlBoV2lyM3FlOWJBMkdHK3lGS2JzZDg5M1IzSTBKb041UVFr?=
 =?utf-8?B?QzZ5UWZkVE1Mcm1TMXpGT2pLaTNJYjhWM2RkTVh0UWhON285UC9oc1NHVzNM?=
 =?utf-8?B?SXNiS2dHOGovbGpJWWJ0RHUvL1diRlF6MjRwMHNXZXhyZVgzM1hzcVJPZTVq?=
 =?utf-8?B?VThscjJlM1BHV2VjM3p4TkY0bmwxeDdwUlVaMUppcktGbkwydjVsc2xTZC9C?=
 =?utf-8?B?OWtaVnVPdWowbXl0Y3dZY1ZKVmxWaURGQUZaV1pobjJsQ2d5K2piZVFNbGtw?=
 =?utf-8?B?bzdiWnhWaU5sZDY1eFRiK0Vnak9wV2h4ZnFHRVR5VWNyelFLb3Q5bVlvQzdM?=
 =?utf-8?B?VGtVem5mbjNtdzRWdCtubW1ZM2xnWG1ZMWdWRHg0Q1BJWTRzNS9PRWNoOFcz?=
 =?utf-8?B?VmhEQTFMVTZmVlJFeXF5TTRiT0UvK0NyTXMxcFVBbmhkUWpKNzJiTWp5bG1O?=
 =?utf-8?B?UWU4cDFlblBFZkRKVUdtMWpRcFZNVWZiOTM5Q2U5YjNwZVBZMk9QQ3JYSXVo?=
 =?utf-8?B?WDkxK29DY1NkcG9ITnhnL2pwWXo4V1RPYS9XRm84dHA5OG1KZ3k3NWRWeFJ2?=
 =?utf-8?Q?tQ6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEZVUkZwa1BMRG5jWnVsN2w2SWdRdkJuSjJWeEoxQ2RWWWNSK2dUd20xVFpm?=
 =?utf-8?B?dFMzUnVzU2JTSXZPTnRuN2tMaUFXSytGelExOWpjQW1sOUlKQkpxWGpGbXA5?=
 =?utf-8?B?NjhLQzd0MHMxZXNJNGZzNGQyMSs2M1Ezb3R4YWZwVTBrYjJIMmxzZFNxYzBl?=
 =?utf-8?B?aHhuZFZPMXQ5K24wZlBqMksyQmNZTUxsOEZNWFF0S3lpNlNRdlY2R3FOR2ht?=
 =?utf-8?B?d1RJQTB6N2d2cVc0RzlJV3lqejV0MHVIVkl2WUh6M2hPWUYva2xveTZ1Vmdy?=
 =?utf-8?B?ZkZkc2NxQy8zVk1saERxUm1jbDFtVG51cWs0M3hGa2hhaFUvc2ZGOTJCb212?=
 =?utf-8?B?Z2w2QUFZV3lPN2ZTWDk2QlViekIxMjZEZzR0Nk9HVFNucXY4ZXVFaTIxOXZj?=
 =?utf-8?B?alBxK3BhNmtLWUsyQUJBdTFyTFF1UGVTanA1ZjZ2cXFydGVZR3ZFSkozL3A1?=
 =?utf-8?B?QlJlSG5DcnBtS1IxSUFZWnQ1NVowQ2NwSkJOQjh6Y0FkRnRGU3MvdVk4ZzJX?=
 =?utf-8?B?bjQ0M3Y2cVF6UjR0VjUvUllwbmVWcnNXK0V3Skh6MzNmQU9UOE14NDk4cEVs?=
 =?utf-8?B?bFpLV0J4YVpnTzlqVUZ4VnhLTXR2cDBsTmo3cjUrYkhZbHRlN3VWb0lEaUc2?=
 =?utf-8?B?UmllNkx4dFRPdnBidERhNHluWHBrYjBsOGpEZERXWHZtYVpBdUVMZGpzUXMy?=
 =?utf-8?B?cVpyRXQrMEZFM2o4U0h3ZHN3c3dlMHZXckpheVZWUzIvTTgxb3hjVnBzVW1z?=
 =?utf-8?B?UDh3M3BIeThrZTJvWmVYQjkyTjVFekRiRHJlcEFPRUpmWU9uU3JMYUVacnoy?=
 =?utf-8?B?TSszOTJiOThGWUNZN285THlLMXVreWorenB4M3dwRE9OU3IwVENGTlYvcUdT?=
 =?utf-8?B?NGRMTHlYNUF2REk5cHE3ejJVNlhFOVp2dkVlSThRSHYzR0Q2YWVmL24xR3ht?=
 =?utf-8?B?UmNITVh5eHQ2L0RnT296L1dhc2dBVDlGTUhjK0NDZVpKbzA0MklkR1BNa1FY?=
 =?utf-8?B?WkswV29laHZaaTJUQlRGd3VkbjBVT2ZNUUhzRnZlZncvYTl6alAvbTlCNnBH?=
 =?utf-8?B?VWZ4blBFZkNUQVlZam1DRnluaDhSYWxxN1FUNlp6QUEyVzZiajFJeE9BYTZk?=
 =?utf-8?B?U3NhWUNudGxiOUtNSFVsMXR3MUV4cEJWTWltVklpSit3UWQvQzBiQng0cTlM?=
 =?utf-8?B?cUlzSmg3WTIzaEdITGhnUUhpeENwR2x3VW5ydGg0dXkrMWZuS2xwOXBQWDVZ?=
 =?utf-8?B?ZGN4TWw4TzRNVGxPNjdZdVpxaEx6aE5pdXZ0RXJKdVUrTW5HZDR6b2dwMnBq?=
 =?utf-8?B?YWIxcG54ckpuREJLMHVRSWdzYWxRSXpBT0RSK3BJMDNTK2l2TnllTUJEalB0?=
 =?utf-8?B?YnVYc05CUzNKK0xhT3VyNElIQTRQanA3WnhOQ05TdW4yRzR0cHpQajhzOWcy?=
 =?utf-8?B?elVUYk9od3ZERXg0ckhqcFovYnlOcFVINGNwTnY0TnNiVFlxVHRvMzU3eHpV?=
 =?utf-8?B?NnNsNlFKZ0tQZWJWZlQ5bUR6YXdhRnZGaEJMTnlxb3BHamVFQ3lzWVI3MHA4?=
 =?utf-8?B?cXoxWVRzeUFob3dTenhvSGE3VVdSSFRWNWgrU1dJdjAyUTZlNEtpMjcxenAz?=
 =?utf-8?B?MjE4SWpzM0VkZzJFT2pJbkRxN2hhMDJoMElJTlUxLzRhWFFJajBDZW1SVmtw?=
 =?utf-8?B?R3B3alZsS1Qyb1FJWHp5bTNjTGFnN1pkTTJUVmorQ3AyVElmcGswKzZ5WFQz?=
 =?utf-8?B?KzFPRkpSWXFCUmNWcUJBYUpBNHJmN1dRdEE1eVpGTW9rTVdTcEF0cmZ4NUpi?=
 =?utf-8?B?akdnMFVIUHIrRkhqQ0NYTVNjMlBRai9pbDBiaUFIa0c0SGF0b1NyUlVpY0w2?=
 =?utf-8?B?TFlrRlpPWE5MR3VlWGlIZU83aGdPdDF6S0lWbWhIK3REK0dZcnFTdDcxUHJv?=
 =?utf-8?B?TUN5SFR2bUlLeXlqVFRyL1g0bytoeXc4N29UVmVVZWpieStoNjlmdXpqUmlJ?=
 =?utf-8?B?NzlWcksrSGtQTzBMRkI2ZWppY0kvOGE4Wm5YS1dxUVdqMzVMeE0zdjhUeUdu?=
 =?utf-8?B?akc1bWRHQ1ozc0dwRC91b215M1pXZGFwWjFjRFFxSm54WmhCdm1IcHRUendO?=
 =?utf-8?B?bFJuSER2eStHWlRCMFJlWnIrQW4yZmRLcStLTXpaSlgzOS9SSFNZMGhGNTJE?=
 =?utf-8?B?dU43d3hLYnVWZFZLRWY5YWh1Z0JkYys1RkNlME9qR1NNcm1EM21aeUN5d1N3?=
 =?utf-8?B?RU41bUlHN2lSTzZMVFhLd0h5djNIbzI1YzBBSkloUXNKSjZ5TUdzZ2FqaU5x?=
 =?utf-8?B?V3RSRyttM2UzdGowSG9ydnFxU0VvWkV4NWpqcXFzS2Z6cDlVdlVxR0lmOGI2?=
 =?utf-8?Q?v/IOSvkMgMIXO8YdKGFJw4MeUtC9UT3iAOdfJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7zKxZmhjidp21w2dDIRvg41E3GkeFcamoQRUe3lChVK+B2nUv7uIEOkpgP+nZoszXwPxzOMJgMm5XuQdDTkA+gvxRWFwQKjSvlI/rKISGV/DaiPUeaGHTOGCiyVyra9JpVaUeOfaHcrdXVH/i18B6fL7oLhwcVDExPT6p3s4t8knH+v+RYD5fR3lFBt0rZavXjIQhCenjQSIqcOO5h4lQfvaFFRZVuky5gjy2Hk8XA8VCsfO/cHCDSqMIPvYdQeK1VHoajJzgAXDgJ4gp6WvJvD2jgIFJ53S/P2Y0rayUignv2zygZrSVhPD5z5k9pFhESDkimIDAvARQ4bFPipB6GkCdLpsTpwxEvTrg+YiUc1QBruEsOIK3/KVUOqENDlXZDGFxXj1W9mAmuG0D+2DgCY9lvb4hDMl/mRPDU7WUK3xwaoaU0aQ/iOmLzlgj49ovrw1oTTLC4UZazGTSqKsHtE1Xp0OVlqQ3a2Nx7N+rBHx0udiMvJWlBIe8cNFHePC96QqfqDwiHs2Ks2f//SKPzzKeWVUTV8vmua48wAOqo8bElJg/yA8C7vckZ40sFFfk1aHbFbDjjM6G8NNAPioNeFozzBlOewdKp+bPTWs3wA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8648084b-4d7b-40ee-3547-08de633ca054
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:55:17.4416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVvUW5cuHXMad3L+Sc9lqDOlS7Sy/z7umhWVYPrVkIWtet94YiOKAbsg8S7OH4sZk41HIFfS2FPvwUHNHsO3gMX2HBG++e9biHCwMpeUIUQp4OHo3tIyv2mUdTMjqNEP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030127
X-Proofpoint-GUID: eElyYTuz5NpiI0M3PoIyrJIzrYKqQxnd
X-Proofpoint-ORIG-GUID: eElyYTuz5NpiI0M3PoIyrJIzrYKqQxnd
X-Authority-Analysis: v=2.4 cv=Nf7rFmD4 c=1 sm=1 tr=0 ts=69821a69 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hgaxu-HfiBkvFUVaSUkA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyNiBTYWx0ZWRfXwrmoSaYx1bmj
 ZCP7QujB78ZTolcxFqnKPOh7OwrVh4EPMu0ucJ8MMzZH6XMBMONp44aVVrOIUeBBpPqBFWOaZBx
 LRoyRim1euMsL/uTRUdpFxwMkUb3+8ANieO1mCdTb52UMPKneTgtyUEvwTzd6DGZkJ1OZLp6KtA
 VB/FsVX3Se/oD9cK87mnFOqtDQ2ZIbZqZxADtx0Ips3MBOUlbMdTZCmIj7lv7Xhqi4QpYffclvi
 RVqcArWxqJJj1U/w96rI0ibOg8AP8gdH/2vkLBH/C7FwJ2Kb+DaGBwO6msOwy4HQ87jEZg9o1VE
 aEe7WNlWZCcHoCEkxTF81xZ2D8tm3ysiFTbn5Kq0E2p73HMB4+9gxGZm6SQ98l1oYPu3am0YQNT
 wcAktqLrXqtkYgkWap2cZGF42drbvUj6PXR6N38xqAEkLuAtQbY6IOuTy+J9dS9onx8MawNDsNF
 af9YBb2LIbROjppLdbVvfobxvay9lALKJZe2gfd4=

Hi Andy,

On 03/02/26 20:49, Andy Shevchenko wrote:
> On Tue, Feb 03, 2026 at 04:20:45AM -0800, Harshit Mogalapalli wrote:
>> Store the spi_device_id at probe entry and reuse it for the name and
>> chip info instead of calling spi_get_device_id() repeatedly.
>>
>> While at it, reshuffle variable list in a reverse Christmas tree
>> order. No functional change intended.
> 
> Did you miss David's comment? AFAIU the suggestion was to convert to
> chip_info(). With that done, this should use spi_device_get_match_data()
> (or something like that, I don't remember the correct spelling of that API).
> 

I was thinking of dealing with it in a separate series(as documented in 
the cover letter). Also David pointed out that if I am planning to do 
that conversion separate, there is no neccesity of this patch, as it is 
anyway going to be replaced soon when I have that ready. So I will drop 
this simplification in my next version and leave the conversion to 
spi_device_get_match_data() to another patch set. Will also include your 
"irq > 0" check fixup in the following series. Hope you are okay with that ?

Thanks a lot for the review!


Regards,
Harshit
