Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7465282F2F;
	Thu,  5 Mar 2026 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703900; cv=fail; b=pr4i/pP4QAU6xjTzL27/bfXKGLnHeZK3CRbBXnx2xqYcRJk8D00QCjNGXbk4clqzju1a0buEnmtOH2rVg/buk/3sRHr1pyj3zC5utws72Yo32n6kUY4LE/J4y+YYId2G0yp2QyxRCSqHMZ0a1yhWQBYqvlCw9X6EsBwY8gE8Sys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703900; c=relaxed/simple;
	bh=djp5nDVEUw1GlVze9Jn37J9kO86+SXm0ycvNAX4Dqks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s5DgNX2bJu3JiY6lG+t+QDs8+oyXENCLED4WuCSnq95G7t7MYMlvnHlPJGyhgStBeyx4PqAfMT6uSvggMC1YLvuF64DnAWByYnx+LZ1DFkYw8Z9ZZcjgH3YZvB/q7cc2h7lF9+SXUxpf4ciNiLzdEXQNHO8rnWG2RDmhNdG4OAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VTalkc0g; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VTalkc0g"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62549Rpc2756510;
	Thu, 5 Mar 2026 04:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=djp5n
	DVEUw1GlVze9Jn37J9kO86+SXm0ycvNAX4Dqks=; b=VTalkc0gEmBSEyPvBVQv0
	C5uMChdr8IPFarI/DYJ+2KbtVi8W1Eu+58kRS9LEhaXtPFKAr8s2z3vRmWJa//OW
	kN+PDlh+0XLXSwGk4T14nkjgZhu5uZCnrN53rKz5wR7+/QNk8eUopFEI7BsV32ai
	JhW8H3IYD4QKI20C89bBHKhlPJjfSUNqMAeuDhjw+7Aa0BRynb2Ry+zuMpPycgeq
	Yf+IRAZOziv7Bml6Gi9GBVn8xgVG+L0KiyVkbK91CeV23dylILb/jr/dQZP8uuvf
	dCzd028HLU9ZCpOByKl+CFY5xo/c4Z/TxCfY7QxomvTlM7i5ZvSAh9h+VFmItijB
	w==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cppt6bqj3-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 04:44:39 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZ8VvMBWMI/CL0PgwUm1d86jH6hrXR1nbECRoS9w9UQcxEaO/8lrqotbUuTwhgMBlog4AeYz04Tn2PTzZSAuck7ZH5RmGzayXaxd59kT1AOIhd09si4B0gEJ3vm+r3NsS8JfYODHKunwIZh2x8v/eQFFVcKZtPVQOFTM7TV347Hd7ymTpTFYRbu7oEyi1N5dss6wTOXlZzgi/be3bMuI8DyGItIqFPklajd/LgfWavSRIpr0U7PaDD46IaHE0b8cGMNVrLb11YyJwBbPxb7whN8uXRz7kImQyCRQenmch4I8cOcd4Rbo/6N+Qd+sNXSd9qxZ3ZKeyWx00cOS535E6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djp5nDVEUw1GlVze9Jn37J9kO86+SXm0ycvNAX4Dqks=;
 b=np/VmzThTauBUhKUFs/uSReFeKmCn1MTHsCE7phcFUZ+ClSp3klyAb/x06j0DGhfGOGBWEAVqeYhi+r+ZeVGecX8zQpdDlvW8+XP5FO30Ka51S7ynWkeZ5Xex/D2vYr0X+qo4pqXimuQVb0zDyDM5lSdTSXRR03reHkU+ABJX/1bWSzClKI9rWnwAHnawANMc6XVKNSEB0yOr8l2sp99QzqM6wWedvVXIm7JmElTONrf5EMkI01CPQxel1rUCqCJK90is8pm5gbqUihtb8CH6sgtTpDYTVNOWQAQjWeZh0/d+9oiUMysIGFHHlqSyahku7K39DLCohYptFFP6nB5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DS7PR03MB5607.namprd03.prod.outlook.com (2603:10b6:5:2ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 09:44:35 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Thu, 5 Mar 2026
 09:44:35 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] iio: frequency: admv1013: fix NULL pointer dereference
 on str
Thread-Topic: [PATCH v4] iio: frequency: admv1013: fix NULL pointer
 dereference on str
