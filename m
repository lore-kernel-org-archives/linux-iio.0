Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389525B0A0;
	Fri, 22 May 2026 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459876; cv=fail; b=u5fCkadqYki2fQBOP1zAhJLRRg0WI36RLyjxqIwpWOonHOwJpmEQKNVam6ZXzJ2Z4cayyHH/3zYcDjQkbV2wqJbFRBRYPcS8yQBZgBUzWBN9igjBoP2sc8AwLw5MeuIgu7uiMKhwcUZDoscPWBfelzdqi0k+EB7yg3KFxO+EigM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459876; c=relaxed/simple;
	bh=eSYt35e5jY1xsMAytPEWTbkpNBEiRohWZGfY2ut3+Jo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cJ/aDz15L8uyf85ROveCjxYngolexiyVr0fikWPqvTGm9ScfSAc4tlk0I+x6PrEeYI63TPQBcij6c4KhkpfTGjzupHM20foTizz6iWMrvqmh2yXWj0Xj0QcaeJ2Vz67VPxhYzt77e+Rw+y4NKe1DYLv8CLKZ5jiyalPgEuWhKkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sonJgT0n; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sonJgT0n"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8K1ht2392062;
	Fri, 22 May 2026 10:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=agxDK
	V5g09ay/Tr3Obwsw+I2Cs3e58qF6yrmehLQw9M=; b=sonJgT0npxcBf+QBfOzzH
	qa4q0wYH7ZYi6ym4YflYLTwTA/pr/736LA+PoG8YWqt+YbjzRxQjsTZQuupO7d9M
	A8tZolVOBMIqqg4c1xm0AOj1PvTQUmvBHvaM5cvRk9prSXgUWbAZwv+Urv+4oh9D
	8XfXapqXtkL7M+n9ywZQR3eyZHos6CrutxcLS/4aoQAXUYMJADFErvXP9omYjjLc
	dfK+arzR8eNeu0bN7rbvfzrcsyLP4QADlSaLmSWR1nQ1BxadDBAuHgtekBsHs2Cj
	ODhW3yxD6upP3XIcH3jg7gUTLWtxfnV1HcT8yQvdwp8yHWxdTZmi+1KtfsXnJo48
	g==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4eakhss10b-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 10:24:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HINvZFDfOlkKXxOv+JmsOyjjSVpaWMGqgT0DE1/mfD4q+oWLBS+5LOSRqZs1OwiHMFZ0IctwccvxADidiLIwl5J0/hle/qHg6rIqCluNuLI21CJdgCWune2Z1XoRj3P2ZsBWl7G/gWWiqxtcFJ37Eo1WhoF41rZN+xZ8nyUB40Xo44VsetkAHOyF46vgfRsTLufngHfGQAesYXGCF36xltwYMoTagWVq1XQLM4jm9x3KKdnCNDnjEXrLtHlpJGdhFH4Snb1vSvJiZTUSq4bnYZiyCebI+KW9J31kTyLRImR82TjgUxdzbnAw0ChPSsWyxXWPbrXgPpqte1+ImWjA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agxDKV5g09ay/Tr3Obwsw+I2Cs3e58qF6yrmehLQw9M=;
 b=ZMzB5RJ7rdQ3xlpAYW1RnLLYxfoLwppDjbL1a0xqn6heVKHezbeSMzwYc24qxdQeTN+N+ZQNTP8cW3lhElFGyElgcPHAPYNUZM8t5FG10GoTKVJGr3K5sKKdFG/JfMBoRfZw2o2Gk0pBsLLPca0ZckcpD2Ye5L2gQJq20db+7rBxyjXJhbfKtGERhhdOddodneL2aMq3E3itNMUm5Ufu7ke+xlcc9TqaTdHbW7jXZB/CNw49IHl8mSmZEd6Z44i5jJR7xJ3i1tCHEmZOIermC6DKta3iek5bZcTq6t0HYeY3wby1ASchG5fJfXuttdBYt2Gi80BdDABcBqNGbtm5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8366.namprd03.prod.outlook.com (2603:10b6:408:368::16)
 by CH2PR03MB8113.namprd03.prod.outlook.com (2603:10b6:610:27e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 14:24:27 +0000
Received: from LV9PR03MB8366.namprd03.prod.outlook.com
 ([fe80::b6c5:a618:15f2:c6eb]) by LV9PR03MB8366.namprd03.prod.outlook.com
 ([fe80::b6c5:a618:15f2:c6eb%6]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 14:24:27 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
CC: David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Miclaus,
 Antoniu" <Antoniu.Miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux
	<linux@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 8/8] iio: temperature: ltc2983: Add support for ADT7604
Thread-Topic: [PATCH v3 8/8] iio: temperature: ltc2983: Add support for
 ADT7604
Thread-Index: AQHc6UFTXwfwmqez90afwCFvVn05e7YaDP0AgAAGU5A=
Date: Fri, 22 May 2026 14:24:27 +0000
Message-ID:
 <LV9PR03MB8366C36D83A00FFCC166E333F60F2@LV9PR03MB8366.namprd03.prod.outlook.com>
References: <20260521164323.770626-1-liviu.stan@analog.com>
	<20260521164323.770626-9-liviu.stan@analog.com>
 <20260522143444.4582e370@jic23-huawei>
In-Reply-To: <20260522143444.4582e370@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8366:EE_|CH2PR03MB8113:EE_
x-ms-office365-filtering-correlation-id: 649a2517-2e5c-483c-61ac-08deb80dd482
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003|38070700021|11063799006|4143699003|6133799003;
x-microsoft-antispam-message-info:
 VbJFhYrUotpoixfRqoDsZ5DzOPezGHppmzPCOIy5kZSORSN5ShhScT5qld8lcrKs9SH7d6swYRxTwtNXlqw0xLZ9x8IBuPEsnLYy0QPK68oC+uHEzzSPxLT4UzwonRM++QnUndGFXT0PvauRdLxvoViLB3k8WacW6HY3m7PWcWrkMp6wQvKYlKfBy9eh1hf/xgDhtIBDckBK5Bp/insQ2jF/OiVpV3EMAxjfiwJZMLmJ3qlAlWr0U1c75QqXDwZpcomB7bR6pBMPg81pIUV2hYZF1w06pWTviVEq6Pvphqn0ks35qoH9TOO0oUUHmJOk9HsPdorgnYr3T7nTUUpYVQUbLx7V6nsLVCUAPQfRtYl6MAw+QQbAEZUdl1aqHddtJ7V9UlK90Fm+6vfU84MQmY7b06D5ACnAkrDp3Znq+gYo0n8QZL/Hfz3+1DdjMyNHj3HN8CipNtJ4G/uTKdPPpuC7+Hv++wXCLbkM1UcoD6p2R9Ht+emyVreKBjTX1OIxeY3D/caNn7tRUklx+SdtlwdfpziNIFhJRIjYIbha9wZLJY5Q/fgJpoerTyff0jYWpNV0pnvZnd1n/R/7i8iYlkypkFOECFiKhVHzMHPKkX1rEY+2WCleJ4qkvihnbeEgGJkRn596DuN+tI8j/nuyCaOp2VLlYZa+OF/9wtrzOQfU2G4C1wPNvjRcZtTykzQ6hX6Dhrs9WEjG7nhCd6EWIbuRZSr/Q+0Bs+EMays02kC7A5Eyt4lFfjNFX2T5YmDN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003)(38070700021)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XIAADxvlnMUG5/kmtovnLHwFJXPopPHoA3e9woUSWr4WcGhHxj6Pe+f2s7Ez?=
 =?us-ascii?Q?R2i8irtz/f2lJsIhnsB7Xvu5CPKSIUBy4QBaZwa62YKyb2pEXwD5F8lrXSpn?=
 =?us-ascii?Q?Ga6FqCrVpxcLMoVvNOJjwqvSQmKdN/DQ1lqLTtIaNVy6wJzwaxtESWr/K49x?=
 =?us-ascii?Q?dR18qLF54dEOvik4J90EgOJlxkttgxSht/OxFGRHAc12EBDBMHrPaPPdcT0d?=
 =?us-ascii?Q?pbVpe28L/PzuNFBvNIexSr8q9oztSOieAgtF7cuJhuKYp5NnCSjAhgCXriFH?=
 =?us-ascii?Q?58DJ223CjWMZjUhLSnJTWIZqtBN/RzVZ0XL/F+X0QrJBHcy+qRm4qyxxfqah?=
 =?us-ascii?Q?8r7otwRyw7pVFJKF5VV5ZzPHGhGW41zvT+BLG0sJfR7UoriWp//j2LajdKQq?=
 =?us-ascii?Q?amB0PIkVv3zOsYgO3t7vG+WW1+7wTcehUqSGBZgpJp/yCn3Ek7J7aN1r6eSO?=
 =?us-ascii?Q?snVeQbGkcGtYBvdQiPPSjIBcMTErn8CHrPw2B2MO7mlTduA8TikzPbr87smJ?=
 =?us-ascii?Q?sYDJoIeKQB+g4oOz1d72TomEnc1ZNA3/P+cuOwRJHBH5pqbW4wyiSfxku3Ya?=
 =?us-ascii?Q?VzuL57DY2coMqBibzy4wKikEuAs8XTujfPIDIa+eu0ztYyZfY+WthkUd+oE/?=
 =?us-ascii?Q?YK9c3uGCryPMzRwQ04yykjfnUwMmQ0MzJwLzdnprc3sx424OamFzwUfVRQIL?=
 =?us-ascii?Q?Q1+G4wWXKL9VIgOO/WQC+wLdEBNRp+Vaz2KxN80oHOX905ZMG9bmaX+C+V8w?=
 =?us-ascii?Q?JBQWqNuqOh+B17YjszxDJsIkYcwHsBey7u/yT2dLpNS1q5V0EHo5ncOtVU6Q?=
 =?us-ascii?Q?Pf/Nbwg7lIRWlozRjaqYHnHmabsq7ZISrQXG31hbhNkRRgN0jKtcE7T5n4db?=
 =?us-ascii?Q?exTOyCPHa9pvVBZbhaBicPyiKsy/sB0Df+zo6CHi5vijMZ8askxgrdlsbjY4?=
 =?us-ascii?Q?37q5C/vxRtkthYgB77ThG70QjPrUKGVb3plHF6/Xr8/yzLpkKEV9Hi7gqfEz?=
 =?us-ascii?Q?7u4hPaEBqXlzjccZDKDkbAtK7nvgKSgUVHrk3xuiozYi/KhM/DGJrjd04KG+?=
 =?us-ascii?Q?5q3s7yUpwKTsfAKOixEvUJ8k0JnCMOQuQa3UTj7XGCUlb6w/zjcCKfM2TU19?=
 =?us-ascii?Q?CHkkI5UMW8ocozqeu0Tkk3SD0CBo+YuGuM3JejP45wlTuOg+HCvqrbrm69xb?=
 =?us-ascii?Q?jMaRiimx9ovGEmrdcubWdIwS6MVAx5pC3OLz4Lcwv0YfvsJ03QsTWD+ZX8Xh?=
 =?us-ascii?Q?ofBWW/VbNoNVIOjwIxLJOSjEUWqncaTqrkPMb7zCwAbDa4yFbcUB6ZPzxPYL?=
 =?us-ascii?Q?JK5NjjMXSiONG50Ck1Z0cnYhx91tq6OcOCO7D0L0WCl9VODMEVc520QeHtfU?=
 =?us-ascii?Q?P814GkaM2fvrbo2q0AXe9izjazQX0iYLE8ccTsDnLnWUJnrhz6lB/FH8ByDo?=
 =?us-ascii?Q?sfXSh0Gk6AB0WIqfsabCP+rqzPjH6FLT2+vHidFnYL/FxqIiQexHnWXekDRP?=
 =?us-ascii?Q?Lu0b2QEM2spc2N1CaFk/rFjni1aMfhbIX/xAnbIBzwyv2EpClKhglyXWtsFe?=
 =?us-ascii?Q?/uej2JEPhPRDMhr18oRaUdMjfDmLFP02/1MZoiAvxMvOArZEXqcPZTLQDqNU?=
 =?us-ascii?Q?pc81K8v24NfUxRla79nPTkmLCx+p2jvtIpuRJPrDH6LT8k4iZhg35V3IwyJE?=
 =?us-ascii?Q?/OnzvDvWbjslcafDDPwSgx4Q6UcrMaC9WcTRJHGeTZ+J5to5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	hp5ZDF8qUkDnjNwNGLOeY0x6arMdvQZcT4UsLSmTSwuOlH36VylXZ2fJMH2QKJFdQNIravQbaGEwK/DgaorrzlkW1+aV8oJlSOTAfmb3pADcHSH3kWBwk9ti3e4b3r14eWyVaTdt5xDaDZj7m/x5V9aRy9fe9xstxTqyybySj6RGfyAIg2J7fToEjFaWc5L1/zERrv0wUAm5r2O1brN43MaIsZLw3DrKOFkHR+KaZjSC+k8rT2l/IJbEdszGrbTFVLqLCiBg3HTH7M8xIq0sZ/tM6ywV7NNc0EoN/VECkvTrOfB6TD0rg+OYhqGu4DUCloP9/WhSwKzdaLb+dmmbsg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649a2517-2e5c-483c-61ac-08deb80dd482
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 14:24:27.2480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcU0tGtY7JS3CZpGvLOyWMB5wzgS059fmYcc/JB/Oc3qHAEMqd3tcVyy+3YCCY+YOmcqZH0vDL/LgcKoB1l5vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8113
X-Proofpoint-ORIG-GUID: 9hb3jxMhtHqh7HMqPtrHH8r0lM6gmMvi
X-Authority-Analysis: v=2.4 cv=YYKNIQRf c=1 sm=1 tr=0 ts=6a10671f cx=c_pps
 a=+6ZDvk2G9QUnVG1E9ywKdQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=JHjvK727DXFZtJDqQ7IA:9 a=CjuIK1q_8ugA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0MyBTYWx0ZWRfXxOr3XYGXZQRl
 fbdDGziTWeE3P/fwRUYfpgJ8cuHyXCmxho1GKYEzJJFcE5hhUfLj5YX+aB/HrSSz0nL/3DKH8Cz
 vyIQYQDH/F21u0u/ohScWsPWFdAot7IGdgMYS0lxvd84iNKwlcQSI2xbFlQgFWgdQXhrvbWZwp4
 vnTrZpshxz1N+V1UwknMWhxxmpu5xrAydn0CgWJJtmN+6egDclyb90Y1iMwf0TCpxvGMF98zPjU
 XQlYuI7Fduxy5N1iiQuPEwMnSOuL6CUXdOfz4ykXBSZu8Az3Cs0/F2q/QxwhNqYX3e+TI8Mddto
 tv38MsZ4f5LVUir+DzkGK3tATQLkgC8hOqsTyXRnkeA2wWVsUw3YyA2F3Rgu5i9sBf6ztoOv48D
 VphznjHwTvJbjBXVLM7I6cF0onu6z3yoFt7PZgMPBELab9gpPd6ZYGyTkwJhujfGA9iQWvl/MM5
 5hRQ3e1pU38jESENxag==
