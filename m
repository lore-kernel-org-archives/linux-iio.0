Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860138CFF3;
	Mon, 23 Mar 2026 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262401; cv=fail; b=jY7TRnPPkaEvhZo0cTQIStpFt+Hpdg20DPN1hy1L6s3bKHEsY46pizsBsjDHyjNhC4tGut8qS3wtdQxUsA9VVsVkjtVtZ5AfF5doKb8iAvHC453phzRhyBXSPsZt3/v2kde+JolDcah2AyAvPmaKwVycXhGfOnQN23cqW1JaPkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262401; c=relaxed/simple;
	bh=emM0tnE9jZjQJrI1Law8+MdDJOMWdnKwjB9z88m9ZaY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qRTXkl9eShxmTxgEtidnslFar+xBfYk22CMPA9fN5loE5zVA7tGsznJrvU8gFhK0qmk7VF9OAPD5VHJlhhb6rDRQCEB+xNFxsegVJIK3ctc8V+ldTKXL1d8c22F9sHE494cqIZUGA5lS73OJMqCCUoJ7N/r4LDDeL0aLOiM7U3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=koIu9bBf; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="koIu9bBf"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N75DOh4072652;
	Mon, 23 Mar 2026 06:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OrPxI
	bru7+Ytz/1GtUtFrYICMXeTbg6b7GUDULL3BgE=; b=koIu9bBfE/c937mGSv2Ei
	+s8R3UKYyUwTtjqv2zMj7Aml7ius8Y9yBWHEFwXXcyXBbZi2MgqWnMLuIsYeIhey
	1W0xIqIuRZBVnYNWlS9AKJwzRSetQH3VpBU3XgxBWUYlCUOFdFDiMIm895dcKR8L
	zL1vDbqy4YffnxrTYx3cWTisqpM47UHrMX1q6cXu2tUhEBF+tXZegCogWe8Ir8WL
	t1zaMYwL2F4+8FyFwhtgoU0QXuywxDNweJZLE4H21YtVN9r7Q+F8HL7sb6ySiuqX
	F1QjG4iL3ANWJ2hK+mkAFUyGZZWwkrP5LKs4HzOoG371TWS7R/pOPHmEQ8RHCAQ8
	w==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d2pxqaq96-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 06:39:39 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/nBNPJzoohWKY6wBMRa/mZdSZErlfR8vCWW7zuRPem3dB+DiryebOO7+95gUyTFk2crDEBGXCO5BXlaPMr5JkAuad/64/FAUsfVdI/022T0gpN9O/bpQXuENsBJ5sL/AONz3JzlZvEEcQ8PoiLwUVc0VdCcgBQ1xCL+2O7QhUIixIsXQQBOQg+B1u3PXJJBVCFS7EQkxvV/5IqRf+ryQHGsSuv1qz3EOdb5O+JZ1aGjyj2G+ATlm0zA6LbXuIySytod8iuYbiltgUhzFgLZu7e4Ts2FlMjjw8JXfmw6ZzNIh3gReqtPFr2327iFFnMsWoGRqxCXGBUcRTJX/tVd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrPxIbru7+Ytz/1GtUtFrYICMXeTbg6b7GUDULL3BgE=;
 b=ntIF/FR/prx61PYTQj0Z6M+/QMPL3HsXD6XTLxz3V3TxcgDwNsVFIp69Ewq8wm1RKKeL5TNCrlxWXAV4P50NZZzuDEwSfRiijyNiunTKPsAZCxHByJyd6Sc87Sk2o1TKCb2SADZ8JKwNmgjzNJi+PFzVfYXe54q99IiR9i3OOAJLPTs5dmiQIwWbyAsluGCaJ+u5dH9uxg5Z/5jrcPmyupPxa1HxVREF4qhKaoxy+SiMk+ADnhhqL2id4jXrkMlyQNcZIhr8aJgg+zaneLUXDitNU0GdQM8rZz9rDnxpDnNnAlvfIlmAeS3wkpWBIVAHcHbhb6fYviSG7wIXSytUjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com (2603:10b6:a03:2d3::19)
 by SJ0PR03MB5568.namprd03.prod.outlook.com (2603:10b6:a03:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 10:39:18 +0000
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0]) by SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 10:39:22 +0000
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
Thread-Index: AQHcuTFge3H03sR5VE+cKMaBgU+vfrW7yr/w
Date: Mon, 23 Mar 2026 10:39:22 +0000
Message-ID:
 <SJ0PR03MB585454ECE02067CB36FD9119F44BA@SJ0PR03MB5854.namprd03.prod.outlook.com>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
	<20260320140819.191700-2-carlosjr.jones@analog.com>
 <20260321125103.516b984e@jic23-huawei>
