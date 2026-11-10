Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794322635;
	b=yyN7SHNCchNIThvotJNRBUdV7cFb48/XuYe9I+jea+Rf+6qe+R9HQjXoIEQIfB9oH5Se
	 5eHslUS+TevYevoVNZAa00dMGyvnp0IjcF568K32uOw5kiQ3EWGfqFd6DfmIM8lJuqIxe
	 JJTfNZVuh9P0TFiPP8ZWYI9556/B9TPx/Z9ubiCBS0Ucc+x6XzEMhUXTfjie0jFaWDTLl
	 1ZkodWpnZQOjiDB+5bElevy7kUA51TZySiUMmEf6NCJO4rJIGZTjP3c1AClShkjp0Qjpp
	 aELE8L0nRkg3+RmL+owSfOb9DfsW+bg3FgSx9maB0FqitRxUwiz0hjs0yEY0tLNZtJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322635;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:msip_labels:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bcOpLt9f2DKMZRA9+JiJmUnZ8OLy8VAQVpMUCemfQwI=;
	b=b/jmxuQiIEBtvt2sBHnqrj2Ybr0WjdYLStZFB5ZSoZI0bSAOw5155xIsIUPAEJA1yXNe
	 plIPyiixN3wbkMxEy/x8uAHTqe6L2v4JvKvBkWj0I/WUmzo4lzY4Rueo13izuYnRavlPc
	 AyrEDfeYjPkDb2J0S5Nv3r3qqDIydckI3aQNdHXqFy1ZK3z3vFvTqRllF1LZAe3luPt+3
	 dqyFBPv6bTrNCmtGWBj1N9Aub9IcYvHruaK8cgxqAQS476lXPUmRyGEj2oNQ7mpYdPN92
	 wSFsPsJQM2FfV79jDbnFcBWSaOiIRLYrChukwTDB8WxG5jgpRTsPgDu4k+y1Gl7Fssw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tdk.com;
	spf=pass smtp.mailfrom=tdk.com;
	dkim=pass header.d=tdk.com header.i=@tdk.com header.a=rsa-sha256 header.s=selector1 header.b=RQ1thSCn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.134
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0CE606A31C
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 14:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D0CE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tdk.com header.i=@tdk.com header.a=rsa-sha256 header.s=selector1 header.b=RQ1thSCn
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAEf8KU2882175;
	Tue, 10 Nov 2026 14:57:06 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012062.outbound.protection.outlook.com [40.107.149.62])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4hswbhjpff-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 14:57:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYU+SatKrqg7L+tM/6u8kcJHjPuAlx9rWvmtk3HyQHw4Rua9+wDH+GyKR8dddiiRxKivqKWsD9xlJeE0/stDeZNQDhLx03869X33ByGh1G2nODhuHHM1dU+zzpR8JBfG9QIvwQAuGIlqR92vjqWJ3h31i1kyavKX2C8LCiqVKS1PfnO9Qh2u13UV3u/8NGPS7uDeOkjBWj3sYi5+nxRsmySzRoqNr/kQP3Lh359NxGcQb7xAjNaXyB7xpPutmC7N6/hb66Bpw+PEPqTg6dQZ4zDWhJwxqJYgAjRF78OFyUbuCYxFw18ewyUX554C9MDyEaI0qcbBb6HQGsaln18jDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcOpLt9f2DKMZRA9+JiJmUnZ8OLy8VAQVpMUCemfQwI=;
 b=EJihPImXxIPKup8v5U5Hp3hjxTP4pCi3hkMG8DhsVaYuC0BCUByB7QHWszyO+6buiX9harRi1ng9UtcZuolcl8mHwCqgc81CdQSZKKfC7jMMzsrKGGe+byTz7GOkBloxcMStNf9ss5DlZJ5seo9JuzCka8woeK0Tc01vFt4ZB8zLXPrLD6PGDF3nfPD9TyF8NLgToqrH8X0UrDthbBe2FWteK6G06nf14Gc8OHCv2nI2tH1K9ltqn/j3dpPWYsCmMA9SY32wqvN8t9R8HOR0doV1C2VUWBdNvKYW8HgYYW/9eR0Co/NkSHAUk9kgLjY8y4rTaT51oZcYgLzJEiFhWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcOpLt9f2DKMZRA9+JiJmUnZ8OLy8VAQVpMUCemfQwI=;
 b=RQ1thSCnOhlUoyIK3yjhe6naXLry2IUod6At3hYOPkSM3foOTSUW8p/WIYyaQqY2CEqUGUpffCqyQqRbQ6BD3d9QcJ56AMI7fdl3XZn4akJI/hfJjRq7PeHOVxCkk2YMjLKwnyZYPVlC/1UxAosNcN4JZv+YByQOhvqcRnckFNX2Ah48Uazjuvt5KcWyolEFDAF3BjmIbraEoQhg/UmG0C0Xp4hnnkK3nSTkydYsJazmXy9myOIi7oUjViB+QPPZty4sraWX4cgyYty7iGzD8VavsYURYjde95IbKhq1Ksmki6JHjgFpmV/C5A3HDmYVuTB3I/h/UKuovaLlRpANEw==
