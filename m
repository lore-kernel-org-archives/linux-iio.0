Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337053E6DFF;
	Fri, 26 Jun 2026 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463512; cv=fail; b=JSNe6ysDc4OWPdSuzLQfUPBO6oYtTO2KJmx2y7+U7xhcTD/HwJMOWKoiI8rnHOne5irgmQuKRzd9qP3WlozHwB1CG6fSi/V8YP9I4Yh4ZjtFPlor/23GXfH9WqjBgCWLySpWyYi/y8eIqBtVgsG8lB0nLiOWkra8dX6q8LlV5YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463512; c=relaxed/simple;
	bh=4AHMIBHrpHh7qRtHJ1U3qYHHg1wcWCDo3MSqNHUuJmE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GSr8U8S9PtP9TzprQpwOi7RzaNrKtAcrHlFjSMBWG2XdEiIeEcLH17S1B6/WOLXSEd0TCJCqnd56v5kzcuT/emwWytWgtwFccK0UiDegc9EPsLCCRqzZVCAkoeAknev2TA6dX9325yXKJL9lDOJzmKFfF9pjZD5pTlwo8GwzfiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Fn/GTRtJ; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Fn/GTRtJ"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q6UAlu718289;
	Fri, 26 Jun 2026 04:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=p9o5C
	mxv8pEGqI5CkXoClJohceMsm4a7zCCPYdLzn/o=; b=Fn/GTRtJ+dofzKJiL19Vu
	6WyeaQTFZAvmLfj4YAgBYbabpzmJiQnzKUR68BwnuDV29nXkEJ4gYHvw7gLWhPCX
	YN1Hlyxf2v4iVJejzhxcmqlBzbk0phFzJp1ob2hauhVJKjEBBXtYa0tLa0r3yTfG
	qynCGVvtQJPRM2AF0KDoSRpNtwEvbdr/tYyH1NkA5Pqwa4phYzVh+0AQpaco9Eby
	3z0hUaKP3BI+a+JNQOVhhYbPKPrUooxnnVN6lNevh9yWSMdhBUUmJq1ct8d0iYaw
	BDPilYFyooQhPA4lxSzQvJDAmNayXDNOTtxz2zDpTxUSoVmVMWAEVgKZIH70L7F0
	w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4f11rwvabk-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 04:45:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0O8sqVOcjzMU4EqDth5LhJltZGGCv6EscdLfCG3mMUuFuXDdNrbftigtH82WnvlV76Fxf9cOq/K/OQXW5czy9nwhIG7A2ksjaCzJls0iV9jxVjrPho+p8uvgRZJpUC3jK3JDCxi4x5YpeqDOPAIoPyjOWyppNRsfoFaCmNAKnJkC/hkyYJF535hdFNxM4TS/uDMrV0pO/2q6MK69hxdea7Izk45KiFG66FTJtO/NRy6OZ5hRuKAgJLYHzWh1xJMXojtcU+A4XcNJYP0tx2zzwmM8u6AgIGYrw+NuMeCRYrxDy0mgLN296+08P1hskG50Ebx+pJ6t+jsf4AXPt8ZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9o5Cmxv8pEGqI5CkXoClJohceMsm4a7zCCPYdLzn/o=;
 b=e2q8q8y4FjF+JgmTyzx4fuXTRo0dLydDm9iHSVyI+3vrvLf/eJnTVzpDV8zF5MTYN6rBHdJKRiv0eggevYDOO3c/YSyaOLk1YXEii+yn0sme3RlWglnEshq4RD60kDAT2n8DriPmv9zlP1t6u094Kt1gpPf1MH5groIp6/x0QbPoPTmoBO/T1QfjKk78QqMBA0RnOhh8Lth1mTM59lknizkHACIEn7oUJJzac8psMqiDUA9UjiAaKOlhN6hAEo5p6yHjb3KAd3qIgd+HCowoOLzpBkcqGwab6eZJzgPZvpcSxxcQM5aJU4qVDqaxKDm17Kb1/F0zqvFKpxlBVk9Eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by DM4PR03MB5983.namprd03.prod.outlook.com (2603:10b6:5:38a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Fri, 26 Jun
 2026 08:44:57 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::72cd:8b8b:cf3c:8376]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::72cd:8b8b:cf3c:8376%5]) with mapi id 15.21.0159.012; Fri, 26 Jun 2026
 08:44:57 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        linux <linux@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] iio: dac: ad3530r: Refactor setup to table-driven
 register bank approach
