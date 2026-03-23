Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013037E319;
	Mon, 23 Mar 2026 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262373; cv=fail; b=VTCLWZ7Daux6LZLdA3LaSVuvjjHbMmP0VOf1Ae2LU0EsnpDgSo/TmZWGDHk5LvE/6vEAyy+bZEB2R6pIixyx3/ULNm8qfaMUG9C9TPBW/WURFX7BZ2GRbx172f1v7pRkJ6PaO2DTuH0WOqrNyPPtwOZ+Bx1RXL557WZ33Rd+NEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262373; c=relaxed/simple;
	bh=LqR7OkI9qmc2SlHl+KiCS0v4ZSdnl2A4VYEUN3B8NVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IZZSAeMwTWAVwAr/tNUzkKBqD4j4iqRsbZORTzro3qT7zIMp2leuBWpzBuTLS/LUJGs4tMBtTXA/r0OYsPsCRz/548u5SbRsIqsS9BwcBdL6dNNmEu2w2vi8O/QPWmV0C86+cY+Ssmtft2+10Nfb8cTyx695fc5n+7tH2vlE3A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xj33YgOB; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xj33YgOB"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N9TrZ5662592;
	Mon, 23 Mar 2026 06:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/gSR3
	DhZmS90+kHCgYxya5J2pmG3jhtx5LVJgXwZR6k=; b=xj33YgOBCnW3wE72jrjAD
	cv8VdHOP7UFGayN91WaV2um0Afk4pkodSo+gak4lu/rkSjULv+8FfGWOdUGVz3GZ
	hTb9dQNF1pa1bJlegccDLyUHbngoOdoFQWNIoLWGhesGZ6OnBgVOy797aru4Tkja
	ViCnRqij6UQQ8QFuPpBJfO+jtSm28L9HrbEAqfuvBowrT0VomrW5yC1Yf88OuyaA
	pWNr5TsCFKgbY6ncpWIrrY8vv2Ye6gmK9LqF747o/6lR+hqpa2ar5mSypnR3uLPM
	SKIno+ACx4iyJOwHMx0V7RA3wG6fuKlhLG9uSQGlnCGUqLKnXMnurHXepQFRyGnJ
	w==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d1n61y6bp-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 06:39:09 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3UqXNTOgXN2DZH/z1Cpv7nTC32ldD20bVGBz6b3k7lWAErtf6LTm8ZCiLFusRLLO8salXOJXxaHLK4r7/YOYi3cZNLAQWlSBKWQTX4t/g0VXPbOUH6/uuvjD0stKZzTMGjnhUA9wC8m8ydoBS578sJqKhKKVfRq+lq5hMb0eKFHGsjeoZpx2/+mmn9psM3cVc1bxJqSUDkpShZ1VqzzM3OI7pSJjkpVZoexOSlY9KBt6mrjfSJUEF44urxZ/cbHqXabWqgAaBvDCgqxf+KZk/jEbZJoMzw9cyHkBMBLMSAG0Ltwt7yIfpn1ez2QZ0Mq2v49H0z/b0lOon7SVEPZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gSR3DhZmS90+kHCgYxya5J2pmG3jhtx5LVJgXwZR6k=;
 b=pW7GGd5BZxs4eaebqm9sZfv4RROR1lnYBN1bRkPoFqhzZbj0KQ4mzprbXwy6Ul9ph7l/quKviSIrREnO2C5/nZDXi/UzkDvlNyrWxdVnl+AO+g1Oc8w7Vt7rZDYdSU4hdvaot1MnqzgS5rISVQldRJv8NgsaZ9nZ73ht++VCLMpGJLkyfgjnamBLJJvAYX8EeW6TCrdpzHTLjuud+lvZhGHksxdKbEQDLI1Xz44MZhRtOzhgKLjrdrkfIjWO75snZTDyQRUVrF0tpTh56Ebc4uQI+jk9d5KvTay4VImIaG1QtxWpgFUBYsVc77TcT6sBMyzqbCTUUYMtGziHpU6Zbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com (2603:10b6:a03:2d3::19)
 by SJ0PR03MB5568.namprd03.prod.outlook.com (2603:10b6:a03:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 10:38:48 +0000
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0]) by SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 10:38:52 +0000
From: "Jones, Carlos jr" <Carlosjr.Jones@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Liam Beguin
	<liambeguin@gmail.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Tobias Sperling <tobias.sperling@softing.com>,
        "Marques,
 Jorge" <Jorge.Marques@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] iio: adc: ltc2309: introduce chip_info structure
