Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020079.outbound.protection.outlook.com [52.101.69.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540CE2853EE;
	Tue,  3 Feb 2026 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770115560; cv=fail; b=s7GK9UpnKdV3qcSyU61CO5Lp6V8F2XzLM3VGeW3eD+sT+HaugJivMxz77waZ4bbEWd0lAMS+fcXVVqdbQ4AxdIc7pSAeDnYqP3t9yKX6FWp8NQ8U/aR/G5D5t2cTp6EgBnGHzlm+fCj6O/jiONbZXOqwRiz/WI7KJGGtp/VizTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770115560; c=relaxed/simple;
	bh=5sylPWvXHyCNSqCG5WdUJqd17ChvT1Amu4grILTtHAU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hgUExNME57Ew5McRjmEbbe5uMswEQuCIVQqXc58TOnOyVzL/N15r3Yieto3EicadLb81gatHRHLMiMRcjf8GptSS41JPa7cMcbnRjbkqg4eow9K5F/upNA1me+qOW4DB3OnPWVD6GjuEU/LbZErhizHVSkqFYZZwC3XFcIukFB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=WpsRv2or; arc=fail smtp.client-ip=52.101.69.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="WpsRv2or"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apg4xqFxFgToePPTsp9NuYqiwf5+Zjp5n9zkEl2T8ugemK9gHsOWxLB1W2ZeZdGqilthT6PBW7earDZUYd7rhqRJQGO6jiSilCTN5Kp4WPH37J+PZ8HG9I+bKQL7OuedAcOpz2HI7A3WVEIfBsBqNUAO5M9CotEC9sevBc8BXHjuK1W0FVFgzZ/jBwSaYPPpgSXTqU+bqu6ZfjnmEWMiw12ANT/T2ZfAJOWURkoAxFJajNc/vXWl3r7zYjAVW2Cocn+an4QSDdvEDosxuPe8j3u0dIhOHT0u5svkkWJVIeD1FxL5vt6hKWBW5tbLEEEkI0AjYpJXtrihD4G/H3fUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSHs0z+rsNLGm9z6rAZxVSp3GrQV8a8JLsHF6qwYH6g=;
 b=VyHLhWzZqcYdmuqvf2KKIl6kweLS83c+yB6k9FDzQjsvEKwFIpNTRfSn8da3vLHh/PYDZhBDlUckLEEaPMhJBuBodX88OxXHW44tGktmKCJWVV1iwFIdjYsF42V9vBqaySZLEKksKH/o91Y0zUv3KwgO5XpV4HtlhOUTBxayNg8EKQ8jiuGwIoqnySN3TH+3+5L5RWPgQp/lEBOkOqjye/kk+sUFCs6d8REZ19SJZzzLV0wzVHwHFglhUhgP+M9oGR+5JIpsxy0LSEyV7QrGHYXAup0kK9O9gDBfUl7y/O2xqfHfl56FA33CTWeIdaXhJYB1zSHJ6yEIb/rBB1BPhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSHs0z+rsNLGm9z6rAZxVSp3GrQV8a8JLsHF6qwYH6g=;
 b=WpsRv2orH7PV5eClcIIdkaj74LM3OMKs/BV+aJYlnjalBU3jwN6/Py0YHB3SvzArgeTA+qgydh/6MQSEXF94hvI8vlhcE5woGiYEwz9bgxI/2OH0T3f3iOCOtKGNhzNDODD7ySP6QaulmMmKmfzKHgXYF7aUPohkoAwZnv1zUWkPp8WA6Mr/OiJG1Cd6XChdwSUXFgVr4y1mkZLVwNhhZjOq7N9zpFpWAozZbiJx2Ylg8kAmq71+QS36Qjj0jKIlF5z0LQiKRlyx11RAxyJUcQspkHzCZMvpQDuEAVGwryZT03IYRHv47kvfxlHlM4SD1tw15uCa//V4yccwRTMTFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GVXPR06MB9721.eurprd06.prod.outlook.com (2603:10a6:150:1e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:45:47 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 10:45:46 +0000
Message-ID: <644c6549-e2e2-432f-aff9-48a37fcbb9b3@vaisala.com>
Date: Tue, 3 Feb 2026 12:45:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] iio: industrialio-backend: support backend
 capabilities
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
 <20260130-b4-ad9467-optional-backend-v5-1-7da803ba7326@vaisala.com>
 <688cbfb1-0944-492a-929d-91ebb9ab22fb@baylibre.com>
 <812a8c408c2e3a87ebe1ddc983acdc2cebe3b36b.camel@gmail.com>
 <30cf63eb-50ba-445d-a78b-d6532aacdc8e@vaisala.com>
 <177d62446d9c2098bbfe8b0f7fd9418d5afb60fc.camel@gmail.com>
 <aa5010ba-27bc-4c0d-9fce-8264216d4aa1@vaisala.com>
 <fc350d2605ca6d95facec1a67858cb0ac22db917.camel@gmail.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <fc350d2605ca6d95facec1a67858cb0ac22db917.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF000167FA.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::674) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GVXPR06MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f50bc77-4bc9-4e54-220b-08de6311637a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVdsZ2kwejdONWNZUndnZHUrUUlUSm1NRytPSGdENEs1aEZPcjhWNW96c2I1?=
 =?utf-8?B?U1dLbGVrYTAwcnJzUjZKcnd0QzQ0L2pHby9JaFVSR0QwL0J0Qi9UbHFiNXAz?=
 =?utf-8?B?cTBTTHBaSW1qekYxa2FhMjZLNk14VXc1K0lXb2Vobk9kUExMOU9vREhHeHhG?=
 =?utf-8?B?THMweUlldk9TRXNDRGtsSWE4S011Y2drZ1hWZzZTeThXVm1VQUUvdUNwWTMv?=
 =?utf-8?B?QzlBb043SVVaUmZoNmFXbllIejVLN1pLZjUvaEhYcEEzNUMwSW0vZUUvTkdk?=
 =?utf-8?B?WFB6RkI5YUloOGNQLzZtM0txNjE1UXR4TUNLQjBwZmtPaXorWW1qZ3hKanNU?=
 =?utf-8?B?TkwwMFBrbjlobndZZXlOOWJGbWdpWi9zVzlTSGVPRTZ5M2NQb3RyYmkraHlC?=
 =?utf-8?B?VlptTDROS0xwa1BKZWYyUWtGQTVUL3lJdld6WFBNd1pjcEJTTG1FZlVhR2R5?=
 =?utf-8?B?R0FyQUMwVFZsRmhoU25pSlBXcTJ3U2ovMDZ0OE5taFRJSWRzbGpvR3Q2eVVW?=
 =?utf-8?B?TTMxaUF3ZDlzeC9PZXB5Q01YbFFWT05RMlZhcHZKTUtVbDhiSU1vZTMzZmoz?=
 =?utf-8?B?SU1rMDJOczI5bC85Z1FRZG9TcVdudFJUbTJodGtwSTRDNUxLT1pxS1FybGo0?=
 =?utf-8?B?eENZWTJHN0ZES1ErMzhUVndtY2hDVW1qRTlRdnByaW9TQ3hQVWRGKzRjZ1A1?=
 =?utf-8?B?M1RWNVIxVlRSUUtMRGRFcU9MWnBiQ1hEeVR6YXM1ajBac2VHSDllSWJEK0Jo?=
 =?utf-8?B?bkkyUVZoQkxFSUYyTHUzK2VFMmZ5QU5JMXVwWmIvbitwc3ZIb1pjTXIxYlBn?=
 =?utf-8?B?RldnZE93NGlRSnIxaEM1cFpNL1JZaTdPTmgycXQxSmJmU2htcU1oemVCZVFm?=
 =?utf-8?B?MnFVemdMaDQ1Ym5HNUpUMmxoS0JSdU1GeEZuWmFUSmhaZVo4VUhtZGRHeEpq?=
 =?utf-8?B?VjBlb1lXRGErUXdUNFQ2MnljblQ4eGhPcEh4QzBQejVRbjVOeG5DRjlac1hh?=
 =?utf-8?B?c1hvOFlIVkZuNWZLeGY1bnVGb1U4eWlxOFJYNFhqL2JESTBlK0UvcWpoeGZ0?=
 =?utf-8?B?ZGdvcG1TamVOMk5sWnBvc0RWTGdiaDFwbWNVOUlLR0lQcHFkYzAySmk4U2Nr?=
 =?utf-8?B?c1Q3a2NOdUZrTmQ2UGNFZmNaNjNtMkJ0cTRrRW81aGtxWHVvZnZMbzNRQ0hM?=
 =?utf-8?B?RFlBaEpiSmVMQ0JWMUpxc0pZWTZQTU5FRThNaFZyMGV0enpuenVTdjhNVEpB?=
 =?utf-8?B?SmM1U1VRenU0UEdWYkRUd0RuRlNzOTBBWkMreEZqUURIUkgyZUZBcjV6SHVB?=
 =?utf-8?B?TmFmWFZxdWNBL0dNdUdsWHcwWDN2cXJxOGhWK1k2aXZwOTZuNWY4REdIeG41?=
 =?utf-8?B?S1c3VDNzTDFsMGxLQlVib3BHNDE0SVBwUTUzckR5V0w0OFVpamlqYU11Vmth?=
 =?utf-8?B?ZXpmRW04anhiK2ltN2NndU5oZ0djR0NPbmw4S0YwbTBnSVIra2hIYkpGb0NN?=
 =?utf-8?B?WGUxdjgwNHozZU1kYmdyMlhxN1UzOGdzNU9hWldNU0t6S0RZVXpHUEIrcW16?=
 =?utf-8?B?ZWpvWmpsVjc4TXJnQlhTRmc4OGdMY3lVbkpRa2ZNNVk1emEwV3ZZV1Vtd0NX?=
 =?utf-8?B?T21nK3RYZUhYa3pWemlDN1R1OTBPSGc5SGNYMSt2dkJ3R2lYM1lHeDFSdlNx?=
 =?utf-8?B?U1VzWUJWajZIODBLQ2I4a1VaZVlpSEtPUC9TL2F0SGJHQytmU3hiTGlBNXdt?=
 =?utf-8?B?ZURJd2NhUitIeklVSmJXMmVqVzNTU1p2ZzArWFp2MXRaNnFmcStJRmZqK21C?=
 =?utf-8?B?VzRuUmt2MWRqVXFZT0dGb0ovZGVIdmQ4ekZ6cnNMTzExdnFJellxT1p6Vm02?=
 =?utf-8?B?TXNNK0JqSWtYdlV2cG5uYWZCWmVldEMyOE1ZaWlyaEFaWEgvYUNsRUhGdng1?=
 =?utf-8?B?WVhQd1oxU1BDQUM5UkJnMDRDaUZjQllqU2pFKzFDYjE2aE1ibWRSYzY2WmQv?=
 =?utf-8?B?K3d0NUlCeVFLMm9lMFB4YXRBZTBIMW1zemttci8ydEVueCtkZ1ZBUHdRVWkw?=
 =?utf-8?B?SUlqdjRMRzZGRjNZSVZwVGFFTFhzVEpQbVZDc0JaWG5oZVV0Q0RlWEplQnU3?=
 =?utf-8?Q?QQ2c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2ZBaEZHSGtUQ0tlTU5XRjVpM05GUEthMVhEVHpsaGVWb0JIWmUrcmxzeTQr?=
 =?utf-8?B?UEtvWnpDN0hpWkZ3RWRrbDVaOXRYekVyQUFETno2cjU1SVpnZlhnNVFtV1FS?=
 =?utf-8?B?Rk5ZTmF5dEdaWExJbnhOdTZUUmZ3Q1FsTGFnUm5RTFo2eVFiekdTMnpHRE9u?=
 =?utf-8?B?aU9QVGMrNFNRNFQyYWMvaXRoMWpnQ3VTUGRITUwwN2o4MWswb01mQ3VBQXhp?=
 =?utf-8?B?RGwxc0x1K3g5TXl1dWZDdURuemN3YTA3RG1BVXpLamtGZ1ZIUEdzdmZDVTE1?=
 =?utf-8?B?aHZGeUZFUklsWi8rYnJTdkRSamZVMzE0ZmpndEppMGppUk9QUWNGTmlpV1dw?=
 =?utf-8?B?NlI4M0RWSkFNTWV3eHBWSUlOYThSM3BweDRyazlqdStEQlZnUFhGUG15Q01h?=
 =?utf-8?B?d0F6a203UDRZOGt6L3ZxanZZMUpGM1FGQnJXbHY2MThPRHY2R0hBekQxdGdX?=
 =?utf-8?B?czFOOGVyZWEwQ0dwT2hTdDdHUWF1Nk1kT3IwamxDYTBBaFJ6Q0p0T0hPU0ZI?=
 =?utf-8?B?SmZGVzg2SHJYTkZxTkhCY2RYMXFaYm9XVDZIeXhQanVHWGlBTi82NEdyT0Q1?=
 =?utf-8?B?UVFrWUw2YnRtQU5XVWpiVHRXZDRtRFBhZncwWWdrRGlTTkV3c1hqZitqL2F5?=
 =?utf-8?B?VUVIcmw4ZUkwVWV4aE1aUjVCdDc5Q3JpS1ZYalQxVmhZc2xwek53ZFFNNFFv?=
 =?utf-8?B?d0d4SzRQVE1uWlJZcDdITWMvUGRjbXk0cGEvNGVpRzF2Tm5Mam56UCtJQWRU?=
 =?utf-8?B?SDRYYzdSdTJ3OXdHS2Jsd0xuWW5LYnh3c1VNNW5KTjhmT1EvaERhOVdJekNM?=
 =?utf-8?B?NEFmazl0ajg4RjVDdmhDOFYvRW5adDQ0VVdTNVdBdVNPeG00bXczYmVtOXZG?=
 =?utf-8?B?Rk9tM1c3azRZQnltRlU1dFJEak96Nmx6SnpZM1pqWnVmVXpDY3VDdnExcDBR?=
 =?utf-8?B?VmJSNE13aVhrUUNSNCtlZy9LVS85T2Z1YnNSTlNjVis0QzVSRTI0d3lVVlhw?=
 =?utf-8?B?bFdHQk84RFl3QTd1Y2pnMHhNdW1MeGdEei9yZW1Gam5PcFdlaVZYWUlKNC9X?=
 =?utf-8?B?N3JaYUJGekxpUjR5a2pVWWJ0d3A4ZmV1ZE1ibmZTTEZYMTFlUlcrdWluamh3?=
 =?utf-8?B?R0NpcG1uUVR4QTlYMWRQU3Z0UXV0UTM3VXNQVWRhRllSa1hFNkNDdnhDTkwr?=
 =?utf-8?B?Z3JzSm8xZkNHOE5xZmt2cEVwaHFEbkRCVWExSUFpZjRFQnlLckVQWFpnVVJa?=
 =?utf-8?B?NDR4QzdXNXRINEFFR2FOcS81N3lQNGY0elZqekM0bW10T2ZWREh3TEh5TURq?=
 =?utf-8?B?U3pONFl2NmxJV09pSkp1MlRXR0trZ0RwWEFnRVdNZVQ4S2Vhb0hlUmJhc0N6?=
 =?utf-8?B?WmprYjMwczRvVTA5bG8rVm1La1VOL0x6NkNCMm5zT1VUTlF5dCtNd0VUblJT?=
 =?utf-8?B?MHg3b3Zib3A4QWwwZTdKQXQvWkVhVWlzeTY2cDFOOVVzWU5WNEN4L0JjSWNq?=
 =?utf-8?B?Qm9oUHdQeEZ4MkpaNXNGV0F3QzFLaUIydG9zUDlVVUw3QXpQR3cxSWowMGFm?=
 =?utf-8?B?R2t2ZzJNdEtGQ2JEOS9qMnVLRjB2U3VqeW1zVzJCMmlETVVmaWF0ZHdQR2ty?=
 =?utf-8?B?OGZ1SEErUDZhdUNvWUs0WkY2NXdCSGtkSkFsOW04dGlNcnJDMUFoV2w5NjNW?=
 =?utf-8?B?dWFTaUtTbU5nNVUzeCtPVEdNc1RSMS85cTBIL0JLampncmYvTVhkaDJiVGZP?=
 =?utf-8?B?ZVN2NzhBZHF6S2pqM0Mzc1dBdVRyQmh2RFErdS9NeE5LYWg5ZXNBV1MxTk9O?=
 =?utf-8?B?VjdtVjVHN0xneXZxU2NmZkMzKzhFRkJQMDRDTDU3ZW9iR2tpdTkzM0h4S29r?=
 =?utf-8?B?U3ZIN1NmbUhtZVlkNTJpNTZ3M093cFB0ckVuS3djZ3k3aHYyRTRYdFh1R3I1?=
 =?utf-8?B?bDF6OVk1ZmJGWWZZcm5sd09uMnhBeUNXdURJT3M0MGloNmNjc20zMFJLUTRE?=
 =?utf-8?B?c0JNMTBHWVBXSTR1K0txYzFrWllpZkFiVG5waHBVWXRjOElZZUd6eVZiRlR4?=
 =?utf-8?B?aUZPU0szSUg1R092TEs3YWEzTDFhTWZPL2FPQjNaOFp3bGFqcHpNT0lqL2N3?=
 =?utf-8?B?VG9PbWI3NFo3cjJiWVNvUkNOU0VsQUxJQmZ5eXZTbDYyc29xejFtWEsxSThM?=
 =?utf-8?B?YldnVVUyRDVRYkpZQmM0MjY0V2FsWFFJQ0VrVnBmVFFYL0FTYXF5VzlRNC9K?=
 =?utf-8?B?TStTUWFpdkRLdk40MnN0b2NFWGhJNGY2NXJPb0YxangvSTRXbXJ3ZlNOYjZl?=
 =?utf-8?B?cTBYRGRnNVgzbWpKY2tpRUVHZVVxTXJYUjlUMGdkbzBsZGdpSUFveEp0QUdh?=
 =?utf-8?Q?Skz/Sgac47YZKc2E=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f50bc77-4bc9-4e54-220b-08de6311637a
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:45:46.8713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6z1/44gbVYFDa3ly6LIxuED6jR2TDnrbqoKuEFiytLNpZRtIZvRJ+mBoKPLDkiyQdXaJvqAC2sgLq2OvhtrxNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9721

Hi,

On 03/02/2026 12:01, Nuno Sá wrote:
> On Mon, 2026-02-02 at 15:04 +0200, Tomas Melin wrote:

>>
>> Yes, this is debatable. It's not necessarily always on, but should not
>> be enabled/touched by the frontend during probe.
>> But anyways, having a capability that says if the enable/disable feature
>> is available, is in any case useful and what I was planning on
>> leveraging in my use case.
>> Fundamentally, with the capabilites as now proposed, it is possible to
>> select what features of the ad9467 are available, in addition to the
>> basic requirements.
> 
> Yeah but this is just tweaking for your special case.

Actually goal for me is just to have the optional features of the
backend really optional. In a sense, it's tweaking for my use case but
at the same time it's making things work more generally.

That said, this always_on is not a showstopper for me. Since it seems
there is no real consensus over that capability, I can drop the
ALWAYS_ON for next version of the series.

Thanks,
Tomas

