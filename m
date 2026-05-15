Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D523F54C8;
	Fri, 15 May 2026 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836847; cv=fail; b=I84ED5TGSUM9ZsBOL6dhQSoIixoQl6m3cQxN97eCVe4dDBbrwpwTphvVQElMWWufS3vJkVHLXcmVvP4pcMhFiPzjyoSuiDZRaFhTzUPHBwovkw4rEKqan4fLr7qg1bo0YMrFRfn+3fWvtbkuK5b2OqwdFEHa+FG0g58oBTbJnKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836847; c=relaxed/simple;
	bh=jEM9Q7IFnUjQpnpb23c+NsQA9urRNo4H6pJTYXfwd94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b9OgntFRfg9iiyxOoT/ZxfoS/BAoUF117xA39uabLS4ZSNn7Y4MbR9OcnIp9NJx0ZGa+Mg02B7n53vAahL3ZmsnFEsSIb/gQiIdd1/hrhrpyawZNj79BwsnIFYM894tWe7KFtB6fyK+CtW/Xlu9JdKVue7xbURuzg0n73zgpHHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ejirYsgj; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ejirYsgj"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F7eFOB2162018;
	Fri, 15 May 2026 05:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jEM9Q
	7IFnUjQpnpb23c+NsQA9urRNo4H6pJTYXfwd94=; b=ejirYsgjDJHiFshBc6BzV
	L1lFUCVFkL5MeoU0wxxsrWyROjXmq8UTI44BW8rKor2VIM1RbSAIgLHjemqnSokW
	uJknks1YyJHMQ8TY+sHrwGH5Tg97qY5FrMWTOmq1rDmowEOxi5KA2l83Cj+FFUTe
	ussTSqmF+EZCS3x6c1pGWrhIk7K4urT3qF+7/0bFzJcDnahaLYOMzA9BNlc/uIEF
	g03CZrZKuIoHMP0LpSaIe8HaR7s9Lvs9cEVE1DlZqznKAmi0SVgS9DtQ7vk+eosF
	EPOM0ijh0FSlxedz/FyUTxq1ad3kVAZzAbDbvzgJp2IrsX94V7AshM4QmpBVL/a+
	A==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e5m2xjett-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 05:20:30 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5CyTg3qYZhtlatK1+ZraH63eWPU/2UDJXbf/paBmjC/ZonVofs3ZnF7oqcVRlQhrmyAwu90X2kK97SMHul2l4xutPDssxCikE1aZr+aQTh2bycEIupgxAVQKjsqp3FkLXUYZGXcUiDUBH7jL/TMszu3jes4pp1PhG94U9epTYMqqhuAqCK1FHXQPnySp/efgiODKq1+fmkSwpQSlxePaZkfsdrYVX0n6w1tRO+bkglS6KNyjg+4JYKpXSlgaAAJvTBGMXYJA6oCDXHx5/qytwS61vvHk3U8MOUxYUCjURy0BGg5UuGvK13fUShimOLzbwOgBuywiPu85eX3s1/f6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEM9Q7IFnUjQpnpb23c+NsQA9urRNo4H6pJTYXfwd94=;
 b=f6/yQWuCX5+nQuIKmLc3z0BFtXaWLtb+0LElqaXil4eU/hLI8rrRCWXH4wDHGe1vZQvorPsrfl9n3doLaaBN1fH5Cvlz2BGBdmfZ8EhSfahceG/bikP4LdbgiIAnWH/A14k9eqC32XCRB3ovxa6RULqmXEj1H8Q3l3tQleBrv9MxutLR7dHwY0X9fEG9vhmSreNpwZVb0+PfjLkjwPyoniBqXYqaFnqtUZMSM72I0HJ+0KEluzEz7rsF4iRATUBa20ficC8oP6hivEOZxubmVSmJbgUjBLepHXzaGd6BEyE+2D5PbZbuKYCpqFEr0hocwp71Y/AtGv85txHj8w8rzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SJ0PR03MB6376.namprd03.prod.outlook.com (2603:10b6:a03:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 09:20:26 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 09:20:26 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Radu Sabau via B4 Relay
	<devnull+radu.sabau.analog.com@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZSBLw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Thread-Topic: [PATCH v2] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Thread-Index: AQHc3inmJrOqLx0RyUyaZwFfTl+ZmrYKRGEAgAL6q1CAAGhWAIABLIPA
Date: Fri, 15 May 2026 09:20:26 +0000
Message-ID:
 <LV9PR03MB8414852B21F8B66AF821055CF7042@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260507-ad_sigma_delta-fix-v2-1-ec86eb0463bd@analog.com>
 <20260512121326.189817b8@jic23-huawei>
 <LV9PR03MB84148EC966F80CB723325B46F7072@LV9PR03MB8414.namprd03.prod.outlook.com>
 <e17532c6-3568-4c9a-9d6f-64af7e4736ba@baylibre.com>
In-Reply-To: <e17532c6-3568-4c9a-9d6f-64af7e4736ba@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SJ0PR03MB6376:EE_
x-ms-office365-filtering-correlation-id: 9c03c08b-7eb8-4c16-ee79-08deb2633339
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|4143699003|38070700021|18002099003|22082099003|56012099003|11063799003;
x-microsoft-antispam-message-info:
 wJVO+1uIn3dd/5GqUAtQJLswXsv95m3i9R1PQ8leHphk8Ee+QDub+752YAL1CtgYOoX9Rewy5Qd7woqj49r+LfZizJZkH9d37pJU9vfhrJ+wUToTFT/vebaM0TIja9BJHbPvGyXdSHIihUizFu3hFx4GCywRiyGOk1i6R9au+KGTrhbRJ+OOeR34guP8Yzoj3RnMVT0UzazgWKD3SGs2Ahzl3lyzVv4M3+yT6XHFdyYyROACremSu917oRZEMB5K55+G+RLhBPfqIK6fAIoOH+QIw0wt9QPWAT6hiKE16fDbe+NrMsvaWTzAUGzzOafBRE6ZmfNK13/6t/DXhKvxm8QR7pSqkCpEekE4GSISW1HdT0XCBrINVDxwk8xB5OLLCA0yPsEkwStPtXnlHZS/X61aQlT/hZP5BstDJxYE29D5PxVpuTv/UJCHadSeif8B5fO4VCp33q4M2+h8n1mVaQJUCbhAj2X+LsKXj7Gp7Jamy32zE0PyHjwGJGYlxxBCPuTXVvT4cCvjaZnya0KB9Mqkw7NFCr0junMCkPSTbLG22VjUgbEjXZNmYt2bHcHhiqtn6++FeGpYwAOp8wxMijCGZN+CzCgq5+PKDyf+tFRyz8z7bZMYzRtR4uuVdAHYEkOFfgQgT2TIPahFnUKBunnqWoktE4RjrcsmUiFv1JmH7hJZGco8U4npoij+atC3Ei/UPwOmhuHoTs/8G4X4tphTbeSWYldZl+qjmphkyfKAIujdYwxCPLOVVO3KATDs
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4143699003)(38070700021)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnNWUHhKeXpTZEVrOHRFKzloVkUrQjZ6T1k0a091OWRuYkU3dUM3TUJoRmtj?=
 =?utf-8?B?QllCUUYwdWdUWWgyOGx2bUR0VkkvOVpOS0hPbS80V1dPMzZHZThjZjZHVGti?=
 =?utf-8?B?V1dSRTVxa2x4Y0l5RkRzNld3NUpmd0pMYUx6S2xxSVQ1U0NBSnBqNEJubmNI?=
 =?utf-8?B?ZzJZWms2cVpjSjZoamxDSjZSeUxRS0lyODIwWkgyazZwaDdPeWNNVFpLQnds?=
 =?utf-8?B?cktpNERhS0NxR1BNVmdxMlprZ0xwQzY2SGF3M1g3djdGSlR4M2QvQ0NFQS9M?=
 =?utf-8?B?V3lLbk1zbVN4d1B5bmdTQ0dkZ1ZJNEFIZ090c3F4aDR0aHpVTlg0ejZWT2lR?=
 =?utf-8?B?R2RvVnNFTjVGYVpueVpRSnNnbXd0dW0zbVRoWGVubUc5eEJ6WmpNZklYS2dI?=
 =?utf-8?B?WVkrNFlXN3hEVFRMa2dnWmErSDRSK3BPNlovc1JOUUZsRmZ6OTlJbDdCOTlr?=
 =?utf-8?B?c1hNeFZobkhYNFl3U2xBV3ViWGoyeFhhY3Y4THVkVlIxbVF0Ri9sZUlYdVpG?=
 =?utf-8?B?R0hnYkdWUWJwU000SGJaV3RZSlMxY29qMktxM2NqaGxQVGIzbCtpVU5iQkJT?=
 =?utf-8?B?cmtBcGhXT3JQWlIwZ2dXU21hdnEySVdoZkNPQksrUW92MkQ0dEpNUlViS0hP?=
 =?utf-8?B?Z1MxcDE0QVdlZ053R0xnZW11SmFNU2VYRmYzY05LTmkwaHAzZ1lQREJJNEdw?=
 =?utf-8?B?QjhscTBtbzN5M29NTnhERVZoRVBwb1BrZ1h4djVydDE1ZVFTU3gyS3phS1du?=
 =?utf-8?B?a3FMVkdpNWt0b2JpV3JtblFmeCtibjI2Uysrd2szTG0rSXY0dkRRcWFMdkti?=
 =?utf-8?B?S29rMUZRelBWYU16aU9KNFhINTRxNUZiNERMclM2K2h5Z3VmcURST0VMZklJ?=
 =?utf-8?B?NkRvWWdoZjhIanp2U0trZ3VudVpTU09TYlh3MHFScUpIK0wxbTFaVEgxM2Nk?=
 =?utf-8?B?STluTkk5aDJyZUpIQzBZdWcvanZkL0NON3BiMGF0T0RKdE5maDdFeDhVaFZE?=
 =?utf-8?B?V0ZaSlZkOHdOdnhaMEIrYXVtZWdjV2FLN1Y0dngrMHNOTy9Gc1BGMXlTQ3ZD?=
 =?utf-8?B?enArNFgxU1hXbnloaDNHemVVRVNxWmxPUXltUE5IS3F0bnl5RmVHNjl4VnJi?=
 =?utf-8?B?YWQrY2txajJpNUlFaURmd0Z2RUZncUFRVEpqWExFcm5EWlVxT3ZyMGxlbmNi?=
 =?utf-8?B?Z3A5bFJTY3EzUjF6MHVCbGhaeWdmZTVSMmpVa2VMRHY4dm51Y2pjK1YzWDhl?=
 =?utf-8?B?VGxZUnVCbjd6Z3VjNXVuVWJrZmc5dEVkR3E0VG5qZmZ5VDBpaEhQNVNzKzZO?=
 =?utf-8?B?MVJ4Qm1uZjk0TkdSc2FQbjhuUlB4QlhTWmFUbzhqWk5xZGxjaUZlbFBaQmdJ?=
 =?utf-8?B?VW1jT2dtSTFtWmFXc0d4WFZJZThpUlBEdG5jYnlHMXkyY3o2MHpMdVdjNzJr?=
 =?utf-8?B?akx3cEZETWNERllKYlFucWFWL0t3TW9WcXovT3FudTNJdldqZ0hkL21yRHRY?=
 =?utf-8?B?aDBSZnhUcmtXYVRLVFNvcmxyL2I1bUZOTUtrdHJGYnNZaWprVTRFYnFxVDls?=
 =?utf-8?B?Tm95RjliQTZZY0V4MzRjejQxSVNxMVlJOUxKZjg3aXpZZ2w5MlBKbUN6NE5Y?=
 =?utf-8?B?MTM4ZGpWVXE5QmJZdDVKeW9QOVQ2R0U5MFljRkgvMEV6MElOSTRHektpVWln?=
 =?utf-8?B?R2RDclMyZGtKdTVwc2Y1SVlmUk1yeWdLcVFuZnRLUll1cUh3QWdyL3hjVE9O?=
 =?utf-8?B?QklUeWtkTGlGelNqSE5maDlpeXdiZE14OGtYZjIrRFE3MFE2ZGhUR3NWQm93?=
 =?utf-8?B?ekpDWXJnOFRiRG9KWXZueGVWaTZVUXZLNzBRTmwrdlc0UExzeVNIUmRjSHBl?=
 =?utf-8?B?R3c4bnk2KzNZd0t6VkZxeThTN0lmZlJqQmVGOFhWdU1LRkt2VUdrZ0NFTUda?=
 =?utf-8?B?WUlOcEJTYWFEWHpFVncwa0VFc1FtbWxNVWRjTXcyYjlXd2VrdWxmZ3NIbTg5?=
 =?utf-8?B?SFhTS3BzbWJpcE1IblljNG1JQ2l6QmdKa3g2eEVjK0d1YWp6WC9WaFdmbWRC?=
 =?utf-8?B?K3V3UnNqaFppRGE4b2dkNG50L2YxMUZuMFRFdXVveXQvcy9DVDEzbTE2QXBN?=
 =?utf-8?B?dUlDZ3ZOOFQzNGhzVFQzU0h0TDhieGp5bVlUU2crTzMxTzQ2dGVWNXJ0NmtX?=
 =?utf-8?B?UEVUL29mMW1aeTJPWEU0cnU2TU4zYmZualA0UlI1d0hXdm1PUEd2LzZGVW9P?=
 =?utf-8?B?YVhaZlhYTTJ4ZHNpK3ZSVFY4VU5wQXZHdGRFTjdyYm41Wis2ektTZHpMdFp6?=
 =?utf-8?B?VjJHdXNySUFkNGsvcWRrQnBSeXAwbWxST1ExQWd6dlZDd2FPWHkrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	qWUatEtUjJzJvIQSmzpvNtUgXqjO4+9UsLvltAbnNBGw6U3MYabbvCo2g583ZCmun3XHasAkXzsumtQg4lcAzoo3gy307rz2vjsQ+dzklZmb+FcBLL6sAVNcobkMKTYgXACxd4hDIxPl8zfKk5Jh4S1TRqhudAj19Rciitjp1+oUidD/93ed2k1m8BtUqYUS/K5Lb1fb9gaoBzIxfODls8khOoKSK5o0nFKIWljQT+bXzdjVrNf9Ti9f0wt15xGVj+LJqbvC/Q4y/GaG/K31fVVJ51qQ3m+wCQXIA882w9NVp16MhtZjyHtd4SN1mIdRwIjZqDE0uVulrrPAp/4Tpg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c03c08b-7eb8-4c16-ee79-08deb2633339
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 09:20:26.3724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fn6MqeICYS1wUN31fonCSqTlSS2nbs8mMr1uXaICvy7FTsX/LZCdb4lJK1jOUFHzDwY79Y3PLnXjsAcCLnDJJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6376
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA5MyBTYWx0ZWRfX/wBBlJ6KZvmt
 Bq4hQtqJaQJjRWY7nXGgS46nYFK5101F16DZ0rMjVJKPOyoXW30U7Olt4wzmqZoeairrLsfmWRh
 gBi3bwb0BS/HEiX8KNuGHL5Qvpg52vl4E1q4ilmPZOaWi/B5nq7iXhGujGQgHsOEJair0gxk9I+
 UyNRXeXO13VCGV1tz2g2l1qDqTy282ht2fE01uFiJpQsvDPr2CccyOg3fNRZsh0v/lA1X0Cyvu3
 9FiXxZ0nD5vwkB7SWt3Y2rzHMc1WKOyBJGtjDqkXLyKCODnlNcLahEnPHo0nvcVWkqZskzJYx4d
 fRCCVlOOuEZmGtIcHe2T4DitqJkVQiicXLz1aib5ctn6T4CTmU0c7wLxKpDYQ3oMyhg+rz/+s8d
 31Hh+kLM1HJoqw3ms5Y8znPVV6bmh69fJsMrdc5COw9r8A5idrOsKWGvKJwQESsq2DwKzaZrbAl
 JfroBmbvU4DbHerCLdQ==
