Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA363C4B81;
	Wed,  5 Aug 2026 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935953; cv=fail; b=ZT3DzR29zwSzhyAFeQQTfJcz8YmA6wk6CA/frfcyW2eLw30s/BkJpkr1TBs2k4ZM1xANdRVzQCDYxgP49AVp98ohs1mztd6wIkbor0FyDyP75Vl11A8IffoSltUiEuanIsgKJr3H9o9aGCTqFOpFcDpxdLyocJo945pnFVL9Snw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935953; c=relaxed/simple;
	bh=MSj3Yh39tAmy0/LxLaSA+BpXeFi5J/o0mwWQsgFvxGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lV5SRUiBEnFzN4rcd+iI5ugapL0E2bRqx2bOLoNDUD9pqvgVskxx83eiMtb+gHaStGfwA6e4l0CQYrj7IhI3MzZ9y9x4Nc8ZbAgJJc9x2oIUCWTiWhGu1zZZeQbOHFNQSXz6HCCagYb/MDDsoF/2IJ+pSwSfpytgyJhrwCzcXBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nHnLwWA3; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nHnLwWA3"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758dLVg1779563;
	Wed, 5 Aug 2026 07:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FcLRM
	UuJOooVFhUjZrowkIfEZpmV46D55yAzynrC/Lo=; b=nHnLwWA3zb44bPlC8OcNS
	NZoBCWNI6herisRBmkxp6zip4NSAJ2KnFeiI7IsiU02RA9s4rgU30R7eLkjTs5wN
	1MWv2cARu0E08UqDIwMkUThl1i6+GtMR/zG+mItogNvmXK+JRvNX+zdbJ//OMpgG
	1qiC9/Mut9bMn3ENMIuNdFfF3f9qBymH/IBOtSyGGd05J0g03BsSX7DewRETRxMp
	oNYGQ6Ir/CpjwZrbzjRNhQqDxJHlrWY0pbeoCGIQS8FKFIiow3KcRhxCnREgzMTH
	h+boPOcy/p34xAYbQTyuMBhz1S1YRY08yksvCnNKxv4aFw4lcdOhvYSPyHfkhVD+
	Q==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fu8g96td4-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 07:45:40 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZKjsRNGpEn8VzVvq7IDNKf/WzGAqxTiy+cSCwInMZG0QsRGEl1P+BWMwRbRq1eNCMG2YiuW3NXpR+HS3z2YUABaBuFeftr7RV1XMGW6KS+CJveK8w834KJyJp3CnQemJePjbzun3PsV1ZY/Fy3CDNAySHZY4kEifrxR1Sm3v8h+3XAnzZaWj4LanQfc+Tr69EceV/JN4hrDB0UERhI/6+jG0dERbswSeMNDhtztujOFqmb0b6d2hE8EGf5Qnh15EJlMv5WZhVrl0zDd0T3coo+lbOj0kuxIW4UcJDIJNCqpFjbC4D5zbKSEEyhga+nGi3K9pxbswiFwK3tAdtjWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcLRMUuJOooVFhUjZrowkIfEZpmV46D55yAzynrC/Lo=;
 b=IDmcGmXqoPI1ZlHjkhsy8N27xsl2pshCEkT3xs66Wxs8nNgLD22N7fZtxiSVCLVbW7uFoa1NzYRl1qXqxvj67ciT2isPcgBtaf4CpW31hoNpZLuXoa9xRTdAHWwpIqy2YyYivck96cHsKWLsmpu6o4VdeVwYC+ievGjDkov7dfabGWi/OSBilypV4524IaWQ6QeheotKuxxkZBgXIzOcXOyIHZGesR9rNI+vwwmkK4438lvvLq1NeyiZ1/z5LjTkbH813t8zOgaPjkPCggGUd0tu2dpD2LUdQGw/nmq7i1UGmRTVjd+wvs+naPLAAmlxM3PMq+qfHG8wQGayPq5N+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY2PR03MB649933.namprd03.prod.outlook.com
 (2603:10b6:930:116::5) by BLAPR03MB5409.namprd03.prod.outlook.com
 (2603:10b6:208:290::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 11:45:37 +0000
Received: from CY2PR03MB649933.namprd03.prod.outlook.com
 ([fe80::fec3:43b4:61ce:f576]) by CY2PR03MB649933.namprd03.prod.outlook.com
 ([fe80::fec3:43b4:61ce:f576%2]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 11:45:37 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan
	<skhan@linuxfoundation.org>,
        "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
        "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
        "Marques, Jorge"
	<Jorge.Marques@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        linux
	<linux@analog.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH v2 0/4] iio: adc: ade9000: add support for ADE9078
Thread-Topic: [PATCH v2 0/4] iio: adc: ade9000: add support for ADE9078
Thread-Index: AQHdIMbc9xCec/Orv0iPzfF3F8NqkraJ/0EAgAVemCA=
Date: Wed, 5 Aug 2026 11:45:37 +0000
Message-ID:
 <CY2PR03MB64993328B3E165CF124F5EF35F9BD32@CY2PR03MB649933.namprd03.prod.outlook.com>
References: <20260731082951.1228-1-antoniu.miclaus@analog.com>
 <20260802024406.6147807e@jic23-huawei>
In-Reply-To: <20260802024406.6147807e@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY2PR03MB649933:EE_|BLAPR03MB5409:EE_
x-ms-office365-filtering-correlation-id: 130517c9-2f83-42cc-8a29-08def2e7115a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|4143699003|56012099006|11063799006|38070700021|4133799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 6aY1bng9CmPYJ/BMMZ+zSWQTDmTSACg7TdHKkR/5qT6N4DGBsJK0zbu8EmhMSPLUKDdjo0FD9mAnsWVS1ut6r1oUG8zsNeFSQAlB7ayPzPVw9UrQB3yqTlVo0dxArbQWL1AzyIBQBLOASnO2Lkrti/ez9rn8pbZbTHGIW4QdNb7XB4FYrHF9Pmj0jVD0DG1K/XvKqMGBxyvwb29AKovBroXQfnZ+u1kbkMXssQF6Cx/ceR6Qd7nUwuJbuVn8YyE0q8kJuyWQhFHTUzgon6k5QIVoLl6VKaIAJ+EqXmatMnSeSzSQtCxuIn8pLN9NFImwQVzQp/S8fvpHW9YqRSMayjXSqIh+p9/StLC9q9+o84RmmBCZUQQq8DSqvq93n0c8bpMUihcqDiTNCV2rIzYfNsrhfkxQUlZh7uqnWqqUU7VRhZ+6rSQyLaWaRjUBzg1UnF/H9YvaAj6t8TgWRQ4fUiQrXYuDKPGVu482kzCF9L/FrRkVUpTfGNwe14+whM1imQRRxjVzX+xcbSDdmtoKQnliO4cEeDHTtEK7z9YLGv6MZNi7NOpXV9kvEEE7dP2YSHEKDx0vaj+Z1vzqM5C+GC/wj8zxrHeIpBdQSMNCrCFe+dtT5qvVvCKaiKBdbPKc596fHOU9mIqd5yN0iI1wVlly1WzVvzvErvrGVeEiw0U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY2PR03MB649933.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(38070700021)(4133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TmqG2pZaPU7weYEE2xC+XreB6Vg9bA4dj0UFTuay0abbY5l2HnQkIu6N9vtA?=
 =?us-ascii?Q?xBe44/FUK9X44s+9D9FsknY7YRe3ibsGpubjStWxPRDnneuiJ6HtEgtt0qVV?=
 =?us-ascii?Q?c01dFfu8mzYEoZjOI+Uyif8CEIJIFsQuOtz5o0BqjyA1uCkgBvbj1f1s733y?=
 =?us-ascii?Q?6Tot38C6UVzoFuSRLNeyA4isZIoO/M8GoFe7/tm8x7E5oL4nyqLJeWP2L0G1?=
 =?us-ascii?Q?8ItZrRKEaOEb3wNUD4idPw/VP8X5iG4lAZDrGF7lrYY8QWxukMgasEiQ/tam?=
 =?us-ascii?Q?4V8ro5vWlIYR+t8+2znIKlnrGakVz2iWgDEH4gcr979eB0vHDNt15i4pUhQP?=
 =?us-ascii?Q?aVB9Hhs4XzOhRQbexoRc2RVzA0Pa2ObRa/1XGnV0dfCvy5ra6PToXkdEFcx5?=
 =?us-ascii?Q?VgBLLoeyEm0vI9xx1Vpu5URPdY19KjW5N50IQ2YmDwu/KfqgdFY65mcY8N26?=
 =?us-ascii?Q?HibGnG3Rd//IAdWh8Zcjmxf7LBYIe9OQcU9IfGncs56t1BaFEf6dWUQy50fk?=
 =?us-ascii?Q?Z8OgxY8gPvrOKwod+aB8ZGnUVEWC2KMn3Uz4+9ap08BiWOV0aI/y/mdvvvCv?=
 =?us-ascii?Q?kNUWtNIdAsxPftPx20xDcOAYJHskzczEPNGToRmz5ngVCSTFsaUXPvvf86Rq?=
 =?us-ascii?Q?1naSBnbbh/Z1XOjZm8fJ0lKdbhVKyYakrsgGDCiYGwKwKOHnNcDUA+IJzYau?=
 =?us-ascii?Q?rlfy3sgRP8RSZGPrZgrwQ7ergDve2YcX4hwM1HIdDUEuCFithRwpnoHUGeak?=
 =?us-ascii?Q?vx5kjSJDvhuu3tYY+izuZZC6AL4bMHBlFquAmCZYSf8TR467knHg70wNo99N?=
 =?us-ascii?Q?gKdiTzrNTCwMOZLHY4JPbEF2FduibCBeYSx8P9fnl0mw4ZA5bLhEsBP6gKeu?=
 =?us-ascii?Q?61mN02zG0uk4vBs7Fjy33mhsfEbZud/qvEOmr+qnuTdvc5gb4cWADKkYIO/s?=
 =?us-ascii?Q?gpCa3HKbXNw7zypNORty0/UqIhu/uUPKklbeu67/V3+8pE2sYqQ/V4AUIpvZ?=
 =?us-ascii?Q?UmKUYeQaSCZu1hIPivkuVs42kEBS/+pb9n0aRF2BEEjGFjB76hLAky2lmbSo?=
 =?us-ascii?Q?YX6cOxNyj2MNkAPHfdCMa6uOaqt83ZAIjB+WpUFFxn5IQl7s4UAa6pBIoi20?=
 =?us-ascii?Q?AnIVWIa8AK0wDjzFIYHYCv7ETBoPnMf2964ZidOoz8slLB4N/6EQTS98lYm+?=
 =?us-ascii?Q?XIRxpJn51BgGDEEdYk3NhqsZp+tQ7Ai5LO/2nKWCQLwwJcjTgKQtKM9nOg6D?=
 =?us-ascii?Q?7C10yTNftiCPZuXt15bfTohw/AiwWmGJHb4eTiXw3+3DfXe5DIOmgFRTbAyb?=
 =?us-ascii?Q?o797fhexJKcf5DoZF4E+qkFTwKpXYyJfEtzqfrkczqkFiLRAkSuvw4OFKcDj?=
 =?us-ascii?Q?/Xj4zKCitnVYV/qy/a+YP6e/1cKedwewqEgGaOzmPo2o95e+VZ4fnoD1Ti7/?=
 =?us-ascii?Q?xbftnPn6X9AAwFRm++dXt8qSbSoIf7JJBuighmKpHhiZmXmBCuShGSdNH2aN?=
 =?us-ascii?Q?YEnF3OBxuHEF6CoxhHQqHo6rSoF0YaFZjz2fL8BPXK8qa2zt6ElTg4p/kiOh?=
 =?us-ascii?Q?cH07zb4+h6gAVJrrtftaxfIwjz9upYJq/C9yHuI/YbOisRy7KYRcbESzLa2i?=
 =?us-ascii?Q?I+W3ASzaMeNKn5Gj7Knsn3HoGgAZZ59ooeFUfvElarUnBPly0sWhXqUhAvpl?=
 =?us-ascii?Q?DAgMrV4Yu4/lVQv1BGrT/qREJSg1lIhjUqqR6pkipEiXjhCKGx+X4nwBUlP2?=
 =?us-ascii?Q?zUzSLr3a7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	GVMZ3Gb8neUTQxxQLlfswmTFOsfl7gQwnti/rFXhtsSpGZevt6u1lQDZ8R0rdL4xH+YuHM7D4Ze1WaG4e1FxT/DldVkhvkOQBfJ0nDLLi3LqAEUjI+LvE6M1QxmMXCJ98qRtGWCGwuRduS5y5Agp1lVzfOq4IBj9etVErLJcXOXaPUH9SXRBPE1EJb22d5hp2xLP2dFgE8WAdx8RVrte+eGeiCRTRS0LslaK3SzItxAUKbBX9JCEx0+jXQD9cR3XLm6rlysA4SiT62xVUXVsypoRzpfWwyHxkMEfvxPyb2/jKSIAPC/yBrEtnPru5j1PnYVok7G8h6qiiXPyHHeh7A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY2PR03MB649933.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130517c9-2f83-42cc-8a29-08def2e7115a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 11:45:37.5647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ApWbs2vw48UJjEb7tvai5Azk8rbZOaCltsa2jTn1lLKgYV5zaLA8AViZuWN0IEIEn8S5zSmDvehdK2/CTL2lQJRQNLYMQfn29ANwvO2g3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5409
X-Proofpoint-GUID: mWMbwOdOmYd1UxB2l_hvBGoR2ARP1Ec-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfX7/Z861BHjpoZ
 99ZAw7xflMcjokcHL0tyxzWNUkoK4pChlL4pgk3abJGbJJRGTJo13vfDrc9q4HwCD9JYVn8yzel
 tzBXBvRTh5XxAZfKNZe+BcprXTS7yVuEDua8da9yC3FA1mUkcQaquhGX5tW/Wgt6gvzT4qzCGrJ
 cGYDvpzLG7GshobeR7nswP3X9ecu87d/tn1tOSu4U7eX33lEvYrAuRjuZ9GfmRJcHZfWOyfAfU0
 D6NX6pe0Nv6IGKcN+po5uG1NoYxKsYsQtDefCJDGF1KIeJRfzzlGQblAi+Ei45Wn1urc71jLnVY
 9EgcfoOnADMbQoKCapiqYP5//EHc5hA2lmhyIV05iE7jG2Z6FzoDdJ48mT4O9GnPJTl443f9d1/
 GPsTihddYGsNJ79v4OUz1x9txKk6OH9kuDuMjaUmN4hh2WSu3Kc1gjHlmqFrOlDoywJrvaV2Je0
 M2XixYaaNSeKPnaScEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfX3SOHi0xJ1VHQ
 QU2gkFupD20KLJeSLJC/m1fMn7eFTQjaqU9vHxAZSfyIm8ZSLn4EGx+Xbl+KFscwdWSMpvl86dC
 Ng4fG6KFImvP8t7dvgSikqL+W+Iv53ayJ4ZflDcFp/mFQSBR9aR4
X-Authority-Analysis: v=2.4 cv=dMCWXuZb c=1 sm=1 tr=0 ts=6a732264 cx=c_pps
 a=7DaYBXCyACNMaGCgbs47fw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=uherdBYGAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=07d9gI8wAAAA:8 a=ag1SF4gXAAAA:8
 a=zd2uoN0lAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=qhxJnI4OJ-NzTIeLF6UA:9
 a=CjuIK1q_8ugA:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=e2CUPOnPG4QKp8I52DXD:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: mWMbwOdOmYd1UxB2l_hvBGoR2ARP1Ec-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050094

Hi Jonathan,

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, August 2, 2026 4:44 AM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Sa, Nuno <Nuno.Sa@analog.com>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; David Lechner <dlechner@baylibre.com>;
> Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> Conor Dooley <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>;
> Shuah Khan <skhan@linuxfoundation.org>; Sabau, Radu bogdan
> <Radu.Sabau@analog.com>; Schmitt, Marcelo
> <Marcelo.Schmitt@analog.com>; Marques, Jorge
> <Jorge.Marques@analog.com>; Salih Erim <salih.erim@amd.com>; Matti
> Vaittinen <mazziesaccount@gmail.com>; Jishnu Prakash
> <jishnu.prakash@oss.qualcomm.com>; linux-iio@vger.kernel.org; linux
> <linux@analog.com>; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-doc@vger.kernel.org
> Subject: Re: [PATCH v2 0/4] iio: adc: ade9000: add support for ADE9078
>=20
> [External]
>=20
> On Fri, 31 Jul 2026 11:29:46 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > The ADE9078 is a polyphase energy metering device from the same family =
as
> > the ADE9000 and is register compatible with it. The main differences
> > relevant to the driver are the absence of the on-chip dip/swell detecti=
on,
> > a lower maximum SPI clock (10 MHz), and slightly different full-scale A=
DC
> > codes.
>=20
> This looks fine to me, but will need to sit on list until the dt maintain=
ers
> have gotten to it.  Sashiko did call out some possible preexisting issues
> in the driver.  I haven't looked at them, but if you have some time, it m=
ay
> be worth a look the power vs interrupt registration one smells plausible.
>=20
Want me to send the fixes in a separate patch or within this series?

> https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260731082
> 951.1228-1-
> antoniu.miclaus*40analog.com__;IyU!!A3Ni8CS0y2Y!78esTjrnDgvdH9h_Pruv
> IpxZPJggP6_ge3-ecPnYKxN8b32xrwH3oUABtFHCRmEGtnicycd5eqRTn7EkeQ$
> >
> > This series adds support for the ADE9078 to the existing ade9000 driver=
.
> > It first refactors the driver to move the part-specific values (device
> > name, channel table, and full-scale codes) into a chip_info structure
> > retrieved via device match data, then adds the new device tree compatib=
le
> > and the ADE9078 support itself, and finally updates the documentation.
> >
> > Changes in v2:
> > - move the "respective datasheets" comment wording to avoid churn.
> > - use a generic Kconfig title and list the supported parts.
> > - duplicate the RMS voltage macro instead of a shared base macro.
> >
> > v1: https://urldefense.com/v3/__https://lore.kernel.org/linux-
> iio/__;!!A3Ni8CS0y2Y!78esTjrnDgvdH9h_PruvIpxZPJggP6_ge3-
> ecPnYKxN8b32xrwH3oUABtFHCRmEGtnicycd5eqTALKwajg$ <FILL-IN-v1-
> MESSAGE-ID>/
> >
> > Antoniu Miclaus (4):
> >   iio: adc: ade9000: introduce chip_info structure
> >   dt-bindings: iio: adc: adi,ade9000: add adi,ade9078 compatible
> >   iio: adc: ade9000: add support for ADE9078
> >   docs: iio: ade9000: document ADE9078 support
> >
> >  .../bindings/iio/adc/adi,ade9000.yaml         |  30 ++-
> >  Documentation/iio/ade9000.rst                 |  28 +--
> >  drivers/iio/adc/Kconfig                       |  16 +-
> >  drivers/iio/adc/ade9000.c                     | 180 ++++++++++++------
> >  4 files changed, 175 insertions(+), 79 deletions(-)
> >
> >
> > base-commit: 0b5e142ced4bcf20532da051934bd694d1bbd470