X-Proofpoint-GUID: 9hb3jxMhtHqh7HMqPtrHH8r0lM6gmMvi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220143

On Fri, 22 May 2026 14:34:44 +0100 Jonathan Cameron <jic23@kernel.org> wrot=
e:

> On Thu, 21 May 2026 19:43:01 +0300
> Liviu Stan <liviu.stan@analog.com> wrote:
>=20
...
>=20
> The sashiko comment about the completion race looks real to me.
> Can you take a look at that. Might be some odd reason why we can't
> reinit_completion() before triggering the capture but that would
> be very unusual.
>=20

I don't see any reason why we couldn't put it before the regmap_write,
it has also already been done in ltc2983_eeprom_cmd(). So, I will change
it in v4.

> Otherwise just two really small things I missed in earlier reviews.
> If everything else was ready to go I'd have tweaked these whilst
> applying but seems you'll be doing a v4 so over to you!

Understood, will change them in v4!:) Thanks!

On Fri, 22 May 2026 09:09:33 -0500 David Lechner <dlechner@baylibre.com> wr=
ote:

> On 5/22/26 8:23 AM, Liviu Stan wrote:
> > On Thu, 21 May 2026 19:18:28 +0000 sashiko-bot@kernel.org wrote:
> >=20
> >> Thank you for your contribution! Sashiko AI review found 2 potential i=
ssue(s) to consider:
...
> >> [Severity: High]
> >> This is a pre-existing issue, but can this function experience spuriou=
s
> >> read timeouts due to a race condition with the completion?
> >>
> >> Looking at the rest of this function:
> >>
> >>     ret =3D regmap_write(st->regmap, LTC2983_STATUS_REG, start_convers=
ion);
> >>     if (ret)
> >>         return ret;
> >>
> >>     reinit_completion(&st->completion);
> >>
> >> If the hardware conversion finishes very quickly after regmap_write(),
> >> could the interrupt fire and call complete() before the CPU executes
> >> reinit_completion()? This would overwrite the completion event, causin=
g the
> >> subsequent wait_for_completion_timeout() to spuriously time out.
> >>
> >> Would it be safer to call reinit_completion() before initiating the ha=
rdware
> >> action?
> >=20
> > This is theoretically valid but in practice, the conversion requires at=
 minimum
> > two 82ms cycles (167ms), so there is no realistic window for the interr=
upt to
> > race with reinit_completion(). What do you guys think?
>=20
> I would still move it before the write so that it looks correct
> and others can copy/paste the logic on other devices.

That makes sense. Thanks!

Would this be considered a fix?

Liviu
