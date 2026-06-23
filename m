Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012014.outbound.protection.outlook.com [52.103.14.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991A2DEA8C;
	Tue, 23 Jun 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221244; cv=fail; b=uKBjMVqDk+8TBQENuDeJohpLXbm6c2MNoKDUqPNOnrpwO1x6dwY8nM+YPRw8MfkP24Xp4gbDISNfY1AkvKBzmlKopDuFu30jEHQsqssOQCK4bZnOlYxv4ZadO/k7EborIcVw2TMzCbyYc8xMMVB0/QDB7Ulze/6Hjojfy3mPCpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221244; c=relaxed/simple;
	bh=7VlQbYl52y2iYuezps6xTejQaF7iOL6eDCW36Q42Zoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eaVGq29xb6IKywKWgHSXxGU43HY3IeU5bSUQX/YL5ePzrVKHVhCIQF2x35stKO9Iv/bDzaTDNrQ0uktQPTP3xlTQgvUOuFlUmfRpwCtkDezSSkUU2DxzE9WthWIKjpyw0nEb4NkFSIHBAUsTrdslyVydc4+wAIon7K45DQeYBh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Xx2tydtg; arc=fail smtp.client-ip=52.103.14.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Xx2tydtg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJcNZHrt1G1fSLhhJHV0fYm9VOnGG09B4fGixaiXejM6igWoXXU58Raa3KG50GvLGz03AFLQdZqNhV9UufArctL+ARQH38UgXgtCazvLWXgMdA40wPH8cUPssYcp0q5Ldxz12jQHGaOIguqqPYku2J1zO7pfryjhIYsxenLSO1bIxoaGTCIMs75ekiihFNn5qnYNDnkvPJkjKqAQ4EdOe8BM9rVgRKhYnGEGpa4QnhJjOc+q4RKGnO1Akq1OgfVQGAzOrECKAHZGmMLLF4GHTJ1lFGc/WwKQ310CsAG/FHgDjTRWBKyVhoEq3LevIdxc1LyIZY7UZK6Z2KaN/pUnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Vrt/xRaVB/3mkLpMu+jiPdG3oiXO0dm/LFeOdVlpEs=;
 b=PxbZNfSLXR6RBbyaoH2LcfM03LIF4w9hMsAKUhHUIhqRzpG6SRrekLS1drd2u2fd50pjMUjWqcXdhAWknXUWsd5GAbTdySkm+Lfo1P2P5tW3gs+gpQebb97+byNX7WhzFxr5EIEs0p0WNh9CqONyxNOKIWFVtnv7VRMnzEa2Pc2B+2D1QOrCbBO+AiSJI5sFS5Jcwofb51+g9tyFmekgo0WGpNf+Tuw9iq0gWdPOXj1qUNcaP6De6RxVCtIwhB3JHA6aE485nmtm8biVUTQXzQHrNlaQBljaNOzRXmSHNsV5Z3LJwvTesrsRl4ZHlKZaRQ0vUTMx6pwM7mL9B31BJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Vrt/xRaVB/3mkLpMu+jiPdG3oiXO0dm/LFeOdVlpEs=;
 b=Xx2tydtgJjaxVQZkzg4dFvsmBsTxrVSDM+Lk+nfFfodlv0Srfg/dfRX0oaURRXZtNFHZmVQ6i6BJD4w2cLPgzLDHwEFyHnphn0nlL/NxTDAcLPvOTFmfP83eYYh3ZOY2TnwJOJNWWdfF1HeauPc44F6MuDEGIL29kTOVYOMBcRjnRXU2j/tc3S3E6y0FZlOGc1JWPSW0dTVyVk+kIb8BepEj0GOrkcDTGgWt+i3w76p/7WSYkYH81zKxF17UkradUg27RZKs68udrEMZjV0oHUxMKJuBYk+r+MYylkxVwZ0/d5URg8Lb+rqcZCe3zRKeSRWhmJUup8d7yvNSrdsm3g==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by DS0PR19MB7499.namprd19.prod.outlook.com
 (2603:10b6:8:14e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 13:27:19 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 13:27:19 +0000
Date: Tue, 23 Jun 2026 08:27:14 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Chris Morgan <macroalpha82@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"andy@kernel.org" <andy@kernel.org>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"heiko@sntech.de" <heiko@sntech.de>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH V13 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Message-ID:
 <PH0PR19MB99733860984A8B229A2B3AC595A5EE2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
 <20260615172554.160910-3-macroalpha82@gmail.com>
 <20260621181804.27b44942@jic23-huawei>
 <BE1P281MB1426C557A66945951D382EDDCEEF2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
 <PH0PR19MB997338ED05370F27B730FEE60CA5EE2@PH0PR19MB997338.namprd19.prod.outlook.com>
 <BE1P281MB1426349316BDFDBDB7C4BFE0CEEE2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BE1P281MB1426349316BDFDBDB7C4BFE0CEEE2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
X-ClientProxiedBy: SN7PR04CA0183.namprd04.prod.outlook.com
 (2603:10b6:806:126::8) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ajqJsnXXGFAsgk4B@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|DS0PR19MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d33708-de8e-4c11-19fb-08ded12b26b0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|4140399003|5072599009|15080799012|23021999003|37011999003|25031999004|10092599007|24021099003|51005399006|6090799003|41001999006|8060799015|19110799012|4302099013|440099028|3412199025|10035399007|40105399003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVllQWxTZm9jK0F5NG5QUjllYWJMb0lxek9IYUJmWVZYZDNWb3Q3c1N6RmVQ?=
 =?utf-8?B?SU1DWllaOHN3eDZaTDRpZWYyUzRVc0Y1SGZkVGR1QkRaejhlNDlhQXB6UTJk?=
 =?utf-8?B?QjM4NTUzNXhLaWNjWEN5Rkp3bnJZSXQyVktVWVJ5Q21SVkQ1RmlUSUMyalUz?=
 =?utf-8?B?OEFiOG1iVThZYTNydEZSOUZyV2dqbkt6TUtyY3I0YmIwSklsQmZUZ3Q0Nisy?=
 =?utf-8?B?VzZzVEpxYk0rQ0djam1YYmVXdm5RMDMzbG01dmNrSW90VEN2dnVWWjVNWStZ?=
 =?utf-8?B?S0dlQmMybFNNcGpSb1RZZ2wxRlFORzN0eXF1aklMTUxlbmlLeFRaaTl4KzNi?=
 =?utf-8?B?cjNZaDR1aCs1Sng4OUlqTzFxaWR4cmhoSmRGZk1yaWVTZ1dJZ0VwYWozeWV5?=
 =?utf-8?B?V0NNTVZGNVdqL3VKSTM2OWYvNHFzdk1qNzRtU0N3ZWFKS0hCSHh6REZscmtO?=
 =?utf-8?B?RVBiNW5mOCs1am1ZQU56ZnRVcURxeC93VGw4WlBWY3pZZUJVckFWQkhmRFBq?=
 =?utf-8?B?eE5ZdEFxYXI4RUljb3hmWHQ3dVpKV1NqNTJkcjVwV1R5aVNQL0NDcCtvRjRC?=
 =?utf-8?B?bEtwZ21YOHd4ZWZSNFFOQVVDN0pKT3NqWTNiVUx3eC85MnF1anlUQUtvT2Ry?=
 =?utf-8?B?Q2VlOVJzTkJtMElIbStxdC9PRE53aU5MQ0hRZy9OcUdHTW1XTG9XbS8zdUZU?=
 =?utf-8?B?RVpmSld2SzZSWGgzUXIvM0hCNFczSVhxSlR1RHBaN28vYzF0RFg3WUNiMjNF?=
 =?utf-8?B?c0g1T01HY2M0bEFDb1Y2R2FQRENrSFdBY2dTWnNFTEFaTlJacGt0dTJycjdC?=
 =?utf-8?B?U0N4Y2ZsUmFUbTRUT1NLQ2g0UDlSd1pWOVI4K0NwaWR6dS9DRElrQk5BR0FC?=
 =?utf-8?B?ZkRwWU5zeGttdG02ekwvUWxUK1pqL21pK1lTOXZZcGpIZU1tcEJRekthKzM4?=
 =?utf-8?B?VWorUm13VjVKdWF5d2JPSkhqZnlBejQ0S3FaaU8vL1FPZ04wUjlLdyt2S3Bz?=
 =?utf-8?B?YlljaUtReGN0Y2p2QUVlZVY1dnIwbjE1UktnTEdmelFzQ0ZlV3BzYmpMZkJD?=
 =?utf-8?B?YXd2LzRvUnJPUEtaLzkyK041UFBYYk9TcW1tTzFvM2ZZU0NTV2JweFZqR0Jt?=
 =?utf-8?B?eGs4WUtmbW5JSkE1RTNHbmI2SVZWTFRJc0RhODlBVDBIOWpXWTNWcStlM1RH?=
 =?utf-8?B?a3dQSG0wVllOd1VWUXMvWlI0WURObkhjWjJKc2dDbWRjallyTmVsbEtpVFIy?=
 =?utf-8?B?NEluVFg3azdkbCt6UHN5YjR2MXIxeEk4dmM0RzNnR3RZOUpGaHhiZGg1cStC?=
 =?utf-8?B?ZEhmcmtlZkVncWlSV2hrRE9KaU5YYUJmUGlodUF0bCtWMDhRdGhrS2hoamUy?=
 =?utf-8?B?RTdOK1Y4V3F4ZURQVVJhRXlVTldOcG8xTE1aNDk2emhCWkhYa2FDZGlSUFlT?=
 =?utf-8?B?NDlVUEpjWGVrMU93TU50ZllZV1hVcGYwQnpmVkhhb1I5NkQrYldNZ3dLSnlx?=
 =?utf-8?Q?orHFYpCwPFCsNZ+hlDEqrrunYlv?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDFtUEpxRy9BZ3pRTjNEQUV2eGovTXBreURQQUpiV1VTcCtUbG8xU25xMjFB?=
 =?utf-8?B?ZkhJR2szeTBlUStKY1QxNG1LZkFGQVJOTGR1Njk2VHY0bjVxVVgyT0lrZ0Zv?=
 =?utf-8?B?ZzlwMGZmcHdaZ3RSRVlnK2k4TEJPRUZyRFFjSEpycG5qZ1FTbnRDdWhTNW9R?=
 =?utf-8?B?NVdDZzdlM2lSaW9zeVk1aytoK3piWldTaHU1NmxLM1RwOG5Lb0E5L1B3bkZY?=
 =?utf-8?B?OVVMOHArdW1qNlFjZThXOXNxd0Zhb0JkbHNCbS9wSmZUMThEZmFLeWdaTlVE?=
 =?utf-8?B?aDdkRnZCMlFVQkd4Yi9jbG9vcVNsQk5uSjZsbFJuSHh5LzRONkpOSmREcWkx?=
 =?utf-8?B?cnNBd1hISTU1MldualBtMitpQk9QeDlJSHZpN1V3Rk9ueXhHa21GYXlSVFNC?=
 =?utf-8?B?cnhITjdRTlBOUDRMcEJhbDFFSlNkaVFsR3hjUDlDSzVMN3RkVG5jbDRHODl1?=
 =?utf-8?B?MzY5S2l3cW5LeWFvS2MvL1J6NysvOFYvYkkyVHNlbGxhZWpsY1JXaXJYS3Nv?=
 =?utf-8?B?RXo1QnE0Y3VlMFBNUTdNWmp6cTRUWkpIbGtIOFdTd0p5QjUwQUthMlBOVUxY?=
 =?utf-8?B?RkFMU3VRMjdHVllFS2VKdEFyNnc3eHhDb3Y3bkxmd2F0Y082OWJVZzQvd3Q4?=
 =?utf-8?B?YVVGTVpvcTE3Qm5wN2JWbktMMjFLSThrQ1U3dXdzT3NVUXV5cGVYNDQ2cDhh?=
 =?utf-8?B?Sk5VT3UyZzBuZERxWGp6dFBzeU45U1ZFZEttaDVrUjkxc0dGOGJaZDJIdjIw?=
 =?utf-8?B?MEhJR24wRmM5NkI5N2ZmSHR0YVk1U2xCM0ErK3lzb2REWUFaMk1nY01OakdV?=
 =?utf-8?B?Q1RNVUwrNU1BRG9QWWYrYmZ3ay80NDJyNW54bXl0enRYV1l2ZURKaWU3bEkv?=
 =?utf-8?B?amJUdW4zSWIvNW5MN1NMMDM2MW80RTY1SjZSdCtGb1dpSXJJalZidDRpZzg1?=
 =?utf-8?B?SHVHM0s5REI3Y1FnU0swdGU1bmlzOUtYTy9tTklOOEYweloyaXFoUGNUNDFL?=
 =?utf-8?B?TjFWZDhBZ29sRDNVcDRuOFNLaG02TXhWdFU3bUtUeHFISVpZNHZaUDFSYUt2?=
 =?utf-8?B?RFF1U0pOVTVsM1BwTTllbEpTOFF4M0M4VG9JVXZhMkg3WXRKaGZaZnBjREdK?=
 =?utf-8?B?ZUpNVVU2NkUzc3BrREdkSkhHNWsxWVBKRkU1WDlhWDlLRXFVMHJkMVpkMyt5?=
 =?utf-8?B?cVI2ZUJRUllGRTlqMkd0TEF1ckphVTRIVENKTDVWS0ErTmttYmpTZXROeGg3?=
 =?utf-8?B?VTZQUWpYOCs4U1RXRkNnWExvcUhMMzJiY1lCOFhrczY2OVQvT0Q5cHhtaEMr?=
 =?utf-8?B?NTk2TXJhOHNjRDgzalFKQitiVHozT1VjTlZydG1iNlh1d1oyQjJTUzJZc1RB?=
 =?utf-8?B?cW54V1MyVVNicVBYUUxzcXR1STRqNFRmV2ZwNlE5MThNVVY0TkI1ZlVnN3Jr?=
 =?utf-8?B?SjMxcWdUeDVoTDRrMktjYXVTNWVFU1AvbTlSOU5udTZRNU56QTBwRkxPUXBz?=
 =?utf-8?B?dW1acUFDYWxOSy9NbmVleUJ2eG9aYVR3Z2dOVGJpRnkvNXpiS3dVRzd5bnNP?=
 =?utf-8?B?SkJEUGZEU3dHRGxqc3IyUnp4UW51N3M5ZDRadTk1YXZuTHlrRWN3T2FDUjQ1?=
 =?utf-8?B?Y056SFdtSjB2U1pRbVd5SkxLOXRFaEtHZ1BheC9veVVTbzV1VjJzelo0c1Bm?=
 =?utf-8?B?bVU1ay9yWENuRHVmUlJ6dzc4UFpaOUg3L3FRRG1jbTJ4RkJCcEdEMWdzdExs?=
 =?utf-8?B?SjJ2ejdSbkcwcEZJTm15UjkzRWw2YTY5eUJXY096VHZza0VmekNmMmJmMTBk?=
 =?utf-8?B?ZW13bHZ4cjlaVFRSN2JUcytGT2Z3aVZGTHltOWR2QWFZYTcxRmhlWWVuTW5T?=
 =?utf-8?B?cXJiRDBiclpXSGFwVjNtU0VMcEgrRjlnS2pxNlpEUE1taEE9PQ==?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d33708-de8e-4c11-19fb-08ded12b26b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:27:19.8325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7499

On Tue, Jun 23, 2026 at 08:14:28AM +0000, Jean-Baptiste Maneyrol wrote:
> 
> 
> >From: Chris Morgan <macromorgan@hotmail.com>
> >Sent: Tuesday, June 23, 2026 02:06
> >To: Jean-Baptiste Maneyrol
> >Cc: Jonathan Cameron; Chris Morgan; linux-iio@vger.kernel.org; andy@kernel.org; nuno.sa@analog.com; dlechner@baylibre.com; linux-rockchip@lists.infradead.org; devicetree@vger.kernel.org; heiko@sntech.de; conor+dt@kernel.org; krzk+dt@kernel.org; robh@kernel.org; andriy.shevchenko@intel.com; Krzysztof Kozlowski
> >Subject: Re: [PATCH V13 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
> >
> >On Mon, Jun 22, 2026 at 09: 23: 28AM +0000, Jean-Baptiste Maneyrol wrote: > Hello Chris and Jonathan, > > concerning dt bindings, my initial understanding was that we had a file per > driver. But here, Chris is doing a new driver for
> >ZjQcmQRYFpfptBannerStart
> >This Message Is From an External Sender
> >This message came from outside your organization.
> >
> >ZjQcmQRYFpfptBannerEnd
> >
> >On Mon, Jun 22, 2026 at 09:23:28AM +0000, Jean-Baptiste Maneyrol wrote:
> >> Hello Chris and Jonathan,
> >>
> >> concerning dt bindings, my initial understanding was that we had a file per
> >> driver. But here, Chris is doing a new driver for icm42607 while adding new
> >> bindings here.
> >>
> >> Does it means we don't have 1 binding file per driver, and there is no need
> >> to create a new binding file for inv_icm42607 driver?
> >>
> >> Despite the naming, icm42607 chips are a complete new design very different
> >> than all other icm42600 chips. It using similar IPs for things like the FIFO,
> >> but all other parts are different. Especially, it doesn't use banks for
> >> registers access but indirect access delegated to the chip internals for
> >> accessing certain registers.
> >
> >For what it's worth I'm not using any of those registers in the driver
> >currently; from what I see in the datasheets I was able to find on the
> >web the 42607p doesn't do the indirect register access (again unless
> >I'm misreading). To be fair I don't have any other icm42607 chips to
> >test against. The 42607c does appear to do such register access.
> >
> >Thank you,
> >Chris
> 
> Hello Chris,
> 
> here is a link to download ICM-42670-P datasheet, this chip is completely similar
> to ICM-42607-P:
> https://www.invensense.tdk.com/en-us/download-resource/ds-000451-icm-42670-p-datasheet
> 
> Indirect register access is required when you want to use the FIFO for configuring
> which data is stored inside or when you want to update gyro/accel hardware
> offsets (calibbias iio attribute usually). Also required for a lot of more
> complex internal chip configuration.
> 
> I didn't had a chance to look at your driver currently. I hope to be able to
> have a look soon.
> 
> I can you give the figures for the required maximum sleep time for accel and
> gyro startups and stops. Usually, they are not provided in datasheet (only mean
> values).
> 
> Thanks for your work,
> JB

I guess I had an older or inaccurate datasheet because mine didn't list
any of the additional user banks for the 42607p, only for the 42607c.

As of right now I'm not using any of those additional registers, my
main goal all along has just been to get the accelerometer working
honestly, and so far using things like monitor-sensor this driver seems
to be outputting what I expect. I'm not using any of the fifo buffers,
wom, or apex stuff currently either as it turns out my implementation
doesn't even have an interrupt as best I can tell, I couldn't get any
output on the designated IRQ line suggesting it probably wasn't
used.

I'm currently using the mean values from the datasheet for the startup
times (10ms for the accelerometer, 30ms for the gyroscope). I had a
misreading in earlier versions for the temp sensor of 77ms, but looking
at the datasheet again it appears it should be 77us. Since the temp
sensor needs one of the gyro or accel enabled to be read I'm just
not messing with the startup time at all and relying on the longer
startup times of the accel or gyro. In the latest version (not pushed
yet as I'm still refactoring stuff) I am tracking the timestamp of
the gyro start to ensure it has been on at least 45ms before it is
shut off, as the datasheet also says minimum run time is 45ms.

If you see anything else let me know, I'm happy to get any help I
can.

Thank you,
Chris

> 
> >
> >>
> >> Thanks,
> >> JB
> >>
> >> >From: Chris Morgan <macromorgan@hotmail.com>
> >> >
> >> >Add the ICM42607 and ICM42607P inertial measurement unit.
> >> >
> >> >This device is functionally very similar to the icm42600 series with a
> >> >very different register layout. The driver does not require an
> >> >interrupt for these specific chip revisions.
> >> >
> >> >Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> >> >Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> >> >---
> >> > .../bindings/iio/imu/invensense,icm42600.yaml  | 18 +++++++++++++++++-
> >> > 1 file changed, 17 insertions(+), 1 deletion(-)
> >> >
> >> >diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> >> >index 9b2af104f186..81b6e85decd5 100644
> >> >--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> >> >+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> >> >@@ -30,6 +30,8 @@ properties:
> >> >       - invensense,icm42600
> >> >       - invensense,icm42602
> >> >       - invensense,icm42605
> >> >+      - invensense,icm42607
> >> >+      - invensense,icm42607p
> >> >       - invensense,icm42622
> >> >       - invensense,icm42631
> >> >       - invensense,icm42686
> >> >@@ -67,10 +69,24 @@ properties:
> >> > required:
> >> >   - compatible
> >> >   - reg
> >> >-  - interrupts
> >> >
> >> > allOf:
> >> >   - $ref: /schemas/spi/spi-peripheral-props.yaml#
> >> >+  - if:
> >> >+      properties:
> >> >+        compatible:
> >> >+          contains:
> >> >+            enum:
> >> >+              - invensense,icm42600
> >> >+              - invensense,icm42602
> >> >+              - invensense,icm42605
> >> >+              - invensense,icm42622
> >> >+              - invensense,icm42631
> >> >+              - invensense,icm42686
> >> >+              - invensense,icm42688
> >> >+    then:
> >> >+      required:
> >> >+        - interrupts
> >> >
> >> > unevaluatedProperties: false
> >> >
> >> >--
> >> >2.43.0
> >
> >
> 
> 
> ________________________________________
> From: Chris Morgan <macromorgan@hotmail.com>
> Sent: Tuesday, June 23, 2026 02:06
> To: Jean-Baptiste Maneyrol
> Cc: Jonathan Cameron; Chris Morgan; linux-iio@vger.kernel.org; andy@kernel.org; nuno.sa@analog.com; dlechner@baylibre.com; linux-rockchip@lists.infradead.org; devicetree@vger.kernel.org; heiko@sntech.de; conor+dt@kernel.org; krzk+dt@kernel.org; robh@kernel.org; andriy.shevchenko@intel.com; Krzysztof Kozlowski
> Subject: Re: [PATCH V13 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
> 
> On Mon, Jun 22, 2026 at 09: 23: 28AM +0000, Jean-Baptiste Maneyrol wrote: > Hello Chris and Jonathan, > > concerning dt bindings, my initial understanding was that we had a file per > driver. But here, Chris is doing a new driver for
> ZjQcmQRYFpfptBannerStart
> This Message Is From an External Sender
> This message came from outside your organization.
> 
> ZjQcmQRYFpfptBannerEnd
> 
> On Mon, Jun 22, 2026 at 09:23:28AM +0000, Jean-Baptiste Maneyrol wrote:
> > Hello Chris and Jonathan,
> >
> > concerning dt bindings, my initial understanding was that we had a file per
> > driver. But here, Chris is doing a new driver for icm42607 while adding new
> > bindings here.
> >
> > Does it means we don't have 1 binding file per driver, and there is no need
> > to create a new binding file for inv_icm42607 driver?
> >
> > Despite the naming, icm42607 chips are a complete new design very different
> > than all other icm42600 chips. It using similar IPs for things like the FIFO,
> > but all other parts are different. Especially, it doesn't use banks for
> > registers access but indirect access delegated to the chip internals for
> > accessing certain registers.
> 
> For what it's worth I'm not using any of those registers in the driver
> currently; from what I see in the datasheets I was able to find on the
> web the 42607p doesn't do the indirect register access (again unless
> I'm misreading). To be fair I don't have any other icm42607 chips to
> test against. The 42607c does appear to do such register access.
> 
> Thank you,
> Chris
> 
> >
> > Thanks,
> > JB
> >
> > >From: Chris Morgan <macromorgan@hotmail.com>
> > >
> > >Add the ICM42607 and ICM42607P inertial measurement unit.
> > >
> > >This device is functionally very similar to the icm42600 series with a
> > >very different register layout. The driver does not require an
> > >interrupt for these specific chip revisions.
> > >
> > >Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > >Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > >---
> > > .../bindings/iio/imu/invensense,icm42600.yaml  | 18 +++++++++++++++++-
> > > 1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > >diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> > >index 9b2af104f186..81b6e85decd5 100644
> > >--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> > >+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> > >@@ -30,6 +30,8 @@ properties:
> > >       - invensense,icm42600
> > >       - invensense,icm42602
> > >       - invensense,icm42605
> > >+      - invensense,icm42607
> > >+      - invensense,icm42607p
> > >       - invensense,icm42622
> > >       - invensense,icm42631
> > >       - invensense,icm42686
> > >@@ -67,10 +69,24 @@ properties:
> > > required:
> > >   - compatible
> > >   - reg
> > >-  - interrupts
> > >
> > > allOf:
> > >   - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > >+  - if:
> > >+      properties:
> > >+        compatible:
> > >+          contains:
> > >+            enum:
> > >+              - invensense,icm42600
> > >+              - invensense,icm42602
> > >+              - invensense,icm42605
> > >+              - invensense,icm42622
> > >+              - invensense,icm42631
> > >+              - invensense,icm42686
> > >+              - invensense,icm42688
> > >+    then:
> > >+      required:
> > >+        - interrupts
> > >
> > > unevaluatedProperties: false
> > >
> > >--
> > >2.43.0
> 
