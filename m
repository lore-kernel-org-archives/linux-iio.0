Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795689000;
	b=ZdPfdwlXu8lNb1G4PwHyovMUK4NlMVVXRWmJ8EAOpTdl8zh4D2ie1/qFMh7gFC3OdCaT
	 cE9WGC2Y5jqxhh9Rx6eroZKvG6/5MHIoJjY8CRN2z/P3QxX4vAVU6czvAlAAngJ7y58N9
	 2q/eDYiOE8RNeqiFRvKi/n2RnCfsXMvbm7iKnvuB6WFRdKKxsZ7CaGCv8r0045NMpBYeS
	 hXMZCuuC2JHNXZ8FrW5ujcVYhzVzxNh/F5py/b//PMZZSnWROKHkpm4WhQUmZPyAoBfts
	 Wtk8ft1rtFHqx4TyvhV/h5VU9qCuT7MDi5gxggO6IiRmJTDknbYeYhl0ZlNBv/4UyPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689000;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+Jo87Onk6ftJbYThayDUnx4DVUkc67V5PuY4PEq17oo=;
	b=3ImOiV2ucp1LaPo7wtnU3xs9yVBl6JDVD3rtKcAImmoX4ThCSbeMlyWHriqf6lg/0i2P
	 v5j01zraMWYbQYpXVRQr/y7gJqkvWCgeZO5eQkhv+ynE8IrpVPzTh6TP6ykKll5GmV7mL
	 bMHxgyBUGH7RZATfvXk1EhKp6yBzAN9x1pv6miuEKd+CKv56DVNwC5sPebuhe0Lowgfl/
	 RblRYUzJyxDfIyViQ6FO87aJI4vMQZoqryrRXBDxZlkbyILd7YGe0Z3q2A9tJ7x2iahOj
	 Du/CndV4EgoOANAymXcRb6D4ZEJ5R0ULCseNyqo0OGW5Oktm6IPix0qDO8NGcoAtprg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Qj70yjdD;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=HH7Jlc1P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E48606A6B8;
	Thu, 26 Nov 2026 10:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57E48606A6B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Qj70yjdD;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=HH7Jlc1P
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7EOe0306146;
	Thu, 26 Nov 2026 05:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=+Jo87Onk6ftJbYThayDUnx4DVUkc67V5PuY4PEq17oo=; b=Qj70yjd
	DK3y74zEyJGLLrbWzE4Lum2NJF7yeZdEE0ntGOliPYy5XQAUdhB9worA1DW4Qo6n
	3gV4xn36i7xGYyEolTKydHZ5BUzLlkwfLRm52bZ2Y4XJshYCa6j1/So+YHpHj1HV
	DJmvq6U3OWI9FGM3Ek3mR9SQ4UgcjPE5S2L+0ElM5arTsewrM/8b4A8RGS/yUhmv
	x290oMrjk+33fx4iqbAM65OKDuRiDU9goFhssYFu5uo6+jShPDp/wXhj3KvWOo0O
	6/5o9/IYNyU0LHQUk1BzEOtR+rS7nJpasK4wINHP3MStLIUSPPfPWJdcXDrtHpZL
	QFrkb1H1tQb3PXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+Jo87
	Onk6ftJbYThayDUnx4DVUkc67V5PuY4PEq17oo=; b=HH7Jlc1P55JVrUsKlDkiv
	Z5CVzCCJJrHaelBDqjr6gTaG98aIkM3gPRTkFmYDZw+IeYvErnO86U87Gl6/4LW4
	XJjUCe79uMzloINfqFZ6T58A0QMH9m2NKZN/vm/MWh845Vk+4anDHKVgX/xU1vOD
	i4zI85IzODZ3Dw0KIYlPGWcGcstMnypXDmj2O7lMjr4REZsR/ASNDQDIuC4rUpag
	a4DDUhgr54p9ndyhM/TKQX66K7cv1qkjbTq592Go6j5YQDlBUBCmm9rh0ZMcRZuH
	x5gOGh/nyZdbW2Y6iz04jsCtkMNY43scY+fEf7eYWsWVGJWJD5n36yss8JpY7kD4
	g==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j5uq8xq0b-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 05:29:44 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxhQbHCb7PSA5M37NFpAup2sSTpH6hGNIG50emFcHulYrtgkcmp09Q2pfpJV6VugSWnmOwF4vS0WIHRfIaqNaFqyKXL/tom9IUmzd5kqPlcfj7Y3/dT1kD90YZsrZMkxkxxkGwSG4noah6nVhcptKLr+q7hE1o7PLR4IgJNHjlckVM4QMOt9C6DVn488l91UOPbyjTcGnKTxLEM1N2JxJRRQNIT5klk7exbTl4Z3f/BgK8ETHIJvJDWDDzYfKhhoAkb/jjsuG89Ryqz2/4ft/GYO0FhySVZc3S4mxQVYT3gKr71MVmLvXegAVYxG5o98y9ij6d9JS7kj0XVe7V0AVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Jo87Onk6ftJbYThayDUnx4DVUkc67V5PuY4PEq17oo=;
 b=BkkdqQhErZ8pDCAIHZCLC6r90Ae8l/HTOaKSHAhEPBfUTZeEn8Zz8PpHzISq5MmvTqqUG3pjP3+f1IkqHGnZ3syPwXi/8X0kC68UsrxR4zg83Me3We/86jCedl5cX/7nmNTnlAjPHz2CKwP+69yMuU942en9lYH2cDe4gYimDImcg+VGBP3ATH+iZ4akrCWSNvb/6ErmLKR4yEd4RMAFfKuPmQ3tOHiDIw2Uo84OzzDV4pi8hiqR+Xp1gTkWTN1I5ceTovJv10ty2tVUUgiHoKzFbZ1Yv1zNWY1Hl9SG74cQDtVltgz0T/cw1dGLrq1K7GyRoVy3QEdrWRqiIdumTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB7442.namprd03.prod.outlook.com (2603:10b6:806:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 10:29:42 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 10:29:42 +0000
Date: Thu, 26 Nov 2026 10:29:37 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux@analog.com, Michael Hennerich <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/6] iio: adc: ad7793: add firmware support and drop
 platform data
