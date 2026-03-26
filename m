Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D566A2D8364;
	Thu, 26 Mar 2026 02:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774491724; cv=fail; b=aUaMridI3LvMsV+fZaEyQNU1rFTYNpx2VyoEPZpSCL0g5PwHDLn6/lGYUvWA4mGnVPoS3aOfJra/Hnmkw5WTLSctMxyWTXT+0Y0EC0L/wApJdNrfb2JJv6S+6E4GFiZfevXof4YxO1TuNM7ndwZnpK1hWZ5/q95ctJukeduul1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774491724; c=relaxed/simple;
	bh=7z6NQld9TLEkbiMRhty+vg6PdwMbultxYYfstPznDIc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NtXj8D1LIXzbSOYzYM4i5E8NYRic6zJPLv+SnbFXXeOFF/pgR5qz7r9pY2w1Q7MArhBPvi77R4vxQwm+te5bJIIcdYLk2zuB9paXcWUj+p5AzFSz/ux23PZQnIMGb1ngmEibMet5Ntg+s8zvWJI0/waOq53MpsDhA568JXdZt4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=p4OJdGfk; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="p4OJdGfk"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PN0boN2316946;
	Wed, 25 Mar 2026 22:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AWc3z
	0J6pLBh/JcBzSlwZKq8cA8SnEIO9UXz/q9Nm7c=; b=p4OJdGfkBExBruNBBgfxF
	4g0VjyxMg0YM2zIptjidTJqMP2gz7Ry0KvGuBus2p4lS+TVwm7zA6hgFa3EAYAnV
	9j0I2SJNfNKM1V6UQV/O0RvgDMshQjSlLXR/uZn/zIa1sA5DJxhn1WBbQUXL4Yy2
	cVRgT+fT3/1g/mfX7FYJuDSvdnlkgln1XTTGtw04jhTVLNAJqppxguizzG4guImW
	blXPUocPX7Stb/LmLLDwvbmRyCNwa2kNr2xr3+aM1Q+VUAIuWHr0T7PPT9o0YAkH
	Bl2xnU/ekOKB3PN+271LXBz+hk4I8SonagljtfdGpQnCdEs+ghx3GyjTHMCvTUfI
	A==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013009.outbound.protection.outlook.com [40.93.196.9])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d3su6s655-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 22:21:32 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMnlND7ZjBuagLh4c9HSwuZLLtB7izM39AP7acSaSDlEVx6whG7rID3G/Tgd7bs8To0AmPZU4k9C7It5u763JjXCrSLMHd3Tbdax+7sgdvJEVYU5tE9R2cgwmZiO4ZR0Rdx6JUTfzrIdPHcOl3YwZejdVL/NMl7cdWATl5CfiTwvCEfQ6YzuHjxWvTWo5HFbcfWHGDEk5SY/OZmQd92kaT+3lhjagtGShQiIQ74EnTnFyEIQcsoUUfuXUZBD0P9EpFvqQR/4UKMKjT9xycxDexJ9wcMAos5FS/ZGYnC1NGuNuAUd85cPiSpRRjxq2PgBRJ1lLkyghLNLnO4BkL4KNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWc3z0J6pLBh/JcBzSlwZKq8cA8SnEIO9UXz/q9Nm7c=;
 b=uTc4Uyp7/4beYmD0bLK6+noIONqiyZsigTIX5zQ7ZHsosMbaBCIP/RkIV4j8WvJ7U9TEhWxNpzKCkI1A2jjaRqAnXqXsX/EGJ4HottFikuoI7oOaGtcBiAe8tayogagu2uhGwbL0TrjofSytRbZVlGnV5TiDgQxg2dKiYy3rXj8A8IJXau7cu9rT7rVqQHrm+zhsxtjjrFRZyrtS7LOTj1SptPRBzWMAYoPHs2r8J9eXrppimXiasSvd4WnBg54H4Acv4EA7FtRHnFef8OAd1qUvC0sRdV35oCLBMEqj1ABZLNgkRk4BQ7dueN74whwISMHGazikYhzMU6KxRt1iXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com (2603:10b6:a03:2d3::19)
 by CO1PR03MB5778.namprd03.prod.outlook.com (2603:10b6:303:6e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 02:21:28 +0000
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0]) by SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0%5]) with mapi id 15.20.9745.020; Thu, 26 Mar 2026
 02:21:28 +0000
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
	<linux-kernel@vger.kernel.org>,
        Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: RE: [PATCH v2 0/4] Add support for LTC2305
