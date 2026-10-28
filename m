Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793181635;
	b=E1ySSKcgBkgN0AQzFRucZGUFUM7hhI9wgF2qPZ1Kf1Bk6i2Ewdz8ElhoLBwz1oaoTkWR
	 eGb8Nsh5bkt0PO2V1VPmEn2Bg2iwXLxRJZ4sS9L5Xm1+GrHOMg7hxLUkPBRW9jygabtl0
	 QaFFrcvtFhfhdicQsF4Tkn4NsTtzXk85WRBhGirDJpBpRfp0gQd+g+t7TnlvcAoyuE0kO
	 odMS77HCnjeJ67fYBtNWvTTPMd3GjFHeKd8mZ3I6NJJ/R54ukKXRiG34J51mMyzqbtn36
	 x5k1+nGDXejv6ESn4/f71p7rwDjKqxD4Qj9NvuOx7TouvOXVkAcpf1et2lr2PLBLx4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181635;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7bLpmk9LXC5f1cp1/ehFIGYtwoBwAXzja3y/AAT+S2s=;
	b=0jNks0JcLhVfEvhNTQpkt8H/7+dmwzMnnZOCYIKnvnw07G/L03SeEyqXBXstks5+VYg8
	 nZ8740qpTyPlm215gZtTdM2ABzi47fJeqmR/AQVV2NE2Kfzy76w4BHlkydgQRNYLOPhmJ
	 fXCgahvP5rkJ9Ktgabhdi4ACVQt1TsRw6DmhRE8Q1MTtH5NuCdUfSuku7e7aiZWHN/pdp
	 1HciA+IuQAVxpiYWrFYNM7mtyU1+ME0GNj3tJDxl3rJDZle0EWGoOkzNtCy7L2rhZzwR6
	 iFM/PxizxEWJInq9H5rKh2l8nJC5bDuocVR5g1SoIROqK+tr/FmPnyx8oyiUMc/2E6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=LiqOlx4x;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=oYViWgkA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E4606A31C;
	Wed, 28 Oct 2026 10:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE5E4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=LiqOlx4x;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=oYViWgkA
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8Gah61445718;
	Wed, 28 Oct 2026 06:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=7bLpmk9LXC5f1cp1/ehFIGYtwoBwAXzja3y/AAT+S2s=; b=LiqOlx4
	xmxSpV/Pv9n4IEYashoMHA//KiJyNjvgB/iO4pUs5PAoZfHEwX/VrRbn6Wh2cpqp
	PKQXlUQhsv6huvVM17ycQaD3HZRv/6YfnvNQK8i4TTDO6+4ttOA5jHYjmJFRMPOm
	WIBSXxFu8g5SbDHwE4okVudZ7BV6WokjsDJU15az2Gg/3hAB2hlYIBbB+99GHDN2
	wkfKAzguMusBknylpRDDEkFIoZk/iMsuR8NKct+4ggNIkdNozSLXeF6KbaAgJOaX
	MA9XKTWZZpYQh3hboV1tKA3s3FNgtVQ3QV5Z7SkvGA1wAI2PHJ4TzfvFf7epr6oj
	oWjgbL0yh3PpSeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7bLpm
	k9LXC5f1cp1/ehFIGYtwoBwAXzja3y/AAT+S2s=; b=oYViWgkAyBNmJqpq2XYVA
	Mr1phu0T2O/ZJGN7AhEaEidJ5TS7NNF1ukHmK725+io0VuCUikhLm7V1WVec1Lc3
	C9mUV+AWO+qO9WstFTGAITdDN6SxCxUGRWshd0PqQO+cXfC7OMe8f1OaC2xVnatD
	g+zDfpQaYUXKI41aVbXUt4D9juMLj5C8oj4GFEu6+xnY6vQUVhM+m57agkgYztod
	zfl9Wj5cGsL0Lum7Oar6UkRuKR9bKGIvo4AqE2JZ8Dyr4XItuJ1G2XR22q17FoNb
	Caj0UgZdfUhta0AnznF/wX6O1rwcE8yYlGZ1m36h+KDTVYKREk+97qkEJH+KxzBO
	A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hk7k5t4rx-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 06:00:29 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVcAYgoat1eKjt3KA9MNDBzBYK6OCQNa5l/sTvggyH34tcT9VKh+DKhrcj6LGOPRJuP2ILPcAuTYDtbHQZ3gArQmwBAMw2Ja7w6sxoBrAJoTGVxi1NcxwTb6ZaotNs2kqF9ayyMz2ZW9A/19slSZfH3ouMrP1nz8+KMoe3LxvduNGBgqBSxu8jsRdgqk+xY8yLWyPBTzqXCORYuVEA9qG4wqRAD4qVHeWHoC3g9Y1I2rcEfay4Fas6XszjQr8iXvA2M/OWgEPCSRuJsbIIUB4BVmDFyER75N/xPo7LSlhMKQpXDeUXXw4ELluj9wMosxu3Ze+Anx0MtKCgUVfS/Ppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bLpmk9LXC5f1cp1/ehFIGYtwoBwAXzja3y/AAT+S2s=;
 b=kAe4r/+DL7J0i+akl7S32icEfHDvAP/T46lLOwJ6zdAQqXkuVtYbBu7hrREtP1VBvmPeit+V07CytVtUQfmCo6Mv8/uOm6LpsyhfaO+neS+saYPLTRZDJVfoQyeDpoJ/F9adHXLCr5G45vTNIz9gUKbkI300oWF4RmCaWQ/Wxutggg4FpOs1VbyfL8fjYIjYBlV8ZDrai0txVHoUwJY31HBI6ESaTLQg6x+C4dXwJkUwJ7u1dX18RNk20tTeIhlAL2u8Eflx+GgNzSNpwmhkMSNIe+cvHor1a43SBrw9hfyPU90BfvBTg5ZpBrkvyl4N/PpJhGE9H/kloYEiMoNd/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH2PR03MB5238.namprd03.prod.outlook.com (2603:10b6:610:a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 10:00:24 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 10:00:23 +0000
Date: Wed, 28 Oct 2026 10:01:47 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@kernel.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>
Subject: Re: [PATCH 03/15] iio: accel: adxl367: don't stay in standby on
 -EINVAL
Message-ID: <auHHf3JSYXE7IthG@nsa>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
 <20261027-llm-char-misc-iio-v1-3-0d818334f6c7@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261027-llm-char-misc-iio-v1-3-0d818334f6c7@linuxfoundation.org>
X-ClientProxiedBy: MA3P292CA0065.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::15) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH2PR03MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: db4d9413-4605-4b78-3f9c-08df34da48ac
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261009223027099003|261022105027099003|56012099006|261021121427099003|261021123027099003|261022075727099003|10067099003|261026121527099003|22082099003|18002099003|11063799006|4143699003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
 D1Nk+9jKyMq/gEgXbLNBVQ4hyYGgQ9xM9yc5qcHlR4OTAKFaDJHOiMVT6ByhI8T/xT+/idZQaKNSTNBe59no24brFWnmKyyUYKijRvChU8yr1/eTq9whnasn7o9nwRdAVfx2BIWcJabzeH9JGtbiFzdH2mSw8u2Rk5fpWP1NnIJ3+ltuVYAoF7yn1bhMy+efOtLEVLj2GKtG5G1SDS3CMjN0Q76PnxfN23VpDV0puYvSvKe3oEaeyqvVJsBqM8yKj4PBIdnMOAJ2xEBUU3IVWcDlXLZH0BwiDWqEFQOjUIjk2J4spgyUgwR24DLLK77ConmGJ2yiXDqrRh2Tmjfc3WmluPY5Titg4ThqlNCzc3iAKGMBSfDKb+xma4+QokHfiyBasTaPLmNg/4OuZ347FH4BRd44ynu9zF61VJr75sFL8etfG6vWUbFxi+tAL4FqmgYMBzUFlsGTCneM+9KMWbnNQC+QkvNU9qlQxTQ4kHy30rKmDMu+6cnK/T0VldlPf4P9aaIWhfBC9MAfP8hQpUSHam+9DrHh9Tmb2pse9gW0vM0du+KkmT3hGrhOw1CVCCDXXA+rk1cmnCnlrP+3rnEumWwRJLO60mXFczra3HuiQe9R8Ryj0BMKGuqrK23JrGgLg6DSLyM0NCCqVgXH1uQqbrNS4ZOVLiEN0iVM9LU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261009223027099003)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(261026121527099003)(22082099003)(18002099003)(11063799006)(4143699003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QXZ6MXM3aUdPcWRHL1BxNG1OZXFQa2VVOVZnZmV4cHpjWXZCS05hcTZHd1VO?=
 =?utf-8?B?Y1hmTTN4Mno0MHpjL2VFalpTdlRTYlk2dFpEUlZBZ0pwMkdpRWhyL04yL29L?=
 =?utf-8?B?N0dHM21EVlpBWDdDVXJqay9PRWFLWWtpQ2Nyd2dBVVFDZjkwOStVengrSHls?=
 =?utf-8?B?TUJSTjcrWndDd2ZoRFlVZVk4bWd1MU5sd1hVU3dqd20xbGZHamh6Z2NBV01T?=
 =?utf-8?B?L2d4a0VGZmk1RkdlNnhiWEtRR1FkVzdzL2JvV2Z5V0g4QU03a2FzbFdNejlv?=
 =?utf-8?B?cmgwNEpDR0FZOCt5MWpmbGREN0RuaWFwYVhlWTN5d0hNVUhTZDRYTCtmSW9O?=
 =?utf-8?B?RzFhSUowc1A5VDZndTJBdktPWmVzU0Y3QnRFTXpuZHBRZ1FPMHc0V0FIKzc5?=
 =?utf-8?B?cWdIMnpqNzZNVTV2Z3FzbC9EZzNRVWw2ZHpsYkJzSWczeUNWczlac293TXpi?=
 =?utf-8?B?YUpGZmpTYkxDR3RhekkxS3paRjdxU0VTdThxL2g1T2s4aTVOMUJySkRCdlkr?=
 =?utf-8?B?NHBWY08rbWFtb0Z4QkxFTXR5YTlkMnF5OHdHWTFjVGxKNjZnQ0JLTUZOazNm?=
 =?utf-8?B?d1o1OTk4UWxuYUVQSDRPQzFlUWhMbEpYUTc4UVlFU3NYNnZzTElMQ29lN29P?=
 =?utf-8?B?OEZGMUZnMEhRQURRaFVjSVhMRStxc1hZa2tRb003MEhDWVlpYVNwNEJEZWtk?=
 =?utf-8?B?OTFJNHRNZUZlaWF2bFlFcVg5dCs4bzc3Sm1NZTkxdU9BVk90aXk5cGEwUDAv?=
 =?utf-8?B?bldxNFBIQmFpKzZRbHFZaUcwTUNUY3dGTjdIRnAzTHVacWFyNEl4V0JYSGZ0?=
 =?utf-8?B?T0hsOGVjRlhNSnpycHVReVZkWXZ1eGc5ZmVBM25INTJadGlldGZPMUhNUUZU?=
 =?utf-8?B?Tll2cElTS01ZemFnWlJZTE02SGtueGM3VVk4dm1sK0M5YkxUWUVRQ0gxTUkw?=
 =?utf-8?B?dFp3WmxMM2ljVXZ0aUIwdzNDOE45Umdjb0FsS05idThTL3JiamFnUHZWQi9C?=
 =?utf-8?B?TGNyLzdBVzFiTkFTL1lIZW1hRmh5UEl4eG1paFZRejZQckJ6SSszakpzTWZu?=
 =?utf-8?B?TzZCRzYvVTVDK3cwMllpdHowUVRTWFk5VHlSNytJSEFGWHcxNVRFTVJuRnJW?=
 =?utf-8?B?R2J0a2o3dVgrN0xLNmw2d1lLYXJlM1lUb2dVYlNhNzdwN0p2SXp1cnFLQ0Jm?=
 =?utf-8?B?a0x0RmY5K1NaS3Z0SjNZa0FRSUhGN1RhUmgydjFPbHVGNWMyOUNFbjFvU0ZQ?=
 =?utf-8?B?UWQ0WVF4bFdyQU5HYlBIbGdnREJ4UW9rbVJTd3NnRlUzY3BrV0NkeGNqNksy?=
 =?utf-8?B?Mk1ZakJqenRBZlE2S2R0WHhtS3hkejRubFJ3clhvYnR4L1M0WkNyM0VXdGNj?=
 =?utf-8?B?TEh1WUdwUG5Bd2FQZTVHSng5Z2YrYlcwdnFOdGZHZkVMRWk3UkhtVkNoTEVl?=
 =?utf-8?B?bkUzOXcxd1lJQ3Q0WFhhTm5lQUhIYTZNcEYyM2JWSURrNVJXTDlkYkY3Nkcr?=
 =?utf-8?B?dTN4V1BpQmUyY1N5Y2phMmxpVWpzMGZUbmdCVzFSRTAzZG52TjFzenBpWm9o?=
 =?utf-8?B?RER6ZWl4OUI2bnV5Z3U3QzQ3eUFKMHRwZjhYa0pCTzhpN000bFk3WjVQT1R1?=
 =?utf-8?B?TmtoTzU5RVE0cVZqSVF0cXA2a0VWKzNXTzdyRTJTSmE0b3JTc0dtQk92cXZQ?=
 =?utf-8?B?NVhORjNvZmJKc1hKci9qUGdPQVVaanRCUmZjdlQ5ZlB0MkZ3cEphalMxOGdX?=
 =?utf-8?B?SGdnTm1kdDhsQldzR0VkMzZOcVRwSXBlTXVXaEhnZmduRVh3b1M2QUxzRmJL?=
 =?utf-8?B?S2VPYURxdVdUR0dyRytXVUxUR2Rwc0h1SGd3TVFUZmkzN2pDMUFKdW93Skhw?=
 =?utf-8?B?SUloQWJGdW5DUDZtWmV6MU42VGo0U2Y0VmxCcE1Fek5SMUtOeUhWZEx0dFlQ?=
 =?utf-8?B?U2JhZUtsOERTK0hRRDBmQkJOOG5BS2pkN0FXcU1ZSmdVc1dFa1czc2lzR2k0?=
 =?utf-8?B?K0Y0U2VhU2xIOUUwby9TQnI4UWttMy9SK3QzcForckwrUDBxMmJkSHBuWW9p?=
 =?utf-8?B?ZnpHNHhzMXM4cTBPU3o1RUZjbysvckw3ODBlcHZNS25YdVB4Vit1dEtjWTZ2?=
 =?utf-8?B?YUo2MDZEcHBQbWZkYkJ4ZVJVcU9wbGhVZmtrc3RpbEY3M0E3WFAxVHZkU0p2?=
 =?utf-8?B?enVUdHFyV3hHU01qYUlYOWJtV1Yybnc1WStvMTg2QWU4OU5IMW9RTDhUQUpL?=
 =?utf-8?B?OEVveUhJN0ZyaGxmNFVJSU9ZVktpbm1TeWJoRmN5dkEweDgvZjFMYnNJN3RJ?=
 =?utf-8?B?L05NSEx4UGJ1c2pVdi80T2c3VnVyQThTUktFeURNcVh1Q2lLZVpKQT09?=
X-Exchange-RoutingPolicyChecked:
	LwGmI9DhyDi7nABNfYBp6xYZqmTRQY3k8up3hHAyQJCsVtEk6MC32C8MDaorTIJ7wDCSybyAlOL8gknPlPEa57A/H9cUAm3SPuDXSbGGyrXliqO97OICvHK4bgBlmEeqaLMlGBbjbFmA3KtPB8LgU/frJf57h8VrS7f9Ve6CUortIfMIRQ4qXH6EaBd7FwPJwoGJd17bCgm6Yha8gpZzjUhdF3C3NzVruREoIH8l12nP910W9mk8ctwdbIoC4Bgpt82cN541kQkf4fk7XCIzXD/8uKj8WZWTc2pMC/Oqlt0Xi4OkHITHA+lTZwSDRFLq4HVbIvygwxxdbnKR2fkRgQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4d9413-4605-4b78-3f9c-08df34da48ac
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 10:00:23.8395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gYF+4Rl8nleWH5u2KJbMbBQgVPvWpaqhQ4hHIrjXeWKf57fTDqUHDbMsL2hsn0qdefietXENYoLC1G5oyNFag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5238
X-Proofpoint-ORIG-GUID: FeWJ0tqq9FaYype7q6hMJ0Z6djP2hh6Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzOSBTYWx0ZWRfX3PtsmJqP35rs
 3/uaUuBbuoq7Xlnyffn/FLNQFAO1iJ2kNoqkrNKfxKb5DNQXjZft/dCD3/pM6dlwVph0+YhjgUc
 pKW0mDwYf5+gQEr9PNsE6nGk+O1OFd/pzQIyQFaA6UpY7ptNFtpz
X-Authority-Analysis: v=2.4 cv=Fo2QbGrq c=1 sm=1 tr=0 ts=6ae1c7bd cx=c_pps
 a=kRgXGWC4h8N5Zk8PQP6WEw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=maIFttP_AAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=KkroM88zE2H5AGfQOXoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=qR24C9TJY6iBuJVj_x8Y:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: FeWJ0tqq9FaYype7q6hMJ0Z6djP2hh6Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzOSBTYWx0ZWRfX5wVf/Z4i7ubB
 oh0MIlkDC2lvM3tUjXcCZP4uILqvfZ+F9PlGQCbDXz9Afoxf2/5A0938dgzskEXpYN9HKZtMAei
 549d8Bz44EgbDztIul5HQY+0W4MK61xLQOIWoewN1RqP4qlwiSBIYr01y1pvHKePEqE43AR+EcP
 rrUhyY6uN4/ns/6JQfM6YiuIoIKC/0OAsxFpU/5dJJCcizLIqOSMeNutVQ8NuppUWmUnApULDgr
 LVRU2H5r+QfJeZKufgod/+v/nRW0Pd2X50bJTGOUeZQCI8q2rFnfWBY33d49G8/wpXeJu7q4UsQ
 MmREfWNbC7U1Jbk7z8srYzZ4ZC6gaMdrwpU9OltjtWklDHpGCLdTR/tyYEFsTsat+wZTrUduJjE
 9aXe46/y82tMuqs392b0YN2Auki2h9XLemGsaUbDJLYTK3StnTFWr1In5UGGz0baP4ejmEwaE3c
 k5uVKp6wUcqlLyN7OxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280039

On Tue, Oct 27, 2026 at 05:19:07PM +0100, Greg Kroah-Hartman wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> adxl367_set_act_threshold() puts the sensor into standby, writes the
> threshold and switches the measurement on again.  A threshold above 8191 is
> refused in between, and the sensor stays in standby: no samples and no
> events until the next write that succeeds.
> 
> adxl367_set_range() has the same problem and a worse one.  It rescales both
> thresholds for the new range, times four from 8 g to 2 g.  If one no longer
> fits it returns -EINVAL with the sensor in standby, the new range in the
> chip, the old one in st->range and rescaled thresholds in the driver's
> state: from the next successful write on the samples are reported with the
> wrong scale.
> 
> Switch the measurement on again if the threshold is refused.  In
> adxl367_set_range() see whether the thresholds fit before anything is
> changed.
> 
> Fixes: cbab791c5e2a ("iio: accel: add ADXL367 driver")
> Cc: stable <stable@kernel.org>
> Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Cosmin Tanislav <demonsingur@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Why don't we use mul_frac() as in the next patch? Also don't love the
condition duplication (feels like some refactor would be worth it). But
for backporting purposes, seems reasonable like. With mul_frac()

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/accel/adxl367.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index 026db73057c5..ba6e7423978f 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -349,8 +349,11 @@ static int adxl367_set_act_threshold(struct adxl367_state *st,
>  		return ret;
>  
>  	ret = _adxl367_set_act_threshold(st, act, threshold);
> -	if (ret)
> +	if (ret) {
> +		/* Leave standby also if the value was refused */
> +		adxl367_set_measure_en(st, true);
>  		return ret;
> +	}
>  
>  	return adxl367_set_measure_en(st, true);
>  }
> @@ -483,6 +486,12 @@ static int adxl367_set_range(struct iio_dev *indio_dev,
>  
>  	guard(mutex)(&st->lock);
>  
> +	/* The thresholds are rescaled: see that they fit before any change */
> +	if (max(st->act_threshold, st->inact_threshold) *
> +	    adxl367_range_scale_factor_tbl[st->range] /
> +	    adxl367_range_scale_factor_tbl[range] > ADXL367_THRESH_MAX)
> +		return -EINVAL;
> +
>  	ret = adxl367_set_measure_en(st, false);
>  	if (ret)
>  		return ret;
> 
> -- 
> 2.56.0
> 
