Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C639CD00;
	Mon, 10 Aug 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374376; cv=fail; b=ObpTHGNraSrG8uxNSFSOQyHceWVgeEJ84hJPbNdXrpT2+VopI4U1FwmuXi3oq7rS2dnPY2UjeEJZzViPgmfQ8OZJb4f6HME0l+Mdzbt0nyqXmrNc8utB8BzJc3JdX1Rzi3gI1gvRP3i7Wh9k/2UJOPnCtrZ+9iBThkqhe3t1Ido=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374376; c=relaxed/simple;
	bh=3HghJ/9pBoAKSNsR9ZJkox3882nTasCVAjCxNoI4L1g=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=PsM+HpPl4zLESSSI1sItz6nQ3kmsMN2ftljWMADgE7sJ4nN3rc7esNC0zm5xchW8PGPHBCPVsuzX1Cjc9yjiOo5+/kI20oQvpNEgpyFgP/Zl3x+QdelpDTYxy3F+iZuYnSag0oqPut5naPRYUnXh9Yeh97odtzQMFAkU9AdIRsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ilzXO74B; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ilzXO74B"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACsJC01464309;
	Mon, 10 Aug 2026 11:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=VRCnAE0IIOJlXoVffYIh0CT8tLq
	MXth8Vbiu2ch7hUQ=; b=ilzXO74BPI9++KCoaSowdiicL6hD5hcvetLrOX+Yjax
	8b9h1V/AQtHOZJFIPJ39FZc+/UoveZBCnWRIqqArOtNli/U8aq+8ZkrJzWR4Tyko
	n6WmGtdoLcuNtIlgU4g0Qkamx9UYWCCweQRaZuu78AqhNE3HcZCrYEqg4e6kyJQk
	a9ypmPGfpzP4aZCihxgUbSxb2ny+8VrqbNhGqdycx69w6nOgqocqbneu2jzk1deZ
	XPhTsEjOSWawjGaXBGaEHVe2xoNcb7hr4sQ0AKdNLRKjQ6KuCuqPQYyezQS94RXi
	d6wlQp2xtEiB/5DHOj2eU37KK7PAk/sjX3UJQhVgR1A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fxjse5ast-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:05:41 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3emD70imhlFqmIVmXbjO+Aghj+d46UVR/IIgZlTZR8Og7GvdxjkXZU03G0/Iri4/1YwoyzOpV8hxravsXWy5vdEtqqG5+btAONtTYiZM8jJbnGP+WX55a9R+NRoJJ1yPIMhk1gYw1hqjwlmydggjfyUO7Xvx3kPvp8vvusEt6oW5WL8z4IPxz1FmrHo1FrxN6UJSlNVtZBG0gLNMoz+KfMy7LZVFXXFPvuzY0IkVG+V/RFjZUgvdNYfiXr1rpJG8BLFTK9plT6rpQL2gqobk9h8RBIMT5g6VnNGLGlEUd8tkkWSAIuDV1Jzw6TW2A9uU2BbdlSfOb0z6xmD1sZydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRCnAE0IIOJlXoVffYIh0CT8tLqMXth8Vbiu2ch7hUQ=;
 b=Albhb+rdm4Gr6VqCXeBeCT/a045vOGi/sDHtGkb4rRMw4afVUOO2OfSqVO8FEnBvHCo2jyxiY03EqmuR8f3OaywVVHePuePuhonN59eTwWq5RCeCmglVQQlTmNBmfnlrNnxwt34Bv/fuDlg4K4dVyKi1a1l5kNTuuWjrhPSghc9JRjeqXFBk0/aQ9aVovzB9iKWAT8fcQu19beAjmJMOvJ6qiUQP/7k6fh2rXnI7rto7Ip+s6HFGFoB8uCp1o6BECeFpd9AgUmkR/54g7/Qt5mrRl6LYf6vrD6egggUuCItzxEgmaW0SuqioK20PVAPwjWVG98vxppRWHFhz5yny5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS7PR03MB8170.namprd03.prod.outlook.com (2603:10b6:8:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:05:34 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:05:34 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2 0/9] dmaengine: Support bus widths of 32 bytes and above
