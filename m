Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAB832AABC;
	Mon, 23 Mar 2026 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262394; cv=fail; b=NcEQKH0rh7kkjK9yyjRtFUN8COlAcU1NfdiY4tbreS3JhqXc/bWdq7k+afZ8v8mJg7qXOawkmR79fgdaqMS20PeLoh4g1e/8s9+lcyx1UyvMMdr8UgY1GpOXjQayQ//n5sTI6ve1gwf5qftSHkFBv7OYt11k4lF5Qj6hdpwISTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262394; c=relaxed/simple;
	bh=RpLSXZiY8HLGAUintkFtMGfRSEB6orgAwukKXV9rFhM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Clz8dV8KFqTuD3wGAbmo9rErAaDk8k+tSztHINLGraX/63aGxx+RbxBfw8qj+iGKN69aPGxLov0HNArK5u8nSapEZVFASbsJGKMKu6umSNHDcyKiUHhDECZATfAAMDGFoBgK8XxQqkJh4q/OuybTqim/zsFuWBFVERPNywdWXs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Z3OUChK6; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Z3OUChK6"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N7V84m2962484;
	Mon, 23 Mar 2026 06:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RpLSX
	ZiY8HLGAUintkFtMGfRSEB6orgAwukKXV9rFhM=; b=Z3OUChK6FMLSosa3so/ah
	p/XeYaKU6ZL8rGBBr36OyXdJmfCtBI6cWd70zKwNBV9D7Chpcuf/NCXLuuVzFxi3
	ZAQ5PZa8wN+fR3d95d3MVob0i+/486gms8l+7tjYq7ITCnsyGRU6qr8o5/O60m8Q
	UtE5A5Cq7z7Tawz7IP03Xp2M27/CH9JzlruLSFMVKiNJDCG0IL3UPG+cj9OxvpO3
	Z6jcPwhFlaMN5bngxjwedqs8oGJtqEc9LGwC1GSY+G7wwex0XFgwnUm2LP81lSpH
	KOFr+9Oqd/bJ7q8EQgObYMTcpAw9jZ5CIZ+Hw2kFhH2LXAjtDzSBDcOTT0y0SkVg
	g==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d1r81xgyw-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 06:39:32 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXZP/0NhobPJ6TpHlpyiATbvq5Nixif+6L1Wljb2YfcVatRnSU303FaUZ9JOCyMLVUJ+Cd1RZoBTzF/iy0C1C9jwB8fgW+GU/YegJcR6W/DsQ6OKBFJR3nhRx/4HmvKO0PqryWIs6pr5PCFDqsLeO5FviU3XymcuA3GGePKs6UVPDZ3a/1Gm2Gn34Rd5VyTfz1Tq4t8Q7MRDVPP5rpZJTHsA9Y3Fwnr8nyzGHQPhgcCyAJra5Fb7dyptv19T6NIaFjbbMWLeNrWGi7KC95/FaqRMJnFNWVDJlFIBs7Iv/AK1TJaT3cAwlz0Bv7e9ir4TL600Is7aVdRwxnAVJd/AMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpLSXZiY8HLGAUintkFtMGfRSEB6orgAwukKXV9rFhM=;
 b=mZEWdOTvgnz3MurVmsIvsOn9hC4nA5a5MI37Pq6crE6PEAeIY3yl7mJ1eG5Gqn337x6IT37CLOQIAg7IQEjq2lVFVHS9cVRABdZoEF1UfR8xvQJCeCVVpuyfYRuHlHBMIdU6fxlHeRk5bykVHyBnwMIPVtnZH2+pQkmbTtuWaapg3P2tFLiGXs3NXygdd0o0N70N89q7HvOSroGd4UPz0hOoSQ23HyYRuXAGQFVb8K6jbvNJkeA2rlGIf/Edx713QmCX03PHTfJffuVP7aOOisNh+K0dIbjw9NEq9GijO/l22T6hrOxAVvZ2ZVeWuO1kTzOW7tTji1IeCjTB0COHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com (2603:10b6:a03:2d3::19)
 by SJ0PR03MB5568.namprd03.prod.outlook.com (2603:10b6:a03:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 10:39:12 +0000
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0]) by SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 10:39:16 +0000
From: "Jones, Carlos jr" <Carlosjr.Jones@analog.com>
To: Conor Dooley <conor@kernel.org>
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
Subject: RE: [PATCH 2/3] dt-bindings: iio: adc: lltc,ltc2497: add LTC2305
 support