Thread-Topic: [PATCH v2 0/4] Add support for LTC2305
Thread-Index: AQHcvJTBf5H1bghjiEqT1mqbVK5kHrXAEGzw
Date: Thu, 26 Mar 2026 02:21:28 +0000
Message-ID:
 <SJ0PR03MB5854559AD0D2624A6251ED6FF456A@SJ0PR03MB5854.namprd03.prod.outlook.com>
References: <20260324071331.842-1-carlosjr.jones@analog.com>
 <20260325201931.26ca84c1@jic23-huawei>
In-Reply-To: <20260325201931.26ca84c1@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5854:EE_|CO1PR03MB5778:EE_
x-ms-office365-filtering-correlation-id: b63607c3-1dc6-4668-fdcb-08de8ade6363
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 kCY88fyUIv87IQwNnLSZNs3a4PIzcoVf4EarQS8iEGhgcU3VgNssrEE2eCFpf9rcqhUSjFzpX8IzMdmxyKauYeNj+LzwRixk+8ENEdCH5Akzr5WPVHo4cs1ua9jg6DE6dyug0aRYSSMxN7sfxMxJjQEzvNF81msVmo9Ham95xJwa7hWrPugMIJYvNHemKT1n6R5fUmmdjPdNjSg035DvqDoDQG1gqjBOJwsCLqnkV5Z/DRVGdVe/djoip9p6OHML60Lg10uCcElN/ASZdjbxd5iQK5do2PzB2ta8w4hZ1EG8PqhheayyhxqLnjzwdBsFBieXtrJxi3mpmelOOh2HhOCzT8C/W3ZBXiPjojoa8FIV3da40NT+cYL467bTDRQBBi3bJh+PsOjPJVHkgAWTljuVtRfAvNKZyLRfjpOU/Aquxj9tSBmh08GtvqJD8OhtDuJe0ZFkp8/5gSzItxypDRaMab9foO1EYal3U+FBcBMIHxSHI7FzozPXmypLsHZTzyrR9vG/9DSse9SqAydD/gVjSw3tlsFrEvgZ1zheGgMGVKJU3GwoWiLjvNsH8qKj6IRzNz0Cf8QqOX6fUYqiE410vewhB9h0YvIxCntzvw7ag8i5w9LtzxQP9UqpLbU8xSRwrRU+4gUu1wNPMJ6BD08GKbb8pVboS3dHvR1iNf97WYryQCygGjtIP5OojirVEOQWd+Fn2dUb9/vOC/Sux+fNqOtGGeJcbVrRdvye5C8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5854.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ugaPQZcEUjiGyQQCNAnwi4hatOOm7RDW6cs9GgzxRLRoSipat8bXgCVGf94z?=
 =?us-ascii?Q?4Kky4UpM63JJsYk1jf65rq1TnugYTnV4Dst+NQXRAaNsi+GZbQ+C4C/3aujj?=
 =?us-ascii?Q?ey1B53upeyV5nMlezJbbMxedS7cxU4Ro6CP2iNzjDFLHLsQ4uA7Fa+E17u02?=
 =?us-ascii?Q?5PsR9ifLvzMg3cxFwIbzNfOKq/FEp1fERCSgCnE0E1lbJquKMcrQlDscBwwq?=
 =?us-ascii?Q?MnW+7lg5DlNQBhamXYsEp/gj4oE8rS3+k+bMJ+d3vxQbP4fDJ1Ib3okarpRh?=
 =?us-ascii?Q?4/OSCklpDeC27eYEdfAd7BhfjZ5AGUBfXP/qTyAQ3dm8pkyuTjTZm99O29J4?=
 =?us-ascii?Q?4SYsw53ds34kSJxl87GqRVQbvupXkGtjHdAJzLCjjRTRhvk83/CUGrNSqBZS?=
 =?us-ascii?Q?kA6YIAfD1wQq5AMvMD+tMQ2IuwTzv+GtN7JCBEB0+kjEUqZBrPG1e8GbMbmq?=
 =?us-ascii?Q?FuQRS/q17/I7MCABCY9ce+nJ8Yu2GtQFv9L3AMqOnwOhTAzojVcSHV+0t6hT?=
 =?us-ascii?Q?h3hgFOg5acHhfveXM0gC/Qm40HPxbVBxLYJ88wBAS12V5HkMMoVHyAK9X8de?=
 =?us-ascii?Q?u31Rq+mCEMEj5XbfU2tYDPkLH2PfIP4ntE75y1EWT4WHRzHDoOqkqew6OqP4?=
 =?us-ascii?Q?bkCkmuIouhkSd7duenT8MiO4kRmCps95n1R9oASy3skgMK55z8ZEsfq35eXb?=
 =?us-ascii?Q?xBBjxY1QW+bRH7EEedUu8s1bizJO/YdbO/EZGDV0X0bgw+zR9muiJ63rKT6E?=
 =?us-ascii?Q?g178jQi/Eai119KKoVLrTH7mMoWkCqu4O3Yta3JxIJGtUrxvHO57eO2D+51H?=
 =?us-ascii?Q?KRPd87NeVEb3AOEiWrK+/cEdl9lvUgeNzYVQERdusj5h5bHwx5q8tHmnzcQa?=
 =?us-ascii?Q?FXj0IqFcXF7nMazL5m6GhL+xDCcFa5NHghINwGQQ2Y0xbHRuaPrhZy19Zvw5?=
 =?us-ascii?Q?VbiHsC6ELimn8A8b0uu2rOeEM7H0/hroLmmtN99/IIWIpOfhAqcg8LLfzSh6?=
 =?us-ascii?Q?ITKC655skW8C8wOozOKc5p5Y79TYFE8fDG08iiSNPZNR9VO0Sz8g7jJXUC32?=
 =?us-ascii?Q?w0F8FnzaO7l5eHAG97MTQTItMLmFV6b0KMwW1I++aFEb7OYtGR6vuHt/3HxO?=
 =?us-ascii?Q?JE73POi3XRXa6lFLiSI7ubsItWe4eIu/DBALl/VUQai0DvbTueY7BDgiSiOA?=
 =?us-ascii?Q?MseAwsgdWS3gH+m6qouUDg114tsPA7qdCkpusGgCJU3bVkg4BIRf8vuhitof?=
 =?us-ascii?Q?URFyiEDGjmLi9OnputDawPiTQZNdqFbRxWel9YO2HyDG9BXxh6o0+ExHs3Aw?=
 =?us-ascii?Q?OObDKFq6f7EUgANvesprP+aN0+z5xhv0DVF0aCh4J1FT2cVmnn0w1DUeo6BD?=
 =?us-ascii?Q?ic92Ntk7Jcwc8SfnqIF/kdwGTR8dGtSSjvIirkXWTJpDuXznYybYOJRdEXm1?=
 =?us-ascii?Q?ffh1Nm9d8rvkE05oGJyaOssECn/0JfbVhXhNQnLjofWh5XdT6B4S8CfrBj4j?=
 =?us-ascii?Q?ZYNzI52wY/JUoxW5XBRpmrBOm/kopSU8YMU7SC4ValveeJv/LEkieotPtYbs?=
 =?us-ascii?Q?RRjmuUvwtFpEoeK5sic5SDfQPOZJ4IFS5I4yJ9aBGqeSFczOaeuRdMn0eGQc?=
 =?us-ascii?Q?kWIhrtG5JGmCatsUKC4ugr8A9x8dove+TS58P6LkAiuIcBAmQWHoh7ldtDP4?=
 =?us-ascii?Q?F2zAQERTZE/ejURtSH7jNeXvrtWEvYkAUsT22ceyK+Q0aKh9r7LBAw/66hSv?=
 =?us-ascii?Q?urGL7Fp2DQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	oneEkzLmtJL7AYkAN6NY54IrLzAXxYbW7LeOLjijkeSyCaof7LYebrVPcGSFUWCfJysdB+Tc/88PjofQZ1c33RSAsEW/taN00LyzdRSNAv1fZn7DkOtojq1RBddQDLLGUtcnW5TTBMsQtXvKbI+uYHkbT2VcbJioM23HJDGhVVMS7axvMfMixjzx4diwjhSsCWAq1tN2bSjtvZ++ge+Dh9N31du6PKdF3z/KRagRDECRXX6YtN+dOrMZzskPQWHhWTnUb4xxvupwvyYz2XrB2OkHvnGVSWHgiZZbLScJl39IIxd18eEjojSdeqTDwmTvhO/N9O1FEiIu2eoHiwh9Vw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5854.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63607c3-1dc6-4668-fdcb-08de8ade6363
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 02:21:28.7925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /OGmGKjBWOBKXwtArzklvY8PzWk+jh9rh0ZTcdF5hGs3ecmsaeA8rgf0ApsNgmoRlD8uoFkSwNFBUcn4e4HIuoLctWDGBfC9Yye714+0PiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5778
X-Authority-Analysis: v=2.4 cv=GtlPO01C c=1 sm=1 tr=0 ts=69c4982d cx=c_pps
 a=bZodHm7PKOcb5V0TIM2Mhw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=pGLkceISAAAA:8 a=609-Az4yxnQjXx3NYlcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDAxNiBTYWx0ZWRfX0BIZXteds33/
 qVvcyr8CJTwFKUwDIqygW6rplllclIWt1Xlu5YSSSCrZ1VbM/A0yaV7IMg9coaHoCo2Kc8OzLfg
 K2YpC46H/2QaOS3K3wmB2iHKYfoM9B7yQR9/mzXCYdAksiLcLstg55WEHXBUMBFPddlAcGhR4WL
 p1uegALg8m/zV4hqhP3rxnAdaJx7rQcD6DwrH5vil3FKhxeVR3t4Glopaj8rxfpf0vlIMxibEvp
 ENIDc1liTcpqCUslAblboBSJ4IgDAB2XPZJDPRDkDntvAqQVSTfvfFWsVnDptiuGClxDIwXAvEr
 tlLq/6pNJYN4GfEv7BbsSuiKHB2vYKigI4kHU/SqJmtZE5/bQv0OW617Smf6uOGJowIRnD+oKa7
 u0I+fUOGOuU4fswdXuQJdR2aMmu8g7jKDVlniZCsAiAFWclc3hVxBuwQF0CFuKBnkHkxhtRSt6c
 9zcec3jIrNg6OorEWyw==
