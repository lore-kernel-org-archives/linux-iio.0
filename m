Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792664780;
	b=p35RemgTWns8HG/DzAo67rRRmHzL1Glrt9X3gGxhPhidFBKWeMJzf1gGypmJn2CiFveb
	 bQuzgvvm9j5PH0AGBTWty2vcNpSVzuYWYyNlTDaawHHVzxDdaP1PFCoVScIowMQrjoBp1
	 mQmOtSjeBYWaWJ3CtlrtU6WIrOwhQyPSnRPiTp9KYDn61oikMschnXho2WzkknvWQTsYx
	 ZTY9JWmOgf+Phye85m0uSOxaAHosiyMvyZVbfq0+EtZDH7EcFsiu218dcK+0/IQW/qTxV
	 fsltsBGx7kL1NgwXHyIh+QSfa3KF1jLPSqUodp338/BVJMNrghmTVGwOf72NPRRXSvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664780;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HYH93nOFsr/97e34JkI1h8QAdNfGqBF4bzR/uDtWXno=;
	b=kmCdQS5tdI+Oqo01HFL/xlI6Vyocwibtb5AvyHq4o2+w0fD9rgad6+56HHqs7cY1PI/1
	 kwnp/+YqgrsjoKAFizOKC49NUWtQJScN0H1E9aFIeUzyhLdUtwFptRrJOKfShAr1zhTNu
	 jLIfvFQV4wiUktbwAeV4NMrOdOPLVoFx425YSQJgvQ7Q1LF/43xdeV9ZB8qSXqZ4waPfr
	 1kLXzBlJQ2BkFFBp/64y/wiTkUUwJCOo4DhdFPN1rpOXpdJQP9EaXduNm7K2P+v4hueZk
	 dtcYhbqdavht8frfVasJ77XS6jQxFWC/ZMjEp3SZtHPlv8mSfyk0te8aMCD3OO2ZVNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Z393EWhS;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=1ypGsCWg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2539606A319;
	Thu, 22 Oct 2026 10:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2539606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Z393EWhS;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=1ypGsCWg
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA1Q9u941153;
	Thu, 22 Oct 2026 06:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=HYH93nOFsr/97e34JkI1h8QAdNfGqBF4bzR/uDtWXno=; b=Z393EWh
	SmK3ntWn8RDt5k2QwUW9Vthl94acqZvPSRPpMtNn+iWiwkcc5hK99ks/NoFruZc7
	GNXq/YfVMs7yvh8FH/cUOm/6smzet3PKa8psEwXv+/LNSVI6wuN/V34JNrE71KwS
	FDvtd7dV1TOhCT3XL2EMkDiEUih05W7K9l5z7oSToFV69jJJUve7rRptM6V3cbiP
	lQbBZY9zchfLFJxG6N+TrJTcSBZW1zfl0bbIfHrq5xJMM0B+E7YKhjvhjzFLRIFx
	EJD73xclxiWQRi9hvZ5s6NCMBWFx7vnzxKSqKTZvCDljgiJEC9TQlm4Oux1fOmE/
	2bLzcHctnQ+krIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HYH93
	nOFsr/97e34JkI1h8QAdNfGqBF4bzR/uDtWXno=; b=1ypGsCWgfeFPrvwHD1Q/E
	mTjDTBq37rVnQOe1CdQusTQ6O8Pqh8LmTOmNLqYQaXChhzJQe9IbTYgSHTkfZv82
	iJVMtBVHE5FAc1PwtKWgJo1lUA6iqPxg22RHXjfFK0t28lnmuoO6h7UQG2oR9xHR
	c4mKsEKQ4Z4b9TV+A5TkfbQTHgE+qpOT16+ZhXkD5FRm0jUuHXWnpz6EEbxdinkV
	ou+bK+cpXmh0RdFgbhkJI/t3GpQ4VwTN8hNx2lo0eg+BnrYjxj48KHnUS5M0k6Cu
	9TfgnKuChbK1YxGN2MiycoJT7sZ27FaknyDqTVa+Y5nqzWyGOvjyfoqRtAGTFujT
	g==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hf9f5t9tj-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 06:25:59 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXRu7Ew63PKsQHoB1UFaOJBTGoC9b2RnsquqCusIgk6h4NWaL/BNt8hreT7Si2jqPI2miwSLVoE0nRyTJEvljOPdG+ATp3nXJ7+ReX1wnokyI9g0YNNWfXjGdwDtI6kvM4f+pQHhkKDaDaSp3LR7w5TeqX6PIOq7uPadlMlJvT4ifJHw1UWzzhgRy4LHjCCnNNCyiPOwYYCOvEnCYejHmxNFYos4AL0UvLKYSYWOZaE5Yq1SQtgQpnf3A4q76vfVb/kZIqbXKFyDy4Mi2bfdlRemghM32836u6hU2ICGXlZO7i/d1zlT+CENdbMlvH5lPy214yir7PTGs3wmnU1kUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYH93nOFsr/97e34JkI1h8QAdNfGqBF4bzR/uDtWXno=;
 b=UhdVs0TicEmKbXZE17x4+HwUnxBaR+oea3prp9iWzQ/rXh9+yr1TLZ+BUnjlJZm7v9XoQcxjOcfqmWRLGhIJA2xowa0ybviu81VV6yoQBwS8NzCiOcLp9XIA9inFeXwLlWpGV/hpdP2IOSYd/EHJULgA9oP9A3E1opn1tcXCbAC0MuT43WGNe/jNx662TlohkG+PAem2omyL6KffjJc4zKWk4ykeBGfcsgDfjq1BArnJy00zmf/XJzV4zY3suvXBlJTTeORaiccnVyBdg/OPRrWLZiLMKrgmhFpOzw3WYb8oe+okPKNYZfcmAaG64m+eYbaov6Ta0qbX1J8ZNANjDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by BY5PR03MB5142.namprd03.prod.outlook.com (2603:10b6:a03:1ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 10:25:56 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 10:25:56 +0000
From: "Sabau, Radu bogdan" <radu.sabau@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 3/6] iio: imu: Add driver for the ADI ADIS16607
Thread-Topic: [PATCH v3 3/6] iio: imu: Add driver for the ADI ADIS16607
Thread-Index: AQHdXIgz8xrnRTomNkec0ptJQKmD9Lb+9vUAgApuHqA=
Date: Thu, 22 Oct 2026 10:25:55 +0000
Message-ID:
 <LV9PR03MB841465FB1D5513C31BF65A20F7652@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
 <20261015-adis16607-v3-3-f972d4efee85@analog.com>
 <atEjwJb7ATxtMT2F@ashevche-desk.local>
