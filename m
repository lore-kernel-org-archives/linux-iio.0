Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510159;
	b=07ZxzLWEuLvX0Yd5UmO42Xq2ZlWnsxw/bJnmb3sTMcZaj7+Lx7smhtsXDcmVtQ4m2m31
	 aMdiN0YvDm+yBs5xUJcBCxmm1VNcVpqRkTj6mfAgLyfjGH6eabWkriZ8pG35Ru2qLDPYf
	 7S66rqLru6W4foYcbgprd/roon89yZGvHruaxQ8joPdR4wIhs20b6eUH7pngj39yaCOq0
	 r1NVLY5aazfpKasJe7q6Vb/bcAhcrzByFKqi99n36OySQalhG6c35SBybxPfCpfK6FPc6
	 W2Ox2J/AIUwk4mlzZia+UqdZi0NtHFK0v3x8jbbng9RJj8QkBR4ai5WktsPFW1imoxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510159;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=fIi3qxZHswYedJbOgbhuH8gfQJxCvZ7c5y/iuc+D25Q=;
	b=5srsZ69q94+NjniScYXABHEdmbDo+xti9aNYGtPxm4zKRHI7jv9sDVz4NZgwOV0AsxUu
	 LjUdMmIPNn1BbR6xE7wUz6HJQbIU//EhQkcHSiGwDFzhT0gi2vu10LR4sfIJayFw/zHji
	 bdfQBK2i4eVoZXR2csBHx2LOJp5y6dWI2WZhP79vxcaZTInMEez2I/1DbSBPXhWg9GMb/
	 MTo3IJUOzqmS0A7Mnyy9Znw2yhwNduRLiFKWMhjVAMLZSXfq67G0uJPMyEQSKBn6vLAFx
	 JxS1ziNt4MfMnaXYU7I1ogol0eazInSv4P2ec+AFOSDpCDxlUCEj7SwTi1nQ+ecPM8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=skf.com;
	spf=pass smtp.mailfrom=skf.com;
	dkim=pass header.d=SKF.com header.i=@SKF.com header.a=rsa-sha256 header.s=selector1 header.b=rP401pxo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.22
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CE2606A31E;
	Tue, 24 Nov 2026 08:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80CE2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skf.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=SKF.com header.i=@SKF.com header.a=rsa-sha256 header.s=selector1 header.b=rP401pxo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVHxmUa3PAVrIuGyNhoDjyBCfrh/MyKLX8cgyIGAx98VnLorwH2JNQPOJEd1BEtbnqmXhPD3b7fYGYttqHn3QFRkLoRK+LybdtC6GpE1HKAsSnztxvYUNRJRkalVn0/2MHMvUJZVJpFxhDayMhtns1bKeIgGBFcPGOs8i1j7BFLKMkKkRdlEEk5/kasUG5fPJ4wsl/m89OnRHg8VALR9kgRJjRxkWYcGramVTHZysd2Egq/eXwHlkvQguN/EQjSJsvUUcHgVEd+CUosgYc8xfeq+zuqUkS52NPA2g+O86RmCQqrrUyA0+BuWQD+Yt4ufM7p+hWWQD0elSPfSEN+ZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIi3qxZHswYedJbOgbhuH8gfQJxCvZ7c5y/iuc+D25Q=;
 b=UaK6Sgo9JcSJIT0Z1TU0T/6ozwSRwH9RUzbnBmrIiz8Dvhlfmf8+Rz9jZcfz66UKffXV88mVtV6EeInTCebrId1wPYg4J5NILjKSVaquGrJM9VpHHdd0AMdPAFya24N8k/ga9B7ndx3EQliBLu4HGqno+lQ60tDytZn/8Jm9gNVuPgzie9J9cWXxDZVvaqk2MKfy41mMISdSf5HvnS7jUO3AmFCaoFnzxQ+61nhrDAuO5XG5OPwFDxg756NIu/3fXLWxsZ8fDyzvJ9jDTEydPIjedbrnBP5Bx67mB4A6/+Eq88FKaxTxv2Z4RH2Ybx4wrA9HhmCbLh/Wz2plKor85g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=skf.com; dmarc=pass action=none header.from=skf.com; dkim=pass
 header.d=skf.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SKF.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIi3qxZHswYedJbOgbhuH8gfQJxCvZ7c5y/iuc+D25Q=;
 b=rP401pxoFOzQ4EKesowI+8Eh38U1+prr0PkpN04I01UR4Z6/0RhPIJIB83aGOJwtvmcyNyUA8wiy8t/Gq/yrzZ30jfDDZlFPbATXcD2/zyWp/oVVmW0dVuszoyN4JbsqNvOtYBywA8pQl1/wHIhaoBABnSuTISqIM6mugKRCxU0=
