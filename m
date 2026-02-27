Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C936B062;
	Fri, 27 Feb 2026 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191410; cv=fail; b=J6n9Pwkb6lI0CyupX4tTVQeMry40eago5J+ixrOQPv/FEusYufIegVUoGjnLaxd2tArh6S8jBKU6TEaQcbMjLfDI1vVyshW0/xFyBVK/5FlxYafC2G4tbKo4Jm7N/y+HqoIDorAaVpKV5mz5JAhHkGIZuC44tXiVg+U3GmmTx3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191410; c=relaxed/simple;
	bh=LiMrlGFstZuovjq9eY+OPS0YHDKWytK7+6Lb10cSEwI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MTReLTLM/FnPDHX9dy6L4hB4fVjx2lE4WJr0F/LC5a1gO7A6g/fg2+5mERbf4nXLqDACd4cKQtO2jNuoiRgLBTO2E/Tw6uqb7JAdAOBxqU8M++XPchfWmR1V/TPO1EibvvUcVVtL44gRaXOZXnPolq5F/5ZaEKRTdc33yDhmc9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1VAf0TmO; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1VAf0TmO"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R8XF0D1869335;
	Fri, 27 Feb 2026 06:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7o06T
	4SBPWG0/EOFrqCswg60+DABD4d2HFt5lQAIBrw=; b=1VAf0TmOXnd8EpQ9imqyT
	qz7lltse5U1X91W3QK3rpSKiFI/wmRoHK/+rLYoKX6QQ7D+p0nMGHWSaUWBc1lg9
	zU6iMb0Ta/FhO7PM7ul7QGkrxzfoGSVvA2DbaYQ1ey+C7d5OytlQ/YLju2HzUpuP
	RNmO+BVpfWDhSMtPZAK0DRdyTajgIT7gFGn69JHs3VCdiS2xzoIEt0WEwPjTCKnF
	zH3pHQDaxbE37RsUO5QDe53D9y7WosoA9i+6dUp0nrHUCZcJWuWg3wfp53/r9Nmn
	ZCQE795N51OKfNkVqwmL+mvkz09g++9KmsSlRRjW+gfNHuFYMQpD4/Si/ypY81YL
	A==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4chvwgaxps-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 06:23:13 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rj7YvpL3SlFqneT85AjSxyOFno+VlX8RKeytEUxPEWALANT84IdXeSaK8ekNGzZkaGsqGH0/RGjiwcnu0C5aFnlEjTSs2OozEWFTERvFY8wibsEdT79Ky+idGbIkmSUPMDSCe4MBEYbtKdF9ePx9HRUcT1L7GD3S/VQi7EGWELFBTaZpsjUJ8b//IBNhti2tzRzdUkP6gUyH3V2wtc1RLh2KMSCpZeIe9vSYSievMEQtFYgHN9EjctbHfYNwhFs+oxwTO+xseM0IIJq3IczDAV+3i4dCS+JkxVxQVi8xrE/FpSjN6rAaCyIbloGQQz/EUS6HXYVYZejtk4iS90Up6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7o06T4SBPWG0/EOFrqCswg60+DABD4d2HFt5lQAIBrw=;
 b=KRBsO3a5a52gKduhNuayK7A5Eg8i7/LGOGYIJSzgrkQf8NdvuqF7limR2RyNmCuiZw74w3EhrQudGpPvYn4chdKK+7/hg9+sVGeoD04R5cLhg356iIvbsCTQXjzWQQk3xpZNsMuWtgjYoVKrL5r5u9bSj4UapV69/DEpsa7OV1xLxqlfGxQ2fmUQiLHHKcLI0lmlr+41JyO+XDWCIFWhHly/IN2cMoJW3rci3/bReNt0V8vicmtzFU2P9mSQvmfm0SzLlXs2uD/7ucnExRnjCRl0ffzF8w6hMvdS9/QGdsF/cBj//dY/CdJKJccTTgXc10QFuM0itGVn0J6ZDgQJ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SA0PR03MB5465.namprd03.prod.outlook.com (2603:10b6:806:b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 11:23:10 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Fri, 27 Feb 2026
 11:23:10 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/6] iio: use dev_err_probe in probe path for ADI
 drivers
