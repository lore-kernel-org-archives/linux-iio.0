Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1DF3955F1;
	Fri,  4 Sep 2026 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513316; cv=fail; b=kj5ieAIh+diPkuADcajBVUkVo4ObcyDxcbKml4meQXWY9zeLI45fi1ID7mnSqQ9bHk3YFmsoi+4/indPVH+8xzU63GLddIqzmHjqLB8IyoYRW6MkqcELYVCAeX1nlWP3mx6da655xtUlE5qHqw24KS1c24PfTvMgBNoL4VaNVig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513316; c=relaxed/simple;
	bh=bM/C/5jGMqj/88oWspsRP1qULkGOawwQ62sTb6hWiuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MdyiZqvoN6nliFXW1iTnUiEU/8flnT5hqvDgu4lxm9z2NI18fFVsnlPHXWAgjBYR7V0LxpY7hKWoWGU4Qh/mcx1NGbYyEUVvi4Qvw6y+lOihpFRtAHMoeOI/Q0cvqCKUoHbDTjSXQN6J4RTesTiQOw6HQ8/ADbnp+YHEDDHJHMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vK2Jsw5h; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vK2Jsw5h"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6849Cv842414710;
	Fri, 4 Sep 2026 05:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=bM/C/
	5jGMqj/88oWspsRP1qULkGOawwQ62sTb6hWiuc=; b=vK2Jsw5hyZMQfKr0YuxbW
	j66ohdwHWBuO38P5hnkgYcsCYfLgDRjII4ZQkxA5+Ra9E+jIRaPN/HqgZzRRhlIy
	aeCldOztAOXF0k29bkiN38MzgxbEhSr7Ke1h4HTqrC7x7s7M/G+O1ffIJFuY9uWI
	OjnOiQlJ8iwh+U2DhqrfAwYEGs24QQ3qz96tycmKVAQl3+uYxXoAXY7zqr7mavla
	oIuQbhoWY5rDr1mCEM0n4TEe3QmsYJ94OQVtsAJBF/mzPUrMoQZiEF8gXwCogL4p
	56EIE7fqMx3V94fuQop+7mDo5cfLZ3KSzdBd5AZwGNmmwAT2LgBFwiIsTr1KyGjD
	A==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gf12u5g8f-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 05:14:57 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqpARPpwAe2tXliBU0xB1PvQco3TKkxrlcQxGM/QJZfFMJaF4Y/VHRtiY7+gv79m1YA43xufM19ADit9LZ+3gucqx05izxi+EbUmVpVzFK6S4YTBJWwar2xvOLPKNYfik641wn2aX2Hx1gXUM6JCfKXi8v5MSnxrIiZaH5E7xnXUcdXMmfM2/pBcqZDMgSeNAcIapRcp/62qXl5F0lUrArLFuWwJmbLtoHiKh2w+4rc9HLo4Qimfwj83l5DIbQY8jlVEIbCvA/xKGALFX6dKgBGeBCrMlnCRDryW2AxtDy7VB3CV4JjGRkBY99kX1SLqDGCJE1XZQfAKZ+Kwu7Y7Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM/C/5jGMqj/88oWspsRP1qULkGOawwQ62sTb6hWiuc=;
 b=atAFHVmADNqSDyeya98osBhtfaZLs3tVb6FVNymQgeA2xel9bmM4auYqr7KnluVm9sv9B7r8Spi8EiI66aypCXFdIUHZUHD/85iUL6VULt/v+UMFOfqx8yjpK4AwFfQOEt/jrUuiTry6vU37rzvzfoL3v1nRzgaSw6GRTUPWQesrEFlbv+PvENRjnQetEn0ieu+9yr3URHmoCKuCbTRikYD6I0QLdzBVMkEZ4hnIKQbL5flkJrcXrwKzC0LsyCgZMFspJ1YAQ65CbW7hK4BpzNngshcRM9lzC7KDuWvnbQC17d5WwNyc6OYvEyK49fcoVBdQxxQMiUh8eJt/q4uA/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY2PR03MB649933.namprd03.prod.outlook.com
 (2603:10b6:930:116::5) by CH5PR03MB7862.namprd03.prod.outlook.com
 (2603:10b6:610:216::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 09:14:54 +0000
Received: from CY2PR03MB649933.namprd03.prod.outlook.com
 ([fe80::fec3:43b4:61ce:f576]) by CY2PR03MB649933.namprd03.prod.outlook.com
 ([fe80::fec3:43b4:61ce:f576%2]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 09:14:53 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
        "Sa, Nuno"
	<Nuno.Sa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        linux
	<linux@analog.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] iio: accel: adxl367: add support for INT2
 interrupt pin
Thread-Topic: [PATCH v4 4/4] iio: accel: adxl367: add support for INT2
 interrupt pin
Thread-Index: AQHdOSM/Iv+T0JWTsEq38sUdObXw47a57wCAgAQ6AQA=
Date: Fri, 4 Sep 2026 09:14:53 +0000
Message-ID:
 <CY2PR03MB64993393CCFED1EB17231DC6B69BB52@CY2PR03MB649933.namprd03.prod.outlook.com>
References: <20260831083122.3486-1-antoniu.miclaus@analog.com>
 <20260831083122.3486-5-antoniu.miclaus@analog.com>
 <178828084760.2788519.15283878760227392025.b4-review@b4>
In-Reply-To: <178828084760.2788519.15283878760227392025.b4-review@b4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY2PR03MB649933:EE_|CH5PR03MB7862:EE_
x-ms-office365-filtering-correlation-id: 8122c035-dad8-4738-6677-08df0a64fb49
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|3023799007|22082099003|18002099003|56012099006|4143699003|38070700021|10067099003|11063799006;
x-microsoft-antispam-message-info:
 EmdO7hS7auL6nV2mizlFgU1x1CC+a5kULipw8YhgJ8T3GKzeoK9YLG8MJKU+RldzFEMBd1tMRzY9XFYPIS1Nz9lRTOEA4IyRd9Zvps8sbjryt6y6D8drvRUInFiJ00tCl2hH76fQajAkrl+xszNEjkn6Jy/yCRAcQ2Mjn7MB0AurZtzhjEKDhff6znLX4eCi1Or5mNgpVkfLeH2yQqRJuJMSaH0vomaqK+vS4jToTGVNXtenLVv23pPH8q4v5l+I9FA3gm9ZcLPwAU4/s2X43JaY0bKZvlGGv+TR4k608Q0WNU0R0PnVVGe6UwiEHpQIfPO8mEwM//J8KSJJtXjYEmWFtHrM6RChl/6rc+wEyFKfmpKh2ozBMDh3BZBf6pFjC8WZSz+EZtizbBi5v+BO88T0Jugh6MX6QJc8rVWfDvjhlNV2i35fcGHyiNX4zjGbZHa96kCrreVYn8Esh46+6KHccFFHSVOAMWu3wmSnD/6mAZxvxX7ktBwOX7ISRT3uEQdHrYq/sb4PZJUC1jYlzl4nkuS02a3NIvhLYFlV0jtRcpCjnDAANsFF94tjdvf+U020piEy1adPvnvYtSG8gkg/WrhLEX76CNkQBQ5h7T9SXBmT0O9O7LAFlY+Ia7pIeQ8NR0qd4YLqPzME3mLgHEqftmMmReHcLbV75ayd4/AhsWzgomDV+kALe7zBUONuVs6H7LDWFUP2vDTaRr8XnVAOEAt/N25U6OJP7nN/o7o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY2PR03MB649933.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(3023799007)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021)(10067099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmhEWUkvbU1pOGViSUttcW53Yi8wdzZjc0lzbVpqUE9NUURuY0JvNlJ4Nkxo?=
 =?utf-8?B?MXZ4R0RudjVST3p1WGxlRUI5YXg2QnBPRVhucVkyR21tK3RQb09JbTRTazg0?=
 =?utf-8?B?SGlvTU92cWxoOGZiWG1EZlBBR3N3eTZEZEMrRXA3YnN3T2toUEN5bFJMU0VO?=
 =?utf-8?B?U3BUNVZBTE4vTmtaWW9EbHBnZk1tODhjaDgxU01OTEF1eC9EQ25FZEFNUVFL?=
 =?utf-8?B?WlBTNXBwb3hRZFVPbWk0dXRjaEEyYmh5Mk1RbmdQQURSNlpUUVlZa21McGZo?=
 =?utf-8?B?Y01iNFd6U1I0UUZhWGtzNFFDVjlPR2R5VnhzNXMvb0Q3ZVVhV1F5R2lVOHJM?=
 =?utf-8?B?WjQ1Nms3UEk0N0RsdzVHMUxjaG13Ry9NeGRTZUEvSTkybWJnKzVNWHpxbnd3?=
 =?utf-8?B?TGZaVHhhVk5FT2UycVpVWmhKZ0JYNWpCNXo0UVNMaE0rZVI4WnovMWdPSTBi?=
 =?utf-8?B?ckh6MFk2cG1xUkNEc3NKMWRkaURYa1BBaFQrNU1iMWR2VWNLQzdFTER3blR4?=
 =?utf-8?B?RlRYMzhUM28xVjB1NzBITmZUbEJ3d2ZSdWRBR0JNZ1VQaG16OXJsdk1DK1dH?=
 =?utf-8?B?a0huYkdXZjRiWUFhbU8zTUxzbU9kdWwrd0FtSEQ3RG9TNE43aXBRUHZhdkh6?=
 =?utf-8?B?a1ViaXlTNHV6TUQ1TncycnQ0MFhGYzhSQWVYREJNc0RCeE5naWFZSlJwbkVz?=
 =?utf-8?B?ejU2QmZ2OS9mMFNoa3hURSsxM1Rqb1FVV0p3Q05QbjdneGNSV2dhZjd1L2I4?=
 =?utf-8?B?TmZvNm9MSUpFOW4xZ1ZZTUJKRjhtQzdSa0phcGlYY0FUL2R3TmlzRWd0eitU?=
 =?utf-8?B?MThxTE8zdEgrdjZ4bDEwaWxUR2txaGVSdkxFV2Y3R21scUtiazNHTU1PQ0RG?=
 =?utf-8?B?aDJ0L3N2Rm5uRC9QMWNRRmNzNE13bzRldmp2NWNXQ29XZUVySHhPTjc2VGZJ?=
 =?utf-8?B?bUEwUUV6T3kranRCQWpFRTlYUE9jbE1nME13dEYwd0xpei92NVltNURFWHAy?=
 =?utf-8?B?ancxWmR0Tkd2WVJUK0sxTklJdTFaeUc3blJkUUdKUUpZR0RPU3ErRXJoZG5B?=
 =?utf-8?B?L1lmNFltUkRzcml0cXZxaGkyYTl1ODNGS3BjaTJvTTVWNUlOVzcvT3QwSjhy?=
 =?utf-8?B?YlFKcnNZV1ZaM3c2cWtuMG0vU2NvSWMvMmFYYVpmQkw3YXNaZHl1TVgyWHpj?=
 =?utf-8?B?azdrRXFwc0xjRm1RVTN3N2ZMR0pnY0hMZERwODIwQXJJNnBEdTEybW9Kb1dC?=
 =?utf-8?B?Y3lzZ2o4K2dFQjJxYmlwZXhoZTl2Nzd3ZklJYXp2SW9hT3NpQjJvc213eEVi?=
 =?utf-8?B?LzFiU1gxN2NCUnFmSXoya3kxTVoyV1pGRzA1SWt1Y2NNTmxxQVRFMFZLTVRo?=
 =?utf-8?B?QVQ3bHRzSnlhektXamxmcjdlM2lUdEVDMUNJYUwzUWxLaHdDQmt6aWFyblU5?=
 =?utf-8?B?U3J3UFZyNHJ5UFdCejVKQnJVZVFBNHdRODJtZ1g4UTJDQlNmT1haOHVtYnB6?=
 =?utf-8?B?TXBEd284bGVMbGJYcDUxaEZXK2Y0UXVsKzlzeDB1U0pDem5HVENLNGpzSXhh?=
 =?utf-8?B?TjV3OFNSWUtYczRJOUwrQmN6b1Y5R1lNVXFFZ2FEc1FrM2d6eXBMVGk5R3hS?=
 =?utf-8?B?UTJ1ZUFRZ1lrbU5Hb2ppa3FzYWlycmpFYjA1QmNYSUZGeHhuVndSQ0V3SEdU?=
 =?utf-8?B?TklIN0VQSUdYUGo0UzQ4UWhMbHVnRE9tREMzTWdQZ1RYYm1yQ0V0SlRHLzJZ?=
 =?utf-8?B?MDlEMjNxOUsrS2dEaXllOEtDelRyVlNiZHE5d0VZNFRDbGgyTXJqMit5ODNi?=
 =?utf-8?B?V3UyTGRrcHJ4SFhJdWhRSTdITHpuZlU0M2hIeUc1UWNudUhZZnFkaVY1UCsv?=
 =?utf-8?B?bmhJaW1FbmxOYlVRMnJvSW9rWEV1MExpTDU3ZUdLbjJOd3JpelYzUXRvSk83?=
 =?utf-8?B?aElmM0Y0R3FCemtBTXcxdGhCSmp0K3h4dkFBV1BQWmhzcXgrNHdEU292aS9m?=
 =?utf-8?B?cG5tdHRhQmE3ekdyYTBZOWlEQWNvQm9aUTZkSW1RSDNNTW9pRXM5UE9BbjVG?=
 =?utf-8?B?cm81d2l1SE1ZdktkUXMxN3lLMFcyY0hsZlJmT0tHaERCR2QrWjJ0VjhpTGhh?=
 =?utf-8?B?UnQvQzlHaytCbkFjeXFONXVpQ0xhYU9paW5Ob01MUTlwdCtyaGUrazhqV0kx?=
 =?utf-8?B?WHBwcGREeG1rWm9jTkV2cVRCNTRPRkl3VXNSSlFIaDQ3MGRhMjNaQkFJNUN3?=
 =?utf-8?B?UFNreVNnbVZqYkQ5MEliWTdIV2RraHlQZVMyUzZodHpPMGg1VDdUZ1lWcTdP?=
 =?utf-8?B?TEZOM2VKa1dWK08xbnB0VmgvTXBvdXpGeDNEL2F5Z0I2bkZwSkd5Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	pfFEfQwG7i3pLhGANSvxcROKiURvrgQhv3PC3Tgz3vxkutExViGK2VZAxRdfTMK729gHY5+1ukNVjErFU027EoHy9GPPqsVlxasplloUUXAsHvfjsJIn25jtKQOY5Nj2EApiy24BOuxwEiNLATpGA1FLaifGRgbw05gE22bUmMIrNaeDRP+jd8Dvy4DLmO3uoPtsdH7Cx1cAYo3vRNJpPr6u1c77l/dzLXFNXniiO56aWFofiFE67cPgnS2KWlN9nHYY54tB4nJ+ud2phqo+Iui2Yq7CfktLLB8Gf8TUvGEyYMxamn91aUxEiG3B0zHo4UXXw1jbfUKcMl2W9Gd/EQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY2PR03MB649933.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8122c035-dad8-4738-6677-08df0a64fb49
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 09:14:53.8596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9XiaeNrBHXcCNX4/EQrKKRiZbQE2dlFX44y0d60maLSKbOwgi6x6NaY1wXS67eNXNxa4ktnMb2kkJ1o/zVlVOXGvrs/wZW3SBe1PprP82k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7862
X-Authority-Analysis: v=2.4 cv=DbAnbPtW c=1 sm=1 tr=0 ts=6a9a8c11 cx=c_pps
 a=xAoCywwWBQ/pNZbveyboNg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=EUspDBNiAAAA:8 a=i8JNFqCUCLRfjF17qq8A:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4NCBTYWx0ZWRfX//xaQcu9Z0gC
 Vq7zIayGEORmR4nbOVHv4P2wWh4E4qCwocuc28FsuYX+hBrI9e7XJCBD3sUj1RgZrbmrBGvCQ88
 8B+iBe2cd5mChYHcpGRHjxQ0Vbo0PeJj3bggDskHFeeYYLq9ohAG
X-Proofpoint-ORIG-GUID: 7569XHRUOSnu4wYFfYDGaAYLam8LcXoS
X-Proofpoint-GUID: 7569XHRUOSnu4wYFfYDGaAYLam8LcXoS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4NCBTYWx0ZWRfX7OH4p2wLu04N
 pnaTBx4IAxDy1PbqbFSxylKN2X/zph8mKdkxuez4b68evDMFjzj4TgzZ2zNAF9roHZLpv66RCib
 wDJry3YsXvQAPwwLk3BetEi9u2aCbls/QWhIhnpSW9Wnl3DhNXsaYZEK98kyOylfAVfGjA+APEz
 AgJ+b7PvFuamTTC/ZxDE+ExmoLuNGBrRBrxGsaqi3Yk9NFuaJPqzLXr7ugNDhPz3WT7p34XFE6C
 3YRlGsCCWE5BOpUM5jAjOq5ya9tCr4d+DKdBoXKftX9psgicrCxi8nw2O9XGmYWfs0g/t7ZijpA
 eqJTifh1Tvdupj9NZz4bmvg/qGROlxHQK0VFiUPzZGw6lDTpFzuzSei6hXCE+0AHnen+xC5/+rf
 GkIA3L0JiRAEBiiTuDgSVoZk6xN+VhneXGQCp0fDcSqt+KMfrmANCwofOkoRdQjDpPYv+9nL48A
 M1ELLZmWM/r2fTT3hIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040084

DQoNCi0tDQpBbnRvbml1IE1pY2zEg3XFnw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1
ZXNkYXksIFNlcHRlbWJlciAxLCAyMDI2IDc6NDEgUE0NCj4gVG86IE1pY2xhdXMsIEFudG9uaXUg
PEFudG9uaXUuTWljbGF1c0BhbmFsb2cuY29tPg0KPiBDYzogU2NobWl0dCwgTWFyY2VsbyA8TWFy
Y2Vsby5TY2htaXR0QGFuYWxvZy5jb20+OyBTYSwgTnVubw0KPiA8TnVuby5TYUBhbmFsb2cuY29t
PjsgSGVubmVyaWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsg
Sm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47DQo+IERhdmlkIExlY2huZXIgPGRs
ZWNobmVyQGJheWxpYnJlLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Ow0KPiBL
cnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkNCj4g
PGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBsaW51eCA8
bGludXhAYW5hbG9nLmNvbT47DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNC80XSBpaW86
IGFjY2VsOiBhZHhsMzY3OiBhZGQgc3VwcG9ydCBmb3IgSU5UMiBpbnRlcnJ1cHQNCj4gcGluDQo+
IA0KPiA+IFRoZSBBRFhMMzY3IHByb3ZpZGVzIHR3byBpbmRlcGVuZGVudCBpbnRlcnJ1cHQgb3V0
cHV0IHBpbnMsIElOVDEgYW5kDQo+ID4gSU5UMiwgZWFjaCB3aXRoIGl0cyBvd24gZXZlbnQgbWFw
cGluZyByZWdpc3RlciAoSU5UTUFQMV9MT1dFUiBhdCAweDJBDQo+ID4gYW5kIElOVE1BUDJfTE9X
RVIgYXQgMHgyQikgc2hhcmluZyBhbiBpZGVudGljYWwgYml0IGxheW91dC4gVW50aWwgbm93DQo+
ID4gdGhlIGRyaXZlciBoYXJkY29kZWQgSU5UMSBmb3IgYWxsIGludGVycnVwdCBtYXBwaW5ncywg
c28gYSBib2FyZCB0aGF0DQo+ID4gcm91dGVzIG9ubHkgSU5UMiB0byB0aGUgaG9zdCBjb3VsZCBu
ZXZlciByZWNlaXZlIGFjdGl2aXR5LCBpbmFjdGl2aXR5DQo+ID4gb3IgRklGTyB3YXRlcm1hcmsg
aW50ZXJydXB0cy4NCj4gPg0KPiA+IERldGVybWluZSB0aGUgY29ubmVjdGVkIHBpbiBmcm9tIHRo
ZSBpbnRlcnJ1cHQtbmFtZXMgZGV2aWNlIHRyZWUNCj4gPiBwcm9wZXJ0eSB1c2luZyBmd25vZGVf
aXJxX2dldF9ieW5hbWUoKSwgYW5kIHJvdXRlIHRoZSBpbnRlcnJ1cHQNCj4gPiBtYXBwaW5ncyB0
byB0aGUgbWF0Y2hpbmcgcmVnaXN0ZXIuIFVzZSB0aGUgaW50ZXJydXB0IG51bWJlciByZXR1cm5l
ZCBieQ0KPiA+IHRoZSBsb29rdXAgZm9yIGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEoKSBzbyB0
aGUgcmVxdWVzdGVkIGxpbmUgYWx3YXlzDQo+ID4gbWF0Y2hlcyB0aGUgcm91dGVkIElOVE1BUCBy
ZWdpc3RlciwgcmVnYXJkbGVzcyBvZiB0aGUgb3JkZXIgaW4gd2hpY2ggdGhlDQo+ID4gaW50ZXJy
dXB0cyBhcmUgbGlzdGVkLiBXaGVuIG5vIGludGVycnVwdC1uYW1lcyBhcmUgcHJlc2VudCwgZGVm
YXVsdCB0bw0KPiA+IElOVDEgYW5kIHRoZSBidXMtcHJvdmlkZWQgaW50ZXJydXB0IHRvIHByZXNl
cnZlIHRoZSBleGlzdGluZyBiZWhhdmlvdXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnRv
bml1IE1pY2xhdXMgPGFudG9uaXUubWljbGF1c0BhbmFsb2cuY29tPg0KPiA+DQo+IA0KPiBPbmUg
Zm9sbG93IG9uIHRoaW5nIHRvIGxvb2sgYXQgdmlhIHNhc2hpa28uDQo+IA0KPiBPdGhlcndpc2Us
IHRoaXMgbG9va3MgZ29vZCB0byBtZSwgYnV0IGdpdmVuIHRoZSBhY3RpdmUgZGlzY3Vzc2lvbiBv
biBwcmV2aW91cw0KPiB2ZXJzaW9uIEknbSBub3QgZ29pbmcgdG8gcGljayB0aGlzIHVwIHVudGls
IHBsZW50eSBvZiB0aW1lIGhhcyBwYXNzZWQNCj4gb3IgdGFncyBoYXZlIGJlZW4gZ2l2ZW4uDQoN
Ck9rLCBJIHdpbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIGFkZHJlc3NpbmcgYWxzbyB0aGUgc2FzaGlr
byBpc3N1ZSBpbiBhIGZvbGxvdyB1cCBwYXRjaC4NCg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9paW8vYWNjZWwvYWR4bDM2Ny5jIGIvZHJpdmVycy9paW8vYWNjZWwvYWR4bDM2Ny5jDQo+
ID4gaW5kZXggYjRlOGRjNmQ2YTVjLi45YjQ3ZTY2YzQ5ZWEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9paW8vYWNjZWwvYWR4bDM2Ny5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWNjZWwvYWR4
bDM2Ny5jDQo+IA0KPiA+IEBAIC0xNDMwLDYgKzE0MzQsMzYgQEAgc3RhdGljIGludCBhZHhsMzY3
X3NldHVwKHN0cnVjdCBhZHhsMzY3X3N0YXRlDQo+ICpzdCkNCj4gPiAgCXJldHVybiBhZHhsMzY3
X3NldF9tZWFzdXJlX2VuKHN0LCB0cnVlKTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQg
YWR4bDM2N19zZXRfaW50X21hcF9yZWcoc3RydWN0IGFkeGwzNjdfc3RhdGUgKnN0LCBpbnQgaXJx
KQ0KPiA+ICt7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBSb3V0
ZSB0aGUgbWFwcGluZ3MgdG8gd2hpY2hldmVyIG9mIElOVDEvSU5UMiBpcyBuYW1lZCBpbiB0aGUN
Cj4gPiArCSAqIGludGVycnVwdC1uYW1lcyBwcm9wZXJ0eS4gLUVJTlZBTCAocHJvcGVydHkgYWJz
ZW50KSBhbmQgLQ0KPiBFTk9EQVRBDQo+ID4gKwkgKiAobmFtZSBub3QgbGlzdGVkKSBhcmUgbm90
IGVycm9yczsgYW55dGhpbmcgZWxzZSBpcy4NCj4gPiArCSAqLw0KPiA+ICsJcmV0ID0gZndub2Rl
X2lycV9nZXRfYnluYW1lKGRldl9md25vZGUoc3QtPmRldiksICJJTlQxIik7DQo+ID4gKwlpZiAo
cmV0ID4gMCkgew0KPiA+ICsJCXN0LT5pbnRfbWFwX3JlZyA9IEFEWEwzNjdfUkVHX0lOVDFfTUFQ
Ow0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4gKwlpZiAocmV0ICE9IC1FTk9EQVRB
ICYmIHJldCAhPSAtRUlOVkFMKQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0
ID0gZndub2RlX2lycV9nZXRfYnluYW1lKGRldl9md25vZGUoc3QtPmRldiksICJJTlQyIik7DQo+
ID4gKwlpZiAocmV0ID4gMCkgew0KPiA+ICsJCXN0LT5pbnRfbWFwX3JlZyA9IEFEWEwzNjdfUkVH
X0lOVDJfTUFQOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4gKwlpZiAocmV0ICE9
IC1FTk9EQVRBICYmIHJldCAhPSAtRUlOVkFMKQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0K
PiA+ICsJLyogTm8gSU5UMS9JTlQyIG5hbWVkOiBkZWZhdWx0IHRvIElOVDEgYW5kIHRoZSBidXMg
aW50ZXJydXB0LiAqLw0KPiA+ICsJc3QtPmludF9tYXBfcmVnID0gQURYTDM2N19SRUdfSU5UMV9N
QVA7DQo+ID4gKwlyZXR1cm4gaXJxOw0KPiANCj4gSSdkIGxpa2UgdG8gZXhwbG9yZSB0aGUgaGVs
cGVyIGlkZWEgZm9yIHRoaXMsIGJ1dCBpdCBjYW4gYmUgYSBzZXBhcmF0ZQ0KPiBzZXJpZXMgd2hl
biBzb21lb25lIGhhcyB0aGUgdGltZS4NCj4gDQo+ID4gK30NCj4gPiArDQo+ID4gIGludCBhZHhs
MzY3X3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3Qgc3RydWN0IGFkeGwzNjdfb3BzICpv
cHMsDQo+ID4gIAkJICB2b2lkICpjb250ZXh0LCBzdHJ1Y3QgcmVnbWFwICpyZWdtYXAsIGludCBp
cnEpDQo+ID4gIHsNCj4gPiBAQCAtMTQ4Niw2ICsxNTIwLDExIEBAIGludCBhZHhsMzY3X3Byb2Jl
KHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QNCj4gc3RydWN0IGFkeGwzNjdfb3BzICpvcHMsDQo+
ID4gIAlpZiAocmV0KQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4NCj4gDQo+IFtTZXZlcml0eTog
TWVkaXVtXQ0KPiBTaW5jZSBmd25vZGVfaXJxX2dldF9ieW5hbWUoKSBpbnNpZGUgYWR4bDM2N19z
ZXRfaW50X21hcF9yZWcoKSBjYW4gcmV0dXJuDQo+IC1FUFJPQkVfREVGRVIgaWYgdGhlIGludGVy
cnVwdCBjb250cm9sbGVyIGlzIG5vdCB5ZXQgcmVhZHksIHdpbGwgcGxhY2luZyB0aGlzDQo+IGxv
b2t1cCBhZnRlciBhZHhsMzY3X3NldHVwKCkgY2F1c2UgcmVwZWF0ZWQgYm9vdCBkZWxheXMgYW5k
IGxlYXZlIHRoZSBkZXZpY2UNCj4gcG93ZXJlZCB1cCBvbiBkZWZlcnJhbD8NCj4gDQo+IExvb2tp
bmcgYXQgYWR4bDM2N19wcm9iZSgpLCBpdCByZXNldHMgdGhlIGhhcmR3YXJlLCBzbGVlcHMgZm9y
IDE1bXMsIGFuZCBjYWxscw0KPiBhZHhsMzY3X3NldHVwKCkgd2hpY2ggcG93ZXJzIHVwIHRoZSBk
ZXZpY2UgaW50byBtZWFzdXJlbWVudCBtb2RlLg0KPiANCj4gSWYgYWR4bDM2N19zZXRfaW50X21h
cF9yZWcoKSB0aGVuIHJldHVybnMgLUVQUk9CRV9ERUZFUiwgdGhlIHByb2JlIGFib3J0cw0KPiB3
aXRob3V0IGFuIGVycm9yIGNsZWFudXAgcGF0aCB0byBwb3dlciBkb3duIHRoZSBkZXZpY2UuDQo+
IA0KPiBDb3VsZCB0aGlzIHNvZnR3YXJlIHJlc291cmNlIGFjcXVpc2l0aW9uIGJlIHBlcmZvcm1l
ZCBiZWZvcmUgdGhlIGhhcmR3YXJlDQo+IGludGVyYWN0aW9uIHRvIGF2b2lkIHVubmVjZXNzYXJ5
IGJvb3Qgc3RhbGxzIGFuZCBwb3dlciBsZWFrcyBkdXJpbmcgcHJvYmUNCj4gZGVmZXJyYWw/DQo+
IA0KPiAtDQo+IA0KPiBUaGlzIG9idmlvdXNseSBpc24ndCBuZXcsIGJ1dCBpdCBtaWdodCBtYWtl
IHNlbnNlIHRvIHR1cm4gdGhlIGRldmljZQ0KPiBvZmYgYXQgbGVhc3QuDQo+IA0KPiBDYW4gYmUg
YSBmb2xsb3cgdXAgcGF0Y2guDQo+IA0KPiAtLQ0KPiBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhh
bi5jYW1lcm9uQG9zcy5xdWFsY29tbS5jb20+DQo=
