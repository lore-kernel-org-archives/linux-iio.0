Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE910392802;
	Mon, 23 Mar 2026 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263698; cv=fail; b=qHviUl5NZhFa+DV/qWkBjm0BL0+ft+paJwszjpskd0JGKLVm5TtRMigmeKT/oblub3hurbnveEpZFSx2hEglJqfIY1Vwxi84K18F+fleYfoL7j4e8B2750Hsk7Ns5G/c6ky/RyHJTqnXy3IE7cQ661ZN03fsByuNd0JzSNeeU88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263698; c=relaxed/simple;
	bh=zVQ8OZR5HDvtT6FRJ6p9oheX4deWr27QxFkpVcMMkZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sfGkMwN8S2znM/ZHqsu9JINoFcbrjnx5KxCJ8+TynLo+NvOz//77RuNSBxKfdTWDGNsMyByQhh6jlQCbYXE9+hl1lWUIbXPrCnBD0oVuFj7FQbimIwH867hrZxJ8vyFJEkvahotYBN6dNLOyqF+zAbe2OD15sDxnaJLjQinV2UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mfAZe0hr; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mfAZe0hr"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N7V87V2962484;
	Mon, 23 Mar 2026 07:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=b3x/n
	KQI5SW/g67CbCJvbKjIUhD1kt7pQQiehx+BNyc=; b=mfAZe0hrcZMIaVBq/wqmh
	vyUeowcO5jmSIm/2ZoOisOzdBEYm0Ckq2p+y8M+2Rq3VfydIIbtETiIFqeEF7aZF
	oBbvuAeZ+enM2NTHVxNfA+/qaiCrRz7wXGKgn2spdQRaqPOppWxP4h8secDMZ+oE
	zHGnVnHNVF7WIT8SviJV5ld8q6mzu5jZ/f8VsBEBJc7Hi7RefOpkI9gh2Xggp7ZS
	W7yNoPpAjoJFhFnPihdAe+dNY/6GAQ9eAOfwhUXpt0o6joUNB+U6fGcs40CaebnH
	P42zD6OAOLncwz4Yoe5bMS7HZBQlvBr5dKidSNeAAR6t4LidWbUNv6jcmXDbRaj8
	w==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d1r81xjqn-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 07:01:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUFRsPSlkGAfutOk/M+DUWjwzZOpoHptjDPVGsGgjtw6fU5wXhGYPuXjP956QYC64dx6rJgH2fSBsfNJisDNjZiY3cQIMYbCafnjkcjRCT8jtjpYVTIAUS5sLIFrwEvlmlaOCZLOzE/oRS2g5JulJzB3c3dwOGBYTfxQown2RXmRSovX1WxvAKR+CttBYn4az8myauYr7cgHfCneQ/2eDANQY6p02DqgRmv+tVALc9lDaE2/au57Lhg4K5btQcwRb0nSTGcOmBuXrR+1vxxX/odqH3s/7+UIccBEg3Uj79zct9585ImDXtte2svLPmJY1pwtY2Bnplr6gEDz632ZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3x/nKQI5SW/g67CbCJvbKjIUhD1kt7pQQiehx+BNyc=;
 b=rGaUYM63uJWFyioWXsUDLBVeAtp0CyDl3AQK6PZ+B/S70CsfO1nh5WvfXvAdHTCVqZmXm0Vl8BfpZdluGB4OqEK3XnoHIX7VTu3GmGhkAA0v+w9rAUZf2NG0LS2qC8vTlcnUIbPhFF7vxoJ8PMrb0XR9Npaty7crmczt4g6uEl+Y0GEfdGi9n4zfn/xngDhzomV5Xcwe8wfleJjJXK/SXV9GvWG/LqX6+bo6NhgtlxEjP1Nmo1Y+giHx4mQCleZKMzlviAjOPl4jTN1bnj44v8mscGNeO8SBK8ke1Geq/08xvx+/ZzXQECLAtmA65mpEk7RviY13TMC1CiZtHZ+uCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com (2603:10b6:a03:2d3::19)
 by IA1PR03MB8092.namprd03.prod.outlook.com (2603:10b6:208:596::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 23 Mar
 2026 11:01:08 +0000
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0]) by SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 11:00:54 +0000
From: "Jones, Carlos jr" <Carlosjr.Jones@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Liam Beguin <liambeguin@gmail.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Tobias
 Sperling <tobias.sperling@softing.com>,
        "Marques, Jorge"
	<Jorge.Marques@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] iio: adc: ltc2309: introduce chip_info structure
