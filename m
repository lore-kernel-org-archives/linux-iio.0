Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793118335;
	b=cqypP/l89p0TyU0B+4iCrp3ldYf3TLRrq2qzrQEz/Q6JK0ZqSq5Z39sjelVUhWLVG9tX
	 0oW3IExDTvbSMHtjZpRcyhdFsn3JaaRYjUSQYXd/S2b3ZX7ZY/dKi6mhu1nBp8wIqR/ie
	 S4NtRK3+cbB9ujerv3DaQAZBe6lOzJhI9oNGDVTqU1rFGO5zZlDNSKyWzSF56PZVM0kKu
	 La4KQbF4/USYcjvfPXX++Is1a0AtJe6Kpo7g0CuU7UY7WqGN2WGXuf7hTclGKrZ8teGDS
	 0p05rfDQ2M0RUjc+tR+oq+IDKZ5K5Se1aAgMjjT6voN92pKXJjCnslKip+3VnuQ6j5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118335;
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
	bh=FSc5t7RRFqx16xpxlMLUCn5IJ3oEvudsjcKUVGSO1f4=;
	b=N61kpKvtTOsHmiur4L95lj4MMo+Vp+RK8ddf/QlyUxaYsnr8zsu+yruTsheFDSxKF7pU
	 AjHOZSRkzapEwuXtTrFA/OSTvwpTMHwahwff6G67YrMBwZlic4LVHgcWe8zyUV6HubaW+
	 3GscbXFiXxev8Arz5nwnScvBo3xiy8DiPmULlCFS2VheipGbhe/dl2YudXJyPJfeh0lca
	 N39GNImp9JAOfatw0a5izPtuULn+mDNkA09iBDZbhjcSaLfOcmyK0FcYai422jBiwFhs+
	 k1A3KJPVYrcZdpozKVmFrEaiDFSSw+wQokW8+aJNch2XfQoSqAl3OPs0mG00B+9ilAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b="Oj/UO9QF";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.18
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011018.outbound.protection.outlook.com [52.101.125.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C8E606A31A;
	Tue, 27 Oct 2026 16:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32C8E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Oj/UO9QF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r89asC9GSLwcd/8Mrp1i5m9zeepEMvuancCpj6NTm86MtBx1get6nQEN8BLhg4qJDOZZTjnVcjGBbeVebjpfv+OkPQedcb/vysYsxM19RoWX1ZOu15+Gj6h7dHt+vcu5ftowUM7gGZJCV4wpz6YT0x8G+v5M3mi1dJG/4i3Cfgj7DcLxJGGHldAWB8nnANuP92fnpGqGUB8n6yKkeLtoXaWHUUZ+SjBLzsj9IGa883n0fV+IIIjD1Y7BRi6BJIiwlsXSPvINnp84vMpiOWGyUKa8OoJfkuE8LNd0yDKFHKNkRA5sj2hbZg0WpoPetTDxOz6g5KC+lo3gQhkLMuYUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSc5t7RRFqx16xpxlMLUCn5IJ3oEvudsjcKUVGSO1f4=;
 b=d6uPDg5jap9esi7lckpMPPL+iLYT3sXeC293H5zWMJENL7Y/ghFmUcOZuvSkYJydX+s3qrSMTV1MOvOGBAkoxXf9oVSewf34uKI1mJqrYciP07GuuLz48pvSQ5fEboO8TWzn4mInySuGwz3FXtoZqZlNtUZUhfwmBVskFPRkVTvAxLf5y6fHvcp6gm7txg29ytUQE28I/zIxJkY6L486YYCtKrE3ZcV6Znv005JJ2GoFntJPZPPGJ3ysYsYo5i0Z3QjWrIz/0zrxRLs3g3l6ooKGNgc1GJpNv1aRpyoezsOjLI+vVwDYc42ISBYwqlIrydJEV+LP/gbkQGE52ZiJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSc5t7RRFqx16xpxlMLUCn5IJ3oEvudsjcKUVGSO1f4=;
 b=Oj/UO9QF8Gheta3m4h25A8lSgq67op15xLEK9SPHJnYIA0dUXToq7a5A1IGl6Pqsw4mCVr9rPH+Kl3yRVRc/WHf9PNk8NDHA5/cyr4UljdUvKMBzUzg3q9PcygCRLZ+JH7JlkAPGIW+ZVdDOhN9OlbiFRlDC7oWn9jcxCtDPIUE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11087.jpnprd01.prod.outlook.com (2603:1096:400:3aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:25:31 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 16:25:30 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron
	<jic23@kernel.org>
CC: Josef Bacik <josef@toxicpanda.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, stable <stable@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
	<u.kleine-koenig@baylibre.com>, Siratul Islam <email@sirat.me>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Stephen Boyd <swboyd@chromium.org>
Subject: RE: [PATCH 15/15] iio: sx9310: use the data of the I2C table
Thread-Topic: [PATCH 15/15] iio: sx9310: use the data of the I2C table
Thread-Index: AQHdZi8HJjzLu6UfcU+fngwNqWk987cRktOg
Date: Tue, 27 Oct 2026 16:25:30 +0000
Message-ID:
 <TY3PR01MB113467B6593E80D2C10C0152286602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
 <20261027-llm-char-misc-iio-v1-15-0d818334f6c7@linuxfoundation.org>
In-Reply-To:
 <20261027-llm-char-misc-iio-v1-15-0d818334f6c7@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11087:EE_
x-ms-office365-filtering-correlation-id: 5933b887-88a5-4e3d-27eb-08df3446eb39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|261026140227099003|38070700021|5023799004|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261021123027099003|261022075727099003|261009223027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 t7AC+xW+oFjukKO0biI6hTpDS6FSu7Ox6bXIa6MDm2YO0Z8eYZa5NWbLyN226QihnT+5H8FulHWElO+zAcBHP7RLVOzezFaO3m1My+hPHCj9ebsJEiwG2GTrfVtCHMMYltu5R5+2WOjt8SEvzYg1bA5YZHt8Zq/LAkUYTZLNDkPd54vGZcbxc8ugsxN2KvS7RF8WMXu2AHlnJ3SCvZCKtcq9xSDwyImz4z3znAZP9Zjs5O69KB8xZVvJIVtc9bfvrSjKE3lqNnL9SnKo4kLQENXrJBYYqH5vFGpJaWh5eh1Xl+4/g3ctDDuCkZCsPX0rv7gfweUbltqYyIbJUsVD3ymAmJYaInW/jZj/aFNBWaVjhBMw421GMOyG74ApE/+QAvvQuQNdkFqv44Z0Zfre44D6C7mQ5Bh9tmQygvkZkIDtOdtJ22rOsxdL+wDecc8KPSNQjNhUXaEqpoTDjKiUYjiwVo2asAlcmqy9ZSPMzyA3bc1pMmCovQP8ZWNKJpiCRK65tH1fBMI0OYhbHVRA0s7j5tv46jbrrLLwML762dmW5Z1lL+wzrTgBF344/ao3ZVU/9iN1cHBvhgLay8796MK9K3K8hV8qTJXynf9sdpVDit9tDmv3kX1WXEQe77AR84tp7pmLOCKj+cf7UAQOP1I03PLhJE9JOBBhBlXsslOCmd4jPs95Esm7BAOYzZw0O4ZiuV4cjOruVKJ4hRtwJ9GA+Of3f+AVp/PTwEp3cTw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(261026140227099003)(38070700021)(5023799004)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a05aYmFuYVNUZmE2bkFMdFVrdythK21qMXZMcUVrR3R6RWh5YlVmbTdEYnI4?=
 =?utf-8?B?YUNsMmVlZldLRFZZZjBxWnZzR1dlanR0VjNOZnVGY1MwaXBJN25idW1BUnZU?=
 =?utf-8?B?NjZLZzE4bVV4VER4b29EYVNhcHY1UmpnY2tYTVNveGJBRjN5QlV6QWNZWDBs?=
 =?utf-8?B?WlY2ejZ0bTJBRGFNdlF3MGkzOFZOaUxxeVpOZDhIaUdaSW9CdGMrOVRiRFFk?=
 =?utf-8?B?b1pyK2xCK3RUd0pRZmRXd1BkSnhteEMyOHVEZHI3OVFZR2lBN0IxWWF3a2x0?=
 =?utf-8?B?WVY1ZExRZ3lRc2gwV0pLUHBzZk5UR2lieVVWZ1M3NnFLNzhoc1lnd21FZnc5?=
 =?utf-8?B?SmorVG1NR3MrNWc2YUFCMjQyOWFybHNpV1JFVExIRnRjbVpTc09CWC9WamhX?=
 =?utf-8?B?RG9pVEI2bVNwWGxkY3JTTnN1SUdaaXRvbEV4TlBxYmNIcGFYNll4dGExYXVk?=
 =?utf-8?B?Q0IrKzFOUGZDNXdKT1RSaWhUek5oL0Qzbkc3aHdDdVYwZWJvSVFPSTFZeEl0?=
 =?utf-8?B?NHV3SmZ0Sy9tRzNTTitOdEsvWEg3NEk0YnB2a0Y3ZFZjQmlxMnpwZGVZVDV4?=
 =?utf-8?B?d3hYSXhPNXpaM25oYm5sR3hkSHFkNVo3YVJZMGV0cExRYmJNMkE4bWNiSnBC?=
 =?utf-8?B?MkZiSEdZYXdEbEdndnhDWWgvSGdXQm9Hay9TSmVOYnV0eDVJYWtzREVxNFJs?=
 =?utf-8?B?TzAvbW9qUUUzMkNDSE9aYnE5cXFzU1dhb2MrUkRXTHhKY3FVL05JWUNBVlg5?=
 =?utf-8?B?Wk1uNEhCenBkajI2d3ZISGtrQjJ2a1Z3KzBUY2tIQUtUNXlxTnphMjQ1WTZB?=
 =?utf-8?B?U1FVVWE1Q3BMa1Z5c3BBTmRIMFpqeDc1c2Y2ZHprODZOeWRybGEvb016MkZk?=
 =?utf-8?B?dlViZ3dhUHFqOVhQY0hBWDBUUWRpeUhnMWEzNTkzQ3Nna0RGNFpuVTlYYUwv?=
 =?utf-8?B?OXpFNEwrZzU2MXA2QW90a09xRHZ0T2orS1R6K1Y2NXpMTXFKQW8xQzVSZkdW?=
 =?utf-8?B?b0dOUVRtVFZob0lvaXAvcFFMaTVXendyZEJGMHpEUkNMT3g5M1RHSnphNTZY?=
 =?utf-8?B?WEorYm8zZjU4SlBMTHYzd3M3azVSVitENm9WR3lTSWN2MEtQaXNHclprUFQ5?=
 =?utf-8?B?VmNNUDFpNjh2djRySjJLVjVIRUkwcUlxQi9xcTBLQ0hBWldEV3lqZlpKbDZ5?=
 =?utf-8?B?ZktRenNOY09JTURSRzQvb3FmTHpRaCtiWGFnSWFwdk9NRmFBamRBRlpBMkVr?=
 =?utf-8?B?elZTSmkyZnM4NVViOVdVbTNpQmxvVkJRdTk2NStkTmJ1M0dYT1RrZGN1anNm?=
 =?utf-8?B?OU52dTNLN3lHSWM5OStFL3kxS0FMUEM2WGd3RlRTUVFjRU9WMmJiei9ZMlJT?=
 =?utf-8?B?UEJDOVBnSmMrZHIrd1piK09wRTdyUTdCZVRhcXF0dG1OaUdob29TUlhUOHhJ?=
 =?utf-8?B?ekcxazkwc0IzempJb09zbkF5ZU5TWGlsK05HYTBiNTZrakJEYjRtblF6dUN5?=
 =?utf-8?B?b1BnZk9MeVpzTW5vV0tvK0hCdEpoQWpOSFJhTVZKZXZaMjVIVlJvYUJucUwx?=
 =?utf-8?B?bXZzREk3aXZsdDB3aUczRXhaMW9ITlhJU2xGWmx0ZHk4emRpb1RTY01UdXFK?=
 =?utf-8?B?SWtaQWszWWM4ZlNxbkEyTXRvOUhNUW8yeGVKMTcwdUZQcnViY2orQXhmcmxL?=
 =?utf-8?B?MTRQbm1LaHFQUVlMak00b2xUaFB0amtWQnp0ejM5ZmtoZnJRR2lsUm5COEhI?=
 =?utf-8?B?L3dheWY5KzVENnNZNldVS0tMZmIwT1lFZDhWNnVTVERwMWhPREcyYnRIbEVv?=
 =?utf-8?B?bUJUZGUzdTFZU2QwUS9kRzQ0RnV1WU8wSEduUWkvaUY4aHd6S2tmZ0lIVEJB?=
 =?utf-8?B?T2NXWk1qNTdJVUIyUkt4ZnYxcnVabHE0ZzcybTd1c0VIOURGMGxqSW9GNlRL?=
 =?utf-8?B?enFzUk43YUo4dDNrMENueWhqWm9kdHF3RjVMRk8xTVdoUnlwUlplUkF3dXUz?=
 =?utf-8?B?bjlOclRRdkhKL2psQ1d1VzFLTzhvciswYWxBV0F4Y3A0MDAycWZRd2dRcUV5?=
 =?utf-8?B?QVZad2oxUElST0RWSjJFVTdoVFVGTDZjSkdYcTA5Q29IZ1JDUzNzOHJwL2NX?=
 =?utf-8?B?VlZheWZZMXZ4SVFMQS8yUEV1eGNvSFY4TnBFa0N4bkZwSXM3TGYrb25CR2Q4?=
 =?utf-8?B?Z0VWYlpGaXVlaFI5SUV3cWtZSmo3NERVb0dkVjZhdlk3eFoxZEJuWm9hVS9z?=
 =?utf-8?B?ckdTdmV0VWpQZWFGNS83cUFJOGdHUVFlbXRJSzRPbEhVZ25PRXFJNjFuN1dm?=
 =?utf-8?B?d0g3VGdBVlJad2puZG16eklOMW9xYWdzMjJRMUtyM0dXSG1lb25VZz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5933b887-88a5-4e3d-27eb-08df3446eb39
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 16:25:30.7798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6xu7tTx8QHzdTqPtC9DvV8fBZJLcm+TkkFrXBMb+3difxow/CG29BG9qpf+v6arrDs+pl7U2ZgbVdY57cb4WYph5eb8SwKJxyPShAqifxwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11087

SGkgR3JlZy9Kb3NlZiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBH
cmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBTZW50OiAy
NyBPY3RvYmVyIDIwMjYgMTY6MTkNCj4gU3ViamVjdDogW1BBVENIIDE1LzE1XSBpaW86IHN4OTMx
MDogdXNlIHRoZSBkYXRhIG9mIHRoZSBJMkMgdGFibGUNCj4gDQo+IEZyb206IEpvc2VmIEJhY2lr
IDxqb3NlZkB0b3hpY3BhbmRhLmNvbT4NCj4gDQo+IHN4OTMxMF9jaGVja193aG9hbWkoKSB0YWtl
cyB0aGUgY2hpcCBpbmZvcm1hdGlvbiBmcm9tIGRldmljZV9nZXRfbWF0Y2hfZGF0YSgpLCB3aGlj
aCBvbmx5IGxvb2tzIGF0IHRoZSBPRg0KPiBhbmQgQUNQSSB0YWJsZXMsIGFuZCBkZXJlZmVyZW5j
ZXMgaXQuIEZvciBhIGNsaWVudCB3aGljaCB3YXMgYm91bmQgdGhyb3VnaCB0aGUgaTJjX2Rldmlj
ZV9pZCB0YWJsZSwgZm9yDQo+IGluc3RhbmNlIG9uZSBjcmVhdGVkIHdpdGgNCg0KTm90IHN1cmUg
d2UgY2FuIGV4dGVuZCBkZXZpY2VfZ2V0X21hdGNoX2RhdGEoKSB0byBjb3ZlciB0aGlzIHVzZSBj
YXNlPw0KDQpDaGVlcnMsDQpCaWp1DQo+IA0KPiAgIGVjaG8gc3g5MzEwIDB4MjggPiAvc3lzL2J1
cy9pMmMvZGV2aWNlcy9pMmMtMS9uZXdfZGV2aWNlDQo+IA0KPiBpdCByZXR1cm5zIE5VTEwsIGFu
ZCB0aGUga2VybmVsIG9vcHNlcyBhcyBzb29uIGFzIHNvbWV0aGluZyBhdCB0aGF0IGFkZHJlc3Mg
YW5zd2VycyB0aGUgcmVhZCBvZiB0aGUNCj4gV0hPQU1JIHJlZ2lzdGVyLg0KPiANCj4gVGhlIEky
QyB0YWJsZSBoYXMgdGhlIHNhbWUgcG9pbnRlcnMuIFVzZSBpMmNfZ2V0X21hdGNoX2RhdGEoKSwg
d2hpY2ggZmFsbHMgYmFjayB0byBpdC4NCj4gDQo+IEZpeGVzOiAyMWZkM2IxMzczZjYgKCJpaW86
IHByb3hpbWl0eTogc3g5MzEwOiBDb252ZXJ0IGVudW0tPnBvaW50ZXIgZm9yIG1hdGNoIGRhdGEg
dGFibGUiKQ0KPiBDYzogc3RhYmxlIDxzdGFibGVAa2VybmVsLm9yZz4NCj4gQ2M6IEpvbmF0aGFu
IENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+IENjOiBEYXZpZCBMZWNobmVyIDxkbGVjaG5l
ckBiYXlsaWJyZS5jb20+DQo+IENjOiAiTnVubyBTw6EiIDxudW5vLnNhQGFuYWxvZy5jb20+DQo+
IENjOiBBbmR5IFNoZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz4NCj4gQ2M6ICJVd2UgS2xlaW5l
LUvDtm5pZyAoVGhlIENhcGFibGUgSHViKSIgPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20+
DQo+IENjOiBTaXJhdHVsIElzbGFtIDxlbWFpbEBzaXJhdC5tZT4NCj4gQ2M6IE1hdHRpIFZhaXR0
aW5lbiA8bWF6emllc2FjY291bnRAZ21haWwuY29tPg0KPiBDYzogQmlqdSBEYXMgPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiBDYzogU3RlcGhlbiBCb3lkIDxzd2JveWRAY2hyb21pdW0u
b3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb3NlZiBCYWNpayA8am9zZWZAdG94aWNwYW5kYS5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vcHJveGltaXR5L3N4OTMxMC5jIHwgMiAr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vcHJveGltaXR5L3N4OTMxMC5jIGIvZHJpdmVycy9p
aW8vcHJveGltaXR5L3N4OTMxMC5jIGluZGV4DQo+IDc5YmE0NmQ4YTBhYS4uMjU4NWI5YzZmYjY5
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9wcm94aW1pdHkvc3g5MzEwLmMNCj4gKysrIGIv
ZHJpdmVycy9paW8vcHJveGltaXR5L3N4OTMxMC5jDQo+IEBAIC04OTEsNyArODkxLDcgQEAgc3Rh
dGljIGludCBzeDkzMTBfY2hlY2tfd2hvYW1pKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gIAlpZiAo
cmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiANCj4gLQlkZGF0YSA9IGRldmljZV9nZXRfbWF0Y2hf
ZGF0YShkZXYpOw0KPiArCWRkYXRhID0gaTJjX2dldF9tYXRjaF9kYXRhKGRhdGEtPmNsaWVudCk7
DQo+ICAJaWYgKGRkYXRhLT53aG9hbWkgIT0gd2hvYW1pKQ0KPiAgCQlyZXR1cm4gLUVOT0RFVjsN
Cj4gDQo+IA0KPiAtLQ0KPiAyLjU2LjANCg0K