In-Reply-To: <atEjwJb7ATxtMT2F@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|BY5PR03MB5142:EE_
x-ms-office365-filtering-correlation-id: da216796-2902-47f8-b8c8-08df3026db8f
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|18002099003|22082099003|11063799006|4143699003|261009223027099003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 BEUyI95wBt4SIFq1QK78Ks258sXwpVjM/IOKnSd7z04dz3OxidTJjWWt8l3AAh4a+hXnO6w+M6veoAy7w7wcTchBVIT/KZZXOdbZq/zUlNFEKY1vSwT46nscwvJ4JbO9MQ7MdfSyeJoKJeKbgLkA+YUJzn+ETTLscmLx5tUa6o05aOYodQBgJCYjHF78QWNyNfCkRRJbhVGsYyqenU+vGiDk+81z8N1aymn4xs83Uw2u9erjXmFFLc0nAhPcrWmMkfNebukuOP3c8H+7jFUC+h0y4KHoip5S3/OM5L/Iau/jAqefzaPTtiDPwo4eoW1ZJiOa4xdyRxd8Su4MuEEzaQ4yXbCFYiDpo81h4xOhKg9dhBuQQJ+jK7yCGwRtYloGMTd6UQ169HNzP3J2ZIzGd4cAga+KvJFdXAhmfXKGFgq5OzeZNAjkr0aHLTmVJ1LgqCnzAh6sYtuzLtGAsK6D2v5/5RMIDsYJLRa59a8mNI6DzRsjqsC6meotBNCb+IPzowguBza/fLW5sn9skam+iYwqiBgSrrIVeTBOKwLXIirEpS5aui4JguuUDO4orU3it6OKI7hSAjt0fLFGnNztvpBVPz1s/kF7mtFr/N4ut5mCfOhRHth0FMsALFqHFxy4EWs2C40KIlqCJZZOcUyKXrnDblOuGuBvXXUeMYkAzNHE2esxFkOIU20WQAQWqHrU2cTG3G/in0yfp93S4/dk5XCe8mBXgiYgUvY1PX1lT/M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AI+d1er0kmqQdHk9Le8LJOkAlN2n6bztxNJCn1jOIxcbF1uWAIFWTe48XLM6?=
 =?us-ascii?Q?SY7BPONHWy3HRvQ6MW1TlPejLvd7V0XtT2h9/PGWKGRQ74ewBljiHU6RgB89?=
 =?us-ascii?Q?yi4dAPLh7WPjqurohqeCLnMgOy12elFzlwS+LWOxUMTj0kSpAsXDCkw05dM0?=
 =?us-ascii?Q?87tsSaGc4oD9vca8J8tu370FhCP7n+jWTWeaMPUlXIbNA1TmYbsrjrkT+n/l?=
 =?us-ascii?Q?yZMocWfP/uHLBmn7KTdztkIvAux18DRW4OeCPQ6FxoMp2q6c7s3r2BqZPb3D?=
 =?us-ascii?Q?DWxN2ZZ6KzvHzqSSYZp7mshdCDfCDUE8kBsi53cz/Mppwv982aYAen0on5v2?=
 =?us-ascii?Q?QTznw3I8udGZJPqw2DB7VEzBjSWWxg3w/Lzz/qTRUhxvC5HanRX6yF0IfhoI?=
 =?us-ascii?Q?GP7FICIeWbsahqj8rN3FbkyU3ABxSgZ294aHK34lp5EayNHD1Xpzta2QOdV7?=
 =?us-ascii?Q?mbd9SPuSFANlZIdlBQb0Z0olmgKIslXjtBi55OkjFIRG9v7+V7rhCc/CyaW+?=
 =?us-ascii?Q?MnpCMJGcyglgdwmm4L+M5CYcFVDdpzjgmDIu3AXGcf5D2qTE9RD2UXwfSLBK?=
 =?us-ascii?Q?hj5gEB7egEn9tKotHcCqEJl8IAgHeTJveVsQBZDTrqev2bMz5QAoj2tG5O9J?=
 =?us-ascii?Q?GkeEJLNpEa6Lm6l/bq2HtFrdLg+W2kvhUddNkZieBmONXi68YiktAgNfo7yr?=
 =?us-ascii?Q?NhW/eOCVLlFXpUKKQOb+MmHNEMoj091KNSxByNqxoDfHfAx9R5VCiJ1Gl7QZ?=
 =?us-ascii?Q?c8Pyukq+a3F4pi1DEXdTb0KgbttTN+fkpMgVBe/Gae/lLaEYotAiJsyYBTzz?=
 =?us-ascii?Q?eWRC4eUYN6fyoM29nEg83SYjxcjgTyyLOUNhqnIX20eA5AdBY3o28KVJwGWo?=
 =?us-ascii?Q?Uc+mAvKY65l3cacwhTulsvB321TyNJrMgXqX01IaiU81kQKoQoWyrc9K2P3P?=
 =?us-ascii?Q?4qoFpb7x2Q6c17+Xu1BIIOAhQhnBoUbRpaTPAzxI/UCPOjr3w+UsSGugxy+L?=
 =?us-ascii?Q?/cODOor98hzDfSMg7ztCFh4bR8jFeB/e5j/5Xw0OmrDLnOKlyAj6IOiQVz8X?=
 =?us-ascii?Q?mRQmJ9ONBo1TYnyzCH2g5G1td/R+USPkdZxoVtyxmTD04f9Nah46Q3NOgJea?=
 =?us-ascii?Q?Z2Q20fgQVWEmJPS6DTNguirK7e1A6l3Bo9H2bJ+utln8TQmoc2AL0bQkfvT6?=
 =?us-ascii?Q?k1whCiCbd+KSrTIf+41rJD7ta92f5PaTTbjWoF0n59+aNaU2jdzZMqtS6YWu?=
 =?us-ascii?Q?CsSrFPqMOFGsKhnK1TFSmBvlOFVwy3vJVwcvEQDB1VMaybHRUNyWDny4lFoq?=
 =?us-ascii?Q?5t7azY+0W388ipAYCuyh8ll4JPjjtuIHu/V+SGfGQIuNZHVKnsmN+4y8NOWd?=
 =?us-ascii?Q?3qNeJXHYjeixlqFYiw7ZP0e3GI9d/kDqPRx10OMl3o/ti4TfEdWyFlF4fXNL?=
 =?us-ascii?Q?Y9O39U2hhKABPNXQCw8QbgSvCGWYdzRT+OnDCqgpmYzq+pSJJnJDz70bnEUT?=
 =?us-ascii?Q?J0leeRF6ivzhGEL0bgxmAoI9nlLySw1KiXvaqMhoUjcdhRvX1Kz3UDnqCm3p?=
 =?us-ascii?Q?PLv8o7DvuBM0qdoLHFV3YCmx91XwVJ2Ue0mbB3VVWFsk1Lm5nszSGj6SXjfQ?=
 =?us-ascii?Q?mdpEWHj7LAhCcrpK4kmydixmUD80lnFextDcyxqYeudp+HGqLgP9I663l4Sg?=
 =?us-ascii?Q?DXX/4KlXQ+zpdVnn83Dcr1EbhZVSj9pIDmbfX3diqyu0AZTl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jPE0dUFAWbXhgkThZzns13LK/fAehcrWbbIByMAcAYZQ3O3nKtm8XwGNx6oCY3ZnNXUYzwQlzzoPjnNn9lCpUA/EiskWlns+Fk2vHlSNLLcpvPX2SnIYlXQWDPMwSYcQED5OeoYl1u8F64FODS38RSlkMwxJZJU5kyxxVpwTVLysr7iP6UVPn1FRSOUzWTHK/O2NEP3Ec8QTqHuTguz4+an72s5a9loFVGdOmUBL2iBXhoi8yNeQ+J96f6prQo53iTgY874lwzTKYhcNTZPt78WCSfURIgHPwXRLS68sF3DysufrfMrScBjQAz+aXRpk5sEtcW4GR7vlA3eOhYt9TA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da216796-2902-47f8-b8c8-08df3026db8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 10:25:56.0223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ltXN+XkvODV7uV98SHTbTKge/S7BQ3nLkgPX01WQ51McRurqHzvwu65amJUrZ3g3EIg5LhdTtBN6pZmvgRiOYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5142
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0MSBTYWx0ZWRfXzHNyNKNVeAeg
 fgfgeqFWH18NXqPTgRLnSBptriS4ui5dS//uslz+yLNhGh7CrWl25HLqNHItDvhao5ZpwexKnxH
 9tghZdbY8uU0XbUCfg76lOSHyQsIeX2cgkWz+FxchpBw9OO68V7k