Received: from BR0PR09MB441440.eurprd09.prod.outlook.com
 (2603:10a6:2c8:56::18) by PAWPR09MB6786.eurprd09.prod.outlook.com
 (2603:10a6:102:386::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 08:49:14 +0000
Received: from BR0PR09MB441440.eurprd09.prod.outlook.com
 ([fe80::4d6d:2f45:42e8:3a37]) by BR0PR09MB441440.eurprd09.prod.outlook.com
 ([fe80::4d6d:2f45:42e8:3a37%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 08:49:14 +0000
From: Ilyas NHASSE <ilyas.nhasse@skf.com>
To: Conor Dooley <conor@kernel.org>
CC: =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
	"linux@analog.com" <linux@analog.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: iio: adc: adi,ad7124: make interrupts
 optional
Thread-Topic: [PATCH 1/2] dt-bindings: iio: adc: adi,ad7124: make interrupts
 optional
Thread-Index: AQHdeOJu+b1Rs8rbEEePzVV7AR9iu7c3PEkAgAWyw5o=
Date: Tue, 24 Nov 2026 08:49:14 +0000
Message-ID:
 <BR0PR09MB441440387856BA66983FCBD37A89442@BR0PR09MB441440.eurprd09.prod.outlook.com>
References: <20261120-ad7124-no-irq-v1-0-7826c5c3fd25@skf.com>
 <20261120-ad7124-no-irq-v1-1-7826c5c3fd25@skf.com>
 <20261120-deflator-purifier-c746b2f9bba6@spud>
In-Reply-To: <20261120-deflator-purifier-c746b2f9bba6@spud>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4ede1376-eff3-448c-a8a5-f3e79c769ae3_Enabled=True;MSIP_Label_4ede1376-eff3-448c-a8a5-f3e79c769ae3_SiteId=41875f2b-33e8-4670-92a8-f643afbb243a;MSIP_Label_4ede1376-eff3-448c-a8a5-f3e79c769ae3_SetDate=2026-11-24T08:46:20.808Z;MSIP_Label_4ede1376-eff3-448c-a8a5-f3e79c769ae3_Name=Internal;MSIP_Label_4ede1376-eff3-448c-a8a5-f3e79c769ae3_ContentBits=1;MSIP_Label_4ede1376-eff3-448c-a8a5-f3e79c769ae3_Method=Standard;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skf.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BR0PR09MB441440:EE_|PAWPR09MB6786:EE_
x-ms-office365-filtering-correlation-id: 9d6e8b07-810d-4854-d6b6-08df4a07d136
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|19092799006|38070700021|10067099003|5023799004|11063799006|4143699003|56012099006|261022115727099003|261022105027099003|261022075727099003|261021135927099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 wf6B6RyqU7Ltl4vvNF1p9XSa3MUO7oVRdtUD8cyO6GkDft03JLa8XcY+8Oo6tcpeK47Q/WmdwG+vOXj/rDGL27/QN5iqNwVH1GDlnLYkBYx8JPFa63duaT1QiirapNf9xzP0JD1Vv7cVOjOzCKDt2ySo6yLVpt/+Emf58j0lpRcvDgA2kwVOP7fLPRuHJ03SbI7Rf0S8MZztcr+TWDVHD18QbKYNM9yU4XAFqwbE5sKluSoedbgdQxVGMQbA1seOXNe5KgZ3zoJZGoVDH/gnGrhCdcaWaz+Q7/MfQNIafDxfKOTowu1Gn5NNYHZv3pBDeiTX5Fq7aacmxkuP6B4Umc99ZajPaa0JYQqH8XoVWU58tbTdFb/YOf6Od09LhiVVqIv6iWI7z4H23zkrI1F0N9l0DAOGosPZDzQYzvTEosOC1Zzd/9RRa0no1jfhG7MkSqQskPwTf66+gUtMq1bGNvc+FutZPH6GNK8ELy47yCgR/ewAbsdI24YlHxGkV1LKxmTIzPs4qoryRI3LfDY5da8TJAt8oe0Fdx5ExF3c5unZQFpcEP0UIfQzYqHT57zRVh61xWQtSzE1GKjtQy+2tQnH2mzwnYaLmnEHf8uwlsiWkcf2RcUmueHibIlbVKXtBFs1g3nJw+LfVWDacF9J9NUavmIbFHgcK8t1prwzphm8rGqzh4kDxM+SGR89a+ELCACrh6lowcpQczEKQSEq+g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BR0PR09MB441440.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(19092799006)(38070700021)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261022115727099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1RtMGRmZFZHd0d1dTF4UUY0Vmp4a2doSFpKeG1TbmFXVGhCRHhaQzk3UVgw?=
 =?utf-8?B?YndKTmxua25iRnhuNU1wekxSNHZtQlZsbDg1K0ppOVdMZm9FYlJ5cU9JS2ZF?=
 =?utf-8?B?U0ZJbHlGNVpIekJIb3B6d3VLaUpVZFdaaUdQR1RrMTNGbFVkblpKOG9YUExw?=
 =?utf-8?B?VXRFdTRKVnZUTStpZ04xcC9NdDdoOE5YZFJIaFA3Y3REWXRQUTI0SXhCeWFT?=
 =?utf-8?B?TXg0QXFCSHdqK3NtMzlySHFGc3BVS1c5RmwrSWlDY2xhc3NiUjI4VGpmS1BF?=
 =?utf-8?B?NlFHT1FCOERycWhZbElDTzNmdGZLUTI4R1VEdVhHTElCY2gvZEpReFRLcW54?=
 =?utf-8?B?NXVDZXM0RFRieDlPY2dTWkZpVWx2dmZVRDVhRjFrTG84eS82amxjTlhnRy9n?=
 =?utf-8?B?dmxOdG5uZHhSblRZbElaY09oSVMwdldsWjJYTEk1UjNFVGluV2dNcG1XbndM?=
 =?utf-8?B?eFFFeGVtVm9BVnhpTTcvRXJjSnZNTk9CdEpkZ2ZvaktDRW44N3lrKzBXUjJh?=
 =?utf-8?B?NFBuVHBlZFdsQnVDS2Vtc0tWckFaTytQUVNQWkFmb1FPaldpTEc2QmExOHBJ?=
 =?utf-8?B?Y0JCNEpmVkJpdSt4bVBWeWpsWmNUeXp6RXJXMDEwdUJLQjBNRUcvT3RJc0Ev?=
 =?utf-8?B?UDA3Y05Ja21rcWc0bS9MSDg0MzlJQVBtNXYwOVdNSU9lOVRYM3YvNjJQNFdR?=
 =?utf-8?B?aHdRWG5BdmZoZGgrV0tUM05vY3JBUkZoR2JkQ0RCajBQMERjYlRIMjhxSlBN?=
 =?utf-8?B?RHFqbW56SzY2TFVBRFB1T0hBTTUySlB4YW0yY1U0eWZwYW5TSlIvWFVjenhZ?=
 =?utf-8?B?MnNab2xYVnllYnVwV3N5WXF5U0NNZlNpQnlERGo0dmRPeHBQV1U5ZHNyeEtk?=
 =?utf-8?B?eVZ1OC9Vd1Z5Wlh1WC9VWmUxWmFLVWRQTzZaR1E0ajZ5aHdUaFUwSkdYa1lz?=
 =?utf-8?B?QjRNTC9hR1paQURRRk90c2svKzRuZFlycjh4SUpiYjZnTC96UHJMVGhaMFBh?=
 =?utf-8?B?STA5UW9tVjVYMFkzMnliMk83bk10ellVR2xra2JWNGd4LzkzeFR1cHdWTUVW?=
 =?utf-8?B?ZHNReVNvL0F6WUtLYy9IeDk2blI1elgzcWl2a1E3Wm85ZTY2VW52Yk5MWHN4?=
 =?utf-8?B?R1lHM0xibUJYTUc0V1RoRHhxVVhYV3ZFT2xuTEFBQjc1SDBMY0F2RkY0dWNa?=
 =?utf-8?B?ZU40czJXdVZFWWp2R0VhVDhZTjZWTXVqRWxJRFgybm9mZ1FrS0dpU2JJSk1s?=
 =?utf-8?B?NlNrejhBa1pFT21zUzd2WEZPZVdoUXd3ajhvVTVrTEQ5SUhUWmt5bWsvc3hr?=
 =?utf-8?B?K2xlQklYNmRJOVVpWjBHYjJHT0k4Y0NNc3FwU08wSzloelgyS1B1ZXFyN04y?=
 =?utf-8?B?NStuSS9QaDJBVmVXSGRXbWNaMFpnejRhK2NiRDJFTitjekJVOTJhRmtKTTcx?=
 =?utf-8?B?b1B5WXVOODRKM2RkQk5jZzB0YkRrTDg0Z043Q3cvSHdUTFdJM05vUWVhRHFy?=
 =?utf-8?B?d2svZnJ4ZElsVVdKYnRSbXVjeXFhK0doVHFkOGF4d2l1QWFib1JualBsM1dr?=
 =?utf-8?B?Z0crQXl1U3VXZDRYSjd6NU53c1BoVS9vWXp4K3BZdGcrSzJNWmIvT2NRT2dY?=
 =?utf-8?B?UzNyU1g3cWZpNDJCOEVyeTdOM0dQVFhIUk1XblFpUFR0a3VLTXU1SXZSTXVo?=
 =?utf-8?B?SmlDdEhwM2RkbHRMTjNSU1lmd1RDb0RzY25CVXk3bXFxUGVWNHFxZXNQWmt2?=
 =?utf-8?B?Q05zRWMwMk9pRllLbnFKNHJyU1c3cHhVS2VDc3V6ejRxbVA5dy9ZenkxVTls?=
 =?utf-8?B?SW1MOC9GZHdjR0hGcUx1QkJZMUVVYlBNdThZZ0lSMldzTTRUcWZxTzNUV3pz?=
 =?utf-8?B?dlBaWXR3RktSSTlVOEtpSkdPeW9YTUZvMW14RGRUOXJTZVM3ZVdkSnZoVWM5?=
 =?utf-8?B?bkR0NTlWbnFCVUxLc2JiOG5OaDM3Y09xQngrQXdaOVMyVUN2Z3BRdmVXZWRv?=
 =?utf-8?B?aDI3VE15bXMvdUI2NDR1VmJadXVxZnhmUXk1U29oVE5mR2tGZ2RIQ3RRcG1W?=
 =?utf-8?B?KzhtQlA2Z25MQmRpdTVpQzVPSUwramFpbkZTTjY1SVNwREk3dmw2WnBOWUJr?=
 =?utf-8?B?MExJYUxOdEEwMk1VZmZjckpjS2IrSVFxcWpFc0lsTlJ4RXZtV2VEQjJIVUhR?=
 =?utf-8?B?SmRMNFo2QmpSQlRmejRsN3hWQmdnQUU5QW0zREhSQkpDYURZZ1pFN1JCdUgz?=
 =?utf-8?B?R0h0M2FLTTRnb3pSOWhuKzlCSlBTczN5aFZYSWZZNklmeGUzSkV4YWtGcU56?=
 =?utf-8?B?UVh6YVdzUTcxR3FnSFE5cFBNVWMxM1QrZFVlNWdSa0k1NHptUVRadz09?=
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
X-OriginatorOrg: SKF.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BR0PR09MB441440.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6e8b07-810d-4854-d6b6-08df4a07d136
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 08:49:14.4929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41875f2b-33e8-4670-92a8-f643afbb243a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JaNkNg1CWje4fhVT4W1zscINNSWSAt6O+oxQu2UWsNbfkCMVjCC6O91bS5CXZQLBDFeOpx/iCDTbaRVnIphBMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR09MB6786

T24gRnJpLCBOb3YgMjAsIDIwMjYgYXQgMDU6NDY6MTBQTSArMDAwMCwgQ29ub3IgRG9vbGV5IHdy
b3RlOg0KPiBPbiBGcmksIE5vdiAyMCwgMjAyNiBhdCAxMjoyNjo0N1BNICswMTAwLCBJTFlBUyBO
SEFTU0UgdmlhIEI0IFJlbGF5IHdyb3RlOg0KPj4gVGhlIEFENzEyNCBzaWduYWxzIHRoZSBlbmQg
b2YgYSBjb252ZXJzaW9uIG9uIGl0cyBET1VUL1JEWSBwaW4sIHdoaWNoIGlzDQo+PiBhbHNvIHRo
ZSBTUEkgTUlTTyBsaW5lLiBVc2luZyBpdCBhcyBhbiBpbnRlcnJ1cHQgcmVxdWlyZXMgdGhlIGJv
YXJkIHRvDQo+PiByb3V0ZSB0aGF0IHBpbiB0byBhbiBpbnRlcnJ1cHQtY2FwYWJsZSBpbnB1dCBh
cyB3ZWxsLCB3aGljaCBpcyBub3QgYWx3YXlzDQo+PiBwb3NzaWJsZSwgZS5nLiB3aGVuIHRoZSBB
REMgc2l0cyBiZWhpbmQgYSBkaWdpdGFsIGlzb2xhdG9yIHRoYXQgb25seQ0KPj4gY2FycmllcyB0
aGUgU1BJIHNpZ25hbHMuDQo+DQo+IFdoYXQgZG9lcyB0aGlzIGFjdHVhbGx5IG1lYW4/IERvZXMg
dGhlIGlzb2xhdG9yIG9ubHkgcGVybWl0IGRhdGENCj4gdHJhbnNtaXNzaW9uIHdoZW4gQ1MgaXMg
YWN0aXZlPw0KDQpObywgdGhlIGlzb2xhdG9yIHBhc3NlcyB0aGUgU1BJIHNpZ25hbHMgbm9ybWFs
bHkuIE9uIG91ciBib2FyZCBET1VUL1JEWQ0KY3Jvc3NlcyBpdCBhcyBNSVNPIGFuZCB0aGVuIG9u
bHkgZ29lcyB0byB0aGUgU1BJIGNvbnRyb2xsZXIncyBNSVNPDQppbnB1dDsgaXQgaXNuJ3QgYWxz
byByb3V0ZWQgdG8gYSBHUElPIG9yIG90aGVyIGludGVycnVwdC1jYXBhYmxlIGlucHV0Lg0KVGhl
IGlzb2xhdG9yIGRvZXNuJ3QgcmVhbGx5IG1hdHRlciwgc28gYXMgSm9uYXRoYW4gc3VnZ2VzdGVk
LCB2MiB3aWxsDQpvbmx5IHNheSB0aGF0IERPVVQvUkRZIG1heSBub3QgYmUgd2lyZWQgdG8gYW4g
aW50ZXJydXB0Lg0KDQpUaGFua3MsDQpJbHlhcw0KVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBp
biB0aGlzIGVtYWlsIGlzIGludGVuZGVkIHNvbGVseSBmb3IgdGhlIHVzZSBvZiB0aGUgaW5kaXZp
ZHVhbCBvciBlbnRpdHkgdG8gd2hvbSBpdCBpcyBhZGRyZXNzZWQgYW5kIG1heSBjb250YWluIGlu
Zm9ybWF0aW9uIHRoYXQgaXMgY29uZmlkZW50aWFsLiBQbGVhc2UgZGVsZXRlIGFuZCBub3RpZnkg
dGhlIHNlbmRlciBpZiByZWNlaXZlZCBpbiBlcnJvci4gU0tGIGRvZXMgbm90IGFjY2VwdCBsaWFi
aWxpdHkgZm9yIGFueSBkYW1hZ2UgYXJpc2luZyBmcm9tIHRoaXMgZW1haWwuDQoNCkZvciBpbmZv
cm1hdGlvbiBvbiBTS0bigJlzIHByb2Nlc3Npbmcgb2YgeW91ciBwZXJzb25hbCBkYXRhLCBwbGVh
c2UgdmlzaXQgU0tG4oCZcyBQcml2YWN5IFBvbGljeSBhdmFpbGFibGUgdmlhIHd3dy5za2YuY29t
PGh0dHBzOi8vd3d3LnNrZi5jb20vcHJpdmFjeT4uDQo=