Thread-Topic: [PATCH 2/3] dt-bindings: iio: adc: lltc,ltc2497: add LTC2305
 support
Thread-Index: AQHcuI7MyIGrMFSCsEGWuy98DZL3XrW3rKOAgAQ7wHA=
Date: Mon, 23 Mar 2026 10:39:16 +0000
Message-ID:
 <SJ0PR03MB58543E2CB9C2EEAC439A2828F44BA@SJ0PR03MB5854.namprd03.prod.outlook.com>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
 <20260320140819.191700-3-carlosjr.jones@analog.com>
 <20260320-popper-uncurled-723c68d33554@spud>
 <20260320-garnish-tremor-0892abd6ae86@spud>
In-Reply-To: <20260320-garnish-tremor-0892abd6ae86@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5854:EE_|SJ0PR03MB5568:EE_
x-ms-office365-filtering-correlation-id: 9b028a60-120f-44d0-0ab4-08de88c86e71
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 WTB+6M869+eE/s6ppmp401sgB+cyj2y8duZNtZ+qtk/P56fuQ8gOoqtvM5QGqXMQO/ZopONC7Y4rWZBn9TKX48rUX5CDnbEMyYTQGB3G6nenFm/0Huug/8gqE7z55U95Jp4G6RDfoOC8lzyRHP04rjP8s9OscRzef0pfzuwPHUQwGuKVkYk9fTBNmCS/1dqk3WgyDhQUxoPwd0NR+chvwv4Pe6tvWakTe5k+gvEeb5IZgLCQL+3gJoCiSZRRMFi9rCPsxnc5ZAHqowpVjuPPe4V0opFym73ESo+pYosrQQDAYGfUZdw5sk3eI0q1vNHx6k6GdAD6YBGhk7OeUNfKbn/Uy/nwvRe4SPOJ7wLmY9cr27F+yvVzjeQKc9jSz1iSlpIGFHwcu6bcupK55gpacSuBcHUJkR8Ypzcs8xcOLRal6lUx69/PV6e0HdE+kvssh1RZyHO+lO++Cu9ctqErg3H7QV31Ciz78ZaTuZV3DpyImua10cs89lyEdPpmjVagWRPBoFqGKR8AJThxu/cXjte5WNeIfHOpAWMTtn3KTmccTlkE/E9m7k18ooeiNWIYoMsfsKBohz6eAPPvLh3ymSNEUN9KVGoXWr7txbrfm7ptjosUMatR2iC9G89yAH+7zI0QsQHYHnGVga2kw3qqdwUk8UC/A1b/64K5c9EtIwBgfLIViR47NZexTxBmSVIq6lfrmJ3dY0P7pxjjh4l4ospSTfTmJuutKpXrw4YcUA50+uGc79yMH8qD6coz3sVtV/8jc8xjqPLdB5aXBQ3/+Hbfqa1mhZlpc5ZuGCt23ww=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5854.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IugjmcdbUkiuSEjHC3FPddANHn5ligduHNie2sAa89vopV3gFhneN0I1nf64?=
 =?us-ascii?Q?bilJuSqGyHHderbpM5V/hfiK8TeBsC+XfNKVzR2iOxoCUzsSULlbV/X0TS/q?=
 =?us-ascii?Q?M7eAhGbkvo5GhYKyzTKYPl8pdS4vSMVjzpz5/dh/aObG95Fw95t0wAeFxMkc?=
 =?us-ascii?Q?Tb9HUfCGXbpVq45tOoVKHeZDWE/HHrmypSuG6Q9QPd8vjUpKEvL1sfToac7D?=
 =?us-ascii?Q?6DaTRDxpaUsDLRpVnlRR3VKp8FDoESQ7pOLtdQSl6mg8E2hAojk7gBOfYglV?=
 =?us-ascii?Q?0ahabHdLpZhzwh14zC/fhJ2u2iBPYXrho+Bn2JLAmZYkjPwCtiXnX+IiEGVL?=
 =?us-ascii?Q?o4YAehETYsHqlpiI0ODnVzZtv/A2hS0f0UAjpsgKwmART57Lc1s3MqoMtTnW?=
 =?us-ascii?Q?o1XeBk+/YA6hfY9EJFq/JrN2fsdMdB49WkTfaTJbKUHJlIgzwYgHAY8I66Dd?=
 =?us-ascii?Q?OAIGf2CZgD5DC6XPeFiXzi0RMKYbVUHRa6XEiEqVNljLBIoriMeaNPcNUFiP?=
 =?us-ascii?Q?1+fGyasS4tXFFVeV7h5jdpL224KTKDSnXa3BbDl+n9Fl7pfY+FHy1AGq7RpK?=
 =?us-ascii?Q?LQeJPd/B1fk4jYC4JM3nCvb7N5waouesplC2wPRxRYUg4SNcrtWRcWQx5jIn?=
 =?us-ascii?Q?X23lwwzfJdlfX1NhBCxq5m2WnzRFu3RZuHWdEbgxbGfMRbZ/Xqv8RTIvkpoo?=
 =?us-ascii?Q?KgnxX8JXwrV6UbV/vlCm/sTxV92q0r1mj8bVzsc0yk8z83EIkJBKVYZRW+Kb?=
 =?us-ascii?Q?2IPEt53gTcyhE/2seFXfT9B9N78QZduAT9Vv6DHeEa16iD8P8gcZMXP5Bnq5?=
 =?us-ascii?Q?uZEll5SaHadmOgbWpodu436S8FZH29Wdd5//P5Jzh+v2NRCTNUlN6Z5zMGd5?=
 =?us-ascii?Q?Ws+C6yq/PCvbVI8zaZzJQlw4KuK6pORDhxhHQwQph+Z25hTt7gQ7KbBZmEJW?=
 =?us-ascii?Q?Pj7rgvFC+23BJ3viVz2xCVMibm0ZP2GOjsgJl3N9nZTqwJb+EHSK2l4XKtq3?=
 =?us-ascii?Q?ZXvJ0rKeT4NBi5nEDdedqBTIvpiuWi7mLyHntKyljQ8UCpLRYx28/Qu7ew14?=
 =?us-ascii?Q?dOt+5X5rfBf8WR4HlF8V/fnsSSVxtxWQKtSQPwxuCJiFHcBBYzehHmnbBZeo?=
 =?us-ascii?Q?WiB87LiWoIddlRENckqGRC9sjhVQDqPHQjrff7ZpwdTTna1Uy6luaNQcMAOJ?=
 =?us-ascii?Q?eBQnEvo0Cwlbo9MGcd+QJ2uHbuOrZfCvVTSGagLfwJR5NOo8PRONYqXtG3Rq?=
 =?us-ascii?Q?3FtdJC6JWBGtLhsfqV/eP8Phu6vNGyugmbg3iQvppWbtpUhf44N+D6Zeys56?=
 =?us-ascii?Q?xHhPm4+el3KjESzWa3qJEre6QS9gCm8YgYOOryBSBmJWB0u0ONwwQe5mgWSH?=
 =?us-ascii?Q?qf5c7lDxGxDosil/SAkoMYQJKDdB5CZv0zLAJYgOW1byes3m7mjGUniO8VsF?=
 =?us-ascii?Q?25cKfLeAA3I4nYrhY+N/husiLLhlaCBmxKZpURE4huk0hZQq/1OSsOBG8zNP?=
 =?us-ascii?Q?d5yezei3G3ngTsaYYq8V7BkL2mlcvprfSAG3p2oAcB9mTGNUA/RPpCCv6XyK?=
 =?us-ascii?Q?Ltin5uSO1Pg/mDrnqaRyJeDZ4kW5+/n7V6AdnYi0ydcBqEF27cujr5QaXK/E?=
 =?us-ascii?Q?6xZmtCQwA+BcHXVOive5sZUxkp7KPlINB6FjzAhfXcH8+Dl6rPhmyb/DaQX6?=
 =?us-ascii?Q?eZJxKFVHpQxaooSRbuIg1F3IKBf4BwGmqXDJwYgFe31J0dByWyimDE6oFxjn?=
 =?us-ascii?Q?pKfZpdtOEw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	TTeGtCqlO86e58xdYu+SPCms4Tk3JA60aqU5lMLfUTmQgUq6WDKtssnuoPZOW1v0xL92iMheAm6qH57Ew7F8HRvl0Lm7+OEw1Bni+wIEg98LFSO2tVbQTjIKexSfkHnwAGHirUrmK+0ULfN+wCQb15x1wTP1zo7Yd0eKpF3M1uSrABm27W008L4w91m26bT5lk6qAGy/GAu5dczntLEAvUC3rj7+coHBr4ekTEWQaKFFseaMGtJN6Or/5TqsXuduS+50uMYKX0k4IztEWK4MAF4xb5p1Er/7InH5O3C0kju1SjYSXcQMggEa3SzVaPW01A9oHLmtd+xc5S2qq4Z2MA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5854.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b028a60-120f-44d0-0ab4-08de88c86e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 10:39:16.0792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9IGhtiySCSOYzLuVoN5mnuOhzfBwu/Zacn7JxM4skbQ3YS26IKvLU4wQjdGjyAmDpmLxkAGhIP69tuchl3jJcj7NqYRU9/TTLzvo1/UuNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5568
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MiBTYWx0ZWRfXySOOMfRdaqJt
 aIH3pUxzbKmrNe1rNHF/wC95mcq5Sjw0XUHuH5Y25TPJ4oMMdhP1TO4FpFjh0icolLQmhYnmMA0
 9+fZF6tw+p6Hr4t9OnoNY6rkrudlgQmdhtIWJf5I+L32RA48OISztrX1h621Cag/9PHNj/MKnfs
 CM3LQzv78hhdAN0NxdpwmY7sLTpHsX5AZxzz3T4FmDsup4NBC8Kn24/lwjPPl8cq8pnlRq2Ujd5
 IWxverDS9rYTtYutvC74k1ZDbgD/3OAQgZzQiwPrXy5LPrS/uE157uePDu3l+kkaq3Y+RGhKLOr
 DovzLgncX0IgoHkdxK40WyApNYzcb5wImKQ8VS4A/Z/Bom4JvWMTAqaM/G7+HbxFcGD2c0iqS20
 GDIMWU/iiYvhoPGpUsRJlYjgh4LdRyLQiJL4FzoZi4phu0k78JGh7IilVWhiDXdyRryD2cT60Sa
 D+PCpoXeVp+T1tAnhCg==
X-Authority-Analysis: v=2.4 cv=edIwvrEH c=1 sm=1 tr=0 ts=69c11864 cx=c_pps
 a=CrKnoqqb99nOpAJSR4mnrQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=E5hqgqT-Typjv8-HT48A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: PcytzS_CBd91wDIOTEhPDnq-SZB5qcok
X-Proofpoint-GUID: PcytzS_CBd91wDIOTEhPDnq-SZB5qcok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230082

> On Fri, Mar 20, 2026 at 05:27:11PM +0000, Conor Dooley wrote:
> > On Fri, Mar 20, 2026 at 10:08:18PM +0800, Carlos Jones Jr wrote:
> > > Add support for the LTC2305 2-channel, 12-bit ADC to the existing
> > > LTC2497 device tree bindings.
> >
> > > The LTC2305 is compatible with the
> > > LTC2309 driver implementation.
> >
> > Clearly this is not true, given the driver patches in the series.
>=20
> Additionally, this is a binding so talk about hardware not drivers.
>=20

Will revise misleading claim on compatibility and focus text on the
hardware. Thank you.