In-Reply-To: <20260321125103.516b984e@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5854:EE_|SJ0PR03MB5568:EE_
x-ms-office365-filtering-correlation-id: a924ef3b-e1ff-4885-baed-08de88c87278
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 ceHsG6O/myAqVLelPDOH5wgpHtWZzWdYOao1aFn+G+IYGGK/VFqVaghaQbzs/mnC2nMk7p7TzQWX5Wn2tLEHQTaiGhBJTQNUoEVnK6oxGDV0F/RLJIFiUXMjGw/AldTR7Ast1y3C7Ys1+7U/xJnltYL7X/t6AkuDuj4njOYSDe2y9z97v4VC8MhcXVtaSzMVWVR/N11dJW6NlK3ArndhA5orEuPrsS2VdzdZsY4uqmdeBcAi0jBlzaKGVbAtHAsIPozhB0N54PZLZ6y/P7Vx9XUeCUKnDTdc8f2md1ozuIfKZ4urJDXsEWf6oZlMU3NKQPugSDG3gfScqzllOdjaVwosGyXgtnXqN4XYvG7AiVS0Q3GNeKO/Hd2/jhRxOFi2pNBvHNY3fJ+ke4bH/RMeK8RYTzfreggTdPTRL+QaH5rxCkeN42TJ6I4Kq/eR872psW2qLgutOtK9JfRk/loc0IOfUwOR/GbjDBsJTwwHd5rPM9Bi5X3EPxgPZFVvicaQzwDweo62BTISI3Kzlbsjq2isB/GF8IzlKH0OcbQdS1HXr0B3gLEWkSgeoxsMhqHBHH96mc6wKX145Ext4FMFq1rDwCdajYUIovHEELxuyCEzzYpMsqlMQTSSElBK4nEyJ44bwJQpd4LIvnyH+9sVUiWIsWe3pj/AqDETbmuIqlT/JQa48/9q9M9Cl0/1e3gbYyibvzebwTPfQO+QVwwi2ipMgZwRCL4tZlVE3a002xTLVk2keXO5J3kEszjnRnATJxf8Usd9XPPO7yHuzc4cRUDYQ5vWQ/6oOvI5aTN4+/o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5854.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eXQodkoA1WUESTbJFr7vJ7qdpETkqoygo0V2izfe+ux0ci1esB8alrS+6VQZ?=
 =?us-ascii?Q?7MU52vvrKzFNrfHWOBANgDFX/mBwS95D/QLWSSzXZ70Phgd/yxoDUFB0MRyA?=
 =?us-ascii?Q?YS+U57tO6+AQigovogVoahgbAO2s71F8wv/Xb6gPZILTP29w8i5K+2lsb/le?=
 =?us-ascii?Q?WJlJY8/K4RTNd+pUyF9W+UgiqRl+UmqOWqRQoZX914TS1oy7R2B1qIbC8qOu?=
 =?us-ascii?Q?LiOqXO4F2FbVdZPFjj5Q/h0l6V7Cptq/jtTyDnCdbgMYlYySIiadGSzEXLk4?=
 =?us-ascii?Q?xPXLgA5YoGgiRAfmraAOHZLDBF8+n19WZgK701dTjw4OSxhjs8+KPhQeSAz0?=
 =?us-ascii?Q?f4hPnYuztQiSPKE4WevfG9ttN1JM/q9cCPyISqrj3Q+WAO+i6vIRrnV9SFBc?=
 =?us-ascii?Q?JD8khZuVZlOSPs5zlJsMB8A6CUKKg4Ulp1O/QK+Z2aWKp0WKl5fURU/OAkrV?=
 =?us-ascii?Q?ETMW9Fc20IDiXdhiD9Qe8iRiWvIh/zkS7sENt9VEmz8O0arHvxtdLbTf98A6?=
 =?us-ascii?Q?jYEJba3wTYjiZr+kuOgOm/b2Q3axu9J2ZUzv6150os5XTIQHLrlXwcESIxqr?=
 =?us-ascii?Q?hPSI8R1+m5QQ1JpvuF6UG0Xa6/szjNKMLDVFAa+eOIVm78EmZi61Yt78J+QW?=
 =?us-ascii?Q?X//rTSU+hJLea0tf2gk8TsKGCwybW3F3OOI+5VuwTFO8DGB6cT7sK166H5EY?=
 =?us-ascii?Q?HvgyZeRELk6KDFhvnBc9IpM1aNzXuFDCexukLCLSufJDZxrJUx34RVknf/L1?=
 =?us-ascii?Q?TpLNpSRgx3USTokHuNvbHSDc8JCayvTtJoctZJ83yj3SRuLUVTS20sPs6EGr?=
 =?us-ascii?Q?FG0wRQmm+Yc+zGWz5Igbs5WkKebv28exvqw/3UB/ztqIIBWtcnFtV0XmIck7?=
 =?us-ascii?Q?kNtuYTtRhEiFcmF5TDjGu5xMGlTp4RZxiXyiQstr4c5KIrNIq7SzjLFN3pRc?=
 =?us-ascii?Q?CYVUTOAPJoURcLHuwjn0RHblTC2PocrGQ8k5p8dc+GeQlSj4ZFojMN7GIknp?=
 =?us-ascii?Q?VP0tvZ0FzZkAnW+NTFAkZvyDE6/pjtIAJ5Yv5wreW4DjSuQw58Oo4hpA07SU?=
 =?us-ascii?Q?dJ64eosHhLEk+XFSZMR8dPvbFKDbKG6vo2Me8YNRW9SYOezBVkpyDsmBrUto?=
 =?us-ascii?Q?9dItEUoJZRGLSrC+Jg0sdj/EX5u0+4aqn3V55Yrh+KDB7RtD9yWQGhB+22GS?=
 =?us-ascii?Q?PMMMxlW36dRhPXbUcaO6scipXWf0HZ+Pv5A4VHSFbkq5SH9mLnmyxGy5cDvE?=
 =?us-ascii?Q?/DbloonCk7KO7KAylUVcNSHQELfkFgOTfK0dAhfMQPwn7vcie9ZDHxCTIXuF?=
 =?us-ascii?Q?kZQARIOnrKyaYyZp4QEkX6ia0fz+YBF0at06ETs28B5vPp3bnkHC3dghSB4h?=
 =?us-ascii?Q?juNcyisijidCudKsKB3NyvWcMxrVvdPRPprwrvXifMycmlbSV8L7rINPi0Z0?=
 =?us-ascii?Q?OUOr6tPAKiq7pb9KGIp2PWyyFDBijnsDU4ZjceZTVBfYnwcVSshm7AT1D7Zq?=
 =?us-ascii?Q?yEfpNOwqfhE6rgo+Sd7ggbp8L2GyYOwWyIuZt3y3YYjKfeEueGOUM+vPMwyF?=
 =?us-ascii?Q?xz9avs9CQDwJG1Oyk2wUVuXT7DFTRxU5LA4qA2OJovvHYKJQcYsqkoxk1xK/?=
 =?us-ascii?Q?nKZshuE4hLt+8pMd+/JZStS5YIFI51qUL/cQg9s5CSUsmYhLf8p8YteMyvHU?=
 =?us-ascii?Q?4qi8Y2t1WwovbSoVJZTEuGHfk7I535f2HsqSY1tf0FizCMCpivmJcX6cd8dy?=
 =?us-ascii?Q?Ud08O9dKlA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	trbYoke7JoenMPKdtUJ/R3sgNgfLNnKenMlecjZf3UNZUgSjwuFYbw2rvBGBMkiZQyz8A6XN6NIBCaq7yfsAIeGfZAxz76zfuhffzWPUOGYpwQZVkZKD1mdJRZ0Qp/cR76yC+bxqptx6c3mFjBXOG5LUsj/lMJfoCwX8MEqGM4H5c1Vo1tNmtxKVGHp8Ky72sERAzqvmDpzPreLOPnMAfzA/F7+yaQS5QUGl3PXt2jijavTdqU6mkKsrq12HjQzfUiS1LPO8w7X2H2/JgiwiVd8xg2cSrtCYTe131dKbdWUps4ykMZs153w9NTrfF5aEXerlW5EnEBOQH8oJ1eoWww==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5854.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a924ef3b-e1ff-4885-baed-08de88c87278
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 10:39:22.8016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2WZtPT/bTs6WHsMX1dFRBJgVeDw8LBoj+v+uIOsGOgH8NU0GnD/sAQmTtsxoLd6JHD+dDEq5gEGBoZaUl7ghqTJI01ytJA1b9yU5D3B5B1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5568
X-Authority-Analysis: v=2.4 cv=ALPFdfBd c=1 sm=1 tr=0 ts=69c1186b cx=c_pps
 a=UZSaxNdd3h1KCbY4z3Yg0Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8
 a=Zn0rDcKmQg87bmYfRhYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: F6Q3SjUEw17o_pWQxZYCkQAylkTCFfUK