Date: Mon, 10 Aug 2026 16:06:41 +0100
Message-Id: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr2K6toa2QsWV9zAshnaAqrSkBdQQ7
 i7FmLhk+SY/781EAnqDgZx3E/E4mmCcXYDvd0Q1YGukRi9MeMKzJGMp1S2grY1FGoauc76nT6P
 RxzttIdwDTQEU48dcIpdk8XQeK/NaG9fiy2Eob6j6KI6LxoTe+ff6xMji7tfLNvRGRhOqgQs4a
 VXKNLuAhYerD8q10b6qpEi2qoQUvGJVrnMF/6pinucPjV6a9TABAAA=
X-Change-ID: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786374404; l=3157;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=3HghJ/9pBoAKSNsR9ZJkox3882nTasCVAjCxNoI4L1g=;
 b=IdXnZ7X3kC2KGD4kV6V46pNw/mH5EkIufhTaLbwcz/ngHQ4lJw39Tg+ewPS6iZzD83fT6fvfS
 Mt/cWLP9t9HA5c7jon+K2n+5ETTg3dM7GZKo6xsmNKeZS4+8jH4EiQB
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA2P292CA0019.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::17)
 To SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS7PR03MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8b1fe1-a7b1-4779-65aa-08def6f0d3e9
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
 s0Bkqj63mDfGU1f21jy76UsoNOpl9j71KdiwXr5jQX5zAyUuwutBmnhgeyN7loZ06cXSsD+qNqa3wzM5EHsFU2O89t6E3nofXbFx6zG2Mn+QDaXKZGK3R+2qsvX8jYdJwum3D3YX3KdYY/6KHFUwt8aEtQ6koNbAZwnkptEZEx4VtpOEhyGQ1uoao3jWccloaAyQyWrCk219LfhwXSwsq/A5QWnN8yncZL0862o2YG50t9yUDzNheCx397gT5TFi7aAQanyLb3VJ75SquEOFiAA6gGdJa50hZhMLBn82IOirxx23h0jj3q0bjZzfYGqK+wczwIOhJ7ByJwPESIOJeBxBhe3Qd9tZInrt5o5bZz3Xj2reniWY1bKp/fusJEjVMapHH685+suMYIVdTYNBVPEsFcEK37fqiEn1yF0HsiVJMiJ5p31O1YPXB6Ac/cC5wanKFsbQAvODidcW4/ACEdjwkx2FTYT40CoZIvk26c0TTUIGfod1JhXgcFi85bE0fWIuxjW/p/UgFf5bUoC5QolCNDXJIxzRtqo88gRW3ur2PdHPp/abcr/jO7Gri3ewLGMdYjU0OJ2OVnui+9to+qGccK4StqS0j1GceLMKtDFWTF5vyR6LXMZBObIz0MZ26cjmPWa365tVsd2ertyCclgyMjMIDLxw3uL+aDgstwg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SHhKOWtNdUFZTktqcExYbXlsRENxWUZTRGRXcklsZDU1YnE4UURxV1JmcEZt?=
 =?utf-8?B?N3ovS3NndjBKNnhyUlNTdjBOSmlnN2RLaGJNcTdwd3ZmQ2VUUzRicVJrWEEr?=
 =?utf-8?B?YXU0Z1RHUldadXNGV2ZtSmQxOFFMZmkrUmU5eUVKdnJzWUhBdFdIUllkSlpC?=
 =?utf-8?B?WW1JTFBxK3lrZ2JaUlN1UnpjbmdBMW9RUm1Hd1hPZUlzaDJaU0lSejZvbDU5?=
 =?utf-8?B?cDBzcWJHQXZkSzg5T3lIMTBDd0RJcnJBZ2o3RHg3RGZndVBHZTJ4Vm50SzBz?=
 =?utf-8?B?aSs3aVI2bDhyWEtiYmpRYjU2NVVwaEU4U2JwVlBCcG1IUDY0TVJxZWRWQUlk?=
 =?utf-8?B?VkpqcXF0aVk3dXlpTWg5bXZrcEg1Yy9pYUdiU1pXWUlDZi80MUVPd20rSElV?=
 =?utf-8?B?dkdTS0QyVmVERzBzYU5aVXV1a0dhQWNCeUdxYXFVcVpzYTN6YTJJSXN1bHJ5?=
 =?utf-8?B?VDV6RXJ3QllsQkV1TUQwUW51UmQ4eTRMaXdsTDlmMDZpbHJMTlYyeWt0dERT?=
 =?utf-8?B?Ti8rU1BpT0FTR3Eyd1lTUzZRU1Vmd0NzYk5xMXdnTmV6VVUzZjVjSURWN2pq?=
 =?utf-8?B?dzZmZnBRKzVjYlNLc0J6NXZpQ216RXJVaW1NSzMzdWJzNExDRlFYbjlpSGs1?=
 =?utf-8?B?QTI4NXU4aytEQjNXZGYxUlNkdFVjY3hZSzNaeVVwRHl0dURQMVVEVGRTaG51?=
 =?utf-8?B?a09UQ1B1ZzJTdjNOaDlua3h2R1hQSW5oNzRjMGpCUDIwSlRGam1FMUxMemJ2?=
 =?utf-8?B?Y2swRENLdzJydFM2MlBTRDgrMGVwSUdrRmtBT1NCRy94WWR3dFMrSU51TGZl?=
 =?utf-8?B?T0IxakVkL0JnSjJ4YnJJalZSTHNTaG00clV4RXhJUFo3MytPbVM5MXhhNVVo?=
 =?utf-8?B?UXBwNHlGRmFhNkxoM2o0RDNrU3REdzZTVlU2S3AzdEpDZjdRbitiR1R0S1A1?=
 =?utf-8?B?bGVXKzZIMlNIcmpHZXFrT2VGVm1PbFZZU3R1QStFaEtlUVZPbEVKMjJGVVdW?=
 =?utf-8?B?VlloVUlFeUFwSU9oazRkTTBaanNRQ1MzQkUzMXZJUExqS0N3V1ZSZ0JoanM4?=
 =?utf-8?B?ZExxWDFtMjRDV2w3a205NEh5dFptcG1JTVRTeE9FUG9IMFBGUFBld2RkWVFr?=
 =?utf-8?B?Mk42bTE1YmJDbnZhS1c1bko4bW5nODQ5b0hUY1c5SXBHR1djT3c2cFZaT1pi?=
 =?utf-8?B?Rk0wNmp6MVR3d3VSaWpEWnZmd1VZb3dTNkRVUWVvMjE4V1YzczlsdTNRRDBM?=
 =?utf-8?B?bHhmNkR0L2QxSXVMTnN3VjBoTEh1TWNKRFhEZ1lwdEVSR0dXS1lnVG1uczNu?=
 =?utf-8?B?OWtFdWk0OTB0SVZjMGpSa1pFUVhNVWJ3TDBzNFlZL2wrbkFka3NoMVFMTlhD?=
 =?utf-8?B?ZngyeW9VNitvdS9KQ2c5UUJNVFlDcGliTkhPY2ZsZGtOT2dabjVJaVJGUHhZ?=
 =?utf-8?B?MldReGNmYjVUUzhmb2JsU0lxdjhYM1F3cVQ0cEg0dDV3cHBxbmpyY0JwOXE3?=
 =?utf-8?B?Tzk5enFyTmx1MjkzTkRpRzNaZ016c0Z5S01VelNFTlBEbjEyUmMvOERWRWVX?=
 =?utf-8?B?bDRGbi96K0c0SGs5eThacjJRYkVDaHBReVZWYXFyT2UrZGFpMkIvRW8zemhy?=
 =?utf-8?B?NEQyRUJMSDY0eFFYblJ5dC8yTzdRRGdlNSt0L1J1czNWYkFlMEhtMXBZM1JP?=
 =?utf-8?B?OEgyTnh1SElvY2JnUnpwME9UV1FuM2MxdXZiUEJLa3pWelN5UDNMN2Y1L2NT?=
 =?utf-8?B?RE9TSVJqbHRyVXg0d2tVaWRvRkVPNExXMmpSTXFaMDAweG1ybWdsZnhRTndn?=
 =?utf-8?B?d2NzVUY2eFBwODMzZ1BBVWpXT3dwZVdpT3JWY0JsbGlSOWcxRE1BVFN2L25l?=
 =?utf-8?B?Ly9tY1pDTmhjMjdvMldRN0J1c010ek9pL2JBZnp4OFgvamJ4eFdDekc3WlBv?=
 =?utf-8?B?SXlnZEE2WlM2MUoxU1FkZmNjMXhFQ0E5VFBmODVEUkhHeWhCdkRJYUNYVUpt?=
 =?utf-8?B?LzZvek9wU0FtR0lVcjFTcWw0NEJTNVdmWFpOMXlRMUE0TGxWS1IzZzVlQ1lw?=
 =?utf-8?B?L3pxWWdrTDlMeURnR1RWQmNBdDJSVmloL2hRaEYvaVpKQ25yRFNXQXVHdWVm?=
 =?utf-8?B?QnpscjEvOEtsWDNMV1BQVG1WbytpUEZ2QXNZWTFnV3lxTDVldTdKWXZGOHVC?=
 =?utf-8?B?RXk0MG5MMy8rdkQrZ3JFdEUxRXN3cnV4VnVYTUdESlJackZWcVczOEZhTXNu?=
 =?utf-8?B?UlhnOHhyVmdMQk85bTczc0F4Y3BzajdvVnB3WnVmdFI0S1U5YlFOMFZUMS9X?=
 =?utf-8?B?clFkQVNwcGJnMVRzb011UnpGMjkrOUZvOGNqSi9pRW00UVR2ZkViZz09?=