Thread-Topic: [PATCH v3 0/6] iio: use dev_err_probe in probe path for ADI
 drivers
Thread-Index: AQHcpmhfw7/Iacok+0mef2sBO4/9PbWTlvsAgALQjQA=
Date: Fri, 27 Feb 2026 11:23:10 +0000
Message-ID:
 <CY4PR03MB3399CFF77F5C0051731D64989B73A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260225150615.274078-1-antoniu.miclaus@analog.com>
 <aZ8gCD3YXvrNscQo@smile.fi.intel.com>
In-Reply-To: <aZ8gCD3YXvrNscQo@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SA0PR03MB5465:EE_
x-ms-office365-filtering-correlation-id: 57acc1cd-67aa-47ac-34f9-08de75f29691
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 x8ybNzjyzAbitPfWkhkMPIAhCXY44MXfUtHUOlY228ME2vzy8ZkwzntO1c/+TQVHRZ9Up+eFqKa13E5eX6DWzFx0/WG1ozVumzkIY5eq/ubPoLgPWZecOs01ccJfP3M2x9zPXjF43XQHgB+higyrqWlOEOWbaK6Ra5ELMiDaCgBoXvREFyO3azzHo2P29M7vtwY7EVdyEd/Du/u/B7/+i7vumS15YK7BJZ0jOqOYQjnE3V6/r8ZAcpLXtiVL4P05WrEwPKSL3UhNLI3LC9WGBK4eAbF4WPgVS6KBOnF95+u3bp5oPSyjMjXNxSWrgkgmsE7TFU0INgASIcEYRsJCtXkak6k4KTt4kEcB37aCfROlqIhU8ru09uQKwXrbftthkDcMYSBzij60n5lhReViHkJ3CeYfPloQY2rpEpXKB/vOLigF9JLKMreWcy4u24y4hvcUljNfSX1YQIA0FJJ/lej8L+gQaB52wajWmO0xpvXdAb/z8Ii/sS2krWiI26+b3DmcEpXQ7fBZS2K4DHNBSQtkMcnKCCIfNpL+MIY4w5DerJGHZLfJW7N3q1WrI7FZU3ijrJ8g+l3xW2Rw7aeV/wP6i8uHtw9B/Jjio536GsVuLMPSKByxgY80xYjMYwFPXEH/g6h9oO2KcACz+J2neyGDCh7o+9BeQdebn1c9jGRKIbzva645MuE6e6MbtE5oamUPkT1yzZh2pESZroN4tjGVBoFefkqC0kuziXK/rTx18yTj1UjCaNP72m/897GVaVnm7fGJfy2dCFVPauBPTq38s6hi+EHzSw0fXx1NN/Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?04G5qjJgvgZ80woHfdDLSUBvMlpWivCnkui/h4z8Tc8NEdkbbN13GfRYpH?=
 =?iso-8859-2?Q?tV4hOnjtGN3P7aPkUY90darO+MgJ0WarePTZydx7o+ke6UXa1AeyMOgoDP?=
 =?iso-8859-2?Q?g0w1puQ4GXHBsie3kVpEvJoEoCYrMN8AcTZlF6p1QGI/i2hKJNjYGKV+DA?=
 =?iso-8859-2?Q?4vlEajd7OZmcG2TNlFzGwZ6VpWbqAQMQpA9kyb7BTH8h+15TSCMN1HKnTn?=
 =?iso-8859-2?Q?36weTKmd1jn/wfKNVeTz18nwefzntKLtqlVKjHhqpbtOoVqPqttlm4QBwU?=
 =?iso-8859-2?Q?HUSIYfuSppIYXpSbzOEB7XudavqDjPRXrGH6wIFRjnONRg4JN+jE4iJ/c0?=
 =?iso-8859-2?Q?cXWO+hJVfgJV3bsRIE0sSs9Z2w6+faugV+lAGczD2U1OFTZOsDYpORPgZR?=
 =?iso-8859-2?Q?+rXtjAcWWpDEeT4tmKu77WroPipi93mXUkvyLu/mYMDrh1Nbq9n1gqe2W6?=
 =?iso-8859-2?Q?Rn/sY/vDr7Pdt4DOcsLLabw3L2MIe5IkXWDuy41ERTChVFkm22dIWByNpY?=
 =?iso-8859-2?Q?0golFfc8aqCaq0KmM1DrImFXJ1grVwqJlEsYCKCg37TKcYFhmJ+GCuA/Sc?=
 =?iso-8859-2?Q?Oud0TiiTCa66KlrbQi+YbtWmr/4iKIW6K3K/+RJWxFd0QBhwJDwhMraqJp?=
 =?iso-8859-2?Q?bHleUd4aFxqvFEs3tM3O0CfK0D631v43HvX58m7OScMAnFM2XTWorr6FN9?=
 =?iso-8859-2?Q?Kxrm0AsJMG3mWoMKsR27+drpmJ+7m4IZyaYcz9Aj//uPIiV9DE1G18cXyi?=
 =?iso-8859-2?Q?AAfzqZrWiC4oabMXT2m45Ls5ZsXIneVvJaCwRPSDDJAH0C3vWMY5lUZKRU?=
 =?iso-8859-2?Q?b8p0B08Bcnp6tz7HwJPs5wEJ79Tq7uSs8YO01sUkIJilikQdxlmkk2hRRC?=
 =?iso-8859-2?Q?qsH/ePp/lAH3kRbXMUNnuc979yq6YVXe4q4cZQtV4V+fzzGzoiXN8iMVNc?=
 =?iso-8859-2?Q?6irQnE74nMTlpGLfywwExkRulj1zZ3Qae2Hw8Ls6hooEzgdPD54x8BIT5W?=
 =?iso-8859-2?Q?/MN2+xAR//D8n3CqgQlA2Pi7h7NRjXyBDlbtCcRV3BEuvZprFPvgEMz253?=
 =?iso-8859-2?Q?QlbnUp/Bmk7uuQqPnCV2ske/GmoHonH5/KZt4W/b+Y5/wI/6lY9xnOLtAR?=
 =?iso-8859-2?Q?SUgnQheWY83zCdCiWvQHGa5rMr+PXG6IaxiSmGh3scqV4QaBdJ/oz2xFlT?=
 =?iso-8859-2?Q?h4JbaLUWSrr2f/d/AHIHRTRPRrlE7kDDceTtSCcs2wKy4O3uc6zfnspHcv?=
 =?iso-8859-2?Q?081epZvv3mGxgzv7nJNWDq/LHEvX8u6OWSFFFG+FblCMcoUbGBb4orBt6O?=
 =?iso-8859-2?Q?LuzBgLOSsj/w8OIp7Nv4lhuwdq5Q68MCnOjtAsv/9nPF8Jz5B414S04x7I?=
 =?iso-8859-2?Q?fs4DnKTVj8Z5Ys82ZqjYh5YfmFTS37eDpPKyCV7qngLjN+w5wJ9547IoyB?=
 =?iso-8859-2?Q?byWR/TZ85G31W8Udqzcb3oLH9JbRS2eggvEJN9vWN6FR/ohttxjPQ4JPnq?=
 =?iso-8859-2?Q?wCtg1MOutVFaisj1nlEboy9Bu27mtuV4FJtHGvDP3VUMH1qSHt1Ejh/HBZ?=
 =?iso-8859-2?Q?NWb+mxgaI1MM6JIt6lad84/8Nq5/vGyGKKeu/ZJw9x1UP1JTa65jKWSwVj?=
 =?iso-8859-2?Q?z+5dMtEn2SyZjQhVI2uHwXBc5hRdgaq9ir3NXKAQ/2I1JyiuIN0+Fjg0DK?=
 =?iso-8859-2?Q?qKXor5O93QyTfsyamfOjiX5RBLPMInp3J+KUejgAMWKAkdy+F50LiDybMH?=
 =?iso-8859-2?Q?6szkDdjnCf1/4iAr4g2jOHWFKvOdw5H0sxvFT21eSb4yuba7NU58UWUqpx?=
 =?iso-8859-2?Q?oFVFdRw66A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57acc1cd-67aa-47ac-34f9-08de75f29691
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 11:23:10.1614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TwfvcFvXsJ53IF5Laa2xRmFg0nJRE7oVGX1kF52pFGqZ/C0s4lp0O0MWG51r3nzpSIuQtj0oiNYiEIZgbs15nF5CpZyQY1xNUZw3w6pxdKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5465
X-Authority-Analysis: v=2.4 cv=Dcgaa/tW c=1 sm=1 tr=0 ts=69a17ea1 cx=c_pps
 a=5QB7A90Jg1Mn+JdiV6um6w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=-CRmgG0JhlAA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=0vTVfiDboYJ3e5pSdOEA:9 a=jiObf9B0YAUA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: QJDs-nwYuMDmJ72iwoKHqZDgfdAov1Hc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA5OCBTYWx0ZWRfX5KJN8oAZ5xkT
 ED0UqBX93OftPmhAX0DoCFGiqhaj5Y0jI8z/G1441i0Dag2hAmP45+hfj/OAfKz+TVyuV/Xc2m+
 wB+lfDki7E3Cd6cEPU+EUZ0i7TUr6odxvyuKcoTycPNwKOPXS8DX18sCki6YzQgqijdjaG9bk2Q
 RHwxHQ6cPy8fqwftfihv3Nz/ZB3m8fkrLLOZwGaK1V9G53W5IVQcHFZOML4euUULWESdJd9kBPf
 eeYIvpZRsBfhLLbVFEXJMTVd0bJHzFzf8zShXS4Lkx21H3TZDNS3x1hwN8g+sM/VkyD2tbc7vsx
 RU0DXVK1uVQQ++EWNvHCqR15k0+LiwsAB847lc1iKkXOGgXr8BYBI7CQaiL9FS+5FIV/VzUhE85
 TaXac/LMrq3hqJJ9dyPJUjWu625TKFg9q2wRFLzkWcfhB/dPcIY9dEVNakbAXAXgx/tXMG/uXoW
 BZIf8ufU20HgJEExU2w==
