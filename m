Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C38B1A76BB;
	Wed, 25 Mar 2026 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774401794; cv=fail; b=ht40M00HGu5iddJaY8uV+/72fZg0E9oyytgjP0yMUN9Fopcma85zeDf2Cz8QRgN0jo8Rkj+bLqugwDO5sQhAZroMdNLdb4P6iJJef64wsx7jdIRh6afnErnfmaVzG6flwkscLtoJcrxX9IZp+l8Bz9ORQy34PlHiYhTjOJMmO6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774401794; c=relaxed/simple;
	bh=UsqtDLw6cPh/lzmFZAxbknyade+088uEEp0joEe/xAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OC8FvOckadrPI1cTQbTWTSkuR/YFrz2ifd/XOqoRO3ZEyS2ecHCiK7J+JJccTyrv55Lr0uPtHle1caxAn6YSSB3jRzEGXKUR/+woT/qphI0S5ZXZHAJHb4N06GvG4PoGS7IEjmIjjM/7W/wNkn9l5PGBRC9iTdLAy48qXUuOLhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nKopzK4a; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nKopzK4a"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OHKX5L2430961;
	Tue, 24 Mar 2026 21:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8xq2B
	YAwiunir9MUGjK7VlxuysP4+JuCtnkKOV55tD0=; b=nKopzK4aEXVr7uS2cdZA/
	VHbX422gIjb/9Ln89n+WiPHYeXfHCmejcO7D2JXiSPcz94JPdOkJ0ACme82vZk/6
	zMwrWadcKsJh5LyNoxD9F+KNVBz+nLnFPjkb033UHClzB0ZeSoeFTGeZ8WyF1yUo
	akfJcMvnhJir82LhpB3V3QrFLmrs4/l0p3hlHKOeQn428O1+8XQHZHQFrXDkiJak
	xRg1kmYX7R3UzUtq22qBtxyCcZai4ESBsEcutSYjB9NDROWLeLTs/hSQ4MpA/XmZ
	cIMr0K+eWFQLGWOtMfUptLlZ2F2IkWNz7iszJym0bYBQORLnmoRCN2mg+3H73M5x
	g==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010052.outbound.protection.outlook.com [52.101.193.52])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d2bxejk15-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 21:22:57 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJ9WS9a+E9Xtac6UEqa7pF/KD9wNQsAMmeafBvYYUHS+eQQJTP9/LbF889KEOaDhaTqk7EGcIx3CgRxHNPb2dwmFjN6H4VyidhvOV1331q8hVqqquabAa6g1DEoItif51nSrRaBbVcNwOQOHhquw9sWXz73NWBZ1JELu9uDnZMq6oovDmzeIFMDvpl4bJt3/s60IP4dpmhHnYp/A8ugrx+iT2rcvWE81qe6nWGviyBkUJsLT22Pv4j9z9+v7zHaasWInqoILkYet/M6KZPEsC+XmKAJLKZ/VvKdIhRkZYIolUoIcPDR2g2+Gtp9FrmeyxE9D0j5ZTq5xMjNc9faXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xq2BYAwiunir9MUGjK7VlxuysP4+JuCtnkKOV55tD0=;
 b=at12J167nknmpvRiqnNrmtJCLOwVUSjs6DsMdvphEOf9T0tQgXbN19m466UXVtXH7JXg7vFTVZAsFg/wHkwfXrlRTI7YSix5L3PWuE0xiXLK17fzfJW5p41HZVF4cCGqRBJx8gcw4OwZR5GJlusMjOdyBmt5/7vsI0yypRkRmjKT1bbNYKLVLzXLCPpTidhrFqbYIpBkIuDRB01XXIlSnPopYXvEGcQuFE+/u8mQMV73m/DWho0XfszaY0PYPB2Tp822bbmT8DpLOpU+pW/fu5GKfS04DziANHT6801Uh1/GVoudbgUbA8euo67vyIiYXZw5fzjSKEMbZqCLAIBCAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by CH2PR03MB5368.namprd03.prod.outlook.com (2603:10b6:610:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 01:22:53 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 01:22:53 +0000
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
Thread-Index: AQHctpdTMBKgFPb38UaDAUFZqVbS1rW5VtOAgAUkVpA=
Date: Wed, 25 Mar 2026 01:22:52 +0000
Message-ID:
 <PH0PR03MB635133FB434235B7542770ABF149A@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
	<20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
 <20260321183909.45761710@jic23-huawei>
In-Reply-To: <20260321183909.45761710@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|CH2PR03MB5368:EE_
x-ms-office365-filtering-correlation-id: 516898c9-bd8d-4879-68c7-08de8a0d0972
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 CgUKxOlTiig1nVZ8iahb5WxcU9NjGTqHpgOb9AU10bfJm0Sh/HttqhTuDe5Jejul1uigXquQJW7QnZggp1sGcKBHgBrTPeXgqmSTdTPZi3T2NWhiprrnB3JbLjgxS5IE35ai0GBAolu9t3cdT3KDfovdRyJqTZjA2fzumQIYRKECi+978AhlXJ68qnsTNVBXO6B8NsbaStnaAY4r8weykhfBq+Q5OO3tNp9XAKZZRqkkix+6m7ASdlDboJDKYH4zdk0cI11MC4XkGqLZZrW6uSNNHY9U1GinozygLPboZ/6Zf0iKokidKdAxjIzGYhE0Ibi0E5L0YmJStRB7XtJIjyYj3hhJCjCNVj8k4N925Vimbb+ziJHGX9pZgjURPZcYdutjD+auWHq5/n0spG7Nh4ySg7+0r9ZBIE+hrcDtKyZ9agyKMkWJCqRJTpzYRnxDV8rr/136jp7XlxY+z9Jdc/7hT8rbDsNSg281bFgTwLCnrXD3W1/ONDduXyYt8hZIeuNNPL1cP151rDIAOQxpNjxMtxEUCA9BwMZrXBJ2V1jxFsnmkoc/KYZJbBo363H3nl50hk8q8jL7cW43v2683hGjQckUAmRP0V7PSI65RjJ7X1qBLDwKv4c8QYwyBwLXAEZXVP45ppcOr8dUXHjlAPDb+zwduKSHBoP3WhC/c5DGmCB6faPosJ0cEqXkJgpVex5L7I5x8oVlUZR5V+f7TJe9H7TaBd5F6YAKE34EUUCJAd3AbToT1vVRS/EyWb3rp3zXWB445TzkTzII8yaAJRmgQhIxDghn/36EXw8Nfts=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?B1kVUIs2v4kmXT9IFLnL8hfAVSA26PGIexpO0l7L/+wv6fOCQOuOolh8gn4I?=
 =?us-ascii?Q?45JYJ+A04ttj0fmHHQ9M06tUr5RhXWEEwJSXhMXbHEgJ6LKEli7us8lpL4ZA?=
 =?us-ascii?Q?aSC5GWiPMBGXwnsrk/WkIQfsMKcPwWM2Zmls1cRhySxqn6txcZ/xioh/sq1i?=
 =?us-ascii?Q?IYhSM5PS/s52bgsLtl8LW4x64a1CFk8ZMw/m60oXLb3MfIRw4zrfUbnksO/q?=
 =?us-ascii?Q?7xx/LjPPJKQUoxpO6fQu577Dhe31/R8w8nsak4S0jy1sdMFXa7QR53FSr0d+?=
 =?us-ascii?Q?bMhop6/6B3YAKrvRUQoGgPuFlWF3Zqbrp6zKcwjFBHJBPQT6DLEU8XUUiohX?=
 =?us-ascii?Q?LQz/jnNn867ewqTl+eqgHtETm0pOZe8IouryvluzHK+Ey3sz/9FD1ZCdnKkM?=
 =?us-ascii?Q?Yd3EOvl34D0PphNP8IeO9EZmaFXd7pZUJp+N0pthTsjKBmul3EcElxyo3quJ?=
 =?us-ascii?Q?k/GVHJWSpGVJEalsI837+Ig09OFE9DtR3+H4fYa6aNg4u5duVmXgEGQqZd+p?=
 =?us-ascii?Q?9cyZdR5LltTwll8/VTsmUHcrhcbTvNOh0zVKaNoY3HY/qT2zBPwEsoXMwPQO?=
 =?us-ascii?Q?ZyPLCBgK4sEu4fDLTCD+sFyU1k/zjhAa7CnGB0Ks3u1PNRhRNkOp1v563yl+?=
 =?us-ascii?Q?EBWydC2nmhM82zROiNXUaPbMZI902BccmoEMx0ymklIkbwEf3B7Thq7j+QMF?=
 =?us-ascii?Q?ZYJQCweLsA8AqlfJelpfhgdGc8gx4Qtk8Qz9dUykd2ZnsycjtCpp1i+cU48x?=
 =?us-ascii?Q?U94RjgYa92pluFoY37JWaRKg9KomW6sBjxAK+OZX195Kta7NJA7KQjeSAqap?=
 =?us-ascii?Q?y0NDloL7ODs1oaNeFXYTVxqmJZuuSBNokboRtGJHzoglCcJnqJaPikXTqgDD?=
 =?us-ascii?Q?/Hv+wc30ZNFrkUZo5DKArQiRgC6F1JS2ykN+PykKGw0c8PyQN4YwTbE7Qih4?=
 =?us-ascii?Q?a2j9SuqYRXfLcZLLYE9Cn3WDK5zXlXhJmNK0lcaccyMsb6XoIrl4Oxju/kY8?=
 =?us-ascii?Q?kelKdgkJEpvD/nnfmqBwbVEI12HmaD/MEi5iz0vmPJUfDP11RaeO9T+RYTwU?=
 =?us-ascii?Q?aCzL9QmhHxVor97IHYi4bmPil8RKPhv6WsBUWBEMJc0P7eqMDReVFFpGQeEL?=
 =?us-ascii?Q?VaekT9I55OfvVHOwBwuVfTj2zvj5DbcVUSLtabOMuM9leugwYYsMGGH7vrHZ?=
 =?us-ascii?Q?B1I9hHbrj+XLAgh3nonYSy9RG/k7SgGKr+tKco03WVpOHcJvDt2oXvpWatsb?=
 =?us-ascii?Q?+vzguNpEkX++y08IyrtAJreQvLSBwW+SeJ7gNI7CgFJe78XIkkUEfNkSkdkq?=
 =?us-ascii?Q?ZxplGkHVkTV3z3tjRigUW+roWTasgdVQPlWTmx7GnuMhwIHkDFMzYJvB8eKJ?=
 =?us-ascii?Q?wZmO5SyN4dG7Lq9v5zooR5QrJjchOO8dXwwJp3SxuUbq0vJAUGVLblL/JqQZ?=
 =?us-ascii?Q?FXmUi0gN92HAX9jaCmE7S9WaOkVMDFns6AqdlQ1wrI12RrOf/pbWdx1Aw7wH?=
 =?us-ascii?Q?fKYJ5kCINBbo4WSKZGZmlZmubU31NvLRBbmu4lXEpF+Q02zJt1UMOTw+34s1?=
 =?us-ascii?Q?YfHzb+hNAmcz8lwdM6MqztnBxY+INohpSuZF3ba+r/AU5PKbbUwAvyr7HtpX?=
 =?us-ascii?Q?UhO5gLMP6GlqySV6wCFqQRE6nIRWkfM+jZUdD0VjyWusoC9EjV6ZSH6R5d3g?=
 =?us-ascii?Q?fkXbMi9qSzAve40c9OrMvfa2Lg+YZHWZ92jlOdxmpkesJLVxOvHHNJs0u+ty?=
 =?us-ascii?Q?1W0EzZsfWbS0Xi2uQ2qeA3awXrigh34=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	sQOemdd6HbGPbMJdHY2Y6qDg7fKoMRkJJaH6ZFf7M60oYmy69DqJFFvxV6DzBgL90kq6d2FI0GmPcD/488exufEwXZiH6j5hzRkwJVMFmx1GoP7h5nvHm2fmHNoQ9BpF7arx4JFpgoo7jZBRPEj43rTng8KeU3S2EdwuQTBwFQL0Xs0bg/S0UOhwgrKu8SKqom+ZQ+ftlB5VxlFptVxslRga31TGe6o6kQiuQLSfzmz0h5T8yPYTUXymK9hr3rZGgWaFInQDgUQ5YNhDlmBVAdLtiF3u9MKNkoMXhAwv2wSBIK7yzXpSDFjjEsTzaZlNM0vkRkCOxtmrhdr1UBH+YA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516898c9-bd8d-4879-68c7-08de8a0d0972
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 01:22:53.0091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQUsaBaVS0mmDQcDtbeWHJxdQXK9dJYYYzAmP3EZI5DWe+7eVKpqzxBeXb281+NFjEFGWhfjWq0fexU8M9ZNBcjoBx1JlzUyb8/ly703Nxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5368
X-Authority-Analysis: v=2.4 cv=P+03RyAu c=1 sm=1 tr=0 ts=69c338f1 cx=c_pps
 a=N8fQrVaeAljVkTo8kKJ49A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=a7LjhGNfj9uqdNqTqS0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: BWbBcDHFOCtG7mN69D4V3IHOcZWkLO6j
X-Proofpoint-GUID: BWbBcDHFOCtG7mN69D4V3IHOcZWkLO6j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAwOCBTYWx0ZWRfX7tOz4DjJpLgj
 ahZ7KozsDGxJivmdyXAOt6I1ppl+BivZHVzlk4qoJHavp/IlKVu1orcqf2nrCWEF/tVfCOE/HaM
 r9ejGFO6XPYIh/V/yTzoNpHJxNIKRK4uEjpB0t79bqENyLtBqu2I75WF3lKkp4R63lpaGkHtcsT
 4OY3gJx4cF0BlJ6qS+vOM23Y+RT5TdzJnQgLrjoNdI9rlacjXoa29vtEHKOyYl3MKgqU1FCo1DY
 4bvzWh8KMFYILUrWSZjQDHB7Vl2NRF9PPPChrjcsr8rgsTL4u8cZf0RXLjYoJ/sI2Ss4ntPH2SB
 Ro4mAU9iHmIbNTzGlg9A/Kdnso4XJFwqkr2rktSDSciTOGPj6dZzZtjvU/Iy1oP+f4oiDzwec6D
 T74/v6ULmqaNyZlHjqg4DW3XO84qFP9hc72T6f0JzGyczTFPalbKmod4Q5Xw7niGL5+T2Z8ttJ7
 Wy+5Z5VRUKBd8wtAynA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250008

> > +
> > +struct ad5706r_state {
> > +	struct spi_device *spi;
> > +	struct mutex lock; /* Protects SPI transfers */
> I assume it actually protects the buffers below. Where possible talk abou=
t what
> 'data' is being protected. It's easier to reason about than transfers whi=
ch will be
> protected anyway by internal bus driver locking.

Ah yes, I'll edit the comment to something like

struct mutex lock; /* Protects tx_buf and rx_buf from concurrent access */

>=20
> > +
> > +	ret =3D spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
>=20
> Can you use spi_write_the_read()?
> Has the added advantage that it bounces the data so doesn't need DMA safe=
.
> Can also use more meaningful types like
> __be16 tx;
> __be16 rx16;
> u8 rx8;

Ok, will shift to spi_write_the_read(). There was another place to use this=
 above,
just trimmed it off here. Noted on the more meaningful variables.

 ...

>=20
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		scoped_guard(mutex, &st->lock) {
> Why?
>=20
> 	case IIO_CHAN_INFO_RAW: {
> 		guard(mutex)(&st->lock);
>=20
> 		ret =3D ....
>=20
> 		return IIO_VAL_INT;
> 	}
>=20
> is easier to read and reduces the huge indent.
>=20
> Only use scoped_guard() when you can't do it in a more readable fashion.

Will edit to simpler guard()

>=20

...

> > +	}
> > +
> I'd prefer an explicit
> 	defualt:
> 		return -EINVAL;
> 	}
> to end the switch statement and make it clear within the switch that all =
other
> options
> are errors.

Wil add the default

> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (val < 0 || val >=3D AD5706R_DAC_MAX_CODE)
> > +			return -EINVAL;
> > +
> > +		guard(mutex)(&st->lock);
>=20
> What's the scope? add {} to the case block to make it clearly defined.

Just the raw, I'll add the {}

> > +static const struct of_device_id ad5706r_of_match[] =3D {
> > +	{ .compatible =3D "adi,ad5706r" },
> > +	{}
>=20
> As below.
>=20
> > +};
> > +MODULE_DEVICE_TABLE(of, ad5706r_of_match);
> > +
> > +static const struct spi_device_id ad5706r_id[] =3D {
> > +	{ "ad5706r" },
> > +	{}
>=20
> Trivial style thing, but we've standardized on
> 	{ }
> for IIO.  Had to pick one of the two choices and that one looked
> nicer to me ;)
>=20

Nice, I did wonder if either style was ok as long as consistent, noted on t=
he {}

Regards,
Alexis