X-Proofpoint-ORIG-GUID: xO5opWvGtzPTXfGXqyup0LuQLnHZ6QI1
X-Authority-Analysis: v=2.4 cv=C5V8WgP+ c=1 sm=1 tr=0 ts=6ad9e4b7 cx=c_pps
 a=TcXP/BJ3gOSVg56PH7Z4Eg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=QyXUC8HyAAAA:8 a=6u_Prd65h1TO-GkUG9oA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0MSBTYWx0ZWRfX1ZxccjLIl0Y7
 WL/oHFSQuDTWjcrNsVClo9HbxvVT/UuO7TS6tRQAkWVW6Lb9yDu0sysHTrniXUbVMggqp0HFeg1
 iaEAWbPlWdAXZY1XVFs7M6uz6UFk4g7J5jThiQr0BVl2OCN1zxEcaRHWkUn1yjZfRl3Horn84ur
 3zmHgdL4aMuwRHYztWirWzHT1d1lZg+rS1owgZ14TMubt7cjO4TwnSxKvqIUcKckopWDenLw9V9
 DGwR317WP0oYjsJy+JZZB46csCBupG0im4i7zj0SiSGTJCFERIbhoIO7SkXdRagHTnwpL68DDpC
 xgjmJfo1SmItiNFGQmwbBFigFLzL5jzDEJIHXvJRJyB5USEQAFqR+4CnF4WPeaA8rW7LXd9oNFo
 E/PELqW1tFpl0RYZnq6qF/KOJI8RdFNkPFu5ei33zIcGXRYHed5FXgaOr4LGq5ujgC66rRGjPXJ
 QBn2kaWHed6jNAwBD9Q==
X-Proofpoint-GUID: xO5opWvGtzPTXfGXqyup0LuQLnHZ6QI1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220041



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Thursday, October 15, 2026 10:05 PM

...

> > +	/* Route a reset-status indicator to its own pin, if reset-gpios is w=
ired
> */
> > +	if (device_property_present(dev, "reset-gpios")) {
>=20
> Huh?! Can we use reset framework instead and do something with help of it=
?
>=20
> > +		ret =3D __adis_update_bits_base(adis,
> ADIS16607_REG_USER_GPIO_CFG,
> > +					      ADIS16607_RESET_GPIO_MASK,
> > +
> FIELD_PREP(ADIS16607_RESET_GPIO_MASK, 1), 2);
> > +		if (ret)
> > +			return ret;
> > +	}
>=20

Hi Andy, thank you also for taking a look.

This code will be removed from here to probe() as per the possibility of
the device hanging discussion, it make much more sense for it to be there.
This was writing RESET_GPIO_MASK after reset, which pretty much was a
no-op since the device already defaults with that bit set.=20

Removed the duplicate here entirely - it's not reset-line handling
or reset-framework territory, just an on-chip pin-function register,
and now it will only exist in the one place where it matters.

Thanks,
Radu