X-Proofpoint-ORIG-GUID: QJDs-nwYuMDmJ72iwoKHqZDgfdAov1Hc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270098



--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Wednesday, February 25, 2026 6:15 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Andy Shevchenko <andy@kernel.org>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v3 0/6] iio: use dev_err_probe in probe path for ADI
> drivers
>=20
> [External]
>=20
> On Wed, Feb 25, 2026 at 05:05:46PM +0200, Antoniu Miclaus wrote:
> > Use dev_err_probe() consistently in the probe path of several ADI IIO
> > drivers. This simplifies error handling and ensures proper logging of
> > deferred probes.
> >
> > Each driver is updated by introducing a local struct device variable to
> > simplify repeated &spi->dev / &client->dev references, and converting
> > error paths to use dev_err_probe().
> >
> > Drivers updated:
> >  - adrf6780
> >  - admv1014
> >  - admv1013
> >  - adf4377
> >  - ad7293
> >  - admv8818
> >
> > Changes in v3:
> >  - Squash the struct device variable introduction and dev_err_probe()
> >    conversion into a single patch per driver.
>=20
> Why? Maybe my comment was unclear previous time.
>=20
> The idea is to convert to short dev the only lines that are not being tou=
ched
> by the second (dev_err_probe() conversion) patch.

Sure, so for the function which use dev only for the dev errors I introduce=
 the struct device *dev =3D &spi->dev; in the dev_error_probe patch?

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

