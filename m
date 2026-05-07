Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B852B9B7;
	Thu,  7 May 2026 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174781; cv=fail; b=tQFh3LUDtrCHvXuF6LDDA0hfMAIwPitxzRGiHa+aHZlUXJU4pwGyyI36fPk1QSyN0+6mFXgLasXVojqWB/C0djbOHGDVCqA0ZZLzNjIS84RN9a7Nvnckxt818BJduNeNYTUOCRhUXk00uK6Yh3U6AFxjzDNilwV/32CIAvQitko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174781; c=relaxed/simple;
	bh=0xqiHOUtbGww+pMiH2guOTewpbhIyu3MI5FUwFIZ6m0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B4Dn2Uo5FDoC/g4fzjJ+pxuGwExp2xfbH6fY74JnfS3d9kzyzdB7Gh2TUTyz3SH7nejJTaTb7meDshbwiCQhJYwZ9CqjbRhdykbRT7I6yK7teDfyZiLR1CyGVg7ZPyl2DpSaaNjTadgMflksC9XdmuzpHuvMoVuDTlrZxfGbZI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WDUxI0EN; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WDUxI0EN"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647FQBtv3611488;
	Thu, 7 May 2026 13:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0xqiH
	OUtbGww+pMiH2guOTewpbhIyu3MI5FUwFIZ6m0=; b=WDUxI0ENV2ykZKwMUEcuF
	R4JbeXQ4VAK7wkDG+Yoq6B3S4URomTBqSw8H0Feh+sACTWVjNlXa8nBbiRjz8QY0
	VlKjbN8VQ7ymLKSG2bHivKuxY/ehqHDxSVPT++JzHEhp8HHUZBTV3AihYL8zN3ii
	rCClaAHv+gHKr2C0nDDhaYlsAkSrru1hLroaX4DUN0He9VbGgYTBLRXzD2B3RyZ4
	l7rGDP3GvmaG3wciCVQMW+oL+uGakXl7n3IWgw2HfunK3mQl+OXuO7HdTNO6uS+h
	srSaqA/TThPM9PL5yyQwVlu+mVrZ2spbVZZPZIVidTUEIjvJ+FIWDlntItUd/D5D
	Q==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e04pjea1y-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 13:26:02 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmUdFmptM0jsCODvKzC+XPuNnZ8YxlPZPWYh78/Ra2GcCXSZv9XfRTClCZabreo+yXAsPcnqmFjwed849lV/CYNps0uJxJf4cv4YOH7RILZ8hiIen6QXv/PGeYZ5KdTg6c0EgWJ08grOTbdCFjEDNRUaTuykKfWRBBURufLDkJSJuttno+RwfoTULd7ZcL9Y5OqNS+pCapMWsmh+msC/MvMe2ZCjuq6t1n4KVR0R7rFUuWkPnFd9Q3D9Ffyre3Q+Kkx+jReuxRT22cNDSI7OHE/rdxEfRR+Gq6AaOqzEmNtxzWI3MRxrrqBRXC+mfqruGNkfgVtfYvyS9gS9eSL0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xqiHOUtbGww+pMiH2guOTewpbhIyu3MI5FUwFIZ6m0=;
 b=PlUKxPyyVSqJJfDrqB65m+UW6Us3Bzyk61MoUVKHbLhFmpo3BQrnEeGLn1tFU00QzJISoIJHiNFiaovS5KKkzWY4csLbQ685xxK+qCK9Ee5ZwMtPcdDqjssxaU6rfVpn/lbqdEtYOFXYtU4cnuOzQ4ChNhKfTJaKXqcGoaIiu5iMeOnuDl2yVwofU+HH871/z6axjFU1gIRAttYoE1GN6bM5SvSxSauFuwJu95zHaxdRd5teNAa5l0glB6zafYyk2gwAtxolbBo7+gxwb7kUI0Q9tXLojQIhRKj9XNbp+0CeCLuvvLk/2/9WMVMTYDn4aOgPMJfTEkkTkKmuYkMu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by CH4PR03MB7745.namprd03.prod.outlook.com (2603:10b6:610:243::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 17:25:58 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 17:25:58 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Topic: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Index: AQHc1kn/5d/Hh1H9DE+/jMXiSvhLvbX0U6uAgA5CZsA=
Date: Thu, 7 May 2026 17:25:58 +0000
Message-ID:
 <SA5PR03MB83772D8F6A3CC39094DE5241F63C2@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <20260427132526.272716-1-liviu.stan@analog.com>
 <20260427132526.272716-3-liviu.stan@analog.com> <afCVtXBHIIoLlsRo@nsa>
In-Reply-To: <afCVtXBHIIoLlsRo@nsa>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|CH4PR03MB7745:EE_
x-ms-office365-filtering-correlation-id: 6c176e52-76a8-4867-d14a-08deac5db40a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|18002099003|22082099003|56012099003|3023799003|38070700021;
x-microsoft-antispam-message-info:
 qu+BrvpYKumvQ5rjy8JL+ZS7+R4KNjuW1qJFOXmNgXweS3DgdyYiY8PjigMh/sgB0h5r0f9xXdmxZ99Qarpnqe9frq1xGbFvTB1WNeEXDd/QFRQFiDeErIaeoDCtFAIWPDD2aCrGnmtmNWMF5m+lXbuD7xJTB0v5q3Pl5EDNUZ4KMLprJxVvwYlP4H6nhKrPcFOidSrNs3X4m1o/TWnZ6LKqV6Me9xMZZTrRFGeGuwLu8z556pZOO9rLGlsPyfv/YSZO5lb7rKegyD/DT7IrX16kAZG3voEhi9eJgEGi7xPOs1NfMf1ee44qulIAskurJHMnlkYPw5XrwzyOYN4uDv29wCsA0uL4m7EJQlwdoFtkJnPg8hZRmFhcXMe7cgPwTRJCj2O2wX/skxL7bZb/aAx+TBwxJ+/wtFwY9uvFY4vszEKUeF6SBVymdog2CtyYcO3fe3Aajb5IJGhY7QoUYJpl7ahntkqvSCyTX04m/6rNi3L5NjBFmtL7T4oKvF5nLBynAYWZ1EdR8Ou9gvbSSbr0/ddRqT4MsTwccDCxq26rB1LwVsRsjR17ZknXtleTM0ex9dIpGyp4I9rOpFGqcevyz4PTNdr/ZTdLAisN5riMlmKqGB6VezmIoRgqglUtSUIQFsADRQZ27zFWbt903h8H7g0cx7nJHQUGiY3q0/s+hbZXSUg85KzAqO7QcusIORNd9sMvVmPyCUud1xqsu405u9kgXX5mf3m7szb4libr+D9KLT1MdYB6wXYqqtzO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(22082099003)(56012099003)(3023799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MURQcmxpNkdDTmNRZ1krVGVSVzM3RmdhZUNBQWJGeXZSVGhETVl4SmlYSkY5?=
 =?utf-8?B?Mzh4YWFmZzdPRnRlRGR2dnBxRXJNN2xQcG56OWM2Wk5ieE5lbys0SVR3V25r?=
 =?utf-8?B?TnRHbUYza3huSG5PNnI0RU9jZnJOMElYRFZ3dTFnUXVhMXl2MHp3TjlzVCto?=
 =?utf-8?B?K1VXQ2d6VUE5Szh5MkZRK1NnTGVneTZWNkZ4OFpEc0V1aUg2SGpsRmFVdnhC?=
 =?utf-8?B?YXcwOHB4c3laUlhFUnlzbzZFbEROM3p5QS9JWHFPWGhoSlFrTlRlT1puSDJa?=
 =?utf-8?B?akVmbU5qU2c4dVZ6MURwdFJ4UVo3cndMS3RSR01jbjBuNU1rdzY1eS8zL1F0?=
 =?utf-8?B?YWYraXVMN2R1TU1qSVA2eHVUWU9nU1U4bitLNnoyWU9LNEJiWERxdVJ0V3pC?=
 =?utf-8?B?MkZ2MTh1V1BQU1dGd2lyd0JMbDlCRFZQTTJtdGpQdmdRWnhJamorK3RuYkhm?=
 =?utf-8?B?MUpIam8wSUZzalpkZksyYkp3bmVGQjhZYkxMR0VEMlJKNUtYcloyQTJtbFNz?=
 =?utf-8?B?b01PNGVKOG8wSHVMZUI5SlVrNWpXVmVmT2xFTUxsdUdGUy80RWVQb1g4cjh5?=
 =?utf-8?B?WHZ3R242eWpnV2NXY2lWRm9xOTZTMXFSVDhuYmtQclJKK2xuRnRsVEJtNTdR?=
 =?utf-8?B?Vjl4NEZLU2tFNWZ4QXNpdTl6WFgrNVhCbm5FL2h6ejdqZDFYakVYTW9FT2N3?=
 =?utf-8?B?V3JLMG04eUwwK0o4NndPYVVDaGY4MEx2alN4T3ZsalVyMEJZM3YyZ0JJdVlJ?=
 =?utf-8?B?VmZueVdnN2lKdkJ6Rlp4dEQ2cllVU3ZDUTBxeWs4b292cDdtMlhHcUowaVF0?=
 =?utf-8?B?cTVNK3NWTityeHhqcU5iSWNwN2Z0YkJPTmZwdHVXY2lxZGQyaEUvSnVBZ0dx?=
 =?utf-8?B?MlpDakM3c1JLSEVvNlhwdjBRb3BJeEx2bHBMM3lNNzNKMkgvV0VGU2hSanpO?=
 =?utf-8?B?THhQUFNHTDhsbHZWcGlOLzhHOFlZR3l1dXpWbnlFWTR3cEhwcFpvWnUxak1V?=
 =?utf-8?B?dnBhTVJzMnp0M2xCUzVVeElGdG94WG5vbm5MMWR4YlBzL3RGUmJsU3lmUFJZ?=
 =?utf-8?B?OXpwV01EL1lQbHVHS2RDWUttYW5zTERnWFBSLzBsZnFrZzVIMHVWUURjb0dU?=
 =?utf-8?B?cmZQaUt6SWZVK084L0ZoZHdOTXNJd2xJdHc5U3NhNWdyYXR4MkpJajlwSnMy?=
 =?utf-8?B?TkdTOEZaa1ZPVnNMcll3YktjSFNUaVBtcjhlQm9NbmRpSkdBNmkydHZManpv?=
 =?utf-8?B?TmtxQk55TkpuTTNjbkFqZkVRN1JNS21XK2Q0OTZMYTNiWFlDVEpWTEs0MkVi?=
 =?utf-8?B?endoWThMRUdESXMzVDc0VkNEZXVoSC9BTWFGWkYrUUIrd2NoRFVXem1VWko1?=
 =?utf-8?B?ays4bmNWQTZSSGhHbjNJR3haSXRUUEhqZlV4ak5QQTVEREFhRko1TXpVbGJU?=
 =?utf-8?B?TmJBb0R3MVNhNGMya2dvcklmK052cm1sSW53NThoQzc5SGN1MmFxemNuak9x?=
 =?utf-8?B?Q0NlWXFlTGRZR01lMzZ2WlFIb0NvTXJ2WFg0Y3NjRmJLcnhEeXZjSDVXUHR3?=
 =?utf-8?B?eXBHOFp3Tk5RaHlibDJSUmVYQlMvd0dGSHB1dW1XVjRCdUg1SDF6ek4wWGp3?=
 =?utf-8?B?RkxZejBwbU83T1VGSkxhdWxwRmIzZ3c4aU0zOCtZK3F6c3FVSmFoUmU0YUpQ?=
 =?utf-8?B?Z3FmekNTMCt2UXJBRUYvdnNlbFBseWNrUzRqSDB1T2hhNE84bEd5bDhqV0V1?=
 =?utf-8?B?NmVWM0FXL0l2YkhYaXpJS3plcWpib3VYN3M0T1lVV2g5OWV0QTI1TkYyejRz?=
 =?utf-8?B?VExsdkVJYXIyeEJlejFVUkZnNjJ5b0lNV1VoQ2Qwc29SVFdMaGVNUWsyTHRT?=
 =?utf-8?B?czlYaWRkdGw5d1hGQU1zNlg4bG1USW9oeW84R2ROV2V3QTFVcnhxZG9vb2dK?=
 =?utf-8?B?b1g1eW0vN2ZIdDJCMm0zeEVkTkM0Q3VxRGJCYldRTzJKcjBHcFBIMC9EVE12?=
 =?utf-8?B?eDZNcEVCQWRXQWM3RXBQWktIcmpoK2RtSVRmcm1kNXhqcVdaMWNJWDVEenFU?=
 =?utf-8?B?WlBHVGJiRnVDOThOUEVjT0h2TkltRWs0ckFaZWg3UHp4VnJrelFCc28ydGs2?=
 =?utf-8?B?NUU0MzRvL3hqcXUrVUxMMS9RRGRoc21pa05jUExZdWJPRi8ybGU2UHpCVGxD?=
 =?utf-8?B?Z2lMdWhtdzVMZDJ2M0ppUHllaCt4ZmFvNjlIanRQdldHVXNiUDFZdXpXRk1m?=
 =?utf-8?B?cDJ5RGlFa0xTckVRbzc2VHNOaFo1OUFJdk1relpIMnRqVkx1cGdNRi83ZEFu?=
 =?utf-8?B?N1hGRWRFb3JVa0NsNi9WMHNRSE9ZaHN5N1VOMTMxZTgzM0tiMmZBUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	kFMFKJ3tlvMJwXy9vJtrGh6lqdc1nazpq+ok8FrMcYTKECIpaI+N5PdZugkUA4BKSLjmzBJfjZ6P1wX1f87uGBPIKO6FyeE7q5K3c334cxL+2Hp5y8xhitYOGnLcTdvUHWkYQwyVUsjm7dXytdKoiR9obRf9rqPbwVrixzen4jScJzZaCtRSXmgkoDLc8ewHI8c2zPSkpdOkbsewdL484gV3qGc0XeKcXfjtKYd25AmbFYbgcjfgb78f6GQgrNaoYqcYLq+wYKrxER4Uwhu5vx43aD7DxXTUARyPxIU4V9D7oH5bSEMQ/NlENddYEhve9ZysdTaB4/MsZJh31yQnOw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c176e52-76a8-4867-d14a-08deac5db40a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 17:25:58.5242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPHiurhiofZ4Gsmk9b7vEjod4so2QuEN+OWYd+71AFH0twE+iNIE8cNckjeeLw0RF7QeRQOBwsp5RV4XwIyfZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7745
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE3NSBTYWx0ZWRfXzek8QWlfiCkK
 Q4LeYsDnn9yaEjajU3QFQvBeSl8+NLePGm5Pk1/1SsdyZ7ZrE0iMC0jJ0pvD/LN+9tKjCI4lWAz
 +9WnsqfFMCUEzEAS/XcTzHdyV5ERFbkiwST02EpWUAmTHXhHAXqoNQ33jvh9MEJp96a3MEDabqX
 cvPeJQGuYsLdjbx6tQy/9IrSY/LeUPI74lJ6pgvjY8KxBqDxt1ePya9z8DRP4zu08MDKj28DIr8
 MfxhhJ4cWBK1uNLZncPHAvG8s4ub51tjjq9YyEXWAzPHS7OWUD2yDrijhkNHaYoTrs5d5/CNIe/
 mLHtpNmblPCP4wyhCT0T1oWcmI14Wt9oYxovYWnQgTre61wrd8QqAu43tepV9A31mceghHORfHD
 o04ha+zFyfnl4PxOrg/fMzW1tVzgOUZo/HCZZlrkvA5ZhO/BzhzzSr61dJXyiIjHpDthesgdBM6
 NR8oPVqVS1bLC6YOJIQ==
X-Proofpoint-ORIG-GUID: 7pOb_EzuLr0s9qRy2ayxqYM7dknMHOIn
X-Proofpoint-GUID: 7pOb_EzuLr0s9qRy2ayxqYM7dknMHOIn
X-Authority-Analysis: v=2.4 cv=Fss1OWrq c=1 sm=1 tr=0 ts=69fccb2a cx=c_pps
 a=Eb813/LJkoRL1pr8t+D1ZA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=e0Cg7hO1CRH8j8MksbgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070175

VGhhbmsgeW91IGZvciB0aGUgY29tbWVudHMsIGFuZCBJIGFwb2xvZ2l6ZSBmb3IgdGhlIGxhdGUg
cmVwbHkuDQoNCk9uIE1vbiwgQXByIDI4LCAyMDI2LCAgTnVubyBTw6Egd3JvdGU6DQouLi4NCj4g
PiBCb3RoIHNlbnNvciB0eXBlcyBleHBvc2UgYW4gSUlPX1JFU0lTVEFOQ0UgY2hhbm5lbCByZWFk
aW5nIGZyb20NCj4gPiB0aGUgcmVzaXN0YW5jZSByZXN1bHQgcmVnaXN0ZXIgYmFuayAoMHgwNjAt
MHgwMEFGKSwgYWRkZWQgdG8NCj4gPiB0aGUgcmVnbWFwIHJlYWRhYmxlIHJhbmdlcy4gU2NhbGVz
IGFyZSAxLzEsMDI0LDAwMCBmb3IgY29wcGVyDQo+ID4gdHJhY2UgKHJlc3VsdCBpbiBtT2htKSBh
bmQgMS8xMDI0IGZvciBsZWFrIGRldGVjdG9yIChyZXN1bHQNCj4gPiBpbiBPaG0pLg0KPiANCj4g
QnV0IGZvciB1c2Vyc3BhY2Ugd2UgcmVwb3J0IGJvdGggaW4gT2htPyBUaGF0J3MgdGhlIEFCSSBB
RkFJQ1QuIEluIERULA0KPiB5b3UgYWxzbyBtZW50aW9uIElJT19URU1QIGlzIHVzZWQ6DQo+ICJJ
SU9fVEVNUCByZXBvcnRzIGNvdmVyYWdlIHBlcmNlbnRhZ2UiDQo+IA0KPiBDYW4geW91IGV4cGFu
ZCBtb3JlIG9uIHdoYXQgdGhlIGFib3ZlIG1lYW5zPyBBcmUgd2UgcmVwb3J0aW5nIG1pbGxpDQo+
IGRlZ3JlZXMgY2VsY2l1cyB0byB1c2Vyc3BhY2U/DQoNClllcywgYm90aCBJSU9fUkVTSVNUQU5D
RSBjaGFubmVscyByZXBvcnQgaW4gzqkuIFRoZSBjb21taXQgbWVzc2FnZSB3YXMgDQptaXNsZWFk
aW5nLCBpdCBkZXNjcmliZWQgdGhlIHJlZ2lzdGVyJ3MgbmF0aXZlIHVuaXRzIChtzqkgZm9yIGNv
cHBlciB0cmFjZSwNCs6pIGZvciBsZWFrIGRldGVjdG9yKSwgbm90IHRoZSB1c2Vyc3BhY2Ugb3V0
cHV0LiBUaGUgc2NhbGVzIGFyZSBjaG9zZW4gdG8gDQpjYW5jZWwgdGhvc2UgdW5pdHMgYW5kIGdp
dmUgzqkgaW4gYm90aCBjYXNlcy4NCg0KQXMgZm9yIHRoZSBJSU9fVEVNUCBxdWVzdGlvbiwgdGhl
IGNoaXAncyBjdXN0b20gc2Vuc29yIHRhYmxlIHN0b3JlcyANCnRlbXBlcmF0dXJlIGluIEtlbHZp
biAoc2FtZSBhcyB0aGUgTFRDMjk4NCBjdXN0b20gUlREIHRhYmxlKS4gRm9yIHRoZSANCmxlYWsg
ZGV0ZWN0b3IsIGNvdmVyYWdlIGRhdGEgaXMgZW5jb2RlZCBhcyAoUCArIDI3My4xNSkgSywgc28g
d2hlbiB0aGUgDQpjaGlwIGNvbnZlcnRzIEtlbHZpbiB0byBDZWxzaXVzIG9uIG91dHB1dCwgYWZ0
ZXIgdGhlIGRyaXZlciBhcHBsaWVzIHRoZSANCjEwMDAvMTAyNCBzY2FsZSwgdGhlIElJTyBvdXRw
dXQgaXMgUCAqIDEwMDAgbWlsbGlkZWdyZWVzIEMgLSAwJSByZWFkcw0KYXMgfjAgbWlsbGlkZWdy
ZWVzLCAxMDAlIHJlYWRzIGFzIH4xMDAwMDAgbWlsbGlkZWdyZWVzLiBCdXQgeWVzLCB0aGUgDQph
Y3R1YWwgdXNlYWJsZSBxdWFudGl0eSBpcyBjb3ZlcmFnZSBwZXJjZW50YWdlLCBub3QgdGVtcGVy
YXR1cmUuIElzIHRoZXJlDQphIG1vcmUgc3VpdGFibGUgZXhpc3RpbmcgSUlPIGNoYW5uZWwgdHlw
ZSBmb3IgY292ZXJhZ2UgcGVyY2VudGFnZT8NCg0KPiBJIGNvdWxkIG5vdCBmaW5kIHRoZSBkYXRh
c2hlZXQgc28gSSBndWVzcyBpdCdzIG5vdCB5ZXQgcHVibGljPw0KDQpDb3JyZWN0LCBpdCBpcyBu
b3QgcHVibGljIHlldC4gV2lsbCB1cGxvYWQgdGhlIFVSTCBvbmNlIGl0IGlzLg0KDQouLi4NCg0K
PiA+ICBzdHJ1Y3QgbHRjMjk4M19kYXRhIHsNCj4gPiBAQCAtMjcyLDYgKzI3NSw3IEBAIHN0cnVj
dCBsdGMyOTgzX3J0ZCB7DQo+ID4gIAl1MzIgcl9zZW5zZV9jaGFuOw0KPiA+ICAJdTMyIGV4Y2l0
YXRpb25fY3VycmVudDsNCj4gPiAgCXUzMiBydGRfY3VydmU7DQo+ID4gKwlib29sIHN1Yl9vaG07
DQo+ID4gIH07DQo+ID4NCj4gPiAgc3RydWN0IGx0YzI5ODNfdGhlcm1pc3RvciB7DQo+ID4gQEAg
LTU3NSw2ICs1NzksMTAgQEAgc3RhdGljIGludCBsdGMyOTgzX3J0ZF9hc3NpZ25fY2hhbihzdHJ1
Y3QNCj4gbHRjMjk4M19kYXRhICpzdCwNCj4gPiAgCQlpZiAocmV0KQ0KPiA+ICAJCQlyZXR1cm4g
cmV0Ow0KPiA+ICAJfQ0KPiA+ICsNCj4gPiArCWlmIChydGQtPnN1Yl9vaG0pDQo+ID4gKwkJY2hh
bl92YWwgJj0gfkdFTk1BU0soMTcsIDApOw0KPiA+ICsNCj4gPiAgCXJldHVybiBfX2x0YzI5ODNf
Y2hhbl9hc3NpZ25fY29tbW9uKHN0LCBzZW5zb3IsIGNoYW5fdmFsKTsNCj4gPiAgfQ0KPiANCj4g
SSdtIG5vdCBzdXJlIGlmIHdlIHNob3VsZG4ndCBqdXN0IHRyZWF0IHRoZSBuZXcgdHlwZXMgYXMg
bmV3IHNlbnNvcnMNCj4gaW5zdGVhZCBvZiB0cnlpbmcgdG8gcHVzaCB0aGVtIGluIHRoZSBleGlz
dGluZyBvbmUuIEkgYWdyZWUgd2l0aCBBbmR5LA0KPiB0aGUgcGF0Y2ggZG9lcyBub3QgbG9vayBn
cmVhdCB3aXRoIHJlc3BlY3QgdG8gaWYoKSBlbHNlKCkgYW5kIGdvaW5nIHRvDQo+IGRlZXAgaW4g
aW5kZW50YXRpb24uDQo+IA0KPiA+DQo+ID4gQEAgLTc1OCw4MyArNzY2LDExMyBAQCBsdGMyOTgz
X3J0ZF9uZXcoY29uc3Qgc3RydWN0IGZ3bm9kZV9oYW5kbGUNCj4gKmNoaWxkLCBzdHJ1Y3QgbHRj
Mjk4M19kYXRhICpzdCwNCj4gPiAgCQlyZXR1cm4gZGV2X2Vycl9wdHJfcHJvYmUoZGV2LCByZXQs
DQo+ID4gIAkJCQkJICJQcm9wZXJ0eSByZWcgbXVzdCBiZSBnaXZlblxuIik7DQo+ID4NCj4gPiAt
CXJldCA9IGZ3bm9kZV9wcm9wZXJ0eV9yZWFkX3UzMihjaGlsZCwgImFkaSxudW1iZXItb2Ytd2ly
ZXMiLA0KPiAmbl93aXJlcyk7DQo+ID4gLQlpZiAoIXJldCkgew0KPiA+IC0JCXN3aXRjaCAobl93
aXJlcykgew0KPiA+IC0JCWNhc2UgMjoNCj4gPiAtCQkJcnRkLT5zZW5zb3JfY29uZmlnID0gTFRD
Mjk4M19SVERfTl9XSVJFUygwKTsNCj4gPiAtCQkJYnJlYWs7DQo+ID4gLQkJY2FzZSAzOg0KPiA+
IC0JCQlydGQtPnNlbnNvcl9jb25maWcgPSBMVEMyOTgzX1JURF9OX1dJUkVTKDEpOw0KPiA+IC0J
CQlicmVhazsNCj4gPiAtCQljYXNlIDQ6DQo+ID4gLQkJCXJ0ZC0+c2Vuc29yX2NvbmZpZyA9IExU
QzI5ODNfUlREX05fV0lSRVMoMik7DQo+ID4gLQkJCWJyZWFrOw0KPiA+IC0JCWNhc2UgNToNCj4g
PiAtCQkJLyogNCB3aXJlcywgS2VsdmluIFJzZW5zZSAqLw0KPiA+IC0JCQlydGQtPnNlbnNvcl9j
b25maWcgPSBMVEMyOTgzX1JURF9OX1dJUkVTKDMpOw0KPiA+IC0JCQlicmVhazsNCj4gPiAtCQlk
ZWZhdWx0Og0KPiA+ICsJLyogQURUNzYwNCByZXF1aXJlcyBoYXJkY29kaW5nIHNlbnNvciBjb25m
aWd1cmF0aW9uIGJpdHMgdG8gMGIxMDAxDQo+ICovDQo+ID4gKwlpZiAoc3QtPmluZm8tPmhhc19j
b3BwZXJfdHJhY2UgJiYNCj4gPiArCSAgICBzZW5zb3ItPnR5cGUgPT0gTFRDMjk4M19TRU5TT1Jf
UlREX0NVU1RPTSkgew0KPiA+ICsJCXJ0ZC0+c2Vuc29yX2NvbmZpZyA9IDB4OTsNCj4gPiArCQlp
ZiAoc2Vuc29yLT5jaGFuIDwgTFRDMjk4M19ESUZGRVJFTlRJQUxfQ0hBTl9NSU4pDQo+IA0KPiBM
aWtlIHRoZSBhYm92ZSwgd2UgaGF2ZSB0aGUgZm9sbG93aW5nIGtpbmQgb2YgY29uZGl0aW9uIGFs
bCBvdmVyIHRoZQ0KPiBwbGFjZS4gSW4gRFQgd2UgY2FuIGp1c3QgaGF2ZSBhIGRpZmZlcmVudCB0
eXBlIGZvciB0aGVzZSBhbmQgbWFwIGl0IHRvDQo+IHJlYWwgdmFsdWUgd2hlbiBjcmVhdGluZyB0
aGUgc2Vuc29yLg0KDQpJIHVuZGVyc3RhbmQsIEkgd2lsbCBpbnRyb2R1Y2UgbmV3IGFkaSxzZW5z
b3ItdHlwZSBlbnVtIHZhbHVlcyBmb3IgDQpjb3BwZXIgdHJhY2UgYW5kIGxlYWsgZGV0ZWN0b3Iu
IFRoZSBkcml2ZXIgd2lsbCBtYXAgdGhlc2UgdG8gdGhlIA0KaGFyZHdhcmUgcmVnaXN0ZXIgdmFs
dWVzICgxOCBhbmQgMjcpIGFuZCBoYW5kbGUgdGhlbSBpbiBkZWRpY2F0ZWQgDQpzd2l0Y2ggY2Fz
ZXMgd2l0aCBkZWRpY2F0ZWQgZnVuY3Rpb25zIChsdGMyOTgzX2NvcHBlcl90cmFjZV9uZXcoKSAN
CmFuZCBsdGMyOTgzX2xlYWtfZGV0ZWN0b3JfbmV3KCkpLCByZW1vdmluZyB0aGUgaGFzX2NvcHBl
cl90cmFjZSBndWFyZHMNCmZyb20gbHRjMjk4M19ydGRfbmV3KCkgYW5kIGx0YzI5ODNfdGhlcm1p
c3Rvcl9uZXcoKSBlbnRpcmVseS4gT25lIA0KdHJhZGVvZmYgaXMgdGhhdCB0aGUgYWRpLHNlbnNv
ci10eXBlIHZhbHVlcyBmb3IgdGhlIG5ldyBzZW5zb3JzIHdpbGwgDQpub3cgbm90IGNvaW5jaWRl
IHdpdGggdGhlIGhhcmR3YXJlIHJlZ2lzdGVyIHZhbHVlcyBpbiB0aGUgQURUNzYwNCANCmRhdGFz
aGVldC4NCg0KLi4uDQoNCkkgd2lsbCBhZGRyZXNzIHRoZSByZXN0IG9mIHRoZSBjb21tZW50cyBp
biB2MiBhcyBwYXJ0IG9mIHRoZSByZXN0cnVjdHVyaW5nLg0KVGhhbmsgeW91IHZlcnkgbXVjaC4N
Cg0KTGl2aXUNCg==