X-Proofpoint-GUID: F6Q3SjUEw17o_pWQxZYCkQAylkTCFfUK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MiBTYWx0ZWRfX3vVZOhigC1WR
 Hmp8wVqU43G7YoTcLpl2JoZqNozBbaXK05mI6M96zvdnULrczbrBuUZGhb7x6O59eC3W7SWm+aE
 aIqfgOn5rriwrmkK+huP2zDZWrOZUDlo5q7ZmJmHMx6QLAj9ZYeobGeCWM3ZV7x/O+yO4SG8XvW
 Xk3Vujvi1n0NQa0HftXSe/A2lN6QBI79O60Vmilu/L/3Wt6SmIScEQTYnwLQqlIdAEerO/u+iwz
 yHhoX2koSs9InU1uLVQtoIKw0u+vvjyxDgi9BDRM3Bh6EtfOxofNhqZIevu6CLpyZlBriZnhkKJ
 hQgS+l35VsCAzB5DNEqdpiSVO4Z5wZe7xi5rgU9SFOCtB7s0DWqP7TVp3os4iHhfyxSc6+VIQnU
 987bmJLMIOlPDxRMYsRaLQ3HQNihzreypfkcYahj68z1tmei3lSZoOtVutyC5eRqkpTovBif44C
 inoHh5MTprkbEbqQSkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230082

