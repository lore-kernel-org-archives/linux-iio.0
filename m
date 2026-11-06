Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793992431;
	b=w83/czXg9UVR0h6bZ1fmra/nDy5CGLOYVdyiXjmI8aBR+iiWSUKae4E+bvqw6GMZlLF+
	 d7K2UGNvdZz9NoyOiu/z9IhTPAyjM3jVsejsAG3wANRC8h8USa7LejbpntQgwrLY3g7x4
	 STbibyexxRPhQLwM60WDx9KN3u4ZByWSB9L06g4TyqbEGpm7ravwuYmsIVldHnAH3aDjb
	 3YVoxSMZHUjI6ZK6IS6gmNnJOnlMHcSlVptyXhwi/4NHGIme2aiW1tNpkdLeV/rG/yaz8
	 w7xs/hGe4l8RAEJsSLNe+L/swZeOXXUBTHZ4PJXi/S3wIV5XQQz82pDcEWRHvN7lFvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992431;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=oMaVdPTjsHiils8DUp9wTRkIGFjO3puDAsEO21JsW+4=;
	b=nARhcFGX0tFpEte2O8eduD9cctIv+lCgt/bGJjxlR6h6S5XFwb8HJ0An8ooCV1WP5Ktg
	 hDGurvtfUme5TtwDlrFs5gqUketW3dvY7j3CHUG64/7IZadU9eWBtjJhlt0NEyd/eW11C
	 0ufZvoEU1DZarOXJ4uFLmkL4ymaL3+bF0pTTieoQqmKGvNJTj1lIfQu0M1fcvc8pPFbCy
	 UcFC+bMHcpH00tdIGpe7SLXgKqzQ4I/uKBFXPzmmgXkmgLDprvZ8keqOkEBkokf44n2D4
	 olohnmKbfZTkYAf98Zfed0OXeQ/lbGmePkSA8NxYSdk3URkN2j3ocrhTTrW6F3bfJRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="m0U/pXPo";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.22
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010022.outbound.protection.outlook.com [52.103.2.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BED606A326;
	Fri,  6 Nov 2026 19:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89BED606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=m0U/pXPo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtVaC1zFS9Qt/gMLP7jhoMFc0HIRshRm5qQqu7b6Wp8mbbyogCqDNlpB8xEm6VmtwFWulIljyHbXvywRP42QOr4E8tUYLEIQsuK7i1peXcflmyhsZqObH2ReLmZrZMvouXDc2VNO+91r2FLcMcLN4A1oFUtwiJxGs0Oqe9bIXlWh2eKWTKDp//MpMh+eA4CiTjMGac1K00aTfU6UvFfqTgImJbz+IUq/640wiPsEio7qs+R02DBx77hz7Uuf6WHFTbphVBjTlay2fBIXMdjmZHIFIj50d4uru01IBX7O/n93pjsCPDR8I1MbOlj6rHzzetlpxW068zg2VLozJmcBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMaVdPTjsHiils8DUp9wTRkIGFjO3puDAsEO21JsW+4=;
 b=xxFdVXHenB4AO3fO4IoDNg8QfxK3ra4I+EdYidGptgJc7EsgMD0pVCb6tJEjYS1CT74SfvYqBvhvvtF2PtAKf1JQfkbYWnEn4aJe8/nq11i2STYqxQuXUt3lvFjPbEynMaXb+r5YsS2dNgUpD5HZlWN0xLQUpN358LlLhGrBaV6UaByDeHh7rrCACEBnXpcEZxejkZRrq13jZ83ArZiwpo2dPpgRMPTgSuCCQOX69o+TBVnGAlOeMiBT5QBWQcb1oC/3OYl3lpANyMkvN9bjsDMo5Nzib7hLEsJOdt/L6ObBnPG27HIFIyw3sQ39Co+pHSH5qYRPqRGHFLQWq4EPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMaVdPTjsHiils8DUp9wTRkIGFjO3puDAsEO21JsW+4=;
 b=m0U/pXPo5S4/leykH7rAr4tY8yO7Flt0v4wwl9omCB8ZKZdDEonV8GEtuGK4poHf1BAxZmuIck3aZeugcWlCxatZBOMZMKvGgKYKeN2/mzLx/rI0ToVRUhfyx3Aaa2s2H2hZosrW++Ho4z2iKLhhKSUbfzXkiizw6lUrjzOKMgfJH2mP9FKyFYrK9UnYv+rrAjcVTmFTwdH2+ktocczQboP1u9VE8kb3AoZJ/oJEhJTItXQYyB+qu8QxjFTni3NKnDxojblG5auA51oNyTpEVZLLNgeoDTwvm+c9MLALjznJQT5EDdNprCd8demNLeeYdoVopZeCfFmTtYItse+OWA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 19:13:47 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 19:13:46 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: viral8854@gmail.com
Cc: andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	robh@kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: Re: [PATCH 2/2] iio: magnetometer: add Infineon TLE493D-W2B6 driver
Date: Fri,  6 Nov 2026 13:13:35 -0600
Message-ID:
 <SN1PR12MB25289B6D8FD76DE3160299B5A5762@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105-tle493d-v1-2-3246e91e6394@gmail.com>
References: <20261105-tle493d-v1-2-3246e91e6394@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:610:b1::17) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261106191335.813304-1-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 5377405a-3f9b-4d2e-bc6e-08df3c3a149f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|39105399006|8060799015|15080799012|24021099003|22091999003|19110799012|23021999003|5072599009|24121999003|22121099003|25010399006|260925184616899003|4140399003|440099028|3412199025|10035399007|40105399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R30Da6bu7aYvH8CvlKgvRv2YR9aGw5bYDmDjrADch0QLmXRo7gzrcoJFS3dZ?=
 =?us-ascii?Q?KLxdTv0dkWcPa/0rbPDavjaPvC0ORHozvfihjJ2X2IYDDIpNyD51LFKpa6vl?=
 =?us-ascii?Q?xYgmaLXdZuyijkb0/ngNYJrqITDLCbFYkbMGnsLWOTBDj4ctOz+zGjL+5zpz?=
 =?us-ascii?Q?+BnyJjsQnJU9go98w2P4AYqnacHmzJlLUx/pinEFEETVQEX6NUCvYwQWnQNU?=
 =?us-ascii?Q?4waaemgVHavjXxNEFrsnn/dIW2UeHnuwxPQC1Zxz6xvdscNzUSpSQ77BaREH?=
 =?us-ascii?Q?BZXqLAPNYj5U3vcHZsSyM6Q2slXDKK4GoSUgyN3F7pLEFI0++zIcItFajkSl?=
 =?us-ascii?Q?uuW8d6Iv2HHlaLhjGLNW8nU2ZVNa0gCRO0ldUGsYckFO0v+IZJn/p3bmyNT7?=
 =?us-ascii?Q?g9cBZ2W/gkSkw58xxuichU/SaYrXqQxS4medRLFhdGjQJuHFaWxa99ujFu9Y?=
 =?us-ascii?Q?dCkK2NnkONBE08Z44DUQJ+EBbl0UdS9t1D+zo/7FyBuPFo3MafNdokujwOpc?=
 =?us-ascii?Q?d0oexhdQK/pP7bQNallXEGcS8wK8CHSc8bj1ujoHKDo87bgS/xAQWvYBRRJI?=
 =?us-ascii?Q?DNGtkOi+b3fCvskeQ5hIYYG1Qai0iBu5aFMKSxJJLcOBjhlbWqFF+oaqXhy2?=
 =?us-ascii?Q?XchZANeZyRSn7s5QCJ9qm46rHUxCYNwQ3YOEgF9VeSIinP6AFC4wCUJkTV7C?=
 =?us-ascii?Q?TsC7r0txG797l+dmcnnOyvJJIHBMddf2JrlOLFneucerr7SUqO6XLB0Y0fPA?=
 =?us-ascii?Q?4XDjKu+W3lJCkLvMqtPN3njeWHpxTIQG57NkcmafNfbA/ABVBfXWH/lEIZls?=
 =?us-ascii?Q?Mwz5n8AW15IYQLWWcvFei8ir4C83v4cKUu4DNc9deaVkiV0Hy9uPy1ivVyNe?=
 =?us-ascii?Q?n6QEkpcJSQvCT14HbzYPYH7jWq+IkQWjst+oTrwRIIwPA75jGudi7vk+cWMC?=
 =?us-ascii?Q?sGcvLxNVI5Zx/aX1ocYulHe2PuW69lFl7WUYP4VFLWvCEvPKFnHqJ4lX7bRN?=
 =?us-ascii?Q?KS9CIlBFf9C6SmZLmou2aseqZeeZwlSTBnlJS1fGRAxZS2fakADVID9/HLse?=
 =?us-ascii?Q?wFbZTZ167Cv27LpiEO2R7wAVdl1EnA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tuJe8MwY3h9j0XgjjQ9dEK8siGstEhl9IaQtpNMnYZ93VY8CXXSqoT/VRSOO?=
 =?us-ascii?Q?iL9oUyVHVlglcrZG6k/oR6nUR05D32g6n5tjYrl2qOMQlnWBTEKNde/Vchvb?=
 =?us-ascii?Q?4j0XKd4awl+b6P4oKVsNryrCdecDBSdR/Hgsmz2aWlst1kUMh8ypfVZZi+xe?=
 =?us-ascii?Q?HK11etDIHy92qoLdd03qmKwyTBKi+fc2yb7zzFkM1xH3WnBKpttAvNtWqdrv?=
 =?us-ascii?Q?K0QQ/y/HDZcem5pbuHhr7vi5UCLY4UYiSWPcpGsRkWls9SWJz5LMnTfPimoS?=
 =?us-ascii?Q?kXzuYaeJDNIxAyJ0O8wgWq/7btRz3b2298CvPK/9DFsN0fBqMjiP9LUOPQzZ?=
 =?us-ascii?Q?jRWoFygSU3Mlclc29n+iT+DrECnjKYAKwkmtEj0gVVyuJm1QCo2rhfboQ4OC?=
 =?us-ascii?Q?q5SmAuE2O9CyRbYlZ3AgVrJjLvcnakKdA8MUGt695Eg55fXzqordWrXSrtls?=
 =?us-ascii?Q?/VZFSL8OCN/SUoYm+sr5loNn8LlhPSfODseYqyviiYrqCacWIk09JOhuOMyk?=
 =?us-ascii?Q?n90KhxE3qarZw17ZhNSdhMPAX2SBRYMLnzECvIXPHDHilmgbZuNk6WAd/xic?=
 =?us-ascii?Q?CqLMJ9PQ9Avs8L5efS979e5LgLL2rCEP9kRDLLHwlbMtiK3F+RV8/ABA0zeP?=
 =?us-ascii?Q?/sBbemnhXsAPC47EYoQLGpltuq1ojVymHX7uHIj9UvI3XK/uW5hXZT2BLZNJ?=
 =?us-ascii?Q?miuo7FYFh+nXB6MfEFmtSBhQSvRhBU6V05BvKT7U8i443kAPCEbrVrjJgSBG?=
 =?us-ascii?Q?B0h77vpiIts12toFv9n81qoib/sckLy+8M38A0gd9Rbl0F/GQyAE8cDcVwHD?=
 =?us-ascii?Q?6J4EVu26BzV1yHlHTdeBEyyMGaz7M0jpdMu64zNpWqGgN5j/QADw6dOn3CNZ?=
 =?us-ascii?Q?Mw301X5aOUw01Er/WbWsxR8ZZ8w1FoRXXeBmxyX5gleSEZbZafo3g39hfPLZ?=
 =?us-ascii?Q?1ievhJNhXKUI4UU8gCXvdurBUkTwzYrv9LKlsmt505+225xUhFoPJdqm5Zgr?=
 =?us-ascii?Q?8DqbwPBEeBJBPDst95AyNWXb13sdEKtkWqKtArium+yVebykalRXvmbZEoUI?=
 =?us-ascii?Q?biIwJrWtl4vjbDQgiwaRLahdqxjpSXZxmP3f3G7UYSBVW3BfPh6yfljl1eTe?=
 =?us-ascii?Q?TSNydgxfp7qiJccNB5HYpBJrOv0WBcQvRVoxS09XFGgfuTO1pz1liZrFfmUq?=
 =?us-ascii?Q?wlHNzqPynTHSZkhd0kz3Ww5OYJo+f3CZHm01SLzbaNdElIumh/7kdYMH0sBo?=
 =?us-ascii?Q?mKq6kalY0S4WPuWyOomaPemBWdGLikIDz0YrocM75H3/IlToCGkmQTBi8rqT?=
 =?us-ascii?Q?/VIvBAh62zcmJDXc9nVOXbt4uv7i1x3dv3jYjeLG0INip0epIXvpsiOUboef?=
 =?us-ascii?Q?k3yfKuXiMC9zsjVDQcH8q+1sfrv7aNAKmbrepb4sDOYNwH7YOQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5377405a-3f9b-4d2e-bc6e-08df3c3a149f
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:13:46.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167

> Based on the TLE493D-W2B6 User Manual v1.11 and Datasheet v1.2.
> 
> Datasheet: https://www.infineon.com/assets/row/public/documents/30/49/infineon-tle493d-w2b6-datasheet-en.pdf
> Signed-off-by: Viral Patel <viral8854@gmail.com>

You should link to the user manual too, since that's where most of
the information relevant to programming the driver is.
I see that it's not available from the Infineon website without a login,
but it's easy to find elsewhere:

https://assets.sourcengine.com/datasheets/c9ebe749-34ab-4924-ab2b-aa7d4dd15e25.pdf

> +/* I2C addresses selected by IICadr, i.e. the default of variants A0 to A3 */
> +static const u8 tle493d_i2c_addrs[] = { 0x35, 0x22, 0x78, 0x44 };
> +

The manual seems to list these addresses as 0x6A, 0x44, 0xF0, 0x88 (Table 4,
p. 14). Can you explain how you go from those values to the ones in
the code?