X-Exchange-RoutingPolicyChecked:
	poCO70EyS+D0Im69rdVI76Y6uaKx7yunFJCXpIRc7jL3az3SYncndR2OqWeyp6jMS/FVZzrfIiH3vgS2yVjseF5TF/WtlgaID8exY1lFdu+YR2vfkvXmVXSkyy448AyM8vRSRop9F62yYuj0Iz7XC10eLC4gf2pwHUiFmD4/U5Di5NdOpMW2E7yUhsYSTdwYd0W9bnQohNkblKf40rdg9YeZjDfwrq6lqC/zY+q+H23kyRBT643KLfCAKQWTx2kLjVfHA3Wif19kpgjypOSFrORjrhu77N2FU2LQT6nm6j0JNMAjKU3uBN/azXJQPUz3L4b/5aLrJ5HsGnGXp9S4MQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8b1fe1-a7b1-4779-65aa-08def6f0d3e9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:05:34.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJ8WvKYobUC8kKeD5H6qh7HWQ9fNaG2GK7TwcS6AltCZ6UufDtpJ0TKjkXxAXrrjP6FbB6N5VyVgY7GTuZNmfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8170
X-Proofpoint-ORIG-GUID: nrEoVOBh2GCj_wxbA2-xyb_TS99-AUYo
X-Proofpoint-GUID: nrEoVOBh2GCj_wxbA2-xyb_TS99-AUYo
X-Authority-Analysis: v=2.4 cv=MLBQXsZl c=1 sm=1 tr=0 ts=6a79e8c5 cx=c_pps
 a=1PMvcOD3Mx+UKTR1GZf1Bw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=gAnH3GRIAAAA:8 a=lWmi8EHbcr2KEopbcr8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfX0AadYFecdirq
 4ydagKznNfIUZzK56LJqnIZ/vWRGr8q+DLhZsX4ZYTjTCeBa0o1iRfLJhM5z46pS0zojHd+qIwj
 5rcszsD8+MtDP7u4WxsuDbbLlIeZEtWEGNmVnXQss9GHAFJWheifYn8YdV+fPWL23VwKC0gKPXT
 ysfrMBRUY7u+APaErHj9FIQPY95FELZ6Gg1YGO769ZbV9Y9pob8DLIISoSPUvOE9vaDdewcoN9M
 7fVM280USzyMv49toJfqeqF+q9NI0xnGOCM/oHdQBct8Z//ZiKiV3zPEVjziWNiGJ8XCTCzopVF
 uQ+dxGkUgV5fIv6qVOcVpCrtzmK4NADYIMAVMfxWZyVVQPkBkJde3LsD2mp+EBB7zXlF0boYqFC
 CeLS3PGy1ixWDZIdOHikoo/LYZzEfdLdOUubsrlU0gMvKT8qaR3bjX4XCIyORoIoIRDUqRf80zq
 Bi4NOBfBGe77KpqhODQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfX/1BrivB/phdK
 eAqca+tuYYEmzBB+aHdRsD2xTsxyWgsYkeIPu0L2VtZ+uyglMwMblXNwhVpB+uLtr6tILu2bdmR
 yrWaLwP0kHUXQmckxevVHQlYYbkPimidYZ2hd8XOAhnJ+nBQBXMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100130