X-Proofpoint-GUID: jOkaPhjFCm3ESZ0zzjNa2yloRh-4tfuY
X-Proofpoint-ORIG-GUID: jOkaPhjFCm3ESZ0zzjNa2yloRh-4tfuY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260016

> On Tue, 24 Mar 2026 15:13:27 +0800
> Carlos Jones Jr <carlosjr.jones@analog.com> wrote:
>=20
> > The LTC2305 is a 2-channel, 12-bit, fast ADC with an I2C interface,
> > compatible with the LTC2309 (which has 8 channels).
> >
> > This patch adds support for the LTC2305 by introducing a chip_info
> > structure to handle the different channel configurations between the
> > two variants. The LTC2305 exposes 2 single-ended channels and 2
> > differential combinations.
> >
> > Also updates the device tree bindings to include the lltc,ltc2305
> > compatible string and documents it in the Kconfig.
> > ---
>=20
> Whilst checking for what comments were in v1, I realized we have two
> different people looking at the same thing within a few weeks of each oth=
er.
> +cc Kyle.
>=20
> https://urldefense.com/v3/__https://lore.kernel.org/all/20260325-
> add_ltc2305_driver-v5-0-
> e0d29daa54f9@gmail.com/*r__;Iw!!A3Ni8CS0y2Y!6jxk_dJQLHUO4PVi3Oca_
> VzVHN-qeFu-y2tE5xXMwuy-
> x2UFG5Fn3KO4Cw15QcDsqTCgFXQQLLRQrdgokg$
>=20
> I guess this is just a case of neither noticing on the list?
> Too many similar part names, so I missed it until now.
>=20
> Currently I have Kyle's patches queued up.  All else being equal that see=
ms fair
> as Kyle started on this last year whereas Carlos' work on this is much mo=
re
> recent.
>=20
> I'm seeing some small differences. Please could you work together on this=
.
> Ideally send any additional changes on top of Kyle's series.
>=20
> Thanks,
>=20
> Jonathan
>=20

First off, my apologies to everyone for not knowing how to check for
existing upstream request for the LTC2305 device before working on it
and wasting everyone's review time. It's a learning experience for me.

But it's still awesome to see how both ended up with almost the same
code after review.

I'll reply to Kyle's series to ask if the delay for LTC2305 could be includ=
ed.

Kind regards,
Carlos