Thread-Topic: [PATCH 1/3] iio: adc: ltc2309: introduce chip_info structure
Thread-Index: AQHcuTFge3H03sR5VE+cKMaBgU+vfrW7yr/wgAAq7wA=
Date: Mon, 23 Mar 2026 11:00:54 +0000
Message-ID:
 <SJ0PR03MB58544C4C2B846ED58CE43CF6F44BA@SJ0PR03MB5854.namprd03.prod.outlook.com>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
	<20260320140819.191700-2-carlosjr.jones@analog.com>
 <20260321125103.516b984e@jic23-huawei>
 <SJ0PR03MB585454ECE02067CB36FD9119F44BA@SJ0PR03MB5854.namprd03.prod.outlook.com>
In-Reply-To:
 <SJ0PR03MB585454ECE02067CB36FD9119F44BA@SJ0PR03MB5854.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5854:EE_|IA1PR03MB8092:EE_
x-ms-office365-filtering-correlation-id: 3131aaed-001e-4e7d-c1c5-08de88cb7486
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 5mqbW6Bfx3N1sZTNdTUCIRgM0Y55UwzaXcNLjfu/4kfjxMjGNi/Ni8belyvaRr/1ISd6S3gVey+LpQ+c1JgBPXfNb/gb2sWG8N74I4Xbpx4Lal4UqB/xWiKjFvX9AMcTfoqzD+JGTQ33fSzhj2j/huZZUBAY6cNV6gu3FVAQZheWP/ltpyWgXyxHcozFMNvhOIB2qn3yKyIDVR4obJftVpKaJSoloZmLsjQ1Jy25RVR9SG1A6VdMAXI69drnr3Tz6vA4yo8ikrb+o8FtLCEYMuAbQhONZBupP3BeLU8YkYqElClbBSr4a3n64OQcQSl0dvRoOJlMjirr8I1eS+3ao5orWXXzpYxIVCFrJg5W7Ag4uaOJo49Kpc61qI72KJkJpp8MHeMpPFa688WJCnB/6ph5SAUp9iDQP4Z5DXV2SdMS4jKbqfHoMIEH3CXjew6efqwY44EbQzuu6S8Z6v3taaBSCGAlYscXWWZIK9ZJeVHdnheUJo7qYEoXmU8DOc+4aWgQ4uMAyBDuQOg71SV64L8ruUbea4Iin27iB3jP5pSaaVBZNmbebBn+/Zl1vOJwCwJ/zaF7hGgeP9RxsOM9PA0ifNFruQNGCb+KDhqKFeKYmgJZBTwUoFN012eGYMsd+FSH4WrhE5mWzJOn31+Y5OUK5pZVemem077goKkdPk9/P672EiSX1+oA+Hz4AEq0EdfwzM8yf0/PvyDGKS+4n/QB3si/Cn8wuormc7CK0Hzcb7OSasHWA0Ivpag3kjnX17dzPlzYU2PaEB+yu+3pHchd3of43/5TThf8JneY7F0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5854.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1iVlMtZLHJY+Hh5rJ6rB2+ccPVD0DDW0Yv1HCPQqyvfkxvB2Yqs11NCskS6+?=
 =?us-ascii?Q?7285dt/5b1Ld1dgIZeAApDrUVRIxCziN1wm+mbkdJfhNhK4gxRIMvRN6IuBW?=
 =?us-ascii?Q?A1SeVLt1TuczznMZLEnbqkQxAZIT9zA39H7F6udYfGmIJzJ6BOmg7f+vXxrN?=
 =?us-ascii?Q?mgv7tG3fZQukc5Tt7w3GPOju7kzfAVZKAFblEx+btuEr/LzSX7zS2NnHwwx4?=
 =?us-ascii?Q?qz9ObRDRUTLkeGvZutQfFkWmAQDFWsTuvBTCFFSpPoYhOkAUL4xk/mv3dy6Q?=
 =?us-ascii?Q?moVi1mfCQVlMWz0826cT4E234rhNMigADu1WkbvziZQIXFx2mN9VouwHq9bb?=
 =?us-ascii?Q?V8V3+ean7iSEYoXOMHWgegABQLEn7WT5ioloyrkf3CD6BsoAKw44X0nHlefK?=
 =?us-ascii?Q?/8/qRBWre+b+ILm+Z+C8ZgSMG87rL6AfifOtrublBgVu2R4uathM5muVNt2o?=
 =?us-ascii?Q?szL7NUnm5ti7HaDwQzezltr4iLXH7xmLEt8lRa1dFe/Wx8cmjCCAlfHSydRz?=
 =?us-ascii?Q?sN9wYsNsSj6oP4nlR/22e2PRg1QhP2zJDAezFRrqBI1rHPW0yFfXHXPDPOYD?=
 =?us-ascii?Q?5efGGPTDUyk8PBp1aJgw33j+1GCHnP2v8PO8UYJkadrB+tVI3XAv1S2AUNL1?=
 =?us-ascii?Q?ptYNyLwfyHX9XiqxpL5adcGrY1/soGwDvWTUh93gJjuPsh6d7IoLeqbzhKIe?=
 =?us-ascii?Q?SvoXqQsh3YxW3Y+dDADZR8KzLDC3Se3k2NXzf/ZMBtENX7DG1ZPyyyl0eavV?=
 =?us-ascii?Q?NMnFk+17D/EgaiQNIOwsUOuEOGuCubTWa1Tmc3w0SF4pUxA0EX8jJhM+2j7W?=
 =?us-ascii?Q?CDXyLKcLJ3ySPxI7ZJvMQXr1DU4laK6OEHdbiNwEuB17s07PQv1Bl4gN53lJ?=
 =?us-ascii?Q?rIDGg2VuWE1mHRqY7NNADRsycJ8Lr33qnlPlsBvkOmAr2nOHfPaRSpTjvTh9?=
 =?us-ascii?Q?vPG5pi1WMYXnUa5Jm2+qlqpkka4wAkGl1eAzm9RS1mZ480/YmCmV6hAp3vGG?=
 =?us-ascii?Q?qYQe1kCCnRN9fNyrutgE0tCy+pS6QmDvB/eVKDAE8m6TauSaKDL6a+/iOkuf?=
 =?us-ascii?Q?wpL9TyaYwZQLIzltq9fYExz9ci2kLvRVsGaue4757PZfrx4WFV3Y0hTiZk1e?=
 =?us-ascii?Q?NYyEIbu6m7Jjzk32VeveRfDzd+5K6EmBGb54w0x42s+bkyBio73hdqvGhFzO?=
 =?us-ascii?Q?AlhBPVexYeX+BPzJw/K4J/Mu1zgwMbA8LNbZg7JQNjcNPAEyUXwAT2uoxdoM?=
 =?us-ascii?Q?p2Hw7RsFujNxkDP81qI0A0p9WGsuK7b1wsYlMpV+aouGf1UHgzHdgA4k+F6+?=
 =?us-ascii?Q?LitxQJIDgsiNBYg7aWa7CSplNLVFEGhK271dweUoezro0F6+GQOOvJjQfWfn?=
 =?us-ascii?Q?+bvqK9if3KdrY2wHAJJe+PbWwg6Ux8C5r4nxl7WRr+zXM5+hQvVaRDnJNvZa?=
 =?us-ascii?Q?K757Xt0ajQbwMmoeXWMsP3qcww2PFFU8NxPJ1fRRKwKD/Sc807lYRRcneZb1?=
 =?us-ascii?Q?Go3ZyboIQnpf5RCSad4W5iIJ0RFU7dQWYZLI/J53NOSemDtHCTJJ/f31kDCO?=
 =?us-ascii?Q?bDHHl5by6VKgrYKGXp7MvH3EMjUwr1LLwqVcKmBzo9InV9b9D91gUwVrXqXe?=
 =?us-ascii?Q?YbqzohkPEavB8GxT9ObL9DYLJVgqiDKJ8m5BMKRU/FIIP1u0lTaGCbaIhQkB?=
 =?us-ascii?Q?cvYihZWwYKGXkgys0zpUnlcVj1g14ZezEH3NHJUOOgIFHpVv9AaB8GOrHUeq?=
 =?us-ascii?Q?1Y0cwQMkng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	eTM8CZKacztjAxNWwtOCsvlRfpEecDsZOqIWS9VRvOUsJU3z2fQCbypYOv2/7YtfKeAQRSCzg5cjgYoW30GruSuRyJRC54XRgnE3BJt20QZ2WYC4XBms0lJKzxq0NW95ht4k9lV1odlWZHs0BJTgxO+OLmxx0dlNFKEu6TKD86MJV/DCsIMu9SgowjZPYx+za1E75XYjmcsGKwgaUEgpPzB2y93wqNUW3/4/aIUv2HAUdWQYZ0RAnSzvzc7yRgWNt67JOGMpQtIvQbw1fZLCtAcz+New2b9tmOj9cQ9Rb1cmbducuJoXNY8APOyppP1Rnd8/ElvwEQBGafqqZrTTLw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5854.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3131aaed-001e-4e7d-c1c5-08de88cb7486
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 11:00:54.7884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNheirvWu4kZYbDPzawiFMbJ5mX2/weNzL5czofRd8k1C01SnP4XswIy1IG97MkjartDpc3Z+k8lnmsfGauHK9nuu6teFM1OJNd8mhikDzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4NSBTYWx0ZWRfX7eOtJ0T+yZid
 XFKOk+WvGWMwG4lIwh2bNK9EaAbsoKWq8R73uj7hUCW+vqvaMnvv6UhHsYLc/zku6UEayoyREaE
 2w7OqHpNnU7H/1Qdt+qepGDbRjp78taf+aMFXOMZ8cPpDOKsRnFp4DqgLlCoF3C/arMIK0PwSYX
 rOkIWOu4b5Svl+zrjdZ3+G/JBX0F4d3hnZyRJKur7sxco7wf2dY4r80N31Dy70ZKchsWIBXXYMC
 ANUy+tNasm4RCa+l7/Ej8wKEWAOMbX+fuKXQSn6beUw0KIoZhJCcvlKJ9i2tPo2qpjvk/g7NtS9
 y6JUw8v4JJ5CTLz7nxHD9H+UxZSYx3T77MBWT7wp5NX+mi4v4fMhD1g6cy7kmqHtYcTMeij2s+H
 /O9Ov4P3aJV9/h0+nONhW4VJV+ThTzbxq2EySXEknB1Qvth4GcchM2QBo/LfWuACOjP84vvLCha
 37T9x7HXlSJ12njzQtA==