> On Fri, 20 Mar 2026 22:08:17 +0800
> Carlos Jones Jr <carlosjr.jones@analog.com> wrote:
>=20
> > This is a preparatory patch that introduces a chip_info structure to
> > the LTC2309 driver to facilitate adding support for additional chip
> > variants with different channel configurations and timing
> > requirements.
> >
> > The chip_info structure contains chip-specific data including the
> > channel specifications, number of channels, and read delay timing.
> > This change does not modify the existing LTC2309 functionality.
> >
> > Signed-off-by: Carlos Jones Jr <carlosjr.jones@analog.com>
> Hi Carlos,
>=20
> Firstly welcome to IIO!
>=20
> A few comments inline. Some overlap with Andy's review.
>=20
> Jonathan
>=20

Thank you for the warm welcome, Jonathan.=20

> > ---
> >  drivers/iio/adc/ltc2309.c | 24 ++++++++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
> > index 5f0d947d0615..4ea25873398c 100644
> > --- a/drivers/iio/adc/ltc2309.c
> > +++ b/drivers/iio/adc/ltc2309.c
> > @@ -8,6 +8,7 @@
> >   * Copyright (c) 2023, Liam Beguin <liambeguin@gmail.com>
> >   */
> >  #include <linux/bitfield.h>
> > +#include <linux/delay.h>
> >  #include <linux/i2c.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/kernel.h>
> > @@ -26,18 +27,26 @@
> >  #define LTC2309_DIN_UNI		BIT(3)
> >  #define LTC2309_DIN_SLEEP	BIT(2)
> >
> > +struct ltc2309_chip_info {
> > +	const struct iio_chan_spec *channels;
>=20
> We now have __counted_by_ptr so you can use that marking to make it
> explicit that num_channels is telling us how many elements channels has.
>=20

Thanks for the instruction, I will apply it to the code.

>=20
> >   */
> >  struct ltc2309 {
> >  	struct device		*dev;
> >  	struct i2c_client	*client;
> >  	struct mutex		lock; /* serialize data access */
> >  	int			vref_mv;
> > +	const struct ltc2309_chip_info *chip_info;
> >  };
> >
> >  /* Order matches expected channel address, See datasheet Table 1. */
> > @@ -117,6 +126,10 @@ static int ltc2309_read_raw_channel(struct
> ltc2309 *ltc2309,
> >  		return ret;
> >  	}
> >
> > +	if (ltc2309->chip_info->read_delay_us)
> > +		usleep_range(ltc2309->chip_info->read_delay_us,
> > +			     ltc2309->chip_info->read_delay_us * 2);
>=20
> Andy covered this. fsleep() provides standard tolerance on usleeps if we =
don't
> care about precise timing (and given it's a sleep we never get precise ti=
ming
> anyway!)
>=20

Noted and thanks.

> > +	unsigned int num_channels;
> > +	unsigned int read_delay_us;
> > +};
> > +
> >  /**
> >   * struct ltc2309 - internal device data structure
> >   * @dev:	Device reference
> >   * @client:	I2C reference
> >   * @lock:	Lock to serialize data access
> >   * @vref_mv:	Internal voltage reference
> > + * @chip_info:	Chip-specific configuration data
> See below. Maybe more appropriate to copy the read_delay rather than
> keeping pointer to full structure around.
>
> > +
> >  	ret =3D i2c_master_recv(ltc2309->client, (char *)&buf, 2);
> >  	if (ret < 0) {
> >  		dev_err(ltc2309->dev, "i2c read failed: %pe\n", ERR_PTR(ret));
> @@
> > -156,6 +169,12 @@ static const struct iio_info ltc2309_info =3D {
> >  	.read_raw =3D ltc2309_read_raw,
> >  };
> >
> > +static const struct ltc2309_chip_info ltc2309_chip_info =3D {
> > +	.channels =3D ltc2309_channels,
> > +	.num_channels =3D ARRAY_SIZE(ltc2309_channels),
> > +	.read_delay_us =3D 0,
> > +};
> > +
> >  static int ltc2309_probe(struct i2c_client *client)  {
> >  	struct iio_dev *indio_dev;
> > @@ -169,11 +188,12 @@ static int ltc2309_probe(struct i2c_client *clien=
t)
> >  	ltc2309 =3D iio_priv(indio_dev);
> >  	ltc2309->dev =3D &indio_dev->dev;
> >  	ltc2309->client =3D client;
> > +	ltc2309->chip_info =3D &ltc2309_chip_info;
>=20
> Given only the read_delay_us is used after probe, I'd add a variable for =
that
> and copy just that value over.  If you have other changes that are coming=
 in
> the near future that will add more fields to the structure that are neede=
d after
> probe, then fine to leave it as you have it (but add a mention in the com=
mit
> message).
>=20

As, I have no visibility into the other similar devices that may require mo=
re
fields to the structure, let me revert the structure changes and use a loca=
l
variable to deal with the read_delay_us instead. Thanks.

> >
> >  	indio_dev->name =3D "ltc2309";
>=20
> Given we try to present the actual device name in sysfs, I'd expect to se=
e the
> name coming from the chip_info structure as well.
>=20

Will do, thank you.

> >  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > -	indio_dev->channels =3D ltc2309_channels;
> > -	indio_dev->num_channels =3D ARRAY_SIZE(ltc2309_channels);
> > +	indio_dev->channels =3D ltc2309->chip_info->channels;
> > +	indio_dev->num_channels =3D ltc2309->chip_info->num_channels;
> >  	indio_dev->info =3D &ltc2309_info;
> >
> >  	ret =3D devm_regulator_get_enable_read_voltage(&client->dev, "vref");

