Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794923387;
	b=CkbzKlDfjFb30FdySMdS+6o1FdQlkF2vdcB8L69tGEHpQ2ILcUGbM54H0rozfHSn4Yds
	 XGb+se/ydiSIKSdefF6XmJBSDEGJpRU3YV4qTHa1/VKSe4+aSl7ZV7LNfO3dQsROom7WG
	 yAzcdJF+xACzGeErFYRGbV14f0mJoy4txQeEuJKSc4igVcZoae/CTR4Wj0736upTcem9Y
	 pJmvUO1MWidInKA1hZUiimOV5lB3vJu4LvWs0ZhS0nNlNLktGL0wMVwBnbfHAYefw0uOg
	 DMHOYTjfCayQyGZnHdhQ14kQ2CbhCCVvQaKAlioK6RQc+EuQDG0pEQkqhpCL45Ba/1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923387;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+f2OKnsYkIbvdaitoLLPkEY57CKo+1RTvBk8gyxpwlY=;
	b=OrWdOM/OBU1eTUycuuAr3c+YoIi/85odTwYTq6PJ8yD1AGXNr985vNgG2Nw62obvaafb
	 +y1NAueadO5C0iekBgFO7aezKmxpT+9eLewGwpYZxHmMLxQqevIJMl/nLYqq00Fg2+m3n
	 fFxNZkBvGL302nWAJIJTG/BJAnpW8nNO40kNJVSxKT+zpHw5ktUr3CAgOYX/nHepfAb9x
	 p1VLiDY+c+flbmPXWkC/k+2MXc5/saEbPOTG7h80mvDcxCNjyFEy5IZWLTYZCIXZ59DFd
	 RixTCVMfApCqOZTL8ajBBVtmfrNpGJRMf2CS2jSU/xzk9zezi9FEGWIIabetLlspXQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=pqis4Z7E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.9
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011009.outbound.protection.outlook.com [52.101.125.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE60606A31C;
	Tue, 17 Nov 2026 13:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE60606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=pqis4Z7E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1aS2UODq8TudwWQ/i7DC5LZzfIPrs2M4pu6jQp5VbymVzFn7zHHstNLAA/oWVr2kgTh/m5kixp4BTImlHcvcxzW+hLC54njPeIisf8Nt3uf2jgZSahTYhxnNO1Zd0Any/1aNr8JbDM7CoYSvtGhWOzUCBubkY624faNLBlC+cOMCTrHpApSSysExIaMtui1SXSyjSltlbv20MtZXKnVOcc09n+grtiSf943SAqzQd0zklPEvfTz7TiRxF8zsho7lX3dvOcO15ux+6xcufYOOhoWMzAcQ0ANT03vgdoyLT5vbxHx+Y3FZs8TEjV8K0QITVopq+klJ50HCpj355RqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f2OKnsYkIbvdaitoLLPkEY57CKo+1RTvBk8gyxpwlY=;
 b=hD7YKolAnFxWWBvE73YgCVCKfBAUDrrtYThCkLNoFysrc70/yz6fnkAFQK4OXUwEuMy+NbOKfZ2wn3On8vVY0MMVoXWJYf4FnM2G3ybYica0NW8iKWQyPk65HRX4+NGHZyLko6aoeJnT4ddWFHmRGPItbRP+pQwoTN89JED0jAuOAucfeFWL6/jGLBko/9Bcoanzh5BQzvVY8V0bc1+0gt01oIZgyQfeMTLFZXCsEoYdqdonoa263H47f6Jxa3D8ZvLHmXJ5CDmoOqSCJYNCpEOo2AsV9AX7b6f1mKB4K2yOCWVIqaD82MdVJzEoo1uvlffzWkoEVojH6cELo6vjWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f2OKnsYkIbvdaitoLLPkEY57CKo+1RTvBk8gyxpwlY=;
 b=pqis4Z7EwGh2PqlHmYKJgvTdjZgsNYkwUxwmsR9xxxt8BbXbbTB5SdSPot7mHYP5SeEipuPV3ynjVp5niQ8HV4fR1ZVwirNZvzr149gA/82ZKL4eRNLH8DQ2/Rbr9tjdp70y1PK/sgodwZpy4JR4smK/8EUGUNjQEScJUHLH2p4=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by OS7PR01MB11777.jpnprd01.prod.outlook.com (2603:1096:604:248::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 13:49:41 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 13:49:41 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, William
 Breathitt Gray <wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin-Gabriel
 Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: RE: [PATCH v3 11/14] counter: rz-mtu3-cnt: cache direction values
Thread-Topic: [PATCH v3 11/14] counter: rz-mtu3-cnt: cache direction values
Thread-Index: AQHddn5Lvbe+rBUhEEONEqrQfgNBn7cyRnsA
Date: Tue, 17 Nov 2026 13:49:40 +0000
Message-ID:
 <TYYPR01MB66036EDFF90414052C73ACF3867B2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261117102607.2504551-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20261117102607.2504551-12-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To:
 <20261117102607.2504551-12-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|OS7PR01MB11777:EE_
x-ms-office365-filtering-correlation-id: 89975df8-3b5a-464b-dd42-08df44b1a0f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|18002099003|22082099003|261026121527099003|261021123027099003|261021121427099003|261102123227099003|56012099006|4143699003|10067099003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 eFuc/ddj04uzdB5Xr2nHNOjDbyqQeMjyXQEgEn3ZMuDylw0NjtItTFkU2hgqqPjReLhjKjrMDKasxLos6l0WFiX3t9TSGhmkm4fP/46Je+hEZyISQDmjFfRgieB+6AoRoQLD3q8h97H/qeza689dBnYLbryDgBvVYJu3RDwKI+UjmsmB7WJgXUKrWxmnLp29vtI0C913IDD5C4axfJWvq7wzbO4cVyE7AaK62CkorvrKjFMgzOzTusA3HP1raFbGzay/w8l2k9mXsKusaBD75M+JNLH+2/xDNeMzlQJl6xXL+TNLPJNw6WS0y5VoxGv87MVcpCxJBCvXqWnx1E7lyXlN5QQDvXjzn9v6qqDLxR3f+SvOnnZOgf72bzeHXcI8M5hHFGCYEYvB+i//qESvG/5cMryTGQAT7T80t/MYjtIEhHroZw4FrCt28cj+y0euZApjK/Ze/5J66AHc23wOP2G7svYVbEf6EsRBXvRqMkWVVT9hM6BWOFZ1Ro4gZpvzGZ/Wl4dYTv2bV8m6/D38ntMVqayq8Z6OWaveaUk/LAAYLgIWxxvS3KFVYMRg05GO6OFoUeOHYlIzxOwx4Y4bHS41HYyJiT0kpbw3G3ao+oVhwOTNrGAXyGPxiL/gNSkHkBJtBIKi0bYiwuw++gUsaGhi+qajiopYzzRbM61mAhpkoEeH96yHnFXeE24KoLYVomWDx8djLvjPQw6Mi+joQoNk9b0zhFNAsfvSLhANd6w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(18002099003)(22082099003)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(56012099006)(4143699003)(10067099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXBaYUs0cDAvSEIwT1g2WDdWd3NtNnJTQWhFWGRoVHFId05vSXlkcTNvcVRk?=
 =?utf-8?B?NlV2MU11YnZpb1pCTnBIM0R3L0NiV25oZ0FHNGJocitpQi9MdjhNMFMrZVpy?=
 =?utf-8?B?TTNDNEdEOTVtTldwTUtQR28zd2VGYzNOOGp6QXZUZ0RMdnRZZDhJMkxkYWFC?=
 =?utf-8?B?aFVWT3M1REk5VUVBN05DeHV1N0pQRytvakRhdC9TMFdGUGZISzhLUTdKRVpt?=
 =?utf-8?B?TnNGMkVkZHBGZzJWY3MxNWd4SDVheFltL3FRR2EySHdIVWtEUW54S01zQWZO?=
 =?utf-8?B?eThhUzFSd1FENjZEZENCNG9IUS9GYnd4SmpKeWMxeG9jUVB4QmNNSCtiWHpX?=
 =?utf-8?B?ZGNjcVRlZjNmb0J2NHBsVWJ2VmRCQ24weHpTcU5ramJaa2F1OUxHaVNiNWxo?=
 =?utf-8?B?akVwYjJlaS90WTN0dXQ4ekJ0QkVJMWdYa2hTL3M5bUs4Y1hqcHNUaXBPWmln?=
 =?utf-8?B?V24yOUhjV1grdEd1MW5wRVFibkZVUHNCdzkwd2RuMkhpeGF0MmlJZ1pOTnZr?=
 =?utf-8?B?emRYR0J5NzJPekR5ZmFjclVocWVXdkt0ZmF5cEdkTWVtWGdDcXl6Y1FTNmFN?=
 =?utf-8?B?Njk1bkI2bTREd0tyY1Vpb1ozMDJNSU9XcHJTbTB1Q2hBQndzZnplbTlRV1FV?=
 =?utf-8?B?aHhzdEQ2NnZZTytrR21NcUxvWHRqM0FkVk9XOHo2NU0vcDdsbWQrWm9KNjFn?=
 =?utf-8?B?TFRlYnFmOTVqMHE0UERFTHVoaElhTXZwb0tmYk1Edy9qZ2E0ZWx5RGJta0M3?=
 =?utf-8?B?UEdaN0ZIaWxUSG4vdm93eUw3V1dGaHVPQTJsd25QcW14QmNHc1ozbGpmbXlC?=
 =?utf-8?B?R0N1VTcxU0xIc1AxTHRsMUhlM0kwUzduQVA2V0UrU1FHTk9RWDFobUwyN0tP?=
 =?utf-8?B?bCtOVXJHZlRvbi9ybzJ1ajRXamN2ajdoVm5TWXlkODd6cm1XZjRUdE00czl0?=
 =?utf-8?B?MWF4U0I2a2I5Z25yUVVSYmM3dDNTb3d4dWRoTEhiK0Z4UXVlbVRHQnBpUjRn?=
 =?utf-8?B?MDl2QWpkUldJNTk5NkhPYTNnRGozUnVSK2RIUWNJRlZueGpPOTkzUDM0c1h3?=
 =?utf-8?B?M2wyaFd1djVLT3hGalV4WmFYYmN0Q0kvV3BYRWM1UUVFMFFCanBZbXRLdmdP?=
 =?utf-8?B?MHg3YjJ5KzZBQ0lra3RCNXdFNzZybkhkUVUvOWd5Z3dsV1N3dllMbGRRN2JH?=
 =?utf-8?B?SndJaVNMdFRhQzNKRTRNSnF5L1F1VThhSjBjRDcyd3h1bEN3OE9qRmc1VURN?=
 =?utf-8?B?OGE3SEpRNVJNT0h3VkE3bmJRUjRBSUY0aFkzMVNYR1NWQVNMeXlEbEJwSjlD?=
 =?utf-8?B?ZTR5WGdrcHNKTmdhWG1YbERtYm1BT083eDhEam1SYmV4cC8wVU5jYy9ibWZL?=
 =?utf-8?B?bjBYSVV1L2djdXdISVBKQTVkVk04NDVlZEJ1dTdzWDVpRzlmYzg2VkVvODYv?=
 =?utf-8?B?ZTMxYU5UNTVMaFR5UFdIZEJpdk9WYjdXbW43VEY4SmdMVStZR3oxTngyaGNG?=
 =?utf-8?B?NEdocTlqMFJSc01KbWROM3lqQ3ZObWN0N1ByczEyNVlkZ1UxQzl0T1BqL2NC?=
 =?utf-8?B?aFNEenZsbTlpMGJzVnRtQWJwQjV0TlVydmd5OGtMdTZwQWl5SXNYT0VkMlBF?=
 =?utf-8?B?ZWd5TGlDQWptT29icmwxcDVlTUJ3cTFUZ0gzUnFwL0Jpc2tyR2tzQ2Z1RVJ5?=
 =?utf-8?B?bVlCVStRNGJzcEV4THZrd3Badm1OT3BZS1piMFZnWjNGZzFYRkxIM0IwdzVu?=
 =?utf-8?B?WmxRbWZuQW40Vnl1V3A4SjRPV3MwMUF0RnJGTUtpMERzcTIxUEFTYTEwYjVO?=
 =?utf-8?B?a0I2bXNkWE90K205dHd1SFMvdGp5SHo2T3BWcS9PdWwzc2hTa0UwQWRZVUNj?=
 =?utf-8?B?anpIYTRLSk8xMUgyVFY3UXR6WHk1bHRTRDdMSFhweDFWN2E5NkR3dHU3dUQx?=
 =?utf-8?B?STVwVFBKSFFUN2hqVU0zQjdNVHV1VlhoSmlFenh4M0lRVUh5VDNpQkd5UTVw?=
 =?utf-8?B?aEdSNGg2OUZnbFM4aEdaRVMwemZ1L2JvSUtqblhaN3BYRXRrK3g3dDhld3Bt?=
 =?utf-8?B?RFM1eVI5dFNqUVp5bytxdjI3RHBhL1BzUkZNelg0UnRxSitqbDA5TzF6VG1W?=
 =?utf-8?B?NDhjRjFnbHpiK3FkcHJEeUdRbDZGVVdCZTJ1THg3Z1hEZ280T3lXdk1qNnJw?=
 =?utf-8?B?bnkzOVlmUzJiWlBCNVpJRTRGOENoVlNBa0pGREZjbzFGWFZBOCtMMG9mZUFt?=
 =?utf-8?B?UllST0I2UXRxWUhNYkF4a3lud3QzcDhpOGkxVHhsaldLQTNmdk1OZWV6bnEw?=
 =?utf-8?B?TlRpL0t1Q0xoOWIraGxWRVpMU1Z3WElTc1kvQnFFK1Vac2c0Nk5OQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89975df8-3b5a-464b-dd42-08df44b1a0f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 13:49:40.9798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3MVVx1no0Ou7hq5OjvOeBCLgSMwCMBN291IVyBW0yXpaeQZTDCs8t0lCWmiwwXYMqPShMzaTYChbg2iE10wAw7lHe8U+lOtTU4wIQlsISks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11777

SGkgQ29zbWluLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaC4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb3NtaW4gVGFuaXNsYXYgPGNvc21pbi1nYWJyaWVsLnRhbmlz
bGF2LnhhQHJlbmVzYXMuY29tPg0KPiBTZW50OiAxNyBOb3ZlbWJlciAyMDI2IDEwOjI2DQo+IFN1
YmplY3Q6IFtQQVRDSCB2MyAxMS8xNF0gY291bnRlcjogcnotbXR1My1jbnQ6IGNhY2hlIGRpcmVj
dGlvbiB2YWx1ZXMNCj4gDQo+IFJlYWRpbmcgcmVnaXN0ZXJzIHdpdGhvdXQgdGhlIGNvdW50IGJl
aW5nIGVuYWJsZWQgaXMgYW4gaXNzdWUgYXMgdGhlDQo+IGNoLT5pc19idXN5IGNoZWNrIGluc2lk
ZSByel9tdHUzX2xvY2tfaWZfY291bnRfaXNfZW5hYmxlZCgpIGNhbiByYWNlDQo+IHdpdGggUFdN
IG9wZXJhdGlvbnMuDQo+IA0KPiBDYWNoZSB0aGUgZGlyZWN0aW9uIHZhbHVlIG9uIGV2ZXJ5IHJl
YWQgYW5kIG9uIGRpc2FibGUsIGFuZCByZXR1cm4gdGhlIGNhY2hlZCB2YWx1ZSBpZiB0aGUgY291
bnQgaXMNCj4gZGlzYWJsZWQuDQo+IA0KPiBTaW5jZSBydW50aW1lIFBNIGlzIGVuc3VyZWQgdG8g
YmUgcmVzdW1lZCBpZiB0aGUgY291bnQgaXMgZW5hYmxlZCwgZHJvcCB0aGUgcG1fcnVudGltZV9n
ZXRfc3luYygpIGFuZA0KPiBwbV9ydW50aW1lX3B1dCgpIGNhbGxzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQ29zbWluIFRhbmlzbGF2IDxjb3NtaW4tZ2FicmllbC50YW5pc2xhdi54YUByZW5lc2Fz
LmNvbT4NCj4gLS0tDQo+IA0KPiBWMzoNCj4gICogbm8gY2hhbmdlcw0KPiANCj4gVjI6DQo+ICAq
IGFkZCBzdHJ1Y3QgcnpfbXR1M19jbnQ6OmRpcmVjdGlvbiBkb2N1bWVudGF0aW9uDQo+IA0KPiAg
ZHJpdmVycy9jb3VudGVyL3J6LW10dTMtY250LmMgfCAxOSArKysrKysrKysrKysrKy0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NvdW50ZXIvcnotbXR1My1jbnQuYyBiL2RyaXZlcnMvY291
bnRlci9yei1tdHUzLWNudC5jIGluZGV4DQo+IDRiMTM3MTZkNmNiNy4uZTM1Nzg4NTBmMDI0IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2NvdW50ZXIvcnotbXR1My1jbnQuYw0KPiArKysgYi9kcml2
ZXJzL2NvdW50ZXIvcnotbXR1My1jbnQuYw0KPiBAQCAtNzAsNiArNzAsNyBAQA0KPiAgICogQGNv
dW50OiBDYWNoZSBmb3IgY291bnQgdmFsdWVzDQo+ICAgKiBAdGltZXJfbW9kZTogQ2FjaGUgZm9y
IHRpbWVyIG1vZGUgdmFsdWVzDQo+ICAgKiBAbXRjbGtjX210Y2xrZDogQ2FjaGUgZm9yIGV4dGVy
bmFsIGlucHV0IHBoYXNlIGNsb2NrIHNlbGVjdCB2YWx1ZQ0KPiArICogQGRpcmVjdGlvbjogQ2Fj
aGUgZm9yIGRpcmVjdGlvbiB2YWx1ZXMNCj4gICAqLw0KPiAgc3RydWN0IHJ6X210dTNfY250IHsN
Cj4gIAlzdHJ1Y3QgbXV0ZXggbG9jazsNCj4gQEAgLTc4LDYgKzc5LDcgQEAgc3RydWN0IHJ6X210
dTNfY250IHsNCj4gIAl1MzIgY291bnRbUlpfTVRVM19NQVhfTE9HSUNBTF9DTlRSX0NIQU5ORUxT
XTsNCj4gIAl1OCB0aW1lcl9tb2RlW1JaX01UVTNfTUFYX0xPR0lDQUxfQ05UUl9DSEFOTkVMU107
DQo+ICAJYm9vbCBjb3VudF9pc19lbmFibGVkW1JaX01UVTNfTUFYX0xPR0lDQUxfQ05UUl9DSEFO
TkVMU107DQo+ICsJYm9vbCBkaXJlY3Rpb25bUlpfTVRVM19NQVhfTE9HSUNBTF9DTlRSX0NIQU5O
RUxTXTsNCj4gIAlib29sIG10Y2xrY19tdGNsa2Q7DQo+ICB9Ow0KPiANCj4gQEAgLTE4Niw2ICsx
ODgsMTMgQEAgc3RhdGljIHZvaWQgcnpfbXR1M19zZXRfcGhja3NlbChzdHJ1Y3QgcnpfbXR1M19j
aGFubmVsICpjb25zdCBjaCwgYm9vbCBlbmFibGUpDQo+ICAJCQkJICAgICAgZW5hYmxlKTsNCj4g
IH0NCj4gDQo+ICtzdGF0aWMgYm9vbCByel9tdHUzX2dldF9kaXJlY3Rpb24oc3RydWN0IHJ6X210
dTNfY2hhbm5lbCAqY29uc3QgY2gpIHsNCj4gKwl1OCB0c3IgPSByel9tdHUzXzhiaXRfY2hfcmVh
ZChjaCwgUlpfTVRVM19UU1IpOw0KPiArDQo+ICsJcmV0dXJuICEhKHRzciAmIFJaX01UVTNfVFNS
X1RDRkQpOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IHJ6X210dTNfY291bnRfcmVhZChzdHJ1
Y3QgY291bnRlcl9kZXZpY2UgKmNvdW50ZXIsDQo+ICAJCQkgICAgICBzdHJ1Y3QgY291bnRlcl9j
b3VudCAqY291bnQsIHU2NCAqdmFsKSAgeyBAQCAtMzE4LDE4ICszMjcsMTcgQEAgc3RhdGljIGlu
dA0KPiByel9tdHUzX2NvdW50X2RpcmVjdGlvbl9yZWFkKHN0cnVjdCBjb3VudGVyX2RldmljZSAq
Y291bnRlciwNCj4gIAlzdHJ1Y3QgcnpfbXR1M19jaGFubmVsICpjb25zdCBjaCA9IHJ6X210dTNf
Z2V0X2NoKGNvdW50ZXIsIGNvdW50LT5pZCk7DQo+ICAJc3RydWN0IHJ6X210dTNfY250ICpjb25z
dCBwcml2ID0gY291bnRlcl9wcml2KGNvdW50ZXIpOw0KPiAgCWludCByZXQ7DQo+IC0JdTggdHNy
Ow0KPiANCj4gIAlyZXQgPSByel9tdHUzX2xvY2tfaWZfY291bnRfaXNfZW5hYmxlZChjaCwgcHJp
diwgY291bnQtPmlkKTsNCj4gIAlpZiAocmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiANCj4gLQlw
bV9ydW50aW1lX2dldF9zeW5jKGNvdW50ZXItPnBhcmVudCk7DQo+IC0JdHNyID0gcnpfbXR1M184
Yml0X2NoX3JlYWQoY2gsIFJaX01UVTNfVFNSKTsNCj4gLQlwbV9ydW50aW1lX3B1dChjb3VudGVy
LT5wYXJlbnQpOw0KPiArCWlmIChwcml2LT5jb3VudF9pc19lbmFibGVkW2NvdW50LT5pZF0pDQo+
ICsJCXByaXYtPmRpcmVjdGlvbltjb3VudC0+aWRdID0gcnpfbXR1M19nZXRfZGlyZWN0aW9uKGNo
KTsNCg0KTm93IHByaXYtPmRpcmVjdGlvbltjb3VudC0+aWRdIGlzIHplcm8taW5pdGlhbGlzZWQs
IHByZXZpb3VzbHkgaXQgd2FzIFNvQyByZWdpc3RlcidzIHJlc2V0DQp2YWx1ZS4gU2hvdWxkIHdl
IGluaXRpYWxpemUgdGhlc2UgdmFsdWVzIGluIHByb2JlIHNvIHRoYXQgdGhlcmUgaXMgbm8gY2hh
bmdlIGluIGJlaGF2aW91cj8NCg0KQ2hlZXJzLA0KQmlqdQ0KDQo+IA0KPiAtCSpkaXJlY3Rpb24g
PSAodHNyICYgUlpfTVRVM19UU1JfVENGRCkgPw0KPiArCSpkaXJlY3Rpb24gPSBwcml2LT5kaXJl
Y3Rpb25bY291bnQtPmlkXSA/DQo+ICAJCUNPVU5URVJfQ09VTlRfRElSRUNUSU9OX0ZPUldBUkQg
OiBDT1VOVEVSX0NPVU5UX0RJUkVDVElPTl9CQUNLV0FSRDsNCj4gKw0KPiAgCW11dGV4X3VubG9j
aygmcHJpdi0+bG9jayk7DQo+IA0KPiAgCXJldHVybiAwOw0KPiBAQCAtNDcyLDYgKzQ4MCw3IEBA
IHN0YXRpYyB2b2lkIHJ6X210dTNfdGVybWluYXRlX2NvdW50ZXIoc3RydWN0IGNvdW50ZXJfZGV2
aWNlICpjb3VudGVyLCBpbnQgaWQpDQo+ICAJc3RydWN0IHJ6X210dTNfY250ICpjb25zdCBwcml2
ID0gY291bnRlcl9wcml2KGNvdW50ZXIpOw0KPiANCj4gIAlwcml2LT5jb3VudFtpZF0gPSByel9t
dHUzX2dldF9jb3VudChjaCwgaWQpOw0KPiArCXByaXYtPmRpcmVjdGlvbltpZF0gPSByel9tdHUz
X2dldF9kaXJlY3Rpb24oY2gpOw0KPiANCj4gIAlpZiAoaWQgPT0gUlpfTVRVM18zMl9CSVRfQ0gp
IHsNCj4gIAkJcnpfbXR1M19kaXNhYmxlKGNoMik7DQo+IC0tDQo+IDIuNTYuMA0K