Thread-Index: AQHcrICZtwY3kfWxdUqkUyghWHO3ibWfreYAgAABWWA=
Date: Thu, 5 Mar 2026 09:44:35 +0000
Message-ID:
 <CY4PR03MB3399F7FB4FE82A606CCC333D9B7DA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260305091448.32052-1-antoniu.miclaus@analog.com>
 <CAHp75VdHz4SSyA78VYRvHrgUxGFAC6HeMmAuoxjS1twsTNTHkw@mail.gmail.com>
In-Reply-To:
 <CAHp75VdHz4SSyA78VYRvHrgUxGFAC6HeMmAuoxjS1twsTNTHkw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DS7PR03MB5607:EE_
x-ms-office365-filtering-correlation-id: 65b447c1-b0e9-4048-33e3-08de7a9bcfa9
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 Eww9hMyojZTJcAHeqz52TpBtLRlPThQ9XtGOIziRCrFUIZO6j/pQfD8VllIUbUSHrNc9mDbM5qqH+kSXP8ztNyyOm2P8yWWzo+QFcT8l4TusibpGVI3/k/W2/JQeO/ewbdYgCLKPUWjnW9RTVz8aq3n0vkrbJ8YcnArcmBa7f/iZFM5qCEpijib/HRSgDxceLKZ/1/kFKnrjlH0NE0Lc+GSsHRP9nRWkr3tqKjp69HcDY8HgfWP4Nth4SRQ/pPdijgKfIFKtHqp7ty8vr8DmY4r+0T+XOHoKcSU0ppmrlBZ3oEyhHLj/uNlRjq13QD7xupe5bCfwdIX2hgIrP77zE4H2D6PBYlBr4teqbIprmGGw5+6pl10/CNJJ/6i+EJ9P0/ZInH1+/S4oiU1aua03UEKwVivwFJQFQ/RxGDpCJQxZK7c5OCIP3eDPM5wwb/bgsS9EUyLPrF3mZb9vSllju5twGm67Y+x1Y28fD6nG9qbqJ6rzN6E9U4PABhuY1mPqdJ9D32nAobjF+LgEeOrNIyup5oFyLM5IRFyJVGR7hnIlvyl2Kle0O+Z4OWeY3feo1ko3heBdKmuaAXek5EC7eIcBpH6Bwf2JO9ASblbtwM20iFV2MObPZIiEojuJOZ7dMg8Gqi9hV9kCHFkDHeGIe3ololF2PUBuHQugnUiW9CK5oGzXPueh5hn/ttEKVuAjuaWBCItkjY4FQ2u0kndHjW+dAhH+OVokTGMTdRtr7CKVB44xeEa3Ngm5/RWMvazQswz+7VGuwFILqY20BkHFc02DxY406AggWI6574j+ZnQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yk5nbm1OSkJGMlArTE1OdlJoNWNRYlMyUzV6c2VmRHpzZm9iUnJsT0xTc01j?=
 =?utf-8?B?TFhXN0lPUmpWVFRlKzVraHRPRzZtZVAwK0lCdGlESEFLSEhNdU5LZTB1Zmxh?=
 =?utf-8?B?NklDdHlFS2dkQzU4S3dxcWNyMVhtOEdLL1A0R0thN05xZzUrZWtHdjJ6V3M0?=
 =?utf-8?B?bkgzL0V6ejdRYUF0NElhWGFvQVk0WHVFWU1xRHVjY3I3dmNlVjEzUjdSSVpo?=
 =?utf-8?B?QTJiNHZwaW9FUzhKVVByaGpNYmxMOUNCeEFDMWt0UjA1UXVOb1ZqcFExNzB5?=
 =?utf-8?B?d1Jrd2pCRkVRNDZ1c01NRlNZa0RFc29MYXRIT2pYTHZ1UCtUWkMzWE9aTWxH?=
 =?utf-8?B?N2tqUTlaVXpNT0daQ2hleFhhZjQrWnFkb21jWjliQnB6Q1lBLzhPN3lZb3Vw?=
 =?utf-8?B?Wll6MzRJY3ZPQURIRENLTlFmMVB1ZHB2Yy9tMGtwNUg4cTM5anBtbE5ZMHF5?=
 =?utf-8?B?QWVHR281dHloTVpIV0pGaFVCT3ZWdGlRUkR4MERXRmJoaTljdGFya2k5QUFJ?=
 =?utf-8?B?Z0R3MGlTeXQ1SUNoaDA0V2xORkZIRFVYVkpGV3Mra0kzbXFLek5UYTJuZ1p1?=
 =?utf-8?B?aDZDWTJJajVwNEhIdjBhUVN0RHZ2SjFCakJUdTFDVVlLZ2VkUGpMcXExTzlU?=
 =?utf-8?B?SHVqUnNrQ0dxeXJVcC96R05JTFFmZVRoRDBKeVZEZWFURldmd2p5TjJJczhO?=
 =?utf-8?B?RUdrZ29xQ1cvVDJhOXc2ZmN6RHJ4bkw1M0dmby9hU2ZoZnZJemoySjhYTW54?=
 =?utf-8?B?SlRaUzZJV1VFc2NsK2dhY2FoeHNTN2NoS1JQM0NPSzRNME5PNmpZY2x5N0pX?=
 =?utf-8?B?SzlTSzIzY2Y3Y0oyTGFzZ0s0bE1UcEpLdXZUWDJIc3k3VlY5ZjRrOGdzeFFU?=
 =?utf-8?B?VkFLcmYxeHFDeGx1V2VHNGNzdlhKVkdPRWxmN0EyZ0IvRGI5cDVxMGFBMVZw?=
 =?utf-8?B?Y3ZaQ29GNUpxQTNvUFZJYTNEL0ZDaWQrNXRKNEVTd2ZVV21iVktqY3N6ZVZT?=
 =?utf-8?B?VExQdUppU2NBV1NTTnBhUDZPR25RZlFzbjFjR1dQR3VHTmxGSGgrS0NSVXcz?=
 =?utf-8?B?azJKNUpSSjZvUWlua2d2K0J6ZXBiT0pmTThNTnMwQ2xxSXBPN2NlZXZCRVhP?=
 =?utf-8?B?MDBKekU2dTErZWV1YkdTWng2VHEyMnlZeHRGQWxlVWc0U3EydDBON3AxRm5x?=
 =?utf-8?B?MXAxbmJZS3BueW9nallHM010WDdiRkhuZ3cya0crMXRPMThneHBoelplQUtH?=
 =?utf-8?B?czRkSzdXRFJPbkhpeUZnb21KUzd6K2w4S200cFJhNDNSa1BjdVA0VTVRd3Zl?=
 =?utf-8?B?TGVMV1gwQVJDZktFVU9HKzFzNkJvVms0enJLSWxVb2pBRVZRTk5GU0F4N3Bt?=
 =?utf-8?B?N2sveFo0cUtIWk5abG1JcFlocHk1NVBJZFpGN2ZpNVA2YVh5VEhFeVR0bzlo?=
 =?utf-8?B?QUpMOURndkJjVzlvSWowN0IxcmE5c250LzJPdDdnZnY4T0lvRWJPTzcwdnpZ?=
 =?utf-8?B?Y0NDWThJd0NTaUgxcTRsUzRRWkQ4cVl4aHc1NDgxRWZITG9nZm8zc1Z6bzRY?=
 =?utf-8?B?OUVKYWxRZE1IL0tLclozYU5LbDllN3R2RmVqQ2RBZFdpNXBpUVhxZlpkMjdr?=
 =?utf-8?B?bkNwVnRFU1E5UG9iZ2ZzWWFCckgyclRYaFNkdStucmIxcVpDbnhoYzlwcGhl?=
 =?utf-8?B?WkowVm5QdlhJWGRiZjgwWUNINmg3WmhCUWg2ZE1jd0x0NDJ3dThJWlI4eVh6?=
 =?utf-8?B?aW1wMW5TaWpqeWpOOEN2d3R3b05Yc2x2OUdpYU8wcUxYcEVWTjF4OVl6ZVI3?=
 =?utf-8?B?Z3NSdVFUN2QxMlpoYXM1THJMS3pmVVJ2Zzh6SjJDdlVPVDIvMldWZTJza1pX?=
 =?utf-8?B?bmxMWVZHbGZDbVdsUG5KNUx0b3ovY2pJQjRNY05nNVBDcFB3YjZ1eWNyQU5O?=
 =?utf-8?B?WmlJZEFRQ2ZJSjJ3RjBmOStxUDZpNEYxUHFOMEI3emZiSmNxY3pVU2Z2eFQ0?=
 =?utf-8?B?R3NIVjA4eWV4VlZUZHNBQWt2Zm85d0VlZFlsdkdtRlZNYzRpZms2STVjM25p?=
 =?utf-8?B?d0RTdDRKeGxTUEVXU1pFcG9weTl1T003WFNhRUVVa2kvekhaRzlGWGNlcktx?=
 =?utf-8?B?L0I2eGFpZ0V4RjJ4akRaUEJnbkRCZmFMaS9mdUhYK21mRXlFbHZZc1Bmak1h?=
 =?utf-8?B?V1VUWTExMGd0TW1qMURkNjZZd0ROWGxuaUYxSUJRc0ZwU0phcVBqMXR0cEsy?=
 =?utf-8?B?bkZ5TUFRMnVOM2RYbWh4a1B6RGRFektHd29PZ3g3UkcwOUYxZ1VnM0xHY0ta?=
 =?utf-8?B?NUkvaVppOGlxMGFjdWVGRDZpRHkwVmlOYnBUWFgzbm5GTWtDYUkzQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b447c1-b0e9-4048-33e3-08de7a9bcfa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 09:44:35.5294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ur5OW2D1mji/bssbA324iczR2YsExzytHLkgN/nKZOw5lEz4xow0wkknCAct926Zc0bl3IXqMwf7BMZvVTI39FPgQcQaiHwOsLVn+DSRX3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5607
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3OCBTYWx0ZWRfX49S7rNigzUop
 PwZvhDDMzA+kjL6rmAnLc+74mOCaHmW1+QUzVgIlsjcwQK1OLmQMNSwQTaSULcXvKTTTU8D3mb0
 DKqFpZt8k1awYBpgoQy8+VWgebMCdV+2RIL06qv7h4lTItfIyClnspVMEtMXeMmqiyT25jRtzit
 CiPIm6fJ8U2QD0RwqTrKjdGjsBMXUjxPIZ48xN42CWIkmwgANlDgr7OPv5XgxepU6gw+8mE/+dR
 FwK/qyF83xwVDGsFPoSjVQsn0WE5zrw8v3PaayrToClZitKLRw1pAayDf2gO6eLI6udzaNxopVQ
 qI+/8kjtrd45QOi/LRNcoVdidkZHj4CSXpDynV9SJBXWvMpl5w/llN8rsxQYMwK/jk7iZPibCsO
 Q+JeJ26JHjEZ7/F1ASZzEUWXCNRExZbq1+BpycfvUTfNAZX5Bv6iVG1+EtQQXU7bDbsgr1KQJr2
 4i8Q4tZHyNmLSenM+9A==