Thread-Topic: [PATCH v2 1/4] iio: dac: ad3530r: Refactor setup to table-driven
 register bank approach
Thread-Index: AQHc/I8ql8qLEbTDgEyXzupIitsRWrY/ZJ4AgBExDEA=
Date: Fri, 26 Jun 2026 08:44:57 +0000
Message-ID:
 <PH0PR03MB7141B6D49AA897B29C42A121F9EB2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
 <20260615-iio-ad3532r-support-v2-1-84a0af8b83fa@analog.com>
 <ai_PCrlH49Qqw-Po@ashevche-desk.local>
In-Reply-To: <ai_PCrlH49Qqw-Po@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|DM4PR03MB5983:EE_
x-ms-office365-filtering-correlation-id: bfcb9262-37f4-48e1-2d6a-08ded35f337a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|38070700021|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 BsCXRNrVre/o9AlyMlRAgBT4JU0GPy7iqFsG8Lvxs0bfJikVG8N1EW32/IJ7hdMRCEEsw9kG+LSZGRQdOiC24mTQbzch2zyTWLMW0UdM/ofYONzPvhc+BEJD/CGPiw0BH3/PI9OZKfFWiZ2mbwvZIwLQV7WWhqb3MVpMNv3sXkGKOkQ/E8W6aSLG4xmiCBzipvoh20ZmX9FumLykLJsSRLJO9R8YmkJq1OJUB4NG4gqGh7X37XUV0R/ZAxkfryCmvBZoNlzcwfLzDMnGnjmTNrN4QwmVFRiMkp9JgNyntKcQj1YEawj+Wcg+Ut2Q3Pu/1bEKRZwOWrY1cui8WkleAc2vlbVl9VdHVbrIz6UZCPi/FJTo/62vjMMew5I4r5M9TikR03UyQGzvjRV4Suh2a1WzfhyPyc2T7uBiftbdUDATCnEqEkwMcf1AQXnzH/B2kIk6DEupj+hKs7PT15Cn7OdyU8ZwyzcyX3CUAVTC9EPkydLbdR3GV6M9twWA2JHZzqoWbdKeF4tEfUAEyefo1JGbDTxeBX/F2OCWTGJGsaTs+QrFWcoye0hE5I8RR1TACFPB+5+PzeXacRzerRZlwFahYD5+62pQQ8HWyuHSP+czW0FDCLvhuT63gNh0BLfoji3xM7baVbdh27SXLgCgWiAoq7Lrhvdc+jE5dJyBGYsnFo8/o3TEORPtzQTSVnhVkudoaB/eb5ZvYyYiibUBpxtAX+hDrWAxFdhLmwRdPc4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(38070700021)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?48k5pK2auZAHM07J4etQEFg2uFJGY3IDlSzh2nGMZUm87RuOss07cgIsMIlM?=
 =?us-ascii?Q?ITrxfx+fp/dE5fqQ7JjYqjzEElbOEPiOWHFQ9chxGu2O6KtZJ48LFLKZ1/ii?=
 =?us-ascii?Q?xcZUwnG0dj6NjsBNLnLc7+Gp+05fUhmUWBcs/ymP2FyNHzBJx+Rdmiv/V57a?=
 =?us-ascii?Q?vNowiw+VuvGRQjQlC4wBh7sS2BbTcRFlA9WH4lDXiGIripdIl0yss553NE4d?=
 =?us-ascii?Q?M/L3Etth67Rx2AdftvMteRFIIIusVnSH2oZo4wGKGp/Jmfn1Nv1ww5MAVOao?=
 =?us-ascii?Q?xIX9mJq0fL7VytUhP96cl/3puVF9n05PPk1ToOWdLU5oyMnaVk+Js1czvevc?=
 =?us-ascii?Q?EhC2/8VEqbT5VH2VRfhvHm46K3F8/mZ2EhF5j6pbIX6evjNY2738cZLC3Oz6?=
 =?us-ascii?Q?ULI4C53pr6qUEmwZuUf2oHzP63Lxhkx5T+mAbe/ps1Sgej2P8DaKcpUCZfxi?=
 =?us-ascii?Q?YTLFJEJryPRxx2H0KCYxIgYnAWJu1HwY7QHCUBxH6oDI2AXRT/kHvnktToMF?=
 =?us-ascii?Q?uV4DKvaRD8OLbCMkCUjDtSwkhnt6TPbAMlQEYM0DALzzbZgfJqmp3JUtepGf?=
 =?us-ascii?Q?eVuaeWguBw3j0DBB9TD4ZQRO+tWGr5PEb032H2aLVCWLGHvVQaxkfGfkmXQV?=
 =?us-ascii?Q?YGiJx0KLSW0vxsmsh7hYTM6mL07fvwDgL+F7M72oOjIyUTcR9r9mr+ME6b3W?=
 =?us-ascii?Q?w481VbMf1hbcf8lB4maa+1EYtZ/9IUPV0FXaUh48YmfDecpfOKoEOrxLsgp7?=
 =?us-ascii?Q?lvMJ4dc8e1EfPZcX7MJ3dg5kI+8+FQMA6rT6xCGkKneKwdnldQlh+qM1g4mv?=
 =?us-ascii?Q?NfyPplSOYL5HFBz5QKCdG6P3+d5gxfu4ICfkICGXsBOA93sQzdVYFTIu8k/4?=
 =?us-ascii?Q?vBDQngReCKl9kKPJ8eEnMa3tUilb0b4ahoLu57pQzs2VtsiAAuaQNOpdEo/J?=
 =?us-ascii?Q?3Xx3R4yUWOr+iHQvs2ny3f1AOleOBDeEOzUirBj2q1uQyTtAzYMhrxpqkSkj?=
 =?us-ascii?Q?Nkt1IM4W4L0cDE6z1+t0Xa8y/znBj6Hq/GcfYajCfn/Me4u8q4w+tFwp2y+i?=
 =?us-ascii?Q?wy3TIdO3Lz96vMTxEp9dOSEAG1ydMPXhde+Q/4tulXAHU7Zo1CqxpSyx5UHw?=
 =?us-ascii?Q?KvBqlEzwmBnOQqv8R40/AmTbzQyPfKilL81E8WEdW6Z5Wr9dcOT8ZPOEknBs?=
 =?us-ascii?Q?A6QxKt/gQUDPhAuKbCIXJjg1BGtrTl+9NKL+hzaDHX0BIbWwyKVh6nVhn7+p?=
 =?us-ascii?Q?LQ3gc6sXg8vZCciKoiCCmcwMNsJFyfRrbsxRT5aAhALzHZoZO6Vo/Ma658Wh?=
 =?us-ascii?Q?ZzSApgYg3PYUoZu4g93yX3dFEFIdmQqdICy+9jFuDiKzWSE5TrcuONf32id1?=
 =?us-ascii?Q?tJ3PgeyL0EfTcqnmCVPw1TRu4qYcWjJrHD66QYEf8kCfw4G+fOUR9owwmwSk?=
 =?us-ascii?Q?lquOhN9Q7GGapvOGIFOpFVbNAeU7QGIer8liTDzyvk7K9jWrzf6Fc2MJN1mt?=
 =?us-ascii?Q?+mcp0/fj5o9E3LsJmH7XvKJsRzKpQQTwwgFVHXSGxApCyRWUfsVaIa+vusfZ?=
 =?us-ascii?Q?4WBTyFtf8/4SqAwmjBRcxet0NMFZWF07ETzC4YnGu5xOgIDnttXWWNiVdMft?=
 =?us-ascii?Q?DTw4EJFWxgBGwWjkRkYXHqGQjE36dtKQRZo6dJUeD2m+9xN1Hjj++7eShMhR?=
 =?us-ascii?Q?Z1pcB6nAvxUQrl7q4bFnwNMhCcV7736Xk+c2c7Jmc5mSFE6VGR7KrL9pX+/9?=
 =?us-ascii?Q?vcldna2jew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	tIiClBzfCiZeiCd9WkKq+Tin9xKDNBEMaSdHLgSc/+pPC6QA4i99V/yFWjNt30NR4fETqnADg0cI5sHJHT9/PpPE3QbxCkNL8j6hjNJd/eLLZ6OZI7g6NBO5Qq+B1sE2OXTVho+TfP5zKw1QRCPaV5Sg5D8BujxOReHa6LSE8bZ3ocY6nFr5I8kXCM5O2cJHOmWtZcFArWujQ44lFVhprmmPsQH95AReRx130VEPmnav5a2l2I2NiF2ai4Xcj31ThIvRNRDYrq1Sv8KaqYN0ZfLaa3ULZzWZYWgBBv8uRUZYzmIhzgabOFbe8grXK1owHtRGy5q1WFFGGr5umWxdCw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcb9262-37f4-48e1-2d6a-08ded35f337a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 08:44:57.1957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hgz3HAgHB5w/pNAeE2ngCZLOhRBpy3kCb4pnsOW+4cCoZLdF434F39xl1bry/h2eKcYM/XZdoIo74D6qySN8bziVjUJpfWeFSVv/W1qhV6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB5983