The DMA engine slave capabilities advertise the supported source and
destination bus widths through src_addr_widths / dst_addr_widths. These
are plain u32 bitmasks where a set bit's position equals the
corresponding enum dma_slave_buswidth value, e.g.
DMA_SLAVE_BUSWIDTH_4_BYTES sets bit 4.

The consequence is that widths of 32 bytes and above cannot be
represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
32, 64 and 128, which do not fit in a u32. Hardware with wider data
paths is becoming common, so add a representation that can express these
widths while still using enum dma_slave_buswidth.

This series switches consumers and a small set of producers to bitmap
based bus width capabilities. The legacy dma_device u32 fields are kept
for now so the remaining DMA controller drivers can be converted
incrementally. dma_get_slave_caps() folds legacy producer masks into the
new bitmap representation returned to consumers.

Once the remaining producers are converted, the legacy dma_device
src/dst_addr_widths fields can be removed as a final cleanup.

This issue was discussed before here:

https://lore.kernel.org/dmaengine/abkoXXbaxaiqbBuX@vaman/

---
Changes in v2:
- Patch 5:
  - Goto the error label instead of directly returning so the clock is
    disabled if setting the bus width capabilities fails.
- Patch 9:
  - Improve the commit message to make it explicit that only the
    struct dma_slave_caps legacy fields are removed and that the
    struct dma_device ones are kept until all the DMA controller drivers
    are converted.
