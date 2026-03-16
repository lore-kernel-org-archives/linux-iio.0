Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC971FC7;
	Mon, 16 Mar 2026 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773664300; cv=fail; b=cdfRT/nMOrpmFiUZ2VgsvlENHatvX02neJyBUuaYkrGi6LqgRFPsWthPC6k0FD8Gw53qlQgqvG4U1XEzxKxk35PV6QrIYKkZDiBnzjzLArz8pAPuDsZaAYtT8+T6dpRTvC/6BFnU51RpJ/NGAYRTugWriNyyQHUcbjPBoG3Uv3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773664300; c=relaxed/simple;
	bh=oHBTRssX0w3WKTeK1vst6Ow/fC5ahhlQEyBjyDNG+zE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nzV/79+1dDVqLNi1Alm4ISxypcNcQ6KwdBruzdZij3mdGVVIOv8U9Ia4OLNb1KFcQIM9juBq/nZvhEUcYRYcMQIj9tzpNMtrSzrZoySVdt+VoZXOQYMRHBa+AOLvU3/BVPAHUPvyk5RQxW5Sa5GAYfKjVo8PdlAdgmL0L+ULTgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qOhO6Hhb; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qOhO6Hhb"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G9rl862123203;
	Mon, 16 Mar 2026 08:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mYBpD
	CO3U3hPzNlSu0ILxtuIZWs4rz82bTQ+AMRarRc=; b=qOhO6Hhb+z3D8bmgeo82o
	PYgVMZSckJ6vs98tNCZUjB/Au0vFserZd1egjUK1WViaJ6j7zi8mixyBd8NveHzd
	b1BFpCZoa1xnjJ3bzBZpwZET0Se6t+Kt7PleFMavI0mcLW7D4RGgL3Pigozr580R
	KO5VJQRGWeI5qgo3ultVGhiJPxn0gd/MvaCyGPOAC/awk0uBQ7E7isHzGHJGLS9a
	yPu2LIirXPpZO9yQxxgc9loG8KctYUcqcYFHICiwm7SoiqFpZCXq9wusM1yu+C2z
	58a3g63FJQOm4N9c5XlOsEk4XAcidg1RNvLUODi1kQKwOmkgtI62kWi3nsIN2FaL
	Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cw1h1f52q-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 08:31:16 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oB431x3vImdS3bMF/usWqN1N79T0YD+YHYHqPG5LAuLcvt1uH2z3e84PnJYFrKhUe1s8Eq6dyl16FVAwc42mc1rWvAOXXlXb/uSV3VWUFuuzhRwRLnSzZ4P5qIUaDB0c6MlVWYsCIzXQWK9CsVyxjAqejJtyTXVDY83iBp/ObjxlwxzsBwkoftNdA8ahldQ0JqfdeL4aYZHXJlEUEPMUgd8W74q1qyHaVgZMHwdfFTp8krqRK3Y6BoHpiiM45uGSbterkMCOGgs8Ddr5AEHAAgS+nmuBLAE6TNxLXjaeLuANO6hWn9rm5HqWuiwELU22LwQdi19iXD/+1g1wpbxF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYBpDCO3U3hPzNlSu0ILxtuIZWs4rz82bTQ+AMRarRc=;
 b=aUfTpeeLVb4pXrGq+3ZjhoPYvocnbrTHEJbdXhoS4sGVeCBerBJqfsivybEy4cCtwAqgyhVqflky9nwda/04/8JCM45I0tMpulSDwHMCUcqv/un5NodYO5aumme0lbtuANrx7ohLkGN3uY5o/sAx0/hUzR9Wv82ExTH6InQIIzMfiC1gc6omlKSs/ogJ6GJJR1ZkOxmQybdkG38SgSRXT3iqva17un4fFmHiFsVKEORXr5gLuny5cOyTu4rPtpxbjy9uDlwyZ37eanmeYDo+vvaDkJ0+XU5J9PdiDZsmogcxda3heJuhgepc+Kpv2KZUJIvkLTjfXaxunmR5BulnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6SPR01MB0090.namprd03.prod.outlook.com (2603:10b6:805:d::23)
 by DS0PR03MB7605.namprd03.prod.outlook.com (2603:10b6:8:1f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 12:30:47 +0000
Received: from SN6SPR01MB0090.namprd03.prod.outlook.com
 ([fe80::8b7e:c42f:998c:10ef]) by SN6SPR01MB0090.namprd03.prod.outlook.com
 ([fe80::8b7e:c42f:998c:10ef%4]) with mapi id 15.20.9654.022; Mon, 16 Mar 2026
 12:31:09 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Cameron
	<jic23@kernel.org>
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
        Olivier Moysan <olivier.moysan@foss.st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Thread-Topic: [PATCH v6 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Thread-Index: AQHcsuDicaoN1aZWTUK+A7wds+cMEbWshACAgAFqgwCAAwIhAIAAIhZQ
Date: Mon, 16 Mar 2026 12:31:09 +0000
Message-ID:
 <SN6SPR01MB00908E6EDB8F4D20D391664B9B40A@SN6SPR01MB0090.namprd03.prod.outlook.com>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
 <20260313115856.87763-5-antoniu.miclaus@analog.com>
 <abQdvXq9MtIZ0EpZ@ashevche-desk.local> <20260314120022.56265de3@jic23-huawei>
 <abfT3qbFaM6PIDKx@ashevche-desk.local>
In-Reply-To: <abfT3qbFaM6PIDKx@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6SPR01MB0090:EE_|DS0PR03MB7605:EE_
x-ms-office365-filtering-correlation-id: c8af71ab-64f4-446c-1238-08de8357e73b
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 p24kzoehZo/0p3DpG+6iTbhkwPBnoVJZ11v9nsryfV56oxWmZNGHpbGKWIDxqnfdlZaYWsDK4nuTH2cbxJuiilIGSYJ+6WDg4pOMp/8svwYDOT4stYTzHWfD77ezyNLRquUhYnLS0d5D1d0NF73sMzLOYmRG9ZGZKRHnEn909m7A/0L3P4HialIblYaDCD1feDjsWpnMY9sOQS1fd5L9lxxtEhNM7PVh70luKf+SoOtKJbOTuk2y/9xeGlV53cAdR8+TrUhiwLN0QtrOro4+hrl7nROxCTqN8yxTbRmWFnEnYy/eBk7pi0bHGVajLpKdIQCCh2KLJ4duyUk2COE5hhsacMM7Wot44sX0dVNavhoIPwx4JdJ+lOIxTyHfYAbqrtV1NxzHDY28sroa6Aas4CCxEFbo6syJGfGTRsURJcLM2DyHmNDbLHDI6xC0A9rebt5ydEPOU/XUSXEBE4MVjgRe+o8b58oNEEZaTmq2CK4kPW7oj0Npkekyc9hsmQRQT/30e8M0tcepwETPIYfQXDzn2JLJZlvz9WnmWmzkY0NoSCpduXAtOg2hpTVpW/awhpAse1f/L4yU2bHFlXqSW+MhWA2Lhx4L5ZVl6eyNbLwazgyDKlFvvfoBVaepEpc84g9jvbVWP+i0+l46N1h1vlAoU5vA+DwO3EgsX/ysAYiaHa7uF/t14GX2N/PWT/iS+4RJCN08DEOG6jtHaEqYbOYPbS1igUP5UZR3Dujzvbdu19iDZUZTelDoJbjDmG21bwjTTvfzBuZjeiUtP/keTJrMZbsz4QEjdmyjM8rpEDU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6SPR01MB0090.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?L4mgM4PkhPyz8L4kWG4dF9EWHJ3RYDbrXZexogVV7zBHXrhu7uChcDRvjp3g?=
 =?us-ascii?Q?eKSbOdYY4JqQgcjXWv4AAvouU+X/RIW4S33crlAqvhXSm8isbeROS3BnKlct?=
 =?us-ascii?Q?UP3+8sxcLHJnDMowCvdhVH73u3q0kD9SRL/xCDhqLWhkDOzqdC1j0xb0eHUn?=
 =?us-ascii?Q?YsbrbOxip5QDGUJE9B50Ol18JGsRieIyLDTcPqvZhP6hE4l1kEW3ffZCH1g5?=
 =?us-ascii?Q?0OyFAB7vPZCTW0RhgY8DhyabRvtLnh2uo9axjBlAgnyuXsKT/5MGM7QIZGgn?=
 =?us-ascii?Q?sTy8N5annWKkMnh/vu/7zoVMFvOWvbWKUrjnmStoDzMRrSVA+sAQqC7Dj2ri?=
 =?us-ascii?Q?Zkjf7T/j/Fxyn3ZIiigRpjiTzElgDYez9N20b9jHAgEpDDQusXg18NQiRcqT?=
 =?us-ascii?Q?gD+FNWlTujhaDJmWxdXMfXTSDtGaUWAiYCjuyhendGAAiJ/1R2CCZaltH4nI?=
 =?us-ascii?Q?71J4saZr0WwGn86SJXttUllgDbvJoFNWBW++0GGLgdcULGhOSIjQOHGzYT+F?=
 =?us-ascii?Q?G0uroiGU2mJoFuKE5FTJ2+aZv4SQpTuquDEH/B92BD4YV6NcuUBT14YjsyVO?=
 =?us-ascii?Q?XtDDyargVXNnf9sizN24Q5ixT9+GmjDiQyrQuVTU0tlLuygGrPBIKUPhkHHT?=
 =?us-ascii?Q?5v9cxZ1d1/11HcmJRS+0+9MqMb4xkz7+EbOMbOnaoAZPpHdwPvYJHsRjVetL?=
 =?us-ascii?Q?CjFNPEqxsUgRO02b8fj+pDsvzXNrD3eCHY9NcvFwYVmOcJMPobVQvKkOAyzx?=
 =?us-ascii?Q?D4jNWURBQPNP+GlKyEcOZt/e+cj4J3DiEn24AMEytUP7R4eVSZkNa94MuRYP?=
 =?us-ascii?Q?g2CiH76rPvey1amJHNQ/W5WVt5jcpWqXP+Ws0hNqp7G+kum5HP3+S+fhLNyt?=
 =?us-ascii?Q?/U5oSfyTI6IgvFkwoo/r425UxUO36E5rmdMSFsHNVtXnWEfe5NodR5fpV0Hx?=
 =?us-ascii?Q?DQpqHOXNQv6qJeqaGpRjkhJPcg6Lea3Mg6Faz+fCa11sCpaxgu/7aegoxHax?=
 =?us-ascii?Q?q5A60GioAUqJVQ0vbgkO0v58ta3E/IpOJwFItThOR1vYTZoROdeEcZVyR3fp?=
 =?us-ascii?Q?QXZQ0RJ0SjPNBwL3P4NyJC5mYV7vFi51mnAGeYPGbD4/IE6q6OHlsO3qYffU?=
 =?us-ascii?Q?wfrS5FRAUV0C9B534pbpaC1p6+Vo2szl9pPKgvjfDTWLBeyi2lj0y3S5k3uw?=
 =?us-ascii?Q?wZXwQrTsTngAMif4e0LsF466NUssUz5getAuTfoXFMuXbUxYbnQXtloUHRL7?=
 =?us-ascii?Q?mhfAfpRL2dhiucDiJk5ezXH2NjNINu+D+PQtGsiYYWKEVYCehWCXW93Zyfy4?=
 =?us-ascii?Q?VhVvrsC/8kOeHuAyKp0uP2qlmgNxyw/ljH5qvffFRSWweQTE68+0mQTPYT9q?=
 =?us-ascii?Q?fP1cW6tnmU5QcY7mhyrAJyrlW1tWlf++JrkJdLROp4jI87Sq4vrhNxO9ODsk?=
 =?us-ascii?Q?MZGEDlobfQNkB88wYGO39tXTCUD/G21rrYlxBDWXPfqObMTUR0pOESOGWzPv?=
 =?us-ascii?Q?nJxS0JnXuBDqSBcY/8BG+8dOYHSvzgMbT7zCqGiPW0/Qb7iMp+iu2LWYryO9?=
 =?us-ascii?Q?CJPd3CrdyGvUnLnJgraOzjCV3FZr0gLF5aC0qHbgZAVAdQVO7jFycgM3syI1?=
 =?us-ascii?Q?wjTD9IZwPgMfhk0yQ3tqGkxgmdy4I463XEfV/KyTjOJzjtn5PjEmQhlcj8qG?=
 =?us-ascii?Q?ZVPwhf9YS9ZIZxX2pDEM1lBcv1CEE7Bzj5wLPlTxfVEmfUToZrh38U+J2J5r?=
 =?us-ascii?Q?eqXG7ST1ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	RuYvR+lgbpK5SXU1GoVx3ulwkeJlOnE4whmGJ3eDZvIwaQ+V3dsBD5qJEKh0KJrcjUWX4NoxFkfguszq5ToeYjQe1gheDMM+C4j/a8BpwMibogcYArDNaWJ/Cq0JQgJmRvdPvcDr4gHNUoiowc49ZaeiNp+o1h60guUtABSVx8fQgSx1Rf58H2sGE+nuS6F+0wNrsWQ4IGbEgqHlgyMfe/cZkzXGPna5uwdQTmXdVHQVJ6f0jGP+XzvtnGfn1Rt6dwkcOb/SV+SMMqR8xZiOcIpJOZMOGKyYhMJHCp/8MS2z70X0RIAtpF7NU+FJxvhkA5HIfV4CJuD6cfdruSpiVA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6SPR01MB0090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8af71ab-64f4-446c-1238-08de8357e73b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 12:31:09.7610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QfONE64qfjfx5hABIoQ6enJBEfzCwBPpmOAFRXf0WbNoyEvN8cCTwDy6T53kbKSt5w9/uazXM2AbF7Swkez5QDvJ29sAQyVb/dVXXJogSOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7605
X-Proofpoint-ORIG-GUID: TBmS5fB0EPw-ueb1HbZHcKFokiX3kWyK
X-Authority-Analysis: v=2.4 cv=FP8WBuos c=1 sm=1 tr=0 ts=69b7f814 cx=c_pps
 a=1QNZTIC90Jmhh4/qmb3rWg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=IpJZQVW2AAAA:8 a=8b9GpE9nAAAA:8 a=lW1N-7kB4HZ5DBZ2WxwA:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: TBmS5fB0EPw-ueb1HbZHcKFokiX3kWyK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5NSBTYWx0ZWRfX27/KEJG3Diwp
 VjdzpmB7IprGLlxfGFF0pNq2Pbjdz3X1oKGsRBnAcxsUQF6wJZhqtOUTfyMSSPEEBwX2zgHQiVK
 rd3y9+dYauVPigECeiJ94jrrce5UielRQLkU4lVKlb1Iya1G20oOhMiAJohtxzMPt4ixA4/o0vu
 BHBC5A1T1Kz9PJwjQ0hVrfzHFj8uXrjBYW9Q7jASWO/eLt8Z0hTlWAT6RAP8p4wQpd7ivX1LozV
 ALNoZaIEMjDVL/oVBoBiDPv/moYqlT21KzFkwr/1BeuCyUWOPnZcWlJnJe25GSkHNdKEjKRhlwY
 ykrqzI4Cy9EJH1S1Tifzhr1HyNyjZ/KIwhwPRUUqdLD2CmHtvFfwHrIqZ+pTiCt8vMklmXEO7n1
 qWeIFwfd5/UgeQ08epvCBw9mP5byqK0pdz+f5BTcEAS9bMPvk0TH0GchjrF4njjC4Pxx1YXCZNP
 ZkI4nD5gtSYq/19oOVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160095

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Monday, March 16, 2026 11:57 AM
> To: Jonathan Cameron <jic23@kernel.org>
> Cc: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Andy Shevchenko <andy@kernel.org>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Olivier Moysan <olivier.moysan@foss.st.com>; linux=
-
> iio@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH v6 4/4] iio: adc: ad4080: add support for AD4880 dual=
-
> channel ADC
>=20
> [External]
>=20
> On Sat, Mar 14, 2026 at 12:00:22PM +0000, Jonathan Cameron wrote:
> > On Fri, 13 Mar 2026 16:22:53 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > On Fri, Mar 13, 2026 at 01:58:53PM +0200, Antoniu Miclaus wrote:
> > > > Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC
> with
> > > > integrated fully differential amplifiers (FDA).
> > > >
> > > > The AD4880 has two independent ADC channels, each with its own SPI
> > > > configuration interface. The driver uses spi_new_ancillary_device()=
 to
> > > > create an additional SPI device for the second channel, allowing bo=
th
> > > > channels to share the same SPI bus with different chip selects.
> > >
> > > I am still not sure this is the best approach we can have.
> > > In any case, I have immediate questions here about regmap usage.
> >
> > I think we have a fairly fundamental misalignment on what this is.
> >
> > To my understanding (diagram on first page of the datasheet)
> > + the functional block diagram on page 3 it's effectively two almost
> > entirely separate devices in one package (sharing of power etc) and
> > a few common wires for clocks references etc.  Pretty close to some
> > of the multi die devices we get for IMUs etc but with tighter coupling
> > that forces one driver (for the IMUs we just register separate drivers)=
.
> >
> > It 'might' use one SPI bus, or 2 or even 4 (if using separate data
> > interfaces).
> >
> > Just to speed things up let me have a go at answering the questions.
> >
> > > - Why do we need to have a separate regmap per channel?
> >
> > Propose an alternative? It's two independent interfaces, so you
> > could spin a special regmap to handle that, but it's much simpler
> > to just use standard stuff and keep them separate. Not to mention it
> > would either have to do external locking or falsely imply
> > there was any restriction on using both interfaces at once
> > (there isn't)
> >
> > > - What is special about channel 0?
> >
> > Nothing.
>=20
> Then why code does explicit access to regmap channel 0?
> We should have regmap[ch] in all cases in the code.
>=20
  There are three places that use channel 0 explicitly, none of which
  imply channel 0 is functionally special from a hardware perspective:

  1. ad4080_reg_access() - the debugfs reg_access callback has no
  channel concept, it's a single (reg, val) interface. We have to
  pick one regmap, channel 0 is the default choice. I can improve
  the comment to make this clearer.
  2. ad4080_properties_parse() - uses regmap_get_device(st->regmap[0])
  solely to obtain the struct device * for reading DT properties.
  The device tree properties live on the parent SPI node, which is
  channel 0's device. This isn't "channel 0 is special", it's just
  "DT properties belong to the primary SPI device."
  3. devm_iio_backend_request_buffer() - requests the buffer from
  st->back[0] because all channel data is interleaved into a
  single stream (there's an inline comment). Only one buffer is needed.

  All register configuration (setup, filter, decimation) already uses
  regmap[ch] throughout.

> > > - Is it okay to communicate with different channels simultaneously?
> >
> > Yes. They are entirely parallel bits of silicon. Own state machines
> > and everything.
> > The configuration registers section of the datasheet says:
> > "Each channel has it's own independent configuration memory
> > accessible through it's separate configuration SPI interface."
> >
> > >   Wouldn't be a nasty race with HW IO?
> >
> > Nope. You are talking to different devices (more or less).
>=20
> If it's a twins in the package, why do we have a special handling and not=
 just
> describing two independent devices in the DT/fw?
>=20

Because they are not fully independent - they share:
- Power supplies and voltage reference
- The CNV clock (conversion trigger)
- A single interleaved data output stream

Describing them as two independent DT nodes would mean duplicating
all the shared resources, and more importantly, the data interface
is a single interleaved stream feeding into one IIO buffer. Having
two separate IIO devices would make synchronized capture impossible
from userspace.

This is exactly the use case spi_new_ancillary_device() was designed
for - a multi-die device sharing a bus with separate chip selects for
configuration but common data/clock/power infrastructure.

> TO me is either something special about channel 0, then we have to
> synchronise
> accesses, or there is no point to have this patch at all, just make devic=
es to
> be the same under the hood and describe as independent pair.

> --
> With Best Regards,
> Andy Shevchenko
>=20