Message-ID: <awgJ9_3WEqtcdkEn@nsa>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
 <20261125-iio-adi-legacy-platdata-v1-6-54e4c8830b57@analog.com>
 <awa728YWKMfpwe8c@ashevche-desk.local>
 <awbA11Ps-v16BKxP@nsa>
 <20261126020051.670fd7bd@jic23-hlaptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126020051.670fd7bd@jic23-hlaptop>
X-ClientProxiedBy: ZR2P278CA0089.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::20) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: b9998b4a-5690-4da4-e397-08df4ba82e9e
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|10067099003|11063799006|56012099006|5023799004|4143699003|261022075727099003|261021121427099003|261026121527099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 VHu0GDkwcLKONqJL64Cu8TZEZ4Hb09+43qD7vo2fKrh1ySh00LybMNjg6rhRc7vDu57PDobq/EVCRCWlx7msoNY/76ObqqUV7g2PgQZpGAVe+DmRCK/mQzAZw2zuTEXFJtjAGoJs4A9hYrnmXVCAuqFwr9A9N5ZHJhkVf4KEI/fl6UOTe/zyNRnf6LWWfSmyIVnzplx9GHbwer8F7tB1j6ll+WWI/mKxdejVn2iNKy1rxdg8JaTgYqK9W4suoO9yxU9Z49mNVrwyVIXnSAOGUMQMqHo46SVJIRVMqvx9GCSOwvxErrOvTYU2cscvp2j3rPlk+RPdJojbCxpMjn7zZw/Nnt4HU4MjdY4PmiIPq1/UyCd0CgvntMgVL8CLKMnbTefBxLF8vGb4mfg4G75l3LtyBejeVuPtxyP8oRamE9liGypQA8VQt5bjxUsjCWidfTtwZ6v8eVcC5kYmODMRA9TqJwgTGyPFlUQ3PTPQjPmV/liKr+XZNmlQ5C5FJBxhkZqHqu9BFVAtBYZEF439KY3KphEzcXD1OYr7iDIR9DlLI/dPKK69IMQNOjL1X7YuMI3K0quKhsxsSoArWx2JFxy9skJdJdNjPQte8zwNOms07e1flQHQgBD2O+hbNn0ddwzzkNXMzH6hOAJk4OfMcwRPkXPyEPwEhh/bmWnLNZc=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(5023799004)(4143699003)(261022075727099003)(261021121427099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RTdqd1U0dk9iaEp3Q3ordXkreXk2aURodWdWUVRkdkNYY3BxUVRsYnJPMDVy?=
 =?utf-8?B?OEc4T2NZV0s0dXJnaStlS01aRzRtSXpoNzU1MWg3QWV1dktKUmpJRmErYTZm?=
 =?utf-8?B?anZkRWU2cWs2ZkZLaDkxaG1xL1R0eGFHMXl4b250a21xZmhDVGpnVXF2WUph?=
 =?utf-8?B?U212ZDhOYnJ2ZkE5UENFa09Zc3k2Ukl3SVNsN3ovTGE2RFNHU0djaWNiTnlz?=
 =?utf-8?B?alhnaWNPUEVnamhDTGluY1hPVVRLMmg0ZFBVWnlIOFFXWWJSVHQ3VFlodVpM?=
 =?utf-8?B?b1o5MHpBdG5zNmdzMnFsbWhkc25aa2pKVWdxazA1QlJjeElQRFhGOW5Kb1lk?=
 =?utf-8?B?bXFXR0pYcm9BZ1UrYTcrNGFqTkNOWXdTLytOTWVyRUhyQkdGWWd2bFRjNmdq?=
 =?utf-8?B?ZTNCVUhocEd4L2JtZUZ1U3RvZmxyMlBuTEdhb2ppc21Gem5YWDJJYXFxWmti?=
 =?utf-8?B?d3dKb0lBSDB6MXdvYUNiWm1TTHBBKzJTQXJTTDFEcGVFdGQwNGlxY3NCeEdN?=
 =?utf-8?B?WnlNQWNrbDdNSmRWaHZST2w1OTlHdDVXUDM3Mm1hdFhuVjQ1NXVtY0hQb0dB?=
 =?utf-8?B?SXQ5dVQzcTZnMndzb0VlZk9VQXZxWnZWSXg5enlaSUtRdmFlQ3RmdENBcXJp?=
 =?utf-8?B?dWtucXBUbVdwbEUzYzhVVTJVZlBVencxWGRMU0hoTndXV3hzMXY5eW1SbzF3?=
 =?utf-8?B?QU1VUjVpcnJNeE1tcm5YOTBIc3JVZCtzUTRERUh0cWsxV0x4RXJJdEFZVVQ5?=
 =?utf-8?B?WU9HNWZpVHUwUHY3dlh6OWR3alZiSWVMczZPTzc0Q1VGVFdMbGhuZjBidVh6?=
 =?utf-8?B?TnVoaXdRQWR1SmJVS0VGRCt6b2sxM3hMM0VVU1I5d01LeUNldllXeWtNTTFw?=
 =?utf-8?B?SWFuZE5Va3hkOTQxdHZuWHpNR0lkakFnTm9XaXIrVlVKSHhxWGhXQURQQ2hK?=
 =?utf-8?B?ZE5Wc05COVIwTnFyS3R1bEN5Wm40OGF6dmtWSWN3b2lub3pWd0EySHhwK3VE?=
 =?utf-8?B?RVZxbGRFMWxZMFcrSlJzR0p3QW1icHR5bzliRWxJeUVmS1FUYnplaEJFZkVr?=
 =?utf-8?B?UEppbGtKVlFJd0VsREVyZ3hPTERzek5Dbi9tOE44bHZqMnRhbkx4NG5OZ2U4?=
 =?utf-8?B?b1ZEb1dwOVBmek8zTTdNOVM3bEpTMGxxTTB2UUhmVC9RckJhNVVnWVoxWUJs?=
 =?utf-8?B?ZituaVROUXJuTzVkK3NydkRIZUFpeWRPRkMvRUUyc2Y4QzRRa0VFczlENGQx?=
 =?utf-8?B?WlpZWDQ1aUswSHgzODJwQzFPbWFyU1F0SHIwY3NDaDcwTUlFV1d2MWc5WC8z?=
 =?utf-8?B?Unp0RTV5WTlheEhPUWplNzg2SktGbUNaZWd6VXVIUEZubG9MM2RpTk9IWGxr?=
 =?utf-8?B?Qi9zb20zSDhaZUtqVmplbzNwYy8zS1lRU0xlV2JLN3Q2U29OQ3pkTjZzUHUy?=
 =?utf-8?B?MjdIc0RTbllzS0pzZDB5eEZzdFhUNUVFclpXUG1CdWs3alFPaHFlUFdoREE4?=
 =?utf-8?B?N0tvR2xPRC9sc2RNK1hib2VEMHliRDNrTFYrcGNBN1ZsTjgycWY0SFU2Y3Zr?=
 =?utf-8?B?VGRBTjE4WHhFbmlBd21yTTgxczV0cFBKSTl3dVpkeE1IRXBwUXFGaVZHZWZG?=
 =?utf-8?B?cG9LSmkvR0lhVCtabkNBU2NLaTlyRFpWY0pIVUVqQmJyaGw0Vi9yMGI5Snd2?=
 =?utf-8?B?Y21ySzVkK0ovWEZRRTBRNDBka1dBOUV0cWd1bURablRKVzA0cDhYQzVXeDFl?=
 =?utf-8?B?ek5hZnEyYU5mWU9kZzNtNE1OZDNDL0FqWkJ0VG94a1locWVkdk5mZXREMUZO?=
 =?utf-8?B?OGpNRVdRVGgxWUVXYzlONEVlZE45OWFER0lrM2d0Y04yY0plZCtUaG9RemhP?=
 =?utf-8?B?RkRHUTdjcVVadDlxZkVudGMrS0VhRjJCeCtBOXN2SzR2ZU96U0V6c0h0bGdx?=
 =?utf-8?B?bHNSWitDVTdPOS9mSnVuZm4wSFlYTkVBS2Rid2N6T2VZWENieDZEbVp1MnNr?=
 =?utf-8?B?SWNaSjVibER4Nk9SRHNKUjJXRC80TzBaaHRlUUd2RWNZc2ZSemwwMG1VSTZK?=
 =?utf-8?B?VWJXYWJFZU1QTFRPdTY0bjV6MzRZcGdEeklTV21QWk9SWDViV2wzWjZPdXZp?=
 =?utf-8?B?VUFIM2NFWFNWTk04aHVvVGFIOVFLcUkwREcyNzNoOFZkOTlEbTlUYk1MdEFp?=
 =?utf-8?B?ZGx3YndnUGhIWGRFcDhnKzJuWWFuUCt4bFQyWmYza3Q4UVJxUTJQSzdnMDBX?=
 =?utf-8?B?bzk3a1hvOVE1bUdmSTVuaDRRY01mSDlwVWdxWXBmakdWWjlvcjNsTE5IREhu?=
 =?utf-8?B?VXNMbENLdlhZeEV3cGtpYjRDanFZdG1hbTFHMjJhRVpwbTQ5ckozQT09?=
X-Exchange-RoutingPolicyChecked:
	dVZHbzmntrh77dFs4pzpwpjfh7MGcCnrPzN4eq22Cer+1Os8CCXS4W+g5fwgZwEKphbFRcaxHJ2EnvtHVELylCabRsWkm57KjLj5VH3H0FjlztOJkF9vk0tEdWI+5IipLl67xW9syJugrV7voTR6SQokSCi00gL3lBLFmuSGpG+LalEAMCOtHfhr30zL9m8XsIG6BAJDO47fJfaKeSvHIOKaImOYofUfpf2y4ZsFLIbsJ8y55v0cckrEFelYYIRKKc0WXzSNqcaTAcUDKnkPp8eAU1apPp5BBoSrRy6HVuRDaQcWnbUH6J31bXNW/o4sQE1YpaxYDmb7/botZDQqtA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9998b4a-5690-4da4-e397-08df4ba82e9e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:29:42.1648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFK6LkMVrwuLdHf57Mew8DkaAozblZuZX2g9GfJOtGzsILCyeG1QgGoNhu51JfWwbCqfHZs2Oz02StaywGz5JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7442
X-Proofpoint-ORIG-GUID: pLXZLpXnWzhzz7MANSBe5Pq94cV8zDHa
X-Proofpoint-GUID: pLXZLpXnWzhzz7MANSBe5Pq94cV8zDHa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0MCBTYWx0ZWRfX1Y7nOrXkiNA3
 3cuEQUzkIbi7z4OI4qsIz2Kki3JmKROKdfl9IcgW08vHcNKQTvhHc189m1/dI6QBjt2x3peBwzf
 y6Ja+IZcWK8DOL2Xq02OyYzve7J6kFt/Cz3LlNqcpz+nt+2IQDTa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0MCBTYWx0ZWRfX0ogUfCfyD93K
 dbg1uZPa9xJZQ37ycS3kLFhDT574mWEMlAkTW/rR1zSGuKQWQYYob14TuRNHcD++X4b3c6ka68T
 yO3pfWKiO4vbziE06DCuHs/QHFB4atfvUgs2Wa5btl2SGIboeEdAMzss7nzKxvTYH8vLYUavgf/
 FX3TjE51odYSjS83iEZqtZWlhHDZPFUA4eTS3lM2SMR0wxsGIoAtI23XOktmzXwvediQt58K57D
 lmW3Mx8XgU2G8R2uErceJ04tGcRPhOXU1d8MYlCBoSm9rwQrGlBElh3IvZl1rxHFlal+XYuaSQa
 5n3ihEpQzJsbtcG+f+ENFze7ot11oXA1su2oqqTZmiXPiaZMrCaqDOlrZ3v8LknzUENRFuVRmkt
 85xzsnS0Eu5RDaHS3qv5IhvicdAdK4roanunL79sRPbgG+dOmJ2K+kAuTnG5NTuoUexNlYpRQbQ
 Ofrr+UeuecqfEf3gvtQ==
X-Authority-Analysis: v=2.4 cv=OozaWC/t c=1 sm=1 tr=0 ts=6b080a19 cx=c_pps
 a=/Dg/agRq+0IGp9KZEOxzXg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=gAnH3GRIAAAA:8 a=LMpcr3y4afQz4Znmu3IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260040

On Thu, Nov 26, 2026 at 02:00:51AM +0000, Jonathan Cameron wrote:
> On Wed, 25 Nov 2026 11:11:48 +0000
> Nuno Sá <nuno.sa@analog.com> wrote:
> 
> > On Wed, Nov 25, 2026 at 12:43:39PM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 25, 2026 at 10:19:22AM +0000, Nuno Sá wrote:  
> > > > The driver refuses to probe without struct ad7793_platform_data, and
> > > > there are no in-tree users of it. That means the driver can not be used
> > > > at all on a modern system.
> > > > 
> > > > Get the configuration from firmware properties instead, following the
> > > > new binding, and drop the platform data header:
> > > > 
> > > > - The reference is REFIN (REFIN1) if refin-supply is present, REFIN2 if
> > > >   refin2-supply is present, and the internal 1.17 V reference otherwise.
> > > >   Parts without an internal reference need refin-supply.
> > > > - An external clock on the CLK pin is used if given. A 128 kHz clock
> > > >   is divided by 2 internally.
> > > > - The input buffer stays enabled (as it is at power-up) unless
> > > >   adi,buffer-disable is set, and unipolar coding is used unless bipolar
> > > >   is set.
> > > > - The bias voltage generator, the burnout currents and the excitation
> > > >   current sources get their own properties.
> > > > 
> > > > While at it, also enable the AVDD and DVDD supplies, add an OF match
> > > > table and fold the platform data checks into the property parsing.  
> > > 
> > > First of all, can this be split to a few smaller changes?
> > > I will look at the rest later on.  
> > 
> > I could but is it worth it? In theory this is all actually resulting of
> > the same change which is dropping platdata which means supporting FW and
> > of_id_table (the extra supplies could another patch but it comes
> > down to the regulator bulk reg). I'll double check if something can be spitted
> > but I do prefer to keep s/platdata/of_id as one single patch.
> One churn reducing thing we've done before with these is to squash the header
> into the c file as a precursor. That gets you all the enums + lots of docs.
> 
> The we get to see the switch to a firmware filled structure slightly more
> easily.   Another thing I think we did once or twice is just leave
> the platform_data naming alone.  That can also reduce the churn somewhat.
> I'm less keen on that one but you could do:
> 
> 1. Code move for platform data into the c file.
> 2. Simple renames of platform data to cfg.
> 3. The new handling.

Alright! Will go in the above direction on v2.

- Nuno Sá

> 
> 
> 
> > 
> > - Nuno Sá
> > 
> > > 
> > > -- 
> > > With Best Regards,
> > > Andy Shevchenko
> > > 
> > >   
> 