Thread-Topic: [PATCH 1/3] iio: adc: ltc2309: introduce chip_info structure
Thread-Index: AQHcuHgEe3H03sR5VE+cKMaBgU+vfrW761FQ
Date: Mon, 23 Mar 2026 10:38:51 +0000
Message-ID:
 <SJ0PR03MB5854895433AA7E5F31819234F44BA@SJ0PR03MB5854.namprd03.prod.outlook.com>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
 <20260320140819.191700-2-carlosjr.jones@analog.com>
 <ab1dNoC6dg4X-Yml@ashevche-desk.local>
In-Reply-To: <ab1dNoC6dg4X-Yml@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5854:EE_|SJ0PR03MB5568:EE_
x-ms-office365-filtering-correlation-id: afd24bec-a0fe-43c0-ff9c-08de88c86010
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 8TuOGPB1GdqnboVBRxsvwVZGMzJqYpuW6Yxi/7rtblUwoSFLPW0QHVgAzwiYz781o3/02QobBVoJwCvs11CouEJV9d4IMtTTCVqzTVGjPK2y7QuW029mW0jILLMeB1KFL+xO1TTX9MQWl9EKAdhE9MdbzgwBLa94UttRIBwn6b3OH0RdKYV8uk2GaC6UvIhM4f4bqyV4rdrB//3unfBBV9SdjRvvFCgXjkZm0/0msa75g7Z6wQswMrmohsR0JAxRO/0ZSq4E63//mwg1xQKYsiXAcly/3W9++N3PAL6X0jrojSTpAqHdoTKnNxuWh/pMQl1cy3HnPx0XJ3Rmt6H/2eOlnsfc26utqQOKNMB+ANysk6EGxnTwdhJ3XcQ35ILVvwhg3A4/aYJCFZNhm1jQbPm/7Eyl2p11IraiGnghupL859ZRdZ1WLh6Sk2o9oJp5BDxF3LnKp6jWEqE1G/9B+UolrIZoGbm9SzvqqSMKIv+xaxOXyjPVqF2Yg5VMwhqFrdBUH9oTXMxbU2haveq6ZaKUDavbKkObpOiHngVER6V/BBQaLMantTbb1lMXrHTGNvusXQIXiqbPz+tDFCN4pjqV+gm3A9p/2pVUakUrPXC8Rw0HlB1Xzo4RSyBeyHuvJQv1JbmkRlHiOJI0XfMQM/4AwT6CoNdzoxFNcUio1LZcdmn/a2+RpSKnkyHMYjWfi1FcQN9YO/G88Ilfs6M8GipZMRuN0KjZejYd0Ty3LlGpxxhFJS0R/Fv1Rau0E1ZxYVzliu3aXsiThv3Mc42k/2LsiceUY6K66MxivWPy3As=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5854.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PRO0VGB36nQOU6jWCpvDmSFZfrobAi8Sv4N9xoAKGvqPKKc5i1jkFoHv4DG6?=
 =?us-ascii?Q?Bm9si3aHgogRqRI/zKxM65ZyG4TyH/PBmjmRzkLl5LSn+BrbNFvV5jO8X2BN?=
 =?us-ascii?Q?9Ft05cZPqvtzGfuBTYAA+pyR5XXVQ6FOuZIKMQgvKQI7glPBQEIKi4nWOZC1?=
 =?us-ascii?Q?TtOzDd6NVBUST4GUML8XAN1Rtqyb1eeXcuakxioeeNP1yFHpjXauiN7bEV9Z?=
 =?us-ascii?Q?Ufee42FnqvrPwMFxYZSnQ8Zokx6eME1yrsyRqkcE9XjlZfttcAd0drDILEBI?=
 =?us-ascii?Q?6xFBKqwDYMhiqViUtWnNbiDF4tWMBybVSbkrotJu5u5iG0DNOosnjgvN/g0F?=
 =?us-ascii?Q?yoa80jZ1GMOphRSTGrtesSQX9YPTx+stA1MZ/aSfGw51ecQU0jipT/T3q6rC?=
 =?us-ascii?Q?969tJzOX4ve1Xp97MwEuQ8xGdLUoTEkxemAemc9BkQARj9ai4Tj5ky35cTiX?=
 =?us-ascii?Q?MMzPLITbR6AKGl/LXddfg8kxlZJadUYxoIObbctkvYzDnuNFm2Vew+V6xzhf?=
 =?us-ascii?Q?ilLFhXrEZpjP00SIpZN6th9+mIrGxdDcUkCy+yqwdZcubpdWLpH84bQgvuIM?=
 =?us-ascii?Q?AALot3yZoQuzUZ3FZQR9j+pv3nhU4W81ZIlZ5Nvhfixj5ScEoRWnLj2kBr2w?=
 =?us-ascii?Q?iJi9X/lS/59yC9Ts14xyauseo/GS+etRyYH0dnNrXGcDkUj03TbZgLBvexVh?=
 =?us-ascii?Q?SfVD/l2y7Vkzv3apw8O1R1lAj+9JX7TFTN9lq2mFNxXHvSFEsZJiKgUdFSf1?=
 =?us-ascii?Q?DmHwZ6uhR3hLrKvPte1wP34uDZ/GznXHNBlWmH0Uyxlr/EgbgICynIKSBnph?=
 =?us-ascii?Q?NPaj6t/dDA2tO3HvmYBQvKbm81qMuF7RMwVGNmPjrnNMMAKwdXSbuEbGHjq6?=
 =?us-ascii?Q?JnounyzRnUedlO6FS2RGU9i/JEEnFCOCHEIk1NW5hp7vuWtx6f8dFUCgrrK0?=
 =?us-ascii?Q?ZBxj7XeZTgxcMjyFEkPRZHNo6d78/SP4QEw1uxaa76wLhkh+L0Zy+YjLf9yJ?=
 =?us-ascii?Q?isRkS0anzpo/jNlN4jWOTsoB87eRWqsZ0S089FBz5hplnJpNYS83dmSTcB4E?=
 =?us-ascii?Q?+qFcg2HGTx193ygWaCxlG8Sfa/9ou4OB0pz1YnUEF1uXclaVK4BGEMsi6SHn?=
 =?us-ascii?Q?zLYOO9jLIAD/QdKPKkkXpCdUPIizP+CRnogrmOdGOFQcSwMXdLU6VXm2bcRy?=
 =?us-ascii?Q?jrVHmk5pLaOx4m2fXqKIRMgjOc3dVwU7U3RYEh/NhU37dIQ9+1qKp5gap3mM?=
 =?us-ascii?Q?fsW0kjWkowlWcJqiMizImd5Wn1PGo1wt1BAj43N0c7iWXr0BbpdDtVSdzKQl?=
 =?us-ascii?Q?qsRsDwZH+vi9HN6fFEz2IkeWmCJztDD1wk57Ik/W44T8+9/+FY4cyBl/wvMh?=
 =?us-ascii?Q?F5CxdMmdlgLBSZ9fTlwTB1Avb19Ha1NG3bM/rE+TbVPjAaVQgUuAN+doohLd?=
 =?us-ascii?Q?nV7Y40f6SG1gtYStS8rnzGiwCMc91sstStyGH9RVdbK8KY0CzQCmAImMGsZr?=
 =?us-ascii?Q?SHTOPyXj/vZq+qXCM/zf84eDW9VsVMioiJIF5pUsEjsusUN7QwOqICjMpFjg?=
 =?us-ascii?Q?pjGlmHMaTcMHsa7o4gD8lmkmqPj58bLS++rFEe2ED8WDuV8O7kUEqSippIKw?=
 =?us-ascii?Q?hBycYY3A1nREQPInVKJofxVpAPJWR1kuePJdU+q32IcVkbDovuL+Q1D69GL/?=
 =?us-ascii?Q?sm5UKyrChJIdGC97ZC5U8g5Hj2fJ13DNInjnUYbslzu8D/m130CCl7b5O/fR?=
 =?us-ascii?Q?aibmpVyaCw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	wTO8cZUGmuECh2Plz/7NiLGILqdgs0AEeNil+Ga2HZE3J1Ld+GSZbqIfbuUzSfUDc4cPDO4wxXIV4bj5ja5jFHdMWmdFOLx2+aBvWfNfb2NbrNbejV/X8FpjDb5o5oFA/fSf0uf8v96unAl9UQsXQMjF5OUilQf01j85a6/QSExTH+sqe6buxQfJLvuw02NwRD0N3ics4TPebnfQE1OUcnTpzLVvqhSihVwFJYh3JAg07Cwsb4FDZ/QFsi4MRFqVuYGXaBU50ym9VWkOZJss1+6bjdoonteyCxOS2FgIS8XHN706F0JvkVZN8xLLlln1ZdyeSoSOb4LFsLFDaLq4bw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5854.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd24bec-a0fe-43c0-ff9c-08de88c86010
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 10:38:51.9027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chp0rW8cxIMeKLhlHYFwVdL5nF7qtgPRIUtTkK8JG3s3uL481/gepfQlll3Af0Na1UlGYNwa4ztPUfWWBKYecIP95jPYlRQ/CG5QXRxn4mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5568
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MiBTYWx0ZWRfXytf92a8qNEWL
 T5WR65YmcwCvcwFW+CKIjSX9gAru9f/nVX43IwBPJbGPyN2hnOuhkPMZwRh2wCw6D5iNpzhdfvn
 IK0xR6uksdgxj9LnhNCj8BPNJcvQlDWqVdBUqaSEU4Jzh9So0Lc8OQ0iTEPc/AJPx7A3/dZwZK2
 78ApSxILRLAb2a1/pGMTBEYFfDC+iYgC9ydoqqbjte96i0a4+8CbhF88kTzwr4FpXOUqz4I8eqC
 TQguWNS3IxvzfhKYvVTtcfJlMyUUjyAap9rvPx6p0E4qzPu+E/6gr8r6jgrygYn29fLllp5LEkg
 HMQHeHqj82m8R+JSvZOzFPRr4plJnu5F8sMgHDF1sWjw4CmmO6O15STjYb9zNiCUbq5KaxH+8SX
 poyVnTcpk29gIUarcfCYFOytR8vqv55MJmBY97Gx8EG3XJt3sBXL1Du0TKJRTrlk4uexKcD4ouI
 DsP+TeizO2QkgWafLEw==
