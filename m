Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E0426EB4;
	Fri, 15 May 2026 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835672; cv=fail; b=P6ChuuZ8KDdXi7a6/iFnZi4u1m4rNUZmYxUmEYSTNC+UYdxq75rI6bzZGOCQyd+z04e+trXLQSY3E3sNAgUoo3qdr2lMJsVCJe31csei9vAH4q6ZEvaaqL2F2m5ykr19LWG2gwXsXOB9ggep/VoCwYhK5p8Hc3kL6L71CjMSXlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835672; c=relaxed/simple;
	bh=OvAMxHsxw1FEQAdtzucIG3qxQKuLFq7HieYQeQLmt9w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MORYqj8N3FNZjFAwJhNTftFnGD9SNz7UNnWoSzXYFe6tzAK75o3jiVjuWZPs5g+zwaojCnsRhGuIJaqqbo9x3R34Ap06D47LSL7ntyJFiI8E08NqNHeWPZp65eSxZqI1me6Ghr5axJbaic8idWZZ0UH2p7q+sfpgHZWHBVPUdWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MtM0nkCK; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MtM0nkCK"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F2Xr6T2817538;
	Fri, 15 May 2026 05:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OvAMx
	Hsxw1FEQAdtzucIG3qxQKuLFq7HieYQeQLmt9w=; b=MtM0nkCKuLXGlMWStIbyl
	0M7hMwG87eMNNIOuZe/lMdXp8sC/tSzAHZAhf0YlhlfwdBwlEAMtCYkBlO7t3BTj
	/A249oiJZHmjMb+NKIkVh90qSBqNv3a6gAP0suonCZccKGc5XUVHyFNm+G4CPxyu
	/R7oVxOfY44U2RFvDYAHX2NetHcTPvTNhG9SVaXDoI3WNOvhXx4HcEFP08KCUcNd
	pd2Q1wfLHnyEHqzex+J4pOg/A/hz4oyuSjtbto1i8B8eQt5EnrlMJw9QvWmZeB4q
	rYi51FOWd9riuu6ooL15XspQKorm7BqRxyteEGaD0uAeu4x49bKc0Dc4Ck9QCQjd
	A==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013016.outbound.protection.outlook.com [40.107.201.16])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e5m2wa4dc-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 05:01:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1HFo6cvficZNKAFSzd+gwy9pEi04970hX64bzNN3w7VtpqyocmGJHf/Ub6v2FjejoU9IqlNwp/Ygiy6YiSXe0CEnw0nWBzColn9KXt5KTzEzxSikz+8ujeLUXrzkkCr780PbvtLJPt8OD/oHuA/T//hLh9FAwoDKZe4YGnoBYMmcMekCRAEfUmt+fASObG47IBE4RX2P5CCuMKoZZ+H5o06fSB1IkEhekTsiF25ctI8TGMwqszhdFnxTcvPPUG290FHGCNFxAg8NatfJkHzhKGkiaR3/q1Cn1PaKhlwwIYiDcbWG0LYa65MnIdBqS/joukhP+ip06gl5ByZz5QQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvAMxHsxw1FEQAdtzucIG3qxQKuLFq7HieYQeQLmt9w=;
 b=Eou2YksahAMZk29+k2cdaj4DzbvSdBV7dC2t4/77AqcoqrNWRG2qPAAB1s0qDBR2RvIhKTArheHnKdr2owAFVIUrcLfO9mX4An7d/iea/QWEsXzl0kOBU3P6ngfVajRBATvEfYEhwvmcFTTg/GPdPZ1ZGrZetDapQY7gFxl3xxD1cOTpZv1CWx48FiyLl/4R86LrvX77kJ76RDfZcGBS5PCw3ov2zAuuV5qv04k86qtxdv3sNLAkDdJaz4KcLpErWjeyPS4O+Cw7nMozjXTrbs36f/jliTjFQDj5hNj27mkOc+spaAHJ1HL9lTzgfQtgILly61UYbaWjZ5/4D29zJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by DS7PR03MB8243.namprd03.prod.outlook.com (2603:10b6:8:262::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 09:01:04 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%4]) with mapi id 15.20.9913.012; Fri, 15 May 2026
 09:01:04 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: Francesco Lavra <flavra@baylibre.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        "Sa, Nuno"
	<Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Miclaus,
 Antoniu" <Antoniu.Miclaus@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        linux <linux@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 5/7] iio: core: Add IIO_COVERAGE_PERCENT channel type
