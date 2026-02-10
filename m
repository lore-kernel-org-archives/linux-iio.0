Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020076.outbound.protection.outlook.com [52.101.69.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9817117ADE0;
	Tue, 10 Feb 2026 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770720850; cv=fail; b=pHtbYS579kkJhdqnddgn6L63LeYRz2PfFr8v9u4I7VMWbxUdPvkVoBCXj3e/HUCSUJIS+sdJccJDyxtd/M5E9e2Ab4S381AUrZRaXPoo77fch3drLFg9ijUtD/QWkK33JDuUmUSF1HuyHw4Pye3cpIiqGQfQLimxKabAaZrpmlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770720850; c=relaxed/simple;
	bh=OyA6zGByuRzJZdIu5/yud4uCpoEYp/z1NViJjC28RdY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=FdYUpPGaIqTl0M0GQ6i/0xdEY7uf/R1qhyeOBBN4O1p94bI62NNLX1bBtxf5UkBa32164mWjGH4vtxS+ujXeDj1WgKyi1iA+Y8KPHULXqRBtOESttggNi4LIUf22XIMm6WXWrNVt5AsfGbuoUxUEwLm65JdKUQwpV3LCBOAJ7Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=Td/lMZFH; arc=fail smtp.client-ip=52.101.69.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="Td/lMZFH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIvK0R6gt+ubYx1Am8Sny+U7TV75gLmy+AqhrdKC6ipkIeS/ppuqXSPd+O1XpM0fY8PrE/jcgALA4qxuQm3Ktd1WdPWxAjzowwgqFovoqvPpA9vrVblFuROcbRpiTdQANcnOvIfzidnCaS1I98H54of4VzoremImozyEnL4coGLY5aF18D4T2qATtFPkuNHLQKL33dEBrvdFs8wS5On1QPCYFaDquDb0dUMWPv28V0bnM6/w5/6/OkjFCJ5EWONPpGkTgPhrLlkAAX3Si+GcLO0JhITvVZMIc2u0U5Ewyj4TuZ/YDjiCF2YUaTAZ2fcb9XCIIYkkvBL+YCC+kimiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBc26WxaN2JJMGyIXxeDulPMPFcAgJlJeykqdEsduTM=;
 b=wflw4XMGs4cUb3H3vEvtVolYXacFG9sHJ0BHrbA85BjJoCuOuccho2GFFctjrk8QurjZHf4c4S2rWxRTMEVMj5bchWE0FK/PGHTawedLmTbSsbhlh3GrDizjvuT5D/k19H1CzIZnT/Rx/5GFhZcfYE9yO/7L6QXlgWQGUAaqJ0Uiz7FvludSTIE76k0uR/ZPbBk3FBgW8AngafMjxYw9lOv9OOGkJSqrGLE+1Dj2swrWLjTIwh5ffvF1AWId0IB5pmCalCg9iXEY2i8vTlKxI7rhX8YcxaOd04jIGRv81pmAMYpkAv5WMLJ2XXMR12mo3Y3Ww4OW3ebtnAIPAjO6NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBc26WxaN2JJMGyIXxeDulPMPFcAgJlJeykqdEsduTM=;
 b=Td/lMZFHIMtkd2DAxvwlLLVmaCBzORT71TnbEYsgswrj8GER3DUOq3rSV7AbBUNp3X1W7Ft4Lv5EnBI3VpUjtGuXwAMjJSkMaW6aEUCDkpcyJi0H459odHjD0JnsWi/qUjUtccGeJipFCNDHWPdIX7Ze9I6S329yNWs22F0D+wNqOiyixb88V6NwEiHgh4cxVROK8c6uFjRvfMYDtjcMpTsJ88k16agqLdWxGJNnslHYjgur66ZnOPqQk/7caVgJlN5qDXvy3IuCHwbQgyMo2BbceOxvy4YLb5/sXP93WglqcIcLwomzDJrSmAPnGRjcrFJwV7VJp+Z+Com06etNpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from VI0PR06MB10639.eurprd06.prod.outlook.com
 (2603:10a6:800:2f4::10) by DU4PR06MB10173.eurprd06.prod.outlook.com
 (2603:10a6:10:621::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Tue, 10 Feb
 2026 10:53:58 +0000
Received: from VI0PR06MB10639.eurprd06.prod.outlook.com
 ([fe80::3a41:90d:2091:bfee]) by VI0PR06MB10639.eurprd06.prod.outlook.com
 ([fe80::3a41:90d:2091:bfee%7]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 10:53:58 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v7 0/6] iio: adc: ad9467: Support alternative backends
Date: Tue, 10 Feb 2026 10:53:33 +0000
Message-Id: <20260210-b4-ad9467-optional-backend-v7-0-7a590ffe02df@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC0Oi2kC/33Rz2rDMAwG8FcpPs9Dkv/FO+09xg6K7axmXVKSY
 jZK3n1OoawjYHT6xMdPB13FkuacFvFyuIo5lbzkaazBPR1EOPL4kWSONQsCMkhoZK8lR6+tk9P
 5Ust8kj2HzzRGSWpA8D4lHZ2owHlOQ/6+4W/vNR/zcpnmn9utgtv2ztoWW1CC7FSyaBSmQcfXw
 nnhEz+H6UtscKE7ZgFRNTGqGDC5VIcGjXtMPWK6iamKRQqd9s5HQNhj+gEjbGK6YthVDqI2EMI
 eMw+YgiZmKuYid6B6dorsHrN/GEHzr8VuWGCCoCEYz/+xdV1/Ad7Je3hHAgAA
X-Change-ID: 20251215-b4-ad9467-optional-backend-23f1099ee4d7
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15-dev-c6abb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770720837; l=3834;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=OyA6zGByuRzJZdIu5/yud4uCpoEYp/z1NViJjC28RdY=;
 b=OrLYVWbZ3agngXnb1CjE0FQr3hks3bXGjFeH4D0WXZQ4y3ZktEXfeOszJ7uMiSD6wFI5f5kIL
 KMVKw25DMU9DmgUO1ZxHV7X34ildR0k2QUzE0FmmbNK4UD2H3cXlr8N
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::28) To VI0PR06MB10639.eurprd06.prod.outlook.com
 (2603:10a6:800:2f4::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR06MB10639:EE_|DU4PR06MB10173:EE_
X-MS-Office365-Filtering-Correlation-Id: 4350113c-6aa4-4329-3388-08de6892b161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWtpNVVYazRmUmpVREM0ZGZ4YjVMZGFOQ1lYZm5uTHhHNmVKR3Z5aXp3V0tk?=
 =?utf-8?B?V3p2MUpsUUIrdk42VGtHWnJ5QWxENEtMb0d3eFVqYSt6ZVduT2kvSS9QbEVH?=
 =?utf-8?B?OCtud1VPZWxtaTNDMktlYmt3MjQxUVFoUFMrV3VKak02MUdGOURFZXhhK2Nq?=
 =?utf-8?B?cjAwRythUFRsK3BENmNxRFZDaldrbzRiclJBMjhEaDJ2bmpaemhySXJUYUUx?=
 =?utf-8?B?d1Z2aVN5UmROWWh2QlFVNFpmdUU0VEhQaVhFd1E0ZEpsT0x1SkxXT29qMUZZ?=
 =?utf-8?B?bEUrVXBhSzJkQlJLYWlHWmRjMTBjM05vU2c1R0VRckdJUEdIbmhHVlVoWW90?=
 =?utf-8?B?aVp0MXNMcG1pOC9HWjcxcm5MTVJ0WmZaeHFmQXdPaSs0WDQrSXJEYWRjNUU1?=
 =?utf-8?B?b2huNHZCT3gyYjJoOUhsV3NwTm9ZWVNwVmlOVmlFTlVMMGg4Q1YrY21lTEJm?=
 =?utf-8?B?UU4xVGNvUDRvVkgvVVlsMnBvUFJLNGk0dlFiQ2pOTzlPVWlOUFJIVEs4RE9D?=
 =?utf-8?B?ZWNTaDR6MncwVm92blErSXBuOUFnRkZzTVovbzlqNTV5T3JKSFdYVHJSZTQy?=
 =?utf-8?B?NlhnWlJBSWdkcjVnN00zQ0VwMytELzNTNEUrNVNzdG5yWmN3NFlVTm1vMHpI?=
 =?utf-8?B?eDJMVnV3cFFwN2QvN3FkTzVncDRIRFpRZEhYY3RIbVc2UDV0SW9ObU9qa1pa?=
 =?utf-8?B?M1d1ZDByWTMvWEp5SUZBQU1tQzkxWG5LRS95clV1K1RzcjVheHdqR0dKaFBx?=
 =?utf-8?B?L0hOemwvZjREcG53N3dSdWJTTmErbk12RkphR3lBS09kc3FCWlNMMkFYYTN0?=
 =?utf-8?B?cW1RQlloN3dKN3Rzakdma0JoS2xPYjdjeis3cmlXWjMvMDlGTVNBcERZeWoz?=
 =?utf-8?B?TGNpdE1iNE01WmNmS2MyZXVrRjNlWTZvc2UrY2lBNkRvRy9uRFJCbVVFSXRa?=
 =?utf-8?B?bGUxZmc5Q3U3a1NmVWV3b3o2RURvTGtJMVhsOUVwcVV1UG0xQXFIK0ZqOHVB?=
 =?utf-8?B?TUgyS2NsNkNmS1h6Zm4xWXRBY1J0bUNGUzRMSnVwcTMyWDFuL084aTQvRXJx?=
 =?utf-8?B?cGZBYjhnZ052K3NDWi82K3NGNnk3anlOcmxHWGV4cC80aERHVW1UWWMvSm1Z?=
 =?utf-8?B?bEdMZG1WcEhCUkJvWkNiQzNiY0Y0TkQrU2k1MW5TZXA2aDNpNmFZTm9PZ2Jx?=
 =?utf-8?B?alJXemMyM2xid2FQNW1vQlNjTUdxdnlpaTZEVUhCWFVrSVBtWkc2TmRhdjF6?=
 =?utf-8?B?UnFWQ3JZYnhyR1hSSmpZdkdQeTV4czZKRW5FdCtCc0pJSFRmTTRZRHpMRFJY?=
 =?utf-8?B?ejdDWlJUbE9hZmhTQ1hYQkd6bE1SVFBjYU9XOHZtazlHL2wvYTNhNzFyYXN2?=
 =?utf-8?B?L05tcUs0SFY4U01TS0Z6QysrQ3pvWTBDTEtmalFoMW1PcVRuV0RnWldyeFZ3?=
 =?utf-8?B?dnY3T2dRaTFlZmh2WlJYZEU4UUtNS0hQVHBlM25DSit0K1hLRm16WnR2eHBp?=
 =?utf-8?B?UERieVh2Z3prVWtZSXZha0tRZm8rTjlwSUlhZUtLWFRXQkZHREQ2ZVUrclJu?=
 =?utf-8?B?czQwenVpQUxsdXI5RXZ5TGszd1I3dHlqcEh6K0tudUtEUktFVFk1eUZHN0ht?=
 =?utf-8?B?L09EYWJsY0ppVWtabjRlaHlYRjA4SjBLaU53U2c4NVVHSlQxeUVNVUNRTEM1?=
 =?utf-8?B?ZDdHeFVtVnVUVGdUVzAwc2F4OFNEaFk0TnpLeW9hS0kxWFFTUzlTVlMreE5m?=
 =?utf-8?B?K0F6NkdXTDE3U1o1R0V3ajdOU2NvV1BZaHd2WVRyR21LNlJYbnU1RFJ0Vkht?=
 =?utf-8?B?WW5WRG1HaFdhV0orc3hzZHU0Ung5MFdibXVYbG5YNzF2WDhWSkI5L1NuVzVm?=
 =?utf-8?B?cHhCM29XRFVicHltbGYwa3RWakEzY1BURDlKNEdReDJPdll0WFZOYUhOOHZu?=
 =?utf-8?B?OFI2cnBCb0RwdHZhZjQ3NkxPSHA5eDFHMHNNWjQxOTE2MThQWk1VUmVxSGdW?=
 =?utf-8?B?TUkrYVdrRmZ6S2xKVzYvbWZwVTBUTFRvZ05wZElmanZ2N2d3cWFOL1lsOGVM?=
 =?utf-8?Q?VRihvk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR06MB10639.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnhQQ2hVNnRmQlVyVE91SjRMMHBDcjhIdyt3V3YwNkxrMERqdmFiZVZ0Qjdh?=
 =?utf-8?B?OXJiSWlpL1hScU9SV0ZnQ3NxdXJPWWEvVDZ6b3VnZjFIMmp0Y1YxVnZqd2J5?=
 =?utf-8?B?NkpydkhPU21pOTBnY1Zmd210UGs1R2ZCSWU1MjRIYi9abmQ3UWFNM3NoUlBz?=
 =?utf-8?B?MXNhMUluejlORTU4eEw1K1RvR1FEZVR0Y0JnSHdVbUZiS3MwUkxCckw3WE1w?=
 =?utf-8?B?cFJCOGY2eHFYWUFSbnFCcEZyRFYzMXp3bEFpanJMeU5JZ1pxM3BzZXBvUW9q?=
 =?utf-8?B?MVNwZGtZR3VUTWZOSHhnUG9DbWpNaTFFMTkxcGZjVHVZczJlYXdtTVd5Z2p2?=
 =?utf-8?B?R3ZmUTNtN3dYaE9ZeDhYaWhaKytaY1l0ZVpmMUNQK2R0ZnJDNnk3SkpDbXBW?=
 =?utf-8?B?TXBRNzE0WVVPeldSbXdwZDQrWE0reXlhSmRSZ2JaazBHNHpaVm4vME1RUld0?=
 =?utf-8?B?WDh4NHI1NFZJbGlZdUhSbTBRbW1tMG1KZG5LbUVGQ3c5eUJXdy9WelRPc2du?=
 =?utf-8?B?Nmw4dkVBZkREcUNMY1ZHMy93UWY4bUZyRUh1bU9IMHhib2FmVmtRSyttMC9N?=
 =?utf-8?B?UlBJNjZqVDc0UmRiTHhKYzNyL3hWdWM3bDUvTFYzZ1hCcldWd2pNVWdIcU5y?=
 =?utf-8?B?SS9rNmxRYTNwZTFLa0o0bVhHSHdvdFJ5M1o1MThzY3VKaktNRmN0bHNON25s?=
 =?utf-8?B?M0dIVkpTZGJyTGE1VXkxMzB2ZFo4SDdHdDNvR0VUc0JwRlJCUDV1Z1MzbTU4?=
 =?utf-8?B?akNhdzlBdC9YcDhSQ2pjanI4b0lDVE8yR3lwT0VEaDdRdm91VkIxbiswVWNa?=
 =?utf-8?B?N0RJM0wyenkxVkQyY3prUTNlSE14N3gyamZ1b0QwU0VNSzRleWhLRDBlZUhw?=
 =?utf-8?B?YzNlR0gwREdUMjBON3pUUTRBS0gyanZETks3THY3VXZTeDRVTHd1YVRNSHl6?=
 =?utf-8?B?Zm0wak5qSEVkRkhpQ3JlMDUyaFpnNG55TmpUeEV3UW15OXErSVVLaGM5dUh0?=
 =?utf-8?B?eU9WdGw3WklqcW03TFBKaitzZnV5QlVDQXRhZEtNQk5jZXZocy9KM3ZwYzNM?=
 =?utf-8?B?cjljZFBmZ0VydUlGWE5uUEt4Sk1EdnlvbjZCbTg3dGJEdWMzNjU3OHJsaDcr?=
 =?utf-8?B?Y0hPNDgvQldaKzZPNmRXZHlzUEt4TTV3V1NjT1dSdFBsdmpxVlBqSmk1UExN?=
 =?utf-8?B?UXExQjZOM3BTUGRRcnNwcnhqemJFTTg5bWZ6NC9NdjlsdjB4WnN0YzBHZndY?=
 =?utf-8?B?OS9FcXp4MnhwSkt2VGg3dFhkRWVDRnhNVWRLbSt4RmUrbHltaFp2TzhIRHZZ?=
 =?utf-8?B?MW5MNWpLZkJXdTZ6aVg3UkpOeFBoenBwaEtNMnZPdDA4NVhYd2t6dm9EUk9R?=
 =?utf-8?B?aE92R3lVVy9lYWw2ZjljOCsxVUN1OEpLNmVSNlJ3Y3JwRHBjTm15REZsN1hm?=
 =?utf-8?B?UllydEw1QVIvT0UweEM0MExNbVRib0J5aXZFYmNqUDhMRndZeGtJVjF2Nkdr?=
 =?utf-8?B?ajlHcFg1UUllYWZURmhIMUZBTmFaKzhVWHBIWVRaOTNWKzBHcWo3WXM3VTE4?=
 =?utf-8?B?V1FQMjJqVUhXYTNNZTA4bnlsUkZBcDgvY1RSSkxnS0pKcVc5RTFMcllpY0pk?=
 =?utf-8?B?eFpUYXFndFRwTU8rUFByS0JUWWZZQ2pZeXUvc2RFWHZuWHhyTWJJcGdnSlBO?=
 =?utf-8?B?SWhsUmxxSDF5bDVTVlhVTjVoNlBSZW45d2RWMVJhdmVoczRMYSthbE5SZzM4?=
 =?utf-8?B?VmRxekxzVW5yREMxZFJqaFU4YWEycnNGaUk2ZXorL3BIVUt1MCtNOTl1Q0R3?=
 =?utf-8?B?UzA4SDVLb0p4SWdVcVRtRFkyb1kwL0dMcjFHRkhWa3MyOFk4Mzg4OENoSHNV?=
 =?utf-8?B?SGl3WDJ5RkpHc0drN1JmRU04MEtCeThyUkQ4QkIzbnAvdWlZaXRsUlBCbDVo?=
 =?utf-8?B?OVExRWRQZFFnSFBBM2JqcHdDMHJBeHlqT0R4QzhLeW0vUTRxS0VjaHZETnJ4?=
 =?utf-8?B?ZElOcmZKVkc5endaMkRsRFZ0SU04MlJ6ZExld3NRZG1rZ240QVN1V1lZNXZM?=
 =?utf-8?B?YkxYM3BVUnV1OFBhbGdYL0dCa3Z6citrWlpXbDhOSStBeHIzcHFPN2Z1amlm?=
 =?utf-8?B?SFhvaHRMTzVoNnJScnMzbHJENWxFN3EzNnVXSlNaSGpScFhkbzhqWkloa2hj?=
 =?utf-8?B?THJVUnRZb1NHNWFpZGJaWlk2eStoczZxcFduNXVrOEpMeVRMbVh0OEFXWDYx?=
 =?utf-8?B?K1ZsZFFqMkp3cENOM25xbDc0dUo4Yi9SckxXcjBGTzB6V01abVVnRE9tWmxq?=
 =?utf-8?B?RjJaTG5pTGZleWo5aDJQOEJHZG9DK1VlWTQxSS93UXU1bm4wZXM1aFFqckds?=
 =?utf-8?Q?pZkdKwHlcGUgGZTQ=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4350113c-6aa4-4329-3388-08de6892b161
X-MS-Exchange-CrossTenant-AuthSource: VI0PR06MB10639.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 10:53:58.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjFPylocLR8964x+O/3hcE4MYKJt0d12kF0ObCXfXUx8HrvVRHxCdTYm9cgHhFnI0SfpV3lI5pH44x6IV0fmbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10173

To facilitate backends with different set of features, add support
for defining capabilities provided by the backend. These capabilities
typically extend beyond a single operation and are therefore not
directly linked to if a single function call is implemented or not.
Furthermore, the capabilities determine if a certain set of operations
should be attempted, or skipped by the frontend. This way
the frontend driver can work with a minimalistic set of features and
still have the device in fully functional state.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
Changes in v7:
- Fix missing check for calibration for test mode off
- Add commit to clean up device usage in probe
- Add empty lines around calibration check
- Link to v6: https://patch.msgid.link/20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com

Changes in v6:
- Renamed CAP_ALWAYS_ON to CAP_ENABLE with inverted interpretation
- Renamed CAP_BUFFERING to CAP_BUFFER
- Added sd_adc_modulator capability commit (CAP_ENABLE)
- minor fixups in code and docs
- Link to v5: https://patch.msgid.link/20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com

Changes in v5:
- As per recommendation, use guard for whole block
- Typo fix in commit message and cover letter
- Link to v4: https://lore.kernel.org/r/20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com

Changes in v4:
- Readd CAP_BUFFERING and also add CAP_ALWAYS_ON to support backends
  that do not need explicit enable/disable
- Don't mix checks for eopnotsupp and caps. Prefer capability checking
  also for caps that map to single operation
- Move capability checking to top of call stack
- Revise iio_backend_has_caps to use bool signature and fixup semantics
- Amend documentation texts
- Add capability checks for axi-dac
- Drop two's complement patch from this series, already applied
- Link to v3: https://lore.kernel.org/r/20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com

Changes in v3:
- Reduce set of capabilities to only include calibration. The other
  ones propsed in V2 can be seen as subset of calibration, or single
  operation failing with opnotsupported
- Rename backends checking function
- Relocate caps field inside backend struct (pahole)
- Add kernel-docs
- Add capabilites for exisiting backend variants
- Link to v2: https://lore.kernel.org/r/20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com

Changes in v2:
- Added industrialio-backend capabilities feature
- Removed acceptance for fully optional backend, instead require atleast
  minimalistic backend to exist
- Switched to FIELD_MODIFY()
- Fixed kernel test robot reported failure for missing bitfield.h
- Link to v1: https://lore.kernel.org/r/20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com

---
Tomas Melin (6):
      iio: industrialio-backend: support backend capabilities
      iio: adc: adi-axi-adc: define supported iio-backend capabilities
      iio: dac: adi-axi-dac: define supported iio-backend capabilities
      iio: adc: sd_adc_modulator: define supported iio-backend capabilities
      iio: adc: ad9467: simplify device pointer in probe
      iio: adc: ad9467: check for backend capabilities

 drivers/iio/adc/ad9467.c           | 95 +++++++++++++++++++++++---------------
 drivers/iio/adc/adi-axi-adc.c      |  5 ++
 drivers/iio/adc/sd_adc_modulator.c |  1 +
 drivers/iio/dac/adi-axi-dac.c      |  2 +
 drivers/iio/industrialio-backend.c | 16 +++++++
 include/linux/iio/backend.h        | 24 ++++++++++
 6 files changed, 105 insertions(+), 38 deletions(-)
---
base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
change-id: 20251215-b4-ad9467-optional-backend-23f1099ee4d7

Best regards,
--  
Tomas Melin <tomas.melin@vaisala.com>

