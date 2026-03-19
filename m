Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEABA39C007;
	Thu, 19 Mar 2026 05:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897807; cv=fail; b=u1qdlC+XqpC/ovrSZBOHmbKWkpKIOcv6MZg44KiC+3sJdu9tU5Xp+ELzffedfmw0VQZjaWHJ7t04qzvZ9yDUbgmWtSaB3nJAPxc/+0ireskais93bcwn+SNh2qQLK+cPIaHU6wVdI7z/nAb4l2p7E5e2GH8Zgu64yP+SBd3dQPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897807; c=relaxed/simple;
	bh=iIsYEd1aPB8Gh0jsv1O74fH0+HRhdIx5FEa7HbGD7bM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kg/yJvh2xLznadMjCr7gW7+KPKq68HzzL3/T3+01SNhEBXy+FfbfMPpJXq7KxrwQFSdyDEn++mVnPVIqVdQs8qGpzq8glzAVBK16AlpDxWUIxXt5jUeSfxIccnU/bisB5ITEZtD+Q6jhlbwm+IUf/qnu8PxZ13Top/Zf0FJUej4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vzECoA1+; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vzECoA1+"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J1JoI34041198;
	Thu, 19 Mar 2026 01:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sjB7X
	dSOpTr0AIaanT97zs1fZdEDCyl3riH9EQHXw9o=; b=vzECoA1+R68BTV7ChzfN8
	3i870axw/eEU6vrH98eCbn+Foa7Bw/K6KmbwgDbWWijM8UHIcbz2dbbj02vL8AJ9
	3KHUaY5jaugENjX6DfNDRTFEdzx2utAj9v36WTxscOpAsSYfNS09LY4CZwENHQQx
	jBoJnRIVAoOyhJ+QSaGKSni1Kx5gpyMt0SzPlHl1AY6c0cLV2LezqKY9ANlw49yx
	xicbYFt1igAVuoz5q7eJaSnoiO3l5yOnst9lIqyKccjZ94qsPIvYqxXptjpptnWs
	o/aX/mk98M6X3mDp6sXQbZBAhfbK0Rbcir/6jdcpv6dwfROeD7ZA14P74gH9n6tW
	g==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cyjesxcnt-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 01:23:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJgzO8Jc94ln6QRJEFBQG6ofQaoP3aAAkN5M+Y5H/hC9DjR5w/DHixlTXQMedWIobqTx8H2BMg7YNX7i8HgB2uLXPYuojhofEgjuYy6EWBkjLRsMgTyrKJvboronEfR6mWLO8zsyfyVEZSZpDyaDs+k31K79oO4y6W7fOI02adv+qFXVEI8cqBOlUw4iZyL2hYYwNsNJBWU9eafg2yOSKM4Av7HRotCvRJBrAiG1h6mZRbTdTksKh33V0Nl7PWvOCnHBBrMnj2I01vJETncVexZn5nayh4lMnp5TysA8A1ovCTJFkdidHb9lYNF2KOZciIYgmwpNgEgybey7dWfNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjB7XdSOpTr0AIaanT97zs1fZdEDCyl3riH9EQHXw9o=;
 b=vvrX9UHkA4EX9uLmCa0gb4Znbly5t+yvD6ug54i/lPCg684F47WJAFdrSU6oeLF46uldXyuUIwlDRAg0f/xt8IO+lpTcWVHGql7PFUSmSOcN1PJDHFaupX5f7+ihQW98WVS66yMG+I0GRDdaagaZC0e3P9qtG3B61V3Wy90MB1ZanLBP/IQ3yLledLgL3ehMX+JIBn4ESALz7XImTs4+7kR0yghQXcrKIC97Lbbc11Y77p3lVUCrn2IrOkR/GLwKERA218tg9iSKnuO9koh79B2nLEcmen+aj9ue/93J8LgQUOjGlZ6IzJBVXKJ689WCuvrcrnaQngugR9v8KreleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by DS0PR03MB8246.namprd03.prod.outlook.com (2603:10b6:8:297::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 05:23:08 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 05:23:08 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Topic: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Index: AQHctpdTMBKgFPb38UaDAUFZqVbS1rWz8fcAgAE3iOA=
Date: Thu, 19 Mar 2026 05:23:07 +0000
Message-ID:
 <PH0PR03MB6351A1A32896F5CFF05A4C10F14FA@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
 <20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
 <abpfdELI33a0Ncl3@ashevche-desk.local>
In-Reply-To: <abpfdELI33a0Ncl3@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|DS0PR03MB8246:EE_
x-ms-office365-filtering-correlation-id: ac8731cc-6b85-4e4f-025a-08de85779aea
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 3kMHrY4ljyUpXaBNE6HB3uso9HzWUqPjjNEUv1TYOgLpGJvVeD5m+2g9miZcfYSh+IVV8EwzTOcSyrFslWrtd4YfjDb1/tqwpyuh+pbsozvx5QaDMKMguoIkyDPMCDztgAJaiNog8ExcFHAh+xQRFariw9vcozRbfMpeJngGmKhDjAYgZhJZ1PxNxeKWJvt+hvp9fpNTewIVarrju0xwHdYNsJnBWp+CxYGnTzRvg1MOf29Zw4A5WVs3n837qSgkY+xaXQKLlp23a/Plivm4niiicGD5/tmb/r0ZuY3MgxWK0SS1BVU8HUZuPiu94po5udQ373IWSeJ1UwdZOYXgRrW3tlLYFMD4zUW3IQLOtLR0HCYAdp0O07+K2cxjD51QVbnM7hKD/WyV4fWJK2wlMnPkjK1UItT737z0Ig9pDnrCTJ9JVy5NVVcHxcczY5KXevGnleBJ4ESmVpyB7YVogH/WA3Qw/AgUMs5xz4J2ChEVom4vyhQ4iyX2x3FgmkWXjjmDFMmjjHonJN0jt436GcUQZbxzx0wViYA8teM+ccY1VPaiQpNR8Si3Eo38/zS4ruXzu+rdSeB73yxkhQR/PjSiUSmRD7vLwBirF7WkE5le0TsPh5EKnNlBaNNiXzveL32IS3a/aa7t6jVN0RunveXYq1qLWPKjXKDr1Jy2vs5QylPX1QgxPBm7gnNN65B2Uk3u63JWXTOyOS7x161fEIH3Hm5ONvprsUChTRx4g8lp5quwgbbJODKf7uBEPE9t8+8u/9ovntbMzFOhdSSGAq0exoanx46AfJ4c9WgGhbg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0wHLKulhnHQv8Y4ZbOBPjh3EbAPv3dxqiRUmlA2fyqrF09ad99iiUAqlnd2/?=
 =?us-ascii?Q?+mWHkn8IjC7eQ3GnPCIQjGyOaV5UWSrgV62ebDjBfkHy1wj8rKcMnCDYCSQ8?=
 =?us-ascii?Q?KBH+8N7v3MGS0wQ9KxjMzss20F+EbZV0mO/Fm8Pvoh87nmILtWvnz+KS9uiZ?=
 =?us-ascii?Q?fGmdv4YBHz9V6ydL04CPJvM8yDAJDl0IttFxh5ARV7NBE0ip4/KMXrLjDGOA?=
 =?us-ascii?Q?qC/hMHP5NAVpnvE31iXkpAcl2CKc0rGzJDDbjfW+q/fkgLkxBe3yadsSlJLb?=
 =?us-ascii?Q?0kfuenOAxfpYKZMd5YEdlmbGXRVX/6MX3DX1UJsME8OIo/EiVGm0cjWPWYvK?=
 =?us-ascii?Q?e/nvaJyiz8LeHLGU/ultoIL8gd+PnMR8ZbXu07zNY5LrdoCO2HjXLZ4ZCzMP?=
 =?us-ascii?Q?NXirtFpLzCReJ7OtJhlf7gokQd7Eto63QK+jZDbAJsC9lIHLkhz4f/jjdCTT?=
 =?us-ascii?Q?WOig6vG6j5inueUmkskwIftxuiH09fCSeYTwOXH4azgHN57TXkpuMuHtPpMr?=
 =?us-ascii?Q?de89kuhnUh9sovCcTEJG6r5+4MRr1FsPVpOhAg3ORQaQ70A3pgGl7yyuOeC5?=
 =?us-ascii?Q?aQYfhX6nM6HsnGs8/igzcPtN4sUiVEkZSNvmqbi39PC5gc+MXf8RlUj6ymGA?=
 =?us-ascii?Q?fzjm+UnSqu69ce4OjiKk1YCIjE+IP5EDNEsJa3TJdgOv745Q07CHxKHkKW0U?=
 =?us-ascii?Q?voUtrsuCtGAotX7sTkWGx+1xjaLJNNSrkQb98HrH0v6xhvpA7v+pmBvbfG6f?=
 =?us-ascii?Q?RhErkXf9Sun75i6OzOsMwDggye4hehTpGhsdkjtn8rlCJOpnGInzVbEhrRpk?=
 =?us-ascii?Q?uUCDth8tNgm7cNUjWbrN2P8XPz9txJpEHj0pzpMHSv0n8Iw9xzTE6zsyoYma?=
 =?us-ascii?Q?RUbhmdxKFFdMuW4EDWqf/0kIavjtJOjdrw4XS9qFWnmaCncJsA57URt/9R7D?=
 =?us-ascii?Q?6WDg5G80hAvf00FHVGbhWAnhp9QsJcxMTzfqnCJ0JjngVShPRZXfOXmXKtX+?=
 =?us-ascii?Q?SwUPS0I7Yg9p7PchOogX08f47EAo0FWDTEBzKc3Cg7A/VnBs/wcS2Rvdr2da?=
 =?us-ascii?Q?P1hYNU37O0K2ksJ7Mdc+ikgPOkgvsWe92+aObwbahIkHheNl7qiSybd7U4gB?=
 =?us-ascii?Q?GrEKOrdsnDe2Ai7dz9Hb8oMM67YcJaY1VuaVQWrDQu46f/ZTCIkotKIgKBoK?=
 =?us-ascii?Q?PwnxdchrZJJPIL4rQmGR88VOOrq8b18NQDwe+KGbQDWweQr+nnoXA91EMl4T?=
 =?us-ascii?Q?mXgT7l/A4mKMNBbi3mx1U06moixNbZebNUaMjWg0SnwIGLOFKm4mFNM7TdZ+?=
 =?us-ascii?Q?kV5mPKHy5a/6xZRZIRwD92AcFOHgjD5wso4/kp1ug5xwa9oUIe2+1M1ZC6re?=
 =?us-ascii?Q?QTAYnUjgoPKAPhGOt9G1BPJA0DWRSfrkKCjJY97eT3ea9kzobRkfvwT+VBRx?=
 =?us-ascii?Q?pZeMXVpJeGzacYL+j8NzoYXbYuzeAmGC19VBScLHxy9dDQ42OQEiHvJMtmgP?=
 =?us-ascii?Q?ZBYU+mPI9cpU1bIheG93NedJeAOGWGXOY3jMkca4/POJrsln7oIKDnA/uRlP?=
 =?us-ascii?Q?0LdSUjpmCKRCFBvU+t0x7MgnS5h2vig0B4zWJiBigU4Xbaad/Zyx4q4Y7q7j?=
 =?us-ascii?Q?sChTYIgB4ks4Jzo59DDVowcoEM5NPkdRCtkoh2BBAR6VtbVKNmS0J/83FR98?=
 =?us-ascii?Q?SmvsXjKBkLl38gWLqiiDkTESAe/EfMlgN7i4/cLUchAFMxQuM7eg4l7Dw3Wf?=
 =?us-ascii?Q?ggIdoiRZ/t2rtCQNIC++YWn0hRQL0Ww=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	QyzxzFW5igqMLcXQC1+RjQ6fmBO0P+D1liQtOwd8OMw8HAWsjt++zvEoTYXqnqoim+mE7HOTWjFiEBQ2M+UhSvM2r79TgIcDdUlIx7gVp/43xcDlmHI/L9yG5AwZcBOuE96jYFKINwgmcHMhDnV91ntL6hMfAIe+X2pb+Eu7pWKGD4ugCqk0T7s+KhEAzYGwALBM5NaAIhx4MwYYjtduKvADP2EafMFJYEOCHml6PP//0HfrFhJI81R+hHZC6IGnkU9Lhv/p5EIfP530+ejqx5pfaqPUsB/VtMJ1yg0tHVg7ACdR8Z3xym256MVgtDO4yxXuWp9KfUWb1A7nCkd3Vw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8731cc-6b85-4e4f-025a-08de85779aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 05:23:07.9431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gp5cstYN+EBNHzmvADsDUPcEBP1n4824OjTjHQKJ/IEq4EPoK6SvmSqGY2Om+mLVhLhzB9o6ct/FtepJGzPGA3fQe0/h+paGGskZpf5FvGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8246
X-Authority-Analysis: v=2.4 cv=SpWdKfO0 c=1 sm=1 tr=0 ts=69bb883f cx=c_pps
 a=W8CcAi5xdRL/7wP9pBfUSA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=d7_tHEUGGfeR5PaVhxQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: lTFshmgXE46WfxyOcH4VRLJ9XHKZSoer
X-Proofpoint-ORIG-GUID: lTFshmgXE46WfxyOcH4VRLJ9XHKZSoer
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAzOSBTYWx0ZWRfX953uvXg+LGyK
 RuLoXGs5aZlwtlx0/WfznvUkshKvy4aM9wnuu3zEuvaYwIKN3m8vy32dLE9y4hEtCzkwNAvZ1t9
 SQE35qTtc0yQ4LP/gQfEthGiwqBy3/Xw40cl8iODQfCZXWMSeYELICpCAS/vLS5gMYYIdV/R5sU
 hgqiIxlICr1gBVEADHYC/x5GJ44JocDVyTT0+lFLDwROFpR4UxqdLnAETVxquVLmybPKj8ySQKe
 Lp2nKJo9dSVl4KCNwXfei6Vce4NB891RJVI2eg53fyMQd6DOq/2C0B8ZGeIHLso2Y7vMp/Hadog
 yfxFdroYSovJH1O3NN1huKZgSdi22+o1TnKkVVhZvy0Bcfp3dIXBbOBci5ZeUUJDs/Ta70tiHOX
 okHzAPFivsfP8otPOYUVsee05g1fTLvFPVICMyjVfhgdGpfIdVu/0hB+p3kmonFlfj7LX0Fru+9
 5bbZ1t0uZNuCd55lvSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190039

> On Wed, Mar 18, 2026 at 01:13:36PM +0800, Alexis Czezar Torreno wrote:
> > Add support for the Analog Devices AD5706R, a 4-channel 16-bit current
> > output digital-to-analog converter with SPI interface.
> >
> > Features:
> >   - 4 independent DAC channels
> >   - Hardware and software LDAC trigger
> >   - Configurable output range
> >   - PWM-based LDAC control
> >   - Dither and toggle modes
> >   - Dynamically configurable SPI speed
>=20
>=20
> > ---
> > Changes since v1:
> >   - Removed PWM, GPIO, clock generator, debugfs, regmap, IIO_BUFFER
>=20
> Why was regmap removed?! Was it not used?

As far as I understand it, regmap also gives access to debugfs. When I remo=
ved
debugfs I also added regmap as removed.

For the spi write/read I am not using regmap as the device has some feature=
s
that I think regmap_read/write couldn't support. Namely the variable data w=
idth,
as the device only accepts exact amount of clock cycles. Future patches wil=
l also add
variable SPI speed.

>=20
> >   - Removed all custom ext_info sysfs attributes
> >   - Simplified to basic raw read/write and read-only scale
> >   - SPI read/write can handle multibyte registers
>=20
> ...
>=20
> > +#include <linux/array_size.h>
> > +#include <linux/bits.h>
> > +#include <linux/cleanup.h>
>=20
> + errno.h
>=20
> > +#include <linux/iio/iio.h>
>=20
> + mod_devicetable.h
>=20
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/spi/spi.h>
>=20
> + types.h
>=20
> > +#include <linux/unaligned.h>
>=20
> Follow IWYU principle.

I did miss errno.h but it seems the IWYU is stricter than pragmatic.=20
Will adhere to it better.

>=20
> ...
>=20
> > +static int ad5706r_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan, int *val,
> > +			    int *val2, long mask)
> > +{
> > +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> > +	u16 reg_val;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		scoped_guard(mutex, &st->lock) {
>=20
>=20
> Can't it be simply guard()() ?

Can be, yes, will edit.

>=20
> > +			ret =3D ad5706r_spi_read(st,
> > +AD5706R_REG_DAC_DATA_READBACK_CH(chan->channel),
>=20
> It's too long line.

Will simplify this and other similar lines

>=20

 ...

>=20
> > +static int ad5706r_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan, int val,
> > +			     int val2, long mask)
> > +{
> > +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (val < 0 || val >=3D AD5706R_DAC_MAX_CODE)
>=20
> in_range()?
>=20
> (will need minmax.h)
>=20

Will replace, much more readable that way

> > +			return -EINVAL;
> > +
> > +		guard(mutex)(&st->lock);
> > +		return ad5706r_spi_write(st,
> > +

