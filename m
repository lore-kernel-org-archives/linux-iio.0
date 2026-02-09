Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023123.outbound.protection.outlook.com [40.107.159.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743171B4138;
	Mon,  9 Feb 2026 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770631296; cv=fail; b=ohJlC10VC4FlIgpA8S9xDYvTaBFfZuPiIF8cLg/jzhNBcF8lOwRQPdK1928p4LJmuaLzu8FlCAYPe4F1a1m+hDMP2v2/5gnqcnwfcQBEdOPFtniju/AlxFPQ2Pt16+WVNHfBiHkUMaDf3IaAhqmNgH07DTfKt/3nQ6zYTYYvvuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770631296; c=relaxed/simple;
	bh=3aIYSLGEocao1zZ2I+t1QJkwjmm/mMuZc/BJoeHZojw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RWqXuLtT36gEJAUtQKBDQ9YwcVVaxjTQ8v1d2fPPTl+/nPMaPIBKQAUOdMiaVTtwskv29Dc/2LVVRK9fWzp/dXDCdQJrRESG5X5AriVuuoQhtyqmiCyhCsPSAR5IBMyKq1wBZqz+kDDMkdEDAYEpLHpJh+MUTIU4n09k12pUzag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=Rb9Ywjqb; arc=fail smtp.client-ip=40.107.159.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="Rb9Ywjqb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMPS5K3MK3uXy4MT1gAJIedv8wA8VDYVbDc5vI2axaNWn/rrewnyi7pDmKM7HHP0MgLipaYhasmRoiOHno/KU4ZpZVYZmF+Dv3qgTVmv9LcW5aZ6Me3gp2PNa9iZoV0kxiMz1SgbfPG1X7AUkek4221kTbDSoSRKot0ilxs/hKRnmkbWrT6i94hh/RTKDAMTeV5Sbzwh+rtDXuSHpzFErOnRykxoGXGEuMBNvd9nY0g0KntelVq0AS8F2kzDSr0bOLAGVfbPl+e3StU0BhnlJYSt6t9j4xbNTDk6hIFQtBJjvXL2WDztnfVho8gCn4vMqjE3R8ePyHwRRCBbCsCU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jrld+9grZdncsA/QHrm5UM12QHeez3+lVcjKyhXejo=;
 b=hRX+lfYorkincdcGoCWewQ3QX4yXlOtn0cFFX1WNefq050KSEQSfocytc1Ok0rrmQJvCgvOXTF4QeEeyKsq6OqXy5+yULk1hhmHZbhCdidjJBUb3XnEgXOWALN88UhaiFZv8Vb07iheLofpv6tN7yjQwZrFSpdGVgV/VksQtbvfWHTaC95WCLybG3snuYRireDPaJxaBxLRsG9j68byAI9NFqgFAQ/7u32PIuosUtvXOcyy+iQsRC0wx1iJRQyIM3CJO91Cp+4r0pk9y1w7eDeQszxJlhZdYLjHA6QA2P9PEhbKmjwNrbCCYVBY1KipuB3XItZ0xBBk7hfUY8cE0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jrld+9grZdncsA/QHrm5UM12QHeez3+lVcjKyhXejo=;
 b=Rb9Ywjqb+Rwv/dz/8WkVs+3OY9OBzGpvdBvs4RRIQ0rVX0lEDyN6jNcua9Ux7ENsVG5WW7dvQv1nEJ/uMiAY0/nL2hrxPPlNPrMZuDI2fHINmG2uYEI8/usmKjtTmPwBQWzImuTEheKLXPF/ARD2yTYRNDNFXVKO+MINg7kwBKEF4bsm50lGT+mazhMVj7h5O7FSj892aUZv+KxN93ExSzQo7xL0XbOYk7zEV6GNQ3xKQeSgYnwB5xpKFHhh4oRkwNwN1CC9MZy2nZBF82mjwfxNw4iM3A4ZkqkptaOINkvkpOvEu07SwXC6ThFeDRyOY5+Uj5Uz6MTZ66lUMnk50w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DB9PR06MB8074.eurprd06.prod.outlook.com (2603:10a6:10:268::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 10:01:29 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 10:01:28 +0000
Message-ID: <c3f7ce0e-4661-4542-9ea0-168d28a483c8@vaisala.com>
Date: Mon, 9 Feb 2026 12:01:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] iio: adc: ad9467: check for backend capabilities
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
 <20260205-b4-ad9467-optional-backend-v6-5-7ca20c40c59a@vaisala.com>
 <aYTGkAf7Ue7goDnw@smile.fi.intel.com>
 <56254198-c45d-427b-bcfb-fa9c60f11e71@vaisala.com>
 <aYmdn4sHxxD1KK0k@smile.fi.intel.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <aYmdn4sHxxD1KK0k@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::11) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DB9PR06MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 2828b7a0-e3d4-43c1-3705-08de67c2317f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHZ2bnREWnovTEdGS3BOUDUrNld5bzVYYTRwRlVCc0pSVjBIMklRdHRDb283?=
 =?utf-8?B?UnhFVFpEMWdTVzFGejdjeTI3YWVuRDFTYVVsMys3aFlNTW9YcnV4d2NYYWoz?=
 =?utf-8?B?Nkc4M1YweVRWZWZWMkIxaE9SL1NDQmxTSWlicEd2RWdsVjk3MUtyTUJsTUR6?=
 =?utf-8?B?ZWNCOWYxTGNRVjYyenhndWxRQ05vOFpCZ1V3cHZGblVoSzZEZXJhYWowOFhZ?=
 =?utf-8?B?bHByZ2xmRDBRSDhBTkNLeFRpMjhWbmpJRXdXWGVac2l2UEg3TjhTMWcyU1Nt?=
 =?utf-8?B?bHhtRDh6dnVqVDZFRHc4cXVFZzJVeGE1cGpCS1lzcHkxTnp3WHVka3VKenp6?=
 =?utf-8?B?RlluRXZLMEE5YzNKdUdyUnZwNlloVDVZTnN6VE94WDJpdUlJb2NyNjV4ZGY5?=
 =?utf-8?B?ZGFrTzdvTWJodzRrS1A2bGNWZXYwR1FDa1F4RzBGSkgzSzM0c3IycWRhY25k?=
 =?utf-8?B?aWkvaTAybkREVWJjK0ZMbFUyY1JTVkxtZjQwYnlSL3dUQUdBUU02ZmlURXlC?=
 =?utf-8?B?SG9RdjlVQkxZUnRMM21GN0thOWJBRlovek0vZDNYNDdOcXV3bk53RW9nNU1X?=
 =?utf-8?B?TkdlNlRiUXFOSkprZFV3RVkrVmxjdE1VQkZkQktKMFlWdlh1YTg3RmZyWmZT?=
 =?utf-8?B?MU92VUVBSU9OSFh2YWRDK21ueEZYT2tNSkZIblFFdyttT0FWUHQzNUFsejBQ?=
 =?utf-8?B?RDFzT25GWHMwOEdMNkl0ZFlZby8yNnhXKytCWklBMjRhLzlNeU1QNnR5amhS?=
 =?utf-8?B?WExKMFU4OXYyVEQycC9Cakh2ZHliRy91bnFQaWlFVHBmYU9YbGpHSjNncDA0?=
 =?utf-8?B?VWpKNFdtRHc2Zm53N3pUOFFwNE02RTNhNWdIT0RMZXVOL2MxRlF2ZDlnWTNk?=
 =?utf-8?B?NXp2R2s3bEt6YXdhK2hVSDVCcnBLUUlka0RVRll5OWduazQ1aTd0d2RHRVFT?=
 =?utf-8?B?SmZ6dkoxeEZ1TTNBQ2FIOHVYR21YRGw0Y3l5aFBtTVVuRUFsZ2RSd1VjSTZx?=
 =?utf-8?B?ZnIwMEFRS2IzSTVSdUJiZElITVZsNjlWcDFhS3ZSWTFNanVCcWVaUGZFemJO?=
 =?utf-8?B?ajhvWUY0QVM5U0htaVZhbHZNZlg1R0lMdmp5WElHakJqU3dsdDZhUFdjeWh0?=
 =?utf-8?B?Q0ZqQ1UxT3U5MFV0djN5elFWSFY1K05XRHFiRjE0ZUplVnBpQXZ0b1pnL1Q2?=
 =?utf-8?B?L0FFZm5UY1dxblgyU1NZNmlIWDJGaDVtMWxXWDNISkJmZ1ZzRDJzcmtHVVBY?=
 =?utf-8?B?WnhpVVVSVnovcjFCcUpLZ3dyYkF4Rys2aE9yWlByNi8xVCtnZ200WTliZlFH?=
 =?utf-8?B?Z00veHViaUhQdEtYMnlRYUN2bzAwTHZGQnBtaEYrTzY4S1NNZ0ZKcXcwcS9K?=
 =?utf-8?B?OFAyVy92Q2s5OU45QmhBekZjZlVFa3B2Y2NIczV1WnMvQk1ncUFYSUJOSEpo?=
 =?utf-8?B?QTc4R2cwU3hZU3g2STVIeW8xMEZNYlJWREs0SXhJWGxMbTRJWmVYSGhySkZB?=
 =?utf-8?B?bEtWRDJlb2w0dWxoUDZ4akx4Y1YzWDdRTE9yeEJqSG1tYWFRUW1sUmd1R2Uw?=
 =?utf-8?B?S0w0SFJoaUlQa3pGRFl6TzNVbXZldUNvNmFNN2dzdVpsam1FWWVtOWYwdlZD?=
 =?utf-8?B?V1JENWEzbWhSc1ptN1J5OU02dnZvSlUrVFl3T3NDNTc4dTdFUFk3WWJWQVVZ?=
 =?utf-8?B?R3lXampXN2NUbFRqdkZWcStkSjBMOWFXSk9tNksweER2OE1QUWl6UG5NbHFS?=
 =?utf-8?B?RGNuMUF6ZE43Q3gzUHlRbjFiYnpzRnl6MW1YbXFsQWNJakwvVlFaTWxHQVYz?=
 =?utf-8?B?RzZmeEUzK281eFlrTzY0WFRoQW1Mc3pKMGJzWS9ISThta3dyTnExUmU3R3Bx?=
 =?utf-8?B?UVRyWUVsdUNNQ2dncFpreU8zcktzdFdBSHR0aTFQU05qSVErSWJ3QklnNURI?=
 =?utf-8?B?eDhvcjAxdTVsVVlmL3BpL0MvN1ZuRDZsek1VcHNnV0puMEtHZDlTQWlUa0VL?=
 =?utf-8?B?UFdlbVB1U1VUUS9qSGJTYzdlYnpRUWpaRjN1Q2twcVExQllvYm1kSDhsZ3oy?=
 =?utf-8?B?OFlGZGNsay9YaldYUDdPU29wV2xVWUtmbFRwZXh3d083b3FLbnZ4bFVTSmdC?=
 =?utf-8?Q?UDqE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnNuaWd6aEZzWFRweTZEN3gyNENuL2RwZ0V5UGM2Z0poV3VQa0JUaVU2dGdj?=
 =?utf-8?B?SnVwSitCRHdrbWV1Uks5U2Z6dXJweklKVGZCbVNEYi9seGR2YXJXSXdVL21z?=
 =?utf-8?B?KzVnOW1SdFYrYUpGVTdGMzhmbVhkTEhsa1pIUHVZZzN6ZGVMQ0YxSldKd21w?=
 =?utf-8?B?N1hsc2lqNjRKQWM4cjJvZVdZSUF6S21BWVE1d3lCNlljdkl4MXZSdWZDL2lN?=
 =?utf-8?B?OXFSaFpYL3ZFV2lSemlTU2s5VDFhTCt2VU00QlUySjU3VDZKWmlrbXFuam45?=
 =?utf-8?B?TlNhaEpaRGpPYWhrQnJoV0tMVFNXaTNlOS8zQUMvNkhnMnpVWFIrSDdJYVRI?=
 =?utf-8?B?Yi9KTm5qZnNUVU5YcnZYZlVENHVoeDNmcjJhejVWU2FNbUZoTDA1ZXJMWStV?=
 =?utf-8?B?K29lbk90dUVIY3VLQ05hZlhaTEt4dmxXQ0EzL3BjVE1EZVFKTUVIejBOMjBO?=
 =?utf-8?B?MU5tZE1pZHphdVZaQlFNTDF2MFl5VlBNalMvbjZXZVduWkF5S1N6Q3NYd3JZ?=
 =?utf-8?B?ekltZ2RQK2tFOWZSRUR0bkovdGQ2ODUxSVQ3NGgrRVJNaEJpYVIwODB1THdB?=
 =?utf-8?B?TXF0RmdrUnFKODNmMUhIRzNlODV4Vm14RElZVGpReDdscEV5OXRRWktOeE9X?=
 =?utf-8?B?N1VzSEVoMUl1OUxsZUdXNGtXb2lYYTBWZVE1d0lyOU9ZTFVuRllGVXplWDJt?=
 =?utf-8?B?a0NTY1NNZWplemdYMUdiOVQ1V0VUbHhGbGRrTDFUMjF0TVI2c0VIZmJXUnhn?=
 =?utf-8?B?dnNNMFloMTYrKzhqaWpJck5UZlZHTVFBdGJMeGpheHdkSFlPcmFBam1obmRK?=
 =?utf-8?B?N3BaSDE3ZnJURkREZk9rcXEvRWNjWk9wZ0R2Q3pCM2pyN3V1WmdPem45S3Vt?=
 =?utf-8?B?cGdLVndkS3k4dnJYaGtORjYxU29MeXpZeDk4dzZNMTB6NjVIdGZCSXdFZXBB?=
 =?utf-8?B?TG9GYkVCK1lrUW9xelgrS1NjUDl1M0QwaDkzRHlWSHFaNDNkY0g5RjJFZ1Js?=
 =?utf-8?B?N2phcmZVQ3RzWmhJT2VTTGlpUXpyUHhtbFE5WVlQYzRUZXUxT3RZR0toQXJR?=
 =?utf-8?B?QllyYnE5OUdTMzFCbEkyOHlUQW9JQ3QyMEZIWC9VWnA5ZUdnZzkzTDVGQ25j?=
 =?utf-8?B?QTkyZElZR1ZPcXh2MUt0cWJQengvd0VTQVFYQ0tjR2RmdTZZellOeTY4dzFW?=
 =?utf-8?B?L1VqNnZQYkQrL0l1eTBxcVU0VTlxS3lBUURlMFlOTWd1SXp6amNDTUJpdm1R?=
 =?utf-8?B?L1MxN0k0bWpXdTJLSUphYjBkMG5mNE40b0dRbTVhbXhHaEFEdWFWQWJkbkgr?=
 =?utf-8?B?UGJMeU1mRnd2aXhkbDF4Y1grNzJUMVVMUU0rOE9DUHRodVdBeFhPZjhYZER0?=
 =?utf-8?B?TlFSNXVJUXo1ME54UStpK0lzUlUvQXl4UjNnTmM5NVJ2aldmaC83OEtnd2FX?=
 =?utf-8?B?QUQyU0ZETkpmcUxiTGh5WHNGeVZOUzIxNFFkZHU5S0lIM0U2dDdWMnRKaU42?=
 =?utf-8?B?MGtFZThFYlM3TXFjS0krbTFOU1grSHk4dmlkbnVDY0swSW1pUFBtSTU3L2lR?=
 =?utf-8?B?N1BVajZXbm95TmF2RUZBY0UraFhpNnphbVhmUXgvL1lCZFcyditwcUNtWW41?=
 =?utf-8?B?bEJKV1ZhdFVDTmRHZnR0VkpzcFhSTVlnb1RlbFFMckZVZmc1b3VBVzlpYWJv?=
 =?utf-8?B?bFFXVUgzOFkvRWdGQ2o3RExQZXZDYlg4VkFsOVdMRnlpUk9uMDZEMHNiTDRw?=
 =?utf-8?B?YTI0UFNlb1hlYUF2NnRpeXkwa0tNcEtONVVuNWEvVEl3dzFWbVQ0dFI4WHNE?=
 =?utf-8?B?aERpUlhsTTRjSmlCbWVDQ3ZLdU1TR1hVUVg2VEVDVU5SMzRaMjF4V2FYOEl5?=
 =?utf-8?B?VHlOY25Vb1hXSXQ2bng5cnZKbWlkMWFRRnNoS0pvYzA0anJ6ZkVtTytrbllp?=
 =?utf-8?B?MmxWczM5cUFwb3dpVGU1Z1V1bEdZR0xyd1g2dEVBaVE4M0lCUFZubjhwSE55?=
 =?utf-8?B?ajBHRmlSU2x0VTRpWUIzTXVXWkJzMm04cFVPN1dYQUJzZW80QWIzeENXUzUr?=
 =?utf-8?B?MGVsWHpSQWhSMFJsQnM3KytEVGhaSEUzRmNVVmlpWSs4Nmd5YTk1dWllV20z?=
 =?utf-8?B?Zzl4UmlWWGhLbzFLR3N0YVVCVnF5SHdoU3BxYlJxNnRIOHVkcTdVcVBOSEps?=
 =?utf-8?B?WEhWZWIzOXUyWWZnN0NRTW5GcVFBNGNIdFdSRll3c20wOVp6M1QwMTk1TWN6?=
 =?utf-8?B?eFFUK0xJZUFSbUJoeWo4YkROd2xQM0xWa0ZiNS9mbUZ6U1cxck1vUU5UNW1E?=
 =?utf-8?B?M2s5d09TWXdsQllyaU5QTE9OUGY1YTRUZjkwSG9nUW9wNTZSNEF3VVNWWjFF?=
 =?utf-8?Q?Q+OV3FEhaxLHwyIc=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2828b7a0-e3d4-43c1-3705-08de67c2317f
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 10:01:28.7090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qw1avRn1+5YaxIlLNKGbmTIVppE4WG/PklUqVtmYFRFNPjLeYa867kqZIBO781X+P7V9fhGqW2rE1MCKlxi0Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB8074



On 09/02/2026 10:41, Andy Shevchenko wrote:
> On Mon, Feb 09, 2026 at 09:24:09AM +0200, Tomas Melin wrote:
>> On 05/02/2026 18:34, Andy Shevchenko wrote:
>>> On Thu, Feb 05, 2026 at 12:24:11PM +0000, Tomas Melin wrote:
> 
> ...
> 
>>>> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_BUFFER)) {
>>>> +		ret = devm_iio_backend_request_buffer(&spi->dev, st->back,
>>>> +						      indio_dev);
>>>
>>> With
>>>
>>> 	struct device *dev = &spi->dev;
>>>
>>> at the top, this one becomes exactly a 80 character line.
>>> And in general it will help cleaning up the rest afterwards.
>>
>> Given it seems it would still be 81 characters long I would like to
>> leave this change as it also creates a bit of noise.
> 
> 		ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> 
> We have different arithmetics for sure, I have it 80.

Indeed this seems to be the case, different editors count this
differently :D

-T



> 
> "There are *two* problems in programming: naming, cache invalidation,
>  and off-by-one error."
> 
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}
> 