X-Proofpoint-GUID: uOGaPgDnlOoW4TCoH72MvV-MirfRvFZZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA2OSBTYWx0ZWRfX4L4H9zk/6dAI
 vaztQb6uZd4ip/x/xc26v8b5/gy4kAoppjdYXnXVInVwPR7l/AdUeF9SBO1if+X93OFvcESk8Up
 6TUeoR9Cuew3A5Y8MHcxKFc4hPa/ZXanzthcY0fp2EcLyVLWC90279yxaz1h9PWaHlYlPmI160+
 4FhNHeIsVgQyak1pze9nW1/cn8TMdF4K+FnD+0P4p9XJDi1wccODQ/SQ4d255ut8Xizhtt0xLU8
 wGK+Yv/FH7zsutTBKjaLhqJU4PL0/5L47ikt3I2PrfyJUIYO9SoIAeLiYH1HfJbHfhUQWRGh+F3
 SYgyYNIQ5Nq53eSI0Q5eDvAp7Tb1OW2gHNGdgzcFEdO1lsTqCSdKm2faw4cWG2MNHEkB7Ia/6ah
 0Z1/mqw4y5Yf2rqyr2wwnRmzs2RwJPVLrXhecnM+cx3Ap4FxG9L+uXYKomtPDmqCYfB9ajxBjiF
 qhQdkrIipPP6YkxJsuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA2OSBTYWx0ZWRfX09FAG3u07cox
 IO1qv5Gc6S+5bQDiN7XX99AAmtuGWDdWOBIayReCxMMCJO6poK4H+e8CTnACQnvRu7Bayju9mQh
 xfDxS20jSIKFmuMNYabPzs75T+SLo0mHzVlj26PoXX6LEjk3oS7x