X-Proofpoint-ORIG-GUID: ZAQuFM08oFSCU-eA9gU_vzoiH3sAy03i
X-Proofpoint-GUID: ZAQuFM08oFSCU-eA9gU_vzoiH3sAy03i
X-Authority-Analysis: v=2.4 cv=D59K6/Rj c=1 sm=1 tr=0 ts=69c1184d cx=c_pps
 a=aQYToRbhQZUme44wGBfxuw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=6nO3_wiFsvoHn8V9W5kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 clxscore=1011 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230082

> On Fri, Mar 20, 2026 at 10:08:17PM +0800, Carlos Jones Jr wrote:
> > This is a preparatory patch that introduces a chip_info structure to
> > the LTC2309 driver to facilitate adding support for additional chip
> > variants with different channel configurations and timing
> > requirements.
> >
> > The chip_info structure contains chip-specific data including the
> > channel specifications, number of channels, and read delay timing.
> > This change does not modify the existing LTC2309 functionality.
>=20
> ...
>=20
> >  struct ltc2309 {
> >  	struct device		*dev;
> >  	struct i2c_client	*client;
> >  	struct mutex		lock; /* serialize data access */
> >  	int			vref_mv;
> > +	const struct ltc2309_chip_info *chip_info;
> >  };
>=20
> Have you checked the layout with `pahole` tool? Does it agree with your
> choice?
>=20
> ...

Will revert addition of const struct ltc2309_chip_info *chip_info since it =
is
indeed, wasteful to carry the pointer to the full structure when only the
read delay is used after probe.

> > +	.read_delay_us =3D 0,
>=20
> Unneeded.
>=20

Will convert to variable to copy this value over instead. Thanks.

>=20
> > +	if (ltc2309->chip_info->read_delay_us)
> > +		usleep_range(ltc2309->chip_info->read_delay_us,
> > +			     ltc2309->chip_info->read_delay_us * 2);
>=20
> fsleep()
>=20
> ...
>=20
> > +static const struct ltc2309_chip_info ltc2309_chip_info =3D {
> > +	.channels =3D ltc2309_channels,
> > +	.num_channels =3D ARRAY_SIZE(ltc2309_channels),
>=20
> Perhaps you also want to add (currently missing?) array_size.h.
>=20
> > +};
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

Noted and thanks for both fsleep and array_size.h