X-Proofpoint-GUID: GYeNJ7Vflt48DNUspwCZBQsA_OL043aZ
X-Authority-Analysis: v=2.4 cv=EKkLElZC c=1 sm=1 tr=0 ts=69a95087 cx=c_pps
 a=ynjcjXHaqbEn4NYQb+mZsg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=yDCCNP0u_GUAv9mYiBsA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: GYeNJ7Vflt48DNUspwCZBQsA_OL043aZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050078

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCA1LCAyMDI2
IDExOjM2IEFNDQo+IFRvOiBNaWNsYXVzLCBBbnRvbml1IDxBbnRvbml1Lk1pY2xhdXNAYW5hbG9n
LmNvbT4NCj4gQ2M6IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPjsgSGVubmVy
aWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsgSm9uYXRoYW4g
Q2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47DQo+IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJh
eWxpYnJlLmNvbT47IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+Ow0KPiBBbmR5IFNoZXZj
aGVua28gPGFuZHlAa2VybmVsLm9yZz47IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjRdIGlp
bzogZnJlcXVlbmN5OiBhZG12MTAxMzogZml4IE5VTEwgcG9pbnRlcg0KPiBkZXJlZmVyZW5jZSBv
biBzdHINCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFRodSwgTWFyIDUsIDIwMjYgYXQgMTE6
MTXigK9BTSBBbnRvbml1IE1pY2xhdXMNCj4gPGFudG9uaXUubWljbGF1c0BhbmFsb2cuY29tPiB3
cm90ZToNCj4gPg0KPiA+IFdoZW4gZGV2aWNlX3Byb3BlcnR5X3JlYWRfc3RyaW5nKCkgZmFpbHMs
IHN0ciBpcyBsZWZ0IHVuaW5pdGlhbGl6ZWQNCj4gPiBidXQgdGhlIGNvZGUgZmFsbHMgdGhyb3Vn
aCB0byBzdHJjbXAoc3RyLCAuLi4pLCBkZXJlZmVyZW5jaW5nIGEgZ2FyYmFnZQ0KPiA+IHBvaW50
ZXIuIFJlcGxhY2UgbWFudWFsIHJlYWQvc3RyY21wIHdpdGgNCj4gPiBkZXZpY2VfcHJvcGVydHlf
bWF0Y2hfcHJvcGVydHlfc3RyaW5nKCkgYW5kIGNvbnNvbGlkYXRlIHRoZSBTRSBtb2RlDQo+ID4g
ZW51bXMgaW50byBhIHNpbmdsZSBzZXF1ZW50aWFsIGVudW0sIG1hcHBpbmcgdG8gaGFyZHdhcmUg
cmVnaXN0ZXINCj4gPiB2YWx1ZXMgdmlhIGEgc3dpdGNoIGNvbnNpc3RlbnQgd2l0aCBvdGhlciBi
aXRmaWVsZHMgaW4gdGhlIGRyaXZlci4NCj4gDQo+IC4uLg0KPiANCj4gPiBzdGF0aWMgaW50IGFk
bXYxMDEzX2luaXQoc3RydWN0IGFkbXYxMDEzX3N0YXRlICpzdCwgaW50IHZjbV91dikNCj4gDQo+
ID4gLSAgICAgICBkYXRhID0gRklFTERfUFJFUChBRE1WMTAxM19RVUFEX1NFX01PREVfTVNLLCBz
dC0NCj4gPnF1YWRfc2VfbW9kZSk7DQo+ID4gKyAgICAgICBzd2l0Y2ggKHN0LT5xdWFkX3NlX21v
ZGUpIHsNCj4gPiArICAgICAgIGNhc2UgQURNVjEwMTNfU0VfTU9ERV9QT1M6DQo+ID4gKyAgICAg
ICAgICAgICAgIGRhdGEgPSA2Ow0KPiA+ICsgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAg
ICAgIGNhc2UgQURNVjEwMTNfU0VfTU9ERV9ORUc6DQo+ID4gKyAgICAgICAgICAgICAgIGRhdGEg
PSA5Ow0KPiA+ICsgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgIGNhc2UgQURNVjEw
MTNfU0VfTU9ERV9ESUZGOg0KPiA+ICsgICAgICAgICAgICAgICBkYXRhID0gMTI7DQo+ID4gKyAg
ICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgZGVmYXVsdDoNCj4gPiArICAgICAgICAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gKyAgICAgICB9DQo+IA0KPiBPaCwgSSBoYXZlbid0
IHJlYWxpc2VkIHRoYXQgaXQgY2FuIGJlIGRvbmUgbGlrZSB0aGlzLiBJIGhhdmUgaW4gbWluZA0K
PiBqdXN0IHRvIGhhdmUgYSBzd2l0Y2ggaW4gdGhlIHByb2JlLCBzbyB3ZSBkb24ndCBuZWVkIHRv
IGRvIHRoYXQgYWdhaW4NCj4gYW5kIGFnYWluLiBPdGhlcndpc2UgbG9va3MgZ29vZCB0byBtZS4N
Cj4NCg0KSG1tLCB0aGUgX2luaXQoKSBmdW5jdGlvbiBpcyBjYWxsZWQgb25seSBpbiB0aGUgcHJv
YmUuDQpJIHRoaW5rIGl0IG1ha2VzIGEgYml0IG1vcmUgc2Vuc2UgdG8gYmUgaGVyZSB3aGVyZSB3
ZSBoYW5kbGUgYWxsIHRoZSBpbml0aWFsIHJlZ2lzdGVyIGNvbmZpZ3VyYXRpb25zLg0KDQpSZWdh
cmRzLA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