Received: from FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:62::7) by
 FR7P281MB6460.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1ef::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.13; Tue, 10 Nov 2026 14:57:02 +0000
Received: from FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5b9c:5d9c:df1d:84af]) by FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5b9c:5d9c:df1d:84af%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:57:02 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Joe LeVeque <joe.l@reflexrobotics.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: iio: imu: inv_icm42600: large gyro offset with temperature sensor
 disabled (ICM-42688-P)
Thread-Topic: iio: imu: inv_icm42600: large gyro offset with temperature
 sensor disabled (ICM-42688-P)
Thread-Index: AQHdbjZvHiFX5I14+kSLz140Z0K89LcnaXaj
Date: Tue, 10 Nov 2026 14:57:02 +0000
Message-ID:
 <FR2P281MB310391F1880DC67B2FC446DBCE722@FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM>
References:
 <CAJLMkXY6wS7ErVT5YUyp=c0TJDPmGePJiDua4MPw47V83JQ0Fw@mail.gmail.com>
In-Reply-To:
 <CAJLMkXY6wS7ErVT5YUyp=c0TJDPmGePJiDua4MPw47V83JQ0Fw@mail.gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tdk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB3103:EE_|FR7P281MB6460:EE_
x-ms-office365-filtering-correlation-id: ef5b8be8-0c6d-473b-7c83-08df3f3ae12a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|23010399003|10070799003|366016|376014|22082099003|18002099003|6133799003|10067099003|38070700021|3613699012|261028144727099003|11063799006|5023799004|261102123227099003|261021121427099003|261022075727099003|261026140227099003|261021123027099003|261026121527099003|261022105027099003|56012099006|261009223027099003;
x-microsoft-antispam-message-info:
 3OFxKTr3ke9Rt7NC2uRemxkHsgFTF/1cXQib+cRhGSuYCqL4A+/fwVe6AQslC0nMrrcHjQKzqQ9YL6pIGg9npJr/UGPHBScUa0X5L/hItCJbf2bMparbeY1FuABnybgrezx+XNGW1f6fbLbFRI1SaOIdpoG6Wu/94E+dQrVDfEbWO51C41/no1fgLAZP0NDWiC9IEcETzDAAmETTOygTc6PnUf13PqbFhrmnHjLoLdnIb3UuwvFPNEyHiQ7wnWQDnYGgNtKpO5H48BTJD96K+MGYI6LfY+nciPyukH5xHM2Pq7K41fsFyPWWdsaZDbtaKxNvLujDIqG93yPHbEkDM7l0h8LZp8CIRF3mCYdc6ekgsGJaDfOR4ziUdYK5UME26LKpp5+ZxOCI+LEdwSFlodpBmmTlUbxgI2CnkeIRY+WCL382dQ8Ec5kWiDzCLGT++ze8teIN0TtOYVFnQTpXqIxSvnMO60RYnNOz6vYgj5zwwor3/yKTnFSoyW7jDUxf8bVpN7nSE+n/L27zW91wCNfA0hG+Dfui4EhSeGBhlBQPo18GKDR3dShzQhtSzCQNyoQwyoCT+YJQX/JDiuLyDO3bBPFX1lm1V4WtnFaRbxy740fWA0GnY60+mu9d/BFvTCt6OGA5/MjXWgZI/P/7t7E8UJhCXP5KaNPBNDlC5idHFwhEefLpJ3AAd6BKZ71xAI5Ph/JV5sym7NQjoTR6a2OfeUGEJuvNYv2o/OrU1QRULo1eMVUIfvUQMg2Cigrn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(10070799003)(366016)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(38070700021)(3613699012)(261028144727099003)(11063799006)(5023799004)(261102123227099003)(261021121427099003)(261022075727099003)(261026140227099003)(261021123027099003)(261026121527099003)(261022105027099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TFU9qUoieP8B+LwZ9h8IrkZYoDJ9OIwaJHXJJyPQZJPZORLp4UxcNOjOiB?=
 =?iso-8859-1?Q?Hi7R7FOIM3F64gN1FrvF+kVCqC7RLTvhgMzsjsgSynzwhT3B6Fg63tCyJh?=
 =?iso-8859-1?Q?ukKMXO8KQHVNqhs+Oj+bUI7O51c8MHG9tW0NuUENRos5sswaesxH9+lYTy?=
 =?iso-8859-1?Q?6x8ScjOvbCvyV90a58Pcu+pzx1qE/g2TOKXp/Z8o1attDN+GjPDX1P+ZYb?=
 =?iso-8859-1?Q?Gkmm/Ix39bEEoRsU7jr1uLvLLl0tHTokHaOR3w7TXoU42/G5jj2DTTwU2W?=
 =?iso-8859-1?Q?+uosv7XpXw2telV06lYFniQcWfpvSBdS1xBD9NETZHrVJOSJgriZx1qoea?=
 =?iso-8859-1?Q?cDu4w5AWxvus/uiQAju3+oS/INvXudPtXWrYOB6bFyrsXcUKmU4ps2UTwz?=
 =?iso-8859-1?Q?RVyKawAifwqYzRabmaLKQJDdacXeGDsFEBk9ENCLHwYPzPSUUvBxaZREci?=
 =?iso-8859-1?Q?lD2IHZvPMfEVNHUY9XC8hE5cvAreiO+Py+1Pv6poorL3cQ9QmRUgZPjCdv?=
 =?iso-8859-1?Q?FbSW+n+46kqIAgX+Riu20fe04wuakimIRx+DINRRps3vJImVy6ZDYmWQA8?=
 =?iso-8859-1?Q?/0zWEK5dDTOZfnY9i1wBMdAyMv10QUBFeqf5idyrSwOXZSfuYIJ7MCimq8?=
 =?iso-8859-1?Q?yD/HvAISHtaafERUoLleypgDLkjmhlr13TiAtWAf0oK/1fBFmC3mue4U9l?=
 =?iso-8859-1?Q?XQkg6Nwqv0jnb7SmOrhHf3UoZvRfTzvSC+uzmsOwGl1xBIW9DC7bXCrxuY?=
 =?iso-8859-1?Q?Yppymz0jRicVyxmBuTV+Lovw6VSvBj56bS2cTVkdOpKlDx7IMzKH1G3BR8?=
 =?iso-8859-1?Q?/oH7PKMeKipF+MDikL6V9ooL5bDVJtg3rzKS7oGjXUKnB3Rd8ku8D7p0P2?=
 =?iso-8859-1?Q?jMHi+C1unieHD7NURrv0/Aopuzw1ImfFGbkxqz14IR85xrE9kDgIaij9CI?=
 =?iso-8859-1?Q?uxgwNwINwlLPnI4pVC4B0Hpf9mI5ECx/aYivjIvCzT2EQKdUjiB1nsEe0G?=
 =?iso-8859-1?Q?AOYI4pHMQIN94Zyr6hkD53jVGAdzMH97+ogz8QKL8g0qOSqMtuXL7GMhHP?=
 =?iso-8859-1?Q?iimpdslMf9OnK+qR3SHPkKONmTMhdVZDyMsLDT9zs3CuXCJXgoTWkqgm0V?=
 =?iso-8859-1?Q?8VqnkUdw+v8yyORbddbo8ATv8WT8XxTLfNjt1Gbi6dfSwKIwc0fAezCbB9?=
 =?iso-8859-1?Q?jnd/O57xvQG1CkUVleNaOpay89e4bJkcgQDfLXS5tQk8PGUcuryssKrjTM?=
 =?iso-8859-1?Q?BcVR+EF3MmkzVZ5kg2dlcmIXt/CRA4mQ+kPWHsqn7UbH/MPsluEYxhkV+a?=
 =?iso-8859-1?Q?n2SZJfkJwzZZGti5i1b531dDo0joG2QDP7+vmfPWgTy/YrW/g976aIa8LY?=
 =?iso-8859-1?Q?/FEEu8paxyNh/UNPRBcOHgphHwMNpNwlw50lESRBnPPZnFdExT+UEt2KtT?=
 =?iso-8859-1?Q?ncpDOV4FULLBrFWGyzxMLPsVQ2l9nZ8RyRZmrszMdzKR0WwghCIKXA4g+U?=
 =?iso-8859-1?Q?sZG9FlVHGDtQ4YIPvIWOdDcvKFNl7svq07lvxmeGNigIXRTASgx+4VX3VG?=
 =?iso-8859-1?Q?JC3QwI403WD1bY30cCX9idvX6oCu9SYrXFstUTm1FxKNhCLjrEaJz5zGLH?=
 =?iso-8859-1?Q?0ZECFzYw43ni4ZcqIEk5V0AtMhC3dxJkO/n9mFyfEkCFaB5T30kYTmcXys?=
 =?iso-8859-1?Q?gHIIqRCjMlO/miekNCi2j4vICXjaKH9WRUX0pzbYALZ6zE9eJ+kUNpw7k7?=
 =?iso-8859-1?Q?F4yJ8dP04Tnd1PNE/a967DjUtrcV9emqSt4ptemGo/wrHOWeDmC+rPcz9D?=
 =?iso-8859-1?Q?JX2I4XU++R+ohmc6sgrGKvTVR7bZMxYLuyOpS9xxgNA1k1bSuT4acp9fH8?=
 =?iso-8859-1?Q?/I?=
x-ms-exchange-antispam-messagedata-1: BPQ+hgi+Ybef6Q==
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
	NLMzViHMW6JxU/xYgfAcA0BYl6TBlY4sc4aSySwDG2HWGhqwyn1AxoOSxeK5LU88x7SOPhdQdXKvTAZWe+dcknhGUYWQBgJLEKFznxqovyjH8jRAdVDp5AV6rfobS/ZO7MlhryiPPnOh9TocDyKYqUU4PQkK93sD56Vl9rmg/1huAjrh2j81bUIPcyXQc1pn9r4MeSgCVbmTHM5VVpFG5k7gNCsn/HJ0SS0yw4nOKWwpApx2wDph0tyeiO86a83aAtPaPh+whgW0T3TOt2HQ4Tly3TBKJMrr+GtnSRtM/ioVFC5sciQmpDWnoNLvDpgeOXW9u+tWZQZAyczNn5mgkQ==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5b8be8-0c6d-473b-7c83-08df3f3ae12a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 14:57:02.7615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bv3j0OyNGRQtUCY8OTTPfVzPOxLlcFSLAtY2jJP67QRQ6Ljjdc5tjbtFlPRtsMl7QZKpiYMcVAzpx0u1i2YMNm9nkbNChA+FIsCWKk79d/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR7P281MB6460
X-Proofpoint-ORIG-GUID: 6v_VFdtcDrhpzTqDLRZH69zZauxcisNw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1OSBTYWx0ZWRfX2sv7iW91l1wO
 gm9CQEFcR9uG5mXE63yWE8DIonkrMHVn4wK5RzVYKEWtCiQUqLBZ1p4seF/q4VPrqnneOn6EHk9
 UkF+1jGEWhJ3JA2RS0hvjAigFG9WorW+V1yejLvL9oBAH/nsw8OaMIObtsTK+Jym+MfxkGNZMKc
 tSPNTgcDIz8VE9IR9IFUHx/723Stgb1byJWQZJS2jRoKtagmOGaGzTK0OCQpLPpi78hJ8SZOofD
 c4txKeMBh5bP414h0SHbBXbNUR9JWR0oSbgcTcaENrq8xRm8zLDs6N8ez2tsXAjqYnO54+wH2Zq
 tfGn+6YTtbL0WhVTUcMH5tSHB8fn46ZBMALK30yZxrNVR4s6QESHg66HYO+7/kZzzAc0oN78Kzo
 /d9Xy1Mq+bDaN7UkLcN+06mWPciq5VstWiPsf+PzZfziOmeNf6NWndwGTmwr0DwxRhOKLEnDY1s
 6rFUn9ZKaFxFbcf3OKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1OSBTYWx0ZWRfX/uEWrYI8mZ/e
 9Gp5mq3sMsoOUPGf3nu5NWNUIviFjfEhESa6V6uCrNbdu6/eaKXZgiGcEiet5eA5xNLSmWMiV4i
 0ufOKpMguaiS5Ckl7kH6qNMErioHoCW1qcTx4sHIoM/gGBDC4vBD
X-Authority-Analysis: v=2.4 cv=IpyL47/g c=1 sm=1 tr=0 ts=6af330c2 cx=c_pps
 a=98V9EubDbGS02EwLOPzuig==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=zJRp6_cAMcgA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22 a=CA_R3AIv3TqSSSP9Ml8A:9
 a=wPNLvfGTeEIA:10 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-GUID: 6v_VFdtcDrhpzTqDLRZH69zZauxcisNw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100059

Hello Joe,=0A=
=0A=
it seems to be a good catch. With temperature sensor disabled, gyro values=
=0A=
are likely to not be temperature compensated internally.=0A=
=0A=
I think the best solution would be to completely delete the temperature=0A=
enable/disable feature. There is really no interest in disabling the=0A=
temperature sensor since it is really bad for the gyro values. And it=0A=
would simplify the driver that is already quite complex.=0A=
=0A=
Deleting all core temperature enable/disable and make temperature sensor=0A=
always working. And we keep enabling/disabling of temperature reporting in=
=0A=
the FIFO.=0A=
=0A=
Is that something you could work on?=0A=
=0A=
Thanks for your reporting,=0A=
JB=0A=
=0A=
>Hello Jean-Baptiste,=0A=
>=0A=
>I'm bringing up an ICM-42688-P (WHOAMI/ID 0x0007c1f2, on SPI) on a=0A=
>custom i.MX8M-Plus carrier board, and I'm seeing a gyro behavior I'd=0A=
>like to check with you before sending a patch.=0A=
>=0A=
>Setup: kernel 6.6 (NXP/CompuLab BSP) with the inv_icm42600 driver plus=0A=
>the upstream "add support of ICM-42688-P" commit backported. I've=0A=
>compared the relevant code paths with current mainline and they are=0A=
>unchanged there, so I believe mainline behaves the same way.=0A=
>=0A=
>Observation: right after boot, reading the gyro through sysfs=0A=
>(in_anglvel_*_raw, default +-2000 dps range) gives a large, very=0A=
>stable offset at rest:=0A=
>=0A=
>- Temperature sensor off (after boot):   x =3D -139, y =3D 379, z =3D -229=
=0A=
>LSB  (about 8 to 23 dps)=0A=
>- After one read of in_temp_raw:         x =3D    9, y =3D  -7, z =3D   -3=
=0A=
>LSB  (under 0.5 dps)=0A=
>=0A=
>The large offset does not decay with time or with spaced-out reads. A=0A=
>single in_temp_raw read removes it, and it stays away as long as the=0A=
>temperature sensor remains enabled. Buffered capture with the=0A=
>temperature channel enabled also gives the small values. The pattern=0A=
>is reproducible across boots and power cycles.=0A=
>=0A=
>Looking at the driver, the default configuration has .temp_en =3D false,=
=0A=
>inv_icm42600_set_pwr_mgmt0() sets PWR_MGMT0.TEMP_DIS whenever temp is=0A=
>false, and inv_icm42600_gyro_read_sensor() enables the gyro through=0A=
>inv_icm42600_set_gyro_conf(), which passes the current=0A=
>st->conf.temp_en through unchanged. So after boot (or runtime=0A=
>suspend), the gyro runs with the temperature sensor disabled, which=0A=
>matches what I see.=0A=
>=0A=
>As a fix, I'm currently keeping the temperature sensor on whenever the=0A=
>gyro or accel is on, in inv_icm42600_set_pwr_mgmt0(), just before the=0A=
>"if nothing changed" check:=0A=
>=0A=
>if (gyro !=3D INV_ICM42600_SENSOR_MODE_OFF ||=0A=
>   accel !=3D INV_ICM42600_SENSOR_MODE_OFF)=0A=
>temp =3D true;=0A=
>=0A=
>With this, the gyro reads correctly from the first read after boot.=0A=
>=0A=
>My questions:=0A=
>=0A=
>1. Is this expected behavior for the ICM-42688-P (gyro offset=0A=
>compensation depending on the temperature sensor), and does it also=0A=
>apply to the other chips supported by this driver?=0A=
>2. Would you accept a fix along these lines, or would you prefer it=0A=
>handled differently, for example only for some chips, or in the gyro=0A=
>read path instead of inv_icm42600_set_pwr_mgmt0()?=0A=
>=0A=
>If this approach is acceptable, I'm happy to send a proper patch=0A=
>against the IIO tree. I can only test on 6.6 with the backported=0A=
>driver, and I would state that in the patch.=0A=
>=0A=
>Thank you for your time.=0A=
>=0A=
>Best regards,=0A=
>Joe LeVeque=0A=
>=0A=