X-Proofpoint-GUID: uS0ss2HtURUpwYtNpWBuH4tMqNQfwRIq
X-Proofpoint-ORIG-GUID: uS0ss2HtURUpwYtNpWBuH4tMqNQfwRIq
X-Authority-Analysis: v=2.4 cv=N90Z0W9B c=1 sm=1 tr=0 ts=6a06e55e cx=c_pps
 a=KM6hcDErBpdSH7DPVcpu/A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=IpJZQVW2AAAA:8 a=w4jwP_JBTp9SZk4WQ84A:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150093

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBMZWNobmVyIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTQsIDIwMjYgNTo1NyBQ
TQ0KDQouLi4NCg0KPiA+PiBJJ20gc3RydWdnbGluZyBhIGJpdCBvbiBob3cgdGhlIG1heDExMjA1
IHdvcmtzIGF0IGFsbCBhcyB0aGVyZSBzZWVtcw0KPiA+PiB0byBiZSBhIHN0YXR1cyByZWdpc3Rl
ciByZWFkIG9uIGEgZGV2aWNlIHdoaWNoIGNsYWltcyB0byBoYXZlIG5vIHJlZ2lzdGVycy4NCj4g
Pj4gYWRfc2lnbWFfZGVsdGFfY2xlYXJfcGVuZGluZ19ldmVudCgpIGFzIHRoZSBiaW5kaW5nIHN1
Z2dlc3RzIHRoaXMgZGV2aWNlDQo+ID4+IGRvZXNuJ3QgaGF2ZSBhIGRyZHlfZ3Bpbw0KPiA+Pg0K
PiA+PiBBbnlob3csIHBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGUgZmVlZGJhY2sgYW5kIGlmIGl0
J3Mgd3JvbmcgcGxlYXNlIHByb3ZpZGUNCj4gPj4gYW4gZXhwbGFuYXRpb24gb2Ygd2h5IGluIHRo
aXMgdGhyZWFkLg0KPiA+Pg0KPiA+DQo+ID4gSGkgSm9uYXRoYW4sDQo+ID4NCj4gPiBGaXJzdCBv
ZiBhbGwgc29ycnkgZm9yIGZvcmdldHRpbmcgYWJvdXQgU2FzaGlrby4gSSBoYWQgYSBsb29rIGF0
IG1heDExMjA1IGFuZCBpdA0KPiA+IHNlZW1zIGxpa2UgdGhlIGRldmljZSBkb2Vzbid0IGhhdmUg
YSBDUyBzbyB0aGVyZWZvcmUgdGhlIGNvbmNlcm4gU2FzaGlrbw0KPiA+IHJhaXNlcyByZWdhcmRp
bmcgQ1MgbWF5IG5vdCBiZSB2YWxpZCwgSSB3aWxsIG1ha2Ugc3VyZSB0byBtZW50aW9uDQo+ID4g
dGhhdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+ID4NCj4gPiBPbiB0aGUgb3RoZXIgaGFuZCwg
SSBzZWUgdGhlIElDIGhhcyBhIHNoYXJlZCBwaW4gZm9yIERSRFkgYW5kIERPVVQgYW5kDQo+ID4g
dGhlIGJpbmRpbmdzIHNwZWNpZnkgc29tZSBpbnRlcnJ1cHQgdGhvdWdoIG5vIHNwZWNpZmljIHJk
eS1ncGlvcyBhcmUNCj4gPiBtZW50aW9uZWQgdGhlcmUuIFRoZSBkZXZpY2UgcmVhZHMgYSByZWdp
c3RlciB0aGF0IGRvZXNuJ3QgZXhpc3Qgd2hpY2gNCj4gPiBpbiB0aGlzIGNhc2UgbWVhbnMgaXQg
YmxpbmRseSBjbG9ja3Mgb3V0IHdoYXRldmVyIGNvbWVzIG9uIE1JU08uLi4NCj4gPg0KPiA+IEhv
d2V2ZXIgSSBtYXkgaGF2ZSBhIGZpeCBmb3IgdGhpcyBhbmQgd291bGQgYXBwZWFyIGluIGEgc2Vj
b25kIGNvbW1pdC4NCj4gPiBJbiBjbGVhcl9wZW5kaW5nX2V2ZW50IHdoZXJlIHJkeV9ncGlvZCBp
cyBjaGVja2VkIHRoZXJlIGNvdWxkIGJlIHlldA0KPiA+IGFub3RoZXIgZWxzZSBicmFuY2ggdGhh
dCBjb3VsZCBzaW1wbHkgcmV0dXJuIDAgYW5kIGhlcmUgaXMgd2h5IEkgdGhpbmsgdGhpcw0KPiB3
b3VsZCB3b3JrOg0KPiA+DQo+ID4gU2luY2UgdGhlIElSUSBpcyByZXF1ZXN0ZWQgd2l0aCBJUlFG
X05PX0FVVE9FTiBhbmQgSVJRX0RJU0FCTEVfVU5MQVpZLA0KPiB0aGUgbGF0dGVyDQo+ID4ga2Vl
cHMgdGhlIElSUSBoYXJkd2FyZS11bm1hc2tlZCBldmVuIHdoaWxlIHNvZnR3YXJlLWRpc2FibGVk
LCBzbyBhbnkNCj4gZmFsbGluZyBlZGdlDQo+IA0KPiBUaGlzIHNob3VsZCBkZXBlbmQgb24gdGhl
IElSUSBjb250cm9sbGVyLiBUaGVyZSBhcmUgc29tZSBwYXN0IGRpc2N1c3Npb25zDQo+IG9uIHRo
aXMgb24gdGhlIG1haWxpbmcgbGlzdC4gVGhlIGlkZWFsIGJlaGF2aW9yIHNob3VsZCBiZSB0aGF0
IGlmIHRoZQ0KPiBJUlEgY29udHJvbGxlciBjYW4gZnVsbHkgZGlzYWJsZSB0aGUgaW50ZXJydXB0
IHNvIHRoYXQgd2UgZG9uJ3QgZ2V0IHRoZQ0KPiBzcHVyaW91cyBpbnRlcnJ1cHQgb24gZW5hYmxl
IChmcm9tIHRoZSBub3JtYWwgU1BJIGRhdGEsIG5vdCBEUkRZKS4gSWYNCj4gdGhlIGludGVycnVw
dCBjb250cm9sbGVyIGNhbid0IGRvIHRoaXMsIHRoZW4gaXQgcmVxdWlyZXMgdGhlIHJkeS1ncGlv
cw0KPiB0byBiZSBhYmxlIHRvIGRpc3Rpbmd1aXNoIERSRFkgZnJvbSBTUEkgZGF0YS4NCj4gDQoN
CnJkeS1ncGlvcyBhZGRlZCB0byB5YW1sIG9mIGRldmljZXMgdGhhdCBkb27igJl0IGhhdmUgdGhl
bSBhbmQgYWxzbyBkb24ndCBoYXZlDQpyZWdpc3RlcnMgaXMgYSBzb2x1dGlvbiB0b28uIFRob3Vn
aCBJIHRoaW5rIHdoYXQgeW91IG1lYW4gYnkgdGhpcyBpcyB0aGF0IHRoZQ0KcmR5LWdwaW9zIHNo
b3VsZCBiZSBzb21ldGhpbmcgb3B0aW9uYWwgdG8gYmUgYWRkZWQgYnkgdGhlIHVzZXIgZGVwZW5k
aW5nDQpvbiBoaXMgSVJRIGNvbnRyb2xsZXIgY2FwYWJpbGl0aWVzLCByaWdodD8gUGVyaGFwcyB0
aGlzIGlzIHRoZSBjYXNlIGhlcmUgYWxyZWFkeS4NCg0KPiBJIGhhdmUgdXNlZCB0aGlzIG9uIGFk
NzE3MyBvbiBhIFplZEJvYXJkIHdpdGhvdXQgcmR5LWdwaW9zIGFuZCB0aGUNCj4gaW50ZXJydXB0
IHdhcyB3b3JraW5nIGNvcnJlY3RseS4gU28gdW5sZXNzIHNvbWV0aGluZyBjaGFuZ2VkIHdpdGgN
Cj4gdGhlIGludGVycnVwdCBjb25maWcgaW4gdGhpcyBjb2RlIHNpbmNlIHRoZSBsYXN0IHRpbWUg
SSB3YXMgdXNpbmcsDQo+IEkgd291bGQgbm90IGV4cGVjdCB0byBzZWUgdGhpcyBwcm9ibGVtIG9u
IF9hbGxfIGludGVycnVwdCBjb250cm9sbGVycy4NCj4gDQoNClllcyBidXQgYWQ3MTczIGhhcyBy
ZWdpc3RlcnMsIG1heDExMjA1IGFuZCBmZXcgb3RoZXJzIGRvbid0Lg0KSW4gdGhlIGNhc2VzIHdo
ZXJlIG5vIHJkeS1ncGlvcywgYWx0aG91Z2ggcmVnaXN0ZXJzIGFyZSBwcmVzZW50IG9yIG5vdCwN
Cml0ICJyZWFkcyIgdGhlIHN0YXR1cyByZWdpc3RlciB3aGljaCBpbiB0aGVzZSBjYXNlcyBtZWFu
cyBjbG9ja2luZyAxIGJ5dGUNCmZyb20gdGhlIERPVVQgbGluZSwgYW5kIGhlcmUgMiBjYXNlcyBh
cHBlYXI6DQoNCjEuIERPVVQvUkRZIGlzIHN0aWxsIGhpZ2ggd2hpY2ggbWVhbnMgRE9VVCByZWFk
cyAweEZGDQoNCi0gInN0YXR1cyByZWciID0gMHhGRg0KLSBwZW5kaW5nX2V2ZW50ID0gISgweEZG
ICYgMHg4MCkgPSAhKDB4ODApID0gZmFsc2UNCi0gcmV0dXJucyAwLCBub3RoaW5nIGJhZCBoYXBw
ZW5zIC0+IFdvcmtzIGJ5IGFjY2lkZW50DQoNCjIuIERPVVQgcmVhZHMgMHgwMCAobGluZSBMT1cp
ICwgcGVyaGFwcyBSRFkgZHJvcHBlZCBhbHJlYWR5Lg0KDQotIFRoZSAxIGJ5dGUgcmVhZCBhbHJl
YWR5IGNvbnN1bWVkIDggYml0cyBvZiB0aGUgYWN0dWFsIGNvbnZlcnNpb24gcmVzdWx0IGFuZA0K
ZGF0YSBzdHJlYW0gaXMgYWxyZWFkeSBjb3JydXB0ZWQuDQotICJzdGF0dXMgcmVnIiA9IDB4MDAN
Ci0gcGVuZGluZ19ldmVudCA9ICEoMHgwMCAmIDB4ODApID0gISgwKSA9IHRydWUNCi0gQ29udGlu
dWVzIGludG8gdGhlIGRyYWluIHBhdGgNCi0ga3phbGxvYygwICsgMSkgLT4gYWxsb2NhdGVzIDEg
Ynl0ZQ0KLSBtZW1zZXQoZGF0YSArIDIsIDB4ZmYsIDAgLSAxKSAtPiBkYXRhX3JlYWRfbGVuIGlz
IHVuc2lnbmVkIGludCwgc28gMCAtIDEgPSBTSVpFX01BWA0KLSBtZW1lc2V0IG9mIFNJWkVfTUFY
IGJ5dGVzIC0+IGhlYXAgY29ycnVwdGlvbiwga2VybmVsIGNyYXNoIC0+IFdvcnN0IGNhc2UsIGJ1
dA0Kc3RpbGwgcG9zc2libGUNCg0KSSB3b3VsZCB0aGVuIHNheSB0aGF0IHRoZSBzb2x1dGlvbnMg
YXJlIDEgb2YgOg0KLSBhZGQgcmR5LWdwaW9zIGFzIHdlbGwgd2hlcmUgaGFzX3JlZ2lzdGVycyBh
cmUgZmFsc2UuDQotIGFkZCBhbm90aGVyIGVsc2Ugd2l0aCByZXR1cm4gMCwgc2luY2UgaWYgdGhl
IERSRFkgaXMgbm90IGxvdywgaXQgd2lsbCBiZSBhZnRlciBlbmFibGVfaXJxLA0KYW5kIGlmIGl0
IGlzIGxvdywgaXQgd2lsbCBiZSB0cmlnZ2VyZWQgYWZ0ZXJ3YXJkcyBhbmQgY2xvY2sgZGF0YSBj
b3JyZWN0bHkuIEZvciB0aGVzZSBkZXZpY2VzDQphcyBmYXIgYXMgSSBjYW4gdGVsbCwgdGhlcmUg
c2hvdWxkIGJlIG5vIHNwdXJpb3VzIHNpZ25hbHMsIG9ubHkgdGhlIERSRFkgaW50ZXJydXB0IHVu
bGVzcw0KY2xvY2tpbmcgZGF0YS4gSSBtYXkgYmUgd3JvbmcgdGhvdWdoLCBhbmQgcGVyaGFwcyB0
aGUgcmR5LWdwaW9zIGlzIHRoZSBzYWZlciBtb3ZlLA0KdGhvdWdoIHRoaXMgd291bGQgbWVhbiBs
ZXNzIGNodXJuLg0KDQpXaGF0IGRvIHlvdSBndXlzIHRoaW5rPw0KDQpUaGFua3MsDQpSYWR1DQoN
Cg==
