Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795431201;
	b=3Rj1XVjW2OrvkN0AGszEm7dYdtHY01b4Z9VO6k7/7jC8iSNNWhXxluRMMOKDhtd7yBqL
	 XpAK774SbChPRkytwymG4VhCd8bJBc7pb8l+8IhYpfxT53v6967FmXtLCkl+/Kc7sHStb
	 POZOh2awb2p1dnrcq5Y3I0v75HJpFFfGy7slKCekdabWoP6vwzQlqViXNIceLUIwMucGD
	 C5mMY3wtmw4bUvfVIV/fVhJBVry89e1RnJ0xTaE45jbM6wQSFEVpAeInkPlk/OaJu0UDl
	 8l/63IL5p2H54lBUIn74VCTaGJ+Bxa6w2KM24uVbRs9Y1Ka/UF18X42CNn8LmkJcs+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795431201;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Z9YPFBs0/UL6V/xt6AcKxd1qjEKuCkhFqD1d/gc4JEc=;
	b=Z+eGOAscmerIDE3rs2oZKP7hvLMfKvzgF1PYaJ714i5iFnnUs65jsrvmYoTvE8URhCyb
	 BHmcdmQWtwzGdsKOoHYXoTYpIjUn9Ufmt/Vhrf4BpaR5YxgRoyc+TXNC7lPyeQc5DgBGW
	 kRpht33r8hbo2lB1WEoG2s4YW2OAmS8nT03U8u3ihORTrRFHE/S4W5UxkS4wwhzeyFIZ3
	 +EdTwkhq7oaDEwiOhkcMArz2rJC9l2PqRB8MhiYFVLX7YBfuG6yv29HeZUrJ9d/+0ErHj
	 6m4bsXMuFK3Qmcml9PAm91o64l90UiG1pPt1poaxjhQnslAAg0ze0Fay5zUojG0PMBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=CE9eYG6p;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Huf2Fw5J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C92C606A31A;
	Mon, 23 Nov 2026 10:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C92C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=CE9eYG6p;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Huf2Fw5J
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9Hbcn260835;
	Mon, 23 Nov 2026 05:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Z9YPFBs0/UL6V/xt6AcKxd1qjEKuCkhFqD1d/gc4JEc=; b=CE9eYG6
	pyjt9BTTuuHjfCqBJysNAcGrdXsitF8pfdXMzT51s1p4DaLx6NSFyJWsOoTuItWD
	g2OOy0wRRFNeQyfDOrp34+dO78Xfn8TDCfj3pp12iBUreZ80UTOwZsilMDWu3p1P
	s6dpJh6ddHrg3ALLchTsUljFG6c03EHd8JWOgWpWFUrASzX3WR/31KC1PBpMW7ef
	UoBghzjoOK8087WTn1Mya/3tcbpTbnxK/XKLIP0BbyFteIXQpHaD980Y+a2ehkj2
	zOGCxzpVCGrYoCYDYGO8fIPWEJqNfTBjbrHhsCgzP74OgH8r1WSiXuRxvoSuDUrB
	vHZsF7/1pEzWIMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Z9YPF
	Bs0/UL6V/xt6AcKxd1qjEKuCkhFqD1d/gc4JEc=; b=Huf2Fw5JHa2SfyPCSNRti
	FCzPsaAbc0NiutaF1ZZgN0MtigXRxT7bwJNs6tGSv+rxr2CBIzI8D+p55gxbg73U
	IK4yelFLyFtlYl4BmKOli3SKjsev5Du/1BH5zR/qb5V4Rxv+i2G/romaybbLm1po
	2F/5Ss6Av1g8EYS/u2ksD0Y3uKkfFTa/eVP4HQCN38YUbBPV3BrXIS1cDcWSJw2d
	WxQJM+gODSnl+dEVKD/5FLZ6W3ScrvEoNUIwkR4Jgr3FCPP1SAUc4iLucR3PDxuW
	vLi2k+dumqsDNJaiY8X7wUlCuPH0sjrr+U3HGQc391UdYEmKrJUXkGVErQN0rGvM
	w==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j3wgm5p17-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 05:52:25 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6gBn7NvZGvkJhWR4FEem8oLmP4oV4vYf+j58vNGL0xp1sE6Nf6cXHyv9r2m2I+DBHhA3nxjasto5CkSG6ADb7LVPCVuJ+0K0guxPPL+y1mKAIOHfp/HEeEpm77687oiKiJ3ehjuHm+JPtBwZVKXfGq8pOxS36dV5zSAbtyMYNs29z2VeLIO6TXqGEFphcQKpVNU7UUwZ9fYq9XuCUs6VShPKn+J1/XvEX04sk3UlPhpZBhCg8Noxtk7OMb+LsWCzKtZpP9lNy+kV9I9E2pxuk2SNRIrNeYe4HvVjZXBRvqC+TlNMBZo5rGFCr3taoQbdXIG9hyj3fftIhyqtuv4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9YPFBs0/UL6V/xt6AcKxd1qjEKuCkhFqD1d/gc4JEc=;
 b=cbU1sr71RaJFOlRhqxkTEEAuLFkNhcXwQucntoRhbEgrXMTBLQ4Q+6MvP5yh7W625PH5ZjTr3uRfcPEcNGKdVkmdibo9KyFJV7TokhUdqdOsNAeTRHiEn85wQSLpr8etU2i97rf5mDAokLqtuRjv35a5/WcF5WY0Ut3LbiPNgLT9Q655Rll9+IllKtf6Nn4u9XzVuxjF5lhegFx9krh9yENLiBp9wsVFUrrVYCRfKgSwxZeKEPJSqzgpKnMZsItKGoi5BMIWfHVp5RXiXUJdz/XZsK8t97RhbKctYVogkAi1YbexhV1BTsx3bOgp+nxERvNCi4vN0/mmde5II5IaEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH0PR03MB989335.namprd03.prod.outlook.com (2603:10b6:510:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 10:52:23 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 10:52:23 +0000
Date: Mon, 23 Nov 2026 10:52:19 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
        Frank Li <Frank.Li@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Frank Li <Frank.Li@nxp.com>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v6 0/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <awQa0Sg6-AyfDwpN@nsa>
References: <20261014-dmaengine-support-wider-dma-masks-v6-0-5b3ffdef8191@analog.com>
 <auiDhzNcif3LhPlq@nsa>
 <awAVoMe1VphXwQIw@parshuram>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awAVoMe1VphXwQIw@parshuram>
X-ClientProxiedBy: MR1P264CA0207.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::7) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH0PR03MB989335:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e35c252-01ae-4670-b72f-08df494fdacf
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|261009220027099003|261009221227099003|6133799003|261009223027099003|261009221727099003|261009223327099003;
X-Microsoft-Antispam-Message-Info:
 C7DA0taXW9jr59bQe7hr9g/9/pcptBLf62XycCEsWVnM9moAZE1xXr0jZAM7J+HJnErndCRzOy4I0GEdm/CKyHmDtu5dwagRQt4+ZA/ikrPLeAuBuNcWAvry+TYqmORHVtt2YokybNf7bQKOeM8sDTH/LkmIE4+W2LgFF2YwBKdszxXmbd3qyQ+czS7bvOj3iUSpdUEyHvKBZjOhEi+/gQOhpPpD545tbZGZsLivKlrVg7hcxwfAV+PaLyialM6vNUS6Zw10vdU1lETxF2GxCe0KDPF2OeJZi73OBrZ8wgJ3AQb9NaPcD4KddGX3SdpCXRdOwsGejQtbCCHXV7cdtprixsnDUwUUrWibe2zEEJ3Q2Y67xdjjZFgfcSU8ypiVujmTLXs2zLSrx3D2fz0OqOO90hW0M4u+PIAPEIe19Fw1MAGqMH4Le6RClZF/KYFmdlaTKSHUYugV62Dh9DQsUC0jsPib6/gP4HcEqPXsOaVv/wxeJeZmlf8PP2VXqtyMFO3IlOebYB8fEwQjeXklyzei7AEKKS6JYvxNvhQw/wZWgxXgH+R7RX8PMjTjjSDFr8cN2IY/sJDf4m4RFLxs20gSLCWG64/E3bRBWh5RNbU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(261009220027099003)(261009221227099003)(6133799003)(261009223027099003)(261009221727099003)(261009223327099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dTV2TzhHc2RtZENlcWhSMVNOZlB6N1pjdEZjZ3ZwL050WWhrdEJDYlZ5L3U3?=
 =?utf-8?B?NEJ2M0VkTzg4WkNmT20xbVRHc1QyVm11djAwOE9MYkZuMTJBQkNrbThmY2FE?=
 =?utf-8?B?TEVoVitXQXFmSTBjWGN3NFVTQlVZSEk3KzI0UUZJVnZoWG0xQzlzUDNRUUdj?=
 =?utf-8?B?aHlreUpDbEszL1E0Q0dDNHB3RzRPeE8xZDRXbERHQmp3bU9Nb1FIQWZDMk5V?=
 =?utf-8?B?MzQ2YXNzSXBzWk53YUxXcWZaNlpyRVJSZUZnS2tWV0V6WXZHQWQ3MkZBeERz?=
 =?utf-8?B?YUE1N0ExaGczbm9WSS9mT1J3WW51SjQ5VFdGZy80S3RpYWpNSTZrZnJ1OTRv?=
 =?utf-8?B?U3FTeXR3M0FPR0krNk42cFdzZTdVNGU3NlJmSE5zcStCRzAxTEpwTEZxS0p2?=
 =?utf-8?B?UDhWNUJTOXhXS2h6RDJZL1V2ZXY2UXRWcVhyQzdmdWhtNnlRWlFrMis5cC8w?=
 =?utf-8?B?SyswYWw4eXlpRktRVUJJc3pYTzNzSmNFMWdhTm54TkN2S043S0pvL080Z0NX?=
 =?utf-8?B?NllMODdxVzlnbjhNOUNsdG5YOExFeTl0SGhTTEpkbUlTQWJGbU1sMGdOT3NL?=
 =?utf-8?B?dE9EdTQ2S1NXeFRJaWtGWERubG5lRStLSHlOSjNFaDZyUGxBWVJVbVB4M2VQ?=
 =?utf-8?B?ZUtvZzR1Vk5nMlE1M0trUDR2UW1HaGlFTklKRzJ0WTU1Z0lvMDRZeWxKejRx?=
 =?utf-8?B?TllIUC9yRml0YmxtcnYzZWxEVHJ4bTNCc3labm9pSjBqMExLZ01UbHRWTkV4?=
 =?utf-8?B?bi9UZXJYQmY4NlU4UmZwYmpvd1ZFYXZsV3A0b2FTMnBLdHg1VUMzbkFad0NZ?=
 =?utf-8?B?bWRzV05adzErN2lHakhRNE5id0gvWnkveE0xTWMzdlpHOGNsMDcrdkNQT1JM?=
 =?utf-8?B?eFN0QkdSREtUSFJzcTRMMUxzb0R2djhkOXJJMCs1L3FIRm9iWUxYeFRZMFJJ?=
 =?utf-8?B?SWdwdHgwOHdSdkxRZXkyOWFnUTIxd2V0UnZqbzhDYk9XdHNkeTdIWEFhRjQ0?=
 =?utf-8?B?VWJ0MU5ZQjVrVm1rRkhWczVwZS8zOExlYnNQVWlQN09rSEg2N0tFVytkMlhJ?=
 =?utf-8?B?YkdMM3greS9wSEE5Wm5NQUo4N1c0UmlZdlBDM1FLYzlkWForUkdrbGNJbXhM?=
 =?utf-8?B?bG0xTU0wK3ZBVWRaS1JxV01JdFp4dkVzRTdWakc3cGdhc3RYZUYzeEJiVWdV?=
 =?utf-8?B?M2FSZnhaK0J2Q0FyTi9DeTdqSFRXZTdsNUFLR3R1NWZYRkRMdVRieW00d2lm?=
 =?utf-8?B?clJrc3lBYjcrbXBoay9VWkE4OHZKVTdnb3l0Vi9GdzB3Znd6Mk9ZSzdFNVZm?=
 =?utf-8?B?c3pPMkJjOHltVVBhSTYwTG9sVFlvYm9zb0FObGFVUUxtVWhaaGpnUXpsYlJ6?=
 =?utf-8?B?Z2w0YitYbmtTSVdZTVhiNzA0R0lBTzBvcko4ekhOZnpRSXUrS3pwMmRWdWI4?=
 =?utf-8?B?ejdvYzVEaEZPaElwSmxCdW42Qk5JUlhCa29VNlFhdjJvQ3g4eWx0L1Y5T1pC?=
 =?utf-8?B?OHFiazlTRXc3NzdxVjRyRjE4R3FLR20weU1oSWZaS0owSWxMbHNPdGtNOUls?=
 =?utf-8?B?RlJyTnp2aDM0ekw5M3Bsc3VzR0tOMU5QaE0zNVJTWTd1UGoycEVVKzlwYXVU?=
 =?utf-8?B?ZjVMckdCVDlsTnFHMStmSm9BNW5Nc0UzVVIzNDBUU0lPbFRrV09vMXFidnF2?=
 =?utf-8?B?cTNNUyt5REM0Q3huT0ZLQzBxNWJ3Znh4ZFlpTjdjN3RaaDFJNUdMazFTWkQ4?=
 =?utf-8?B?eXB2YyszeGx1aXpabHJkaDJYdlNDaHpGYU1VeFd0cE9CS2d6UG1kK09UVFFS?=
 =?utf-8?B?QUxQd2YwOEJFOFZ1Um0wb3JndTMrRDFIdXB4dHNIdmNnd1Q2WWlhT0hFTzBl?=
 =?utf-8?B?N3NWbWQrdWdvaWFUZU1UTXJEWTY5Mndtb2NLbEVIQnliK0RvUksra3phbEJD?=
 =?utf-8?B?SzFRMFBmS00wSlBwUmFKaHJZbXQrMWQwaHgvUTJPYk5LTHBPdGFmUk05R2tq?=
 =?utf-8?B?ZmJFOWNENllGbndLdWtXcEc1aWVvaURhclhwNXlGOXAwVWZTRGx5dkttZ0Ew?=
 =?utf-8?B?TEJtZlZlSG1BellWUEx1U0VPREhZc3A1WU9UUVIzVFZMOEF4aUFiRzJJRDVD?=
 =?utf-8?B?SzRSY0NZWEtFQXVQdU1SWkdXUG5wbkZRV1hkRXFpbSt1SWM0aHhwTUI1a3Rm?=
 =?utf-8?B?OUpUeFBnWVM4Slp0Y2JMdVptUWJMQkZFWGZpazAzR2wrdkZUVDF1ZitsTW93?=
 =?utf-8?B?YzJqSFJ3SkcwZ1REQ294UXFDeTNOZWdoKzZ6c3JmS3lqMGtUTWtWRHZIV2pD?=
 =?utf-8?B?b0p2YVBXajZmMnE3K2ZTcXpTVjd1bmpWZEFQelVyUU8xNEovR0RzUT09?=
X-Exchange-RoutingPolicyChecked:
	RQzv8DYyiJ0el7XBydThCsphaiMIJrKGQ3Bw2L40I1pSuo9FgbK06mtuJGLcKy9UHOVXQKpAunXI2JmlBdhq5UdlJqsdjkVC7HLHJMSb6AZtvrvh8BF384xkInnJj2X1iR3aiAQt550LvQ0VctRlwbToBjnk1T8gq2D2mEc6BVYAdOJi8WyZxtDhIK0ocRSSM8iSGuM3O5Ndt7ofDh1Un4IPC+L3Op1Lsu7+PgcmtTLGLtY6gO8Dynw3EMzxb+igkSFLSos9lMlCu+PpW1jY2g+D0d8ENeNyMDp0J7ey1u6T3fxkpglzAHzriEBqTRXVzqVHgj+YAdOvxJEbbdrAbQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e35c252-01ae-4670-b72f-08df494fdacf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 10:52:23.3342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sYkDvCC+NF+/nCGhAEQfpGSajWfgBdwtcTvJ+KLy7s8HLB9+NcxihPNBfM5N5x6bHIDyRgk/K2zjajp9EbbZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989335
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MyBTYWx0ZWRfX57ueH/fmpwUT
 1Auhip57OMcQF2DIZUW/4UBj/bNuHLJJ+frRNIMNHQ91Sso9iJfLwovOoeG9OtqfL/hAJTzsz0E
 xyvi/OAhfJOoWsMWFIkeEoM8BKyzSCFTK1gCqtN9CGD2lIB7ruEntd9TJNDa4CBRgW4RtI2tzTq
 Ra9t2IUcI92hNSdaxMAVdKFBLaJXWsvx1XfLyxebPjY9sv9p8IHqy2gDVt195VKCpBiwCGyIHQv
 rRnXvkpwYSHZD96aVag7QzMxddCb9C1EMkE0W7TEn+OO/vDtiwdXafmFI8SlwbZ6p4Im5tnEvht
 Sc3bvw2e6gJG7OQI6PFVkI+4lGi9/HyitrWi4JXhF/kRSrHfHZByPSfm57RgGyMnlyPoGYMdIlK
 4Ut/2XTkp3oNlzUCwFvWbXILnbZDhm9qTJApKOpGw6fH+FOXk6t8r7oqagpmjk3R+PZ+YHbU1Nv
 bcLNIC9ksAcj92H0utw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MyBTYWx0ZWRfXwkGNp1vUoeia
 mvN4yOeNws8f4av3RkBafl963PYVccxCtmQxH7wowAlP7yZm1yckqRVsIR5/qu/gkiaJStPVyNI
 KSR1Yp5ud3Ui59cJpkEy9RtjQja2WB/K9GTrPv6/fzbGtHJU1gG3
X-Authority-Analysis: v=2.4 cv=FeGiV5+6 c=1 sm=1 tr=0 ts=6b041ae9 cx=c_pps
 a=CJt2AWVwLbfAHulDA2arTw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=gAnH3GRIAAAA:8 a=S-ZOCt0gclX-FooYNv4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: kdd8IC0XmEuTs9a9kTakOwMzfYeOhUn-
X-Proofpoint-GUID: kdd8IC0XmEuTs9a9kTakOwMzfYeOhUn-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230043

On Fri, Nov 20, 2026 at 03:10:48PM +0530, Vinod Koul wrote:
> On 02-11-26, 12:36, Nuno Sá wrote:
> > On Wed, Oct 14, 2026 at 03:19:10PM +0100, Nuno Sá wrote:
> > > The DMA engine slave capabilities advertise the supported source and
> > > destination bus widths through src_addr_widths / dst_addr_widths. These
> > > are plain u32 bitmasks where a set bit's position equals the
> > > corresponding enum dma_slave_buswidth value, e.g.
> > > DMA_SLAVE_BUSWIDTH_4_BYTES sets bit 4.
> > > 
> > > The consequence is that widths of 32 bytes and above cannot be
> > > represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
> > > 32, 64 and 128, which do not fit in a u32. Hardware with wider data
> > > paths is becoming common, so add a representation that can express these
> > > widths while still using enum dma_slave_buswidth.
> > > 
> > > This series switches consumers and a small set of producers to the new
> > > bus width capabilities, represented by a dma_buswidth_mask_t modeled
> > > after dma_cap_mask_t. The legacy dma_device u32 fields are kept for now
> > > so the remaining DMA controller drivers can be converted incrementally:
> > > dma_async_device_register() folds a legacy-only producer's u32 into the
> > > mask, so consumers only ever have to look at the mask.
> > > 
> > > Once the remaining producers are converted, the legacy dma_device
> > > src/dst_addr_widths fields can be removed as a final cleanup.
> > > 
> > > This issue was discussed before here:
> > > 
> > > https://lore.kernel.org/dmaengine/abkoXXbaxaiqbBuX@vaman/
> > > 
> > > Changes in v6:
> > > - Patch 1:
> > >   - Prefix the bus width helpers with dmaengine_ (Frank).
> > >   - Drop the wrapper macros taking the address of their mask arguments.
> > >     The helpers are now static inline functions taking a
> > >     dma_buswidth_mask_t pointer (Frank).
> > >   - Drop a stray blank line in dma_get_slave_caps() (Frank).
> > > - Patch 2-8:
> > >   - Use the renamed helpers, passing the masks by pointer.
> > > - Link to v5: https://patch.msgid.link/20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com
> > > 
> > > ---
> > > Nuno Sá (9):
> > >       dmaengine: Support bus widths of 32 bytes and above
> > >       dmaengine: dma-axi-dmac: Use bus width capability helpers
> > >       dmaengine: dw-axi-dmac: Use bus width capability helpers
> > >       dmaengine: qcom: gpi: Use bus width capability helpers
> > >       dmaengine: stm32-dma3: Use bus width capability helpers
> > >       iio: buffer-dmaengine: Use dma_slave_caps bus width accessors
> > >       ALSA: pcm_dmaengine: Use dma_slave_caps bus width helpers
> > >       spi: dw: Use dma_slave_caps bus width helpers
> > >       dmaengine: Drop legacy bus width fields from dma_slave_caps
> > > 
> > >  drivers/dma/dma-axi-dmac.c                         |  13 +-
> > >  drivers/dma/dmaengine.c                            |  23 ++-
> > >  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  39 +++--
> > >  drivers/dma/qcom/gpi.c                             |  11 +-
> > >  drivers/dma/stm32/stm32-dma3.c                     |  37 ++--
> > >  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  15 +-
> > >  drivers/spi/spi-dw-dma.c                           |   7 +-
> > >  drivers/spi/spi-dw.h                               |   3 +-
> > >  include/linux/dmaengine.h                          | 188 +++++++++++++++++++--
> > >  sound/core/pcm_dmaengine.c                         |  20 ++-
> > >  10 files changed, 289 insertions(+), 67 deletions(-)
> > > ---
> > > base-commit: 42c31fec1ca76b8b5f7759def122d418dff2cd4b
> > > change-id: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
> > > --
> > > 
> > > Thanks!
> > > - Nuno Sá
> > > 
> > 
> > Hi Vinod, pinging this one before resend. Already got the rb  tag from Frank on the
> > first patch. If anything left to do, let me know please.
> 
> This fails to apply for me, can you rebase on next and send

Sure, will do it today!

- Nuno Sá
> 
> -- 
> ~Vinod
