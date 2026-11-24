Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795519591;
	b=eoYenTz+D3Dj7hN+Q0Lvv43xAKEuQWovlqzBQKoyntYLniVOoqMdr1aLtUBmnArcWltF
	 wuALu9rDEMTCw6FYNq+SrRfiTWbnx6dky5/tjwVzNjahLsIhqRaAPEXcWc0Nit6/9nMdv
	 BidkEYtI8eZvw8Dep6uFjyG+4vx0H1lKbCCPnKroR3BGzNIUmec5yIEfn+DO9/p5C1ngu
	 P6CoAHqrPjhYoYRdnMYSkODZ2YL+kxmkYTRp/uP9uXc+yPW/l+Oitas41wINchxbi5/Tv
	 J+kBer+UduhFQMtZmtu36entz0LPHP11m5+8by+uHcFNgf18sQX9a/sLODS1LrGf45w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519591;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dGVSUhAKABda7G8ygqy/SjraxGh07QmCWGUMWMWh4fw=;
	b=bopqmjG5Q1pu7nY6J1VZxIXuevnvNbfuzCKRJeKctgyvwpljJMFFuqUf/oGVeUcjXcFu
	 zqNNXLnVPjauROStOsoBWiRtH1KE2Npf1N/9il/gwyzxtgH7xedin1qa6UEJqTjANT3z5
	 MMyBzHq5QHs677sbGHNlWUPqzR7/L9k2WwAgfMZI8DU4vTJaYbxcWa1d8wOUBbKWqE3oM
	 vwP20bS66JNIbzBZslYVx87C7xzPvTPm19K0sR4qrm+6hPQn4lwIPIv1uTYlHqQAE+vYy
	 7qJLVm1L0cHTgS0TzNz1NmCfOUcPBuJ7qjIaBIF7lwK/tUU51nDLASOYKvRqpqpJOnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=lvVzLDfa;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=x8U6Vuth;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBC606A31E;
	Tue, 24 Nov 2026 11:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7EBC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=lvVzLDfa;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=x8U6Vuth
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAuKXe3504129;
	Tue, 24 Nov 2026 06:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=dGVSUhAKABda7G8ygqy/SjraxGh07QmCWGUMWMWh4fw=; b=lvVzLDf
	aZt2gBMZb53wtvrqCve219frsQBFp/D3NoxmvLL0uMg5Pb4n1ZxKxBSxARZZg2OG
	ClZF6dSKhIJ7rUdMAfZgwx6iZH++F/r3xC4YpcCi6DDTV/V5OOu0uCR3N4zFsu0t
	uSyeKAome9bZf9o7JGMRTGMV659FYmzkIDWOqMFxmb8Za5hLygN4H0CeHbO/XKDr
	XisLeApFztIWyGB1lkFPn6QFe0eYrNBecXnKms3BaKBFUMd3+p0pvSJ0xDwx+BTx
	OCizhya2rgs9B5EtGYpJiSlPDmj5QO8cLz/BPeNcUJXHzU6m7gEd2jILiRgGpLfJ
	k5ioQjvyBN4x4rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dGVSU
	hAKABda7G8ygqy/SjraxGh07QmCWGUMWMWh4fw=; b=x8U6VuthDeebIgcZe0Z0X
	VwgcmAF42qGE702KR2s5W6944Aeqn7s7spM9/1MEvFp+lGjkopXqokrQQIWPZrsW
	15h3Qae2JjrmgZP5PRD3CR+xerM6EsRlXmo9t+3eSaNwHMcekHPcS9y7jL9BWVj0
	IDK9XbUGa/VXtC9lsHD2/SeSU/JXJ7RwYf6wxOpklx4CyvXgW/cEkSWoaduyFX+E
	lvZadr+EUb7xubdPurSYSaNZ+D6FsJV1nTpLlczKPH9eghVI91WL5chn8ZGwLk6O
	SVrkEWvw7TxVWA32h+4xR89XIlPQ/FNYcOPQ+tGSXanmaCGTHzLXm+s4guOnQnvn
	g==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j4df4yffs-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 06:26:18 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaSA8KPgRiWtfyDQ4QlVgEmo35ObC1+HU98qSqWrZicBE90VH0ogYxl3M74tq4kgITgUWlNjVM6TkH5jzoE/zlAJ1j6CBSMPUOJGDofTY09w+IyG21yVFzosHz/74D2rdHTaYrl+vts2j987I4WOZHAe9fRp6X58ev3KCGWRZmHeBliy760pMPqKttOAgfF+qLBaF9Sf34us5Ffc+pD9ewy2A9YXXcGHYim17N0/28u4tkDMCxAUBfVatyTwgpLWulqyQEfHe6cmZ94163SkIU5BlCGDk9KdUYYTrBaKwPjm5LIRkQbAjgELZZ/3n53GGTdtr50XN1oraqBQrjz//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGVSUhAKABda7G8ygqy/SjraxGh07QmCWGUMWMWh4fw=;
 b=SVaQleI1PPdHfYq8kLZ/u3IyNsuX0qy+TbQYFKqTD1KIh9B1jxD2JifdGBXuT0T3uvxrsFciCKLgEZ9+0NaeeepqkJVeln/cHsXrc1b0uSfFUKcmyigktSvWVKEz6cmiVUxyEJ/UAZO67/6Z3bqrwMcIhpDC+LP3MZP1UiRghUlnLXdSfNa1iB10r7QwfDdQwDtCbE3wfP6DmIW1lq1f13A/ZeJfLKsddPcNAQosNmdsHxMFvIlFZY0mELj3/7sRNZNJpRbZMdJiKxO7nOxM4JIHnBQuq1m0+rDM19Q+X/04g1IIKIJHJvuzDyKOTT9jeN7aKpg2ACYuFM2ziVTleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA6PR03MB7949.namprd03.prod.outlook.com (2603:10b6:806:430::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 11:26:15 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 11:26:14 +0000
Date: Tue, 24 Nov 2026 11:26:10 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Rupesh Majhi <zoone.rupert@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: core: Split debugfs routines
Message-ID: <awVz_NIDb01OZL3y@nsa>
References: <20261124094502.557175-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124094502.557175-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: MR1P264CA0180.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA6PR03MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: c55e5ad5-b9cc-4d7e-6f98-08df4a1dbff6
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|261102130727099003|261028144727099003|261021123027099003|11063799006|261021121427099003|261022075727099003|261026140227099003|261009223027099003|261022105027099003|261026121527099003|56012099006|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 RWDC57NB9tqw9mXqxOco6LswhvVjhEvNCKgWM+eFbgqmbHWzW1FKED1tdf/C/Drh8dfHfKaBlUp/BkCLEpqk8ZR1bdzQzVuu2I8N/nzK4lN7zO0fYvPyv7TWa4FZGi4Dghf+PP/EU9gm5uohtXzt9oCzj00zOCFFZXtlbhkmQohhWsPg/cP3SNVeak4YxNYBmTPO+qUFlcvH/+29WYSM9fySI2ykJB9r1MXrB3iRgR9EwEhc+l8tjMq2Tg4a/dQRq7FLp8bynxpDLNuJ6m4btaNDCdbDsUuEhP514fWgovC2+/Ta1LjMPsK/RFDdDz+k6AKF4v+TOSjIvg9v181CJYovzCosDyfz7n0bp0fFqbS8greoRfRP+2LuvwKI6LjO1/KFenetKLjNg98Hx2d1dVUhGe5VjyUHRc15//Bjco/rPuXNkmEDhNtHif9zASp7pdU4Z0Ydn62PaWQjPq1cvjnkXZMQuz+7RIRzgbo+b1qiGBDTm0BiEIbC1+rw2OrSINQchMw+4wEyDqAIPtzA9t8Mhu+dm/Fi2cyX8p/ZiP95MC6m+S2RlZyNg5b2AddUROBcmxNueg+efKuLpK9LNgnTRx5POoVyw7G1qxFdZn6QIGr0o1QjKIkjV/NQTiIkLaVUWBtJyr3Gwb6wDymJ0omei/HgqtoPsWifvAzCg+Y=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(261102130727099003)(261028144727099003)(261021123027099003)(11063799006)(261021121427099003)(261022075727099003)(261026140227099003)(261009223027099003)(261022105027099003)(261026121527099003)(56012099006)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RWVLQWUyaktjUUt5REo4d2NSbVRDekV1S1gzL1pXbjMzTEY0M0Q4cDluS1Vl?=
 =?utf-8?B?RG5mNWRjZ1ptM291bEcwR3QrSHFVaUFIR0NLQU1GdjFZdkFHdXh1QVhNNEgv?=
 =?utf-8?B?OFI2cEN0QkZZaCtQQ3pwYWxNZ1J4d2ZndlpxSGlwU3hGTzRVMnNiRURHaFJs?=
 =?utf-8?B?RkJkZ1M5eFNOMjVqQ2VzUzdSYmVpSHk4a0ExaWF5WnpYUTdvOXQzMkYrVlQr?=
 =?utf-8?B?ZHRvZGMzb21zeFZBYURkN2ZGdHRKc255R2hPTXg2YzA2ZWMwaHBmS0JGeURW?=
 =?utf-8?B?d3BNbGlGeDJmOTkxaHlPRmoxc0pFY3BTcUQvQW1XSFBqaFU0QXFVSVVtWnll?=
 =?utf-8?B?c1VOV0xhT21KSm1Ydjd1cm4xLzFTZVJNSW9GaVFhaG5NQ2NPOGVhMmxTb1Jl?=
 =?utf-8?B?N2lweWJQUTZsK0QyUCt0QzVNbnVoUWIvYitXV25EUHI1RFZWbXFGcWcrejY3?=
 =?utf-8?B?N2pEVGpYZ01Zb0NkTHV0YjhuaXBRS3BnRSt5amxvd0hsb0NmUzZVNjVURW8x?=
 =?utf-8?B?K0dIUUF2UFIvcVJKQ2x4aUVqaTVQNFVZYWt0N0FvNTJWQnZWMW1EUWNrNjdp?=
 =?utf-8?B?b0ZZMUc2OG1QTUltTnFDcTdNeEZralo5MkpQV0dZdEoyQjJrSWRGUHJWTmZq?=
 =?utf-8?B?UXNUeXZ2QWxyek93dnJ2THNROWdzb3NJWlgvcGd3N2FxWTRCcDJobzNZTGNZ?=
 =?utf-8?B?OEZFcXhIMzJIOUo2cHVLU0FEMmhLYUE3ZXUydENSWlZOdlcyS01XK2puc21s?=
 =?utf-8?B?aXZDRE5VMUtRbHBZaDhScXF5MTZML2ZkbFdsV0p3dVFJSjZUV1ZpalN1V0pG?=
 =?utf-8?B?OTJ2K2RQSzJJTXZGYiszT0wzak91YUhHb1p3a3VvQzA5WFJ3WEo4MERVSTE5?=
 =?utf-8?B?QUkwMWhQMkNERTUzK0U1SFZzbk1TamFIbWNRUzlJdEUzNGNTd21BeTIyNTlp?=
 =?utf-8?B?YzI4ZnZRa1BPODczYzZrSHQyNDd6TEt0bHNMOHFaVkpxWnVaNkt6dm9nTENR?=
 =?utf-8?B?MDJTVjlWVnkvUi9uWDNYMlpLb2Uva09PcUV2dEVhaFM1Rmd5cTE4MWJRVFVs?=
 =?utf-8?B?S0cwd0t3bHlPRmpqYmJWbFc2eTNXMHVrc0tKcjVOVTFxWC9wTVNYZ2U2Y08r?=
 =?utf-8?B?VkhyZ2hQTjZCbVk1dm9hMlZVdk1UdXJUMVdDYTQzSklUZ0g4WFd0VG5meFl5?=
 =?utf-8?B?WVJVeHQvTFhQWndWS2JEMjVkR0dURXpRVHU1VFhkekcwRjh2R3JaS2NTWVNU?=
 =?utf-8?B?QmkrUjRIbkZia3VzMTg5ZVF1ZWh2OXp1anMvQ2xRTWhrTUI5M2pSNVF6eFZX?=
 =?utf-8?B?QnRpN0Z3OWpTK1ZJb29Bdk9yODJWZTk1ZEw4K0ZOZERsSFdKZ21CVGdwNG9u?=
 =?utf-8?B?NzJ5MVl1dHJSeEVCMVFyVXZ1Q3dvWTE3S00za0pQWUF2a2dvdTBSRXpFc3dy?=
 =?utf-8?B?azN6TmFCbjFOY2dyU2I5eDBOTXBOV3doK1VzOFhtRVN6N1c2WWRoOTkzVDNO?=
 =?utf-8?B?UmpCMm5hZEJQb2xjVkhzbTdwRjhadk1rUlNQMXR2cFdhQnZGZXprYy81NGJH?=
 =?utf-8?B?ZHlMR2lrNnJGekhQWVl4TGdQTURNNFE2Kzd1blZLS3ZrczkxcGdLNytDcnlo?=
 =?utf-8?B?V3QzV1Y1dUJXd0I0STh3UHo3eEFaYmZyNXNEeGhyVWdnMTdFejlRcXhaeUFy?=
 =?utf-8?B?YktrY3FCVERaVmdaYWtyYUs2NWVsUnZjSkdOaWltYU16amlQYXplZVpuU0VQ?=
 =?utf-8?B?dGNQTHBrN0FPcjdwaE1SZXRUU2J6QmJ3RXFrcXpzS2RwbnZwN3JNQlBTTGda?=
 =?utf-8?B?aWRqcU5DaE9WaFZvSzlldVY0NUJRYkFWMkQ1a0lIWExmZ2NXZjRQRzJxbU5v?=
 =?utf-8?B?YlozZHZpK0FJdE83b3U1ZUJpMEtYaEE5bnVKQm9kLzVSVVZSdjVDTHBZMjVi?=
 =?utf-8?B?ZktRR29tM0NBczJKV0JlRlZHb2p5VG9CbUM0bzE1VEVKRVA5VjJCMStQS2gw?=
 =?utf-8?B?OXBEL015UWlHQ2pOOFdCcUp4eDB4MG41cHR5d1FKMG85UTRBeWN1M3RqREhO?=
 =?utf-8?B?Q09LaHFPZWMxY3RSYlllNlE0TGZPYWxoSmQ1ZjR0YUc2a0ZVSy9ZeEQvM0Q3?=
 =?utf-8?B?eUtPUmltUFZSQ1BVNzF6TERhVDlyVG8xRVR0dnM2N2lqMDZVY1d1VndoaUJs?=
 =?utf-8?B?SXFYcnlQNXpKQ0h3YmRMTUQ0R1p6eWIwUGpRYXhjUEE5NXh0TlpPRmFiVXhl?=
 =?utf-8?B?bnRpQnMwSllsVWFuRk5WbWNYTFltN1o5bVBuQ1hZKzFXRTVQTmllUGhrbU5N?=
 =?utf-8?B?UXhDOWE1V1NDZEI3Y29RQTFFNkthWjhkSEtqNW5iZXBoWXpQa2J0dz09?=
X-Exchange-RoutingPolicyChecked:
	FfkKisl5Pb3N2THYFBWD4rfPXCnIGtsCWhzmPcJWnH8bTRrMoSJ7tfMPjHiETw3xe2vzV90hBwDwcphoebiT7zRzf70Na+2pOHccvP9G+xc/9rP8Bn9DREXCZDF0oVc4j7yIfDs8QkQY7lExS3XlJ/PMjMwEiGQcFZVmRUgNtosmdANFj0JEgwcAkmtS3e/ZlO8LF2qRNovohGWHLnef1/ubZdVKG4ZArcr7Qo3jDj033RwWccjm403iPEZZaaa4mY8Yx4PNUxjD3nP7GEleZfeJyxKUqxjLksqxApvXe1rqjZQwtatmnNFW4jQW9smqOcS1UEbiUXBvg5C3Gbm2Pg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55e5ad5-b9cc-4d7e-6f98-08df4a1dbff6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:26:14.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyn0NEjkrXvLJ3tXNZ4D9bM+lsIuqCarPfF8D3s9wfqaWcVPfcnpeKyIOcbsarKfIqglmpdgp5kx+jjrvdsLrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7949
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX8+rbLvfllUxZ
 YCTCXoDeZrSxlNSQDUbCWpXertkdrYSZxsGL+nsqeXJHvVgfB8kTuf8AGMiWG+FQcGgvkehYypj
 Hr8ofofheRcEugZX+GXh+05wJ1PTDInTVH8j+KfTWuenCggZX7xM
X-Proofpoint-ORIG-GUID: EUqnDzmUdXbiRqvloXu_Tkoz5QN_mCXI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX1uZlWgJ2P04w
 NuA23DK8AutizCiPfumACwcoEJM8EMekbRSwJcM90tqBjhbXmJlk2JiGdASFSzf0eklSpZVAWbJ
 FbqfSMre2ex7FNp3oAy43GG7ctG+dtbcW5E/9KmNSuqPg9nMw1f3FuA9wuByjM5WalYgcumvSXl
 yLlt3NkyJTQ8t88Xac2ghePEwd5LQ6S7kmxHXMxVSnushHu9I3cJBMS5TuItNfakaHBUFCAgQGQ
 nqoZd73eRVll4kdSCC5F9RoP+gt/sRR283Jl1NvtezXLmrXFLOAPdoehp5FfDAXP5y35S8qE4qu
 D89wD5YY1a6+GVNokQmll1azMpX+E771Cqd5Gu2zEy/Tmw8Wzvk4z7k/VswKwG8vK35gw2tJco7
 jQ5a1ZUNe9yLufCCf+5oxpu/yyEcH/JBRnRLUgjM6cMXpjcqMxasDXJYhsWKls3VpqlDgyZNhtq
 XniqVkKRLIhHyVqQlaA==
X-Proofpoint-GUID: EUqnDzmUdXbiRqvloXu_Tkoz5QN_mCXI
X-Authority-Analysis: v=2.4 cv=YJIKWhGx c=1 sm=1 tr=0 ts=6b05745a cx=c_pps
 a=iUWcX4Zb67NrYBHNvjZ/UQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=FvSWL99rPpPUQIIn-FsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240044

On Tue, Nov 24, 2026 at 10:44:10AM +0100, Andy Shevchenko wrote:
> Split debugfs routines into a separate file for easier maintenance.
> No functional changes intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Looks good! With the compilation fix in v2:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> 
> Rupesh, feel free to include this patch into your series as the first one.
> 
> Fun fact: This patch was written with zero AI assistance.
> 
>  drivers/iio/Makefile               |   1 +
>  drivers/iio/iio_core.h             |  14 +++
>  drivers/iio/industrialio-core.c    | 152 +-------------------------
>  drivers/iio/industrialio-debugfs.c | 165 +++++++++++++++++++++++++++++
>  4 files changed, 182 insertions(+), 150 deletions(-)
>  create mode 100644 drivers/iio/industrialio-debugfs.c
> 
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 8a897b6729d2..5fd81b20da22 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -8,6 +8,7 @@ industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>  industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>  industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>  industrialio-$(CONFIG_ACPI) += industrialio-acpi.o
> +industrialio-$(CONFIG_DEBUG_FS) += industrialio-debugfs.o
>  
>  obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
>  obj-$(CONFIG_IIO_GTS_HELPER) += industrialio-gts-helper.o
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 59fa1bd9924b..985ac82a37f9 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -16,6 +16,20 @@ struct iio_buffer;
>  struct iio_chan_spec;
>  struct iio_dev;
>  
> +#if defined(CONFIG_DEBUG_FS)
> +void iio_debugfs_create(void);
> +void iio_debugfs_remove(void);
> +
> +void iio_device_unregister_debugfs(struct iio_dev *indio_dev);
> +void iio_device_register_debugfs(struct iio_dev *indio_dev);
> +#else
> +static inline void iio_debugfs_create(void) {}
> +static inline void iio_debugfs_remove(void) {}
> +
> +static void iio_device_register_debugfs(struct iio_dev *indio_dev) {}
> +static void iio_device_unregister_debugfs(struct iio_dev *indio_dev) {}
> +#endif /* CONFIG_DEBUG_FS */
> +
>  extern const struct device_type iio_device_type;
>  
>  struct iio_dev_buffer_pair {
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 792c2d28835b..3b66d7b765d5 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -14,7 +14,6 @@
>  #include <linux/anon_inodes.h>
>  #include <linux/cdev.h>
>  #include <linux/cleanup.h>
> -#include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> @@ -54,8 +53,6 @@ const struct bus_type iio_bus_type = {
>  };
>  EXPORT_SYMBOL(iio_bus_type);
>  
> -static struct dentry *iio_debugfs_dentry;
> -
>  static const char * const iio_direction[] = {
>  	[0] = "in",
>  	[1] = "out",
> @@ -293,20 +290,6 @@ bool iio_buffer_enabled(struct iio_dev *indio_dev)
>  }
>  EXPORT_SYMBOL_GPL(iio_buffer_enabled);
>  
> -#if defined(CONFIG_DEBUG_FS)
> -/*
> - * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
> - * iio_get_debugfs_dentry() to make it inline if CONFIG_DEBUG_FS is undefined
> - */
> -struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
> -{
> -	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> -
> -	return iio_dev_opaque->debugfs_dentry;
> -}
> -EXPORT_SYMBOL_GPL(iio_get_debugfs_dentry);
> -#endif
> -
>  /**
>   * iio_find_channel_from_si() - get channel from its scan index
>   * @indio_dev:		device
> @@ -427,7 +410,7 @@ static int __init iio_init(void)
>  		goto error_unregister_bus_type;
>  	}
>  
> -	iio_debugfs_dentry = debugfs_create_dir("iio", NULL);
> +	iio_debugfs_create();
>  
>  	return 0;
>  
> @@ -442,140 +425,9 @@ static void __exit iio_exit(void)
>  	if (iio_devt)
>  		unregister_chrdev_region(iio_devt, IIO_DEV_MAX);
>  	bus_unregister(&iio_bus_type);
> -	debugfs_remove(iio_debugfs_dentry);
> +	iio_debugfs_remove();
>  }
>  
> -#if defined(CONFIG_DEBUG_FS)
> -static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
> -			      size_t count, loff_t *ppos)
> -{
> -	struct iio_dev *indio_dev = file->private_data;
> -	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> -	unsigned int val = 0;
> -	u64 val64 = 0;
> -	int ret;
> -
> -	if (*ppos > 0)
> -		return simple_read_from_buffer(userbuf, count, ppos,
> -					       iio_dev_opaque->read_buf,
> -					       iio_dev_opaque->read_buf_len);
> -
> -	if (indio_dev->info->debugfs_reg64_access) {
> -		ret = indio_dev->info->debugfs_reg64_access(indio_dev,
> -							    iio_dev_opaque->cached_reg_addr,
> -							    0, &val64);
> -	} else {
> -		ret = indio_dev->info->debugfs_reg_access(indio_dev,
> -							  iio_dev_opaque->cached_reg_addr,
> -							  0, &val);
> -		val64 = val;
> -	}
> -
> -	if (ret) {
> -		dev_err(indio_dev->dev.parent, "%s: read failed\n", __func__);
> -		return ret;
> -	}
> -
> -	iio_dev_opaque->read_buf_len = snprintf(iio_dev_opaque->read_buf,
> -						sizeof(iio_dev_opaque->read_buf),
> -						"0x%llX\n", val64);
> -
> -	return simple_read_from_buffer(userbuf, count, ppos,
> -				       iio_dev_opaque->read_buf,
> -				       iio_dev_opaque->read_buf_len);
> -}
> -
> -static ssize_t iio_debugfs_write_reg(struct file *file,
> -		     const char __user *userbuf, size_t count, loff_t *ppos)
> -{
> -	struct iio_dev *indio_dev = file->private_data;
> -	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> -	unsigned int reg;
> -	char buf[80];
> -	u64 val64;
> -	int ret;
> -
> -	if (*ppos != 0 || count >= sizeof(buf))
> -		return -EINVAL;
> -
> -	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> -				     count);
> -	if (ret < 0)
> -		return ret;
> -
> -	buf[ret] = '\0';
> -
> -	ret = sscanf(buf, "%i %lli", &reg, &val64);
> -
> -	switch (ret) {
> -	case 1:
> -		iio_dev_opaque->cached_reg_addr = reg;
> -		break;
> -	case 2:
> -		iio_dev_opaque->cached_reg_addr = reg;
> -		if (indio_dev->info->debugfs_reg64_access)
> -			ret = indio_dev->info->debugfs_reg64_access(indio_dev, reg,
> -								    val64, NULL);
> -		else
> -			ret = indio_dev->info->debugfs_reg_access(indio_dev, reg,
> -								  val64, NULL);
> -		if (ret) {
> -			dev_err(indio_dev->dev.parent, "%s: write failed\n",
> -				__func__);
> -			return ret;
> -		}
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return count;
> -}
> -
> -static const struct file_operations iio_debugfs_reg_fops = {
> -	.open = simple_open,
> -	.read = iio_debugfs_read_reg,
> -	.write = iio_debugfs_write_reg,
> -};
> -
> -static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
> -{
> -	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> -
> -	debugfs_remove_recursive(iio_dev_opaque->debugfs_dentry);
> -}
> -
> -static void iio_device_register_debugfs(struct iio_dev *indio_dev)
> -{
> -	struct iio_dev_opaque *iio_dev_opaque;
> -
> -	if (!indio_dev->info->debugfs_reg_access &&
> -	    !indio_dev->info->debugfs_reg64_access)
> -		return;
> -
> -	if (!iio_debugfs_dentry)
> -		return;
> -
> -	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> -
> -	iio_dev_opaque->debugfs_dentry =
> -		debugfs_create_dir(dev_name(&indio_dev->dev),
> -				   iio_debugfs_dentry);
> -
> -	debugfs_create_file("direct_reg_access", 0644,
> -			    iio_dev_opaque->debugfs_dentry, indio_dev,
> -			    &iio_debugfs_reg_fops);
> -}
> -#else
> -static void iio_device_register_debugfs(struct iio_dev *indio_dev)
> -{
> -}
> -
> -static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
> -{
> -}
> -#endif /* CONFIG_DEBUG_FS */
> -
>  static ssize_t iio_read_channel_ext_info(struct device *dev,
>  				     struct device_attribute *attr,
>  				     char *buf)
> diff --git a/drivers/iio/industrialio-debugfs.c b/drivers/iio/industrialio-debugfs.c
> new file mode 100644
> index 000000000000..7ceeb88f9276
> --- /dev/null
> +++ b/drivers/iio/industrialio-debugfs.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Industrial I/O debugfs bits
> + */
> +
> +#include <linux/cdev.h>
> +#include <linux/debugfs.h>
> +#include <linux/dev_printk.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/sprintf.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/iio-opaque.h>
> +
> +#include "iio_core.h"
> +
> +static struct dentry *iio_debugfs_dentry;
> +
> +/*
> + * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
> + * iio_get_debugfs_dentry() to make it inline if CONFIG_DEBUG_FS is undefined
> + */
> +struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +
> +	return iio_dev_opaque->debugfs_dentry;
> +}
> +EXPORT_SYMBOL_GPL(iio_get_debugfs_dentry);
> +
> +void __init iio_debugfs_create(void)
> +{
> +	iio_debugfs_dentry = debugfs_create_dir("iio", NULL);
> +}
> +
> +void __exit iio_debugfs_remove(void)
> +{
> +	debugfs_remove(iio_debugfs_dentry);
> +}
> +
> +static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
> +			      size_t count, loff_t *ppos)
> +{
> +	struct iio_dev *indio_dev = file->private_data;
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	unsigned int val = 0;
> +	u64 val64 = 0;
> +	int ret;
> +
> +	if (*ppos > 0)
> +		return simple_read_from_buffer(userbuf, count, ppos,
> +					       iio_dev_opaque->read_buf,
> +					       iio_dev_opaque->read_buf_len);
> +
> +	if (indio_dev->info->debugfs_reg64_access) {
> +		ret = indio_dev->info->debugfs_reg64_access(indio_dev,
> +							    iio_dev_opaque->cached_reg_addr,
> +							    0, &val64);
> +	} else {
> +		ret = indio_dev->info->debugfs_reg_access(indio_dev,
> +							  iio_dev_opaque->cached_reg_addr,
> +							  0, &val);
> +		val64 = val;
> +	}
> +
> +	if (ret) {
> +		dev_err(indio_dev->dev.parent, "%s: read failed\n", __func__);
> +		return ret;
> +	}
> +
> +	iio_dev_opaque->read_buf_len = snprintf(iio_dev_opaque->read_buf,
> +						sizeof(iio_dev_opaque->read_buf),
> +						"0x%llX\n", val64);
> +
> +	return simple_read_from_buffer(userbuf, count, ppos,
> +				       iio_dev_opaque->read_buf,
> +				       iio_dev_opaque->read_buf_len);
> +}
> +
> +static ssize_t iio_debugfs_write_reg(struct file *file,
> +		     const char __user *userbuf, size_t count, loff_t *ppos)
> +{
> +	struct iio_dev *indio_dev = file->private_data;
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	unsigned int reg;
> +	char buf[80];
> +	u64 val64;
> +	int ret;
> +
> +	if (*ppos != 0 || count >= sizeof(buf))
> +		return -EINVAL;
> +
> +	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> +				     count);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf[ret] = '\0';
> +
> +	ret = sscanf(buf, "%i %lli", &reg, &val64);
> +
> +	switch (ret) {
> +	case 1:
> +		iio_dev_opaque->cached_reg_addr = reg;
> +		break;
> +	case 2:
> +		iio_dev_opaque->cached_reg_addr = reg;
> +		if (indio_dev->info->debugfs_reg64_access)
> +			ret = indio_dev->info->debugfs_reg64_access(indio_dev, reg,
> +								    val64, NULL);
> +		else
> +			ret = indio_dev->info->debugfs_reg_access(indio_dev, reg,
> +								  val64, NULL);
> +		if (ret) {
> +			dev_err(indio_dev->dev.parent, "%s: write failed\n",
> +				__func__);
> +			return ret;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +
> +static const struct file_operations iio_debugfs_reg_fops = {
> +	.open = simple_open,
> +	.read = iio_debugfs_read_reg,
> +	.write = iio_debugfs_write_reg,
> +};
> +
> +static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +
> +	debugfs_remove_recursive(iio_dev_opaque->debugfs_dentry);
> +}
> +
> +static void iio_device_register_debugfs(struct iio_dev *indio_dev)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque;
> +
> +	if (!indio_dev->info->debugfs_reg_access &&
> +	    !indio_dev->info->debugfs_reg64_access)
> +		return;
> +
> +	if (!iio_debugfs_dentry)
> +		return;
> +
> +	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +
> +	iio_dev_opaque->debugfs_dentry =
> +		debugfs_create_dir(dev_name(&indio_dev->dev),
> +				   iio_debugfs_dentry);
> +
> +	debugfs_create_file("direct_reg_access", 0644,
> +			    iio_dev_opaque->debugfs_dentry, indio_dev,
> +			    &iio_debugfs_reg_fops);
> +}
> -- 
> 2.50.1
> 
