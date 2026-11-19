Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795074446;
	b=jtc5D9Xx8kK3GeM6Qjesv6Ld7XlMMrDCG9QE+OU7lKk3mxcZjRnI6jCdR284Jhmzjen5
	 bQGKt0c4ffTPbuaZziUc0KCK40p9RfOdFJX1Rut+BFIyHY9cjLA5Q3FqhiushG79GRAHX
	 YERvpJ3VQc/yrNwvboZvsPc3SbdkzKvtC1qJiZDeK6VnvmlF9UZkRgxpCaJjPxKZok9DP
	 NouYQJ0gMrOcS5QTF/NlOBwge+bqukXHoHDeIc+HOB0yhLpyufj7Mmm0kZnCLeDKUWEK/
	 Asl9MnApcWzhoNZTHV3buOvF8HNet3EfHBGxw6IkD2UOCzjEtbpRbtHaXtjxOlMNA7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074446;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zShpAM0ROdAanRnl15XF/LsLxLSDt5lnwVHDL/2Rc54=;
	b=0leODbmCmpbeBmfBeFQKqV1yPHB22KF/m0dh7DYDqSaH/R7W94UwSSOgRiQowREhJStx
	 +/eABk94waNSCV668YzbvDdJLNnT9mZEVcp+o81wqKwiAYTAkM8zeTFSCCSydJX9zORYf
	 8+FQxpDsDL83muH5oUso1P3UxQqNEWuwy1iK0xL3jrAyEn0V9CkeNs11i4rQJdW2RC2ZF
	 1LmPh15pwl9lrfTILnuGsYmx5EIW8TVZGQDYMvfhYjX9pQWEa6A9Qhc1VH8odG5AokadE
	 PL/oWyOCQO/pB5yG7qRap/8BfD1A4uZF14h4hzqNlQDOYGcN7LFu/9SWw6tlpR145+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=RClSD9YE;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="py6ht1h/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F25606A320;
	Thu, 19 Nov 2026 07:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0F25606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=RClSD9YE;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=py6ht1h/
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6x2pk1419827;
	Thu, 19 Nov 2026 02:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=zShpAM0ROdAanRnl15XF/LsLxLSDt5lnwVHDL/2Rc54=; b=RClSD9Y
	E1/JVs6ahClW1+P/WF8IFUyzJEn5I3i0LrsVH2yVR4fCnLzBxR+LNkce78DYhioK
	rHamBiGI2TguAafJCpL+sCXpzMYkdR2fMYBNo4IUXqyghEJ9u+8P6Vu7njMjCPjo
	TK5tU/5OWxOTICzEl5NtnNoBzIZhAiQM4Gf5Kywx5cO33zW2Ku5Ux70TpDpTNl2J
	cRB/Z42rNMZjJsqEzzkLtDjzfbBfEaK/+B+aCNZ0fbeGSEa8laacA4LeO6LhWvOX
	y6uZOKPS0TSnkcAUEZg3t5pi2sG6tvZil4utnksxz27NfSW2rjMUGWphk61XKtE0
	CueGPoYtvgixYSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zShpA
	M0ROdAanRnl15XF/LsLxLSDt5lnwVHDL/2Rc54=; b=py6ht1h/gypkdFsffGlMc
	bvUD3s1b2OYGOqyTS1wK69Qmv0n1YmYPT9bF+V8s6yybyXGrVwT83TYyfjgniCKP
	K4nWSfXMvwd3UuhgDDC3cAMp0QbqNq2rCd9jjYUPeyz4kYsRb3Ubx/0XPn7x/IFL
	uBNgtcwA92988vyY65FseUqOXNh+MD6S2gCrq6iYXn0bzGeKuZoOEokzIGDXtAIQ
	JtS6UiL86iKuNOUH8iE1RoyFKGI6L/lXsgv77EORZG8lB5FT1xOzBVQXUzBc/Fm8
	MTy2wWRNkrdmJCWyIvUBAmq0ixXNNpZ3+nDkNxOZFsGncAkYGznpn1xZtFp0rn7W
	A==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j1kmkjuuq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 02:47:07 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBk8YaZs+YYRyqi3qcDObpkzMWNwVlnVMC1/8v8l+UFLl/BHsBEHrFvZcjrpRCH+ddjejQyVFNq15k0vqan0BkFV6LKkfKnnsgbXEybcYxfrzjmUobmRCKnFn3Opxbvrw1E0/9ssF6YbqBesMiw5kOnjN14CCMOEs1nlozyDV0KFQdboet2v6SvdmHeizU/of87c7M8NR5am2YbbbQmJzbrHEOr8J0l6zWEu4ZEt/DgiOJl5tvGPpnyjS+X6n4ZU8clxhf8+UlKgP/Nyqx2n1uaZUYmaNTrmUoWkbRGzZnI2hjzNbcQX3y///kButqWrx4bPLleItlFd/+6Sz31mAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zShpAM0ROdAanRnl15XF/LsLxLSDt5lnwVHDL/2Rc54=;
 b=xk8BvmkjqQNEUSJZAqu2q907jCuU1jL8QLQqwzvP73o/jJEslhIZfqL9ptC1fCyx/f//xySCKufb1ACyo+f6NatXKUQ8ew2wUVjA2H9B4FXEN6vUn57d4DLiUL8kWAmbg+libQ//4V09VA7b/Xn/sJXGGFExJ0q1y+fZ4nODaedQ0aRT/5UlsvgQnJFW/H0iqRRnkFdn2DTFDKpxCtru2jfzzig9zlpkIgHpKcy8Vb/dXY5etY5y16XTM135Hka0NuMUu7xcBD7Ye9Kk2zdLZ02C0jzQTtJ7oKMN6Llz3liCWBdwDZlceG6kCpP9IzCu6vCj2+b4yvGuHEZ+/0q3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from DS2PR03MB8418.namprd03.prod.outlook.com (2603:10b6:8:32c::19)
 by DS0PR03MB7752.namprd03.prod.outlook.com (2603:10b6:8:1fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:46:05 +0000
Received: from DS2PR03MB8418.namprd03.prod.outlook.com
 ([fe80::4669:571:4347:1b1b]) by DS2PR03MB8418.namprd03.prod.outlook.com
 ([fe80::4669:571:4347:1b1b%6]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 07:46:05 +0000
From: "Tsao, Bruce" <Bruce.Tsao@analog.com>
To: "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tsao, Bruce"
	<Bruce.Tsao@analog.com>
Subject: Re: [PATCH 0/2] iio: dac: add support for AD5413
Thread-Topic: [PATCH 0/2] iio: dac: add support for AD5413
Thread-Index:
 AQHdXaP8M+1ukguSuk6GgnmGOadjObcEkV4AgAG4jzCAAULsAIATKFgAgAGEbLCAGPrP1Q==
Date: Thu, 19 Nov 2026 07:46:04 +0000
Message-ID:
 <DS2PR03MB8418EC84B10A45C01D848D4AFB792@DS2PR03MB8418.namprd03.prod.outlook.com>
References: <20261017-ad5413-upstream-v1-0-61f40c8fef25@analog.com>
 <atXY4kLEXxmG-tnk@ashevche-desk.local>
 <DS2PR03MB84188FD41F8847EEB34759D9FB672@DS2PR03MB8418.namprd03.prod.outlook.com>
 <athZVjaGYmCyuNrW@ashevche-desk.local> <auhqSGR84LUTjBS7@nsa>
 <DS2PR03MB84187FC75752460484048798FB692@DS2PR03MB8418.namprd03.prod.outlook.com>
In-Reply-To:
 <DS2PR03MB84187FC75752460484048798FB692@DS2PR03MB8418.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS2PR03MB8418:EE_|DS0PR03MB7752:EE_
x-ms-office365-filtering-correlation-id: 6d70cacc-f869-493e-abf7-08df46112a6f
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|3023799007|4143699003|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 1tOm03m813knKEFfe+NrQWAYvif4TVAhGgqToA6T9ZnjCm6Ctz+rCBadp0yYQZdU2zUeblFVK85pRfKi04/sPDKTYRC9B6RMOOowcumBv5luoJZ707qWfwi1Z5PJSPVJ7UhlK7jsP8WMDHbUHYuNH/GVB8+PWuISZUUL1KMJayXPN2mxB45GvbejKTyamq65w9Ln3qE2mr7PbXVUborTwk5uU2DmzYxSgtrLkVIJxuWMIZ9MbGydQ1FKPw6SImcCxbORvc13lOlaVF/JSl8wN8pkc9ShLWHZOfV62gBNC/8VE5xRNX0Mzh37IFHZbCzwSi74x0rs2VDySVwyRvTPVBvp44SgteH3s9PWFSESo2sUev2JDPGoWuOStdfAMjrZ1TtcK+hKOqa40t87CGTOpLi+6oPXHybKCmcDqEwWlsmVehu7s4OU/RFiGxgtm2t2c41tzKdOHRxS+nDHSc1ffa5YEI7bGeOGNJs18w7jj/oBJplXPHqurOPTVKbs4CqAN3TSWSsYdHm3JCVCGtjNJ3olNOvFK8Jk7rHj7MrKnVRyBHkqybWwBEYv7k8DWIQxwGygCIi7SIO82m2kUTNUOoUO8dTHzqAlYPKj+qIVyuik1G5XRcgEyzeS4qkwXbOij2ZGny/qhFQg01zxWRk7OyXUhJWp4mL/tm8xslWfmLtiRPbZDK7HgWxScj2IYTMQOwugY5VwPVkd9sySPgH51tY4xC6MoZmjnBhLW+KoGXg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR03MB8418.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(3023799007)(4143699003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?B0IA99n8dYhecZpE+qk/0MU12LP0RF7QhoM1Kgu96ZvyA/vyBj4JZSE6G0?=
 =?iso-8859-1?Q?oxaXy1wiq+zCD9QbTThTTLHuH4id6WdT2IK20LI0cId/NTt93s4Xov9amO?=
 =?iso-8859-1?Q?Tvgm1tn1S3Ns3O8DPUn5AM5y57xC85vwPSVqv1FqqcNBmz7eiX5pQH5dVb?=
 =?iso-8859-1?Q?M/H0NiFDI+olfG+ul5X57mpcRQ1YCTULCLfPdD0LNWOdL0hAOXHwjdZ8QJ?=
 =?iso-8859-1?Q?DfdOJ8NltHVW57aiI3rwwGLnF6L7z9AYAiPuc3f+sBNb9FDdzAyo9ZesDg?=
 =?iso-8859-1?Q?eWP7RvAhaLXEeMGZeCmngC5z0X1AOCNldVdY17/PZYAl5KrdhdmELMWCsq?=
 =?iso-8859-1?Q?RL2r33FtYTKFE2GZTIdYwRrvrqyaOrrxgJg/ptGFnGyUF/pflINLPQwEVz?=
 =?iso-8859-1?Q?C3l2Y04RilTPjAtwFGhzWblDKrp5nG4TYNCD/p994Tdp/QoHGTDWjckwjv?=
 =?iso-8859-1?Q?uXOMFjyqLAppHeX/t8ORkdiICo9DbtPMyxdzNGfq7H06YFFozqIlHs6XgF?=
 =?iso-8859-1?Q?EKDF/lUCvhtei7McD/3ZW7YU1yUAHmzwKUACBXpa4NO6ebV/WP4Zs5uLuf?=
 =?iso-8859-1?Q?sDoWURllt8b+EPRAhltAyRp4neY1bsJVQIvKxpeUcLH7+DK2Ub5o/XuRFS?=
 =?iso-8859-1?Q?ZzTnoBfqi1l7c4JdwAZHAkBPfABhmB9WStbVwTLQbZBQ0Gslus1tw4QQKM?=
 =?iso-8859-1?Q?N7zeE5Psu5skfFyRzAQSiNkpLdUcDYej+5f9jZyOxqqQecb1eUT95o0iD8?=
 =?iso-8859-1?Q?VP8tRDY66oETSPjj6ja2iRiWgusM68A3smWDW17f27iL5LwBB5S/NaVPIA?=
 =?iso-8859-1?Q?8z8XUmKZNa8tqjEdu/wh+n+Vr+oFAuA8FYX35Al2vNdX+opNMGsU//8WpA?=
 =?iso-8859-1?Q?NOo3EsmVWgUj09R607zsFGFYr3ml3xoLtSQQOhsKP+hUYxsuPnMp3K2Wov?=
 =?iso-8859-1?Q?XMOxU4opxF80kRKdACUHnFKNgH8C4TDDb0LQ2w7P63t8VgCq6YVxwFiVrq?=
 =?iso-8859-1?Q?XgHvOQFdQUdZMj6HlUhlVpK7fkLMueAE2W+JJJjnqgaJZ8r5ObIclcq6p6?=
 =?iso-8859-1?Q?H8Fh+StuY0RMzQJu1MrGbFWjGlfBmixiYGxtC0YVfKZ486EU7Al5FHhM7P?=
 =?iso-8859-1?Q?v4wB5maZlDz5OH511nkl2GvIOe90Zq0mzVlXZTVsW2CkObxWhPWLVvhT39?=
 =?iso-8859-1?Q?gqGTgN4lZ/R5925fq7LA8BhEMdrQuCuIPP4HaUitJeJd5Huy1jCDCVFZ6I?=
 =?iso-8859-1?Q?Ng/CY/hodV6twIyqd71ubQaCwtqj6TAERgzR4nWVsaGtE1q0I8xEBHMPlg?=
 =?iso-8859-1?Q?JYYxvlE3jS3wio8b2D+zpP+g5TimzzMvqBzCXNbs5s0q0Dlxa/QEV+blp7?=
 =?iso-8859-1?Q?+4RRzuoLokOjOLhcCK1SZ2ueJ3Rz656q1eDeXrt2by411OzKWh+kysdues?=
 =?iso-8859-1?Q?T1bmIXCVsb1WViCAEr48aOTusXI49EI0e+/0VyS/GV9Q5IPZS3zAw9M20p?=
 =?iso-8859-1?Q?ULPqQ2B9MpwX8xw+0WQSYuMxcpFl1MDzgIAM21wabypSkh8RA7H1E4idnM?=
 =?iso-8859-1?Q?mdWnEGDCxARowB+xIzepA3mnixNelIvySzkipllH05/v+7BIIOzqPhI82V?=
 =?iso-8859-1?Q?5WQLRvL/Fz947GH40W98B1C2h3E+LITp+vN9CQ4oVs5GlKA25Ej+UezGYw?=
 =?iso-8859-1?Q?Ok0zAObEWipNxfmqA9nYEOmw1y5t+GPTKuYNGLcE2P3HCgl7Z7oXjJoBfK?=
 =?iso-8859-1?Q?PgFbyfoMm9n7mIfLkPUDnqdnzuw2qDIZPRWaAYwwQ2It27s6WXsygZcRrL?=
 =?iso-8859-1?Q?7ZWoZ+lmzg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
	juJ74SiTJP3dfwmkkeTLjOXFJxKPObu5R25cpn27dG0BEUEk+S/XTqa2BzE8Q0EFHR7aXNCTLd+PDPmj2Kzf1Zj9NGigvCutdi19VZu1ggOoOLabaaOyjg0H5EvCVt5cWQzcJRsgBUX3x3EwgNvMnvLV+ySflt2spEwxfB8BWqOLQikKlJ1ec1GWGRVypKp1aQfxNDPN2/HDOmtliRendwvCDBZ0zPxharj4inXakjS1B6LNiUCe1GT+UjXg5mhHtMWLfidI/bLELMp0xfLpQTH1FPHwL7Su2YCmwDONS0Fmx5Df4209nggfcuOjwElnJYTwegC9SoCqRpm0UUHLbQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS2PR03MB8418.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d70cacc-f869-493e-abf7-08df46112a6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 07:46:04.9739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8zRk92w8gurYWqiaKOKcIUsTBXvpFu5I/vw6F6fy73GCLx1Cxg5MZeYtjTIQm75SZhopBe2JmTPx5lRGHmO1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7752
X-Authority-Analysis: v=2.4 cv=MIr1C8Zl c=1 sm=1 tr=0 ts=6afea97b cx=c_pps
 a=qCFiEXCgs887QpJba4awmw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=h_cPbwIqzl5VvyxgcDcA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: H1D9x0CkZ4YArCfelD6ABnwIpVAzfmTr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMCBTYWx0ZWRfX/hB/Be+rHDe8
 Rd6yUue56mfXrULZkN+X8tw92ZzlXC/Jp630biMG13ui43wj7Pa8jO1wuWPmHeEsEA+4zgyulYW
 AfxCAOW6M/PLHgI80Ka4OBHpC2IF/QxsP6vfh0MOwX4lJ+QT4IKX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMCBTYWx0ZWRfX42br4/zjRhJ7
 t86gqc18RN0+My14MIGo1HiCW2QEQ6LvuH/JyW9niDAq9+dPBWD/NHZ0NBYHR5gx1+Rg3Ywtu2z
 v7/5lcwmfkq9mcwq5jsMlBT8IRQ00PQsQC9jXW6Sr+nQlrfgV7d8ulEwGnQRv7gutVeQCfLOl0j
 utN1JzcILIZFtlZlcmn+YoKgmuvNubij0IQkYxcylJg1hMhss0BhG77kHTOK6J3I4AGn1giSYaE
 4+yqWat0RCMO7hiqDtzScj+R4j4D3qzNxhAga8/dX7jj73QMQ1MWOUNycJarzcrRkPPeMRY1i4B
 X2UUWFwanM3JGv+StWPtuh7zgUEC1cr+7YFZNQGivdJu0g7bzBa+6oc1Od2CLCHvv73d/XE/GsP
 hQvMiwql2KAxqhFCfw/xm4KgDHP681BQY9Pxnk50bf8YEsMmxvSjMyfI5DvIPR/gi0+hYpVwUu7
 c299TLTn7DxTbkmejng==
X-Proofpoint-GUID: H1D9x0CkZ4YArCfelD6ABnwIpVAzfmTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190030

On Tue, Nov 03, 2026 at 10:06:08AM +0000, Tsao, Bruce wrote:=0A=
> David -- since you have the background here: ad5758 currently carries=0A=
> CRC as a TODO and disables it at probe, whereas the AD5413 implements=0A=
> per-frame CRC. For the merged driver, would you prefer (a) keeping the=0A=
> AD5758 CRC-off via the flag (no behaviour change), or (b) also=0A=
> enabling CRC on the AD5758 to finish that TODO?=0A=
>=0A=
> I'll get started on the no-functional-change refactor in the meantime.=0A=
=0A=
Hi Jonathan, David, Nuno,=0A=
=0A=
A short status update on the v2 rework, plus a gentle ping on the open=0A=
questions.=0A=
=0A=
Status:=0A=
=0A=
- ad5758 is now chip_info based: the per-device constants (name,=0A=
  resolution, full scale and the DC-DC/CRC/reset traits) sit in a=0A=
  chip_info selected via the OF/SPI match data. No functional change=0A=
  for the AD5758; I checked this by comparing the generated object code=0A=
  before and after.=0A=
=0A=
- The AD5413 is added on top as a second chip_info: compatible and SPI=0A=
  ID, 14-bit data alignment, an optional reset controller (falling back=0A=
  to the existing soft reset) and the avdd/dvdd/avss supplies. These=0A=
  are all per variant, so the AD5758 behaves as before.=0A=
=0A=
The main open points are the CRC framing and the output mode, which=0A=
is where I would like your input.=0A=
=0A=
David, I would appreciate your view on the CRC question quoted above.=0A=
=0A=
One more point, for David and Nuno: register access still goes=0A=
through ad5758's own SPI helpers, which is also where the AD5413 CRC=0A=
would go. Should this series move it to regmap, e.g. with a custom=0A=
regmap_bus as in ltc2688, or keep the existing helpers?=0A=
=0A=
Jonathan, on the output mode (your adi,ch-func pointer on the v1=0A=
binding): in the ad5758 binding, adi,dc-dc-mode selects voltage or=0A=
current output and with it which of adi,range-microvolt/-microamp=0A=
applies. The AD5413 has no DC-DC converter and only one range per mode=0A=
(+/-10.5 V or 0-24 mA), so only the mode needs describing. Two options=0A=
for the merged binding:=0A=
=0A=
  1) Reuse adi,range-microvolt / adi,range-microamp: an AD5413 node=0A=
     carries exactly one of them, and that selects the mode. No new=0A=
     property.=0A=
=0A=
  2) A top-level adi,ch-func (1 =3D voltage output, 2 =3D current output),=
=0A=
     as adi,ad74115.yaml does for its single channel, with the same=0A=
     values ad5710r and max22007 use per channel.=0A=
=0A=
Which would you prefer? Or, if you think now is the time for the=0A=
generic DAC binding you mentioned, I am happy to go that way instead.=0A=
=0A=
Jonathan, could you also confirm that you are fine with adding the=0A=
AD5413 to the ad5758 driver and binding, rather than as a new driver?=0A=
=0A=
Thanks,=0A=
Bruce=