X-Authority-Analysis: v=2.4 cv=edIwvrEH c=1 sm=1 tr=0 ts=69c11d79 cx=c_pps
 a=/8oI+ICX6VsmSI+SRIYafw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=XmdC1-LukskQr8P_t2gA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: TS356BpNWvSr9ikSonGu7VEjnUkHWmfO
X-Proofpoint-GUID: TS356BpNWvSr9ikSonGu7VEjnUkHWmfO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230085

> > > +	unsigned int num_channels;
> > > +	unsigned int read_delay_us;
> > > +};
> > > +
> > >  /**
> > >   * struct ltc2309 - internal device data structure
> > >   * @dev:	Device reference
> > >   * @client:	I2C reference
> > >   * @lock:	Lock to serialize data access
> > >   * @vref_mv:	Internal voltage reference
> > > + * @chip_info:	Chip-specific configuration data
> > See below. Maybe more appropriate to copy the read_delay rather than
> > keeping pointer to full structure around.
> >
> > > +
> > >  	ret =3D i2c_master_recv(ltc2309->client, (char *)&buf, 2);
> > >  	if (ret < 0) {
> > >  		dev_err(ltc2309->dev, "i2c read failed: %pe\n", ERR_PTR(ret));
> > @@
> > > -156,6 +169,12 @@ static const struct iio_info ltc2309_info =3D {
> > >  	.read_raw =3D ltc2309_read_raw,
> > >  };
> > >
> > > +static const struct ltc2309_chip_info ltc2309_chip_info =3D {
> > > +	.channels =3D ltc2309_channels,
> > > +	.num_channels =3D ARRAY_SIZE(ltc2309_channels),
> > > +	.read_delay_us =3D 0,
> > > +};
> > > +
> > >  static int ltc2309_probe(struct i2c_client *client)  {
> > >  	struct iio_dev *indio_dev;
> > > @@ -169,11 +188,12 @@ static int ltc2309_probe(struct i2c_client
> *client)
> > >  	ltc2309 =3D iio_priv(indio_dev);
> > >  	ltc2309->dev =3D &indio_dev->dev;
> > >  	ltc2309->client =3D client;
> > > +	ltc2309->chip_info =3D &ltc2309_chip_info;
> >
> > Given only the read_delay_us is used after probe, I'd add a variable
> > for that and copy just that value over.  If you have other changes
> > that are coming in the near future that will add more fields to the
> > structure that are needed after probe, then fine to leave it as you
> > have it (but add a mention in the commit message).
> >
>=20
> As, I have no visibility into the other similar devices that may require =
more
> fields to the structure, let me revert the structure changes and use a lo=
cal
> variable to deal with the read_delay_us instead. Thanks.
>=20

Not a local variable, I meant replace the chip info with the read_delay_us
instead.

struct ltc2309 {
    struct device		*dev;
    struct i2c_client	*client;
    struct mutex		lock; /* serialize data access */
    int			vref_mv;
    unsigned int		read_delay_us;
};

