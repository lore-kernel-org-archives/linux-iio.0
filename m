Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F512BD586;
	Wed,  4 Feb 2026 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196965; cv=fail; b=uAV9qqc0yIrFN7WnDjn+cSMJVmTIt13eFe0FHb9eTmc3AeGpbUdgfNv/caIURc2cNlprYC8wi43pOaixz0zrSPL38/yxLTP+yJAQ9Z9cl1lftfzD30GLzPXwa8XbVe7GRZFLbSHjpLx5OdWOaN7ejlN3/2pk+x497SP90euXek8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196965; c=relaxed/simple;
	bh=/hCI4Lt8UNHH4aRurpbuEdpNBbAxdVtffNVqNtH9Ai0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QkcZ7fvS8dhKpsicJCSSq5w4uF/+dxqSz0UOP1dlWANGEZn0XrBJURjp+Oy5IW8a5zURGifb597UWIAtfp8X1HM/2rSd/i/4w89scf1N9sT7ic5eTXcbPc/kSQu3CiTSAb68J4RvodAebzPc0qGmOJwfll1zzrG3r3gBdSFn7LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aunc8TJC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=naXoDhtw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aunc8TJC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="naXoDhtw"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613IuDYK467997;
	Wed, 4 Feb 2026 09:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PCKdvOlOstrC3PWbgkeuo/AaMnE558cv82VCvtFb+AQ=; b=
	aunc8TJC95A0LuuYLd2pcZhPpaPZPD/Bh+b1RecXl5fvc9d28lV67vfI2HnIrr09
	/46ytslc96o4i136qsTy23pnaSYOS5YnUdsdJPhWaKqIYMhBGo8seqay2gvp2NBp
	GI7WRsl37VH4PIhHV9Yw/W97OFJdp6mLD57acQ1bAnCeAtNx0S2IiOgVAgnj54Am
	g/POK+TxDAORfsGP4erLVthGkLhS8od7af32seKstEdIcmybsMKw+v8GAfgxMK85
	BEsuoHlj832NVQB0exV6N6vveWiBN8Mkmv1uzs4nYeridDsntJ00Xc9OWp6YCMML
	rRaD+gkB9kRSASW0Wjum/Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jm4sf37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 09:22:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6147OUsT002070;
	Wed, 4 Feb 2026 09:22:31 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186nq38q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 09:22:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLTR3GjweFbIiWvyAvAWdxs1WNxnX6O77OPfNnyiXcsurFevEqVQWxG1S1LeZ75NIpS/2H52dqy13l6bcEftcrtIh8gyT9alyqtFVafpxBZhSZwurR+E7yIS4u50XPCknv7cR527s7YS6V5uWojMgF5FVfrLFIFxWtVOukYtF/XObcli9mWpL3sCJlVNL+ErWJoTmn6BF+qTxG82DqE3vPTt6GHjYoWQeZtTHFCWipYnKITduf7ekEbro1FzMNL6tNwHcHD4PZ+pb9Ivj4etJuYHc/5WeCrbh2/ene/df3iKYyeTaG0MY0PcYDzPQWqvT6m22GttaAKy3fgZH7oiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCKdvOlOstrC3PWbgkeuo/AaMnE558cv82VCvtFb+AQ=;
 b=eySvY/lSbZje4NZl6lGOQH114JyZMihTsUdOqoHv9eMQom2gJGqYecOu27GIMETEcnoH3z78vS0XVt4OONphk857kXKRUOjVwIyOmjahn2OKi/K76c9x4nDVYlg10rjFcyoGxXyTHN/LmIftVnoeoi5tyBiWAw07AQqJ2jSvVmTcvaEf/UapYnN8IKCuryVdBzzIC3++6C1n+Gh9ENBLGnSrP9gWbiThUfzx682wSAjoKmgH+27IywFSc+aModGSCnol54JUrO50vphGxGhXhlpQoNjjil3veMhN0Lro2Tc/HXQtUJLs98eheets6x2oxWJ/I/jCG1zvjdIWr/ZF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCKdvOlOstrC3PWbgkeuo/AaMnE558cv82VCvtFb+AQ=;
 b=naXoDhtwrppObLuNhQdiFRHbthAM8W02Lbt5umoERzp3CmoSTN9E0T4FG+Ovuwebq9Xu8DlcLGezQ9R2ocDHkJq0GL3g5dunx8mjqgJV53C5Ggk1ZDivzME0Jz/W/xatW7Jvhy+Y+Kx8tyYAJ2OA1aRXIZ50zigZtWTfbgWVhYo=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by SJ0PR10MB4526.namprd10.prod.outlook.com (2603:10b6:a03:2d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 09:22:23 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 09:22:23 +0000
Message-ID: <934cfc72-b17a-47e8-8a5e-2dd63a3a3655@oracle.com>
Date: Wed, 4 Feb 2026 14:52:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 next 5/6] iio: sca3000: stop interrupts via
 devm_add_action_or_reset()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20260204061219.791037-1-harshit.m.mogalapalli@oracle.com>
 <20260204061219.791037-6-harshit.m.mogalapalli@oracle.com>
 <aYMK06VJUrXCnNiX@smile.fi.intel.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <aYMK06VJUrXCnNiX@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::13) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|SJ0PR10MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 1354ae63-4e60-4cec-d32b-08de63cee75a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU1kSWM4ckkvWEhrRlR1RlNDaytJS0hBT0JTaE94WmI0R1FsSFZQanVqa25Y?=
 =?utf-8?B?T3FJeWVkenZaTW1NZmljR0hpNHhDWkhWUG5sMVZmN2pwejNxS2dJdUxEcjJN?=
 =?utf-8?B?RGZFWktLaEhIV3ZpUEt4SW1wdmlXK0hianQ5U3p5dko2Z2ltbnlBMmJMelVQ?=
 =?utf-8?B?NTVXNldCRUhCOTUzOHpzbUZ1eXNlSFJJSVBieExmTkVCUlBZM24zaXcxUmwz?=
 =?utf-8?B?bnB5WnRmRmNKSVZpN3dYN0dTZjBEbWtpOVdURmlpWEMzY0tBQitma2xhNlVm?=
 =?utf-8?B?VDJJdzhUTFJMR3IzR1FPOXY2UTd0a2gxck1nYmw1dUs2NVhibm1HQVpwclh0?=
 =?utf-8?B?U005NS9BaXZ2YmdyRFBoT2VNS3RVSHU5UG9lN1VOY01aYkVKUUtzLyt4Tnpi?=
 =?utf-8?B?Q3hLNzFFcU5uaGtuWHZZMGY5cHdaN2FTc21aNTQxalFaK3BOV3p1MTBmNmY5?=
 =?utf-8?B?R2hoUFVodVlYOUx4LzYrU0kyRXhlaEZWWXZxNE1hTWQ5aHNIMWcyWmVSWkxj?=
 =?utf-8?B?RWlYNVlHbEJPM1hHK1FSZkZjYklrblFXY1p1aGZRVkVEamZ4MjJ3UzA2KzNS?=
 =?utf-8?B?T3UyZ3hadjVScnk4Vlp4L2U3aTNIL21FdkJCVUFWYWlCM3ZIeFJRNFFoRTVx?=
 =?utf-8?B?enBOTlhsUC93SDJUaHR0cjhSdjBYUHZtRklyY1J6NDFBaEtJSFI5MDFhbXMr?=
 =?utf-8?B?TTNaSVdQY2Q2UkFaRGNRb0F4NnoxbTMyNWZhdVg5aDJzd1Vjb3ZpaEprMHcr?=
 =?utf-8?B?SzFRZXdWZG5YQVNPM1hLaGtXWkZoa2syT0lKRUh3aEZacWY4ZUMxZjdLM3Fy?=
 =?utf-8?B?N1NORktrRWNob3MyQ1RPM3dhRWUvSjFSUExxMjVMY2VROGNLeExkYW5RY3lC?=
 =?utf-8?B?eXhpTnQ4OWxHQVpCUGtZR2hxUzJSdkRoNTlwUHdaclIwWTFTQnNnQ3NjcUkx?=
 =?utf-8?B?RllwNVhYbGJMeFNyVnRReStqRitPampBY0F4MGFqczdEckIxOWhSZDREVEVE?=
 =?utf-8?B?K0RTT2dwOFhBdCt2NEk2U1RYdWJKak5JUGpRSUo5VCtaOCt5L2sxOFcwK0dt?=
 =?utf-8?B?Y0wxd0hURTYwVUJEMGhmT2g4cTY5cHltbGNzdm8xbXJIUUFaY3ZWUGR5NTc1?=
 =?utf-8?B?c1EwUXg4K25JVW1GSnpaZ2xXSHVpODRPd3NBSGNsL05WRHlFOE5QL2ppdE50?=
 =?utf-8?B?YTkrajRzYzlGWU81dWhoOGFyVlE3bmNkeXJZRVp4dkJUVTQ2MTZGdVRIK2pw?=
 =?utf-8?B?RlZsWGRaMVhWYnJzNENZeEtiYW5PUVY0UlJVTHhjTE04QXA0N0VZZ0FNeUkx?=
 =?utf-8?B?Q21SUTBmWG5BQUhQWC9CWmdja3plQk9ucUVzcUdMYmxSTGppRnUvRlMxK2FX?=
 =?utf-8?B?U011SWZRTzNuVUVkNk9aREtCQzZDWUdwbUNNR3g1U2VvV3lBR3lJRkh0NVA3?=
 =?utf-8?B?UUFtMWtLNUNtblNkM2xRSnUwaGVvelZLY3crY2ttMVZLVmVXRTJtSHJvRURp?=
 =?utf-8?B?RVp1TnJQVkVJbHVsM3lKcnZ0UDdWTWtjRXNxalJnWDN1ZnhlUGMvbThIUXAx?=
 =?utf-8?B?R0FsQXZjVUFrWThlRCtDUTNaUUJmU3FmSk1GV2lENDNRdjlnOUV1YVgxS29t?=
 =?utf-8?B?R3N3WkhmTDVlSGx1NUxYdFBBdTZybWRaNW9rbHdCTjJRYytvRGhJUUtHOG9F?=
 =?utf-8?B?R2wrMEhueUkxeERiOWxzaHpLU2xPV1RqOUhTemlFYUlZTGxiTkdzZXczaU5D?=
 =?utf-8?B?OGtva1RQTkxGMU44OFBqbDR1VEU5VmdRcXhRMzdYb05YcThsdkpWOGdOYVVm?=
 =?utf-8?B?Nkw1UnpXL3ZzTlFxQmN6UVptcisrbDdpREJNVkF5VHc1dXh6ZWo5cXpWRzF0?=
 =?utf-8?B?blVyQVY2dEJJSmJSN0RKZE5QOVpPREhyRkwzb0hPSGhFbzhKY25RT1ExdEhD?=
 =?utf-8?B?Y1FuWEpVWnJoTFNIK0sxZEVlVkIwT1AvVlI3a0dEWUFCT1JtQmhPWm41emZX?=
 =?utf-8?B?aVkwOXg5QWFWUWxjZ21mWXpOT1ZYNGpMeDhjbzBJTzcvWnEzRUhHdHF0aStL?=
 =?utf-8?B?akRnelNUaUcveGI4OUIyS2labmVFVWo5VkJIZ1JIYWV2bzFLb09FZUpHZmxi?=
 =?utf-8?Q?UrbI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHJFZHJzTXo5M0JFVHA2VEdSUE1WaE96NGRpSXJkTkRXcW5NSlF6MjVOOWl1?=
 =?utf-8?B?VWovTE4zMDM3cGYrYnE1aFB2bC9JSjBwR043cW1RK0VBS1NvbzBnMmJUUHFh?=
 =?utf-8?B?REhhWWRYRzN4RXdNTWJyOUhZcGVOcDl5eUdtTDU1NmhLMXFrOURCV3ROMlky?=
 =?utf-8?B?ejRKOWFYY2o3T1pVL0cwb0g3Nmhray9GbjFScytwTjhSSzZGT3VNSWEwYWtJ?=
 =?utf-8?B?YkFqOEdDRFE3RHBZUVdiNWpPQTNaR1hTS3NRc2JPeUdCWXBLY1dwY2crZGJ0?=
 =?utf-8?B?cDdSODI2QUpTMzZRRENscjdjQjRYcjk2bGo4TjN0MmxMTFhRZ2FXdFA4ejkw?=
 =?utf-8?B?TWN6U1NCTE5yVm0vWWhKb3pRUHByVDNvNW93aVpmVDUvRzdKV3pRNlRnelY4?=
 =?utf-8?B?Q3FualNTSlVjQ1ZQeDB4UkVWZ2NCVjRvdTd3enlQVitiYlA0WGJTQjlRbSsv?=
 =?utf-8?B?bGpNYVF5bHhYdW9lR2NzYWRzZ2tBM0lSRzZxdEtHM0FlSUtIWmdsaUJkUXIv?=
 =?utf-8?B?QzFsZytublEwUFU4UG52cUFHeVZIWDVER2ZZNmxESlBIbkxkNmYrTEdrMjJs?=
 =?utf-8?B?cnVxT2dwUGEwbG1vdE1JcGFTNXJEclVnMW1lWFI3TzBlR1c5WnVuY0lEd2ZC?=
 =?utf-8?B?YTFybG91TkVuSmtvZDlkeW1ONU5LMHJTNW96czN6ZWVKd1VhbEY5L2ZzUm85?=
 =?utf-8?B?L3I1ME83UC9iMzJheFpIUjlxeERvY2xPVWRVeXhEVm15LytmZ2NYNy83cU1t?=
 =?utf-8?B?RGgwNXBZRVIxb0pnMkIrVFJNVXdBZ2lQMGRONThCcjFhbFI1ME5oWVRTb0VT?=
 =?utf-8?B?Wi9xUjN0MmVpaHVYbnBONFZqQTFYb000K2g3MldseExXOE9NQ2RtN01ZV1pI?=
 =?utf-8?B?dDRMZkRJNG5xMEtXK0FRWXR3QzZ3ZnRaMzdoTFlqYTNzM2hWanY5YXFhMlRL?=
 =?utf-8?B?ZFBHcU94N1U1eVMyOTNBcERnQ1dmSkZzSnFzR0lYeDYxUXRrVGZDbFZVNHly?=
 =?utf-8?B?Zm5CdjBKRGVpNFRFa1ZqWS83V1ZJWTNKSHJWNjFzeVhVYk1BbThLSndmRHVo?=
 =?utf-8?B?bWU2aTFibHlKdXhyR2pkc1ZId29TK0taUTMxWmtQdXJpTTl1bDBMUzIwRVN2?=
 =?utf-8?B?aXMySjlmcFFpb1d6SXg3RTc5K3AwVmZVR3BVSmhZMTRNNmN5RGk5eFBDUTBy?=
 =?utf-8?B?cXZTdDNYbW40NnRUN2xwc3pUQ3VxMVBIK1dQbEU3emVOTjEzN3RnQmNFMWJF?=
 =?utf-8?B?RzFXSnBpZGJzRVJKRHlsSlhma2U0L0dwOTRIWHBUUWRKZTdNR3hVZzNpYkRQ?=
 =?utf-8?B?ZVoxbm02aktkUytMMU9pYXBjcmU4OVlXMmRSYTFYY1dBZnlMOWd1NVpHNDd6?=
 =?utf-8?B?YTY0MjhSRFM0dmxYVWdxVUFob081dXVzcXUrMStvVGltN1ZjaVk3UHU5VVZL?=
 =?utf-8?B?Q0cxNjdoTUNkTzVJakJiVyt0TTFWRGpRVTkxdzJKdG8zNnFEd0xSYVUyNEcv?=
 =?utf-8?B?dWNaSVQ3cjFISVpKTTlFUTFhN1luZzhPZ0UzVmROeHU0Y0o5dlI4WXVOdU9a?=
 =?utf-8?B?alBOcUZzcWJXZXpJYnM0aW5BZHNvTzZUZTlNczlvTXM5Tno4ZUdrTVRFVCtC?=
 =?utf-8?B?dEt4TlMwRG9QQ290S2E2bW9NSkluLzB6ZU1DRWxZYXp6cjROZ1ZNZ0haek5V?=
 =?utf-8?B?WjhSUUJmRDI4UmVRckdQMGZEaXlYVm9BNlRIcVNtcmd5ZGwzN2RQU3phWE1V?=
 =?utf-8?B?cW1UQTVXK1dmakJzZWlXbEdUaWFZZDZQc3VaUkVER1hJaHNvMzg3RW9LeDBq?=
 =?utf-8?B?TnZCbE9pTTR5c2JsNW5rQUVIUUlhTWt5ZDQ4Uk9xdVk2VTNGVWpjOEp5bkIw?=
 =?utf-8?B?SDZ1SW9XMEZ6WnkwalZabVJrbmYwcytjakFvVnVQUzBaKzh2aXUxZm9YKy9D?=
 =?utf-8?B?MldyUUJKTFVnOU9aS0JSYkFQSC8yTXNWaDVPc1dldnVWZG1qVjAvOEVCSUlE?=
 =?utf-8?B?cXU3Um9WTVg0UGpQVnE3eERpaW5qQmZxRk5QanJCSHpaV2V3VXM4MUZ6Tkt5?=
 =?utf-8?B?N2VhVmpHS2FyZEJPWnFnV1hnV3ZUbC94TVB2YmY0RE4zRmwvWGJuakZueEJR?=
 =?utf-8?B?Uk9VQWF1WThmUzlXMWpYMnlYaThrazRYNWxpMEdaQ1o3c2xydDZVZUFUMGw0?=
 =?utf-8?B?R0s0L2JJWFJ0TmF5aWYvZUR4am50QXViY3dRT2JHWVFodGpRQklFTWR1THht?=
 =?utf-8?B?MTZueWJ2YU4wU0FMaHIvbStKVnJER0lHMzdGRXRlWDE0TE81dkNIWTNJRG1X?=
 =?utf-8?B?UUhYWkdTcjJxNFYzemdhMXpadDhpMjh5N0QrZjRwRW5RaWtqOG9oc25rTWlF?=
 =?utf-8?Q?4H5hk2kllQTLDrevUQvVFH6E/f4b6zXV2gPhf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NoeoLlh7UV6CKZH1g9UPXJDUOfISAbffeCiwlNY3Cfgl8exVY3novN3FCCcHPX7v4SwpGmjgq3i7mnIPaNCCN7427yCvrc1StnyN3dcMHCJI75y6Y0zysb6cC6fzxqjfHL9uxMDastpVQOyVAnP2ESDfuZLtl3xdvnmABO+3OHtRGuP9BoussWGZKsY8emD/r5qclrwGW+IINId+q0q9GjW1C6RrR+2KrkoCd6ctozsVL4c2zxg2Yt50IrZMxn1SDgPp9X6tl7lZ7T5AYmW56cF2/O/QeCiMcHABEidF8fQU2TR6SRorTc9LYRcd19Gnh838d4SR3o7XcMZEx1Q5QL0nlIvTGAzOX25ByqgWVU0fv0Gt7+3HGpn8bzuyGiz8+ImhwU9CiCLr2D5GYlmXNx3wPPhoT0EOatUtKX7brbm7NgvEjgIve06/cQPOUHWFqDTOIEiZm3M0UoXgRo+kJVJDhARO2/q0YeU9ZR0R0UChwJzoHIT3HgGEf7szXaK5PUKhSzNhy/ywSpun/TW1u8fjIcYlGhtLOb6lAA2Nj6dQ4VotZmrELoWGZKodxu6XM35UnLBNjFTF8rXk+AFoE1AgWNevSQp+7yBJVOQ3uPg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1354ae63-4e60-4cec-d32b-08de63cee75a
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 09:22:23.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqqccDu+aKqWklhBpLYbSAp63frEfEEEo68JB1JjYUETllJ30mizWanR7GcbZOqqNikwb6JO4M7wo5OlLKbIAdJv7rGyYYp06g/DFH4LLYQcNxiuyqkRtOWW4yGyYTo8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_01,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=755
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602040069
X-Authority-Analysis: v=2.4 cv=OuJCCi/t c=1 sm=1 tr=0 ts=69830fd8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=15ynfj5MqqVvvnM1HiIA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA3MCBTYWx0ZWRfXy+T/3u5tyeYf
 Nn/JB3DvNBRHRvlufz5SgCMr7WG0KEz9Fky8kdQAhTyL3s+QGHbRqqUSzNhebh6s4gQF/PoG9I3
 /7/O31L7aEcPx7KOJ/VAUSJwdpvzlqNRT4TLr4h/sF6a1lLwMCoYVHgM6BSN2bu8W0pgAjaO9fR
 4Wup6krd3hZV0bZnqpmQ1dzxuy1NMc18gtWTJhnSn2+BP3nCAGOztcSkgzv8Kx+RPPbRc2ilQoW
 Yq+KwpcY15fzH87TZd9CiMPneDJxniGELRS5ovtX+5Z3Icv+/QMRqQtQn3Tob2ZDlYXHMJSxZ+8
 9s9efRrnmvhhRrwEjUOytcXjHKYGl/PMGEP4861vsr0edx7x6wWgH72imXqMNod9AMy4WgUOwja
 ZmyZaZwDOno7su9s8QaaUuj1w6Q/7f9kZ8RlMCs2FY08GMOw/tlHqwfG8ve9tD2ywKF1heo6n+Z
 iI3yfEBk/HdtPkY2B+cBPjVCrQTj9LjUrOiaeJkM=
X-Proofpoint-GUID: ANYtq4FXfK5Rh7mPnRMeX_ONdT4vguk1
X-Proofpoint-ORIG-GUID: ANYtq4FXfK5Rh7mPnRMeX_ONdT4vguk1

Hi Andy,

On 04/02/26 14:31, Andy Shevchenko wrote:
> On Tue, Feb 03, 2026 at 10:12:00PM -0800, Harshit Mogalapalli wrote:
>> sca3000_stop_all_interrupts() is moved above the probe routine so the
>> new function sca3000_disable_interrupts() used in probe can directly
>> call it without additional declaration.
>>
>> Used devm_add_action_or_reset() for shutting down the interrupts.
>> Make sca3000_stop_all_interrupts() return void now that it always hooks
>> into devm cleanup.
>>
>> No functional change intended.
> 
> This patch overloaded by extra thing. What you should do is just move code
> upper without _any_ modifications being done _before_ even patching it for
> guard()(). With that additional patch the rest will look much easier to
> review.
> 

I agree, thanks a lot for the suggestions!

Regards,
Harshit
