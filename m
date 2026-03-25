Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC91917BA2;
	Wed, 25 Mar 2026 03:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774408409; cv=fail; b=ZCADVcNZ+Dh5jgGrpbRtWnGYGuBJ02roL240FF0wjNw04YlRl7/HkHeloPa2kaicu96FkB+KOVUojUypPGREkb6Cb+Qwph4nbEs8cMXmLDbyHfL4xYZ9PdwLlQmM4edKD5JVqTRHxiHvQbZQx+ztXnvVkybvLTfja3iJ38VDQoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774408409; c=relaxed/simple;
	bh=jvhV9LlS2vre7YmhyOr2eprmaikYlUWosOoaGGuZ/BM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NMYYp/6srdoSlTsMnQymSJ6EcV0m6HjXumQwRdmpOLQoy+RsdTEw33K6OZ1n+dEqmgeD2UgCis4jsdKM9b3ZnfPOUwd8g1+/X9U87kkh3h4d8QS0I8VA08Hqp3NVdj9Nwtyh9qxop8ijOb9FzRF5NTET3L7UMK3+E1BYAzhUF4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xAM82W+D; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xAM82W+D"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P0oTH3279177;
	Tue, 24 Mar 2026 23:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5oFc0
	kjdwWI8yJ0Bb1lm994axqpvYrrYi3LuV5j/RBc=; b=xAM82W+D5AfgMtk/Og5Uq
	P8YtCUBh5hRfNZU+p5F+k7ippAn3KTx9Iqb8H6Y6wMXDU6yj0NmfhPrEsF5dFl7r
	4k7+Q5rYTl/ym7eUUbI516YwMu/y57wS0fjX6WyovMlkyjp+nsmhlVxYyTmxs+gU
	w+llHPdwWExXcBwPRNQgjGS8Xsd9DhB2Ma3Us2c49A27DkAY36ibLktFLe5w096L
	1M/U3rl03JBB2OvkX+h1sX9iZn3nMk+9bIcmhR2Pz191BpgKihA/NZsueUERqUNv
	hzJ6waP9bi78C9KZK/oOR8YTmWRpkQDjtSlbtu+cJvyODKOTAKrCWInJ+lKECIS4
	w==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d45gyrhrs-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 23:13:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFnxHavZow+VPPCtOzmGInjGD9SBv8QnCLHSTb9/yAefpT0KggiJiGU1iC5P3irb3vq6oc8sg7gzevPdSJQVQgeV8wUkBbe4Tfgdw94wKfJfZDQOWmkOzBqSDcCq2xcOmzlhdEfhFdMWJPsRJtLKL085Tdfv7tUBlXFOJ1HF30pscH4/MoB/ijpjZ6ZKGeMu/3sRxbdmjQtWrKhSUZCkKDTxQlouATMIq7wa5QyI7NuXzWGWqF1HQh3MNvhamXnuw/pMR5zc3JlkAI2011N6/eG5yFkFBEXgt7xbmyZhLywL9jbSwYCm+wOWQbu/8+mt8hskEltUgAE0Zjtn0TuBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oFc0kjdwWI8yJ0Bb1lm994axqpvYrrYi3LuV5j/RBc=;
 b=WEPZlll8IEyUCPO/6fpp4BZUxAOe9iGXO1L4MduM+G7lHeLeTXmP4irX7TYuxfYGFvc4St23HswRtkS5tk+FDqoBbCx3Gtv8MtasBuffldsS65Le6uaVwMoWGSnuODGI6GYJcLsLO3QkOMDt0XQrqoQtarF83R3ycKWLzV5gMwr8cT6bcJwcUHe5W9Ej5YtKLE0ByJCT4UZi/gfsiF2n5Evss4qegZZLwl83pzxQ3K5lPSu1EsxFM7oufMONfOb20HECXuoeXiVx232D/Xazq6UIuN5KsDPrrMlvmsxOd4QhXcYuL0XUL3vIy4VdQtXXJcf003Of5bJwQeQwWyrhGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by LV3PR03MB7707.namprd03.prod.outlook.com (2603:10b6:408:28b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 03:12:44 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 03:13:08 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Topic: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Index: AQHctpdTMBKgFPb38UaDAUFZqVbS1rW5VtOAgAUkVpCAACGMAA==
Date: Wed, 25 Mar 2026 03:13:08 +0000
Message-ID:
 <PH0PR03MB6351C1D87987E0533F4A07EEF149A@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
	<20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
 <20260321183909.45761710@jic23-huawei>
 <PH0PR03MB635133FB434235B7542770ABF149A@PH0PR03MB6351.namprd03.prod.outlook.com>
In-Reply-To:
 <PH0PR03MB635133FB434235B7542770ABF149A@PH0PR03MB6351.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|LV3PR03MB7707:EE_
x-ms-office365-filtering-correlation-id: 0d93c20d-00ae-4516-c636-08de8a1c70a8
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 N3ycAaZelB+KH9hL42J3yhbQo57DcxPRx2harh+buv3uxCyEWLSN6qGzfiDFVaF+/c8Mwhz2BBex8BoIARMOMJwo7GYgFGLa9k4C41SLn6GLbSlLSGiQuB8IuEjY4vixGp06HG+Uc2u+AXlxNO4Nz5GU46tiKGMaeuyOEPtV/KMp9zo15tQr7N/xvAGvYQu/uwmOEcYrkpxYNFkDX67iM3Ba04vadg7NRwRpIOipDex4QrQaWb9CEZJ8Kvd/rAhgq/jHMSfukFyvt5fapjjLaF9SFFAB53LYbxn8mNg/EnTzUpupOylGO8RNZaQoAcezGFEF2LCD66o7L4+tUi/RJ+rQzRg3qs6U83caC+mGP2V3hnYivvIn23NVh13YF1CScm56mOHvVyowrgf2S/FHdctgki2uPzBmIxC8c1jFtUCQvp6lNUlUVZv+2XnP19pxQW/oTAP3i0JJNvkI5ATjkzWdpTQKXBA/KBiDcxC0x1IR+VPsXJcOUQuEPej7UBdtdMFsVlA7mSNVJVqeWnLyQhN4r58+n0oYWfDf551Ps66iNPdOW+pBqyscFOVfgUamkkiFF9D4gt+pSGBsNG43F8auKu1upvcPMKBtglcInn1qB7qE++kWAcR8DSSPKYap4UP/8y3///wq044KTQfWm8U2TTG8zWoInDYEJA3bT0p4R8YLugN3fnuh6dNYE4jDRV/R08oHX5/oo7S3gR2QF6FeKk+wIQhpzGai0EwClWlCarFUwOyDByBbRIKrZEW7E0KPq11gaJaYfIH6hS4BL2jPmND9Gs8bCfJZ8SJHVbI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NYDpnPSOfYD3iImtjQcS2cUqtFejh5UB8C2gmS7VRXb8U05Vao7rfTdgV640?=
 =?us-ascii?Q?DsOYSvW4MPIskGtdbZiDuIkytbYRfHyg7efTJVgdd7VLZZSFsCl6kAOjI6rz?=
 =?us-ascii?Q?zj8hg+S0tml2N5eAQbNS6icd4m4uwMjvrTBDwrf2Ala6ohWSrmklEvYiHNyL?=
 =?us-ascii?Q?JKZ7oXas04F85uTaYqAsZLHxXomGAmqOtYwInXeSAo0QzaJgVSN/LIFPUjPx?=
 =?us-ascii?Q?OUUAqB9GFCoSudjg6DsAm/YmXt/7t2BG0Agsk6SW/7krHXOxTJWd4KWs7mrG?=
 =?us-ascii?Q?Wx7ARPhD4MNYeLeIoHAdnUwMVkkJo1OOtDYWxcxnXa6aNVLhvSjMvvrGu4D0?=
 =?us-ascii?Q?qVrRuw6xEbSEGsxySWMDll2pFr83q4ByEfavbIUJEYZREQK7/1fwM1xGcohe?=
 =?us-ascii?Q?SRvbsKYb+687xXJpzhCVALp3/oX2O9OyJmnQF4GwG4PeGE5MPjwbBaRRsVsz?=
 =?us-ascii?Q?03cdw4hOQPI25W4g1UV9nRlVG8NwEaJH2lrRQi/kerqCVGM2Px/GbnJ1AL4B?=
 =?us-ascii?Q?4quSskXvZayqgq/64Ix2L/mncnO1zmApNAS+tNJQ8QHnEV/4GFQIbstonCLS?=
 =?us-ascii?Q?csaw6Tno+mJc15YiiLymG7UKZjuHTetd53Qy3JG4a7aBUJU1M2Sl2m7XhsWs?=
 =?us-ascii?Q?ir4Bku7T2qidSgT2RfNjiBpTIOYrFUh/v5+aEvti0IRIdIhlZKXA24vqZQ95?=
 =?us-ascii?Q?DtBn4CF8WiehsR4BGxLPYJ4NncU06Dxi2JRMP6Zd6zS6zHPQ/SQ3gDwhlQWV?=
 =?us-ascii?Q?Z1J7JZrpFKJW4BCowk25XwJdmuJRKKEhvdPPGAXfVMVebqngbAn7kfYPFKpF?=
 =?us-ascii?Q?0MXCEXac0ovOknRN0HASzL9xlXRSdGKdHPORgkDX+jifjtNsGWJUq2djq/Z0?=
 =?us-ascii?Q?uJKgzeShqZJgpW4sP+GqaAK/BUguE5vczQTupaK0DiQf/msKHPZOoqO2m/Aw?=
 =?us-ascii?Q?0o6wcUBjxdfK+WFXqu1LKrFjP/S7XpCrf8tgJlFSE1GenVjwUmBRv3VuyVR9?=
 =?us-ascii?Q?mSOEEICDHGjrTTQ43oWx5U1xC6zlS6qhhM3bemPwztCgueZ+q31Qi2bdG0iB?=
 =?us-ascii?Q?XJ3ms9CaoBNhC1wWnanB13I6pxbbX0jejcY05K1TTC/QOYjL1YbJKxaFBpbw?=
 =?us-ascii?Q?zBNIUvmxT4jz3vSW1NJ6cMewB6mVrU9ZGpIaECVH20Bl9638Xx86i8dTut2z?=
 =?us-ascii?Q?8mFhHwked9tYxhWisW5Y6xnIj90o8rymu1vFAUZ9+nGKC6bAgTFRzvogp0KL?=
 =?us-ascii?Q?+3AE9ADWjkVWUHxaDr0s5ELwDu9K1lam398994DQd2NGnrzNH+63KY8C7NTZ?=
 =?us-ascii?Q?ORjMCMyShw5OwyrkhuuVvKpfT7mYUclWbe8dB7OvFySU3tzOhga8M0XlGAum?=
 =?us-ascii?Q?9F9eDe9GdAkb5+w3Lc+KHsdchlflEJgD9leszJ1L2uHbmoY25v6RDPsnzI68?=
 =?us-ascii?Q?Fu2KgqIE2wisyv2eY1ZilOyVZWDp6gSaKH9p0g1j3BHE+tUDplV4vpltRuBG?=
 =?us-ascii?Q?bd6T0l8rh2rP8nRLZ8e1n2uDOkqqDDZJgl6+che6dX4UCE7PC2b1h5hLL/2U?=
 =?us-ascii?Q?azLQpv8Igooj45P5Q1CxJl7UShgMVdJjuzz++Jx/E9Dej9cj7/rwE8vCq2Fo?=
 =?us-ascii?Q?EvI9/T9bOj+YuJ4T4i/++9YW+PMOkAZn17IGq97u90kPGxgw/Cl70KzFvt2Q?=
 =?us-ascii?Q?l043/hKV9410W3FXm9uWvKrZOcLxLeNdtz8AqqJsWZuoZcdFPYVWR5N3vnvc?=
 =?us-ascii?Q?rEYZx38yFeSAViK37giH3zD0O6/6JXU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	KfX0Y18qV3K0RsLBue3GENf/DpGVYTtAgIHG9UaezhbRS8I1dQVvln85e3xKRM6WnnoZPlNZwtrKfb0uscQCA7g13CJGe0tUAxt29RMwtoF2doGcbWWZtU374TqCyvU1T7slCn4ubDOqBVmvwKmTOd7c8duUNoxB0L+RuuG1ZmHqpkEZsxrWGzAZPVY5uGaHj4IfrXegg+NvLfNDc8cBaF+p8YlXhE2wRsyTFlQ59s3Wx80NYyWu0upUC2BBDtL7CuIR4Q9lOEn72H6BXHt7icptSc52uyWWfB+S+D24m3UGuvYp2t9/yR5AtOb4JjcqkIhYIodFD0dN49jsSIcgUA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d93c20d-00ae-4516-c636-08de8a1c70a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 03:13:08.6614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rdiefLqp5kQeWFp3kuJdeJNrrtAKGsxw1VnL6U3PF53zKkAiaHUE5x/haPq8AU3SyVb/iTV0qzWIGVGBsHjezLyF8KxdT2ClVLY1oQi318g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7707
X-Proofpoint-GUID: XVuFbDcMsA9cD6PhOsH_ctlUgaT3gQB-
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69c352c9 cx=c_pps
 a=Kac4Oh/pgoirBk7HbaAweA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=2GleLwiyHP21YGhL2gMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: XVuFbDcMsA9cD6PhOsH_ctlUgaT3gQB-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAyMSBTYWx0ZWRfX7Y4k3UH2xRsc
 Q9PFDKrNKxDcaiQoTS6gMGI+rc/XCMJRApg3Tp/4Z9UC3/OSilEizI07fU4cGV6cbaA2TKx4mag
 RmZ+fXSaDQJPVeaWXSkdNck2nWk2ndaFiKT5QP0qcGyofp6Q2C/RfGxTTc2M1YlwAybEi0PCLUH
 lgwC9FdQpVyI+jbLknpJl2aOK1ND07Gixhx69gr0w6XeWlVEluMtgn9yNIqFN78fEdXlhg0i8+c
 ZaMJbbYpH1g+g8ZGuNB7Dh1HwZnkjPsak7Za0hKHh3N8ATfHGYGlcuz0XtIYm7vOJ7M2qR0NzPG
 +/rvcw+MIf+rg4f1Mwcj9oBsne5FuIIgIOt0+ym3iQ+1RsDuL2HNV+1Dv1nu+w0SnuCrWfTzv9e
 DHWrtKay0CEu4ERZQpk/2JsbL2XiK0isVIfpp0Ucz5Vjm0AAP5T1UVPRRm1BVQtIsKsKEsTVfxm
 WPuQjmtKxGQgQF/pLhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250021

> > > +	ret =3D spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
> >
> > Can you use spi_write_the_read()?
> > Has the added advantage that it bounces the data so doesn't need DMA sa=
fe.
> > Can also use more meaningful types like
> > __be16 tx;
> > __be16 rx16;
> > u8 rx8;
>=20
> Ok, will shift to spi_write_the_read(). There was another place to use th=
is
> above, just trimmed it off here. Noted on the more meaningful variables.
>=20

I only just checked spi_write_then_read() but, it seems this doesn't suppor=
t
variable spi_speed_frequency for my future patches. Should I still use it f=
or now
and revert in the future?