- Link to v1: https://patch.msgid.link/20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com

---
Nuno Sá (9):
      dmaengine: Support bus widths of 32 bytes and above
      dmaengine: dma-axi-dmac: Use bus width capability helpers
      dmaengine: dw-axi-dmac: Use bus width capability helpers
      dmaengine: qcom: gpi: Use bus width capability helpers
      dmaengine: stm32-dma3: Use bus width capability helpers
      iio: buffer-dmaengine: Use dma_slave_caps bus width accessors
      ALSA: pcm_dmaengine: Use dma_slave_caps bus width helpers
      spi: dw: Use dma_slave_caps bus width helpers
      dmaengine: Drop legacy bus width fields from dma_slave_caps

 drivers/dma/dma-axi-dmac.c                         |  13 +-
 drivers/dma/dmaengine.c                            |  20 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  39 ++--
 drivers/dma/qcom/gpi.c                             |  11 +-
 drivers/dma/stm32/stm32-dma3.c                     |  32 +--
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  15 +-
 drivers/spi/spi-dw-dma.c                           |   6 +-
 drivers/spi/spi-dw.h                               |   3 +-
 include/linux/dmaengine.h                          | 234 ++++++++++++++++++++-
 sound/core/pcm_dmaengine.c                         |  14 +-
 10 files changed, 323 insertions(+), 64 deletions(-)
---
base-commit: 0613e7934ee233d726af8d8c89f251a1c4df738d
change-id: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
--

Thanks!
- Nuno Sá

