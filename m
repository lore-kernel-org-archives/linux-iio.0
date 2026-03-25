Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4420223DE7;
	Wed, 25 Mar 2026 01:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774400889; cv=fail; b=WppzKPSLMQ4qKDzDz1Tb5Tes9vZkn3AV9YK01HnJTsb/++GduMyQKMzst89+sSMaE5PoRqrvXt9eIDzJ/S2Zr0CG93fKyUYqvTefLWhMXIzaCoES+F91iqfoBJO8Oni4KdGOtODyAnS2of2ZYO5uL/MwYZJv5+IZptb9wWUWNcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774400889; c=relaxed/simple;
	bh=kcwI0EM+sqZ8WzZWbo06rKwXfpVX+fSP5s9f9XRRSq4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VfJz4CrOT/l3N60+j6saRB9WJxY/c/BLxF/EYRcXMeMi6BURHrLajukgfdlDOujU72VmkgHyCbeOgkuv6bODkHPZOXbHTJanBkfIe54meDqPT1+SJZNrNUu1lgKBzY4vdl9UqQJAKcXQnJbZu5jiZg66EE7sf6DYxM4Yn2CPu9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Hg6MDkOE; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Hg6MDkOE"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P0oH2k278923;
	Tue, 24 Mar 2026 21:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uk7fj
	EqxwDsQ6W+YWgpekDYqaVGVxLj4X+1rWuLyd7Q=; b=Hg6MDkOE2GUNEM7ccuK5t
	3FHr//W+ixhbxl+Sah+vUDPJFUnYsGH/cPqLT1wEIvtgEGi2GTnzQ5NRDJOFAoyi
	s/oU+6H+WPbv/bIFQl26BurAdVIgjt6htN504UewWk0DMp7yuomF5bJqoaKEwiDT
	DhRaGb0c2YZ8hgnaBn434M4FEJfAbZXfNamNgoYpH38+YvtB5l7/H8Kjs6lqwqOK
	Ro+YAP4XPvYzoAdkw8snTcZ9fU1ZcI9RGOPJGZ0d0kN7zTlefECkyYbFHTTPS/rI
	gqmKHFP8QgYkhI71LOWxNJ4/imsNNml6xgbZPjot+3o6aw5n+SlKyOvhZFYVK2Q3
	g==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d45gyr26d-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 21:07:48 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQzEXeqQ4JXH1iCvxSXAMiRFbNFo5gZuBVTc0AFPqCJ6OPElzyMKHE1nXHj0B/BAJavlfcc/eusfI8eeObNcYQDNO8dBUJb0oZH9+VXDYmoKoZ3RrM9QZx9uGwLI32xN33FFy+nGTJ1gaRJdU0A1a/MKuM9iEIXwsrM2uyYqZkrCMPwr1oS4Z6WElU7eyLQ/scYFIWwwzsW6a6xzLBUFGy6v3jgaLa2zx/1b1kwKhHgfEg+b5UzSPa3w8vYIsMX2KFWTKK17nLi18dRchPk1Hw9gI01GXA2H9FX/rs1Lqd7A7VeQW5JWsx02hs0rHVvBtE35WNNQ4iklTA8YPQj0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uk7fjEqxwDsQ6W+YWgpekDYqaVGVxLj4X+1rWuLyd7Q=;
 b=ZyvkgpvQlOLAppHTYdIbkNxD80ytCC2ms8o2E1xpkEMELI9UcIfY5o/X4KjZqelYoIl6xUy/zwoPppkcgKT3L2zRu2yL3B78IVlh9M6miRLa+QLPKLXSTXfkZlKaKP+kYxdkvXEmJu2U74ewlyQGkGEPv0NtpPrafTmSVyLRhGrFvbiK2a+07bg1kPp159hqovAYMy/PwzVzmUgPcluuP9P5kt/iO0/ZhdLA8wCy9oARvc/SWTHN7buik26lWm7zPSWl/1ILyHFd0XqM44qmm3dztgc8QROtTYnVLbXleqMOQm6uxXSyxxbvMHkoUGx87ckLELzmdSM3iOPXDVg6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by SA1PR03MB8032.namprd03.prod.outlook.com (2603:10b6:806:45a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Wed, 25 Mar
 2026 01:07:23 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 01:07:44 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Topic: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Index: AQHctpdTMBKgFPb38UaDAUFZqVbS1rWz8fcAgAE3iOCAAEdXgIAI/mOw
Date: Wed, 25 Mar 2026 01:07:44 +0000
Message-ID:
 <PH0PR03MB63519301C13837DBD94535E2F149A@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
 <20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
 <abpfdELI33a0Ncl3@ashevche-desk.local>
 <PH0PR03MB6351A1A32896F5CFF05A4C10F14FA@PH0PR03MB6351.namprd03.prod.outlook.com>
 <abugoaMtEV75Fyk8@ashevche-desk.local>
In-Reply-To: <abugoaMtEV75Fyk8@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|SA1PR03MB8032:EE_
x-ms-office365-filtering-correlation-id: a1fe7ec8-ca03-41da-ce98-08de8a0aec0e
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 GABkV2hObYWmY3P/5M/zMNhrHeJYLHrzB/EE7TsAk4Cuqv7SlLM/goECEVXNsaqMUIA47bE55co1NbxUIYGbrPfzjMWN3NPycAM/0Ink+vLJf51/Zv9rPUBnnl61bD4J4kLooefGrlDPivX5qFOq3/esHWDPxTrsG5S85SIBus62B/Nk9rYPGFtP48zMkgINomxcBNY7FhEhk6DtVRRKcYcSpv45c8VO2T1zkkSM/UFVsQj3PtkDsdbCH+6BCDjI1bda8kPnOGjQ5PRDSZMI0J2zHiyPflx2KFPBDB8x2SUNLAnpnuvM/zb9Tvfss71gl1pSHwKSWB5D42C9Fold/R0vqsp8HUFLFSmEXTCFYiCRMoZe9a02r11ZX7YLG5atAesS1IPk4zglp0a9F6Dav64SrBqULc1ulXyeu6y+eqL0TNbQsrUK1hTFz4sRgEnpKyF6pfQeM+TDOoB8TYfjbXkc7r9g3oq//WUhLB+ABiZA6bj1BqBz/dAtI92XBSbD0Wtx79XCiO+ddj8y5cRZtWmLDyn62ENk1J87tF7tYv030q0z7Ior1S4mTg3D5jmM2GjWXQ7Q524txI2e1/KtMA0Eii2lid9TadFx4L7RfZb+3+L/CqZIEFcI9y53XglUk8boT5oRm3qjt5fn7NjU3J7MS5r3z/NMV31jS1Iksd58ShBmapHcSFbS5xPLWGPyXPK/EBKzSCx4jnngtnh0vEdpqu1o2hLNehVxBT6PmW1IWE7Z0ik0nXhhjuS7bMcH9muEcHz14Nfz/fa/HMZHTYLJZkZDrsFovPSXa92B9m8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zM6rxtvTLcndjgkMafrxvPEFzqPaV6wOM2qPBVT3C4RDcxgU+L8SlKp1I5v0?=
 =?us-ascii?Q?A6WWzoiRxImVQKxXtrtWq41CsBxCJNX5WCo6ZeWx5e2MTbTF/zgdQVlk1oIm?=
 =?us-ascii?Q?25nnRmazvU5S54MtL/qT3yuY1s7R18YAD1QYg2Fi1dNCe3F15NquB2pfijIn?=
 =?us-ascii?Q?0ZoO6f1hsi0lAIeYeg6AJgN6PlKmMTWVmm78S/1jDq2poyjeuBbVAX3dT2Nt?=
 =?us-ascii?Q?ARbxB/eEjIpeAgmGMfwYODuaVhYo/fd092V6xJ0pEOSR2GveCy3xpL9gMxL3?=
 =?us-ascii?Q?O8Xj+0yocpWa+Tt2AU86sTfg3l0JeI6WBxdULUT2d1KtvF4vophq326LqnQl?=
 =?us-ascii?Q?/hEfCjR9B5HWa6IMw3Gm/ujAIykR4FE7SCs1257jrmVVR/YAq7Aj8mm0aJwr?=
 =?us-ascii?Q?2nShwrLNsQJpeykNXSSpsZnDvlHJW8or3B4FU3/0qq3X8YfjIibSbe1rErfl?=
 =?us-ascii?Q?eb/Eyw7LbE2POHzXu/HtO2GLAAtfmK0hircBta3USKg4NNCHUQFKidqzwcBe?=
 =?us-ascii?Q?Wut5MU6EjJty1MSrCBvH1HHFsA9tgZbUi8kPyW4s5wLD6aJ8lY0RyFrWT2tR?=
 =?us-ascii?Q?5JShKCFZyldFMaEezTcOWVE1a/X8Dlza9mqdyeugCNmf+qVY/bgcsVjVGykx?=
 =?us-ascii?Q?i9+qgjul3G41q+2+mi0b7l81WjWSI6Rb8WsS22RGDTWgt2inw3ffOYV4mQ/E?=
 =?us-ascii?Q?XKaEgX/kkH3eRtouWiexjb+5QiTozXqwv2m1S+/Xq/Dxb99IPcbkoxSGmOsu?=
 =?us-ascii?Q?JsOYFIyoTzx8c8YsKBxWyjKzFdrDsTky7ar3oHDCfqQnzpcY9T6mgJvfMmc1?=
 =?us-ascii?Q?vDnNOHhr94L58VqyZyn4KQmpd9i3Snrdp0FvbSUpoufAhyg/9RmDKW/0ITJB?=
 =?us-ascii?Q?ZWamQNgEJSVX/S7yMeZzwARYBlU0CCPc4hbIIDELgoqRgfQHs+Mus+G243TQ?=
 =?us-ascii?Q?ARUSVTOUQ8FaeE1aC9SRNFTTrIze1q8gnLEcBW1IDF1PYXpatHwyCRwUEwst?=
 =?us-ascii?Q?+RbrFcOLvXB5y5c+xe47P6wBnkBlzDl/Iri9vgif2mz1lOpZbijPW2Nhq+lu?=
 =?us-ascii?Q?nqjSqdF4Q6zHeMb7KC7BhJAf+SYVII4VE+ReVmiHfGhl2Pw12XBDOyu7OPhh?=
 =?us-ascii?Q?sTzB9HweWprysT8QGLVoUm6zy7AlKjW0BurhvIvE66LxWJxnq+fAnRjw1+dY?=
 =?us-ascii?Q?41Cl1+d9UeK/KUn86TkGOA6u0wJv7zTIiQMwq1Vd8TMvaxLJK5vUJoFdRdMS?=
 =?us-ascii?Q?7Yrdk6Z6Om7ivMHfyYvGmLoA0/uPBtVCtj59bQC9X75WxRnc6Zu0QO1KSrE/?=
 =?us-ascii?Q?fM0mf0VehzpV9zTGhm4qto3OQN18YOZMmsHcGAq/2lku0H8JEff7vQ6U0l0E?=
 =?us-ascii?Q?KxT1pTb5a9Hp9gtE+85fXKV+e9KlHU8lLUxgZWkVyrqZQt7/F9ozsfIixJg0?=
 =?us-ascii?Q?wziKpsxs1uhrlngFSdkcuEny9MRi9QX1poem3afcCDlJEY0R16JqrW7BTQro?=
 =?us-ascii?Q?XiuunfPhtl4dgml+qREBBB71GbWZdWuHH96rp7/pgMo5SPfPJZni46AKRxLJ?=
 =?us-ascii?Q?xinhh6SlZYclRL6BqjKSpRJOF1KnqpTj8OizUyjW/J6jSmsNSHkvMY7Av3U+?=
 =?us-ascii?Q?5mOrv7bKu7TduRSwhgCopyqzRksh/j01UpdGrapijA2TI7MzJjmt6IobM/5E?=
 =?us-ascii?Q?vuh57XkpVpJppFM2gsWtba0aIhztamZbe1z7eCuxzDemaK5UWvNFA735RZoZ?=
 =?us-ascii?Q?SirunZvHm1syU4i49ld9E6QAddvsjm4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	n1Q/TJa//zyID7QtS+32/1lJJhiWn7GfCIWyieQ23g2e6/JUmekyFNrp5GEYyH/xazmTawwgWLEVmeHMwLfyDWQb/6pu4yU067q37aZm6TWqatjVWp9xfCEZNEGdkfFKOnd8uhPwirJnOEchL8w7UkPVewrT95qVSQgWTzpF5h+OKdK5SCf/5oL4v8S5ynE5ATpKen6DpBmTFisssKPsVHvQFZnSmW+EXC1H3c4mPbpcUVml3o4AOIi4PMDY8T2U07Qp/SJQJrhYgVI1aJC/TW5NYvG/OyOy95972EKbKvUdCGSEwTEEbYqX4EiaL8X7sDWeNgnmo4tVuMiQRjKadg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fe7ec8-ca03-41da-ce98-08de8a0aec0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 01:07:44.7660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4DKj63VctlnhFiwh4XFhxAqGGKIlDt9yP2v3JsvSspCwLkbGycaTN2qopS+RyaMAc+xadwHnyO+MV1ABYCyVlanGbSbmNZsQiTzrMew5icY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB8032
X-Proofpoint-GUID: _Sv5xx3vyC5jbVadcitmwLoR3Cj6SxZH
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69c33564 cx=c_pps
 a=oJa8ZcSO0M6ZbQlUw3N+2w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=U0mwriObdfBV8LfVzsAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: _Sv5xx3vyC5jbVadcitmwLoR3Cj6SxZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAwNiBTYWx0ZWRfX7iRkDGqHVeWA
 tuPGz4dlvUlHYdfrjtvs1R+aNnA9Lq+ZZp10cxW0Gl4F7jNU1AlYrNITfeDRjYWFf31S2rhGkYu
 TI/3wpO6nRg/1wVFI3+DrzGh5qLfbj8+2B0ZksM5Vn2gylkCF2D78L7zJwIrlLYxZe7yqC3Bqld
 tPjHkMU6gZhdsKMfQ6aF417JKnh7TLwG6SRVa/AhJ7H9td2yctBqH4CqxeVBHuFriMSEX4l/E/D
 ivvQxBMa1eCojHDi/0zSo6tDG1KhYNVwsS6goWbc6taiYiE0BIJWiGB5dOWhsJPHHR8vfGUq4Wq
 XC6opzgkGphBe2mkHVeOP8UMsEJXWSixwX//n5kY5a9dfNfjgu/6CZnGlUr5NFaI4KQnT6NeqbF
 c06H4JlDzsueH7+cxpgmYDMkvIyBEy/Od8EPhYer2u5GLYQl5pp6276DGbv8aYmLsVFEd+aezvr
 +/P9I+8+zjct44PUjkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250006

> > > > Changes since v1:
> > > >   - Removed PWM, GPIO, clock generator, debugfs, regmap,
> > > > IIO_BUFFER
> > >
> > > Why was regmap removed?! Was it not used?
> >
> > As far as I understand it, regmap also gives access to debugfs. When I
> > removed debugfs I also added regmap as removed.
>=20
> Not only debugfs, and it's unrelated to the any custom debugfs interfaces=
 in
> the driver, it's just a feature out-of-the-box of regmap.
>=20
> > For the spi write/read I am not using regmap as the device has some
> > features that I think regmap_read/write couldn't support. Namely the
> > variable data width, as the device only accepts exact amount of clock
> > cycles. Future patches will also add variable SPI speed.
>=20
> We have a lot of flexibility in regmap core. Do you think it can be impro=
ved /
> extended to cover the cases like yours?
>=20

To neatly summarize, my needs are: (in future patches)
1. SPI read/write can have different frequencies and runtime changeable
2. SPI data bits needs to be exactly 8bits or 16bits depending on register =
width
3. DAC Device reads SPI command bits [14:12] for communication, not just ch=
ip select

For regmap to be used
1. regmap_config would need new read_speed and write_speed entries.
2. val_bits must now be changeable depending on the need.
3. I think the read/write_flag_mask can do this.

1) is relatively easy I think, but am not sure with 2) as it might break ot=
her regmap core code
that already assumes it to be fixed.
Feels like a lot of work for a niche amount of devices, I may still lean on=
 the opinion of
keeping regmap as is.

Regards,
Alexis