X-Authority-Analysis: v=2.4 cv=C9HZDwP+ c=1 sm=1 tr=0 ts=6a3e3c0c cx=c_pps
 a=QABtpIB3qQ7RK8WoHHm5GQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=VRHVEP1VdgkMUKBomTUA:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: uOGaPgDnlOoW4TCoH72MvV-MirfRvFZZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260069

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Monday, June 15, 2026 6:08 PM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; David Lechner
> <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>; Andy
> Shevchenko <andy@kernel.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; linux=
-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org; linux <linux@analog.co=
m>;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH v2 1/4] iio: dac: ad3530r: Refactor setup to table-dr=
iven
> register bank approach
>=20
> [External]
>=20
> On Mon, Jun 15, 2026 at 02:20:15PM +0800, Kim Seer Paller wrote:
> > Replace direct register calls in ad3530r_setup() with per-chip
> > register address arrays and bank helpers (ad3530r_set_reg_bank_bits,
> > ad3530r_write_reg_banks). Convert sw_ldac_trig_reg from a static
> > register address to a function pointer for per-bank LDAC trigger
> > register selection. Switch spi_device_id to named initializers.
>=20
> ...
>=20
> > +static int ad3530r_set_reg_bank_bits(const struct ad3530r_state *st,
> > +				     const unsigned int *regs,
> > +				     unsigned int num_regs,
> > +				     unsigned int mask)
> > +{
> > +	int ret;
> > +
> > +	for (unsigned int i =3D 0; i < num_regs; i++) {
> > +		ret =3D regmap_update_bits(st->regmap, regs[i], mask, mask);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad3530r_write_reg_banks(const struct ad3530r_state *st,
> > +				   const unsigned int *regs,
> > +				   unsigned int num_regs,
> > +				   unsigned int val)
> > +{
> > +	int ret;
> > +
> > +	for (unsigned int i =3D 0; i < num_regs; i++) {
> > +		ret =3D regmap_write(st->regmap, regs[i], val);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> Can the above helpers use bulk operations or regmap_multi_reg_write()?

I think bulk operations don't apply for the AD3532R case, since bank 0 is a=
round 0x102x
and bank 1 around 0x302x  two register banks, not one continuous block.
For regmap_multi_reg_write(), since all the registers get the same value, w=
e would
have to build a reg_sequence, and it ends up being the same number of write=
s with
just more code. So I think the simple loop helper is better here, but happy=
 to switch if
regmap_multi_reg_write() is the preferred form.

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