Thread-Topic: [PATCH v2 5/7] iio: core: Add IIO_COVERAGE_PERCENT channel type
Thread-Index: AQHc47D7zvAMrEpy2kqudw9pAB/Q/bYOxPsAgAAFnnA=
Date: Fri, 15 May 2026 09:01:03 +0000
Message-ID:
 <SA5PR03MB8377B8CB8183E8EF57F59CCFF6042@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <20260514144712.64374-1-liviu.stan@analog.com>
	 <20260514144712.64374-6-liviu.stan@analog.com>
 <f77e96bbf0a85cacd3ec300bac3bf4ed6b8605b0.camel@baylibre.com>
In-Reply-To: <f77e96bbf0a85cacd3ec300bac3bf4ed6b8605b0.camel@baylibre.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|DS7PR03MB8243:EE_
x-ms-office365-filtering-correlation-id: 4cbcf78b-0aa9-438e-af90-08deb2607e5b
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700021|56012099003|11063799003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 cCeW+FSGFhpUBKGwadyefowZ170gNscr2qjkJGTnbGAPqwBvm2RpmJudzIu5aLYMFynhXPWBSPpS9jODRRkvnK2bQGDeZs5Cb3eL167A9qtJryGOhCQbJzmznal3I5o5HkKM19F5yJZUNqHpBpxQGnC+jdBslYqDI466iUKDjMFowHuO2zN1y7+FSllesKcp1qCFCLnPGHIbQP8kHulC5Wt9hErjKINppV1lx+IFOamyPv49FDToZLAt4HyHM5tIkFbE5bQPFBPeiSCWp6GNfI6F60B1BXBAU/X/VEapCbsn712VtLzl8vHzkUEdhsJDTVJfdFHqf9Qfma/KXAfhiqFZuh7htwKDk27jCinVBEsgXGYmK7o8bM6ptZHextPx5URWuALdBqw/oGTGupLdMlf44IUNWryYJ/eVxHz6qfcl9pLA9xap8OnOaerzSTThibSVB+xeSAnN1zPR7syUkMFcOocpxAfQaCIr9T336jZwzy2xtibudWcEAMfiqjUIREifoZgKeeQG7ErG0SM2RSdTdNhjnxu90TmkVjBAjDQvUwQaDVn0288KXQ8tdVkoHJ8/4pW/dc0KcbKHeuveh2evYBB3TEetqasAAGifK8GGbyLlRNuMl5s1Aq0yyhL/t3WYYlymVBX31nfJ3GQ4Nit0wJA7OFNnWS5+ns+yau+Oi1rdiRz+AYuHu5653VdjxlEW6r5gE8y2t3mNfjIrpDzWBPSeuipXgPrAXOPHTByvecsos3dI/dXwmSGiZvtLeeVq8TzP6FXHNH+CJZeHow==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700021)(56012099003)(11063799003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWhlNkhZUGl1ZTAxQ0x2YWpoUWpoMStGaWx6Wks1V2FhVVowblBxQTZLejYw?=
 =?utf-8?B?WEZwL2pBMHZvRlJ0bzhCOVhzWXAyNURabVVpVUsxQ1JUSDFqL2hnTTR3c3BX?=
 =?utf-8?B?TzI5OHJRN1phQmNDMUVJMERYT1BocDhVZEFZYjYvV3pveE53cVN2VU1BUCtV?=
 =?utf-8?B?QjdrY1ExeWVVS004OXBDTFJRUW9vVmdQVVFyZXc5VVdyREcyMURMYUY4QWZJ?=
 =?utf-8?B?Y2RkRzVhME10K0F6Uy9RN1pxbHpSQlZiOTlTVisyTVhudFA0YS81M3hLdklC?=
 =?utf-8?B?OFI1NDNJSGw0N2w2VXVpQ1VDZWVhUkRvUlNjVDh1amdXdzgyQTNIa0pPUHB1?=
 =?utf-8?B?ejhaVG1VZ1FUM08xc0tUY3FrU0NlZUhxd2xveHZyRHA0YjRwS245d01rQXlZ?=
 =?utf-8?B?L3h6T05GamlmakxPSG4wOXByakZMOGRmWnk4SEdMS1FJU1VReWVMUFcyUmhj?=
 =?utf-8?B?c2ZTaUZEcGtjbnl6YlRaVDNpM1pJSjFCTUd2YVBHMzZLTGdPakF3MGZIb252?=
 =?utf-8?B?aVY5VVAwWGlETnc2LzdUeFFIMzV1TDAyTFlaVndoUDU3YnN0aUtiNTFKUXBM?=
 =?utf-8?B?Snc3eUlnOVdoYy9lTWV4NlByUm41ZHE2TWJpUHNUbEF0aGZkV2xSTy9yT2hW?=
 =?utf-8?B?UlNnVjlrK1dXYUhyRFlVazlCdStQZi9kaFBoeGpwN0hJRmlLdjJNTEF2UHh4?=
 =?utf-8?B?bjdUaTBLL210bXUrYjlSNVlpTGYwbVVkWnlIQ3p2ZHphdGlhWkRXTVZLZzhC?=
 =?utf-8?B?SGtBdjRwa0dSRWNmKzVBZXVNUnZoOFh2UGNhMTRxSWVOcnpCUFJXN1JmVXRF?=
 =?utf-8?B?emxuWDlXejh0YUoxS3pJUGhIMHZmcTdBbW0zWnFrZWNvZDQyTlpUOEhpYjFa?=
 =?utf-8?B?Z3M1Nk5RUkNFMzE5K1NRT284b2U5Q1E5ZU9zWU11azF3QVVuYWRiK0N4VHMw?=
 =?utf-8?B?UlRCY2wrWEk4VWx3L3BBUEZkTkJ1OXp4bm1aZmY1bk5RWktIVHVteE9tUHNu?=
 =?utf-8?B?MWhnZnZaQVdlRjQ2N2JEMktNdDVYUnF4Z0Q2QURPaERlUVplcVZSYno5ZXpj?=
 =?utf-8?B?cnRPeThWS3g4VElvQ1ZuNG1WWG43M0plQlI0M09FNTZ6WWFxRzlpaUgrcElj?=
 =?utf-8?B?Vng2N0t3R1hKNzlydkpDN1JwcnlMRURaRFY2MmVuenJWQzZidThESUNUK29Z?=
 =?utf-8?B?M2VDSjk5bWhoK0I0TjRZS3N1SDVBV05RYWUyaHFFak1BSjYzeU1KclN3QnpR?=
 =?utf-8?B?OHJRWlVwRE0wSWNyS0thZWhwNEozVC9mN05UVCtCc0Vod2tSYkdicXB6QVlL?=
 =?utf-8?B?MWZQeU40WkhwY1B4dmhKa0ZjZWxnQ3I5SEE0MnVXUC91OURoZ2wwR0NVSjhX?=
 =?utf-8?B?UTNSbVNDQ1YxaEcrRWFpV0s1ODcvQU40YjdrZ2YvWTRDS05hQlhUdWNmTG1q?=
 =?utf-8?B?eWt1c3ZjaG5GRVhmUG9LM010aFBKYmJ0clNsK0ZNUUIzTkZZYXBnakNWbjBs?=
 =?utf-8?B?NDlZNWJIVFVDTFRZUE5qOGhWd0pzaFAwTlo5YXA4ZStGUTFCdHpHRU0zTXlF?=
 =?utf-8?B?TExXeFRIL3QzUzhuSXplOGcvRFBXcngzWWw2MmpQNG1GV2t6eVE5RS8zbGJG?=
 =?utf-8?B?MTlzdkU5MUROTmZHNXRVZ2hpZ1Qxbi90aDVyY1NTZnVWN0doVVNTR2F6Slpv?=
 =?utf-8?B?ekZHMzNSclpDSGpHSWloTlVHRXR0Y1ZGb3RwREEwWHE5Z0k4S0c1dmxlZkdr?=
 =?utf-8?B?Q3FzUEpjU0dVY1M3OG52TVpEYmsydU5LMXJXQi81cUkxNW9VMHhYWWp0Sngv?=
 =?utf-8?B?ZEQ1MDdGNzcyanlrdFdBcVlpem5VbjF4Um1wWUV4SXI3WnJJYW9abGtoMVBM?=
 =?utf-8?B?NmcyMUdjNXQ5VUI5b3oxeGFVRnZCaXVPUDhaaGlpeHBJR1hNYjNISWRUT25z?=
 =?utf-8?B?SmowVE0rWGRGdmxhbEh2dHhQRnQ5ZkRYM1pIdVduU2ZnNzlPY2s4ckJucmJY?=
 =?utf-8?B?K1ZrMTNXRDVVQzdMV3BsR3JCRzZidEdmSkpYOXNLeDR3TlR5dXFQQmpONTlx?=
 =?utf-8?B?YlpNRXdQbnZ4UFYxUmNzN2c2N3dGWWlvOUxEcVhwSDFDNDk5UGl5NVVPNUNz?=
 =?utf-8?B?Q3hReWlIU1gwSXNEc043NmVNYi80VlpnSEpmRm5JMXhYZDZUYllMWFM0eTFE?=
 =?utf-8?B?YU0zRTBiZWRkNkpzaWdoYW44OEh1dnM3dlQzaXJlZWEzT2dOMWoySUUzaUtu?=
 =?utf-8?B?VUFwaU1GNGUwOVQzbCs5YlJDZWRSQlhHY05IQUY0RjhqQkhVRWNTMWpKWEho?=
 =?utf-8?B?ZnNPOGo1TStYcDRHbGEyZjQxYnNuc002ekR0T2pqR2hTUXptOUtZUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ix9mGScq93IqOh3Mrq9EyEkQjdIt0a+YjFVjqXcyV1XbNP1XYRCPP7/QqbcZak/PmYQaZfiYwW6r0ib8uGQ5xWcnrTAtG/8Sy+UzBawcpb/H690eJY6BsdbBLBumZQ+iDCv3Vd8/kYKPklcF9zpE343fNJW9VNPtSV4Ojrtacsq4vHDJSkT5ZeJ7nKczb4q8dmDdhJKQpWdcsib3NdbkAZ9fp89NGNDyegwXY7iXDdLIjIKQMGN+Hfb6zCTasVsFo/nkrkSo7pdKYZg/k0y+71nx4aUG6q9D3yxaHyb0MWHcFR6jachIBP6w8PfXNKYjEwNu568LHTZRWngdP5XklA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbcf78b-0aa9-438e-af90-08deb2607e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 09:01:03.9567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06XcSCJX1Sj+CsoyEfLSv9VLNnSBXrU8nax7MynF/aCHf8kg4PfzOSaKaps0TESOKEBDqQLzZV1nCco1c74dpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8243
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA5MCBTYWx0ZWRfXzsGCY1So2xhk
 4G54+z0sPchhxOU7sOTLg7xgSnrxN7tA+GEt/eVRWZgD38Rru7hhbb+n6dBCjza9pJwfXg7zlKX
 WpV/4O441d/jGvhJ6Qt/Xv+bh86iJIlw+Zy3HV7IkfgyMLAcvMK7dzzcLHR+O9TYNs1DfocKb2a
 sfVFp7r3HhW9w3zMbGEaZlhgUVBCRIo+C2Hysl8DveiS1uNIrjrLa3+IT4DhTHWTy2axdM1jYYl
 iabLZ0XRxQ+u26M1jaFcD9epymXVBUrITTQC3c5TilR3E1d0kHKxbMATmdfybCwXEeghhb5Dwo1
 JaosPZPpNUoOxlUoW5R/adjiyjj/yENk1ByzERrDIkHheiJRCy+/WofWhfamwn5yBErS862ubmr
 JdlUU6auQh3tuk7mp1Av0MYXl01bjDl0Nk+zIpThLGVl3wrtH0IylsePZAlnGRJ6Wacm4xSi10S
 S2nd1D3mCNGtr18JFuw==
X-Proofpoint-GUID: 3oaQBXFprwrHQJmke6EMsvs6y2PBdgec
X-Authority-Analysis: v=2.4 cv=UrBT8ewB c=1 sm=1 tr=0 ts=6a06e0d2 cx=c_pps
 a=+8K2uRBjRfMG8L7NFMG7mA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=hnObvkvdm5TXnq0h2qEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3oaQBXFprwrHQJmke6EMsvs6y2PBdgec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150090

T24gRnJpLCBNYXkgMTUsIDIwMjYsIEZyYW5jZXNjbyBMYXZyYSB3cm90ZToNCj4gPiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlvDQo+ID4gYi9Eb2N1
bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1paW8NCj4gPiBpbmRleCA5MjVhMzNmZDMw
OWEuLjA1NzBlOGI4ZjVlNSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0
aW5nL3N5c2ZzLWJ1cy1paW8NCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5
c2ZzLWJ1cy1paW8NCj4gPiBAQCAtMTk4MCw2ICsxOTgwLDE2IEBAIERlc2NyaXB0aW9uOg0KPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgUmF3ICh1bnNjYWxlZCBubyBvZmZzZXQg
ZXRjLikgcmVzaXN0YW5jZSByZWFkaW5nLg0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgVW5pdHMgYWZ0ZXIgYXBwbGljYXRpb24gb2Ygc2NhbGUgYW5kIG9mZnNldCBhcmUgb2ht
cy4NCj4gPg0KPiA+ICtXaGF0OsKgwqDCoMKgwqDCoMKgwqDCoMKgL3N5cy9idXMvaWlvL2Rldmlj
ZXMvaWlvOmRldmljZVgvaW5fY292ZXJhZ2VwZXJjZW50WF9yYXcNCj4gPiArS2VybmVsVmVyc2lv
bjrCoDYuMTUNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIDcuMiAoYXQgbGVhc3QpLg0KDQpVbmRlcnN0
b29kLiBXaWxsIHVwZGF0ZSBpbiB2My4NCg0KVGhhbmtzLA0KTGl2aXUNCg==
