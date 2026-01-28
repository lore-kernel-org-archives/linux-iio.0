Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2B9283FD9;
	Wed, 28 Jan 2026 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611544; cv=fail; b=d6q1ECHyektPvpNluU+iPlrXhh7AqMSLUIqRW5NWtjRBSdYZ3wR0AXvuNSUmDdYN2opM9T/kQeVTl+jYXj4P/ILvI9CPlCPuwZ+Epm7BuxR6fdqOsVr4fTBzFCx/Dt43TyzwVreXrhQF/Ao2mr7jwIvJxLgHn0xa+k3wO+0pvjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611544; c=relaxed/simple;
	bh=otWGqEDXn09tc3v5JmvOOkwP2ah5dwXg0XdrttVKYqQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PAWReTSiuKRO+EgkiHioTzDVJt/EiKZOH6rdOJBwoph8Q9QGiecj4yVgqO6zzh4G3J4LqLdZw/N/7ECFnN89rSFTSQ2NbNsGbgjrCsN0BTlcReFQajVvJ91D5HNaO872h/lLqNySiPKq0AVA13jkyqNczpVvvrfBbdYJcErzrgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hQQ0GLYV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JcHMRhLa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hQQ0GLYV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JcHMRhLa"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S4EVXp840930;
	Wed, 28 Jan 2026 14:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xT1+o/l6qvE6mCjupwMxHEmA1BiTRt9k0+61ZOJDZJo=; b=
	hQQ0GLYV2Knm4OrvE5imePwibtbBZC3f2tuIv0EaO4741tVItQpGFjuUyX3RN2eO
	snS002nhSnF/v+5QKZZI/NzyMri3wrockA0BnR0KLSHi5JnClEkFdru7r+2k9VWy
	4rwps3UQD2aSOkEvTN6QbpHGlPbPUM5QYrfr79/juYY95U9lbC7CrK2qjEvSBQrJ
	ok1v1uJB5bxf4QpIxhnhdPJkZBb3faRESpfNqH+aSz60pHQwQSNe7ViHp4TltPnl
	tM5kzyS0nIpXsQqhS/rYGC0eauubTrw2ODpgthExue6ktrx72o7S/OuS/eWo+NR9
	ujHFAc1M8j72dgqA+IM9tQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by378hfgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 14:45:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60SDfMsE009991;
	Wed, 28 Jan 2026 14:45:20 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012024.outbound.protection.outlook.com [40.107.200.24])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhb0cr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 14:45:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jo5pavetOOw84AVwvRCjv6cHJ6XcE6sJF/hcv5NsLaiHfLV7Au4MEFWICeD08OJRMvDeGl+RXuHU41JNudDQ0OJgWAo4ull8lYJhWlesgg6jp2tG2a9RKFgjpZ1HKm3LgIRYAv+cjgSQjv8cT9CFgP8idu1HZxV6mjZnEc+O/DBj/AKxaiicTj9dhva5xYs8JQFUZqsCO/MrHKSEXaY1f+pN/L/7gFdLhjPegWQ6jRGac1dmuDHWSS6P7LdrUNjV9qG0SyhDhk35/ogd7iz0xhxGBMepejG/qbsT2XXpyQ3m9W2TmLs5lUe1daQEVOM/MZ5dehejKszNKPgxoSVU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xT1+o/l6qvE6mCjupwMxHEmA1BiTRt9k0+61ZOJDZJo=;
 b=KKAIwIQxmlGDuMfcJXQoDlDoRG1aB+7HIcMzOOWk2qpB3sBIqNCzrBbJIJlBltRdw/Vf6j+3KSCtmQ/XH8n7Q0S/t0q3schpD3KHOVPCngcsHCA8jpS/aQlaNj87/s4jSeK8onfG004SP2nfojhL+/1ddrANJ/Er3eYZY6ArzEBYVeRwXevmNkGGuqoGfDST514cdjQUSj5v/DkSLQatg8xiTjiLxcvFE6GZK1UtduLrQLocHr6IqIu1Dhh7OJREhgPxzkQCAyWygBcHqe5ShI++uVHvxl3msqjmmTFUiGE0en+IzbWHX4Fpzr8qxALoqJIvwbl4xMzLmJPAzPVIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT1+o/l6qvE6mCjupwMxHEmA1BiTRt9k0+61ZOJDZJo=;
 b=JcHMRhLauT3qnuZ/IMYv2jS/qhAzRU16w6NaFsksTyiaC3bPcNmT+RDqUxxKALM23JDUxlxeRRbOyQgj6kEP+roUFWiQL9SmfhwMniFScSbfJ20LlIJrUAdsRrd7rO5LS3QextyCdoab1MC4epfS2CYuvcxjw9duA1Nre4inXc4=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by MW6PR10MB7592.namprd10.prod.outlook.com (2603:10b6:303:242::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 14:45:15 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 14:45:15 +0000
Message-ID: <5703036f-fcff-4474-9adc-5b1438295b7c@oracle.com>
Date: Wed, 28 Jan 2026 20:15:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: sca3000: Fix a resource leak in sca3000_probe()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Gustavo Bastos <gustavobastos@usp.br>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com
References: <20260128064953.2952714-1-harshit.m.mogalapalli@oracle.com>
 <aXnbcNYWaf2u9I4u@smile.fi.intel.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <aXnbcNYWaf2u9I4u@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0434.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::7) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|MW6PR10MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ea1f06-72c9-4836-e396-08de5e7bd92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LyszbU5XQVo0TXBEWWVqWHJCVWpnMEFURDI5T0gyaXExVzRaYUJDTWdvSFVV?=
 =?utf-8?B?a281Rzhmd0NWMGFrN1daSHBIWE5uQVdGMzBZOVFDdDhDYXV3M2drY003U29v?=
 =?utf-8?B?MnB2cUtpbTNtQnZGSzRPSFhpV25hZjlKaXlTbGphTHljcFdnNFVJbE8rWmY5?=
 =?utf-8?B?MXVDQy9tV25XYjltRkZrZThlS1lSZ2t3ZXdIeGM1NGY2WGtRL1BSVU8veW1v?=
 =?utf-8?B?TGc3aE41RjlGY094Zmp5NmN3b0hmQUVZaXVzTzFQVHpWQVI2aWZXQTFzdFdJ?=
 =?utf-8?B?cHkxQi82bkpEcWs2MW9XZzdtVEdITEtEbDRHWERUWCt0ZFpiTU5UcUo0UlF3?=
 =?utf-8?B?TFd0ZVFxL0xuRUtuYjQ3YjF6S0wxM0dmNk1wU1hVcnlmeTQ0Q0lnbmxqUGxV?=
 =?utf-8?B?dEhRdDkyYTFvbTdkNmkwM0FtZlNzRisvZHUvekxCa0psK3l5MlI1dkc2OXZt?=
 =?utf-8?B?OW4zMERRMm5XMiszeGN2S09hOHR1aTVDZGNnd1pUblBOeVVUYy9PaGVLRm9G?=
 =?utf-8?B?d0dHUFUzUkpTU1dWNkNWWWxENnUwbWgvdmJBSG9Wb3NhdUx4OEdJaTNlNGFO?=
 =?utf-8?B?eUFIUVFRNWtzNGV5OHVzVmwxUjNWQ09Qai9ONWVhNVg2NXZnQ1VPMDZ3TXFV?=
 =?utf-8?B?ZFIrSC96MEN6Zk1YSHUwVnBPSE9BQVdIK05Md0x0VTdYWGlQL1hyTjQveDBw?=
 =?utf-8?B?UGVyZzZ0dGFDUXgvajN1SFVwQml5MTlPRHVHTzFXNXRpeUJxaldTamZVTTJ4?=
 =?utf-8?B?TzV2KzBUL2YzR0ZML3BSQmZwL1RFVWFKZWtrQUIvTzlpbU94YzFqcUVzeFhN?=
 =?utf-8?B?YW5IMlhVazVpOHVBdXFVR3MzVkY5Z2IvTXZ4dmR4bnZsaWxUYytiMzVTV0dU?=
 =?utf-8?B?VVdGRmxFaFJGZXlMcXhFMWcvQkpmUkJTbGlreHpGVzBCL0cwT0MyYUE0NjBy?=
 =?utf-8?B?aG00aVp0WTJwVlU3aUw3T2wyU2VwaHZQK2h1OFk5NHc4M01OMVptWk1pbm05?=
 =?utf-8?B?VGVIeXgvSUlHTGFtdG1HNXNRelQwcDdVazNpK0xWS3cvSk5HQi9sNmxPMmlD?=
 =?utf-8?B?aWRPSk9OcEVZeitiVVhHTXkwNmlDSGdNd3owa3RNL1hTbVo4bEpOaFNENVFN?=
 =?utf-8?B?NUcrbEIwVlN1YWltQVJicEwwTFV5TVBuTkN3R1BYVk1ucE51Zy85UWt5S3Az?=
 =?utf-8?B?cGM2RFNHaWxEbGtHbVF1QVZSblExaEMwMHJMNDljNFZDVEwyOWYxS0pUd1hX?=
 =?utf-8?B?N1RFZEFMcFc3Z2N2K2hYcjNpSVJYOGxqQ1J3WVlMZTk0ZCs5WWdoYTd6anQy?=
 =?utf-8?B?dHpXKzZwb3NZSzRzbzF5OVVRamJ4QlNVZk52ZHNjVUNldCthd2FZeGh5WUNY?=
 =?utf-8?B?WThhWWlIcDd0c0NlM0NGNHk4cFNCOS94UitXV0R0ZmhsMWhPWHpkRWRHT0lG?=
 =?utf-8?B?YzZqbnJmRmVicWdiNWdoM3RJMlAxdHFYN29ValdSVGM0bnM2VVF3c0gxcVNy?=
 =?utf-8?B?M2I4WUkzYnJCcjlNN1F6Zk8wc1hXM1hLRmlHaGYzbUs2WVdTTEtOTytvUWtq?=
 =?utf-8?B?SjJMZ1pCZ29LbS9sRFcvTXRTQUhBbEdDT0Y0WXVTTXlTRU5CcjMxWklMWVZB?=
 =?utf-8?B?bW5IK0hyaTlTWUhDR0hWenZzR2VnUUVpSUZPSit1S0ZWSE9jeEZUSkpobURV?=
 =?utf-8?B?QTQ1dWpncnVXaVhCUWdrWW44VGlrQTlMRFR5eXcwTU5vUTNkazFCV0VFdjJK?=
 =?utf-8?B?Q1g0SkpibG82SWcrdVdoWURUU0NYYzZ0NWo0ekZYck5KeDFJZUZxektVVmRP?=
 =?utf-8?B?ZU5kazZ1c3lJR21iYlAwc29CTzRWRnBsNFdrZ0lTREZvc2lSOW52N1hjSE9x?=
 =?utf-8?B?RlpyS0dZSXpENXMzS2hVMmZNcUd3L2phVU5rdXFRY1QwbWlDQXI0NmIvUW9L?=
 =?utf-8?B?U3VTLzk5eGJqM3dZL3JPbTA5ZzVoTk95N0Q5OWltK2l4blpLYWUyT2gxbEFC?=
 =?utf-8?B?a0hBYUs4ajNDWmRZWGJFbVN3Qm5wdWdzeVdHRXl3Z0NtTjFUaXNXdTNvejRB?=
 =?utf-8?B?TDVHNVZHYkgxZjl2ZmViVnJoQ0p0N0VhUjQwMlllRzNZOWtDbFpRaXRGVFk2?=
 =?utf-8?Q?u8n0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG14bkVPV0JnWWR2Ny85THBkM09VcXYzZytaK2t0bG5YYm9DOVg4Uy9JcjY4?=
 =?utf-8?B?bDNwUVlVdzZ4bWY3Tk5TbGxoOTV5eWxyUWd0ZGFJeTVmVDMwd1hjRE9OcXlQ?=
 =?utf-8?B?emc1UHpsclA4cTRSQ2dsdnA5R0ZSMkplRTI3cE5CbzBocHBzUWRzdzBaaEJU?=
 =?utf-8?B?Tk5pNCtBY1RJemt0Y1NIOGF4UzdMd2lFakwvMk44Y1dUWVBBelRKVHNLUnIy?=
 =?utf-8?B?TEEwN3Q4aHlTS3lYd1pIcDV2S05jdVJaRkJ1RjJIY3hjdjB0WnlZTGlsRGV5?=
 =?utf-8?B?Wjh5Y0xROWY2RWNMYzJORGlJNDB1VVNhTmFvZjVHcHdqcllnNThUcTYzOEZH?=
 =?utf-8?B?UUo5WXFOUDc3RTVNaFkrRmo3T1R6S2ZIU0VRb2RyekNHWGVBUzVMdU5LQzhC?=
 =?utf-8?B?cDJpV0NzbXUwU0ZCcUNmM2VpZWRKNktzSlI1MEpONytPUEx5bHFyUnR0aVU4?=
 =?utf-8?B?UzQwUGd6aDl6NjNienJSTUlKT25Ea0Ftc2hRSGRMV3FvVHhERVZqMWxTOEli?=
 =?utf-8?B?OWNBT0RyUDdOaVp1eUQvOUFMdURXYklFWWFnWjdKVUlzYndqd0xBVStIODYx?=
 =?utf-8?B?SytPemdDOUJoQ0lDQWhLbGJPWTJ6aGZSdkRhNVVDRmFUcE8yU3FETTBQM005?=
 =?utf-8?B?WG9YUU50S0N1eHhuNU9mNzIvR3hweHFVSGdiVjlOOUFsVEh1SzFoNkY5VGpE?=
 =?utf-8?B?aE1jbDU3bmNKOVJvendYMUtqT2htYTlYRm01T1BwVk5iQWZYdnc3NXVqenlO?=
 =?utf-8?B?bllUOXRZUnF6dGVUZDRpeFNjLytJZjFHd0JjNmxmRWFGQ0JzU1FYWGh5SWlS?=
 =?utf-8?B?Y2xyK2N5cFdIbDl0TFBETk1mTWdsbWxHNGIvRjg2K1crdmVjcTNycjh6bUxW?=
 =?utf-8?B?a0tpZGdYS21TNTVYRzRHL05nTFgxWDJMakpacmxYN2FsaWY3cWs0Y0VoK05L?=
 =?utf-8?B?Rjdrb2FFVjNzNVpCc1J5aEZSdmRGOWpMdXhlMytFR2dxSXVTK25aWWFPNlJL?=
 =?utf-8?B?ODlsTWJJNkEzU1h0WFhIOXY3QkZTQ21nWG9oL1k4K2duYkZTVGJxM0l3U3h4?=
 =?utf-8?B?RmtUNDJQVnBUL3BDVmZRdEtQYm9iTlJVTnlWS1ZzWm9nUHZjTVd2amMvSUZL?=
 =?utf-8?B?OWs2V1lqL2lXcGVlNmFaSmlyZzU4NjdGdHBkOENKSzQ4WHJvb1l3U0lpNko5?=
 =?utf-8?B?MjU0NTlpY2wvOEczUFJSWnM2a1RhOGh6V1dmaEw4b2V0VmZHeTMrUlZ3bWZJ?=
 =?utf-8?B?QW1vVW4vdXpQbWZZRzZzS3JDa3Y1OHpKTElYS2dDektsZFBpOVZCanZCRHZt?=
 =?utf-8?B?NjE5TloyeXRDOVVYbHk4V0NLRXZCVkxKMHU4bE01Z3RpZkVTOWFCSUJqdnVJ?=
 =?utf-8?B?WWltNFJiRXBNSGtmZUVCcHRwTWszTlQwRnBiYmxzYjNXTVIvTERJS2pTS1dN?=
 =?utf-8?B?ODVuOFdDa0NwQVlYUUVFNnptVGd5V1NpcjJBWi9aczlmSjdaYjIvVFpISy9y?=
 =?utf-8?B?elA1WThVZ2I4MFRHWFZxVU1teHFkeDFyZDlxUEN4YUw1ekJ1NkF1b2trQmJh?=
 =?utf-8?B?OVYyRmM0aUQxdjluYU5oeFo5VU1jTittWWJtWG1rZ2tGM2JtejAxb2k1ZDMz?=
 =?utf-8?B?OHVJNnhWaThYd01OZkF3NFVlWisya2FzUDE5R0VVQUJoTHZJUzJBVnl2ekhq?=
 =?utf-8?B?eVl6bE5vaExhNk1QeFZxSHdEMmd1S1JmdnhGMjkyeHRpNktjaWRNUXVSSWN0?=
 =?utf-8?B?OFpiQjZGK2tjTGM0aXNqKy9OdmtkNzJrSXhxSUV1enozVmJKMWRVZStWTHh3?=
 =?utf-8?B?a1gwR0hlMjFnWTQ1ZGhxbklENWxLSExyU2ZETHdrZWYwNEt1THFFVmZoSHJU?=
 =?utf-8?B?TjRhK3doWlJHM1Nub0xIeWF5NWdveUN4a29kRVI4bndDVjZ4WE1WS1haa2ly?=
 =?utf-8?B?SUEzNkt5MmZWWWJYNmIzY1F2QXhrOXBWQWU3Mk1ncUdsdHZsN3JjSWJqd0tD?=
 =?utf-8?B?alhDOGtEcVJuMFVzTFV2NDJQMXJodTd3ZVpLUzZsR0tvZGJ4RXg2NWdkZDlG?=
 =?utf-8?B?bkQ2ZE0yR1JkU2IyZVl0eUg2dU9hWW5VQ0pieThjQXFwMCtEaUNoTTI0bEdK?=
 =?utf-8?B?ZWhKbVU4RjlVMDRzMmJ6bk5UUndaY21JclNzVFpqdlNYdUt1K21pbzNUbzVU?=
 =?utf-8?B?OHlKMlJraDdHM2tUZlJObW8za0M0RFQ1L2h3dmpSTms3bVR1ekpwYzlyR0cr?=
 =?utf-8?B?SXNqL3VHOUNidE9FN1hKOXIzeWFFOStSVXNpbXRlZWJ1b2xFZFptbEhlTzlJ?=
 =?utf-8?B?OWRHVkJtcU8yNnM0ZjFrZGlGWjlza0VINUpCTmpFNUhIb0RxNTJqZ1NTTERY?=
 =?utf-8?Q?VqyMTaNdQ96FyXqe2UAdnElUDkbSg/+GGEkKk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nJsCVmsOEOZaJnQ6y77q87QAKwWqhbYSwRqQ1St0ZM0MjTvm2JsDteXTsleMboclA+JS2uv8jxT2N1n/VK+qK3+kDkiL2fBi1YIJyPzwpk2tlzI7xVwNPiCd5Ho/e6uew7pb68BQn3ypKmt1uwh5gOUnH0vrhWJYgET+RxOLfsx1Wr9BgScgZehT7W0iR1cuQ0Ii8emGh9Jc27TGlNWFzJUICBHd7G3ZXD5/EIPimhGdF0mBw0IwZS/hYkNyYczXZZYd4k2mFI7bbuXL1hbh4aHwncoKcRmzrFFRh6Vw8SRTnMFhlzjmd6t42LVRrm/niLL11L/3p2E8onC430hZljgRC+mBB3zDxSrffHNHtmhyfz5oZWFC44CVPBGzNHOZmCP9z01Z1ntYmHWGP0y+mf50taqx2XeGvTYzhDXbU/TmYU50oWD9oUYNMmRpHS1lq7p57NR1Mk97GFDgBQtGCxmrQ75t6ZaeAhWWmdWWO80tTgCVGjtbxoNYwXpihVxFN4Nbpw3V646oSovpE48cEDRnNLgbQRBEJ/CWvQWn6DhoJ8n2tmuZQKwFeQbkMIMY4f2IjuMp1KM9arUZgx7eIiQyIyQSMY+euV5NCZ7K/q8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ea1f06-72c9-4836-e396-08de5e7bd92b
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:45:15.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0Xoi9rhiDZXb5puvhdFRluBno6VRtKUoiWoU0rc4uIdEIA1bB9wQrr/029dx51uHZ/zzXhvOraPeICsiEGyNXTTdC7wrKGi71nR99++q0yE1lTXOFKosX/oAUqGlIOz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=834
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601280121
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEyMCBTYWx0ZWRfX+UmqOIX5Obyp
 FTYwZF9EFYhVNFVLw/ktYm/pf82OqKTaVoo2pj6qxHQS1VVgbe5H/E+EDgHjarN+uLAy35dG8Ra
 7kh33m50N6F7PD53YGzO2z+mxUuHwg6QsuruqzQmmoKIe0HhauYZIRjiXS1vKi7VOYR9o7EbZ9O
 dcExC9+bnPLcELIUbsD+g7NKUecIfX/pPhzrxBeUMRnrdPXfFe2AdNtqBenhyyRTf82ZB0eUgcd
 vtwY4MW01QmybL4AGU8nI+/XiafgmzGqlhr0J6Mr9iL7wXrcdtc5RphRvqeHBr4dBXGI35fB4vf
 TOp8+bLeCfjaaEe4Yqj6i3GNmzAT0fGbXdT66OCRGXyNZJ9q15KxZM7U1IstF68Q5waZY5+CCUM
 obIJgcEKYIDhmy7Y+/wQ4UjrBR5DCPJeQ9c+yWhOh8hJdAyX3OknWMbXrto5lXvj0VKnUGsjEt8
 Ly6jhJPA73hhu50rHqw==
X-Authority-Analysis: v=2.4 cv=a/o9NESF c=1 sm=1 tr=0 ts=697a2101 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=8TJ66IoDh_pku07uRVcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tkW3lwdqFbsTyb4My3UOsN1wY68yvFh1
X-Proofpoint-ORIG-GUID: tkW3lwdqFbsTyb4My3UOsN1wY68yvFh1

Hi Andy,

On 28/01/26 15:18, Andy Shevchenko wrote:
> On Tue, Jan 27, 2026 at 10:49:49PM -0800, Harshit Mogalapalli wrote:
>> spi->irq from request_threaded_irq() not released when
>> iio_device_register() fails. Add an return value check and jump to a
>> common error handler when iio_device_register() fails.
> 
> LGTM, but I would rather converting this to use managed resources.
> 

Thanks for the review.

I’ll follow up with a separate patch that converts it to devm-based
resource handling. Maybe that helps in a way to keep the fix and
refactor separate ?

> So, if Jonathan wants to take this first,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>

Thanks!

Regards,
Harshit


